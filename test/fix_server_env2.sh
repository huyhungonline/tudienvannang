#!/bin/bash
ssh root@14.225.198.235 << 'EOF'
cd /root/tudienvannang
cat > .env << 'ENVFILE'
POSTGRES_USER=postgres
POSTGRES_PASSWORD=Dic@2024$Pg!Secure
POSTGRES_DB=english_word_splitter
DATABASE_URL=postgresql://postgres:Dic%402024%24Pg%21Secure@postgres:5432/english_word_splitter

RECAPTCHA_SECRET_KEY=6LcEBBUtAAAAAP7XdAvicSK5Nl7gCvc_iFDqB7P6
RECAPTCHA_SITE_KEY=6LcEBBUtAAAAAOOlUtYP_qfs_HTSb0O307a32orE

JWT_SECRET=your-jwt-secret-here

AUDIO_FILES_PATH=/audio
ENVFILE

echo "=== New .env ==="
cat .env
echo ""
echo "=== Restarting backend ==="
docker-compose restart backend
sleep 5
docker logs tudienvannang_backend_1 --tail 5
EOF
