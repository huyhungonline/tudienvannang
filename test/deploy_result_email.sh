#!/bin/bash
# Deploy the result-email change. Clears untracked copies left by test scripts
# first, since git refuses to overwrite them.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1

echo "=== Discarding local edits made by test scripts ==="
git checkout -- backend-python/services/email_service.py \
                backend-python/services/mock_exam_service.py 2>/dev/null
rm -f test/test_result_email_body.py

echo "=== Pulling ==="
git pull origin main || exit 1
echo "HEAD: $(git log --oneline -1)"

echo ""
echo "=== Rebuilding backend ==="
docker compose up -d --build backend 2>&1 | tail -6

echo ""
echo "=== Waiting for health ==="
for i in $(seq 1 20); do
    status=$(docker inspect --format='{{.State.Health.Status}}' tudienvannang-backend-1 2>/dev/null)
    [ "$status" = "healthy" ] && break
    sleep 3
done
docker ps --format 'table {{.Names}}\t{{.Status}}'
REMOTE
