#!/bin/bash
# The coverage/test scripts scp'd these files to the VPS before they were
# committed, so git refuses to overwrite them. Contents are identical to the
# committed versions, so removing the untracked copies is safe.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1

echo "=== Removing untracked copies ==="
rm -f backend-python/services/mock_exam_service.py test/test_mock_exam_grading.py

echo "=== Pulling ==="
git pull origin main || exit 1
echo "HEAD: $(git log --oneline -1)"

echo ""
echo "=== Files restored by git ==="
ls -1 backend-python/services/mock_exam_service.py test/test_mock_exam_grading.py 2>&1 | sed 's/^/  /'
REMOTE
