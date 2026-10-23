#!/bin/bash
# Deploy frontend-only changes: pull on VPS and rebuild just the frontend container.
# Leaves backend and postgres untouched (no DB restart, minimal downtime).
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1

echo "=== Pulling latest code ==="
git pull origin main

echo ""
echo "=== Verifying new BooksPage arrived ==="
echo "btn-buy-book occurrences: $(grep -c 'btn-buy-book' frontend/src/pages/BooksPage.tsx 2>/dev/null || echo 0)"

echo ""
echo "=== Rebuilding frontend only ==="
docker compose up -d --build frontend

echo ""
echo "=== Containers ==="
docker ps --format 'table {{.Names}}\t{{.Status}}'
REMOTE
