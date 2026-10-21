#!/bin/bash
# Confirm which timezone cron uses on the VPS and when the backup will fire.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
echo "=== VPS timezone ==="
timedatectl 2>/dev/null | grep -E 'Time zone|Local time|Universal time'

echo ""
echo "=== Cron entry ==="
crontab -l | grep backup-db-s3

echo ""
echo "=== Interpretation ==="
echo "Cron uses the system local time shown above."
echo "Scheduled field '0 19' means 19:00 system local time."
echo ""
echo "Right now:"
echo "  system local : $(date '+%Y-%m-%d %H:%M %Z (%z)')"
echo "  UTC          : $(date -u '+%Y-%m-%d %H:%M UTC')"
echo "  Vietnam      : $(TZ=Asia/Ho_Chi_Minh date '+%Y-%m-%d %H:%M %Z')"

echo ""
echo "Next backup fires at 19:00 system local, which is:"
echo "  Vietnam time : $(TZ=Asia/Ho_Chi_Minh date -d 'today 19:00' '+%H:%M %Z' 2>/dev/null)"
REMOTE
