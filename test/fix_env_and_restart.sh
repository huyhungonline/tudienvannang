#!/bin/bash
ssh root@14.225.198.235 << 'EOF'
cd /root/tudienvannang
sed -i 's/POSTGRES_PASSWORD=postgres/POSTGRES_PASSWORD=DicSecure2024Pg/' .env
sed -i 's|postgres:postgres@postgres|postgres:DicSecure2024Pg@postgres|' .env
grep POSTGRES .env
docker-compose restart backend
sleep 5
docker logs tudienvannang_backend_1 --tail 3
EOF
