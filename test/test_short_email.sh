#!/bin/bash
ssh root@14.225.198.235 << 'EOF'
docker exec tudienvannang_backend_1 python3 -c "
from services.email_service import send_email
result = send_email('huyhungonline@gmail.com', 'jaenglish.com - Code 847291', 'Your verification code is: 847291')
print(f'Result: {result}')
"
EOF
