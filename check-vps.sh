#!/bin/bash
# Check VPS security + fix common issues
# Usage: ssh root@14.225.198.235 'bash -s' < check-vps.sh

echo "=== [1] Security Check ==="

# Check for suspicious users in postgres
echo -n "Postgres suspicious users: "
SUSPICIOUS=$(docker exec tudienvannang_postgres_1 psql -U postgres -d english_word_splitter -t -c "SELECT usename FROM pg_user WHERE usename NOT IN ('postgres');" 2>/dev/null)
if [ -n "$SUSPICIOUS" ]; then
    echo "⚠️  FOUND: $SUSPICIOUS"
    echo "  Dropping suspicious users..."
    for user in $SUSPICIOUS; do
        docker exec tudienvannang_postgres_1 psql -U postgres -c "DROP USER IF EXISTS $user;" 2>/dev/null
        echo "  Dropped: $user"
    done
else
    echo "✅ Clean"
fi

# Check if port 5432 is exposed to internet
echo -n "Port 5432 exposed: "
if docker port tudienvannang_postgres_1 2>/dev/null | grep -q "0.0.0.0:5432"; then
    echo "⚠️  YES — Postgres is accessible from internet!"
    echo "  Fix: Remove 'ports: 5432:5432' from docker-compose.yml"
else
    echo "✅ Not exposed"
fi

# Check SSH brute force attempts
echo -n "SSH failed logins (last 24h): "
FAILED=$(journalctl -u ssh --since "24 hours ago" 2>/dev/null | grep -c "Failed password" || echo "0")
echo "$FAILED attempts"

echo ""
echo "=== [2] Fix: Remove Postgres Port Exposure ==="
cd /root/tudienvannang

# Remove port 5432 exposure from docker-compose (sed in-place)
if grep -q '"5432:5432"' docker-compose.yml; then
    sed -i '/"5432:5432"/d' docker-compose.yml
    # Also remove the 'ports:' line if it's now empty for postgres
    echo "✅ Removed port 5432 exposure from docker-compose.yml"
    echo "  Need to restart: docker-compose down && docker-compose up -d"
else
    echo "✅ Port 5432 already not exposed"
fi

echo ""
echo "=== [3] Fix: Reset Postgres (clean volume) ==="
echo "Running: docker-compose down -v && up -d + migrations..."

docker-compose down -v
docker-compose up -d
sleep 10

echo ""
echo "=== [4] Run Migrations ==="
for f in backend-python/migrations/*.sql; do
    echo -n "  $f: "
    cat "$f" | docker exec -i tudienvannang_postgres_1 psql -U postgres -d english_word_splitter 2>/dev/null && echo "OK" || echo "FAIL"
done

echo ""
echo "=== [5] Restart Backend ==="
docker restart tudienvannang_backend_1
sleep 5

echo ""
echo "=== [6] Final Check ==="
bash check.sh

echo ""
echo "=== [7] Security Recommendations ==="
echo "  1. Change VPS root password: passwd"
echo "  2. Consider disabling password SSH login (use key only)"
echo "  3. Install fail2ban: apt install fail2ban"
echo "  4. Postgres port 5432 should NOT be exposed to internet"
