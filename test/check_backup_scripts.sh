#!/bin/bash
# Syntax-check the backup/restore shell scripts.
cd "$(dirname "$0")/.." || exit 1
status=0
for f in backup-db-s3.sh restore-db-s3.sh setup-backup-cron.sh test/sync_mail_env.sh test/compare_env.sh; do
    if bash -n "$f" 2>/dev/null; then
        echo "OK   $f"
    else
        echo "FAIL $f"
        bash -n "$f"
        status=1
    fi
done
exit $status
