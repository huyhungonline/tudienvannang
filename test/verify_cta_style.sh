#!/bin/bash
# Confirm the CTA box now uses the same white background and border as book cards.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
CSS=$(docker exec tudienvannang-frontend-1 sh -c 'ls /usr/share/nginx/html/assets/*.css' 2>/dev/null | head -1)
echo "css: $CSS"
echo ""
echo "=== .mock-exam-cta rule as served ==="
docker exec tudienvannang-frontend-1 sh -c "grep -o '\.mock-exam-cta{[^}]*}' $CSS" 2>/dev/null | head -1
echo ""
echo "=== .book-item rule (for comparison) ==="
docker exec tudienvannang-frontend-1 sh -c "grep -o '\.book-item{[^}]*}' $CSS" 2>/dev/null | head -1
echo ""
echo "=== .btn-mock-exam-cta rule ==="
docker exec tudienvannang-frontend-1 sh -c "grep -o '\.btn-mock-exam-cta{[^}]*}' $CSS" 2>/dev/null | head -1
echo ""
echo "=== Gradient must be gone from the CTA ==="
n=$(docker exec tudienvannang-frontend-1 sh -c "grep -c -F 'linear-gradient(135deg,#1976d2' $CSS" 2>/dev/null | head -1)
n=${n:-0}
if [ "$n" -eq 0 ]; then echo "  absent   old gradient (correct)"; else echo "  STILL PRESENT  old gradient"; fi
echo ""
curl -s -o /dev/null -w "  https://taogiaoduc.com -> HTTP %{http_code}\n" --max-time 15 https://taogiaoduc.com/ 2>/dev/null
REMOTE
