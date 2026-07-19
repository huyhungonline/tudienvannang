#!/bin/bash
ssh root@14.225.198.235 << 'EOF'
docker logs tudienvannang_backend_1 2>&1 | grep -iE "forgot|reset|email|Error" | tail -20
EOF
