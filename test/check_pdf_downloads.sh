#!/bin/bash
# Look for any record of PDF downloads: DB tables, nginx access logs, container logs.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
PG=$(docker ps --format '{{.Names}}' | grep postgres | head -1)

echo "=== 1. Any download-tracking table in the DB? ==="
docker exec "$PG" psql -U postgres -d english_word_splitter -tAc \
"SELECT COALESCE(string_agg(tablename, ', '), '(none)')
 FROM pg_tables WHERE schemaname='public'
 AND (tablename ILIKE '%download%' OR tablename ILIKE '%slide%' OR tablename ILIKE '%pdf%');"

echo ""
echo "=== 2. Is the file being served? ==="
docker exec tudienvannang-frontend-1 sh -c 'ls -lh /usr/share/nginx/html/downloads/ 2>/dev/null' || echo "  (no downloads dir in the image)"

echo ""
echo "=== 3. nginx access log inside the frontend container ==="
docker exec tudienvannang-frontend-1 sh -c 'ls -la /var/log/nginx/ 2>/dev/null' || echo "  (none)"

echo ""
echo "=== 4. Requests for the PDF in container logs (stdout) ==="
HITS=$(docker logs tudienvannang-frontend-1 2>&1 | grep -c -i 'IT_Passport_Khoa_Hoc_Mien_Phi' || true)
echo "  matches in frontend container log: ${HITS:-0}"
docker logs tudienvannang-frontend-1 2>&1 | grep -i 'IT_Passport_Khoa_Hoc_Mien_Phi' | tail -5 | sed 's/^/    /'

echo ""
echo "=== 5. Host nginx logs (the TLS terminator) ==="
ls -la /var/log/nginx/ 2>/dev/null | head -10 || echo "  (no host nginx)"
if ls /var/log/nginx/access.log* >/dev/null 2>&1; then
    echo ""
    echo "  Total PDF requests across all access logs:"
    zgrep -h -i 'IT_Passport_Khoa_Hoc_Mien_Phi' /var/log/nginx/access.log* 2>/dev/null | wc -l | sed 's/^/    /'
    echo "  Successful (HTTP 200) requests:"
    zgrep -h -i 'IT_Passport_Khoa_Hoc_Mien_Phi' /var/log/nginx/access.log* 2>/dev/null | grep -c ' 200 ' | sed 's/^/    /'
    echo "  Unique client IPs:"
    zgrep -h -i 'IT_Passport_Khoa_Hoc_Mien_Phi' /var/log/nginx/access.log* 2>/dev/null | awk '{print $1}' | sort -u | wc -l | sed 's/^/    /'
    echo ""
    echo "  Most recent requests:"
    zgrep -h -i 'IT_Passport_Khoa_Hoc_Mien_Phi' /var/log/nginx/access.log* 2>/dev/null | tail -5 | cut -c1-140 | sed 's/^/    /'
fi

echo ""
echo "=== 6. When was the PDF first deployed? ==="
git log --format='  %ad  %s' --date=short -1 -- frontend/public/downloads/ 2>/dev/null || echo "  (unknown)"
REMOTE
