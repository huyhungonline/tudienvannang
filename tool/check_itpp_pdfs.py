"""Check cached OCR or local PDF coverage without calling Azure or an LLM."""
import json
import os
import re
from pathlib import Path

from extract_itpp_questions import (
    find_pdf_pairs, parse_answer_key, read_pdf_text, split_questions,
)


def main():
    # Use saved OCR when present; otherwise inspect the local text layer.
    os.environ.pop("DOC_INTELLIGENCE_ENDPOINT", None)
    os.environ.pop("DOC_INTELLIGENCE_KEY", None)
    rows = []
    for exam, answer, name in find_pdf_pairs(Path(__file__).parent / "IT-PP"):
        questions = split_questions(read_pdf_text(exam))
        key = parse_answer_key(read_pdf_text(answer)) if answer else {}
        numbers = [int(re.match(r"問\s*(\d+)", q).group(1)) for q in questions]
        row = dict(
            exam=name, questions=len(questions), unique_questions=len(set(numbers)),
            answers=len(key), missing_answers=sorted(set(numbers) - set(key)),
            missing_questions=sorted(set(range(1, 101)) - set(numbers)),
        )
        rows.append(row)
        print(json.dumps(row, ensure_ascii=False), flush=True)
    report = Path(__file__).with_name("pdf_check_report.json")
    report.write_text(json.dumps(rows, ensure_ascii=False, indent=2), encoding="utf-8")
    return 0 if rows and all(
        row["questions"] == row["unique_questions"] == row["answers"] == 100
        and not row["missing_answers"] and not row["missing_questions"]
        for row in rows
    ) else 1


if __name__ == "__main__":
    raise SystemExit(main())
