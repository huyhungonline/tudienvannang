"""Verify mock exam label normalisation and choice detection.

Run: python3 test/test_mock_exam_grading.py
"""
import sys
import os

# Works both from the repo root (backend-python/) and inside the container (/app)
for candidate in (
    os.path.join(os.path.dirname(__file__), "..", "backend-python"),
    "/app",
):
    if os.path.isdir(os.path.join(candidate, "services")):
        sys.path.insert(0, candidate)
        break

from services.mock_exam_service import (  # noqa: E402
    normalise_label,
    extract_choice_labels,
    is_true_false,
)

failures = []


def check(desc, actual, expected):
    if actual == expected:
        print(f"  OK   {desc}")
    else:
        print(f"  FAIL {desc}: got {actual!r}, expected {expected!r}")
        failures.append(desc)


print("=== normalise_label: real values found in the database ===")
check("plain circle", normalise_label("○"), "○")
check("circle with Vietnamese suffix", normalise_label("○ — Đúng"), "○")
check("plain cross", normalise_label("×"), "×")
check("cross with suffix", normalise_label("× — Sai"), "×")
check("katakana marker", normalise_label("ア"), "ア")
check("parenthesised number", normalise_label("(3)"), "3")
check("bare number", normalise_label("3"), "3")
check("cancelled question marker", normalise_label("※ — Tất cả thí sinh được công nhận đúng"), "※")
check("None", normalise_label(None), "")
check("empty", normalise_label(""), "")
check("alternate circle glyph 〇", normalise_label("〇"), "○")

print()
print("=== Equivalence: stored vs submitted forms must match ===")
check("'○ — Đúng' equals '○'", normalise_label("○ — Đúng") == normalise_label("○"), True)
check("'(2)' equals '2'", normalise_label("(2)") == normalise_label("2"), True)
check("'×' does not equal '○'", normalise_label("×") == normalise_label("○"), False)

print()
print("=== is_true_false ===")
check("circle label with bool set", is_true_false("○", True), True)
check("cross label with bool set", is_true_false("× — Sai", False), True)
check("katakana with NULL bool", is_true_false("ア", None), False)
check("number with NULL bool", is_true_false("(3)", None), False)

print()
print("=== extract_choice_labels ===")
check("true/false question", extract_choice_labels("下図は、フライス盤である。", "○"), ["○", "×"])

itpp_question = """問1 生成AIを用いた生成物の取扱いに関して,どれか。
a 好みのアーティストの楽曲に似た音楽を生成し，公開した。
b 自分のPC上に保管し,個人で視聴した。
c 偶然似た音楽が生成できたので保管した。
ア a
イ a, b
ウ a, b, c
エ b, c"""
check(
    "katakana multiple choice",
    extract_choice_labels(itpp_question, "ウ"),
    ["ア", "イ", "ウ", "エ"],
)

numbered_question = """次の記述のうち、正しいものはどれか。
(1) 第一の選択肢
(2) 第二の選択肢
(3) 第三の選択肢
(4) 第四の選択肢"""
check(
    "parenthesised multiple choice",
    extract_choice_labels(numbered_question, "(3)"),
    ["1", "2", "3", "4"],
)

check(
    "unparseable body still offers choices",
    len(extract_choice_labels("問題文のみ、選択肢が検出できない。", "イ")) >= 2,
    True,
)

print()
print("=== Grading simulation (pure logic) ===")


def grade(stored_label, submitted_label):
    expected = normalise_label(stored_label)
    chosen = normalise_label(submitted_label)
    if expected == "※":
        return True
    return bool(chosen) and chosen == expected


check("correct true/false answer", grade("○ — Đúng", "○"), True)
check("wrong true/false answer", grade("○", "×"), False)
check("correct multiple choice", grade("ウ", "ウ"), True)
check("wrong multiple choice", grade("ウ", "ア"), False)
check("paren stored vs bare submitted", grade("(4)", "4"), True)
check("unanswered counts as wrong", grade("ア", None), False)
check("cancelled question always correct", grade("※ — Tất cả thí sinh được công nhận đúng", "ア"), True)
check("cancelled question correct even if unanswered", grade("※", None), True)

print()
if failures:
    print(f"{len(failures)} check(s) FAILED")
    sys.exit(1)
print("All checks passed.")
