#!/bin/bash
# Verify the redesigned Books page is actually being served in the built bundle.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1

echo "=== Containers ==="
docker ps --format 'table {{.Names}}\t{{.Status}}'

echo ""
echo "=== Served CSS bundle contains new classes? ==="
CSS=$(docker exec tudienvannang-frontend-1 sh -c 'ls /usr/share/nginx/html/assets/*.css' 2>/dev/null | head -1)
echo "bundle: $CSS"
for cls in book-grid btn-buy-book book-modal-overlay book-item-cover; do
    n=$(docker exec tudienvannang-frontend-1 sh -c "grep -c '$cls' $CSS" 2>/dev/null || echo 0)
    if [ "$n" != "0" ]; then
        echo "  FOUND    .$cls"
    else
        echo "  MISSING  .$cls"
    fi
done

echo ""
echo "=== Served JS bundle contains modal text? ==="
JS=$(docker exec tudienvannang-frontend-1 sh -c 'ls /usr/share/nginx/html/assets/index-*.js' 2>/dev/null | head -1)
n=$(docker exec tudienvannang-frontend-1 sh -c "grep -c 'Hãy liên hệ ngay' $JS" 2>/dev/null || echo 0)
[ "$n" != "0" ] && echo "  FOUND    modal heading text" || echo "  MISSING  modal heading text"
n=$(docker exec tudienvannang-frontend-1 sh -c "grep -c 'Liên hệ mua sách' $JS" 2>/dev/null || echo 0)
[ "$n" != "0" ] && echo "  FOUND    button label" || echo "  MISSING  button label"

echo ""
echo "=== Site responding ==="
curl -s -o /dev/null -w "  https://jaenglish.com -> HTTP %{http_code}\n" https://jaenglish.com/ 2>/dev/null
curl -s -o /dev/null -w "  /api/books        -> HTTP %{http_code}\n" http://localhost:4000/api/books 2>/dev/null
REMOTE
