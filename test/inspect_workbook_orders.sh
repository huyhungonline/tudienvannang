#!/bin/bash
# Read-only: show the workbook_orders schema and row counts (no customer data printed).
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
PG=$(docker ps --format '{{.Names}}' | grep postgres | head -1)
DB=english_word_splitter

echo "=== workbook_orders schema ==="
docker exec "$PG" psql -U postgres -d "$DB" -P pager=off -c "\d workbook_orders" 2>&1

echo ""
echo "=== Row count and date range ==="
docker exec "$PG" psql -U postgres -d "$DB" -P pager=off -c \
"SELECT count(*) AS orders,
        min(created_at)::date AS first_order,
        max(created_at)::date AS latest_order
 FROM workbook_orders;" 2>&1

echo ""
echo "=== Related tables ==="
docker exec "$PG" psql -U postgres -d "$DB" -tAc \
"SELECT tablename FROM pg_tables WHERE schemaname='public'
 AND (tablename LIKE '%order%' OR tablename LIKE '%registration%')
 ORDER BY tablename;" 2>&1
REMOTE
