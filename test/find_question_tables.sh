#!/bin/bash
# Read-only: find tables that look like they store questions, and show their
# columns plus row counts.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
PG=$(docker ps --format '{{.Names}}' | grep postgres | head -1)
DB=english_word_splitter
q() { docker exec "$PG" psql -U postgres -d "$DB" -tAc "$1" 2>/dev/null; }

echo "=== Tables with 'question'/'quiz'/'exam'/'answer' in the name ==="
q "SELECT tablename FROM pg_tables WHERE schemaname='public'
   AND (tablename ILIKE '%question%' OR tablename ILIKE '%quiz%'
        OR tablename ILIKE '%exam%' OR tablename ILIKE '%answer%'
        OR tablename ILIKE '%test%')
   ORDER BY tablename;"

echo ""
echo "=== Tables having a column named like a question/answer field ==="
q "SELECT DISTINCT table_name FROM information_schema.columns
   WHERE table_schema='public'
     AND (column_name ILIKE '%question%' OR column_name ILIKE '%answer%'
          OR column_name ILIKE '%option%' OR column_name ILIKE '%correct%')
   ORDER BY table_name;"

echo ""
echo "=== All public tables with row counts ==="
for t in $(q "SELECT tablename FROM pg_tables WHERE schemaname='public' ORDER BY tablename;"); do
    c=$(q "SELECT count(*) FROM \"$t\";")
    printf '  %-38s %s rows\n' "$t" "$c"
done
REMOTE
