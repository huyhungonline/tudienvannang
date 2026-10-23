#!/bin/bash
# Add APP_URL to the VPS .env so it is explicit rather than relying on the
# code default. Backs up the file first and leaves all other values untouched.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1

if grep -q '^APP_URL=' .env; then
    echo "APP_URL already present; nothing to do."
    exit 0
fi

cp .env ".env.bak.$(date +%Y%m%d_%H%M%S)"
printf 'APP_URL=https://jaenglish.com\n' >> .env
echo "Added APP_URL. Current value:"
grep '^APP_URL=' .env
REMOTE
