#!/bin/bash
# Verify the URL-token MCP route works over public HTTPS and rejects bad tokens.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
set -a; . ./.env; set +a
HOST=https://taogiaoduc.com
URL="$HOST/api/mcp/t/$MCP_TOKEN"
JSON='Content-Type: application/json'

echo "=== 1. Correct URL token: tools/list ==="
curl -s --max-time 20 -X POST -H "$JSON" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list"}' "$URL" \
  | docker exec -i tudienvannang-backend-1 python3 -c "
import json,sys
d=json.load(sys.stdin)
for t in d['result']['tools']: print('  -', t['name'])"

echo ""
echo "=== 2. Wrong URL token must 404 ==="
curl -s -o /dev/null -w "  wrong token -> HTTP %{http_code}\n" --max-time 15 -X POST -H "$JSON" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list"}' "$HOST/api/mcp/t/wrong-token-123"

echo ""
echo "=== 3. initialize (what ChatGPT calls first) ==="
curl -s --max-time 20 -X POST -H "$JSON" \
  -d '{"jsonrpc":"2.0","id":1,"method":"initialize"}' "$URL" | head -c 220; echo

echo ""
echo "=== 4. add_book_customer through the URL route ==="
curl -s --max-time 25 -X POST -H "$JSON" \
  -d '{"jsonrpc":"2.0","id":2,"method":"tools/call","params":{"name":"add_book_customer","arguments":{"full_name":"URL Token Test","phone":"0988777666","book_type":"Test"}}}' "$URL" \
  | docker exec -i tudienvannang-backend-1 python3 -c "
import json,sys
print(json.load(sys.stdin)['result']['content'][0]['text'])" | sed 's/^/  /'

echo ""
echo "=== 5. Header route still works (Claude Desktop / Kiro) ==="
curl -s --max-time 20 -X POST -H "Authorization: Bearer $MCP_TOKEN" -H "$JSON" \
  -d '{"jsonrpc":"2.0","id":3,"method":"tools/list"}' "$HOST/api/mcp" \
  | grep -q add_book_customer && echo "  OK" || echo "  FAILED"

echo ""
echo "=== 6. Cleanup ==="
PG=$(docker ps --format '{{.Names}}' | grep postgres | head -1)
docker exec "$PG" psql -U postgres -d english_word_splitter -tAc \
  "DELETE FROM book_customers WHERE full_name = 'URL Token Test';" >/dev/null
docker exec "$PG" psql -U postgres -d english_word_splitter -tAc \
  "SELECT 'rows remaining: ' || count(*) FROM book_customers;"

echo ""
echo "=== Your ChatGPT connector URL ==="
echo "  $URL"
REMOTE
