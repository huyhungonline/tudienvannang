#!/bin/bash
# Run the mock exam grading tests inside the VPS backend container,
# where asyncpg and the rest of the dependencies are installed.
cd "$(dirname "$0")/.." || exit 1

echo "=== Copying service + test to VPS ==="
scp -q backend-python/services/mock_exam_service.py \
    root@14.225.198.235:/root/tudienvannang/backend-python/services/
scp -q test/test_mock_exam_grading.py \
    root@14.225.198.235:/root/tudienvannang/test/

echo ""
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
docker cp backend-python/services/mock_exam_service.py tudienvannang-backend-1:/app/services/
docker cp test/test_mock_exam_grading.py tudienvannang-backend-1:/tmp/
echo "=== Running tests in container ==="
docker exec -w /app tudienvannang-backend-1 python3 /tmp/test_mock_exam_grading.py
REMOTE
