#!/bin/bash
# Start app trên local
# Usage: wsl -e bash -c "cd /mnt/c/source/dic && bash start-local.sh"

echo "=== Starting Docker containers ==="
docker-compose up -d --build

echo ""
echo "=== Waiting for backend ready... ==="
for i in $(seq 1 30); do
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:4000/api/history/recent-public 2>/dev/null)
    if [ "$STATUS" = "200" ]; then
        echo "Backend ready!"
        break
    fi
    echo -n "."
    sleep 2
done

echo ""
echo "=== Chạy migrations ==="
POSTGRES_CONTAINER=$(docker ps --format '{{.Names}}' | grep postgres | head -1)
for f in backend-python/migrations/*.sql; do
    cat "$f" | docker exec -i "$POSTGRES_CONTAINER" psql -U postgres -d english_word_splitter 2>/dev/null
done

echo ""
WSL_IP=$(hostname -I | awk '{print $1}')
echo "=== App running ==="
echo "  WSL:     http://localhost:3000"
echo "  Windows: http://$WSL_IP:3000"
echo ""
echo "=== Quick check ==="
bash check.sh
