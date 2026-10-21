#!/bin/bash
# Remove the connectivity probe object created by test_s3_access.sh.
# Scope: deletes only s3://<bucket>/_probe/connectivity.txt
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
set -a; . ./.env; set +a
export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION="$AWS_REGION"

echo "Before:"
aws s3 ls "s3://${S3_BACKUP_BUCKET}/_probe/" 2>/dev/null || echo "  (nothing)"

aws s3 rm "s3://${S3_BACKUP_BUCKET}/_probe/connectivity.txt" 2>&1 | head -2

echo "After:"
aws s3 ls "s3://${S3_BACKUP_BUCKET}/_probe/" 2>/dev/null || echo "  (nothing)"

echo ""
echo "Backups still present:"
aws s3 ls "s3://${S3_BACKUP_BUCKET}/postgres/" --recursive --human-readable
REMOTE
