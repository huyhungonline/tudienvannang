#!/bin/bash
# Point APP_URL at taogiaoduc.com on the VPS and restart the backend so the
# new value is picked up. Backs up .env first and leaves every other value
# untouched.
NEW_URL="${1:-https://taogiaoduc.com}"

ssh root@14.225.198.235 "NEW_URL='$NEW_URL' bash -s" <<'REMOTE'
cd /root/tudienvannang || exit 1

echo "=== Before ==="
grep '^APP_URL=' .env || echo "  (APP_URL not present)"

BACKUP=".env.bak.$(date +%Y%m%d_%H%M%S)"
cp .env "$BACKUP"
echo "  backup: $BACKUP"

# Replace the line without touching anything else.
grep -v '^APP_URL=' .env > /tmp/env.new
printf 'APP_URL=%s\n' "$NEW_URL" >> /tmp/env.new
mv /tmp/env.new .env

echo ""
echo "=== After ==="
grep '^APP_URL=' .env

echo ""
echo "=== Confirming .env still sources cleanly ==="
if ( set -a; . ./.env; set +a ) 2>/tmp/env_err && [ ! -s /tmp/env_err ]; then
    echo "  OK"
else
    echo "  ERRORS:"; cat /tmp/env_err
fi
rm -f /tmp/env_err

echo ""
echo "=== Recreating backend to load the new value ==="
docker compose up -d --force-recreate backend 2>&1 | tail -4

for i in $(seq 1 20); do
    s=$(docker inspect --format='{{.State.Health.Status}}' tudienvannang-backend-1 2>/dev/null)
    [ "$s" = "healthy" ] && break
    sleep 3
done

echo ""
echo "=== Value seen by the running backend ==="
docker exec tudienvannang-backend-1 printenv APP_URL

echo ""
docker ps --format 'table {{.Names}}\t{{.Status}}'
REMOTE
