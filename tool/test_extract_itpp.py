"""Check the PDF-parsing logic without touching an LLM or a real PDF.

Run: python3 tool/test_extract_itpp.py
"""
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))

from extract_itpp_questions import (  # noqa: E402
    KNOWLEDGE_GROUPS,
    find_pdf_pairs,
    parse_answer_key,
    split_questions,
)

failures = []


def check(desc, ok):
    print(f"  {'OK  ' if ok else 'FAIL'} {desc}")
    if not ok:
        failures.append(desc)


print("=== split_questions ===")
sample = """問1 次の記述のうち、適切なものはどれか。
ア 選択肢A
イ 選択肢B
ウ 選択肢C
エ 選択肢D
問2 データベースに関する問題。
ア あ
イ い
問 3 空白ありの番号も認識する。
ア A
イ B"""
qs = split_questions(sample)
check("splits three questions", len(qs) == 3)
check("keeps the 問N marker", qs[0].startswith("問1"))
check("keeps the options with the question", "エ 選択肢D" in qs[0])
check("handles a space after 問", qs[2].startswith("問 3"))
check("ignores section range and inline references",
      len(split_questions("問1から問34まではストラテジ系です。\n問1 問2を参照する。\n問2 次の問題。")) == 2)
check("ignores cover ranges and handles ruby and OCR punctuation",
      len(split_questions("問1~問100\n問1 A\nぜい 問2 B\n·問3 C")) == 3)
passages = split_questions(
    "問84 A\n中問A 共通の説明\n問85 B\n問86 C\n"
    "中問B 別の説明\n問89 D\n表計算ソフトの機能·用語\n付録")
check("does not attach a shared passage to the preceding question",
      "共通の説明" not in passages[0])
check("attaches a shared passage to each related question",
      all("共通の説明" in q for q in passages[1:3]))
check("switches context at the next passage",
      "別の説明" in passages[3] and "共通の説明" not in passages[3])
check("excludes reference appendices", "付録" not in passages[-1])

print()
print("=== split_questions on text with no markers ===")
check("returns empty list", split_questions("không có câu hỏi nào ở đây") == [])

print()
print("=== parse_answer_key: 問N format ===")
key = parse_answer_key("問1 ア\n問2 イ\n問3 ウ\n問4 エ")
check("reads four answers", len(key) == 4)
check("question 1 is ア", key.get(1) == "ア")
check("question 4 is エ", key.get(4) == "エ")

print()
print("=== parse_answer_key: table format ===")
table = " ".join(f"{i} {'アイウエ'[i % 4]}" for i in range(1, 21))
key2 = parse_answer_key(table)
check("reads twenty answers from a table", len(key2) == 20)
check("question 5 matches the table", key2.get(5) == "アイウエ"[5 % 4])

print()
print("=== parse_answer_key ignores out-of-range numbers ===")
key3 = parse_answer_key("問1 ア\n999 イ\n1500 ウ")
check("keeps question 1", key3.get(1) == "ア")
check("drops 1500 (above 120)", 1500 not in key3)

print()
print("=== knowledge groups ===")
check("exactly nine groups", len(KNOWLEDGE_GROUPS) == 9)
check("no duplicates", len(set(KNOWLEDGE_GROUPS)) == 9)
for g in ["企業と法務", "技術要素", "基礎理論"]:
    check(f"contains {g}", g in KNOWLEDGE_GROUPS)

print()
print("=== find_pdf_pairs ===")
temporary_directory = tempfile.TemporaryDirectory()
tmp = Path(temporary_directory.name)
for name in ["2026_spring.pdf", "2026_spring_ans.pdf",
             "2025_autumn.pdf", "2025_autumn_answer.pdf",
             "2024_solo.pdf", "2026r08_ip_qs.pdf", "2026r08_ip_ans.pdf"]:
    (tmp / name).touch()

pairs = find_pdf_pairs(tmp)
by_name = {name: (exam, ans) for exam, ans, name in pairs}
check("finds four exams", len(pairs) == 4)
check("pairs actual IT-PP filenames",
      by_name["2026r08_ip_qs"][1] == tmp / "2026r08_ip_ans.pdf")
check("pairs 2026_spring with its _ans file",
      by_name["2026_spring"][1] is not None
      and by_name["2026_spring"][1].name == "2026_spring_ans.pdf")
check("pairs 2025_autumn with its _answer file",
      by_name["2025_autumn"][1] is not None)
check("exam without an answer file yields None",
      by_name["2024_solo"][1] is None)
check("answer files are not treated as exams",
      not any(n.endswith("_ans") or n.endswith("_answer") for n in by_name))

temporary_directory.cleanup()

print()
if failures:
    print(f"{len(failures)} check(s) FAILED")
    sys.exit(1)
print("All checks passed.")
