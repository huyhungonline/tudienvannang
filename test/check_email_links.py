"""Confirm email templates build links against the configured APP_URL.

Patches send_email so nothing is sent. Run inside the backend container.
"""
import sys

sys.path.insert(0, "/app")

from config import APP_URL, FROM_EMAIL  # noqa: E402
from services import email_service  # noqa: E402

print("APP_URL loaded by backend :", APP_URL)
print("FROM_EMAIL (unchanged)    :", FROM_EMAIL)
print()

captured = []
email_service.send_email = lambda to, subject, body: (captured.append(body) or True)

email_service.send_welcome_email("hv@example.com")
try:
    email_service.send_password_reset_email("hv@example.com", "TempPass123")
except AttributeError:
    pass
email_service.send_mock_exam_result_email(
    to="hv@example.com",
    certificate_name="Test",
    total_questions=10,
    correct_count=8,
    score_percent=80.0,
    duration_seconds=600,
    wrong_questions=[],
)

old = new = 0
print("Links found in the composed emails:")
for body in captured:
    old += body.count("jaenglish.com")
    new += body.count("taogiaoduc.com")
    for line in body.splitlines():
        if "http" in line:
            print("  ", line.strip())

print()
print("links -> taogiaoduc.com :", new)
print("links -> jaenglish.com  :", old)
print()
print("RESULT:", "OK" if old == 0 and new > 0 else "CHECK NEEDED")
