#!/bin/bash
# Compare local vs server state to show what has/hasn't been deployed.
cd "$(dirname "$0")/.." || exit 1

echo "=== LOCAL ==="
echo "HEAD   : $(git log --oneline -1)"
echo "Dirty  : $(git status --porcelain | wc -l) uncommitted file(s)"
echo "BooksPage new design present: $(grep -c 'btn-buy-book' frontend/src/pages/BooksPage.tsx)"

echo ""
echo "=== SERVER ==="
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
echo "HEAD   : $(git log --oneline -1)"
echo "BooksPage new design present: $(grep -c 'btn-buy-book' frontend/src/pages/BooksPage.tsx 2>/dev/null || echo 0)"
echo "Containers:"
docker ps --format '  {{.Names}}  {{.Status}}'
REMOTE
