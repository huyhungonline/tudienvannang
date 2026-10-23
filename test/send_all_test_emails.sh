#!/bin/bash
# Send one of each email template to the admin's own address for visual review.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
docker exec -w /app tudienvannang-backend-1 python3 -c "
import asyncio, db
from services import email_service

async def main():
    row = await db.query_one('SELECT email FROM users WHERE is_admin = true ORDER BY created_at LIMIT 1')
    addr = row['email']
    print('Sending to:', addr)
    print()

    print('welcome        :', email_service.send_welcome_email(addr))
    print('pro upgrade    :', email_service.send_pro_upgrade_email(addr))
    print('password reset :', email_service.send_password_reset_email(addr, 'DemoPass2026'))
    print()
    print('NOTE: the password above is a sample, no account was changed.')
    await db.close_pool()

asyncio.run(main())
"
REMOTE
