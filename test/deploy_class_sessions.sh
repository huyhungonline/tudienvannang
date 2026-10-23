#!/bin/bash
# Deploy class session management: pull, run migration 038, rebuild, verify.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1

echo "=== Discarding test-script edits ==="
git checkout -- backend-python/services/ 2>/dev/null

echo "=== Pulling ==="
git pull origin main || exit 1
echo "HEAD: $(git log --oneline -1)"

PG=$(docker ps --format '{{.Names}}' | grep postgres | head -1)

echo ""
echo "=== Running migration 038 ==="
cat backend-python/migrations/038_class_sessions.sql \
    | docker exec -i "$PG" psql -U postgres -d english_word_splitter

echo ""
echo "=== class_sessions contents ==="
docker exec "$PG" psql -U postgres -d english_word_splitter -P pager=off -c \
"SELECT s.id, s.code, s.name, s.first_lesson_date, s.capacity, s.is_active,
        (SELECT COUNT(*) FROM class_registrations r
          WHERE r.course = s.course AND r.schedule = s.code) AS registrations
 FROM class_sessions s ORDER BY s.sort_order;"

echo ""
echo "=== Old schedule CHECK constraint should be gone ==="
docker exec "$PG" psql -U postgres -d english_word_splitter -tAc \
"SELECT COALESCE(string_agg(conname, ', '), '(none)')
 FROM pg_constraint
 WHERE conrelid = 'class_registrations'::regclass AND contype = 'c';"

echo ""
echo "=== Rebuilding ==="
docker compose up -d --build 2>&1 | tail -6

for i in $(seq 1 20); do
    s=$(docker inspect --format='{{.State.Health.Status}}' tudienvannang-backend-1 2>/dev/null)
    [ "$s" = "healthy" ] && break
    sleep 3
done
echo ""
docker ps --format 'table {{.Names}}\t{{.Status}}'
REMOTE
