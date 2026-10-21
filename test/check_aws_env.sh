#!/bin/bash
# Verify AWS backup vars exist in .env without printing their values.
cd "$(dirname "$0")/.." || exit 1

status=0
for k in AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_REGION S3_BACKUP_BUCKET; do
    v=$(grep -m1 "^${k}=" .env 2>/dev/null | cut -d= -f2- | tr -d '\r')
    if [ -z "$v" ]; then
        echo "MISSING  $k"
        status=1
    else
        case "$k" in
            AWS_REGION|S3_BACKUP_BUCKET)
                echo "OK       $k = $v"
                ;;
            *)
                echo "OK       $k is set (${#v} chars)"
                ;;
        esac
    fi
done
exit $status
