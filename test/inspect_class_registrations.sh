#!/bin/bash
# Read-only: schema + counts for class_registrations (no personal data printed).
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
PG=$(docker ps --format '{{.Names}}' | grep postgres | head -1)
DB=english_word_splitter

echo "=== class_registrations schema ==="
docker exec "$PG" psql -U postgres -d "$DB" -P pager=off -c "\d class_registrations" 2>&1

echo ""
echo "=== Registrations per course/schedule ==="
docker exec "$PG" psql -U postgres -d "$DB" -P pager=off -c \
"SELECT course, schedule, count(*) AS registrations
 FROM class_registrations GROUP BY course, schedule ORDER BY course, schedule;" 2>&1
REMOTE
