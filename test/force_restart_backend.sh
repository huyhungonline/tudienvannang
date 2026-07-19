#!/bin/bash
ssh root@14.225.198.235 << 'EOF'
cd /root/tudienvannang
docker-compose up -d --build --force-recreate backend
sleep 5
docker logs tudienvannang_backend_1 --tail 3
EOF
