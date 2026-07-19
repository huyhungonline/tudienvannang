#!/bin/bash
ssh root@14.225.198.235 << 'EOF'
docker exec tudienvannang_backend_1 python3 -c "
from services.email_service import send_email

# Test 1: same subject, no URL
r1 = send_email('huyhungonline@gmail.com', 'Password Reset - jaenglish.com', 'Your reset code is: ABC123')
print(f'Test 1 (subject with Password Reset, no URL): {r1}')

# Test 2: different subject, with URL
r2 = send_email('huyhungonline@gmail.com', 'Your account notification', 'Click here: https://jaenglish.com/reset-password?token=abc123')
print(f'Test 2 (neutral subject, with URL): {r2}')
"
EOF
