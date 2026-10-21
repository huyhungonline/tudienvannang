#!/bin/bash
# Set AWS_REGION in .env to the bucket's actual region.
cd "$(dirname "$0")/.." || exit 1

NEW_REGION="${1:?usage: fix_aws_region.sh <region>}"

tr -d '\r' < .env > /tmp/env.fix
grep -v '^AWS_REGION=' /tmp/env.fix > /tmp/env.fix2
printf 'AWS_REGION=%s\n' "$NEW_REGION" >> /tmp/env.fix2
mv /tmp/env.fix2 .env
rm -f /tmp/env.fix

echo "AWS_REGION is now: $(grep -m1 '^AWS_REGION=' .env | cut -d= -f2-)"
