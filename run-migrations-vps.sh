#!/bin/bash
# Run all migrations on VPS
ssh root@14.225.198.235 << 'EOF'
cd /root/tudienvannang
PG_CONTAINER=$(docker ps --format '{{.Names}}' | grep postgres | head -1)
echo "Using container: $PG_CONTAINER"
for f in backend-python/migrations/*.sql; do
    echo "Running: $f"
    cat "$f" | docker exec -i "$PG_CONTAINER" psql -U postgres -d english_word_splitter 2>/dev/null || true
done
echo ""
echo "=== Containers ==="
docker ps --format "table {{.Names}}\t{{.Status}}"
EOF
