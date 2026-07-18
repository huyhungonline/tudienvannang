Có cách đổi password mà không mất data: SSH vào server, vào container postgres chạy lệnh ALTER USER trực tiếp:

ssh root@14.225.198.235 "docker exec -i tudienvannang_postgres_1 psql -U postgres -c \"ALTER USER postgres PASSWORD 'Dic@2024\$Pg!Secure';\""
Sau đó chỉ cần update .env trên VPS với password mới và restart backend (không cần xóa volume).