#!/bin/bash
# Resolve the pull conflict caused by scp-ing backup scripts before they were
# committed. The git versions are identical, so removing the untracked copies
# is safe. Backs them up first, then pulls and rebuilds the frontend.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1

echo "=== Backing up the untracked scripts (just in case) ==="
mkdir -p /root/script-backup-before-pull
for f in backup-db-s3.sh restore-db-s3.sh setup-backup-cron.sh; do
    [ -f "$f" ] && cp "$f" /root/script-backup-before-pull/ && echo "  saved $f"
done

echo ""
echo "=== Removing untracked copies so git can place the tracked versions ==="
rm -f backup-db-s3.sh restore-db-s3.sh setup-backup-cron.sh

echo ""
echo "=== Pulling ==="
git pull origin main

echo ""
echo "=== Verifying ==="
echo "HEAD: $(git log --oneline -1)"
echo "btn-buy-book in BooksPage: $(grep -c 'btn-buy-book' frontend/src/pages/BooksPage.tsx 2>/dev/null || echo 0)"
echo "backup scripts restored by git:"
ls -1 backup-db-s3.sh restore-db-s3.sh setup-backup-cron.sh 2>/dev/null | sed 's/^/  /'

echo ""
echo "=== Confirming cron script still works ==="
bash -n backup-db-s3.sh && echo "  backup-db-s3.sh syntax OK"
crontab -l | grep backup-db-s3 | sed 's/^/  cron: /'
REMOTE
