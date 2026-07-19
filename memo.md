Kết nối được rồi thì đổi password bằng cách chạy lệnh SQL trong DBeaver hoặc SSH:

Cách 1: Trong DBeaver — mở SQL Editor, chạy:

ALTER USER postgres PASSWORD 'Dic@2024$Pg!Secure';
Cách 2: SSH trên server (đã SSH vào rồi):

docker exec -i tudienvannang_postgres_1 psql -U postgres -c "ALTER USER postgres PASSWORD 'DicSecure2024Pg';"
Sau đó update .env trên server:

sed -i 's/POSTGRES_PASSWORD=postgres/POSTGRES_PASSWORD=DicSecure2024Pg' /root/tudienvannang/.env
sed -i 's|postgresql://postgres:postgres@|postgresql://postgres:Dic@2024\$Pg!Secure@|' /root/tudienvannang/.env
Rồi restart backend:

cd /root/tudienvannang && docker-compose restart backend
Không mất data, chỉ đổi password.


