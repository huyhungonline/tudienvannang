#!/bin/bash
# Verify S3 credentials and bucket write access from the VPS.
# Uploads a tiny probe object, reads it back, and reports what works.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
set -a
. ./.env
set +a
export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION="$AWS_REGION"

echo "Bucket: $S3_BACKUP_BUCKET   Region: $AWS_REGION"
echo ""

echo "--- 1. Identity ---"
aws sts get-caller-identity --query 'Arn' --output text 2>&1 | head -3

echo ""
echo "--- 2. Bucket reachable (ListBucket) ---"
aws s3 ls "s3://${S3_BACKUP_BUCKET}/" 2>&1 | head -5 && echo "ListBucket OK"

echo ""
echo "--- 3. Write test (PutObject) ---"
echo "probe $(date -u +%FT%TZ)" > /tmp/s3probe.txt
if aws s3 cp /tmp/s3probe.txt "s3://${S3_BACKUP_BUCKET}/_probe/connectivity.txt" --only-show-errors 2>&1; then
    echo "PutObject OK"
else
    echo "PutObject FAILED"
fi

echo ""
echo "--- 4. Read back (GetObject) ---"
if aws s3 cp "s3://${S3_BACKUP_BUCKET}/_probe/connectivity.txt" /tmp/s3probe.down --only-show-errors 2>&1; then
    echo "GetObject OK: $(cat /tmp/s3probe.down)"
else
    echo "GetObject FAILED"
fi

rm -f /tmp/s3probe.txt /tmp/s3probe.down
REMOTE
