#!/bin/bash
# Confirm .env can be sourced without errors (what backup-db-s3.sh does).
cd "$(dirname "$0")/.." || exit 1

# Capture stderr to a file so sourcing happens in this shell, not a subshell.
set -a
. ./.env 2>/tmp/env_source_err
set +a

if [ -s /tmp/env_source_err ]; then
    echo "ERRORS while sourcing .env:"
    cat /tmp/env_source_err
    rm -f /tmp/env_source_err
    exit 1
fi
rm -f /tmp/env_source_err

echo "sourced with no errors"
echo "FROM_NAME         = [${FROM_NAME}]"
echo "S3_BACKUP_BUCKET  = [${S3_BACKUP_BUCKET}]"
echo "AWS_REGION        = [${AWS_REGION}]"
echo "POSTGRES_DB       = [${POSTGRES_DB}]"
