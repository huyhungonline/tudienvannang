#!/bin/bash
ssh root@14.225.198.235 << 'EOF'
docker exec tudienvannang_backend_1 python3 -c "
from services.email_service import send_email
result = send_email('huyhungonline@gmail.com', 'Direct test from backend service', 'This email is sent using the actual backend send_email function.')
print(f'Result: {result}')
"
EOF
