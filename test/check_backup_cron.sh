#!/bin/bash
# Report the backup cron job status on the VPS.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
echo "cron service : $(systemctl is-active cron 2>/dev/null)"
echo "cron enabled : $(systemctl is-enabled cron 2>/dev/null)"
echo ""
echo "--- crontab ---"
crontab -l
echo ""
echo "--- next run (UTC now / local now) ---"
echo "UTC   : $(date -u '+%Y-%m-%d %H:%M')"
echo "Local : $(date '+%Y-%m-%d %H:%M %Z')"
echo ""
echo "--- backups directory ---"
ls -lh /root/tudienvannang/backups/ 2>/dev/null || echo "(empty)"
echo ""
echo "--- recent log ---"
tail -5 /root/tudienvannang/backups/backup.log 2>/dev/null || echo "(no log yet)"
echo ""
echo "--- disk ---"
df -h / | tail -1
echo ""
echo "--- objects in S3 ---"
cd /root/tudienvannang
set -a; . ./.env; set +a
export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION="$AWS_REGION"
aws s3 ls "s3://${S3_BACKUP_BUCKET}/postgres/" --recursive --human-readable
REMOTE
