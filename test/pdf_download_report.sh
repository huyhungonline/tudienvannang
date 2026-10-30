#!/bin/bash
# Summary of PDF downloads: totals, unique visitors, daily trend.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
LOG=/var/log/nginx/access.log
PDF='IT_Passport_Khoa_Hoc_Mien_Phi'

echo "=== Totals ==="
TOTAL=$(grep -h "$PDF" $LOG* 2>/dev/null | wc -l)
OK=$(grep -h "$PDF" $LOG* 2>/dev/null | awk '$9==200' | wc -l)
IPS=$(grep -h "$PDF" $LOG* 2>/dev/null | awk '{print $1}' | sort -u | wc -l)
echo "  all requests        : $TOTAL"
echo "  completed (HTTP 200): $OK"
echo "  unique IP addresses : $IPS"

echo ""
echo "=== Downloads per day (HTTP 200 only) ==="
grep -h "$PDF" $LOG* 2>/dev/null | awk '$9==200 {print $4}' \
  | cut -d: -f1 | tr -d '[' | sort | uniq -c \
  | awk '{printf "  %-12s %3d\n", $2, $1}'

echo ""
echo "=== Unique visitors per day ==="
grep -h "$PDF" $LOG* 2>/dev/null | awk '$9==200 {d=$4; sub(/\[/,"",d); split(d,a,":"); print a[1], $1}' \
  | sort -u | awk '{c[$1]++} END {for (d in c) printf "  %-12s %3d\n", d, c[d]}' | sort

echo ""
echo "=== Where the clicks come from ==="
grep -h "$PDF" $LOG* 2>/dev/null | awk -F'"' '{print $4}' | sort | uniq -c | sort -rn | head -5 \
  | sed 's/^/  /'
REMOTE
