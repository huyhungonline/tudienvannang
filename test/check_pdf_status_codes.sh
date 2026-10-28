#!/bin/bash
# Break down the HTTP status codes for PDF requests.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
LOG=/var/log/nginx/access.log
PDF='IT_Passport_Khoa_Hoc_Mien_Phi'

echo "=== Status code breakdown ==="
# Field 9 in the combined log format is the status code.
grep -h "$PDF" $LOG* 2>/dev/null | awk '{print $9}' | sort | uniq -c | sort -rn | sed 's/^/  /'

echo ""
echo "=== Sample of each non-200 response ==="
for code in $(grep -h "$PDF" $LOG* 2>/dev/null | awk '{print $9}' | sort -u | grep -v '^200$'); do
    echo ""
    echo "--- HTTP $code ---"
    grep -h "$PDF" $LOG* 2>/dev/null | awk -v c="$code" '$9==c' | head -2 | cut -c1-200 | sed 's/^/  /'
done

echo ""
echo "=== Bytes sent per status (field 10) ==="
grep -h "$PDF" $LOG* 2>/dev/null \
  | awk '{sum[$9]+=$10; n[$9]++} END {for (c in sum) printf "  %s: %d requests, avg %.1f MB\n", c, n[c], sum[c]/n[c]/1048576}'

echo ""
echo "=== Are non-200s using Range requests? (partial downloads) ==="
echo "  Full file size on disk:"
docker exec tudienvannang-frontend-1 sh -c 'ls -l /usr/share/nginx/html/downloads/*.pdf' | awk '{print "    "$5" bytes"}'
REMOTE
