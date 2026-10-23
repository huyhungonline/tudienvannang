"""Check the Japanese mock exam result email without sending anything.

Patches send_email so nothing leaves the machine, then prints the composed
subject, plain-text body and HTML for review.

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


def fake_send_email(to, subject, body, html=None):
    captured.update({"to": to, "subject": subject, "body": body, "html": html})
    return True


email_service.send_email = fake_send_email

failures = []


def check(desc, ok):
    if ok:
        print(f"  OK   {desc}")
    else:
        print(f"  FAIL {desc}")
        failures.append(desc)


print("=== Case 1: three wrong answers (below pass mark) ===")
email_service.send_mock_exam_result_email(
    to="hocvien@example.com",
    certificate_name="機械加工 3級",
    total_questions=30,
    correct_count=12,
    score_percent=40.0,
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

check("subject in Japanese", "模擬試験の結果" in captured["subject"])
check("duration uses Japanese units", "30分45秒" in captured["body"])
check("body mentions 試験結果", "試験結果" in captured["body"])
check("wrong list header present", "誤答一覧（3問）" in captured["body"])
check("unanswered shown as 未解答", "未解答" in captured["body"])
check("below-pass verdict", "合格ラインまであと一歩" in captured["body"])
check("html produced", bool(captured["html"]))
check("html has score", "40.0%" in captured["html"])
check("html has table rows for 3 misses", captured["html"].count("<tr>") >= 4)
check("html links to site", "/certificates" in captured["html"])
check("no Vietnamese leftovers in body", "Điểm:" not in captured["body"])

print()
print("=== Case 2: perfect score (above pass mark) ===")
email_service.send_mock_exam_result_email(
    to="gioi@example.com",
    certificate_name="ITパスポート試験",
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

check("no wrong-answer section", "誤答一覧" not in captured["body"])
check("missing duration shown as dash", "—" in captured["body"])
check("pass verdict", "合格ライン到達" in captured["body"])
check("html congratulates on full marks", "全問正解" in captured["html"])

print()
print("=== HTML escaping ===")
email_service.send_mock_exam_result_email(
    to="x@example.com",
    certificate_name="Test <script>alert(1)</script>",
    total_questions=1,
    correct_count=0,
    score_percent=0.0,
    duration_seconds=10,
    wrong_questions=[{"questionNo": 1, "correctLabel": "<b>ア</b>", "selectedLabel": "×"}],
)
check("certificate name escaped", "<script>" not in captured["html"])
check("answer label escaped", "<b>ア</b>" not in captured["html"])

print()
if failures:
    print(f"{len(failures)} check(s) FAILED")
    sys.exit(1)
print("All checks passed. No email was actually sent.")
