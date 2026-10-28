#!/bin/bash
# Gather the numbers that decide how many concurrent downloads the VPS can serve.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
echo "=== CPU / RAM ==="
echo "  cores: $(nproc)"
free -m | awk 'NR==2 {printf "  RAM: %d MB total, %d MB used, %d MB available\n", $2, $3, $7}'
echo "  load average (1/5/15 min): $(cut -d' ' -f1-3 /proc/loadavg)"

echo ""
echo "=== Network interface speed ==="
for i in $(ls /sys/class/net | grep -v lo); do
    s=$(cat /sys/class/net/$i/speed 2>/dev/null)
    echo "  $i: ${s:-unknown} Mbps"
done

echo ""
echo "=== nginx worker configuration (host, the TLS terminator) ==="
grep -E 'worker_processes|worker_connections|keepalive_timeout|sendfile|limit_rate|limit_conn' \
     /etc/nginx/nginx.conf 2>/dev/null | sed 's/^/  /'
echo "  effective worker processes: $(pgrep -c -f 'nginx: worker' 2>/dev/null)"

echo ""
echo "=== Any rate or connection limiting on the site? ==="
grep -rhE 'limit_rate|limit_conn|limit_req' /etc/nginx/sites-enabled/ 2>/dev/null | sed 's/^/  /' \
  || echo "  (none configured)"

echo ""
echo "=== Open file descriptor limits ==="
echo "  system max: $(cat /proc/sys/fs/file-max)"
echo "  nginx soft limit: $(cat /proc/$(pgrep -f 'nginx: master' | head -1)/limits 2>/dev/null | grep 'open files' | awk '{print $4}')"

echo ""
echo "=== Peak traffic seen so far (requests per minute, top 5) ==="
awk '{print $4}' /var/log/nginx/access.log 2>/dev/null \
  | cut -d: -f1-3 | sort | uniq -c | sort -rn | head -5 | sed 's/^/  /'

echo ""
echo "=== Busiest minute for the PDF specifically ==="
grep -h 'IT_Passport_Khoa_Hoc_Mien_Phi' /var/log/nginx/access.log* 2>/dev/null \
  | awk '{print $4}' | cut -d: -f1-3 | sort | uniq -c | sort -rn | head -3 | sed 's/^/  /'

echo ""
echo "=== Disk read throughput (how fast the file can be served from disk) ==="
docker exec tudienvannang-frontend-1 sh -c 'ls -l /usr/share/nginx/html/downloads/*.pdf' | awk '{print "  file size: "$5" bytes"}'
REMOTE
