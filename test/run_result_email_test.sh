#!/bin/bash
# Run the result-email body test inside the backend container (needs config/env).
# send_email is patched out, so no mail is sent.
cd "$(dirname "$0")/.." || exit 1

scp -q backend-python/services/email_service.py \
    backend-python/services/mock_exam_service.py \
    root@14.225.198.235:/root/tudienvannang/backend-python/services/
scp -q test/test_result_email_body.py root@14.225.198.235:/root/tudienvannang/test/

ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
docker cp backend-python/services/email_service.py tudienvannang-backend-1:/app/services/
docker cp backend-python/services/mock_exam_service.py tudienvannang-backend-1:/app/services/
docker cp test/test_result_email_body.py tudienvannang-backend-1:/tmp/
docker exec -w /app tudienvannang-backend-1 python3 /tmp/test_result_email_body.py
docker exec tudienvannang-backend-1 rm -f /tmp/test_result_email_body.py
REMOTE
