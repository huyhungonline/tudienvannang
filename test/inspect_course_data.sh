#!/bin/bash
# Read-only: what course values exist, and what constrains them.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
PG=$(docker ps --format '{{.Names}}' | grep postgres | head -1)
DB=english_word_splitter
p() { docker exec "$PG" psql -U postgres -d "$DB" -P pager=off -c "$1" 2>&1; }

echo "=== Registrations per course ==="
p "SELECT course, count(*) AS registrations FROM class_registrations GROUP BY course ORDER BY course;"

echo "=== Class sessions per course ==="
p "SELECT course, code, name, is_active FROM class_sessions ORDER BY course, sort_order;"

echo "=== CHECK constraints on class_registrations ==="
p "SELECT conname, pg_get_constraintdef(oid) AS definition
   FROM pg_constraint
   WHERE conrelid = 'class_registrations'::regclass AND contype = 'c';"
REMOTE
