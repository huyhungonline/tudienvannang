#!/bin/bash
# List top-level prefixes/objects in the backup bucket (read-only).
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
set -a; . ./.env; set +a
export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION="$AWS_REGION"

echo "=== Top level of s3://${S3_BACKUP_BUCKET}/ ==="
aws s3 ls "s3://${S3_BACKUP_BUCKET}/"

echo ""
echo "=== Total object count and size ==="
aws s3 ls "s3://${S3_BACKUP_BUCKET}/" --recursive --summarize | tail -3

echo ""
echo "=== Versioning status ==="
aws s3api get-bucket-versioning --bucket "${S3_BACKUP_BUCKET}" --output text 2>&1 | head -2
REMOTE
