#!/bin/bash
# One-time setup on the VPS: install AWS CLI and register the daily backup cron job.
# Run from the project directory on the VPS:
#   bash setup-backup-cron.sh

set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CRON_SCHEDULE="0 19 * * *"   # 19:00 UTC = 02:00 UTC+7
CRON_LINE="${CRON_SCHEDULE} cd ${PROJECT_DIR} && /bin/bash ${PROJECT_DIR}/backup-db-s3.sh >> ${PROJECT_DIR}/backups/cron.log 2>&1"

echo "=== Installing AWS CLI (if missing) ==="
if command -v aws >/dev/null 2>&1; then
    echo "aws already installed: $(aws --version 2>&1)"
else
    apt-get update -qq
    apt-get install -y -qq awscli
    echo "Installed: $(aws --version 2>&1)"
fi

echo ""
echo "=== Checking cron daemon ==="
if ! command -v crontab >/dev/null 2>&1; then
    apt-get install -y -qq cron
fi
systemctl enable cron >/dev/null 2>&1 || true
systemctl start cron >/dev/null 2>&1 || true
echo "cron is active: $(systemctl is-active cron 2>/dev/null || echo unknown)"

echo ""
echo "=== Registering cron job ==="
mkdir -p "${PROJECT_DIR}/backups"
# Remove any previous entry for this script, then append the current one.
( crontab -l 2>/dev/null | grep -v 'backup-db-s3.sh' || true; echo "$CRON_LINE" ) | crontab -
echo "Installed:"
crontab -l | grep 'backup-db-s3.sh'

echo ""
echo "Setup done. Run a manual test with:"
echo "  bash ${PROJECT_DIR}/backup-db-s3.sh"
