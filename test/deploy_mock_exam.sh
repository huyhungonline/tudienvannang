#!/bin/bash
# Deploy the mock exam feature: pull, run the new migration, rebuild.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1

echo "=== Pulling ==="
git pull origin main || exit 1
echo "HEAD: $(git log --oneline -1)"

echo ""
echo "=== Running migration 036 ==="
PG=$(docker ps --format '{{.Names}}' | grep postgres | head -1)
cat backend-python/migrations/036_mock_exam_attempts.sql \
    | docker exec -i "$PG" psql -U postgres -d english_word_splitter

echo ""
echo "=== Verifying new tables ==="
docker exec "$PG" psql -U postgres -d english_word_splitter -tAc \
  "SELECT tablename FROM pg_tables WHERE schemaname='public'
   AND tablename LIKE 'mock_exam%' ORDER BY tablename;"

echo ""
echo "=== Rebuilding ==="
docker compose up -d --build 2>&1 | tail -8

echo ""
echo "=== Containers ==="
docker ps --format 'table {{.Names}}\t{{.Status}}'
REMOTE
