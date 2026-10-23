#!/bin/bash
# Call the real send function once and report whether SMTP accepted it.
# Sends to the admin's own address only.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
docker exec -w /app tudienvannang-backend-1 python3 -c "
import asyncio, db
from services import email_service

async def main():
    row = await db.query_one('SELECT email FROM users WHERE is_admin = true ORDER BY created_at LIMIT 1')
    addr = row['email']
    print('Sending to:', addr)
    ok = email_service.send_mock_exam_result_email(
        to=addr,
        certificate_name='Kỹ năng gia công cơ khí (tiện thường) 3級',
        total_questions=30,
        correct_count=9,
        score_percent=30.0,
        duration_seconds=930,
        wrong_questions=[
            {'questionNo': 2, 'correctLabel': '○', 'selectedLabel': '×'},
            {'questionNo': 5, 'correctLabel': 'ウ', 'selectedLabel': ''},
        ],
    )
    print('SMTP accepted:', ok)
    await db.close_pool()

asyncio.run(main())
"
REMOTE
