#!/bin/bash
# Deploy script - chạy từ local (WSL) để deploy lên VPS
# Usage: bash deploy.sh [commit message]

set -e

VPS_HOST="14.225.198.235"
VPS_USER="root"
VPS_DIR="/root/tudienvannang"
COMMIT_MSG="${1:-deploy update}"

echo "=== [1/4] Push code lên GitHub ==="
git add .
git commit -m "$COMMIT_MSG" || echo "Nothing to commit"
git push origin main

echo ""
echo "=== [2/4] Sync .env lên VPS ==="
scp .env ${VPS_USER}@${VPS_HOST}:${VPS_DIR}/.env
echo "✅ .env synced"

echo ""
echo "=== [3/4] SSH vào VPS: pull + rebuild ==="
ssh ${VPS_USER}@${VPS_HOST} << 'REMOTE'
set -e
cd /root/tudienvannang
git pull origin main

echo ""
echo "=== [4/4] Rebuild Docker ==="
docker-compose up -d --build

echo ""
echo "=== Chờ postgres khởi động... ==="
sleep 8

echo ""
echo "=== Chạy migrations ==="
for f in backend-python/migrations/*.sql; do
    cat "$f" | docker exec -i tudienvannang_postgres_1 psql -U postgres -d english_word_splitter 2>/dev/null || true
done

echo ""
echo "=== Kiểm tra containers ==="
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo ""
echo "=== Done! App chạy tại https://jaenglish.com ==="
REMOTE
