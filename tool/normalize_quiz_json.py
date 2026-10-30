"""Migrate extracted exams to quiz schema v2, preserving a source backup."""
from __future__ import annotations

import base64
import hashlib
import io
import json
import os
import re
import shutil
import time
import threading
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path

from openai import AzureOpenAI

ROOT = Path(__file__).resolve().parent
OUTPUT = ROOT / "structured"
BACKUP = ROOT / "structured_backup"
CACHE = ROOT / ".quiz-cache"
LABELS = "アイウエ"
IDS = "ABCD"
client = None
PDF_LOCK = threading.Lock()


def clean(text):
    text = re.sub(r":(?:un)?selected:", "", text)
    text = re.sub(r"(?m)^\s*[-ー−–—]+\s*\d+\s*[-ー−–—]+\s*$", "", text)
    text = re.sub(r"(?m)^〔(?:テクノロジ|ストラテジ|マネジメント)〕\s*$", "", text)
    text = re.sub(r"(?m)^中問[A-D]から中問[A-D]までは[^\n]*", "", text)
    return text.strip()


def strip_number(text):
    return re.sub(r"^(?:問\s*\d+|Câu(?:\s+hỏi)?\s*\d+)\s*[:.：-]?\s*", "", clean(text), flags=re.I)


def split_options(text, language):
    pattern = (r"(?<!\S)([アイウエ])(?:[ \t]+|\n|[.:：])" if language == "ja" else
               r"(?m)^\s*([A-DIUEアイウエ])(?:[.)：:]\s*|[ \t]+)")
    matches = list(re.finditer(pattern, text))
    labels = "".join(m.group(1) for m in matches)
    if labels not in (LABELS, "ABCD", "AIUE"):
        return None
    options = [clean(text[m.end():matches[i+1].start() if i < 3 else len(text)])
               for i, m in enumerate(matches)]
    if not all(options):
        return None
    return strip_number(text[:matches[0].start()]), options, labels


def normalize_explanation(text, labels):
    if labels == "AIUE":
        mapping = dict(zip(labels, IDS))
        return re.sub(r"(?<![\w/])([AIUE])(?=[\s.,:;)]|$)",
                      lambda m: mapping[m.group(1)], text)
    return text


def source_info(document):
    pdf = ROOT / "IT-PP" / document["source_pdf"]
    digest = hashlib.sha256(pdf.read_bytes()).hexdigest()
    result = json.loads((ROOT / ".ocr-cache" / f"{digest}.json").read_text(encoding="utf-8"))
    text = result["content"]
    starts = {}
    pattern = r"(?m)^(?:[ぁ-ゖ·・• \t　]{0,15})問[ \t　]*(\d+)(?!\d)(?![ \t　]*(?:から|[~〜～－-]))"
    for m in re.finditer(pattern, text):
        starts[int(m.group(1))] = m.start()
    pages = {}
    for number in range(1, 101):
        start, end = starts[number], starts.get(number+1, len(text))
        if number == 100:
            appendix = re.search(r"(?m)^(?:擬似言語の記述形式|表計算ソフトの機能)", text[start:])
            if appendix:
                end = start + appendix.start()
        pages[number] = [page["pageNumber"] for page in result["pages"]
                         if any(span["offset"] < end and span["offset"]+span["length"] > start
                                for span in page.get("spans", []))]
    return pdf, pages, text, result


def page_images(pdf, pages):
    with PDF_LOCK:
        return render_page_images(pdf, pages)


def render_page_images(pdf, pages):
    import pypdfium2 as pdfium
    images = []
    with pdfium.PdfDocument(str(pdf)) as document:
        for number in pages[:2]:
            page = document[number-1]
            bitmap = page.render(scale=1.5)
            pil = bitmap.to_pil()
            buffer = io.BytesIO()
            pil.save(buffer, format="JPEG", quality=85)
            images.append({"type": "image_url", "image_url": {
                "url": "data:image/jpeg;base64,"+base64.b64encode(buffer.getvalue()).decode(),
                "detail": "high"}})
            pil.close()
            bitmap.close()
            page.close()
    return images


SYSTEM = """Chuẩn hóa dữ liệu đề thi trắc nghiệm Nhật–Việt. Không giải lại câu hỏi.
Tách nguyên nội dung câu hỏi khỏi bốn lựa chọn; giữ dữ kiện, bảng và mã giả.
Các lựa chọn PHẢI có thứ tự A=ア, B=イ, C=ウ, D=エ dù OCR in sai hoặc đảo thứ tự.
Ảnh PDF (nếu có) là nguồn chính xác để khôi phục nhãn lựa chọn và bảng.
Không bịa dữ kiện hoặc hình. Nếu không đọc rõ thì ghi review_notes bằng tiếng Việt.
Bỏ số câu, số trang, các marker :selected:, phụ lục, tiêu đề nhóm khỏi nội dung.
Phần 〔共通本文〕 là bài đọc chung: KHÔNG chép vào question hoặc options.
Giữ nguyên nghĩa bản dịch và giải thích có sẵn; chỉ sửa cách tham chiếu lựa chọn
trong giải thích về A/B/C/D (thay cách gọi A/I/U/E tương ứng).
Trả JSON {"question":{"ja":"...","vi":"..."},
"options":[{"id":"A","label":"ア","ja":"...","vi":"..."}, ... đủ 4],
"explanation_vi":"...", "review_notes":[]}.
"""


def request_json(system, payload, images=None):
    key = hashlib.sha256((system+json.dumps(payload, ensure_ascii=False)+"v2").encode()).hexdigest()
    cache = CACHE / f"{key}.json"
    if cache.exists():
        return json.loads(cache.read_text(encoding="utf-8"))
    content = [{"type":"text", "text":json.dumps(payload, ensure_ascii=False)}]
    content.extend(images or [])
    for attempt in range(4):
        try:
            response = client.chat.completions.create(
                model=os.getenv("OPENAI_DEPLOYMENT", "gpt-5.4"),
                messages=[{"role":"system", "content":system}, {"role":"user", "content":content}],
                response_format={"type":"json_object"})
            result = json.loads(response.choices[0].message.content)
            if system == SYSTEM:
                validate_parts(result)
            elif not isinstance(result.get("vi"), str) or not result["vi"].strip():
                raise ValueError("Missing passage translation")
            cache.write_text(json.dumps(result, ensure_ascii=False), encoding="utf-8")
            return result
        except Exception:
            if attempt == 3:
                raise
            time.sleep(2**attempt)


def validate_parts(parts):
    assert all(isinstance(parts["question"][k], str) and parts["question"][k].strip() for k in ("ja", "vi"))
    assert len(parts["options"]) == 4
    for i, option in enumerate(parts["options"]):
        assert option["id"] == IDS[i] and option["label"] == LABELS[i]
        assert all(isinstance(option[k], str) and option[k].strip() for k in ("ja", "vi"))
    assert isinstance(parts["explanation_vi"], str) and parts["explanation_vi"].strip()


def convert_question(q, exam, pdf, pages, passage_id):
    ja = clean(q["question_ja"].split("〔共通本文〕")[0])
    vi = clean(q["question_vi"])
    jp, vn = split_options(ja, "ja"), split_options(vi, "vi")
    direct = jp is not None and vn is not None and passage_id is None
    if direct:
        parts = dict(question=dict(ja=jp[0], vi=vn[0]), options=[
            dict(id=IDS[i], label=LABELS[i], ja=jp[1][i], vi=vn[1][i]) for i in range(4)],
            explanation_vi=normalize_explanation(q["explanation_vi"], vn[2]))
        validate_parts(parts)
    else:
        images = page_images(pdf, pages) if jp is None else []
        parts = request_json(SYSTEM, q, images)
    needs_asset = jp is None or bool(re.search(r"図|表|グラフ|プログラム|ワークシート", ja))
    result = dict(
        id=f"{exam}-{q['question_no']:03d}", exam=exam, question_no=q["question_no"],
        knowledge_group=q["knowledge_group"], question=parts["question"], options=parts["options"],
        correct_option_id=IDS[LABELS.index(q["answer"])], explanation_vi=parts["explanation_vi"],
        assets=([dict(type="pdf_page", path=f"../IT-PP/{pdf.name}", pages=pages)] if needs_asset else []),
        passage_id=passage_id, review_status="pending",
        source=dict(pdf=pdf.name, pages=pages, answer_source=q["answer_source"]),
    )
    if parts.get("review_notes"):
        result["review_notes"] = parts["review_notes"]
    return result, direct


def main():
    global client
    CACHE.mkdir(exist_ok=True)
    BACKUP.mkdir(exist_ok=True)
    files = sorted(OUTPUT.glob("*_qs.json"))
    assert len(files) == 17
    for file in files:
        if not (BACKUP / file.name).exists():
            shutil.copy2(file, BACKUP / file.name)
    client = AzureOpenAI(azure_endpoint=os.environ["OPENAI_ENDPOINT"], api_key=os.environ["OPENAI_KEY"],
                         api_version=os.getenv("OPENAI_API_VERSION", "2024-12-01-preview"),
                         timeout=180, max_retries=2)
    staging = ROOT / ".quiz-staging"
    staging.mkdir(exist_ok=True)
    documents = {}
    futures = {}
    direct_count = 0
    with ThreadPoolExecutor(max_workers=8) as executor:
        for file in files:
            old = json.loads((BACKUP / file.name).read_text(encoding="utf-8"))
            exam = old["exam"].removesuffix("_ip_qs")
            pdf, pages, raw_text, raw_result = source_info(old)
            doc = {k: v for k, v in old.items() if k not in ("questions", "validation")}
            doc.update(schema_version=2, exam=exam, passages=[], questions=[])
            documents[file.name] = doc
            passage_ids = {}
            for q in old["questions"]:
                passage_id = None
                if "〔共通本文〕" in q["question_ja"]:
                    passage = q["question_ja"].split("〔共通本文〕", 1)[1].strip()
                    if passage not in passage_ids:
                        passage_id = f"{exam}-passage-{len(passage_ids)+1:02d}"
                        passage_ids[passage] = passage_id
                        passage_doc = dict(id=passage_id, text=dict(ja=clean(passage), vi=""),
                                           assets=[], review_status="pending")
                        start = raw_text.find(passage)
                        if start >= 0:
                            passage_pages = [p["pageNumber"] for p in raw_result["pages"]
                                if any(s["offset"] < start+len(passage) and s["offset"]+s["length"] > start
                                       for s in p.get("spans", []))]
                            passage_doc["assets"] = [dict(type="pdf_page", path=f"../IT-PP/{pdf.name}", pages=passage_pages)]
                        doc["passages"].append(passage_doc)
                        future = executor.submit(request_json,
                            'Dịch đầy đủ bài đọc chung đề IT Passport sang tiếng Việt. Giữ dữ kiện và bảng bằng Markdown. Trả JSON {"vi":"..."}.',
                            dict(ja=passage))
                        futures[future] = ("passage", passage_doc)
                    passage_id = passage_ids[passage]
                future = executor.submit(convert_question, q, exam, pdf, pages[q["question_no"]], passage_id)
                futures[future] = ("question", doc)
        done = 0
        for future in as_completed(futures):
            kind, target = futures[future]
            value = future.result()
            if kind == "passage":
                target["text"]["vi"] = value["vi"]
            else:
                question, direct = value
                target["questions"].append(question)
                direct_count += direct
                done += 1
                if done % 50 == 0:
                    print(f"Converted {done}/1700; direct={direct_count}", flush=True)
    ids = set()
    for name, doc in documents.items():
        doc["questions"].sort(key=lambda q: q["question_no"])
        assert [q["question_no"] for q in doc["questions"]] == list(range(1,101))
        old = json.loads((BACKUP / name).read_text(encoding="utf-8"))
        passage_ids = {p["id"] for p in doc["passages"]}
        assert all(p["text"]["ja"] and p["text"]["vi"] for p in doc["passages"])
        for q, previous in zip(doc["questions"], old["questions"]):
            for field in (q["question"], *q["options"]):
                for language in ("ja", "vi"):
                    field[language] = clean(field[language])
            validate_parts(q)
            assert q["id"] not in ids
            ids.add(q["id"])
            assert q["correct_option_id"] == IDS[LABELS.index(previous["answer"])]
            assert q["passage_id"] is None or q["passage_id"] in passage_ids
        doc["validation"] = dict(complete=True, expected_questions=100, returned_questions=100,
                                  answers_matched=100, options_per_question=4, schema_version=2)
        (staging / name).write_text(json.dumps(doc, ensure_ascii=False, indent=2), encoding="utf-8")
    # Publish only after all 17 documents pass validation.
    for name in documents:
        (staging / name).replace(OUTPUT / name)
    report = dict(schema_version=2, complete=True, exams=17, total_questions=len(ids),
                  answers_matched=len(ids), options=4*len(ids), direct_questions=direct_count,
                  model_assisted_questions=len(ids)-direct_count,
                  passages=sum(len(d["passages"]) for d in documents.values()),
                  review_status="pending", backup_directory="../structured_backup",
                  assets_note="Assets reference pages of the source PDF; cropped figures are not generated.")
    (OUTPUT / "validation_report.json").write_text(json.dumps(report, ensure_ascii=False, indent=2), encoding="utf-8")
    print(json.dumps(report, ensure_ascii=False), flush=True)
    client.close()


if __name__ == "__main__":
    main()
