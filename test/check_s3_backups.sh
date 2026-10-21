#!/bin/bash
# Read-only report of backups currently stored in S3, plus lifecycle rule status.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
set -a; . ./.env; set +a
export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION="$AWS_REGION"

echo "=== Backups in s3://${S3_BACKUP_BUCKET}/postgres/ ==="
aws s3 ls "s3://${S3_BACKUP_BUCKET}/postgres/" --recursive --human-readable

echo ""
echo "=== Summary ==="
aws s3 ls "s3://${S3_BACKUP_BUCKET}/postgres/" --recursive --summarize | tail -2

echo ""
echo "=== Lifecycle rule ==="
aws s3api get-bucket-lifecycle-configuration --bucket "${S3_BACKUP_BUCKET}" 2>&1 | head -30

echo ""
echo "=== Local copies on VPS ==="
ls -lh /root/tudienvannang/backups/*.sql.gz 2>/dev/null || echo "(none)"

echo ""
echo "=== Cron schedule ==="
crontab -l | grep backup-db-s3 || echo "(not registered)"
echo "UTC now: $(date -u '+%Y-%m-%d %H:%M')   Local: $(date '+%H:%M %Z')"
REMOTE
