#!/usr/bin/env python3
"""Extract IT Passport exam questions from PDFs into structured JSON.

Reads an exam PDF plus its answer-key PDF, sends the text to an LLM, and writes
one JSON file per exam containing, for every question:

    exam            - which sitting the question came from
    knowledge_group - one of the nine official IT Passport categories
    question_ja     - the original Japanese text, including its options
    question_vi     - a Vietnamese translation
    answer          - the correct option label
    explanation_vi  - why that option is correct, in Vietnamese

Usage
-----
    # Single exam
    python extract_itpp_questions.py --exam 2026_spring.pdf --answers 2026_spring_ans.pdf

    # Several exams at once (files paired by name: X.pdf + X_ans.pdf)
    python extract_itpp_questions.py --dir ./pdfs

    # Inspect what was read from the PDF without calling the LLM
    python extract_itpp_questions.py --exam e.pdf --answers a.pdf --dry-run

Requirements
------------
    pip install pdfplumber openai

    export OPENAI_API_KEY=sk-...
"""
from __future__ import annotations

import argparse
import hashlib
import json
import os
import re
import sys
import time
from dataclasses import dataclass, field
from pathlib import Path

# --- The nine official IT Passport knowledge groups -------------------------
# The LLM must choose one of these exactly; anything else is reported so bad
# output is visible instead of silently stored.
KNOWLEDGE_GROUPS = [
    "企業と法務",
    "経営戦略",
    "システム戦略",
    "開発技術",
    "プロジェクトマネジメント",
    "サービスマネジメント",
    "基礎理論",
    "コンピュータシステム",
    "技術要素",
]

DEFAULT_MODEL = "gpt-5.4"
# Questions per LLM request. Small batches keep each response within the
# output token limit and make a failure cost less work.
DEFAULT_BATCH_SIZE = 5
MAX_RETRIES = 3

SYSTEM_PROMPT = """Bạn là chuyên gia về kỳ thi IT Passport (ITパスポート試験) của Nhật Bản
và dịch thuật Nhật - Việt trong lĩnh vực công nghệ thông tin.

Nhiệm vụ: với mỗi câu hỏi được cung cấp, trả về một đối tượng JSON gồm:

- "question_no": số thứ tự câu hỏi (số nguyên, lấy từ đề)
- "knowledge_group": PHẢI là một trong chín giá trị sau, không được tạo giá trị khác:
  企業と法務, 経営戦略, システム戦略, 開発技術, プロジェクトマネジメント,
  サービスマネジメント, 基礎理論, コンピュータシステム, 技術要素
- "question_ja": nguyên văn tiếng Nhật của câu hỏi, GIỮ NGUYÊN cả phần các
  phương án lựa chọn (ア/イ/ウ/エ). Không được tóm tắt hay sửa chữa.
- "question_vi": bản dịch tiếng Việt đầy đủ, dịch cả các phương án lựa chọn.
  Giữ nguyên thuật ngữ kỹ thuật tiếng Anh khi thuật ngữ đó phổ biến.
- "answer": nhãn đáp án đúng (ví dụ "ア" hoặc "イ"). Dùng đáp án từ bảng đáp án
  được cung cấp. Nếu không có trong bảng đáp án, hãy tự xác định.
- "explanation_vi": giải thích bằng tiếng Việt vì sao đáp án đó đúng, và ngắn
  gọn vì sao các phương án còn lại sai. Viết 2-4 câu.

Chỉ trả về JSON hợp lệ theo dạng: {"questions": [ ... ]}
Không thêm lời dẫn, không bọc trong khối markdown."""


# --- PDF reading ------------------------------------------------------------

def read_pdf_text(path: Path) -> str:
    """Extract text from a PDF, page by page."""
    cache = Path(__file__).parent / ".ocr-cache" / (
        hashlib.sha256(path.read_bytes()).hexdigest() + ".txt")
    if cache.exists():
        return cache.read_text(encoding="utf-8")
    # Answer PDFs already have a usable text layer; avoid unnecessary OCR.
    if path.stem.endswith("_ans"):
        import pdfplumber
        with pdfplumber.open(path) as pdf:
            text = "\n".join(page.extract_text() or "" for page in pdf.pages)
        if text.strip():
            return text
    endpoint = os.getenv("DOC_INTELLIGENCE_ENDPOINT")
    key = os.getenv("DOC_INTELLIGENCE_KEY")
    if endpoint or key:
        if not endpoint or not key:
            sys.exit("Cần cả DOC_INTELLIGENCE_ENDPOINT và DOC_INTELLIGENCE_KEY")
        try:
            from azure.ai.documentintelligence import DocumentIntelligenceClient
            from azure.core.credentials import AzureKeyCredential
        except ImportError:
            sys.exit("Thiếu Azure SDK. Chạy: pip install -r tool/requirements.txt")
        with DocumentIntelligenceClient(endpoint, AzureKeyCredential(key)) as client:
            with path.open("rb") as document:
                poller = client.begin_analyze_document("prebuilt-layout", body=document)
            result = poller.result()
            text = result.content or ""
            if text.strip():
                cache.parent.mkdir(parents=True, exist_ok=True)
                cache.write_text(text, encoding="utf-8")
                cache.with_suffix(".json").write_text(
                    json.dumps(result.as_dict(), ensure_ascii=False), encoding="utf-8")
            return text

    try:
        import pdfplumber
    except ImportError:
        sys.exit("Thiếu thư viện pdfplumber. Chạy: pip install pdfplumber")

    pages: list[str] = []
    with pdfplumber.open(path) as pdf:
        for index, page in enumerate(pdf.pages, start=1):
            text = page.extract_text() or ""
            if text.strip():
                pages.append(text)
            else:
                # A page with no text layer is almost certainly a scan; the
                # caller needs to know rather than silently losing questions.
                print(f"  [cảnh báo] {path.name} trang {index}: không có text "
                      f"(có thể là ảnh scan, cần OCR)", file=sys.stderr)
    return "\n".join(pages)


def split_questions(text: str) -> list[str]:
    """Split exam text into individual questions on the 問N marker."""
    text = re.sub(r"(?m)^問[ \t　]*\d+[ \t　]*(?:から|[~〜～－-]).*$", "", text)
    # Ruby annotations can precede the question marker in OCR reading order.
    text = re.sub(r"(?m)^[ぁ-ゖ \t　]{1,15}(?=問[ \t　]*\d+)", "", text)
    text = re.sub(r"(?m)^[·・•][ \t]*(?=問[ \t　]*\d+)", "", text)
    # Reference appendices are not part of question 100.
    text = re.split(r"(?m)^(?:擬似言語の記述形式|表計算ソフトの機能)[^\n]*", text, maxsplit=1)[0]
    # Keep the marker with the question by splitting on a lookahead.
    marker = r"問[ \t　]*\d+(?!\d)(?!から|まで)"
    contexts = []
    for heading in list(re.finditer(r"(?m)^中問[A-DＡ-Ｄ][ \t　]+", text))[::-1]:
        next_question = re.search(rf"(?m)^{marker}", text[heading.end():])
        if next_question:
            end = heading.end() + next_question.start()
            number = int(re.match(r"問\s*(\d+)", text[end:]).group(1))
            contexts.append((number, text[heading.start():end].strip()))
            text = text[:heading.start()] + text[end:]
    contexts.sort()
    parts = re.split(rf"(?m)(?=^{marker})", text)
    questions = [p.strip() for p in parts if re.match(rf"^{marker}", p.strip())]
    for index, question in enumerate(questions):
        number = int(re.match(r"問\s*(\d+)", question).group(1))
        context = [body for start, body in contexts if start <= number]
        if context:
            questions[index] = question + "\n\n〔共通本文〕\n" + context[-1]
    return questions


def parse_answer_key(text: str) -> dict[int, str]:
    """Read 'question number -> answer label' pairs from the answer-key PDF.

    Answer keys come in several layouts, so several patterns are tried and the
    results merged.
    """
    answers: dict[int, str] = {}
    labels = "アイウエ"

    # "問1 ア" / "問 1  ア"
    for m in re.finditer(rf"問\s*(\d+)\s*[\.:：]?\s*([{labels}])", text):
        answers[int(m.group(1))] = m.group(2)

    # Table rows such as "1 ア 2 イ 3 ウ"
    if len(answers) < 10:
        for m in re.finditer(rf"(?<!\d)(\d{{1,3}})\s*[\.:：]?\s*([{labels}])(?!\w)", text):
            num = int(m.group(1))
            if 1 <= num <= 120:
                answers.setdefault(num, m.group(2))

    return answers


# --- LLM ---------------------------------------------------------------------

@dataclass
class ExtractionStats:
    questions_found: int = 0
    questions_returned: int = 0
    answers_in_key: int = 0
    answers_matched: int = 0
    invalid_groups: list[str] = field(default_factory=list)
    batches_failed: int = 0


def call_llm(client, model: str, batch: list[str], exam_name: str,
             answer_key: dict[int, str]) -> list[dict]:
    """Send one batch of questions to the LLM and return parsed objects."""
    # Give the model the known answers so it labels rather than guesses.
    key_lines = []
    for q in batch:
        m = re.match(r"^問\s*(\d+)", q)
        if m:
            num = int(m.group(1))
            if num in answer_key:
                key_lines.append(f"問{num}: {answer_key[num]}")

    user_parts = [f"Kỳ thi: {exam_name}", ""]
    if key_lines:
        user_parts += ["Bảng đáp án cho các câu dưới đây:", *key_lines, ""]
    user_parts += ["Các câu hỏi:", ""]
    user_parts += [f"--- câu {i + 1} ---\n{q}" for i, q in enumerate(batch)]
    cache_key = hashlib.sha256(
        (model + SYSTEM_PROMPT + "\n".join(user_parts)).encode()).hexdigest()
    cache = Path(__file__).parent / ".llm-cache" / f"{cache_key}.json"
    if cache.exists():
        return json.loads(cache.read_text(encoding="utf-8"))

    for attempt in range(1, MAX_RETRIES + 1):
        try:
            response = client.chat.completions.create(
                model=model,
                messages=[
                    {"role": "system", "content": SYSTEM_PROMPT},
                    {"role": "user", "content": "\n".join(user_parts)},
                ],
                response_format={"type": "json_object"},
            )
            payload = json.loads(response.choices[0].message.content)
            items = payload.get("questions", [])
            expected = [int(re.match(r"^問\s*(\d+)", q).group(1)) for q in batch]
            if sorted(item.get("question_no", -1) for item in items) != sorted(expected):
                raise ValueError("LLM trả về thiếu, trùng hoặc sai số câu hỏi")
            for item in items:
                if item.get("knowledge_group") not in KNOWLEDGE_GROUPS:
                    raise ValueError("Nhóm kiến thức không hợp lệ")
                if not all(isinstance(item.get(k), str) and item[k].strip()
                           for k in ("question_vi", "explanation_vi", "answer")):
                    raise ValueError("LLM thiếu bản dịch, giải thích hoặc đáp án")
                qno = item["question_no"]
                if qno in answer_key and item["answer"] != answer_key[qno]:
                    raise ValueError(f"Đáp án LLM khác bảng đáp án: {qno}")
                item["question_ja"] = batch[expected.index(qno)]
            cache.parent.mkdir(parents=True, exist_ok=True)
            cache.write_text(json.dumps(items, ensure_ascii=False), encoding="utf-8")
            return items
        except Exception as e:
            if attempt == MAX_RETRIES:
                print(f"  [lỗi] bỏ qua lô sau {MAX_RETRIES} lần thử: {e}",
                      file=sys.stderr)
                return []
            wait = 2 ** attempt
            print(f"  [thử lại {attempt}/{MAX_RETRIES}] sau {wait}s: {e}",
                  file=sys.stderr)
            time.sleep(wait)
    return []


# --- Orchestration -----------------------------------------------------------

def process_exam(exam_pdf: Path, answer_pdf: Path | None, exam_name: str,
                 model: str, batch_size: int, dry_run: bool,
                 ) -> tuple[list[dict], ExtractionStats]:
    stats = ExtractionStats()

    print(f"Đọc đề: {exam_pdf.name}")
    exam_text = read_pdf_text(exam_pdf)
    questions = split_questions(exam_text)
    stats.questions_found = len(questions)
    print(f"  tìm thấy {len(questions)} câu hỏi")

    answer_key: dict[int, str] = {}
    if answer_pdf and answer_pdf.exists():
        print(f"Đọc đáp án: {answer_pdf.name}")
        answer_key = parse_answer_key(read_pdf_text(answer_pdf))
        stats.answers_in_key = len(answer_key)
        print(f"  tìm thấy {len(answer_key)} đáp án")
    else:
        print("  (không có file đáp án — LLM sẽ tự xác định đáp án)")

    if not questions:
        print("  [lỗi] không tách được câu hỏi nào. Kiểm tra PDF có text layer "
              "hay không (file scan cần OCR trước).", file=sys.stderr)
        return [], stats

    if dry_run:
        print("\n--- DRY RUN: 2 câu đầu đọc được từ PDF ---")
        for q in questions[:2]:
            print(q[:400])
            print("---")
        print(f"\nĐáp án đọc được: {dict(list(answer_key.items())[:10])}")
        return [], stats

    try:
        from openai import AzureOpenAI, OpenAI
    except ImportError:
        sys.exit("Thiếu thư viện openai. Chạy: pip install openai")

    if os.getenv("OPENAI_ENDPOINT"):
        if not os.getenv("OPENAI_KEY"):
            sys.exit("Chưa đặt biến môi trường OPENAI_KEY")
        client = AzureOpenAI(
            azure_endpoint=os.environ["OPENAI_ENDPOINT"],
            api_key=os.environ["OPENAI_KEY"],
            api_version=os.getenv("OPENAI_API_VERSION", "2024-12-01-preview"),
        )
    else:
        if not os.getenv("OPENAI_API_KEY"):
            sys.exit("Chưa đặt OPENAI_ENDPOINT/OPENAI_KEY hoặc OPENAI_API_KEY")
        client = OpenAI()
    results: list[dict] = []

    total_batches = (len(questions) + batch_size - 1) // batch_size
    for i in range(0, len(questions), batch_size):
        batch = questions[i:i + batch_size]
        n = i // batch_size + 1
        print(f"  gửi lô {n}/{total_batches} ({len(batch)} câu)...")

        items = call_llm(client, model, batch, exam_name, answer_key)
        if not items:
            stats.batches_failed += 1
            continue

        for item in items:
            group = item.get("knowledge_group", "")
            if group not in KNOWLEDGE_GROUPS:
                stats.invalid_groups.append(f"問{item.get('question_no')}: {group!r}")

            qno = item.get("question_no")
            if isinstance(qno, int) and qno in answer_key:
                stats.answers_matched += 1
                # The answer key is authoritative; override the model if it
                # disagreed, so a hallucinated answer cannot slip through.
                if item.get("answer") != answer_key[qno]:
                    item["answer"] = answer_key[qno]
                    item["answer_source"] = "answer_key_corrected"
                else:
                    item["answer_source"] = "answer_key"
            else:
                item["answer_source"] = "llm"

            results.append({
                "exam": exam_name,
                "knowledge_group": group,
                "question_no": qno,
                "question_ja": item.get("question_ja", ""),
                "question_vi": item.get("question_vi", ""),
                "answer": item.get("answer", ""),
                "explanation_vi": item.get("explanation_vi", ""),
                "answer_source": item["answer_source"],
            })

    stats.questions_returned = len(results)
    return results, stats


def find_pdf_pairs(directory: Path) -> list[tuple[Path, Path | None, str]]:
    """Pair each exam PDF with its answer key.

    An answer file is recognised by an _ans / _answer / _dapan suffix, or by
    having 'answer'/'解答' in the name.
    """
    pdfs = sorted(directory.glob("*.pdf"))
    answer_markers = ("_ans", "_answer", "_dapan", "answer", "解答", "正解")

    exams = [p for p in pdfs if not any(m in p.stem.lower() for m in answer_markers)]
    answers = [p for p in pdfs if any(m in p.stem.lower() for m in answer_markers)]

    pairs = []
    for exam in exams:
        stem = re.sub(r"_qs$", "", exam.stem.lower())
        match = next((a for a in answers
                      if a.stem.lower() in {
                          stem + suffix for suffix in ("_ans", "_answer", "_dapan")
                      }), None)
        if match is None:
            match = next((a for a in answers
                          if a.stem.lower().startswith(exam.stem.lower())), None)
        pairs.append((exam, match, exam.stem))
    return pairs


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Tách câu hỏi IT Passport từ PDF thành JSON có cấu trúc.")
    parser.add_argument("--exam", type=Path, help="File PDF đề thi")
    parser.add_argument("--answers", type=Path, help="File PDF đáp án")
    parser.add_argument("--dir", type=Path, help="Thư mục chứa nhiều cặp PDF")
    parser.add_argument("--name", help="Tên kỳ thi (mặc định: lấy từ tên file)")
    parser.add_argument("--out", type=Path, default=Path(__file__).parent,
                        help="Thư mục xuất JSON (mặc định: cùng thư mục tool)")
    parser.add_argument("--model", default=os.getenv("OPENAI_DEPLOYMENT", DEFAULT_MODEL),
                        help="Model OpenAI hoặc tên deployment Azure (OPENAI_DEPLOYMENT)")
    parser.add_argument("--batch-size", type=int, default=DEFAULT_BATCH_SIZE,
                        help=f"Số câu mỗi lần gọi LLM (mặc định {DEFAULT_BATCH_SIZE})")
    parser.add_argument("--dry-run", action="store_true",
                        help="Chỉ đọc PDF và in ra, không gọi LLM")
    args = parser.parse_args()

    if args.dir:
        jobs = find_pdf_pairs(args.dir)
        if not jobs:
            sys.exit(f"Không tìm thấy file PDF nào trong {args.dir}")
    elif args.exam:
        if not args.exam.exists():
            sys.exit(f"Không tìm thấy file: {args.exam}")
        jobs = [(args.exam, args.answers, args.name or args.exam.stem)]
    else:
        parser.error("Cần --exam hoặc --dir")

    args.out.mkdir(parents=True, exist_ok=True)

    for exam_pdf, answer_pdf, exam_name in jobs:
        print(f"\n{'=' * 60}\n{exam_name}\n{'=' * 60}")
        questions, stats = process_exam(
            exam_pdf, answer_pdf, exam_name,
            args.model, args.batch_size, args.dry_run)

        if args.dry_run:
            continue

        if not questions:
            print(f"  [bỏ qua] không có kết quả cho {exam_name}", file=sys.stderr)
            continue

        out_path = args.out / f"{exam_name}.json"
        out_path.write_text(
            json.dumps({"exam": exam_name, "questions": questions},
                       ensure_ascii=False, indent=2),
            encoding="utf-8")

        print(f"\n  Đã ghi {out_path}")
        print(f"  câu tách từ PDF        : {stats.questions_found}")
        print(f"  câu LLM trả về         : {stats.questions_returned}")
        print(f"  đáp án khớp bảng đáp án: {stats.answers_matched}/{stats.answers_in_key}")
        if stats.questions_returned < stats.questions_found:
            print(f"  [cảnh báo] thiếu {stats.questions_found - stats.questions_returned} "
                  f"câu so với PDF", file=sys.stderr)
        if stats.batches_failed:
            print(f"  [cảnh báo] {stats.batches_failed} lô thất bại", file=sys.stderr)
        if stats.invalid_groups:
            print(f"  [cảnh báo] {len(stats.invalid_groups)} câu có nhóm kiến thức "
                  f"không hợp lệ:", file=sys.stderr)
            for g in stats.invalid_groups[:5]:
                print(f"      {g}", file=sys.stderr)


if __name__ == "__main__":
    main()
