#!/bin/bash
# Deploy script - chạy từ local (WSL) để deploy lên VPS
# Usage: bash deploy.sh [commit message]

set -e

VPS_HOST="14.225.198.235"
VPS_USER="root"
VPS_DIR="/root/tudienvannang"
COMMIT_MSG="${1:-deploy update}"

echo "=== [1/3] Push code lên GitHub ==="
git add .
git commit -m "$COMMIT_MSG" || echo "Nothing to commit"
git push origin main

echo ""
echo "=== [2/3] SSH vào VPS và pull code ==="
ssh ${VPS_USER}@${VPS_HOST} << 'REMOTE'
cd /root/tudienvannang
git pull origin main

echo ""
echo "=== [3/3] Rebuild Docker ==="
docker-compose down
docker-compose up -d --build

echo ""
echo "=== Chờ postgres khởi động... ==="
sleep 5

echo ""
echo "=== Chạy migrations ==="
cat backend-python/migrations/001_initial_schema.sql | docker exec -i tudienvannang_postgres_1 psql -U postgres -d english_word_splitter 2>/dev/null || true
cat backend-python/migrations/002_macro_news.sql | docker exec -i tudienvannang_postgres_1 psql -U postgres -d english_word_splitter 2>/dev/null || true
cat backend-python/migrations/003_public_searches.sql | docker exec -i tudienvannang_postgres_1 psql -U postgres -d english_word_splitter 2>/dev/null || true

echo ""
echo "=== Kiểm tra containers ==="
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo ""
echo "=== Done! App chạy tại http://14.225.198.235:3000 ==="
REMOTE
