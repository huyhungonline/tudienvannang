#!/bin/bash
# Compare APP_URL with the domains actually serving the site.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
echo "=== APP_URL in .env ==="
grep '^APP_URL=' .env

echo ""
echo "=== APP_URL seen by the running backend ==="
docker exec tudienvannang-backend-1 printenv APP_URL 2>/dev/null || echo "(not set in container)"

echo ""
echo "=== Which domains respond? ==="
for d in taogiaoduc.com jaenglish.com; do
    code=$(curl -s -o /dev/null -w '%{http_code}' --max-time 15 "https://$d/" 2>/dev/null)
    echo "  https://$d -> HTTP $code"
done

echo ""
echo "=== nginx server_name entries ==="
grep -rh 'server_name' /etc/nginx/sites-enabled/ 2>/dev/null | sed 's/^/  /' | head -10
REMOTE
