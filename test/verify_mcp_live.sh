#!/bin/bash
# End-to-end check of the MCP endpoint: auth, tool discovery, write, read, cleanup.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
PG=$(docker ps --format '{{.Names}}' | grep postgres | head -1)
set -a; . ./.env; set +a
URL=http://localhost:4000/api/mcp
AUTH="Authorization: Bearer $MCP_TOKEN"
JSON='Content-Type: application/json'

rpc() { curl -s -X POST -H "$AUTH" -H "$JSON" -d "$1" "$URL"; }

echo "=== 1. Health (no auth needed) ==="
curl -s "$URL/health"; echo

echo ""
echo "=== 2. Request without a token must be refused ==="
curl -s -o /dev/null -w "  no token -> HTTP %{http_code}\n" -X POST -H "$JSON" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list"}' "$URL"
echo "  wrong token ->" $(curl -s -X POST -H 'Authorization: Bearer wrong' -H "$JSON" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list"}' "$URL" | head -c 80)

echo ""
echo "=== 3. initialize ==="
rpc '{"jsonrpc":"2.0","id":1,"method":"initialize"}' | head -c 250; echo

echo ""
echo "=== 4. tools/list ==="
rpc '{"jsonrpc":"2.0","id":2,"method":"tools/list"}' \
  | docker exec -i tudienvannang-backend-1 python3 -c "
import json,sys
d=json.load(sys.stdin)
for t in d['result']['tools']:
    print('  -', t['name'])
    print('    required:', t['inputSchema'].get('required', []))"

echo ""
echo "=== 5. add_book_customer ==="
rpc '{"jsonrpc":"2.0","id":3,"method":"tools/call","params":{"name":"add_book_customer","arguments":{"full_name":"Nguyễn Văn Test","phone":"0901234567","email":"test@example.com","address":"123 Lê Lợi, Quận 1, TP.HCM","book_type":"IT Passport"}}}' \
  | docker exec -i tudienvannang-backend-1 python3 -c "
import json,sys
print(json.load(sys.stdin)['result']['content'][0]['text'])" | sed 's/^/  /'

echo ""
echo "=== 6. Duplicate detection (same phone) ==="
rpc '{"jsonrpc":"2.0","id":4,"method":"tools/call","params":{"name":"add_book_customer","arguments":{"full_name":"Nguyen Van Test 2","phone":"0901234567"}}}' \
  | docker exec -i tudienvannang-backend-1 python3 -c "
import json,sys
print(json.load(sys.stdin)['result']['content'][0]['text'])" | sed 's/^/  /'

echo ""
echo "=== 7. list_book_customers (data must be masked) ==="
rpc '{"jsonrpc":"2.0","id":5,"method":"tools/call","params":{"name":"list_book_customers","arguments":{"limit":5}}}' \
  | docker exec -i tudienvannang-backend-1 python3 -c "
import json,sys
print(json.load(sys.stdin)['result']['content'][0]['text'])" | sed 's/^/  /'

echo ""
echo "  Masking check: full values must NOT appear"
OUT=$(rpc '{"jsonrpc":"2.0","id":6,"method":"tools/call","params":{"name":"list_book_customers","arguments":{"limit":5}}}')
for secret in '0901234567' 'test@example.com' '123 Lê Lợi'; do
    if echo "$OUT" | grep -qF "$secret"; then
        echo "    LEAK: '$secret' exposed"
    else
        echo "    ok: '$secret' not exposed"
    fi
done

echo ""
echo "=== 8. book_customer_stats ==="
rpc '{"jsonrpc":"2.0","id":7,"method":"tools/call","params":{"name":"book_customer_stats","arguments":{}}}' \
  | docker exec -i tudienvannang-backend-1 python3 -c "
import json,sys
print(json.load(sys.stdin)['result']['content'][0]['text'])" | sed 's/^/  /'

echo ""
echo "=== 9. No delete tool is exposed ==="
rpc '{"jsonrpc":"2.0","id":8,"method":"tools/call","params":{"name":"delete_book_customer","arguments":{"id":1}}}' | head -c 150; echo

echo ""
echo "=== 10. Cleanup test rows ==="
docker exec "$PG" psql -U postgres -d english_word_splitter -tAc \
  "DELETE FROM book_customers WHERE source='chatgpt' AND full_name LIKE '%Test%';" >/dev/null
docker exec "$PG" psql -U postgres -d english_word_splitter -tAc \
  "SELECT 'rows remaining: ' || count(*) FROM book_customers;"
REMOTE
