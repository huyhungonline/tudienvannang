#!/bin/bash
ssh root@14.225.198.235 << 'EOF'
docker exec tudienvannang_backend_1 python3 -c "
import smtplib
try:
    s = smtplib.SMTP_SSL('pro205.emailserver.vn', 465, timeout=10)
    s.login('admin@jaenglish.com', 'Kmno4kclo3!123')
    print('SMTP login OK')
    s.quit()
except Exception as e:
    print(f'SMTP error: {e}')
"
EOF
