#!/bin/bash
# Check containers status and test APIs
# Usage: wsl -e bash -c "cd /mnt/c/source/dic && bash check.sh"

echo "========== CONTAINER STATUS =========="
docker ps -a --filter name=dic --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo ""
echo "========== HEALTH CHECKS =========="

# Wait for services to be ready
sleep 2

# Check backend health
echo -n "Backend (port 4000): "
BACKEND=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:4000/api/words/split -X POST -H "Content-Type: application/json" -d '{"text":"hello","targetLanguage":"ja"}' 2>/dev/null)
if [ "$BACKEND" = "200" ]; then
  echo "✅ OK ($BACKEND)"
else
  echo "❌ FAIL ($BACKEND)"
fi

# Check frontend
echo -n "Frontend (port 3000): "
FRONTEND=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/ 2>/dev/null)
if [ "$FRONTEND" = "200" ]; then
  echo "✅ OK ($FRONTEND)"
else
  echo "❌ FAIL ($FRONTEND)"
fi

# Check frontend proxy to backend
echo -n "Frontend -> Backend proxy: "
PROXY=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/api/words/split -X POST -H "Content-Type: application/json" -d '{"text":"test","targetLanguage":"ja"}' 2>/dev/null)
if [ "$PROXY" = "200" ]; then
  echo "✅ OK ($PROXY)"
else
  echo "❌ FAIL ($PROXY)"
fi

# Check recent-public API
echo -n "Recent public history API: "
RECENT=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:4000/api/history/recent-public 2>/dev/null)
if [ "$RECENT" = "200" ]; then
  echo "✅ OK ($RECENT)"
else
  echo "❌ FAIL ($RECENT)"
fi

# Check postgres
echo -n "Postgres: "
PG=$(docker exec dic-postgres-1 pg_isready -U postgres 2>/dev/null)
if echo "$PG" | grep -q "accepting"; then
  echo "✅ OK"
else
  echo "❌ FAIL"
fi

echo ""
echo "========== SAMPLE SPLIT RESPONSE =========="
curl -s http://localhost:4000/api/words/split -X POST -H "Content-Type: application/json" -d '{"text":"hello world","targetLanguage":"ja"}' | python3 -m json.tool 2>/dev/null || echo "❌ Could not get response"

echo ""
echo "========== CSS LAYOUT CHECK =========="
# Fetch the CSS file from frontend and check grid layout
CSS_CONTENT=$(curl -s http://localhost:3000/ 2>/dev/null)
CSS_FILE=$(echo "$CSS_CONTENT" | grep -oP 'href="/assets/[^"]+\.css"' | head -1 | grep -oP '/assets/[^"]+\.css')
if [ -n "$CSS_FILE" ]; then
  LAYOUT=$(curl -s "http://localhost:3000${CSS_FILE}" 2>/dev/null | grep -oP 'grid-template-columns:\s*[^;}]+' | head -1)
  if echo "$LAYOUT" | grep -q "1fr 1fr"; then
    echo "Homepage layout: ✅ OK (1fr 1fr)"
  else
    echo "Homepage layout: ❌ WRONG ($LAYOUT) — expected: 1fr 1fr"
  fi
  
  # Check no-cache headers
  CACHE_HEADER=$(curl -sI "http://localhost:3000${CSS_FILE}" 2>/dev/null | grep -i "cache-control")
  if echo "$CACHE_HEADER" | grep -qi "no-cache"; then
    echo "CSS cache: ✅ Disabled (no-cache)"
  else
    echo "CSS cache: ⚠️  May be cached ($CACHE_HEADER)"
  fi
else
  echo "CSS file: ❌ Not found in HTML"
fi

echo ""
echo "========== DONE =========="
