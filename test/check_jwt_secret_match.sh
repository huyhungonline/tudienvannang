#!/bin/bash
# Compare JWT_SECRET between the local .env, the VPS .env, and the value the
# running backend container actually loaded. Prints only hashes, never secrets.
cd "$(dirname "$0")/.." || exit 1

echo "=== JWT_SECRET fingerprints (sha256, first 16 chars) ==="

local_val=$(grep -m1 '^JWT_SECRET=' .env | cut -d= -f2- | tr -d '\r"')
echo "local .env       : $(printf '%s' "$local_val" | sha256sum | cut -c1-16)"

ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
server_val=$(grep -m1 '^JWT_SECRET=' .env | cut -d= -f2- | tr -d '\r"')
echo "VPS .env         : $(printf '%s' "$server_val" | sha256sum | cut -c1-16)"

runtime_val=$(docker exec tudienvannang-backend-1 printenv JWT_SECRET 2>/dev/null)
echo "backend runtime  : $(printf '%s' "$runtime_val" | sha256sum | cut -c1-16)"

if [ "$server_val" = "$runtime_val" ]; then
    echo ""
    echo "VPS .env and running backend agree."
else
    echo ""
    echo "MISMATCH: backend is running an older JWT_SECRET than .env."
    echo "Existing tokens were issued with a different secret."
fi
REMOTE
