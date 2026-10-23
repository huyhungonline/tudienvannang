#!/bin/bash
# Deploy the backup script change and remove existing local dumps that are
# already safely stored in S3.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1

echo "=== Pulling ==="
git pull origin main || exit 1
echo "HEAD: $(git log --oneline -1)"

set -a; . ./.env; set +a
export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION="$AWS_REGION"

echo ""
echo "=== Verifying each local dump exists in S3 before deleting ==="
removed=0
kept=0
for f in backups/*.sql.gz; do
    [ -e "$f" ] || continue
    name=$(basename "$f")
    # Look the object up by name anywhere under postgres/
    if aws s3 ls "s3://${S3_BACKUP_BUCKET}/postgres/" --recursive | grep -q "$name"; then
        rm -f "$f"
        echo "  removed $name (confirmed in S3)"
        removed=$((removed+1))
    else
        echo "  KEPT    $name (NOT found in S3)"
        kept=$((kept+1))
    fi
done
echo "  removed: $removed, kept: $kept"

echo ""
echo "=== backups/ now ==="
ls -lh backups/ 2>/dev/null
du -sh backups/ 2>/dev/null

echo ""
echo "=== Disk ==="
df -h / | tail -1
REMOTE
