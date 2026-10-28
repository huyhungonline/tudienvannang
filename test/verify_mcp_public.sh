#!/bin/bash
# Check the MCP endpoint is reachable over public HTTPS, not just inside the VPS.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
set -a; . ./.env; set +a

for HOST in https://taogiaoduc.com https://jaenglish.com; do
    echo "=== $HOST ==="
    echo -n "  /api/mcp/health -> "
    curl -s -o /tmp/h -w '%{http_code}' --max-time 15 "$HOST/api/mcp/health"
    echo "  body: $(cat /tmp/h)"

    echo -n "  POST /api/mcp (no token) -> "
    curl -s -o /dev/null -w '%{http_code}\n' --max-time 15 -X POST \
      -H 'Content-Type: application/json' \
      -d '{"jsonrpc":"2.0","id":1,"method":"tools/list"}' "$HOST/api/mcp"

    echo -n "  POST /api/mcp (with token) -> "
    RESP=$(curl -s --max-time 20 -X POST \
      -H "Authorization: Bearer $MCP_TOKEN" -H 'Content-Type: application/json' \
      -d '{"jsonrpc":"2.0","id":1,"method":"tools/list"}' "$HOST/api/mcp")
    if echo "$RESP" | grep -q 'add_book_customer'; then
        echo "OK (tools returned)"
    else
        echo "FAILED"
        echo "    response: $(echo "$RESP" | head -c 200)"
    fi
    echo ""
done
rm -f /tmp/h

echo "=== nginx proxy rules for /api ==="
grep -rhA3 'location /api' /etc/nginx/sites-enabled/ 2>/dev/null | head -20 | sed 's/^/  /'
REMOTE
