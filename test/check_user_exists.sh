#!/bin/bash
ssh root@14.225.198.235 << 'EOF'
docker exec -i tudienvannang_postgres_1 psql -U postgres -d english_word_splitter -c "SELECT id, email, is_admin FROM users;"
EOF
