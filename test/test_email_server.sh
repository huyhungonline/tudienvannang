#!/bin/bash
ssh root@14.225.198.235 << 'EOF'
docker exec tudienvannang_backend_1 python3 -c "
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

SMTP_HOST = 'pro205.emailserver.vn'
SMTP_PORT = 465
SMTP_USER = 'admin@jaenglish.com'
SMTP_PASSWORD = 'Kmno4kclo3!123'
FROM_EMAIL = SMTP_USER
TO_EMAIL = 'huyhungonline@gmail.com'
SUBJECT = 'Test email from server container'
BODY = 'This is a test email sent from the backend container on VPS.'

msg = MIMEMultipart()
msg['From'] = FROM_EMAIL
msg['To'] = TO_EMAIL
msg['Subject'] = SUBJECT
msg.attach(MIMEText(BODY, 'plain'))

try:
    print(f'Connecting to {SMTP_HOST}:{SMTP_PORT} (SSL)...')
    server = smtplib.SMTP_SSL(SMTP_HOST, SMTP_PORT, timeout=10)
    print(f'Logging in as {SMTP_USER}...')
    server.login(SMTP_USER, SMTP_PASSWORD)
    print(f'Sending email to {TO_EMAIL}...')
    server.sendmail(FROM_EMAIL, TO_EMAIL, msg.as_string())
    server.quit()
    print('Email sent successfully!')
except Exception as e:
    print(f'Error: {e}')
"
EOF
