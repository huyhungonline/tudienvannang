#!/bin/bash
ssh root@14.225.198.235 << 'EOF'
cd /root/tudienvannang
docker-compose down && docker-compose up -d
sleep 8
docker logs tudienvannang_backend_1 --tail 3
EOF
