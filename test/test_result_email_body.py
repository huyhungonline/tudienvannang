"""Check the mock exam result email body without sending anything.

Patches send_email so nothing leaves the machine, then prints the composed
subject and body for review.

Run: python3 test/test_result_email_body.py
"""
import sys
import os

for candidate in (
    os.path.join(os.path.dirname(__file__), "..", "backend-python"),
    "/app",
):
    if os.path.isdir(os.path.join(candidate, "services")):
        sys.path.insert(0, candidate)
        break

from services import email_service  # noqa: E402

captured = {}


def fake_send_email(to, subject, body):
    captured["to"] = to
    captured["subject"] = subject
    captured["body"] = body
    return True


email_service.send_email = fake_send_email

failures = []


def check(desc, ok):
    if ok:
        print(f"  OK   {desc}")
    else:
        print(f"  FAIL {desc}")
        failures.append(desc)


print("=== Case 1: learner missed three questions ===")
email_service.send_mock_exam_result_email(
    to="hocvien@example.com",
    certificate_name="Kỹ năng gia công cơ khí (tiện thường) 3級",
    total_questions=30,
    correct_count=27,
    score_percent=90.0,
    duration_seconds=1845,
    wrong_questions=[
        {"questionNo": 4, "correctLabel": "○", "selectedLabel": "×"},
        {"questionNo": 11, "correctLabel": "ウ", "selectedLabel": "ア"},
        {"questionNo": 23, "correctLabel": "2", "selectedLabel": ""},
    ],
)
print()
print("SUBJECT:", captured["subject"])
print("-" * 70)
print(captured["body"])
print("-" * 70)
print()

check("recipient correct", captured["to"] == "hocvien@example.com")
check("subject has score", "90.0%" in captured["subject"])
check("subject has ratio", "27/30" in captured["subject"])
check("body has certificate name", "tiện thường" in captured["body"])
check("duration formatted as minutes", "30 phút 45 giây" in captured["body"])
check("lists all three wrong questions", captured["body"].count("Câu ") == 3)
check("unanswered shown clearly", "(không trả lời)" in captured["body"])
check("includes review link", "/certificates" in captured["body"])

print()
print("=== Case 2: perfect score, no wrong answers ===")
email_service.send_mock_exam_result_email(
    to="gioi@example.com",
    certificate_name="Kỳ thi IT Passport",
    total_questions=100,
    correct_count=100,
    score_percent=100.0,
    duration_seconds=None,
    wrong_questions=[],
)
print()
print("SUBJECT:", captured["subject"])
print("-" * 70)
print(captured["body"])
print("-" * 70)
print()

check("no wrong-answer section when perfect", "CÁC CÂU TRẢ LỜI SAI" not in captured["body"])
check("missing duration shown as dash", "—" in captured["body"])
check("subject shows 100%", "100.0%" in captured["subject"])

print()
if failures:
    print(f"{len(failures)} check(s) FAILED")
    sys.exit(1)
print("All checks passed. No email was actually sent.")
