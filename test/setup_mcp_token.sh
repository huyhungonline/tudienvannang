#!/bin/bash
# Generate a strong MCP_TOKEN on the VPS and add it to .env if absent.
# Prints the token once so it can be pasted into the ChatGPT connector.
ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1

if grep -q '^MCP_TOKEN=' .env; then
    echo "MCP_TOKEN already present. Current value:"
    grep '^MCP_TOKEN=' .env
    exit 0
fi

cp .env ".env.bak.$(date +%Y%m%d_%H%M%S)"
TOKEN="mcp_$(openssl rand -hex 32)"
printf 'MCP_TOKEN=%s\n' "$TOKEN" >> .env

echo "Added MCP_TOKEN to .env:"
grep '^MCP_TOKEN=' .env
echo ""
echo "Keep this value private; it grants write access to the customer list."
REMOTE
