#!/bin/bash
# Xem logs các container trên VPS
# Usage: bash vps-logs.sh [số dòng]

LINES="${1:-50}"

ssh root@14.225.198.235 << REMOTE
cd /root/tudienvannang
echo "=== Docker containers ==="
docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo ""
echo "=== Backend logs (last $LINES lines) ==="
docker logs tudienvannang_backend_1 --tail $LINES 2>&1

echo ""
echo "=== Frontend logs (last $LINES lines) ==="
docker logs tudienvannang_frontend_1 --tail $LINES 2>&1

echo ""
echo "=== Postgres logs (last 20 lines) ==="
docker logs tudienvannang_postgres_1 --tail 20 2>&1
REMOTE
