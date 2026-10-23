"""Review all four email templates without sending anything.

Run inside the backend container:
  python3 /tmp/test_all_email_templates.py
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

sent = []
email_service.send_email = lambda to, subject, body, html=None: (
    sent.append({"to": to, "subject": subject, "body": body, "html": html}) or True
)

failures = []


def check(desc, ok):
    print(f"  {'OK  ' if ok else 'FAIL'} {desc}")
    if not ok:
        failures.append(desc)


cases = [
    ("WELCOME", lambda: email_service.send_welcome_email("hv@example.com")),
    ("PRO UPGRADE", lambda: email_service.send_pro_upgrade_email("hv@example.com")),
    ("PASSWORD RESET", lambda: email_service.send_password_reset_email("hv@example.com", "Xk7mPq2w")),
    ("MOCK EXAM RESULT", lambda: email_service.send_mock_exam_result_email(
        to="hv@example.com", certificate_name="機械加工 3級", total_questions=30,
        correct_count=21, score_percent=70.0, duration_seconds=1530,
        wrong_questions=[{"questionNo": 7, "correctLabel": "イ", "selectedLabel": "エ"}])),
]

for name, fn in cases:
    sent.clear()
    fn()
    m = sent[0]
    print()
    print("=" * 72)
    print(f"{name}")
    print("=" * 72)
    print("SUBJECT:", m["subject"])
    print("-" * 72)
    print(m["body"])
    print("-" * 72)
    check(f"{name}: subject has brand prefix", m["subject"].startswith("【"))
    check(f"{name}: html generated", bool(m["html"]))
    check(f"{name}: html has branded header", "#1976d2" in (m["html"] or ""))
    check(f"{name}: html has footer link", APP := (f"{email_service.APP_URL}" in (m["html"] or "")))
    check(f"{name}: no Vietnamese 'Xin chào'", "Xin chào" not in m["body"])
    check(f"{name}: no English 'Hi,'", not m["body"].startswith("Hi,"))

print()
print("=" * 72)
print("Cross-checks")
print("=" * 72)

sent.clear()
email_service.send_password_reset_email("x@example.com", "Secret99")
m = sent[0]
check("reset: password appears in text body", "Secret99" in m["body"])
check("reset: password appears in html", "Secret99" in m["html"])
check("reset: warns about changing password", "変更" in m["body"])

sent.clear()
email_service.send_welcome_email("new@example.com")
m = sent[0]
check("welcome: shows the account address", "new@example.com" in m["body"])
check("welcome: links to login", "/login" in m["html"])

print()
if failures:
    print(f"{len(failures)} check(s) FAILED")
    sys.exit(1)
print("All checks passed. No email was sent.")
