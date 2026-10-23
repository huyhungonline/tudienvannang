#!/bin/bash
# Review every email template inside the backend container. Nothing is sent.
cd "$(dirname "$0")/.." || exit 1

scp -q backend-python/services/email_service.py \
    root@14.225.198.235:/root/tudienvannang/backend-python/services/
scp -q test/test_all_email_templates.py root@14.225.198.235:/tmp/

ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
docker cp backend-python/services/email_service.py tudienvannang-backend-1:/app/services/
docker cp /tmp/test_all_email_templates.py tudienvannang-backend-1:/tmp/
docker exec -w /app tudienvannang-backend-1 python3 /tmp/test_all_email_templates.py
docker exec tudienvannang-backend-1 rm -f /tmp/test_all_email_templates.py
rm -f /tmp/test_all_email_templates.py
REMOTE
