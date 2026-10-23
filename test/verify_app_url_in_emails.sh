#!/bin/bash
# Confirm email templates now build links against taogiaoduc.com.
# Patches send_email so nothing is actually sent.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
docker exec -w /app tudienvannang-backend-1 python3 - <<'PY'
from services import email_service
from config import APP_URL, FROM_EMAIL

print('APP_URL loaded by backend :', APP_URL)
print('FROM_EMAIL (unchanged)    :', FROM_EMAIL)
print()

captured = []
email_service.send_email = lambda to, subject, body: (captured.append(body) or True)

email_service.send_welcome_email('hv@example.com')
email_service.send_password_reset_email('hv@example.com', 'TempPass123')
email_service.send_mock_exam_result_email(
    to='hv@example.com', certificate_name='Test', total_questions=10,
    correct_count=8, score_percent=80.0, duration_seconds=600,
    wrong_questions=[])

old = new = 0
print('Links found in the composed emails:')
for body in captured:
    old += body.count('jaenglish.com')
    new += body.count('taogiaoduc.com')
    for line in body.splitlines():
        if 'http' in line:
            print('  ', line.strip())

print()
print('links -> taogiaoduc.com :', new)
print('links -> jaenglish.com  :', old)
print()
print('RESULT:', 'OK' if old == 0 and new > 0 else 'CHECK NEEDED')
PY
REMOTE
