"""Run all IT-PP exams with resumable caches and strict output validation."""
import json
import os
import re
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path

from extract_itpp_questions import (
    KNOWLEDGE_GROUPS, find_pdf_pairs, parse_answer_key, process_exam,
    read_pdf_text, split_questions,
)

ROOT = Path(__file__).resolve().parent
OUTPUT = ROOT / "structured"


def run(job):
    exam, answer, name = job
    output = OUTPUT / f"{name}.json"
    source = split_questions(read_pdf_text(exam))
    numbers = [int(re.match(r"問\s*(\d+)", q).group(1)) for q in source]
    key = parse_answer_key(read_pdf_text(answer)) if answer else {}
    if sorted(numbers) != list(range(1, 101)) or sorted(key) != list(range(1, 101)):
        raise ValueError(f"{name}: OCR câu hỏi/đáp án chưa đủ 1–100: "
                         f"questions={len(numbers)}, missing={sorted(set(range(1,101))-set(numbers))}")
    if output.exists():
        existing = json.loads(output.read_text(encoding="utf-8"))
        if existing.get("validation", {}).get("complete"):
            return dict(exam=name, questions=100, status="complete")
    for attempt in range(3):
        questions, stats = process_exam(
            exam, answer, name, os.getenv("OPENAI_DEPLOYMENT", "gpt-5.4"), 5, False)
        questions.sort(key=lambda q: q["question_no"])
        complete = (
            [q["question_no"] for q in questions] == list(range(1, 101))
            and all(q["answer"] == key[q["question_no"]]
                    and q["knowledge_group"] in KNOWLEDGE_GROUPS
                    and q["question_vi"].strip() and q["explanation_vi"].strip()
                    for q in questions)
        )
        payload = dict(
            exam=name, source_pdf=exam.name, answer_pdf=answer.name,
            model=os.getenv("OPENAI_DEPLOYMENT", "gpt-5.4"),
            validation=dict(complete=bool(complete), expected_questions=100,
                            returned_questions=len(questions),
                            answers_matched=stats.answers_matched),
            extraction_note="Japanese text is OCR output. Refer to source PDF for figures and OCR ambiguities.",
            questions=questions,
        )
        temporary = output.with_suffix(".tmp")
        temporary.write_text(json.dumps(payload, ensure_ascii=False, indent=2), encoding="utf-8")
        temporary.replace(output)
        if complete:
            print(f"COMPLETE {name}: 100/100", flush=True)
            return dict(exam=name, questions=100, status="complete")
        print(f"RETRY {name}: {len(questions)}/100; attempt {attempt+1}", flush=True)
    raise ValueError(f"{name}: incomplete after retries; see {output}")


def main():
    OUTPUT.mkdir(exist_ok=True)
    jobs = find_pdf_pairs(ROOT / "IT-PP")
    summary = []
    with ThreadPoolExecutor(max_workers=8) as executor:
        futures = {executor.submit(run, job): job[2] for job in jobs}
        for future in as_completed(futures):
            name = futures[future]
            try:
                summary.append(future.result())
            except Exception as error:
                print(f"FAILED {name}: {error}", flush=True)
                summary.append(dict(exam=name, status="failed", error=str(error)))
            (OUTPUT / "run_report.json").write_text(
                json.dumps(sorted(summary, key=lambda row: row["exam"]),
                           ensure_ascii=False, indent=2), encoding="utf-8")
    return 0 if len(summary) == 17 and all(row["status"] == "complete" for row in summary) else 1


if __name__ == "__main__":
    raise SystemExit(main())
