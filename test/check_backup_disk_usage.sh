#!/bin/bash
# Report what the backup job is actually leaving on disk.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1

echo "=== Retention setting in the deployed script ==="
grep -n 'RETAIN_LOCAL_DAYS' backup-db-s3.sh

echo ""
echo "=== Files in backups/ ==="
ls -lh backups/ 2>/dev/null

echo ""
echo "=== Space used by backups ==="
du -sh backups/ 2>/dev/null

echo ""
echo "=== Disk ==="
df -h / | tail -1

echo ""
echo "=== Objects in S3 ==="
set -a; . ./.env; set +a
export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION="$AWS_REGION"
aws s3 ls "s3://${S3_BACKUP_BUCKET}/postgres/" --recursive --human-readable | tail -5
aws s3 ls "s3://${S3_BACKUP_BUCKET}/postgres/" --recursive --summarize | tail -2
REMOTE
