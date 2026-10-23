#!/bin/bash
# Fast diagnostic for API outage: container state, logs, endpoint checks, resources.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
echo "=== 1. Containers ==="
docker ps -a --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'

echo ""
echo "=== 2. Backend health from inside the network ==="
curl -s -o /dev/null -w "  backend:4000/api/health  -> %{http_code}\n" --max-time 10 http://localhost:4000/api/health
curl -s -o /dev/null -w "  backend:4000/api/books   -> %{http_code}\n" --max-time 10 http://localhost:4000/api/books

echo ""
echo "=== 3. Through nginx (public path) ==="
curl -s -o /dev/null -w "  https://jaenglish.com/            -> %{http_code}\n" --max-time 15 https://jaenglish.com/
curl -s -o /dev/null -w "  https://jaenglish.com/api/books   -> %{http_code}\n" --max-time 15 https://jaenglish.com/api/books
curl -s -o /dev/null -w "  https://jaenglish.com/api/health  -> %{http_code}\n" --max-time 15 https://jaenglish.com/api/health

echo ""
echo "=== 4. Backend logs (last 40) ==="
docker logs tudienvannang-backend-1 --tail 40 2>&1

echo ""
echo "=== 5. Resources ==="
df -h / | tail -1
free -m | head -2

echo ""
echo "=== 6. Postgres reachable? ==="
docker exec tudienvannang-postgres-1 pg_isready -U postgres 2>&1
REMOTE
