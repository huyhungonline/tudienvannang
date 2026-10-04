#!/bin/bash
# Lấy log lỗi trên VPS khi có sự cố (backend/frontend/postgres)
# Usage: bash check-log.sh [số dòng log gần nhất]
#   bash check-log.sh        # mặc định 100 dòng
#   bash check-log.sh 300    # lấy 300 dòng gần nhất

VPS_HOST="14.225.198.235"
VPS_USER="root"
LINES="${1:-100}"

ssh ${VPS_USER}@${VPS_HOST} "LINES=$LINES bash -s" << 'REMOTE'
cd /root/tudienvannang

POSTGRES_CONTAINER=$(docker ps --format '{{.Names}}' | grep postgres | head -1)
BACKEND_CONTAINER=$(docker ps --format '{{.Names}}' | grep backend | head -1)
FRONTEND_CONTAINER=$(docker ps --format '{{.Names}}' | grep frontend | head -1)

echo "========== CONTAINER STATUS =========="
docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo ""
echo "========== LỖI GẦN ĐÂY (backend) =========="
if [ -n "$BACKEND_CONTAINER" ]; then
    BACKEND_ERRORS=$(docker logs "$BACKEND_CONTAINER" --tail "$LINES" 2>&1 | grep -iE "error|exception|traceback|critical|fail")
    if [ -n "$BACKEND_ERRORS" ]; then
        echo "$BACKEND_ERRORS" | tail -50
    else
        echo "(Không tìm thấy dòng lỗi nào trong $LINES dòng log gần nhất)"
    fi
else
    echo "❌ Không tìm thấy container backend"
fi

echo ""
echo "========== LỖI GẦN ĐÂY (postgres) =========="
if [ -n "$POSTGRES_CONTAINER" ]; then
    docker logs "$POSTGRES_CONTAINER" --tail "$LINES" 2>&1 | grep -iE "error|fatal|panic" | tail -30
else
    echo "❌ Không tìm thấy container postgres"
fi

echo ""
echo "========== BACKEND LOG ĐẦY ĐỦ (tail $LINES) =========="
if [ -n "$BACKEND_CONTAINER" ]; then
    docker logs "$BACKEND_CONTAINER" --tail "$LINES" 2>&1
fi

echo ""
echo "========== FRONTEND LOG (tail 30) =========="
if [ -n "$FRONTEND_CONTAINER" ]; then
    docker logs "$FRONTEND_CONTAINER" --tail 30 2>&1
fi

echo ""
echo "========== DISK & MEMORY =========="
df -h / 2>/dev/null | tail -1
free -h 2>/dev/null | head -2

echo ""
echo "========== DONE =========="
REMOTE
