#!/bin/bash
ssh root@14.225.198.235 << 'EOF'
docker exec tudienvannang_backend_1 python3 -c "
from services.email_service import send_password_reset_email
result = send_password_reset_email('huyhungonline@gmail.com', 'test-token-12345')
print(f'Result: {result}')
"
EOF
