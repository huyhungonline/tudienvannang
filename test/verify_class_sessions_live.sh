#!/bin/bash
# End-to-end check of class session management. Creates a test class, verifies
# the active toggle hides it from the public list, then removes it.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
PG=$(docker ps --format '{{.Names}}' | grep postgres | head -1)

TOKEN=$(docker exec -w /app tudienvannang-backend-1 python3 -c "
import asyncio, db
from services.auth_service import _create_token
async def main():
    r = await db.query_one('SELECT id FROM users WHERE is_admin = true ORDER BY created_at LIMIT 1')
    print(_create_token(str(r['id'])) if r else '')
    await db.close_pool()
asyncio.run(main())" 2>/dev/null | tr -d '\r\n')
[ -n "$TOKEN" ] || { echo "no token"; exit 1; }
AUTH="Authorization: Bearer $TOKEN"
BASE=http://localhost:4000/api/classes

echo "=== 1. Public list (before) ==="
curl -s "$BASE/sessions?course=it-passport" | head -c 400; echo

echo ""
echo "=== 2. Create a December class (admin) ==="
CREATED=$(curl -s -X POST -H "$AUTH" -H 'Content-Type: application/json' \
  -d '{"course":"it-passport","code":"test-thang-12","name":"Lớp tháng 12 — TEST","first_lesson_date":"2026-12-01","capacity":50,"is_active":true,"sort_order":10}' \
  "$BASE/admin/sessions")
echo "$CREATED" | head -c 300; echo
SID=$(echo "$CREATED" | docker exec -i tudienvannang-backend-1 python3 -c "import json,sys; print(json.load(sys.stdin).get('id',''))" 2>/dev/null | tr -d '\r\n')
echo "  created id: $SID"

echo ""
echo "=== 3. Public list now includes it ==="
curl -s "$BASE/sessions?course=it-passport" \
  | docker exec -i tudienvannang-backend-1 python3 -c "
import json,sys
d=json.load(sys.stdin)
for s in d['sessions']:
    print(f\"  {s['code']:<20} {s['name'][:40]:<42} {s['taken']}/{s['capacity']} full={s['isFull']}\")"

echo ""
echo "=== 4. Deactivate it ==="
curl -s -X PUT -H "$AUTH" -H 'Content-Type: application/json' \
  -d '{"is_active":false}' "$BASE/admin/sessions/$SID" | head -c 200; echo

echo ""
echo "=== 5. Public list must no longer offer it ==="
curl -s "$BASE/sessions?course=it-passport" \
  | docker exec -i tudienvannang-backend-1 python3 -c "
import json,sys
d=json.load(sys.stdin)
codes=[s['code'] for s in d['sessions']]
print('  codes:', codes)
print('  RESULT:', 'OK - hidden' if 'test-thang-12' not in codes else 'FAIL - still visible')"

echo ""
echo "=== 6. Registering for a deactivated class must be refused ==="
curl -s -X POST -H 'Content-Type: application/json' \
  -d "{\"request_id\":\"$(cat /proc/sys/kernel/random/uuid)\",\"course\":\"it-passport\",\"full_name\":\"Test\",\"email\":\"t@example.com\",\"phone\":\"0901234567\",\"schedule\":\"test-thang-12\"}" \
  "$BASE/registrations" | head -c 250; echo

echo ""
echo "=== 7. Registering for a non-existent class must be refused ==="
curl -s -X POST -H 'Content-Type: application/json' \
  -d "{\"request_id\":\"$(cat /proc/sys/kernel/random/uuid)\",\"course\":\"it-passport\",\"full_name\":\"Test\",\"email\":\"t@example.com\",\"phone\":\"0901234567\",\"schedule\":\"khong-ton-tai\"}" \
  "$BASE/registrations" | head -c 250; echo

echo ""
echo "=== 8. Cleanup ==="
curl -s -X DELETE -H "$AUTH" "$BASE/admin/sessions/$SID" | head -c 200; echo
docker exec "$PG" psql -U postgres -d english_word_splitter -tAc \
  "SELECT 'classes remaining: ' || count(*) FROM class_sessions;"
REMOTE
