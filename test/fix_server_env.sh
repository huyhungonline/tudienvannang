#!/bin/bash
ssh root@14.225.198.235 << 'EOF'
cd /root/tudienvannang
sed -i 's/POSTGRES_PASSWORD=postgres/POSTGRES_PASSWORD=Dic@2024\$Pg!Secure/' .env
sed -i 's|postgresql://postgres:postgres@postgres:5432|postgresql://postgres:Dic@2024\$Pg!Secure@postgres:5432|' .env
cat .env | grep POSTGRES
docker-compose restart backend
EOF
