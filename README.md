# Táo Giáo Dục

## Quy tắc triển khai

Mọi lần triển khai code lên VPS phải chạy `deploy.sh` từ thư mục gốc dự án trong WSL:

```bash
bash deploy.sh "Mô tả thay đổi"
```

- Kiểm tra diff và chạy kiểm tra phù hợp trước khi deploy. Script sẽ `git add .`, commit, push lên `origin/main`, rồi VPS pull code và build lại Docker, chạy migrations.
- Không chép code trực tiếp lên VPS bằng SCP để thay thế quy trình này. Code triển khai phải có trên GitHub để máy khác có thể pull được.
- Giữ nguyên `.env` trên VPS; không chép `.env` local đè lên cấu hình server. Không commit mật khẩu hoặc thông tin bí mật.
- Thư mục `output/` chứa các file xuất, dữ liệu cá nhân và công cụ chạy riêng, được bỏ qua bằng `.gitignore`; không đưa lên GitHub.
- Nếu VPS còn code chưa commit từ lần triển khai cũ, sao lưu và đối chiếu trước khi đồng bộ. Không bỏ mất thay đổi trên server.
- Sau triển khai, kiểm tra commit trên VPS trùng `origin/main`, trạng thái container và website hoạt động.
