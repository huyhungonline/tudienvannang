#!/bin/bash
ssh root@14.225.198.235 << 'EOF'
docker exec tudienvannang_backend_1 python3 -c "
import os
print('SMTP_HOST:', os.getenv('SMTP_HOST', 'NOT SET'))
print('SMTP_PORT:', os.getenv('SMTP_PORT', 'NOT SET'))
print('SMTP_USER:', os.getenv('SMTP_USER', 'NOT SET'))
print('SMTP_PASSWORD:', os.getenv('SMTP_PASSWORD', 'NOT SET'))
print('FROM_EMAIL:', os.getenv('FROM_EMAIL', 'NOT SET'))
print('APP_URL:', os.getenv('APP_URL', 'NOT SET'))
"
EOF
