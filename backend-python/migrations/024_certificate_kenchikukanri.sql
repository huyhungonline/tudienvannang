-- Certificates feature: kenchikukanri (xaydung category) — generated from
-- doccument/kenchikukanri/sach_on_tap_Nhat_Viet.md via a one-off parsing script

INSERT INTO certificates (code, category, name_ja, name_vi)
VALUES ('kenchikukanri', 'xaydung', '建築施工管理技士 2級', 'Kỹ sư quản lý thi công xây dựng 2級')
ON CONFLICT (code) DO NOTHING;

DO $$
DECLARE cert_id INT;
BEGIN
    SELECT id INTO cert_id FROM certificates WHERE code = 'kenchikukanri';
    DELETE FROM certificate_vocabulary WHERE certificate_id = cert_id;

    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'JIS', 'ジェーアイエス', 'Tiêu chuẩn công nghiệp Nhật Bản', '', '', '', 1);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'RC', 'アールシー', 'Bê tông cốt thép', '', '', '', 2);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ALC', 'エーエルシー', 'Bê tông khí chưng áp nhẹ', '', '', '', 3);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'MDF', 'エムディーエフ', 'Tấm sợi mật độ trung bình', '', '', '', 4);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'PBX', 'ピービーエックス', 'Tổng đài điện thoại nội bộ', '', '', '', 5);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'CAD', 'キャド', 'Thiết kế có hỗ trợ máy tính', '', '', '', 6);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'QC', 'キューシー', 'Kiểm soát chất lượng', '', '', '', 7);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'PDCA', 'ピーディーシーエー', 'Plan–Do–Check–Act: kế hoạch, thực hiện, kiểm tra, xử lý', '', '', '', 8);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'QCDSE', 'キューシーディーエスイー', 'Chất lượng, chi phí, thời hạn, an toàn, môi trường', '', '', '', 9);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ISO 14000', 'アイエスオーいちまんよんせん', 'Họ tiêu chuẩn quản lý môi trường', '', '', '', 10);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'AE', 'エーイー', 'Cuốn khí; xuất hiện trong phụ gia AE giảm nước', '', '', '', 11);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'SN400B', 'エスエヌよんひゃくビー', 'Mác thép cán dùng cho kết cấu xây dựng trong đề', '', '', '', 12);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'SSC', 'エスエスシー', 'Thép hình nhẹ dùng cho kết cấu thông thường', '', '', '', 13);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'STKN', 'エスティーケーエヌ', 'Ống thép carbon dùng cho kết cấu xây dựng', '', '', '', 14);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ST杭', 'エスティーぐい', 'Cọc có tiết diện mở rộng', '', '', '', 15);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'SC杭', 'エスシーぐい', 'Cọc bê tông có ống thép ngoài', '', '', '', 16);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'dB', 'デシベル', 'Decibel, đơn vị mức âm', '', '', '', 17);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'kN', 'キロニュートン', 'Kilonewton, đơn vị lực', '', '', '', 18);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'N/mm²', 'ニュートンまいへいほうミリメートル', 'Đơn vị ứng suất/cường độ', '', '', '', 19);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'タスク・アンビエント照明', 'タスク・アンビエントしょうめい', 'Chiếu sáng cục bộ công việc kết hợp chiếu sáng chung', '', '', '', 20);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'マスキング', 'マスキング', 'Che lấp âm', '', '', '', 21);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'フラッターエコー', 'フラッターエコー', 'Âm phản xạ lặp giữa bề mặt đối diện', '', '', '', 22);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ヤング係数', 'ヤングけいすう', 'Môđun đàn hồi Young', '', '', '', 23);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ポアソン比', 'ポアソンひ', 'Hệ số Poisson', '', '', '', 24);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ガセットプレート', 'ガセットプレート', 'Bản nút', '', '', '', 25);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'エンドタブ', 'エンドタブ', 'Bản dẫn đầu/cuối mối hàn', '', '', '', 26);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'スプライスプレート', 'スプライスプレート', 'Bản nối', '', '', '', 27);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ダイアフラム', 'ダイアフラム', 'Vách truyền lực ở nút dầm–cột', '', '', '', 28);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'フィラープレート', 'フィラープレート', 'Bản chêm bù chênh chiều dày', '', '', '', 29);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'スタッド', 'スタッド', 'Đinh hàn liên kết dầm–sàn', '', '', '', 30);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ターンバックル', 'ターンバックル', 'Tăng đơ', '', '', '', 31);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'セパレータ', 'セパレータ', 'Thanh giữ khoảng cách ván khuôn', '', '', '', 32);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'コラムクランプ', 'コラムクランプ', 'Đai kẹp ván khuôn cột', '', '', '', 33);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'セルフレベリング', 'セルフレベリング', 'Tự san phẳng', '', '', '', 34);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'キュービクル', 'キュービクル', 'Tủ trạm nhận điện/biến áp', '', '', '', 35);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'インバート', 'インバート', 'Rãnh dẫn dòng trong hố nước thải', '', '', '', 36);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ベンチマーク', 'ベンチマーク', 'Mốc cao độ', '', '', '', 37);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'プライマー', 'プライマー', 'Lớp lót tăng bám dính', '', '', '', 38);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'プライムコート', 'プライムコート', 'Lớp nhựa tưới thấm trên móng đường', '', '', '', 39);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'タックコート', 'タックコート', 'Lớp nhựa dính bám giữa các lớp mặt đường', '', '', '', 40);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'グレイジングチャンネル', 'グレイジングチャンネル', 'Gioăng kênh ôm cạnh kính', '', '', '', 41);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'セッティングブロック', 'セッティングブロック', 'Miếng kê kính', '', '', '', 42);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'エフロレッセンス', 'エフロレッセンス', 'Hiện tượng kết tinh muối trắng', '', '', '', 43);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'トレーサビリティ', 'トレーサビリティ', 'Khả năng truy xuất', '', '', '', 44);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'サンプリング', 'サンプリング', 'Lấy mẫu', '', '', '', 45);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ロット', 'ロット', 'Lô kiểm soát', '', '', '', 46);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ダミー', 'ダミー', 'Công việc giả có thời lượng bằng 0', '', '', '', 47);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'フロート', 'フロート', 'Độ dự trữ thời gian', '', '', '', 48);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'クリティカルパス', 'クリティカルパス', 'Đường găng', '', '', '', 49);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', 'Mẫu câu tiếng Nhật', 'Cách đọc bằng kana', 'Nghĩa tiếng Việt / cách xử lý', '', '', '', 50);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '最も不適当なものはどれか。', 'もっともふてきとうなものはどれか。', 'Chọn phát biểu không thích hợp nhất; tìm nội dung sai.', '', '', '', 51);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '不適当なものはどれか。', 'ふてきとうなものはどれか。', 'Chọn phát biểu không thích hợp.', '', '', '', 52);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '正しいものはどれか。', 'ただしいものはどれか。', 'Chọn nội dung đúng, không chọn phát biểu sai.', '', '', '', 53);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '誤っているものはどれか。', 'あやまっているものはどれか。', 'Chọn phát biểu sai.', '', '', '', 54);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '最も関係の少ないものはどれか。', 'もっともかんけいのすくないものはどれか。', 'Chọn cặp hoặc thuật ngữ ít liên quan nhất.', '', '', '', 55);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '定められていないものはどれか。', 'さだめられていないものはどれか。', 'Tìm mục không được luật/quy định nêu.', '', '', '', 56);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '必要がないものはどれか。', 'ひつようがないものはどれか。', 'Chọn trường hợp không cần thực hiện nghĩa vụ đang hỏi.', '', '', '', 57);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', 'ただし，〈内容〉とする。', 'ただし，〈ないよう〉とする。', 'Với điều kiện〈nội dung〉; giữ điều kiện khi chọn công thức/quy định.', '', '', '', 58);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '〈内容〉に関する記述として', '〈ないよう〉にかんするきじゅつとして', 'Xét các phát biểu liên quan đến〈nội dung〉', '', '', '', 59);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '［a］に当てはまる語句', '［エー］にあてはまるごく', 'Từ thích hợp điền vào ô ［a］; xem cả ngữ pháp và kỹ thuật.', '', '', '', 60);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '図に示す', 'ずにしめす', 'Được thể hiện trong hình; đọc đủ nhãn và số liệu.', '', '', '', 61);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '値の大きさ', 'あたいのおおきさ', 'Độ lớn giá trị; phân biệt độ lớn với dấu của đại lượng.', '', '', '', 62);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '〈内容〉以上／〈内容〉以下／〈内容〉未満／〈内容〉を超える', '〈ないよう〉いじょう／〈ないよう〉いか／〈ないよう〉みまん／〈ないよう〉をこえる', '≥ / ≤ / < / >; chú ý có hay không lấy giá trị biên.', '', '', '', 63);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '〈内容〉に係わらず', '〈ないよう〉にかかわらず', 'Bất kể〈nội dung〉; kiểm tra xem đại lượng có thực sự độc lập hay không.', '', '', '', 64);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '原則として', 'げんそくとして', 'Về nguyên tắc; phân biệt nguyên tắc với ngoại lệ.', '', '', '', 65);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '〈内容〉を除くものとする', '〈ないよう〉をのぞくものとする', 'Loại trừ〈nội dung〉; không dùng quy định của nhóm đã bị loại.', '', '', '', 66);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '全問題を解答してください。', 'ぜんもんだいをかいとうしてください。', 'Trả lời toàn bộ câu thuộc nhóm chỉ định.', '', '', '', 67);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '〈内容〉問題を選択し，解答してください。', '〈ないよう〉もんだいをせんたくし，かいとうしてください。', 'Chọn đúng số câu quy định rồi trả lời.', '', '', '', 68);
END $$;

DO $$
DECLARE cert_id INT;
BEGIN
    SELECT id INTO cert_id FROM certificates WHERE code = 'kenchikukanri';
    DELETE FROM certificate_exam_questions WHERE certificate_id = cert_id;

    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Management', 1, '照明に関する記述として，最も不適当なものはどれか。

1．天井や壁等の建築部位と一体化した照明方式を，建築化照明という。

2．全般照明と局部照明を併せて行う照明方式を，タスク・アンビエント照明という。

3．単位面積当たりから放射する光束の量を，照度という。

4．照明対象となる範囲外に照射されるような漏れ光によって引き起こされる障害のことを，光害という。', 'Về chiếu sáng, phát biểu nào không thích hợp nhất?

1. Phương thức chiếu sáng tích hợp với các bộ phận kiến trúc như trần và tường được gọi là chiếu sáng kiến trúc tích hợp.

2. Phương thức kết hợp chiếu sáng chung và chiếu sáng cục bộ được gọi là chiếu sáng task–ambient.

3. Lượng quang thông phát ra trên một đơn vị diện tích được gọi là độ rọi.

4. Sự gây hại do ánh sáng lọt ra ngoài phạm vi đối tượng cần chiếu sáng được gọi là ô nhiễm ánh sáng.', NULL, '3', 'Đề yêu cầu chọn phát biểu không thích hợp. Độ rọi là quang thông tới trên một đơn vị diện tích, E = Φ/A, đơn vị lx. Quang thông phát ra trên một đơn vị diện tích là độ trưng, không phải độ rọi. Phân biệt ánh sáng tới và ánh sáng phát ra; các lựa chọn 1, 2, 4 mô tả đúng khái niệm.', '[{"term": "照度", "reading": "しょうど", "meaning": "Độ rọi"}, {"term": "光束", "reading": "こうそく", "meaning": "Quang thông"}, {"term": "光害", "reading": "ひかりがい", "meaning": "Ô nhiễm ánh sáng"}]'::jsonb, 1);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Management', 2, '鉄筋コンクリート構造に関する記述として，最も不適当なものはどれか。

1．大梁の主筋は，引張力だけでなく圧縮力に対しても有効に働く。

2．床スラブの配筋において，主筋はスラブの長辺方向に，配力筋は短辺方向に配筋する。

3．梁の幅止め筋は，腹筋間に架け渡したもので，あばら筋の振れ止め及びはらみ止めの働きをする。

4．柱の主筋に必要な定着長さは，一般にコンクリートの設計基準強度が高くなるにつれて，短くなる。', 'Về kết cấu bê tông cốt thép, phát biểu nào không thích hợp nhất?

1. Cốt thép chủ của dầm chính làm việc hữu hiệu đối với cả lực kéo và lực nén.

2. Khi bố trí thép bản sàn, cốt thép chủ đặt theo phương cạnh dài, còn cốt thép phân bố đặt theo phương cạnh ngắn.

3. Thép giữ bề rộng dầm được đặt nối giữa các thanh thép cấu tạo bên hông, có tác dụng chống xê dịch và phình của cốt đai.

4. Chiều dài neo cần thiết của cốt thép chủ cột nói chung ngắn dần khi cường độ thiết kế của bê tông tăng.', NULL, '2', 'Phương chịu lực chủ yếu của bản sàn thông thường là phương nhịp ngắn: thép chủ theo cạnh ngắn, thép phân bố theo cạnh dài. Lựa chọn 2 đảo hai phương. Không áp dụng kết luận này một cách máy móc cho mọi bản hai phương; ở đây xét cách bố trí cơ bản của đề.', '[{"term": "主筋", "reading": "しゅきん", "meaning": "Cốt thép chủ"}, {"term": "配力筋", "reading": "はいりょくきん", "meaning": "Cốt thép phân bố"}, {"term": "定着長さ", "reading": "ていちゃくながさ", "meaning": "Chiều dài neo"}]'::jsonb, 2);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Management', 3, '図に示す単純梁ABのAC間に等分布荷重wが作用したとき，BC間に生じるせん断力の値の大きさとして，正しいものはどれか。

1．1kN

2．2kN

3．3kN

4．6kN

![Hình câu 3, năm 2025](images/2025_cau_03.png)', 'Khi tải phân bố đều w tác dụng trên đoạn AC của dầm đơn giản AB trong hình, giá trị nào đúng cho độ lớn lực cắt trên đoạn BC?

Dữ liệu hình: w = 3 kN/m; AC = 2 m; CB = 4 m. A và B là hai gối tựa, C là điểm kết thúc tải phân bố.

1. 1 kN

2. 2 kN

3. 3 kN

4. 6 kN', NULL, '1', 'Tổng tải W = 3 × 2 = 6 kN, đặt cách A 1 m. Lấy mômen quanh A: R_B × 6 = 6 × 1, nên R_B = 1 kN và R_A = 5 kN. Trên BC không có tải, lực cắt V = 5 − 6 = −1 kN, độ lớn là 1 kN. Đề hỏi độ lớn nên không chọn theo dấu âm.', '[{"term": "単純梁", "reading": "たんじゅんばり", "meaning": "Dầm đơn giản"}, {"term": "等分布荷重", "reading": "とうぶんぷかじゅう", "meaning": "Tải phân bố đều"}, {"term": "せん断力", "reading": "せんだんりょく", "meaning": "Lực cắt"}]'::jsonb, 3);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Management', 4, '鋼材に関する記述として，最も不適当なものはどれか。

1．ヤング係数は，常温では強度に係わらずほぼ一定である。

2．建築構造用圧延鋼材SN400Bの引張強さの下限値は，400N/mm²である。

3．炭素含有量が多くなると，溶接性は低下する。

4．約1,000℃で融解する。', 'Về thép, phát biểu nào không thích hợp nhất?

1. Ở nhiệt độ thường, môđun Young gần như không đổi, không phụ thuộc vào cường độ.

2. Giới hạn dưới của độ bền kéo thép cán dùng cho kết cấu xây dựng SN400B là 400 N/mm².

3. Khi hàm lượng carbon tăng, tính hàn giảm.

4. Thép nóng chảy ở khoảng 1.000 ℃.', NULL, '4', 'Thép xây dựng thường nóng chảy ở khoảng 1.400–1.500 ℃, tùy thành phần; 1.000 ℃ quá thấp. Đừng nhầm nhiệt độ bắt đầu suy giảm khả năng chịu lực với nhiệt độ nóng chảy: thép đã giảm cường độ đáng kể trước khi chảy.', '[{"term": "鋼材", "reading": "こうざい", "meaning": "Vật liệu thép"}, {"term": "引張強さ", "reading": "ひっぱりつよさ", "meaning": "Độ bền kéo"}, {"term": "溶接性", "reading": "ようせつせい", "meaning": "Tính hàn"}]'::jsonb, 4);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Management', 5, '冬季における一般的な結露対策に関する記述として，最も不適当なものはどれか。

1．外壁の室内側の表面結露を防止するためには，熱橋となる部分に断熱材を施す。

2．外壁の室内側の表面結露を防止するためには，居室の気密性を高め，絶対湿度を高くする。

3．外壁の壁体内の結露を防止するためには，外断熱にする。

4．二重サッシ間の結露を防止するためには，室内側サッシの気密性を高くする。', 'Về biện pháp chống ngưng tụ thông thường vào mùa đông, phát biểu nào không thích hợp nhất?

1. Để ngăn ngưng tụ trên bề mặt phía trong tường ngoài, bố trí vật liệu cách nhiệt ở các bộ phận tạo cầu nhiệt.

2. Để ngăn ngưng tụ trên bề mặt phía trong tường ngoài, tăng độ kín khí của phòng ở và tăng độ ẩm tuyệt đối.

3. Để ngăn ngưng tụ bên trong tường ngoài, sử dụng cách nhiệt phía ngoài.

4. Để ngăn ngưng tụ giữa hai lớp cửa sổ, tăng độ kín khí của lớp cửa phía trong.', NULL, '2', 'Tăng độ ẩm tuyệt đối làm tăng điểm sương và nguy cơ ngưng tụ. Cần giảm lượng hơi nước bằng thông gió hoặc hút ẩm, đồng thời giữ nhiệt độ bề mặt đủ cao. Độ kín khí tự nó không thay thế việc kiểm soát độ ẩm.', '[{"term": "結露", "reading": "けつろ", "meaning": "Ngưng tụ"}, {"term": "熱橋", "reading": "ねっきょう", "meaning": "Cầu nhiệt"}, {"term": "絶対湿度", "reading": "ぜったいしつど", "meaning": "Độ ẩm tuyệt đối"}]'::jsonb, 5);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Management', 6, '音の一般的な性質に関する記述として，最も不適当なものはどれか。

1．塀等の障壁の裏側に音が回り込む現象は，周波数の高い音のほうが起こりやすい。

2．音波は，空気の粒子が音波の進行方向と同じ方向に振動する縦波である。

3．ある音が他の音によって聞こえにくくなる現象を，マスキング効果という。

4．室内の仕上げが同じ場合，室の容積が大きいほど残響時間は長くなる。', 'Về tính chất thông thường của âm, phát biểu nào không thích hợp nhất?

1. Hiện tượng âm vòng ra phía sau vật cản như hàng rào dễ xảy ra hơn với âm có tần số cao.

2. Sóng âm là sóng dọc, trong đó các phần tử không khí dao động cùng phương với hướng truyền sóng.

3. Hiện tượng một âm bị âm khác làm khó nghe được gọi là hiệu ứng che lấp.

4. Khi vật liệu hoàn thiện phòng giống nhau, thể tích phòng càng lớn thì thời gian âm vang càng dài.', NULL, '1', 'Nhiễu xạ qua vật cản dễ xảy ra với bước sóng dài, tức tần số thấp, vì λ = c/f. Lựa chọn 1 đảo quan hệ này. Che lấp âm và âm vang là hai hiện tượng khác với nhiễu xạ.', '[{"term": "周波数", "reading": "しゅうはすう", "meaning": "Tần số"}, {"term": "縦波", "reading": "たてなみ", "meaning": "Sóng dọc"}, {"term": "残響時間", "reading": "ざんきょうじかん", "meaning": "Thời gian âm vang"}]'::jsonb, 6);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Management', 7, '鉄骨構造の一般的な特徴に関する記述として，鉄筋コンクリート構造と比較した場合，最も不適当なものはどれか。

1．構造体の剛性が大きいため，振動障害が生じにくい。

2．大スパンの建築物に適している。

3．同じ容積の建築物では，構造体の軽量化が図れる。

4．鋼材は不燃材料であるが，骨組の耐火性能は劣る。', 'So với kết cấu bê tông cốt thép, phát biểu nào về đặc điểm thông thường của kết cấu thép không thích hợp nhất?

1. Vì độ cứng của kết cấu lớn nên khó phát sinh ảnh hưởng bất lợi do rung động.

2. Thích hợp với công trình có nhịp lớn.

3. Với công trình cùng thể tích, có thể làm nhẹ kết cấu.

4. Thép là vật liệu không cháy nhưng khả năng chịu lửa của khung kém.', NULL, '1', 'Kết cấu thép thường nhẹ và có độ cứng tổng thể thấp hơn kết cấu bê tông cốt thép tương ứng, nên phải chú ý rung động. Môđun đàn hồi lớn của vật liệu thép không có nghĩa mọi khung thép đều cứng hơn khung bê tông.', '[{"term": "鉄骨構造", "reading": "てっこつこうぞう", "meaning": "Kết cấu thép"}, {"term": "剛性", "reading": "ごうせい", "meaning": "Độ cứng"}, {"term": "耐火性能", "reading": "たいかせいのう", "meaning": "Khả năng chịu lửa"}]'::jsonb, 7);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Management', 8, '鉄骨構造の部材に関する記述として，最も不適当なものはどれか。

1．ガセットプレートは，節点に集まる部材相互の接合のために設ける。

2．エンドタブは，溶接時に溶接線の始端と終端に取り付ける。

3．添え板（スプライスプレート）は，高力ボルト等で部材を接合する際に用いる。

4．丸鋼を用いる筋かいは，主に圧縮力に抵抗する。', 'Về các bộ phận của kết cấu thép, phát biểu nào không thích hợp nhất?

1. Bản nút được bố trí để liên kết các cấu kiện tập trung tại nút.

2. Bản dẫn đầu và cuối mối hàn được gắn tại điểm đầu và điểm cuối đường hàn khi hàn.

3. Bản nối được sử dụng khi liên kết cấu kiện bằng bu lông cường độ cao hoặc phương tiện tương tự.

4. Thanh giằng dùng thép tròn chủ yếu chống lực nén.', NULL, '4', 'Thanh giằng thép tròn thanh mảnh chủ yếu chịu kéo; chịu nén dễ mất ổn định do oằn. Phân biệt khả năng chịu kéo của vật liệu với khả năng chịu nén của một thanh dài.', '[{"term": "筋かい", "reading": "すじかい", "meaning": "Thanh giằng"}, {"term": "高力ボルト", "reading": "こうりょくボルト", "meaning": "Bu lông cường độ cao"}, {"term": "圧縮力", "reading": "あっしゅくりょく", "meaning": "Lực nén"}]'::jsonb, 8);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Management', 9, '地盤及び基礎構造に関する記述として，最も不適当なものはどれか。

1．液状化現象は，粘性土地盤より砂質地盤のほうが生じやすい。

2．水を多く含んだ粘性土地盤では，圧密が生じにくい。

3．直接基礎の鉛直支持力は，基礎スラブの根入れ深さが深くなるほど大きくなる。

4．直接基礎の形や大きさは，上部荷重に応じて基礎底面に生じる力の大きさと地耐力により決める。', 'Về nền đất và kết cấu móng, phát biểu nào không thích hợp nhất?

1. Hóa lỏng dễ xảy ra trong nền cát hơn nền đất dính.

2. Trong nền đất dính chứa nhiều nước, cố kết khó xảy ra.

3. Sức chịu tải theo phương đứng của móng nông tăng khi chiều sâu chôn bản móng tăng.

4. Hình dạng và kích thước móng nông được quyết định theo độ lớn lực phát sinh trên đáy móng do tải phía trên và sức chịu tải nền đất.', NULL, '2', 'Đất dính bão hòa chịu tải có thể cố kết do nước lỗ rỗng thoát dần, gây lún theo thời gian. Lựa chọn 2 ngược với đặc điểm này. Cố kết chậm không đồng nghĩa với khó xảy ra.', '[{"term": "圧密", "reading": "あつみつ", "meaning": "Cố kết"}, {"term": "液状化", "reading": "えきじょうか", "meaning": "Hóa lỏng"}, {"term": "地耐力", "reading": "じたいりょく", "meaning": "Sức chịu tải nền đất"}]'::jsonb, 9);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Management', 10, '構造材料の力学的性質に関する記述として，最も不適当なものはどれか。

1．弾性体の一方向の垂直応力によって材料に生じる縦ひずみに対する横ひずみの比を，ポアソン比という。

2．熱による材料の単位長さ当たりの膨張長さの割合を，ヤング係数という。

3．弾性体の応力度とひずみ度が比例関係にあることを，フックの法則という。

4．曲げモーメントを材の断面二次モーメントで除して，中立軸からの距離を乗じて算定するものを，曲げ応力度という。', 'Về tính chất cơ học của vật liệu kết cấu, phát biểu nào không thích hợp nhất?

1. Tỷ số giữa biến dạng ngang và biến dạng dọc của vật liệu đàn hồi do ứng suất pháp một phương được gọi là hệ số Poisson.

2. Tỷ lệ chiều dài giãn nở do nhiệt trên một đơn vị chiều dài của vật liệu được gọi là môđun Young.

3. Quan hệ tỷ lệ giữa ứng suất và biến dạng của vật đàn hồi được gọi là định luật Hooke.

4. Đại lượng tính bằng mômen uốn chia mômen quán tính tiết diện rồi nhân khoảng cách từ trục trung hòa được gọi là ứng suất uốn.', NULL, '2', 'Đại lượng ở lựa chọn 2 là hệ số giãn nở nhiệt; môđun Young E = σ/ε trong miền đàn hồi tuyến tính. Giãn nở nhiệt được biểu diễn ΔL = αLΔT, còn ứng suất uốn σ = My/I. Nhớ phân biệt E với α.', '[{"term": "応力度", "reading": "おうりょくど", "meaning": "Ứng suất"}, {"term": "ひずみ", "reading": "ひずみ", "meaning": "Biến dạng tương đối"}, {"term": "断面二次モーメント", "reading": "だんめんにじモーメント", "meaning": "Mômen quán tính tiết diện"}]'::jsonb, 10);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Management', 11, '図に示す単純梁ABの点C及び点Dにそれぞれ集中荷重Pが作用したときの曲げモーメント図として，正しいものはどれか。ただし，曲げモーメントは材の引張側に描くものとする。

1．2．

3．4．

![Hình câu 11, năm 2025](images/2025_cau_11.png)', 'Khi tải tập trung P tác dụng tại mỗi điểm C và D của dầm đơn giản AB trong hình, biểu đồ mômen uốn nào đúng?

Quy ước: vẽ mômen uốn về phía chịu kéo của cấu kiện.

Dữ liệu hình: AC = l/2; CD = l/4; DB = l/4; AB = l. Hai lực P hướng xuống tại C, D. Các lựa chọn 1, 2, 3, 4 là bốn biểu đồ trong hình.', NULL, '1', 'Cân bằng mômen cho R_B = 5P/4, R_A = 3P/4. Lực cắt lần lượt là 3P/4, −P/4, −5P/4, nên mômen tăng tới C rồi giảm nhẹ tới D và giảm về 0 tại B. Biểu đồ 1 có đúng ba độ dốc; biểu đồ 3 có đoạn bằng giữa C và D, không phù hợp vì lực cắt đoạn này khác 0.', '[{"term": "集中荷重", "reading": "しゅうちゅうかじゅう", "meaning": "Tải tập trung"}, {"term": "曲げモーメント図", "reading": "まげモーメントず", "meaning": "Biểu đồ mômen uốn"}, {"term": "引張側", "reading": "ひっぱりがわ", "meaning": "Phía chịu kéo"}]'::jsonb, 11);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Management', 12, '日本産業規格（JIS）に規定するセラミックタイルに関する記述として，不適当なものはどれか。

1．素地とは，タイルの主体をなす部分をいい，施ゆうタイルの場合，表面に施したうわぐすりは含まない。

2．壁の有機系接着剤によるタイル後張り工法で施工するタイルには，裏あしがなくてはならない。

3．表張りユニットタイルとは，多数個並べたタイルの表面に，表張り台紙を張り付けて連結したものをいう。

4．水濡れする床に使用するタイルは，原則として，耐滑り性の試験を行わなければならない。', 'Về gạch ceramic theo Tiêu chuẩn công nghiệp Nhật Bản (JIS), phát biểu nào không thích hợp?

1. Phần thân gạch là phần cấu thành chủ yếu của gạch; với gạch tráng men, không bao gồm lớp men trên bề mặt.

2. Gạch thi công bằng phương pháp dán sau trên tường với keo hữu cơ phải có gờ ở mặt sau.

3. Gạch đơn vị liên kết bằng giấy phía trước là nhiều viên gạch được xếp và nối với nhau bằng giấy dán trên bề mặt.

4. Về nguyên tắc, gạch dùng trên sàn bị ướt phải được thử tính chống trượt.', NULL, '2', 'Dán bằng keo hữu cơ không bắt buộc gạch phải có gờ mặt sau như phát biểu 2. Điều kiện bám dính phụ thuộc hệ keo và loại gạch phù hợp. Đừng đồng nhất yêu cầu của phương pháp vữa với phương pháp keo hữu cơ.', '[{"term": "素地", "reading": "そじ", "meaning": "Thân gạch"}, {"term": "有機系接着剤", "reading": "ゆうきけいせっちゃくざい", "meaning": "Keo hữu cơ"}, {"term": "耐滑り性", "reading": "たいすべりせい", "meaning": "Tính chống trượt"}]'::jsonb, 12);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Management', 13, '日本産業規格（JIS）に規定する建具の性能試験における性能項目に関する記述として，不適当なものはどれか。

1．強さとは，外力に耐える程度をいう。

2．遮熱性とは，熱の移動を抑える程度をいう。

3．結露防止性とは，建具表面の結露の発生を防ぐ程度をいう。

4．開閉繰返しとは，開閉繰返しに耐え得る程度をいう。', 'Về các chỉ tiêu tính năng trong thử nghiệm cửa theo JIS, phát biểu nào không thích hợp?

1. Độ bền là mức độ chịu được ngoại lực.

2. Tính chắn nhiệt là mức độ hạn chế sự truyền nhiệt.

3. Tính chống ngưng tụ là mức độ ngăn ngưng tụ xuất hiện trên bề mặt cửa.

4. Độ bền đóng mở lặp lại là mức độ chịu được việc đóng mở nhiều lần.', NULL, '2', 'Hạn chế truyền nhiệt nói chung là tính cách nhiệt（断熱性）. Tính chắn nhiệt（遮熱性）chú trọng hạn chế nhiệt do bức xạ mặt trời. Lựa chọn 2 tráo hai thuật ngữ gần nghĩa này.', '[{"term": "建具", "reading": "たてぐ", "meaning": "Cửa và bộ phận đóng mở"}, {"term": "遮熱性", "reading": "しゃねつせい", "meaning": "Tính chắn nhiệt"}, {"term": "断熱性", "reading": "だんねつせい", "meaning": "Tính cách nhiệt"}]'::jsonb, 13);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Management', 14, 'ボード類の一般的な性質に関する記述として，最も不適当なものはどれか。

1．けい酸カルシウム板は，温度や湿度による伸縮や反り等の変形が小さい。

2．インシュレーションボードは，断熱性に優れている。

3．ロックウール化粧吸音板は，吸音性や耐水性に優れている。

4．シージングせっこうボードは，普通せっこうボードに比べ，吸水時の強度低下が少ない。', 'Về tính chất thông thường của các loại tấm, phát biểu nào không thích hợp nhất?

1. Tấm calcium silicate ít biến dạng như co giãn và cong vênh do nhiệt độ, độ ẩm.

2. Tấm sợi cách nhiệt có tính cách nhiệt tốt.

3. Tấm tiêu âm trang trí bằng bông khoáng có tính tiêu âm và chịu nước tốt.

4. Tấm thạch cao sheathing giảm cường độ khi hút nước ít hơn tấm thạch cao thông thường.', NULL, '3', 'Bông khoáng tiêu âm tốt nhưng tấm tiêu âm trang trí không được mặc nhiên xem là chịu nước tốt. Phát biểu 3 ghép một tính chất đúng với một tính chất sai. Khả năng chống cháy, tiêu âm và chịu nước phải xét riêng.', '[{"term": "吸音性", "reading": "きゅうおんせい", "meaning": "Tính tiêu âm"}, {"term": "耐水性", "reading": "たいすいせい", "meaning": "Tính chịu nước"}, {"term": "反り", "reading": "そり", "meaning": "Cong vênh"}]'::jsonb, 14);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Management', 15, '屋外排水工事に関する記述として，最も不適当なものはどれか。

1．排水管を給水管に平行して埋設する場合，原則として排水管を下方にして，両配管は500mm以上のあきを設ける。

2．排水管として用いる遠心力鉄筋コンクリート管のソケット管は，受口を上流に向けて水下から敷設する。

3．地中埋設排水管の長さがその内径又は内法幅の120倍を超えない範囲内で，桝又はマンホールを設ける。

4．地中埋設排水経路に桝を設ける場合，雨水桝にはインバートを，汚水桝には泥だめを設ける。', 'Về thi công thoát nước ngoài nhà, phát biểu nào không thích hợp nhất?

1. Khi chôn ống thoát nước song song với ống cấp nước, về nguyên tắc đặt ống thoát bên dưới và giữ khoảng cách giữa hai ống từ 500 mm trở lên.

2. Ống bê tông cốt thép ly tâm kiểu đầu nong dùng thoát nước được lắp từ phía hạ lưu, đầu nong hướng lên thượng lưu.

3. Bố trí hố kiểm tra hoặc hố ga trong khoảng sao cho chiều dài ống thoát chôn ngầm không vượt 120 lần đường kính trong hoặc bề rộng thông thủy của ống.

4. Khi đặt hố kiểm tra trên tuyến thoát chôn ngầm, làm rãnh dẫn dòng cho hố nước mưa và hố lắng bùn cho hố nước bẩn.', NULL, '4', 'Lựa chọn 4 đảo cấu tạo: hố nước mưa có bộ phận lắng bùn; hố nước bẩn có rãnh dẫn dòng（インバート）để nước thải đi qua thông suốt, hạn chế cặn. Đừng suy rằng nước bẩn thì phải bố trí chỗ đọng bùn.', '[{"term": "雨水桝", "reading": "うすいます", "meaning": "Hố thu nước mưa"}, {"term": "汚水桝", "reading": "おすいます", "meaning": "Hố nước thải"}, {"term": "泥だめ", "reading": "どろだめ", "meaning": "Ngăn lắng bùn"}]'::jsonb, 15);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Management', 16, '建築物の電気設備に関する用語の組合せとして，最も関係の少ないものはどれか。

1．避雷設備 — 棟上導体

2．高圧受変電設備 — キュービクル

3．照明設備 — PBX

4．予備電源設備 — 蓄電池', 'Cặp thuật ngữ nào về thiết bị điện trong công trình có liên hệ ít nhất?

1. Thiết bị chống sét — dây dẫn trên nóc mái.

2. Thiết bị nhận điện và biến áp cao áp — tủ trạm điện cubicle.

3. Thiết bị chiếu sáng — PBX.

4. Thiết bị nguồn điện dự phòng — ắc quy.', NULL, '3', 'PBX là tổng đài điện thoại nội bộ, thuộc hệ thống thông tin liên lạc. Nó không phải thiết bị chiếu sáng. Ba cặp còn lại nối đúng hệ thống với bộ phận hoặc thiết bị đặc trưng.', '[{"term": "避雷設備", "reading": "ひらいせつび", "meaning": "Thiết bị chống sét"}, {"term": "受変電設備", "reading": "じゅへんでんせつび", "meaning": "Thiết bị nhận điện và biến áp"}, {"term": "蓄電池", "reading": "ちくでんち", "meaning": "Ắc quy"}]'::jsonb, 16);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Management', 17, '給排水設備に関する記述として，最も不適当なものはどれか。

1．飲料水用の給水タンクの水抜管は，排水管に直接連結する。

2．飲料水用の給水タンクの天井，底又は周壁は，建築物の構造体と兼用してはならない。

3．公共下水道の排水方式には，雨水とその他の排水を合流させる合流式と，合流させない分流式がある。

4．水道直結増圧方式の給水設備は，水道本管から分岐した水道引込み管に増圧給水装置を直結し，建物各所に給水する方式である。', 'Về thiết bị cấp thoát nước, phát biểu nào không thích hợp nhất?

1. Ống xả cạn của bể cấp nước uống nối trực tiếp với ống thoát nước.

2. Trần, đáy hoặc thành của bể cấp nước uống không được kiêm làm bộ phận kết cấu công trình.

3. Hệ thống thoát nước công cộng có kiểu chung, kết hợp nước mưa với nước thải khác, và kiểu riêng, không kết hợp chúng.

4. Cấp nước tăng áp trực tiếp là phương thức nối bộ tăng áp trực tiếp vào ống dẫn nước vào tòa nhà được phân nhánh từ ống cấp nước chính, rồi cấp nước đến các nơi trong nhà.', NULL, '1', 'Ống xả của bể nước uống phải thoát gián tiếp với khoảng hở không khí để ngăn nước bẩn chảy ngược. Nối trực tiếp như lựa chọn 1 tạo nguy cơ nhiễm bẩn nước uống.', '[{"term": "水抜管", "reading": "みずぬきかん", "meaning": "Ống xả cạn"}, {"term": "合流式", "reading": "ごうりゅうしき", "meaning": "Hệ thống thoát chung"}, {"term": "分流式", "reading": "ぶんりゅうしき", "meaning": "Hệ thống thoát riêng"}]'::jsonb, 17);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 18, '遣方及び墨出しに関する記述として，最も不適当なものはどれか。

1．水貫は，水杭に示した一定の高さに上端を合わせて，水杭に水平に取り付ける。

2．縄張りは，建物の位置を確認するため，設計図書に従ってロープを張り巡らせる。

3．鋼製巻尺は，温度により伸縮するため，測定時の気温に合わせて温度補正を行う。

4．2階から上階における高さの基準墨は，墨の引通しにより，順次下階の墨を上げる。', 'Về giàn định vị và bật mực, phát biểu nào không thích hợp nhất?

1. Thanh ngang định vị được gắn nằm ngang vào cọc, mép trên trùng cao độ nhất định đã đánh dấu trên cọc.

2. Để xác nhận vị trí công trình, căng dây vòng theo hồ sơ thiết kế.

3. Thước cuộn thép co giãn theo nhiệt độ nên được hiệu chỉnh nhiệt độ theo nhiệt độ không khí lúc đo.

4. Mốc mực cao độ từ tầng 2 trở lên được chuyển lần lượt từ mốc tầng dưới bằng cách kéo thông đường mực.', NULL, '4', 'Chuyển cao độ lần lượt từ tầng dưới lên tầng trên làm tích lũy sai số. Cần truyền từ mốc chuẩn thống nhất bằng phương tiện đo phù hợp, kiểm tra khép và đối chiếu. Đừng nhầm nối một đường mực ngang với truyền cao độ giữa tầng.', '[{"term": "遣方", "reading": "やりかた", "meaning": "Giàn định vị"}, {"term": "墨出し", "reading": "すみだし", "meaning": "Bật mực định vị"}, {"term": "鋼製巻尺", "reading": "こうせいまきじゃく", "meaning": "Thước cuộn thép"}]'::jsonb, 18);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 19, '地業工事に関する記述として，最も不適当なものはどれか。

1．砂利地業で用いる砂利は，砂が混じっていない粒径の揃ったものとする。

2．締固めによって砂利地業にくぼみが生じた場合，砂利を補充して表面を平らに均す。

3．捨てコンクリート地業は，基礎スラブ及び基礎梁のセメントペーストの流出を防ぐ効果がある。

4．捨てコンクリート地業は，床付け地盤が強固で良質な場合，地盤上に直接施工できる。', 'Về công tác nền móng sơ bộ, phát biểu nào không thích hợp nhất?

1. Sỏi dùng cho lớp nền sỏi phải không lẫn cát và có cỡ hạt đồng đều.

2. Khi đầm chặt làm xuất hiện chỗ trũng trên lớp sỏi, bổ sung sỏi và san phẳng bề mặt.

3. Bê tông lót có tác dụng ngăn hồ xi măng của bản móng và dầm móng chảy mất.

4. Nếu nền ở đáy đào chắc và tốt, có thể thi công bê tông lót trực tiếp trên nền.', NULL, '1', 'Cấp phối hạt thích hợp, kể cả phần hạt nhỏ, giúp lấp lỗ rỗng và đầm chặt. Không yêu cầu sỏi phải toàn hạt đồng cỡ và tuyệt đối không lẫn cát. Hạt đều kích thước có thể tạo nhiều lỗ rỗng.', '[{"term": "地業", "reading": "じぎょう", "meaning": "Công tác lớp nền móng"}, {"term": "締固め", "reading": "しめかため", "meaning": "Đầm chặt"}, {"term": "捨てコンクリート", "reading": "すてコンクリート", "meaning": "Bê tông lót"}]'::jsonb, 19);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 20, '異形鉄筋における継手及び定着に関する記述として，最も不適当なものはどれか。

1．大梁の上端筋の継手位置は，スパンの中央部とする。

2．重ね継手の長さは，コンクリートの設計基準強度に係わらず同じである。

3．鉄筋の継手には，重ね継手，圧接継手，機械式継手，溶接継手等がある。

4．フック付き定着とする場合の定着の長さは，定着起点からフックの折曲げ開始点までの距離とする。', 'Về nối và neo cốt thép có gờ, phát biểu nào không thích hợp nhất?

1. Vị trí nối cốt thép trên của dầm chính là vùng giữa nhịp.

2. Chiều dài nối chồng không đổi, không phụ thuộc cường độ thiết kế bê tông.

3. Các mối nối thép gồm nối chồng, nối hàn ép, nối cơ khí và nối hàn.

4. Khi neo có móc, chiều dài neo là khoảng cách từ điểm bắt đầu neo đến điểm bắt đầu uốn móc.', NULL, '2', 'Chiều dài nối chồng phụ thuộc khả năng bám dính, cường độ bê tông, loại và đường kính thép cùng điều kiện nối. Không thể lấy một chiều dài cố định cho mọi cường độ. Neo và nối chồng cũng không phải cùng một khái niệm.', '[{"term": "異形鉄筋", "reading": "いけいてっきん", "meaning": "Cốt thép có gờ"}, {"term": "重ね継手", "reading": "かさねつぎて", "meaning": "Mối nối chồng"}, {"term": "定着", "reading": "ていちゃく", "meaning": "Neo cốt thép"}]'::jsonb, 20);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 21, 'せき板及び支柱の取りはずしに関する記述として，最も不適当なものはどれか。ただし，計画供用期間の級は標準とする。

1．梁下支柱の取りはずしが可能となるコンクリートの圧縮強度は，普通ポルトランドセメントを用いる場合と早強ポルトランドセメントを用いる場合では同じである。

2．せき板の取りはずしが可能となるコンクリートの圧縮強度は，柱とスラブ下では異なる。

3．コンクリートの材齢によるスラブ下の支柱の最小存置期間は，普通ポルトランドセメントを用いる場合，存置期間中の平均気温によって異なる。

4．コンクリートの材齢によるせき板の最小存置期間は，普通ポルトランドセメントを用いる場合と高炉セメントB種を用いる場合では同じである。', 'Về tháo tấm ván khuôn và cột chống, phát biểu nào không thích hợp nhất? Cấp thời gian sử dụng dự kiến là tiêu chuẩn.

1. Cường độ nén bê tông cho phép tháo cột chống dưới dầm giống nhau khi dùng xi măng Portland thường và Portland cường độ sớm.

2. Cường độ nén bê tông cho phép tháo ván khuôn khác nhau giữa cột và mặt dưới bản sàn.

3. Khi xác định theo tuổi bê tông, thời gian lưu tối thiểu cột chống dưới sàn dùng xi măng Portland thường khác nhau theo nhiệt độ trung bình trong thời gian lưu.

4. Khi xác định theo tuổi bê tông, thời gian lưu tối thiểu ván khuôn giống nhau khi dùng xi măng Portland thường và xi măng lò cao loại B.', NULL, '4', 'Xi măng khác loại có tốc độ phát triển cường độ khác nhau nên mốc tuổi để tháo ván khuôn không mặc nhiên giống nhau. Phải phân biệt tiêu chí cường độ đã đo với tiêu chí số ngày dưỡng hộ; lựa chọn 4 sai ở tiêu chí tuổi.', '[{"term": "せき板", "reading": "せきいた", "meaning": "Tấm ván khuôn"}, {"term": "支柱", "reading": "しちゅう", "meaning": "Cột chống"}, {"term": "存置期間", "reading": "そんちきかん", "meaning": "Thời gian lưu giữ"}]'::jsonb, 21);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 22, '鉄骨の建方に関する記述として，最も不適当なものはどれか。

1．建入れ直し用のワイヤロープの取付け用ピースは，あらかじめ鉄骨本体に取り付けた。

2．油が付着している仮ボルトは，油を除去して使用した。

3．ターンバックル付き筋かいを有する構造物は，その筋かいを用いて建入れ直しを行った。

4．溶接継手のエレクションピースに使用する仮ボルトは，高力ボルトを用いて全数締め付けた。', 'Về lắp dựng kết cấu thép, phát biểu nào không thích hợp nhất?

1. Các tai gắn cáp để chỉnh độ thẳng đứng đã được gắn sẵn vào thân kết cấu thép.

2. Bu lông tạm bị dính dầu được làm sạch dầu rồi mới dùng.

3. Với kết cấu có giằng gắn tăng đơ, dùng chính giằng đó để chỉnh độ thẳng đứng.

4. Bu lông tạm dùng cho tai lắp dựng của liên kết hàn là bu lông cường độ cao, được siết toàn bộ.', NULL, '3', 'Chỉnh dựng cần hệ cáp hoặc phương tiện chỉnh tạm thích hợp; không dùng giằng kết cấu có tăng đơ như dụng cụ chỉnh dựng. Giằng chính thức được điều chỉnh và cố định theo trình tự sau khi hình học khung được kiểm tra.', '[{"term": "建方", "reading": "たてかた", "meaning": "Lắp dựng"}, {"term": "建入れ直し", "reading": "たていれなおし", "meaning": "Chỉnh độ thẳng đứng"}, {"term": "仮ボルト", "reading": "かりボルト", "meaning": "Bu lông tạm"}]'::jsonb, 22);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 23, '合成高分子系ルーフィングシート防水の接着工法に関する記述として，最も不適当なものはどれか。

1．塩化ビニル樹脂系シート防水において，防水層の立上り末端部は，押え金物で固定し，不定形シール材を用いて処理した。

2．塩化ビニル樹脂系シート防水において，ALCパネル下地であったため，プライマーを塗布した。

3．加硫ゴム系シート防水において，ルーフィングシート相互の接合部は，接着剤とテープ状シール材を併用して接合した。

4．加硫ゴム系シート防水において，ルーフィングシート相互の接合部で3枚重ねとなる部分は，熱風で柔らかくして段差部をなくすように融着した。', 'Về phương pháp dán màng chống thấm polymer tổng hợp, phát biểu nào không thích hợp nhất?

1. Với màng nhựa PVC, đầu cuối phần chống thấm dựng đứng được cố định bằng nẹp ép và xử lý bằng vật liệu trám dạng không định hình.

2. Với màng nhựa PVC trên nền tấm ALC, đã quét lớp lót.

3. Với màng cao su lưu hóa, các mối nối giữa màng được nối bằng kết hợp keo và băng trám.

4. Với màng cao su lưu hóa, chỗ mối nối có ba lớp chồng nhau được làm mềm bằng khí nóng, rồi hàn nóng để xóa bậc chênh.', NULL, '4', 'Cao su đã lưu hóa không nóng chảy như vật liệu nhiệt dẻo PVC, nên không dùng hàn nóng để nối ba lớp. Phải xử lý mối nối bằng hệ keo, băng và vật liệu trám phù hợp. Tránh chuyển nguyên phương pháp của PVC sang cao su lưu hóa.', '[{"term": "防水", "reading": "ぼうすい", "meaning": "Chống thấm"}, {"term": "加硫ゴム", "reading": "かりゅうゴム", "meaning": "Cao su lưu hóa"}, {"term": "融着", "reading": "ゆうちゃく", "meaning": "Hàn nóng chảy"}]'::jsonb, 23);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 24, 'セルフレベリング材塗りに関する記述として，最も不適当なものはどれか。

1．流し込みに先立ち，コンクリート下地を調整し，塗厚が10mm程度となるようにした。

2．流し込み作業中は，通風のため窓や開口部を開放した。

3．流し込み後の乾燥養生期間は，外気温が低い冬季であったため，14日間とした。

4．打継ぎ部の凸部は，硬化後にサンダーを使って削り取った。', 'Về thi công lớp tự san phẳng, phát biểu nào không thích hợp nhất?

1. Trước khi đổ, điều chỉnh nền bê tông để lớp phủ dày khoảng 10 mm.

2. Trong lúc đổ, mở cửa sổ và các lỗ mở để thông gió.

3. Vì mùa đông có nhiệt độ ngoài trời thấp, thời gian dưỡng hộ khô sau đổ được đặt là 14 ngày.

4. Chỗ lồi tại mạch ngừng được mài bỏ bằng máy mài sau khi cứng.', NULL, '2', 'Gió lùa khi thi công làm khô bề mặt không đều và có thể gây nứt, nên cần tránh mở cửa tạo luồng gió trong lúc đổ. Phân biệt bảo vệ ban đầu với thông gió phục vụ khô về sau.', '[{"term": "セルフレベリング材", "reading": "セルフレベリングざい", "meaning": "Vật liệu tự san phẳng"}, {"term": "養生", "reading": "ようじょう", "meaning": "Dưỡng hộ"}, {"term": "打継ぎ", "reading": "うちつぎ", "meaning": "Mạch ngừng"}]'::jsonb, 24);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 25, '鋼製建具に関する記述として，最も不適当なものはどれか。ただし，1枚の戸の有効開口は，幅950mm以下，高さ2,400mm以下とする。

1．建具枠の取付け用のアンカーは，枠の両端から逃げた位置から900mm内外の間隔で設けた。

2．フラッシュ戸の組立てにおいて，中骨を300mm以下の間隔で設けた。

3．錆止め塗装を2回塗りとするため，1回目を工場で行い，2回目を工事現場で行った。

4．くつずりは，あらかじめ裏面に鉄線等を取り付けておき，モルタル詰めを行った後に取り付けた。', 'Về cửa thép, phát biểu nào không thích hợp nhất? Lỗ mở hữu hiệu của một cánh cửa có bề rộng không quá 950 mm và chiều cao không quá 2.400 mm.

1. Neo lắp khung cửa được bố trí cách hai đầu khung một đoạn và sau đó theo khoảng cách khoảng 900 mm.

2. Khi lắp ráp cửa phẳng, xương giữa được bố trí cách nhau không quá 300 mm.

3. Để sơn chống gỉ hai lớp, lớp thứ nhất được sơn tại nhà máy và lớp thứ hai tại công trường.

4. Ngưỡng cửa đã được gắn dây thép ở mặt dưới trước; sau khi nhồi vữa mới được lắp đặt.', NULL, '1', 'Khoảng cách neo khung 900 mm quá lớn; cấu tạo tiêu chuẩn yêu cầu khoảng cách không quá 500 mm, bắt đầu từ vị trí cách hai đầu khung một đoạn. Điều kiện kích thước cửa của đề phải được giữ khi đối chiếu, không lấy yêu cầu của cửa lớn đặc biệt thay thế.', '[{"term": "鋼製建具", "reading": "こうせいたてぐ", "meaning": "Cửa thép"}, {"term": "錆止め塗装", "reading": "さびどめとそう", "meaning": "Sơn chống gỉ"}, {"term": "くつずり", "reading": "くつずり", "meaning": "Ngưỡng cửa"}]'::jsonb, 25);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 26, 'ビニル床シート張りに関する記述として，最も不適当なものはどれか。

1．床シートは，張付け前に24時間以上仮敷きし，巻き癖を除いた。

2．床シートを幅木部に張り上げるため，ニトリルゴム系接着剤を用いた。

3．熱溶接工法において，溶接部の床シートの溝部分と溶接棒は，250℃から300℃の熱風で加熱溶融した。

4．クッションフロアの床シート間の端部の接合には，溶接液を用いた。', 'Về dán tấm sàn vinyl, phát biểu nào không thích hợp nhất?

1. Trước khi dán, trải tạm tấm sàn ít nhất 24 giờ để loại bỏ độ cong do cuộn.

2. Để dán tấm sàn dựng lên phần chân tường, dùng keo cao su nitrile.

3. Trong phương pháp hàn nóng, rãnh nối của tấm sàn và que hàn được nung chảy bằng khí nóng từ 250 ℃ đến 300 ℃.

4. Khi nối mép giữa các tấm sàn cushion floor, dùng dung dịch hàn.', NULL, '3', 'Mức khí nóng 250–300 ℃ ở lựa chọn 3 không phù hợp điều kiện hàn nóng của đề. Cách đúng là dùng máy hàn và que hàn chuyên dụng, điều chỉnh nhiệt độ cùng tốc độ để tấm sàn và que hàn nóng chảy đồng thời, rồi ép tạo mối nối có phần dư. Nhiệt độ cụ thể theo vật liệu và thiết bị; không nhầm nhiệt khí thổi với nhiệt thực tế của vật liệu.', '[{"term": "ビニル床シート", "reading": "ビニルゆかシート", "meaning": "Tấm sàn vinyl"}, {"term": "溶接棒", "reading": "ようせつぼう", "meaning": "Que hàn"}, {"term": "熱風", "reading": "ねっぷう", "meaning": "Khí nóng"}]'::jsonb, 26);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 27, '外部仕上改修工事に関する記述として，最も不適当なものはどれか。

1．外壁の劣化した既存複層仕上塗材は，高圧水洗で除去した。

2．外装金属カーテンウォールの既存シーリングをすべて除去することが困難なため，補修シーリング材を重ねるブリッジ工法で補修した。

3．外壁の石張り目地のシーリング材の劣化した部分を再充填工法にて改修するため，既存シーリング材を除去し，同種のシーリング材を充填した。

4．外壁のコンクリート打放し面のひび割れは，ポリマーセメントモルタル充填工法で改修した。', 'Về sửa chữa lớp hoàn thiện bên ngoài, phát biểu nào không thích hợp nhất?

1. Lớp phủ hoàn thiện nhiều lớp hiện hữu đã xuống cấp trên tường ngoài được loại bỏ bằng rửa nước áp lực cao.

2. Vì khó loại bỏ toàn bộ vật liệu trám cũ của tường rèm kim loại ngoài nhà, đã sửa bằng phương pháp cầu nối, phủ thêm vật liệu trám sửa chữa.

3. Để sửa phần trám đã xuống cấp ở mạch ốp đá tường ngoài bằng trám lại, loại bỏ vật liệu cũ rồi điền vật liệu cùng loại.

4. Vết nứt trên mặt bê tông để trần của tường ngoài được sửa bằng phương pháp điền vữa xi măng polymer.', NULL, '4', 'Điền vữa xi măng polymer đơn thuần không phải phương án cơ bản cho vết nứt của mặt bê tông để trần. Cần chọn xử lý vết nứt phù hợp, như bơm nhựa hoặc cắt rãnh và trám theo trạng thái nứt. Không đồng nhất sửa vết nứt với vá phần bê tông khuyết.', '[{"term": "改修工事", "reading": "かいしゅうこうじ", "meaning": "Công tác sửa chữa"}, {"term": "ひび割れ", "reading": "ひびわれ", "meaning": "Vết nứt"}, {"term": "再充填", "reading": "さいじゅうてん", "meaning": "Trám lại"}]'::jsonb, 27);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Strategy', 28, '事前調査に関する記述として，最も不適当なものはどれか。

1．敷地境界と敷地面積の確認のため，地積測量を行うこととした。

2．敷地内の建家，立木，工作物の配置を把握するため，水準測量を行うこととした。

3．掘削への影響を検討するため，近隣河川までの距離と河川の水位を調査することとした。

4．杭の打込みが予定されているため，近接する工作物や舗装の現状を記録することとした。', 'Về khảo sát trước thi công, phát biểu nào không thích hợp nhất?

1. Để xác nhận ranh giới và diện tích khu đất, quyết định đo đạc địa tích.

2. Để nắm bố trí nhà, cây đứng và công trình phụ trong khu đất, quyết định đo thủy chuẩn.

3. Để xem xét ảnh hưởng đến đào đất, quyết định khảo sát khoảng cách đến sông lân cận và mực nước sông.

4. Vì dự kiến đóng cọc, quyết định ghi lại hiện trạng công trình phụ và mặt đường ở gần.', NULL, '2', 'Đo thủy chuẩn xác định chênh cao; để nắm bố trí mặt bằng cần đo vị trí mặt bằng. Lựa chọn 2 chọn sai loại đo. Những khảo sát khác lần lượt phục vụ ranh đất, nước và đánh giá tác động đóng cọc.', '[{"term": "事前調査", "reading": "じぜんちょうさ", "meaning": "Khảo sát trước thi công"}, {"term": "水準測量", "reading": "すいじゅんそくりょう", "meaning": "Đo thủy chuẩn"}, {"term": "地積測量", "reading": "ちせきそくりょう", "meaning": "Đo địa tích"}]'::jsonb, 28);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Strategy', 29, '仮設計画を検討するうえでの位置関係の組合せとして，最も関係の少ないものはどれか。

1．仮設給水の引込み位置 — 受変電設備の設置位置

2．仮設足場の防護棚の設置位置 — 隣接道路の位置

3．乗入れ構台の設置位置 — 本体建物の鉄骨柱の位置

4．下小屋の位置 — 材料置場の位置', 'Cặp quan hệ vị trí nào ít liên quan nhất khi xem xét kế hoạch công trình tạm?

1. Vị trí dẫn nước cấp tạm vào — vị trí đặt thiết bị nhận điện và biến áp.

2. Vị trí đặt sàn che bảo vệ của giàn giáo tạm — vị trí đường liền kề.

3. Vị trí đặt sàn công tác cho xe ra vào — vị trí cột thép của công trình chính.

4. Vị trí xưởng gia công tạm — vị trí bãi vật liệu.', NULL, '1', 'Điểm cấp nước tạm và vị trí thiết bị điện không có quan hệ công năng trực tiếp bằng ba cặp còn lại. Câu hỏi so sánh mức độ liên quan, không nói hai hệ thống hoàn toàn không cần phối hợp an toàn.', '[{"term": "仮設計画", "reading": "かせつけいかく", "meaning": "Kế hoạch công trình tạm"}, {"term": "防護棚", "reading": "ぼうごだな", "meaning": "Sàn che bảo vệ"}, {"term": "下小屋", "reading": "したごや", "meaning": "Xưởng gia công tạm"}]'::jsonb, 29);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Strategy', 30, '工事現場における材料の保管に関する記述として，最も不適当なものはどれか。

1．アルミニウム製建具は，平積みを避け，立てて保管した。

2．型枠用合板は，直射日光が当たらないようにシートを掛けて保管した。

3．板ガラスは，クッション材を挟み，乾燥した場所に平積みで保管した。

4．巻いた壁紙は，癖が付かないように立てて保管した。', 'Về bảo quản vật liệu ở công trường, phát biểu nào không thích hợp nhất?

1. Cửa nhôm được bảo quản dựng đứng, tránh xếp nằm.

2. Ván ép ván khuôn được che bằng tấm phủ để tránh ánh nắng trực tiếp.

3. Kính tấm được xen vật liệu đệm và bảo quản xếp nằm ở nơi khô.

4. Cuộn giấy dán tường được dựng đứng để tránh biến dạng.', NULL, '3', 'Kính tấm cần bảo quản dựng trên giá phù hợp, có đệm và chống đổ; xếp nằm làm tăng nguy cơ nứt do tải chồng và biến dạng. Chèn đệm không biến phương án xếp nằm thành đúng.', '[{"term": "板ガラス", "reading": "いたガラス", "meaning": "Kính tấm"}, {"term": "平積み", "reading": "ひらづみ", "meaning": "Xếp nằm"}, {"term": "保管", "reading": "ほかん", "meaning": "Bảo quản"}]'::jsonb, 30);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Strategy', 31, '工程管理に関する記述として，最も不適当なものはどれか。

1．工程計画は，所定の工期内で，所定の品質を確保し，経済的に施工できるよう作成する。

2．工程管理の手法として，3次元CADやコンピュータグラフィックスを使用することで工事現場の進捗状況を視覚的に把握する方法がある。

3．Sチャートは，工事の進捗に従って発生する出来高の累積値を縦軸に，時間を横軸に取ることで，出来高の進捗を示すことができる。

4．工期短縮に用いる手法として，山積工程表における山崩しがある。', 'Về quản lý tiến độ, phát biểu nào không thích hợp nhất?

1. Kế hoạch tiến độ được lập để bảo đảm chất lượng yêu cầu, thi công kinh tế trong thời hạn quy định.

2. Một phương pháp quản lý tiến độ là dùng CAD 3 chiều hoặc đồ họa máy tính để nắm trực quan tình trạng thực hiện công trường.

3. Biểu đồ S thể hiện tiến độ khối lượng bằng cách lấy trục đứng là khối lượng hoàn thành tích lũy theo tiến triển công việc, trục ngang là thời gian.

4. San bằng biểu đồ nhu cầu nguồn lực là một phương pháp rút ngắn thời gian thi công.', NULL, '4', 'San bằng nguồn lực（山崩し）nhằm điều hòa nhu cầu nhân công hoặc thiết bị theo thời gian, không tự động rút ngắn tổng thời hạn. Muốn rút ngắn cần tác động đến các công việc chi phối tiến độ, xét quan hệ phụ thuộc và đường găng.', '[{"term": "工程管理", "reading": "こうていかんり", "meaning": "Quản lý tiến độ"}, {"term": "出来高", "reading": "できだか", "meaning": "Khối lượng hoàn thành"}, {"term": "山崩し", "reading": "やまくずし", "meaning": "San bằng nguồn lực"}]'::jsonb, 31);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Strategy', 32, 'バーチャート工程表に関する次の文章中，［a］/［b］に当てはまる語句の組合せとして，適当なものはどれか。

「バーチャート工程表は，縦軸に工事種目，横軸に［a］を示した工程表であり，その特徴として，作成がしやすい，各工事種目の日程が管理しやすい，作業間調整に伴う修正が［b］，重点管理項目がわかりにくい，複雑な工事には不向き等がある。」

［a］＝イ，［b］＝ロ。

| 選択肢 | ［a］（イ） | ［b］（ロ） |
| --- | --- | --- |
| 1 | 各工事日数 | しにくい |
| 2 | 各工事日数 | しやすい |
| 3 | 各工事の達成度 | しにくい |
| 4 | 各工事の達成度 | しやすい |', 'Trong đoạn văn sau về biểu đồ tiến độ thanh, tổ hợp từ nào thích hợp để điền vào ô trống ［a］/［b］?

“Biểu đồ tiến độ thanh là biểu đồ có trục đứng thể hiện hạng mục công việc, trục ngang thể hiện ［a］. Đặc điểm của nó gồm: dễ lập; dễ quản lý lịch của mỗi hạng mục; ［b］ sửa đổi khi điều chỉnh giữa các công việc; khó thấy các hạng mục cần quản lý trọng điểm; không phù hợp công việc phức tạp.”

Ô ［a］ tương ứng イ, ô ［b］ tương ứng ロ.

1. ［a］ Số ngày của từng công việc; ［b］ khó.

2. ［a］ Số ngày của từng công việc; ［b］ dễ.

3. ［a］ Mức độ hoàn thành từng công việc; ［b］ khó.

4. ［a］ Mức độ hoàn thành từng công việc; ［b］ dễ.', NULL, '1', 'Trục ngang là thời gian/số ngày. Biểu đồ thanh không diễn tả chặt quan hệ phụ thuộc nên sửa khi phối hợp các công việc có thể khó. “Dễ lập” không đồng nghĩa “dễ điều chỉnh quan hệ giữa công việc”; tổ hợp đúng là lựa chọn 1.', '[{"term": "バーチャート工程表", "reading": "バーチャートこうていひょう", "meaning": "Biểu đồ tiến độ thanh"}, {"term": "工事種目", "reading": "こうじしゅもく", "meaning": "Hạng mục công việc"}, {"term": "達成度", "reading": "たっせいど", "meaning": "Mức độ hoàn thành"}]'::jsonb, 32);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Strategy', 33, '建築施工の品質管理に関する記述として，最も不適当なものはどれか。

1．施工の検査に伴う試験は，試験によらなければ品質及び性能を証明できない場合に行う。

2．品質計画に基づく施工の試験又は検査の結果は，次の計画や設計に活かす。

3．品質管理は，施工段階より計画段階で検討するほうが効果的である。

4．品質管理は，作業そのものを適切に実施するプロセス管理に重点を置くより，試験や検査に重点を置く。', 'Về quản lý chất lượng thi công xây dựng, phát biểu nào không thích hợp nhất?

1. Thử nghiệm đi kèm kiểm tra thi công được thực hiện khi không thể chứng minh chất lượng và tính năng nếu không thử nghiệm.

2. Kết quả thử nghiệm hoặc kiểm tra thi công theo kế hoạch chất lượng được dùng cho kế hoạch và thiết kế tiếp theo.

3. Xem xét quản lý chất lượng ở giai đoạn lập kế hoạch hiệu quả hơn xem xét ở giai đoạn thi công.

4. Quản lý chất lượng chú trọng thử nghiệm và kiểm tra hơn là quản lý quá trình để thực hiện đúng bản thân công việc.', NULL, '4', 'Chất lượng phải được tạo ra và kiểm soát trong quá trình làm việc; kiểm tra cuối chỉ phát hiện kết quả. Do đó không đặt trọng tâm vào kiểm tra thay cho quản lý quá trình. Phân biệt ngăn lỗi với phát hiện lỗi.', '[{"term": "品質管理", "reading": "ひんしつかんり", "meaning": "Quản lý chất lượng"}, {"term": "検査", "reading": "けんさ", "meaning": "Kiểm tra"}, {"term": "プロセス管理", "reading": "プロセスかんり", "meaning": "Quản lý quá trình"}]'::jsonb, 33);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Strategy', 34, '品質管理の用語に関する記述として，最も不適当なものはどれか。

1．サンプルとは，母集団の情報を得るために，母集団から取られた1つ以上のサンプリング単位をいう。

2．三現主義とは，現場で現物を見ながら現実的に検討を進めることを重視する考え方をいう。

3．トレーサビリティとは，対象の履歴，適用又は所在を追跡できることをいう。

4．ロットとは，異なる条件下で生産された品物の集まりをいう。', 'Về thuật ngữ quản lý chất lượng, phát biểu nào không thích hợp nhất?

1. Mẫu là một hoặc nhiều đơn vị lấy mẫu được lấy từ tổng thể để thu thông tin về tổng thể đó.

2. Nguyên tắc ba thực coi trọng xem vật thực tại hiện trường và xem xét trên thực tế.

3. Khả năng truy xuất là khả năng theo dõi lịch sử, sự áp dụng hoặc vị trí của đối tượng.

4. Lô là tập hợp các sản phẩm được sản xuất trong những điều kiện khác nhau.', NULL, '4', 'Lô để kiểm soát chất lượng là tập hợp được nhóm theo điều kiện xác định, thường điều kiện tương đồng. Gộp các sản phẩm tùy ý từ điều kiện khác nhau phá vỡ ý nghĩa đại diện của việc lấy mẫu.', '[{"term": "母集団", "reading": "ぼしゅうだん", "meaning": "Tổng thể"}, {"term": "三現主義", "reading": "さんげんしゅぎ", "meaning": "Nguyên tắc ba thực"}, {"term": "トレーサビリティ", "reading": "トレーサビリティ", "meaning": "Khả năng truy xuất"}]'::jsonb, 34);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Strategy', 35, '鉄筋のガス圧接継手の外観検査の結果，不合格となった圧接部の処置に関する記述として，最も不適当なものはどれか。

1．圧接部のふくらみの直径や長さが規定値に満たなかったため，再加熱し加圧して所定のふくらみに修正した。

2．圧接部のふくらみが規定値を超える片ふくらみとなっていたため，圧接部を切り取って再圧接した。

3．圧接面のずれが規定値を超えていたため，圧接部を切り取って再圧接した。

4．圧接部における鉄筋中心軸の偏心量が規定値を超えていたため，再加熱して偏心を修正した。', 'Về xử lý mối nối hàn ép khí cốt thép bị đánh giá không đạt qua kiểm tra ngoại quan, phát biểu nào không thích hợp nhất?

1. Vì đường kính hoặc chiều dài phần phình chưa đạt quy định, nung lại và ép để chỉnh thành phần phình đúng yêu cầu.

2. Vì phần phình bị lệch về một phía vượt quy định, cắt bỏ chỗ hàn ép và hàn ép lại.

3. Vì độ lệch mặt hàn ép vượt quy định, cắt bỏ chỗ hàn ép và hàn ép lại.

4. Vì độ lệch tâm trục cốt thép tại chỗ hàn ép vượt quy định, nung lại để chỉnh lệch tâm.', NULL, '4', 'Lệch tâm vượt giới hạn phải cắt bỏ và hàn ép lại, không chỉ nung để nắn chỉnh. Nung và ép thêm chỉ dùng cho những dạng thiếu kích thước phần phình được phép xử lý; không áp dụng cho mọi lỗi ngoại quan.', '[{"term": "ガス圧接", "reading": "ガスあっせつ", "meaning": "Hàn ép khí"}, {"term": "外観検査", "reading": "がいかんけんさ", "meaning": "Kiểm tra ngoại quan"}, {"term": "偏心量", "reading": "へんしんりょう", "meaning": "Độ lệch tâm"}]'::jsonb, 35);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Strategy', 36, '作業主任者を選任すべき作業として，「労働安全衛生法施行令」上，定められていないものはどれか。

1．支柱高さが3mの型枠支保工の解体

2．軒の高さが5mの木造建築物の構造部材の組立て

3．鉄筋コンクリート構造の建築物の鉄筋の組立て

4．アセチレン溶接装置を用いて行う金属の溶断', 'Theo Nghị định thi hành Luật An toàn và vệ sinh lao động, công việc nào không được quy định là phải chỉ định người phụ trách công việc?

1. Tháo hệ chống ván khuôn có chiều cao cột chống 3 m.

2. Lắp cấu kiện kết cấu nhà gỗ có chiều cao mép mái 5 m.

3. Lắp cốt thép của công trình bê tông cốt thép.

4. Cắt kim loại bằng thiết bị hàn acetylene.', NULL, '3', 'Việc lắp cốt thép thông thường không thuộc loại công việc được liệt kê ở đây cần 作業主任者. Ba công việc khác thuộc các nhóm pháp định tương ứng. Điều này không miễn các nghĩa vụ giám sát và an toàn khác.', '[{"term": "作業主任者", "reading": "さぎょうしゅにんしゃ", "meaning": "Người phụ trách công việc theo luật"}, {"term": "型枠支保工", "reading": "かたわくしほこう", "meaning": "Hệ chống ván khuôn"}, {"term": "溶断", "reading": "ようだん", "meaning": "Cắt nhiệt"}]'::jsonb, 36);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Strategy', 37, '通路及び足場に関する記述として，最も不適当なものはどれか。

1．高さ8m以上の登り桟橋には，高さ7m以内ごとに踊場を設けた。

2．勾配が15°以下の登り桟橋には，踏桟を設けなかった。

3．高さ5m以上の枠組足場において，壁つなぎの水平方向の間隔は，10mとした。

4．枠組足場において，階段の手すりの高さは，踏板より90cmとした。', 'Về lối đi và giàn giáo, phát biểu nào không thích hợp nhất?

1. Với cầu lên dốc cao từ 8 m trở lên, đặt chiếu nghỉ theo khoảng cao không quá 7 m.

2. Với cầu lên dốc có độ dốc không quá 15°, không bố trí thanh chống trượt ngang.

3. Với giàn giáo khung cao từ 5 m trở lên, khoảng cách ngang giữa các liên kết vào tường là 10 m.

4. Trên giàn giáo khung, tay vịn cầu thang cao 90 cm tính từ mặt bậc.', NULL, '3', 'Khoảng cách ngang liên kết tường của giàn giáo khung phải không quá 8 m, còn phương đứng không quá 9 m theo điều kiện tiêu chuẩn liên quan. 10 m vượt giới hạn ngang. Phân biệt giới hạn ngang với đứng.', '[{"term": "枠組足場", "reading": "わくぐみあしば", "meaning": "Giàn giáo khung"}, {"term": "壁つなぎ", "reading": "かべつなぎ", "meaning": "Liên kết giàn giáo vào tường"}, {"term": "踊場", "reading": "おどりば", "meaning": "Chiếu nghỉ"}]'::jsonb, 37);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Strategy', 38, '型枠のセパレータに関する記述として，最も不適当なものはどれか。

1．コーンを使用しないセパレータは，型枠脱型後にねじ部分を折り取り，残った座金の露出部分に錆止め塗料を塗り付けた。

2．地下外壁には，水膨潤ゴム製の止水板付きセパレータを用いた。

3．打放し仕上げ面となる外壁コンクリートの型枠に，コーン付きセパレータを用いた。

4．独立柱の型枠の組立てにおいて，コラムクランプをセパレータで締め付けた。

5．セパレータは，せき板に対して垂直となるよう配置した。', 'Về thanh giằng giữ khoảng cách ván khuôn, phát biểu nào không thích hợp nhất?

1. Với thanh không dùng côn, sau tháo ván khuôn bẻ bỏ phần ren và sơn chống gỉ phần vòng đệm còn lộ ra.

2. Với tường ngoài tầng ngầm, dùng thanh có bộ phận cản nước bằng cao su trương nở khi gặp nước.

3. Với ván khuôn bê tông tường ngoài để trần, dùng thanh có côn.

4. Khi lắp ván khuôn cột độc lập, siết đai kẹp cột bằng thanh giằng giữ khoảng cách.

5. Bố trí thanh giằng vuông góc với tấm ván khuôn.', NULL, '4', 'Đai kẹp cột（コラムクランプ）được siết bằng cơ cấu kẹp phù hợp để giữ ván khuôn cột; không dùng セパレータ theo cách ở lựa chọn 4. Thanh giằng chủ yếu giữ khoảng cách giữa hai mặt ván khuôn đối diện.', '[{"term": "セパレータ", "reading": "セパレータ", "meaning": "Thanh giữ khoảng cách ván khuôn"}, {"term": "止水板", "reading": "しすいばん", "meaning": "Bộ phận cản nước"}, {"term": "脱型", "reading": "だっけい", "meaning": "Tháo khuôn"}]'::jsonb, 38);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Strategy', 39, '木造在来軸組構法に関する記述として，最も不適当なものはどれか。

1．腰掛け蟻継ぎとした土台の継手部分は，下木となるほうをアンカーボルトで締め付けた。

2．根太の継手の位置は，大引の受材心とした。

3．土台の継手の位置は，床下換気口部分を避けた。

4．筋かいは，建入れ直し完了後，接合金物や火打梁を固定した後に取り付けた。

5．和小屋組の棟木や母屋には，垂木を取り付けるため，垂木欠きを行った。', 'Về phương pháp khung gỗ truyền thống, phát biểu nào không thích hợp nhất?

1. Ở mối nối đà nền bằng mộng đuôi én có vai, phần gỗ nằm dưới được siết bằng bu lông neo.

2. Vị trí nối thanh đỡ sàn nhỏ đặt tại tim cấu kiện đỡ của dầm sàn lớn.

3. Vị trí nối đà nền tránh phần lỗ thông gió dưới sàn.

4. Giằng được lắp sau khi hoàn thành chỉnh độ thẳng đứng và cố định phụ kiện liên kết cùng dầm giằng góc.

5. Đòn nóc và xà gồ của khung mái kiểu Nhật được khoét vị trí để gắn rui.', NULL, '1', 'Với mộng đuôi én đà nền, bu lông neo cần giữ phần gỗ phía trên theo cấu tạo tương ứng để chống bật mối nối. Lựa chọn 1 đặt bu lông vào phần dưới, không giữ đúng phần cần khóa. Cần hình dung trên/dưới của mộng, không chỉ nhớ tên mối nối.', '[{"term": "土台", "reading": "どだい", "meaning": "Đà nền"}, {"term": "アンカーボルト", "reading": "アンカーボルト", "meaning": "Bu lông neo"}, {"term": "垂木", "reading": "たるき", "meaning": "Rui mái"}]'::jsonb, 39);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Strategy', 40, '外壁の張り石工事において，湿式工法と比較した場合の乾式工法の特徴として，最も不適当なものはどれか。

1．石材の表面に衝撃が加わると破損しやすい。

2．凍結による被害を受けにくい。

3．地震時の躯体の挙動に追従しにくい。

4．エフロレッセンス（白華現象）が起こりにくい。

5．石材の熱変形を吸収できる。', 'Trong ốp đá tường ngoài, so với phương pháp ướt, đặc điểm nào của phương pháp khô không thích hợp nhất?

1. Đá dễ vỡ khi mặt đá chịu va đập.

2. Ít chịu hư hại do đóng băng.

3. Khó biến dạng theo chuyển động của kết cấu khi động đất.

4. Ít xảy ra hiện tượng kết tinh muối trắng (efflorescence).

5. Có thể hấp thụ biến dạng nhiệt của đá.', NULL, '3', 'Liên kết cơ khí và khe của phương pháp khô cho phép thích ứng chuyển vị tốt hơn phương pháp gắn cứng bằng vữa, nên lựa chọn 3 sai. Ít vữa sau đá cũng giảm cơ chế gây trắng muối và hư hại do nước đóng băng.', '[{"term": "乾式工法", "reading": "かんしきこうほう", "meaning": "Phương pháp khô"}, {"term": "湿式工法", "reading": "しっしきこうほう", "meaning": "Phương pháp ướt"}, {"term": "白華現象", "reading": "はっかげんしょう", "meaning": "Hiện tượng trắng muối"}]'::jsonb, 40);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Strategy', 41, '金属製折板葺に関する記述として，最も不適当なものはどれか。

1．タイトフレームと下地材との接合は，ボルト接合とした。

2．はぜ締め形折板は，本締めの前にタイトフレームの間を1mの間隔で部分締めを行った。

3．重ね形折板のけらばの変形防止材には，折板の3山ピッチ以上の長さのものを用いた。

4．棟包みと折板の隙間を塞ぐため，棟包みの水下側にエプロンを設けた。

5．重ね形折板のボルト孔は，呼出しポンチで開孔した。', 'Về lợp tấm kim loại gấp nếp, phát biểu nào không thích hợp nhất?

1. Liên kết thanh đỡ tight frame với vật liệu nền được thực hiện bằng bu lông.

2. Với tấm kiểu ghép mí, trước khi siết mí toàn bộ, siết cục bộ theo khoảng cách 1 m giữa các tight frame.

3. Với tấm kiểu chồng, vật chống biến dạng ở mép đầu hồi dài ít nhất bằng bước ba sóng tấm.

4. Để bịt khe giữa nẹp nóc và tấm mái, đặt tấm apron phía hạ lưu của nẹp nóc.

5. Lỗ bu lông của tấm kiểu chồng được tạo bằng dụng cụ đột lỗ.', NULL, '1', 'Tight frame được liên kết với kết cấu đỡ theo cấu tạo hàn quy định của phương pháp tiêu chuẩn này; mô tả dùng bu lông ở lựa chọn 1 không phù hợp. Đừng nhầm bu lông giữ tấm lợp với liên kết tight frame vào nền đỡ.', '[{"term": "折板葺", "reading": "せっぱんぶき", "meaning": "Lợp tấm gấp nếp"}, {"term": "はぜ締め", "reading": "はぜしめ", "meaning": "Siết mí"}, {"term": "棟包み", "reading": "むねづつみ", "meaning": "Nẹp che nóc"}]'::jsonb, 41);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Strategy', 42, 'アロー型ネットワーク工程表に関する用語の説明として，最も不適当なものはどれか。

1．ダミーとは，工程の最後に入れる予備日のことである。

2．フロートとは，作業の余裕時間のことである。

3．ノードとは，作業と作業を結合する点及び工程の開始点又は終了点のことである。

4．アクティビティとは，工事の工程を分割してできる工事活動の単位のことである。

5．クリティカルパスとは，開始結合点から終了結合点に至るまでの所要時間の合計が最も長いパスのことである。', 'Về thuật ngữ của biểu đồ tiến độ mạng mũi tên, giải thích nào không thích hợp nhất?

1. Công việc giả là ngày dự phòng đặt vào cuối tiến độ.

2. Độ dự trữ là thời gian dư của công việc.

3. Nút là điểm nối các công việc, cũng như điểm đầu hoặc điểm cuối của tiến độ.

4. Công việc là đơn vị hoạt động thi công tạo ra khi chia tiến trình công trình.

5. Đường găng là đường có tổng thời gian cần thiết dài nhất từ nút bắt đầu đến nút kết thúc.', NULL, '1', 'Công việc giả có thời lượng bằng 0, biểu diễn quan hệ phụ thuộc logic; không phải ngày dự phòng cuối tiến độ. Độ dự trữ và công việc giả là hai khái niệm khác nhau.', '[{"term": "ダミー", "reading": "ダミー", "meaning": "Công việc giả"}, {"term": "フロート", "reading": "フロート", "meaning": "Độ dự trữ thời gian"}, {"term": "クリティカルパス", "reading": "クリティカルパス", "meaning": "Đường găng"}]'::jsonb, 42);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Strategy', 43, '用語の定義に関する記述として，「建築基準法」上，誤っているものはどれか。

1．基礎は，構造耐力上主要な部分であるが，主要構造部ではない。

2．土地に定着する工作物のうち，屋根及び柱若しくは壁を有するものは，建築物である。

3．建築設備は，建築物に含まれない。

4．耐火建築物以外の建築物で，主要構造部を準耐火構造とし，外壁の開口部で延焼のおそれがある部分に防火戸その他の政令で定める防火設備を有するものは，準耐火建築物である。', 'Theo Luật Tiêu chuẩn xây dựng, phát biểu nào về định nghĩa thuật ngữ sai?

1. Móng là bộ phận quan trọng về khả năng chịu lực, nhưng không thuộc “bộ phận kết cấu chính”.

2. Trong các công trình gắn cố định với đất, công trình có mái và cột hoặc tường là công trình kiến trúc.

3. Thiết bị công trình không được bao gồm trong công trình kiến trúc.

4. Công trình không phải công trình chịu lửa, có các bộ phận kết cấu chính là kết cấu bán chịu lửa và có cửa chống cháy hoặc thiết bị phòng cháy khác theo nghị định tại các lỗ mở tường ngoài có nguy cơ cháy lan, là công trình bán chịu lửa.', NULL, '3', 'Định nghĩa công trình kiến trúc bao gồm thiết bị công trình, nên lựa chọn 3 sai. Các khái niệm “bộ phận kết cấu chính” và “bộ phận quan trọng về chịu lực” là các tập hợp pháp lý khác nhau; móng thuộc tập hợp thứ hai.', '[{"term": "建築設備", "reading": "けんちくせつび", "meaning": "Thiết bị công trình"}, {"term": "主要構造部", "reading": "しゅようこうぞうぶ", "meaning": "Bộ phận kết cấu chính"}, {"term": "延焼", "reading": "えんしょう", "meaning": "Cháy lan"}]'::jsonb, 43);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Strategy', 44, '居室の採光及び換気に関する記述として，「建築基準法」上，誤っているものはどれか。

1．居室の窓その他の開口部で採光に有効な部分の面積を算定する際，天窓は実際の面積よりも大きな面積を有する開口部として扱う。

2．劇場の客席には，政令で定める技術的基準に従って，換気設備を設けなければならない。

3．ホテルの客室には，採光のための窓その他の開口部を設けなければならない。

4．ふすま，障子その他随時開放することができるもので仕切られた2室は，居室の採光及び換気の規定の適用に当たっては，1室とみなす。', 'Theo Luật Tiêu chuẩn xây dựng, phát biểu nào về lấy sáng và thông gió phòng sử dụng sai?

1. Khi tính diện tích hữu hiệu lấy sáng của cửa sổ hoặc lỗ mở phòng sử dụng, cửa trời được coi là lỗ mở có diện tích lớn hơn diện tích thực.

2. Khu ghế ngồi nhà hát phải có thiết bị thông gió theo tiêu chuẩn kỹ thuật do nghị định quy định.

3. Phòng khách sạn phải có cửa sổ hoặc lỗ mở khác để lấy sáng.

4. Hai phòng được ngăn bằng cửa trượt fusuma, shoji hoặc bộ phận khác có thể mở bất cứ lúc nào được coi là một phòng khi áp dụng quy định lấy sáng và thông gió.', NULL, '3', 'Yêu cầu lỗ mở lấy sáng tự nhiên không áp dụng chung cho phòng khách sạn như phát biểu 3. Phải phân biệt yêu cầu lấy sáng theo loại phòng với yêu cầu thông gió; không suy rằng mọi phòng có người dùng đều bắt buộc cửa sổ lấy sáng.', '[{"term": "居室", "reading": "きょしつ", "meaning": "Phòng sử dụng thường xuyên"}, {"term": "採光", "reading": "さいこう", "meaning": "Lấy sáng"}, {"term": "天窓", "reading": "てんまど", "meaning": "Cửa trời"}]'::jsonb, 44);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Strategy', 45, '建設業の許可に関する記述として，「建設業法」上，誤っているものはどれか。

1．建築一式工事のうち延べ面積が150m²に満たない木造住宅を建設する工事のみを請け負う場合，建設業の許可を必要としない。

2．2以上の都道府県の区域内に営業所を設けて営業しようとする者が建設業の許可を受ける場合，国土交通大臣の許可を受けなければならない。

3．国又は地方公共団体が発注者である建設工事を請け負う者は，特定建設業の許可を受けなければならない。

4．建築一式工事のうち工事1件の請負代金の額が1,500万円に満たない工事のみを請け負う場合，建設業の許可を必要としない。', 'Theo Luật Ngành xây dựng, phát biểu nào về giấy phép kinh doanh xây dựng sai?

1. Nếu chỉ nhận xây nhà gỗ thuộc công trình xây dựng tổng hợp có tổng diện tích sàn dưới 150 m² thì không cần giấy phép kinh doanh xây dựng.

2. Người đặt cơ sở kinh doanh trong từ hai tỉnh/thành cấp tỉnh trở lên phải nhận giấy phép của Bộ trưởng Đất đai, Hạ tầng, Giao thông và Du lịch.

3. Người nhận công trình do Nhà nước hoặc chính quyền địa phương làm chủ đầu tư phải có giấy phép kinh doanh xây dựng đặc định.

4. Nếu chỉ nhận công trình xây dựng tổng hợp có giá trị hợp đồng mỗi công trình dưới 1.500万円 thì không cần giấy phép kinh doanh xây dựng.', NULL, '3', 'Giấy phép đặc định được xét theo việc nhà thầu chính giao thầu phụ và quy mô liên quan, không chỉ vì chủ đầu tư là Nhà nước. Lựa chọn 3 gán sai điều kiện. Vị trí cơ sở kinh doanh, không phải địa điểm thi công, quyết định cơ quan cấp phép.', '[{"term": "建設業の許可", "reading": "けんせつぎょうのきょか", "meaning": "Giấy phép kinh doanh xây dựng"}, {"term": "特定建設業", "reading": "とくていけんせつぎょう", "meaning": "Kinh doanh xây dựng đặc định"}, {"term": "営業所", "reading": "えいぎょうしょ", "meaning": "Cơ sở kinh doanh"}]'::jsonb, 45);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Strategy', 46, '建設工事の請負契約書に記載しなければならない事項として，「建設業法」上，定められていないものはどれか。

1．工事の履行に必要となる建設業の許可の種類及び許可番号

2．注文者が工事に使用する資材を提供するときは，その内容及び方法に関する定め

3．契約に関する紛争の解決方法

4．各当事者の履行の遅滞その他債務の不履行の場合における遅延利息，違約金その他の損害金', 'Theo Luật Ngành xây dựng, mục nào không được quy định là nội dung phải ghi trong hợp đồng nhận thầu xây dựng?

1. Loại giấy phép kinh doanh xây dựng và số giấy phép cần cho việc thực hiện công trình.

2. Nếu bên đặt hàng cung cấp vật liệu dùng cho công trình, quy định về nội dung và phương thức cung cấp.

3. Phương pháp giải quyết tranh chấp liên quan hợp đồng.

4. Lãi do chậm thực hiện, tiền phạt vi phạm và khoản bồi thường khác khi mỗi bên chậm thực hiện hoặc không thực hiện nghĩa vụ.', NULL, '1', 'Danh mục nội dung bắt buộc của hợp đồng bao gồm các mục 2, 3, 4; loại và số giấy phép như mục 1 không thuộc mục bắt buộc được hỏi. “Không bắt buộc ghi” không có nghĩa không được phép ghi thêm.', '[{"term": "請負契約書", "reading": "うけおいけいやくしょ", "meaning": "Hợp đồng nhận thầu"}, {"term": "紛争", "reading": "ふんそう", "meaning": "Tranh chấp"}, {"term": "債務不履行", "reading": "さいむふりこう", "meaning": "Không thực hiện nghĩa vụ"}]'::jsonb, 46);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Strategy', 47, '建設工事の現場における次の業務のうち，「労働安全衛生法」上，都道府県労働局長の登録を受けた者が行う技能講習を修了した者が就くことができる業務はどれか。ただし，道路上を走行させる運転を除くものとする。

1．建設用リフトの運転の業務

2．機体重量が2tのパワーショベルの運転の業務

3．つり上げ荷重が1tの移動式クレーンの玉掛けの業務

4．ゴンドラの操作の業務', 'Trong các công việc sau tại công trường, công việc nào người đã hoàn thành khóa huấn luyện kỹ năng do đơn vị được Cục trưởng Cục Lao động cấp tỉnh đăng ký tổ chức có thể đảm nhiệm theo Luật An toàn và vệ sinh lao động? Không bao gồm lái xe chạy trên đường.

1. Vận hành vận thăng xây dựng.

2. Vận hành máy xúc có khối lượng máy 2 t.

3. Móc buộc tải cho cần trục di động có tải trọng nâng 1 t.

4. Điều khiển sàn treo gondola.', NULL, '3', 'Móc buộc tải đối với thiết bị nâng có tải trọng nâng từ 1 t thuộc phạm vi huấn luyện kỹ năng tương ứng. Các công việc khác trong lựa chọn thuộc phạm vi giáo dục đặc biệt theo điều kiện của đề. Mốc tính là tải trọng nâng của thiết bị, không phải khối lượng vật đang móc.', '[{"term": "技能講習", "reading": "ぎのうこうしゅう", "meaning": "Huấn luyện kỹ năng"}, {"term": "玉掛け", "reading": "たまかけ", "meaning": "Móc buộc tải"}, {"term": "つり上げ荷重", "reading": "つりあげかじゅう", "meaning": "Tải trọng nâng"}]'::jsonb, 47);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Strategy', 48, '建設工事の現場において，元方安全衛生管理者を選任しなければならない常時就労する労働者の最少人員として，「労働安全衛生法施行令」上，正しいものはどれか。ただし，ずい道等の建設の仕事，橋梁の建設の仕事又は圧気工法による作業を行う仕事を除くものとする。

1．10人

2．20人

3．30人

4．50人', 'Theo Nghị định thi hành Luật An toàn và vệ sinh lao động, số người lao động thường xuyên tối thiểu tại công trường khiến phải chỉ định người quản lý an toàn và vệ sinh của nhà thầu chính là bao nhiêu? Không gồm xây dựng đường hầm, cầu hoặc công việc dùng phương pháp khí nén.

1. 10 người

2. 20 người

3. 30 người

4. 50 người', NULL, '4', 'Với nhóm xây dựng thông thường được hỏi, ngưỡng là 50 người. Một số nhóm đặc biệt có ngưỡng khác nhưng đề đã loại trừ chúng. Cần giữ nguyên điều kiện ngoại lệ trước khi chọn con số.', '[{"term": "元方安全衛生管理者", "reading": "もとかたあんぜんえいせいかんりしゃ", "meaning": "Người quản lý an toàn vệ sinh nhà thầu chính"}, {"term": "常時就労", "reading": "じょうじしゅうろう", "meaning": "Làm việc thường xuyên"}, {"term": "圧気工法", "reading": "あっきこうほう", "meaning": "Phương pháp khí nén"}]'::jsonb, 48);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Strategy', 49, '建設工事に係る次の資材のうち，「建設工事に係る資材の再資源化等に関する法律（建設リサイクル法）」上，特定建設資材に該当しないものはどれか。

1．木造住宅の改修工事に伴って生じた木材の端材

2．木造住宅の金属製建具の改修工事に伴って生じた金属くず

3．駐車場の解体撤去工事に伴って生じたコンクリート平板のガラ

4．駐車場の解体撤去工事に伴って生じた舗装用アスファルト・コンクリート塊', 'Trong các vật liệu liên quan công trình sau, loại nào không thuộc vật liệu xây dựng đặc định theo Luật Tái tài nguyên hóa vật liệu liên quan công trình xây dựng (Luật Tái chế xây dựng)?

1. Đầu mẩu gỗ phát sinh khi sửa nhà gỗ.

2. Phế liệu kim loại phát sinh khi sửa cửa kim loại của nhà gỗ.

3. Mảnh tấm bê tông phát sinh khi phá dỡ bãi đỗ xe.

4. Khối bê tông nhựa dùng làm mặt đường phát sinh khi phá dỡ bãi đỗ xe.', NULL, '2', 'Nhóm đặc định gồm bê tông, vật liệu gồm bê tông và thép, gỗ, bê tông nhựa. Phế liệu kim loại riêng ở lựa chọn 2 không thuộc danh mục này. Không thuộc danh mục đặc định không đồng nghĩa được bỏ qua việc quản lý chất thải.', '[{"term": "特定建設資材", "reading": "とくていけんせつしざい", "meaning": "Vật liệu xây dựng đặc định"}, {"term": "金属くず", "reading": "きんぞくくず", "meaning": "Phế liệu kim loại"}, {"term": "再資源化", "reading": "さいしげんか", "meaning": "Tái tài nguyên hóa"}]'::jsonb, 49);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Strategy', 50, '次の者のうち，「消防法」上，定められていないものはどれか。

1．特定高圧ガス取扱主任者

2．危険物取扱者

3．防火対象物点検資格者

4．防火管理者', 'Trong các chức danh sau, chức danh nào không được quy định trong Luật Phòng cháy?

1. Người phụ trách xử lý khí cao áp đặc định.

2. Người có chứng chỉ xử lý vật nguy hiểm.

3. Người có tư cách kiểm tra đối tượng phòng cháy.

4. Người quản lý phòng cháy.', NULL, '1', 'Chức danh liên quan khí cao áp thuộc hệ thống pháp luật an toàn khí cao áp, không phải chức danh của Luật Phòng cháy trong câu này. Các lựa chọn 2, 3, 4 thuộc hệ thống phòng cháy. Phân biệt luật quản lý theo loại nguy cơ.', '[{"term": "危険物取扱者", "reading": "きけんぶつとりあつかいしゃ", "meaning": "Người có chứng chỉ xử lý vật nguy hiểm"}, {"term": "防火管理者", "reading": "ぼうかかんりしゃ", "meaning": "Người quản lý phòng cháy"}, {"term": "消防法", "reading": "しょうぼうほう", "meaning": "Luật Phòng cháy"}]'::jsonb, 50);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 1, '音に関する記述として，最も不適当なものはどれか。

1．音の強さのレベルが60dBの同じ音源が2つ同時に存在する場合，音の強さのレベルは約120dBとなる。

2．1点から球面状に広がる音源の場合，音源からの距離が2倍になると，音の強さのレベルは約6dB減少する。

3．フラッターエコーとは，向かい合った壁同士等で音が多重反射する現象をいう。

4．反響とは，直接音と反射音が分離して聞こえる現象をいう。', 'Về âm, phát biểu nào không thích hợp nhất?

1. Nếu hai nguồn âm giống nhau, mỗi nguồn có mức cường độ âm 60 dB, cùng tồn tại thì mức cường độ âm khoảng 120 dB.

2. Với nguồn âm lan theo mặt cầu từ một điểm, khi khoảng cách đến nguồn tăng gấp đôi, mức cường độ âm giảm khoảng 6 dB.

3. Flutter echo là hiện tượng âm phản xạ nhiều lần giữa các bức tường đối diện hoặc bộ phận tương tự.

4. Tiếng vọng là hiện tượng nghe riêng biệt âm trực tiếp và âm phản xạ.', NULL, '1', 'Decibel là thang logarit: với hai nguồn độc lập có cùng mức 60 dB, tổng là 60 + 10 log₁₀2 ≈ 63 dB, không phải 120 dB. Không cộng trực tiếp các giá trị dB. Nguồn điểm có I tỉ lệ 1/r² nên tăng khoảng cách gấp đôi giảm khoảng 6 dB.', '[{"term": "音の強さ", "reading": "おとのつよさ", "meaning": "Cường độ âm"}, {"term": "反響", "reading": "はんきょう", "meaning": "Tiếng vọng"}, {"term": "音源", "reading": "おんげん", "meaning": "Nguồn âm"}]'::jsonb, 51);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 2, '鉄筋コンクリート構造における構造耐力上主要な部分である柱及び梁の配筋に関する記述として，最も不適当なものはどれか。

1．梁は，全スパンにわたり主筋を上下に配置した複筋梁とする。

2．梁は，圧縮側の鉄筋量を増やすと，クリープによるたわみが小さくなる。

3．柱の帯筋は，柱の上下端部より中央部の間隔を密にする。

4．柱の出隅部の主筋には，末端部にフックを付ける。', 'Về bố trí thép cột và dầm là những bộ phận quan trọng về khả năng chịu lực của kết cấu bê tông cốt thép, phát biểu nào không thích hợp nhất?

1. Dầm là dầm cốt kép, bố trí thép chủ phía trên và dưới trên toàn nhịp.

2. Tăng lượng thép phía chịu nén của dầm làm giảm độ võng do từ biến.

3. Đai cột được bố trí dày hơn ở phần giữa so với hai đầu trên và dưới cột.

4. Đầu cốt thép chủ ở góc ngoài cột được làm móc.', NULL, '3', 'Hai đầu cột thường chịu tác động lớn và cần đai dày hơn vùng giữa; lựa chọn 3 đảo vị trí. Đai giúp giữ thép chủ, kiềm chế bê tông và tăng khả năng chịu cắt, không chỉ là thép định vị.', '[{"term": "帯筋", "reading": "おびきん", "meaning": "Cốt đai cột"}, {"term": "複筋梁", "reading": "ふくきんばり", "meaning": "Dầm cốt kép"}, {"term": "クリープ", "reading": "クリープ", "meaning": "Từ biến"}]'::jsonb, 52);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 3, '図に示す単純梁ABの点Cに集中荷重P₁，点Dに集中荷重P₂がそれぞれ作用したとき，CD間に生じるせん断力の値の大きさとして，正しいものはどれか。

1．1kN

2．3kN

3．4kN

4．8kN

![Hình câu 3, năm 2026](images/2026_cau_03.png)', 'Khi tải tập trung P₁ tác dụng tại C và tải tập trung P₂ tác dụng tại D trên dầm đơn giản AB trong hình, giá trị nào đúng cho độ lớn lực cắt trên đoạn CD?

Dữ liệu hình: P₁ = 8 kN hướng xuống tại C; P₂ = 4 kN hướng xuống tại D; AC = 4 m; CD = 2 m; DB = 2 m.

1. 1 kN

2. 3 kN

3. 4 kN

4. 8 kN', NULL, '2', 'AB = 8 m. Cân bằng mômen quanh A: R_B × 8 = 8 × 4 + 4 × 6 = 56, nên R_B = 7 kN và R_A = 5 kN. Trên CD: V = R_A − P₁ = −3 kN, độ lớn 3 kN. Không trừ P₂ trước khi đi qua D.', '[{"term": "集中荷重", "reading": "しゅうちゅうかじゅう", "meaning": "Tải tập trung"}, {"term": "せん断力", "reading": "せんだんりょく", "meaning": "Lực cắt"}, {"term": "単純梁", "reading": "たんじゅんばり", "meaning": "Dầm đơn giản"}]'::jsonb, 53);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 4, '内装材料に関する記述として，最も不適当なものはどれか。

1．タイルカーペットは，バッキング材を裏打ちしたタイル状の敷物である。

2．ミディアムデンシティファイバーボード（MDF）は，植物繊維を主原料として成形熱圧製板したものである。

3．フレキシブル板は，セメントと無機質繊維を主原料とし，成形後に高圧プレスをかけたものである。

4．強化せっこうボードは，芯材のせっこうに油脂をしみ込ませ，強度を向上させたものである。', 'Về vật liệu nội thất, phát biểu nào không thích hợp nhất?

1. Thảm tấm là vật liệu trải sàn dạng viên có lớp backing ở mặt sau.

2. Tấm sợi mật độ trung bình (MDF) được tạo hình và ép nóng từ nguyên liệu chính là sợi thực vật.

3. Tấm flexible dùng xi măng và sợi vô cơ làm nguyên liệu chính, sau tạo hình được ép áp lực cao.

4. Tấm thạch cao tăng cường được tăng độ bền bằng cách ngấm dầu mỡ vào lõi thạch cao.', NULL, '4', 'Thạch cao tăng cường được bổ sung sợi và các thành phần phù hợp để tăng tính năng; ngấm dầu mỡ không phải cơ chế của loại này. Đừng nhầm tấm tăng cường với tấm được xử lý tăng khả năng chống ẩm.', '[{"term": "強化せっこうボード", "reading": "きょうかせっこうボード", "meaning": "Tấm thạch cao tăng cường"}, {"term": "芯材", "reading": "しんざい", "meaning": "Vật liệu lõi"}, {"term": "植物繊維", "reading": "しょくぶつせんい", "meaning": "Sợi thực vật"}]'::jsonb, 54);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 5, '換気に関する記述として，最も不適当なものはどれか。

1．定常状態で室内汚染物質の発生量が等しければ，室容積の大小によらず，必要換気量は一定になる。

2．流入口から室内に入った空気の空気齢が短いほど，その空気は新鮮といえる。

3．局所換気方式とは，局所的に発生する汚染物質を発生源近くで捕集して排出する換気のことである。

4．第3種機械換気方式は，給気側にのみ送風機を設け，外気に比べて常に室内を正圧に保つことができる。', 'Về thông gió, phát biểu nào không thích hợp nhất?

1. Ở trạng thái ổn định, nếu lượng chất ô nhiễm phát sinh trong phòng bằng nhau thì lưu lượng thông gió cần thiết không đổi, bất kể thể tích phòng lớn nhỏ.

2. Tuổi không khí của luồng khí đi vào phòng từ cửa cấp càng ngắn thì không khí đó càng tươi mới.

3. Thông gió cục bộ là thu gom và thải chất ô nhiễm phát sinh cục bộ ngay gần nguồn.

4. Thông gió cơ khí loại 3 chỉ đặt quạt ở phía cấp khí và luôn giữ áp suất phòng dương so với ngoài trời.', NULL, '4', 'Loại 3 dùng hút cưỡng bức và cấp tự nhiên, thường tạo áp suất âm. Mô tả ở lựa chọn 4 là loại 2: cấp cưỡng bức, thải tự nhiên. Loại 1 cơ khí cả cấp và hút. Phân biệt lưu lượng thông gió với số lần trao đổi không khí.', '[{"term": "換気量", "reading": "かんきりょう", "meaning": "Lưu lượng thông gió"}, {"term": "空気齢", "reading": "くうきれい", "meaning": "Tuổi không khí"}, {"term": "正圧", "reading": "せいあつ", "meaning": "Áp suất dương"}]'::jsonb, 55);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 6, '採光に関する記述として，最も不適当なものはどれか。

1．昼光率とは，室内のある点の天空光による照度を，全天空照度で除したものである。

2．昼光率は，窓等の採光部の立体角投射率によって異なる。

3．室内のある点における昼光率は，時刻や天候によって変化する。

4．室内に要求される基準昼光率は，居間より事務室のほうが高い。', 'Về lấy sáng, phát biểu nào không thích hợp nhất?

1. Hệ số ánh sáng ban ngày là độ rọi do ánh sáng bầu trời tại một điểm trong phòng chia độ rọi toàn bầu trời.

2. Hệ số ánh sáng ban ngày khác nhau theo hệ số chiếu góc khối của bộ phận lấy sáng như cửa sổ.

3. Hệ số ánh sáng ban ngày tại một điểm trong phòng thay đổi theo thời điểm và thời tiết.

4. Hệ số ánh sáng ban ngày tiêu chuẩn yêu cầu trong văn phòng cao hơn phòng khách.', NULL, '3', 'Hệ số ánh sáng ban ngày là tỷ số dưới điều kiện bầu trời quy ước; nó chủ yếu phản ánh hình học và đặc tính căn phòng, không thay đổi theo thời gian/thời tiết như độ rọi thực tế. Lựa chọn 3 nhầm tỷ số quy ước với lượng ánh sáng tức thời.', '[{"term": "昼光率", "reading": "ちゅうこうりつ", "meaning": "Hệ số ánh sáng ban ngày"}, {"term": "天空光", "reading": "てんくうこう", "meaning": "Ánh sáng bầu trời"}, {"term": "全天空照度", "reading": "ぜんてんくうしょうど", "meaning": "Độ rọi toàn bầu trời"}]'::jsonb, 56);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 7, '鉄骨構造に関する記述として，最も不適当なものはどれか。

1．鉄骨構造の柱は，鉄筋コンクリート構造の柱に比べ，小さな断面で大きな荷重に耐えることができる。

2．鉄骨構造の架構は，鉄筋コンクリート構造の架構と比べ，変形能力が高い。

3．大空間を必要とする建築物に用いる長大な梁は，トラス梁とすることで軽量化を図ることができる。

4．軽量鉄骨構造に用いる軽量形鋼は，通常の形鋼に比べ，部材がねじれにくく局部座屈に強い。', 'Về kết cấu thép, phát biểu nào không thích hợp nhất?

1. So với cột bê tông cốt thép, cột thép có thể chịu tải lớn với tiết diện nhỏ.

2. Khung thép có khả năng biến dạng cao hơn khung bê tông cốt thép.

3. Dầm dài dùng cho công trình cần không gian lớn có thể được làm nhẹ bằng cấu tạo dầm giàn.

4. Thép hình nhẹ dùng trong kết cấu thép nhẹ khó xoắn và chống mất ổn định cục bộ tốt hơn thép hình thông thường.', NULL, '4', 'Thép hình nhẹ thành mỏng nhạy với xoắn và mất ổn định cục bộ; lựa chọn 4 đảo đặc điểm. Cường độ vật liệu không loại bỏ ảnh hưởng của độ mảnh thành và hình dạng tiết diện.', '[{"term": "軽量形鋼", "reading": "けいりょうかたこう", "meaning": "Thép hình nhẹ"}, {"term": "局部座屈", "reading": "きょくぶざくつ", "meaning": "Mất ổn định cục bộ"}, {"term": "トラス梁", "reading": "トラスばり", "meaning": "Dầm giàn"}]'::jsonb, 57);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 8, '鉄骨構造の部材に関する記述として，最も不適当なものはどれか。

1．ダイアフラムは，梁から柱へ応力を伝達するため，仕口部に設ける部材である。

2．フィラープレートは，厚さの異なる板をボルト接合する際に，板厚の差による隙間を少なくするために設ける部材である。

3．合成梁に用いる頭付きスタッドは，鉄骨梁と鉄筋コンクリート床スラブが一体となるように設ける部材である。

4．裏当て金は，鉄骨建方のために，鉄骨柱等に仮に取り付ける部材である。', 'Về các bộ phận kết cấu thép, phát biểu nào không thích hợp nhất?

1. Vách diaphragm đặt ở nút liên kết để truyền ứng lực từ dầm sang cột.

2. Bản chêm filler plate được bố trí để giảm khe do chênh chiều dày khi nối bu lông các tấm có chiều dày khác nhau.

3. Đinh hàn có đầu dùng cho dầm liên hợp giúp dầm thép và bản sàn bê tông cốt thép làm việc thành một thể.

4. Bản lót hàn là bộ phận gắn tạm vào cột thép và cấu kiện khác để lắp dựng.', NULL, '4', 'Bản lót hàn（裏当て金）đỡ và định hình chân mối hàn ngấu; bộ phận phục vụ nối tạm khi dựng là tai lắp dựng. Lựa chọn 4 gán chức năng lắp dựng cho bản lót hàn.', '[{"term": "裏当て金", "reading": "うらあてがね", "meaning": "Bản lót hàn"}, {"term": "仕口部", "reading": "しぐちぶ", "meaning": "Nút liên kết"}, {"term": "合成梁", "reading": "ごうせいばり", "meaning": "Dầm liên hợp"}]'::jsonb, 58);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 9, '基礎杭に関する記述として，最も不適当なものはどれか。

1．鋼杭は，地中での腐食への対処法として，肉厚を厚くする方法，塗装やライニングを行う方法等が用いられる。

2．拡径断面を有する遠心力高強度プレストレストコンクリート杭（ST杭）は，拡径部を上側にし中杭として使用することで，上杭の径を大きくすることができる。

3．節部付きの遠心力高強度プレストレストコンクリート杭（節杭）は，主として，その先端の支持力によって上部構造からの荷重を支える杭として用いられる。

4．外殻鋼管付きのコンクリート杭（SC杭）は，大きな水平力が作用する杭に適している。', 'Về cọc móng, phát biểu nào không thích hợp nhất?

1. Các biện pháp chống ăn mòn cọc thép trong đất gồm tăng chiều dày thành, sơn hoặc làm lớp lót phủ.

2. Cọc bê tông ly tâm cường độ cao dự ứng lực có tiết diện mở rộng (cọc ST) được dùng làm đoạn cọc giữa với phần mở rộng hướng lên trên, nhờ đó đoạn cọc phía trên có thể có đường kính lớn hơn.

3. Cọc bê tông ly tâm cường độ cao dự ứng lực có các đốt nhô chủ yếu đỡ tải công trình bằng sức chịu tải đầu cọc.

4. Cọc bê tông có ống thép ngoài (cọc SC) thích hợp khi chịu lực ngang lớn.', NULL, '3', 'Các đốt nhô tăng tương tác với đất và sức kháng quanh thân, nên không mô tả loại này chủ yếu dựa vào đầu cọc như lựa chọn 3. Phân biệt cơ chế sức kháng thân với sức kháng mũi.', '[{"term": "基礎杭", "reading": "きそぐい", "meaning": "Cọc móng"}, {"term": "節杭", "reading": "ふしくい", "meaning": "Cọc có đốt nhô"}, {"term": "水平力", "reading": "すいへいりょく", "meaning": "Lực ngang"}]'::jsonb, 59);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 10, '建築物の構造設計における荷重及び外力に関する記述として，最も不適当なものはどれか。

1．積雪荷重は，雪下ろしを行う慣習のある地方では，雪下ろしの実況に応じて垂直積雪量を減らして計算することができる。

2．事務室の積載荷重の値は，一般に，大梁，柱又は基礎の構造計算用より，床の構造計算用のほうを大きくする。

3．地震層せん断力は，建築物の弾性域における固有周期及び地盤の種類に応じて算定する。

4．風圧力は，地震力と同時に作用するものとして計算する。', 'Về tải trọng và ngoại lực trong thiết kế kết cấu công trình, phát biểu nào không thích hợp nhất?

1. Ở nơi có tập quán dọn tuyết mái, có thể tính tải tuyết bằng cách giảm chiều sâu tuyết đứng theo tình hình dọn tuyết thực tế.

2. Tải sử dụng của văn phòng nói chung lấy cho tính sàn lớn hơn giá trị dùng tính dầm chính, cột hoặc móng.

3. Lực cắt tầng do động đất được tính theo chu kỳ riêng trong miền đàn hồi của công trình và loại nền đất.

4. Áp lực gió được tính là tác dụng đồng thời với lực động đất.', NULL, '4', 'Các tổ hợp tải tiêu chuẩn xét gió và động đất theo trường hợp tương ứng, không cộng đồng thời chúng như lựa chọn 4. Không chọn theo suy nghĩ “cộng mọi tải là an toàn hơn”; phải xét đúng tổ hợp quy định.', '[{"term": "積載荷重", "reading": "せきさいかじゅう", "meaning": "Tải sử dụng"}, {"term": "固有周期", "reading": "こゆうしゅうき", "meaning": "Chu kỳ riêng"}, {"term": "風圧力", "reading": "ふうあつりょく", "meaning": "Áp lực gió"}]'::jsonb, 60);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 11, '図に示す単純梁ABの点Cにモーメント荷重Mが作用したときの曲げモーメント図として，正しいものはどれか。ただし，曲げモーメントは，材の引張側に描くものとする。

1．2．

3．4．

![Hình câu 11, năm 2026](images/2026_cau_11.png)', 'Khi mômen tải M tác dụng tại điểm C của dầm đơn giản AB trong hình, biểu đồ mômen uốn nào đúng?

Quy ước: vẽ mômen uốn về phía chịu kéo của cấu kiện.

Dữ liệu hình: AC = l/2, CB = l/2; mômen M tại C quay theo chiều kim đồng hồ. Các lựa chọn 1, 2, 3, 4 là bốn biểu đồ trong hình.', NULL, '1', 'Cặp phản lực có độ lớn M/l: R_A = −M/l, R_B = M/l. Mômen biến thiên tuyến tính trên hai nửa và nhảy một lượng M ở C do mômen tập trung. Theo phía chịu kéo quy định, biểu đồ 1 đúng. Các hình có đoạn mômen hằng không phù hợp vì lực cắt trên mỗi đoạn khác 0.', '[{"term": "モーメント荷重", "reading": "モーメントかじゅう", "meaning": "Tải mômen"}, {"term": "曲げモーメント図", "reading": "まげモーメントず", "meaning": "Biểu đồ mômen uốn"}, {"term": "引張側", "reading": "ひっぱりがわ", "meaning": "Phía chịu kéo"}]'::jsonb, 61);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 12, '鋼及び鋼材に関する記述として，最も不適当なものはどれか。

1．鋼のヤング係数は，約2.05×10⁵N/mm²である。

2．鋼の密度は，約2.3g/cm³である。

3．一般構造用軽量形鋼は，SSC材と呼ばれ，冷間成形された軽量形鋼である。

4．建築構造用炭素鋼鋼管は，STKN材と呼ばれ，材質をSN材と同等とした円形鋼管である。', 'Về thép và vật liệu thép, phát biểu nào không thích hợp nhất?

1. Môđun Young của thép khoảng 2,05 × 10⁵ N/mm².

2. Khối lượng riêng của thép khoảng 2,3 g/cm³.

3. Thép hình nhẹ dùng cho kết cấu thông thường được gọi là SSC, là thép hình nhẹ tạo hình nguội.

4. Ống thép carbon dùng cho kết cấu xây dựng gọi là STKN, là ống tròn có tính chất vật liệu tương đương SN.', NULL, '2', 'Khối lượng riêng của thép khoảng 7,85 g/cm³, không phải 2,3 g/cm³. Giá trị 2,3 gần với một số vật liệu khoáng/bê tông; không áp dụng cho thép. Môđun Young không phải khối lượng riêng.', '[{"term": "密度", "reading": "みつど", "meaning": "Khối lượng riêng"}, {"term": "冷間成形", "reading": "れいかんせいけい", "meaning": "Tạo hình nguội"}, {"term": "炭素鋼鋼管", "reading": "たんそこうこうかん", "meaning": "Ống thép carbon"}]'::jsonb, 62);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 13, 'タイルに関する記述として，最も不適当なものはどれか。

1．ラスター釉とは，光彩を発するようにした釉薬である。

2．マット釉とは，つや消し効果のある釉薬である。

3．湿式タイルとは，粉末状の土をプレスで成形し焼成したタイルである。

4．面取タイルとは，側面を丸く加工し出隅等に使用するタイルである。', 'Về gạch ốp lát, phát biểu nào không thích hợp nhất?

1. Men luster là men tạo ánh màu óng.

2. Men matt là men có hiệu ứng không bóng.

3. Gạch tạo hình ướt là gạch được ép từ đất dạng bột rồi nung.

4. Gạch bo cạnh là gạch có mặt bên được gia công tròn, dùng ở góc ngoài và vị trí tương tự.', NULL, '3', 'Ép bột đất là phương pháp tạo hình khô. Tạo hình ướt sử dụng đất ở trạng thái dẻo, thường đùn hoặc tạo hình tương ứng. Lựa chọn 3 gán tên phương pháp ướt cho quy trình khô.', '[{"term": "釉薬", "reading": "ゆうやく", "meaning": "Men gốm"}, {"term": "湿式タイル", "reading": "しっしきタイル", "meaning": "Gạch tạo hình ướt"}, {"term": "焼成", "reading": "しょうせい", "meaning": "Nung"}]'::jsonb, 63);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 14, 'シーリング材の特徴に関する記述として，最も不適当なものはどれか。

1．ポリイソブチレン系シーリング材は，耐熱性が良好である。

2．アクリルウレタン系シーリング材は，ガラス回り目地に適している。

3．シリコーン系シーリング材は，目地周辺を汚染することがある。

4．アクリル系シーリング材は，未硬化の状態では雨に流されやすい。', 'Về đặc điểm vật liệu trám khe, phát biểu nào không thích hợp nhất?

1. Vật liệu trám polyisobutylene có tính chịu nhiệt tốt.

2. Vật liệu trám acrylic urethane thích hợp cho mạch quanh kính.

3. Vật liệu trám silicone có thể làm bẩn vùng quanh mạch.

4. Vật liệu trám acrylic dễ bị nước mưa cuốn đi khi chưa đóng rắn.', NULL, '2', 'Acrylic urethane không phải lựa chọn thích hợp chung cho mạch quanh kính theo phân loại này; cần loại tương thích kính và điều kiện mạch. Silicone có thể gây bẩn do thành phần di chuyển, dù có nhiều tính năng tốt. Không đồng nhất mọi loại “urethane”.', '[{"term": "シーリング材", "reading": "シーリングざい", "meaning": "Vật liệu trám khe"}, {"term": "目地", "reading": "めじ", "meaning": "Mạch/khe"}, {"term": "未硬化", "reading": "みこうか", "meaning": "Chưa đóng rắn"}]'::jsonb, 64);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 15, 'アスファルト舗装工事に関する記述として，最も不適当なものはどれか。

1．路床は，地盤が軟弱な場合を除いて，現地盤の土をそのまま十分に締め固める。

2．路盤は，舗装路面に作用する荷重を分散させて路床に伝えるものである。

3．プライムコートは，路床の仕上がり面を保護し，路床と路盤との接着性を向上させる。

4．タックコートは，基層と表層を密着し，一体化する役割を持っている。', 'Về thi công mặt đường bê tông nhựa, phát biểu nào không thích hợp nhất?

1. Trừ trường hợp nền đất yếu, đất hiện có được đầm đủ chặt làm nền đường.

2. Móng đường phân tán tải tác dụng trên mặt đường và truyền xuống nền đường.

3. Lớp prime coat bảo vệ mặt hoàn thiện của nền đường và tăng bám dính giữa nền đường với móng đường.

4. Lớp tack coat giúp lớp cơ sở và lớp mặt bám chặt, làm việc thành một thể.', NULL, '3', 'Prime coat được tưới lên mặt móng đường, không phải nền đất đường như lựa chọn 3. Tack coat tạo bám dính giữa các lớp bê tông nhựa. Cần phân biệt 路床 (nền đường) và 路盤 (móng đường).', '[{"term": "路床", "reading": "ろしょう", "meaning": "Nền đường"}, {"term": "路盤", "reading": "ろばん", "meaning": "Móng đường"}, {"term": "舗装", "reading": "ほそう", "meaning": "Kết cấu mặt đường"}]'::jsonb, 65);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 16, '構内電気設備の名称とその配線用図記号の組合せとして，最も不適当なものはどれか。

1．避難口誘導灯

2．屋外灯

3．壁付コンセント

4．分電盤

![Hình câu 16, năm 2026](images/2026_cau_16.png)', 'Cặp tên thiết bị điện trong khuôn viên và ký hiệu bản vẽ đi dây nào không thích hợp nhất?

1. Đèn chỉ dẫn cửa thoát nạn — ký hiệu hình tương ứng ở lựa chọn 1.

2. Đèn ngoài trời — ký hiệu hình tương ứng ở lựa chọn 2.

3. Ổ cắm gắn tường — ký hiệu hình tương ứng ở lựa chọn 3.

4. Tủ phân phối điện — ký hiệu hình tương ứng ở lựa chọn 4.', NULL, '4', 'Hình chữ nhật có hai đường chéo ở lựa chọn 4 biểu thị 配電盤 (tủ phân phối nguồn), khác với 分電盤 (tủ phân phối nhánh) được ghi trong đề. Cần đối chiếu cả dấu bên trong khung; không chỉ nhận ra “hình chữ nhật là tủ”. Ba ký hiệu còn lại khớp tên trong đề.', '[{"term": "配線用図記号", "reading": "はいせんようずきごう", "meaning": "Ký hiệu bản vẽ đi dây"}, {"term": "避難口誘導灯", "reading": "ひなんぐちゆうどうとう", "meaning": "Đèn chỉ dẫn cửa thoát nạn"}, {"term": "分電盤", "reading": "ぶんでんばん", "meaning": "Tủ phân phối điện"}]'::jsonb, 66);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 17, '空気調和設備に関する記述として，最も不適当なものはどれか。

1．定風量単一ダクト方式は，一定の風量で送風するシステムで，負荷変動の異なる複数の空間に適している。

2．放射暖房方式は，設置したパネルや埋設した配管に温水や蒸気を通すこと等により，加熱された放熱体からの放射熱を利用する方式である。

3．ファンコイルユニットは，熱源機器でつくられた冷水や温水の供給を受け，冷暖房を行う機器である。

4．全熱交換器は，換気のために排出する室内空気が持つ熱量を回収する装置である。', 'Về thiết bị điều hòa không khí, phát biểu nào không thích hợp nhất?

1. Hệ thống một ống gió lưu lượng không đổi thổi gió với lưu lượng cố định, thích hợp cho nhiều không gian có biến động tải khác nhau.

2. Sưởi bức xạ sử dụng nhiệt bức xạ từ bộ phận đã được nung nóng bằng cách cho nước nóng hoặc hơi đi qua tấm lắp đặt hoặc ống chôn sẵn.

3. Fan coil unit nhận nước lạnh hoặc nóng do thiết bị nguồn nhiệt tạo ra để làm lạnh, sưởi.

4. Bộ trao đổi nhiệt toàn phần thu hồi nhiệt chứa trong không khí trong phòng thải ra để thông gió.', NULL, '1', 'Hệ một ống gió lưu lượng không đổi khó điều khiển riêng nhiều vùng có biến động tải khác nhau. Lựa chọn 1 mô tả sai tính phù hợp. Phân biệt lưu lượng cố định với điều chỉnh riêng theo tải của từng vùng.', '[{"term": "定風量", "reading": "ていふうりょう", "meaning": "Lưu lượng gió không đổi"}, {"term": "放射暖房", "reading": "ほうしゃだんぼう", "meaning": "Sưởi bức xạ"}, {"term": "全熱交換器", "reading": "ぜんねつこうかんき", "meaning": "Bộ trao đổi nhiệt toàn phần"}]'::jsonb, 67);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 18, '遣方及び墨出しに関する記述として，最も不適当なものはどれか。

1．遣方を設けて，建物の高低，位置，方向，心の基準を明確にした。

2．ベンチマークは，複数設置により相互の誤差が生じるため，設置は1か所とした。

3．通り心，高低のベンチマーク等の基準墨については，図面化し，墨出し基準図を作成した。

4．高さの基準墨は，各階基準床仕上げ面から1m上がりとした。', 'Về giàn định vị và bật mực, phát biểu nào không thích hợp nhất?

1. Lập giàn định vị để xác định rõ mốc cao độ, vị trí, hướng và tim của công trình.

2. Vì đặt nhiều mốc cao độ sẽ phát sinh sai số giữa các mốc, chỉ đặt một mốc.

3. Các mốc mực như tim trục và mốc cao độ được thể hiện trên bản vẽ để lập bản vẽ chuẩn bật mực.

4. Mốc mực cao độ được đặt cao hơn mặt hoàn thiện sàn chuẩn mỗi tầng 1 m.', NULL, '2', 'Cần nhiều mốc đủ để kiểm tra chéo và dự phòng mất mốc; một mốc duy nhất không cho phép phát hiện dịch chuyển. Mốc phải được thống nhất và kiểm tra, chứ không tránh sai số bằng cách bỏ việc kiểm tra chéo.', '[{"term": "ベンチマーク", "reading": "ベンチマーク", "meaning": "Mốc cao độ"}, {"term": "通り心", "reading": "とおりしん", "meaning": "Tim trục"}, {"term": "基準墨", "reading": "きじゅんずみ", "meaning": "Mực chuẩn"}]'::jsonb, 68);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 19, '既製コンクリート杭工事に関する記述として，最も不適当なものはどれか。

1．セメントミルク工法において，根固め液は，あらかじめ掘削した孔に杭を挿入した後に注入する。

2．セメントミルク工法において，掘削中の孔壁の崩壊を防ぐための掘削液は，一般にベントナイト泥水を使用する。

3．中掘り根固め工法において，杭の中空部に挿入したアースオーガーで掘削しながら杭を設置した後，根固め液を注入する。

4．プレボーリング拡大根固め工法において，杭周固定液は，杭と周囲の地盤との摩擦力を確保するために使用する。', 'Về thi công cọc bê tông đúc sẵn, phát biểu nào không thích hợp nhất?

1. Trong phương pháp sữa xi măng, dung dịch gia cố mũi được bơm sau khi đưa cọc vào hố đã khoan trước.

2. Trong phương pháp sữa xi măng, dung dịch khoan để ngăn thành hố sụp khi khoan thường là bùn bentonite.

3. Trong phương pháp khoan trong lòng và gia cố mũi, sau khi lắp cọc vừa khoan bằng vít đất trong lỗ rỗng cọc, bơm dung dịch gia cố mũi.

4. Trong phương pháp khoan trước mở rộng gia cố mũi, dung dịch cố định quanh cọc dùng để bảo đảm lực ma sát giữa cọc và nền đất quanh cọc.', NULL, '1', 'Ở phương pháp sữa xi măng khoan trước, xử lý gia cố mũi được thực hiện trước khi đưa cọc vào theo trình tự tương ứng. Lựa chọn 1 đảo trình tự này. Đừng lẫn với phương pháp khoan trong lòng cọc ở lựa chọn 3.', '[{"term": "根固め液", "reading": "ねがためえき", "meaning": "Dung dịch gia cố mũi"}, {"term": "既製コンクリート杭", "reading": "きせいコンクリートぐい", "meaning": "Cọc bê tông đúc sẵn"}, {"term": "掘削", "reading": "くっさく", "meaning": "Đào/khoan đất"}]'::jsonb, 69);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 20, '型枠工事に関する記述として，最も不適当なものはどれか。

1．階段が取り付く壁型枠は，敷き並べた型枠パネル上に現寸で墨出しをしてから加工した。

2．横に長い窓開口の腰壁部分のふたには，コンクリートの充填を確認するため，両端部に開口を設けた。

3．埋込み金物やボックス類は，コンクリートの打込み時に移動しないように，せき板に堅固に取り付けた。

4．外周梁の側型枠の上部は，コンクリートの側圧による変形防止のため，スラブ引き金物で固定した。', 'Về công tác ván khuôn, phát biểu nào không thích hợp nhất?

1. Ván khuôn tường nơi cầu thang nối vào được gia công sau khi bật mực kích thước thực lên các tấm ván khuôn đã trải ra.

2. Nắp phần tường dưới cửa sổ dài theo ngang được mở lỗ ở hai đầu để xác nhận bê tông đã điền đầy.

3. Phụ kiện chôn sẵn và hộp được gắn chắc vào ván khuôn để không di chuyển khi đổ bê tông.

4. Phần trên của ván khuôn bên dầm ngoài được cố định bằng phụ kiện kéo sàn để tránh biến dạng do áp lực ngang bê tông.', NULL, '2', 'Phần giữa của đoạn tường dài dễ khó kiểm tra điền đầy; chỉ bố trí lỗ ở hai đầu không đáp ứng cấu tạo kiểm tra cần thiết. Cần lỗ kiểm tra/thoát khí tại vị trí thích hợp, đặc biệt giữa đoạn dài. Đề nhấn mạnh cửa sổ dài theo ngang.', '[{"term": "型枠", "reading": "かたわく", "meaning": "Ván khuôn"}, {"term": "充填", "reading": "じゅうてん", "meaning": "Điền đầy"}, {"term": "側圧", "reading": "そくあつ", "meaning": "Áp lực ngang"}]'::jsonb, 70);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 21, 'トルシア形高力ボルト接合に関する記述として，最も不適当なものはどれか。

1．ボルトの本締めは，ピンテールが破断するまで締め付けた。

2．ボルトの締付けは，ボルト群ごとに継手の中央部より周辺部に向かう順序で行った。

3．ボルトの首下長さは，締付け長さにナットと座金の高さを加えた寸法とした。

4．ナット側の座金は，座金の内側面取部がナットに接する側に取り付けた。', 'Về liên kết bu lông cường độ cao kiểu torque-shear, phát biểu nào không thích hợp nhất?

1. Siết cuối bu lông cho tới khi đuôi pin tail đứt.

2. Siết từng nhóm bu lông theo thứ tự từ giữa mối nối ra ngoại vi.

3. Chiều dài dưới đầu bu lông bằng chiều dài kẹp cộng chiều cao đai ốc và vòng đệm.

4. Vòng đệm phía đai ốc được lắp với phần vát mép trong tiếp xúc phía đai ốc.', NULL, '3', 'Chiều dài dưới đầu còn phải có phần cộng thêm cần thiết, kể cả phần ren nhô và cấu tạo riêng của bu lông torque-shear; không chỉ cộng chiều dày kẹp, đai ốc và vòng đệm. Chọn chiều dài theo bảng tiêu chuẩn loại bu lông, không bỏ phần dự phòng cấu tạo.', '[{"term": "首下長さ", "reading": "くびしたながさ", "meaning": "Chiều dài dưới đầu bu lông"}, {"term": "本締め", "reading": "ほんじめ", "meaning": "Siết cuối"}, {"term": "座金", "reading": "ざがね", "meaning": "Vòng đệm"}]'::jsonb, 71);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 22, '木造在来軸組構法に関する記述として，最も不適当なものはどれか。

1．束立て床組の大引の継手位置は，床束心とした。

2．根太掛けの継手位置は，柱心とした。

3．胴差の継手位置は，梁及び筋かいを受ける柱間を避けた。

4．垂木の継手位置は，母屋の上で乱に継いだ。', 'Về phương pháp khung gỗ truyền thống, phát biểu nào không thích hợp nhất?

1. Vị trí nối dầm sàn lớn trong hệ sàn có cột đỡ đặt tại tim cột đỡ sàn.

2. Vị trí nối thanh đỡ đầu joist đặt tại tim cột.

3. Vị trí nối đà ngang tầng tránh khoảng cột nhận dầm và giằng.

4. Rui được nối lệch nhau trên xà gồ.', NULL, '1', 'Mối nối dầm sàn lớn được đặt nhô khỏi tim cột đỡ sàn khoảng 150 mm, không đặt ngay tim như lựa chọn 1. Vị trí này đi cùng hình dạng mối nối và cách cố định quy định. Không áp dụng chung quy tắc “mọi mối nối đều ở tim gối” cho mọi cấu kiện gỗ.', '[{"term": "大引", "reading": "おおびき", "meaning": "Dầm sàn lớn"}, {"term": "床束", "reading": "ゆかづか", "meaning": "Cột đỡ sàn"}, {"term": "胴差", "reading": "どうさし", "meaning": "Đà ngang tầng"}]'::jsonb, 72);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 23, 'シーリング工事に関する記述として，最も不適当なものはどれか。

1．マスキングテープは，シーリング材のへら仕上げ終了後，直ちに取り除いた。

2．裏面に粘着剤が付いているバックアップ材は，目地幅より1mmから2mm程度小さい幅のものを使用した。

3．充填箇所以外の部分に付着したシリコーン系シーリング材は，硬化する前に直ちに除去した。

4．ノンワーキングジョイントとなるコンクリートの打継ぎ目地は，シーリング材の充填深さの最小値を10mmとした。', 'Về thi công trám khe, phát biểu nào không thích hợp nhất?

1. Băng che được gỡ ngay sau khi hoàn thành miết vật liệu trám.

2. Vật liệu chèn lưng có keo mặt sau được chọn bề rộng nhỏ hơn bề rộng khe khoảng 1–2 mm.

3. Vật liệu trám silicone dính ngoài vùng cần trám được loại bỏ ngay trước khi đóng rắn.

4. Với mạch ngừng bê tông là khe không chuyển động, chiều sâu trám tối thiểu là 10 mm.', NULL, '3', 'Silicone dính vào vùng không trám nên để đóng rắn rồi gỡ theo phương pháp phù hợp; lau khi chưa cứng có thể làm lan bẩn. Phân biệt gỡ băng che ngay sau miết với xử lý silicone đã dính ngoài mạch.', '[{"term": "マスキングテープ", "reading": "マスキングテープ", "meaning": "Băng che"}, {"term": "バックアップ材", "reading": "バックアップざい", "meaning": "Vật liệu chèn lưng khe"}, {"term": "へら仕上げ", "reading": "へらしあげ", "meaning": "Hoàn thiện bằng bay miết"}]'::jsonb, 73);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 24, 'タイル張りに関する記述として，最も不適当なものはどれか。

1．有機系接着剤張りにおいて，タイル表面に付着した接着剤は，表面が粗いタイルであったため，硬化した後に砂消しゴムを使って削り取った。

2．床タイル張りにおいて，張付け面積が小さい下地は，セメント1に対して砂3の貧調合で硬練りの敷モルタルとした。

3．壁のモザイクタイル張りにおいて，張付けモルタルの1回に塗り付ける面積は，タイル工1人当たり3m²以内とした。

4．壁タイル面の伸縮調整目地は，下地コンクリートのひび割れ誘発目地を避けた位置に設けた。', 'Về ốp lát gạch, phát biểu nào không thích hợp nhất?

1. Trong dán gạch bằng keo hữu cơ, keo dính trên mặt gạch nhám được để cứng rồi mài bỏ bằng tẩy nhám.

2. Với lát sàn, nền có diện tích lát nhỏ sử dụng vữa lót ít xi măng và trộn khô cứng, tỷ lệ xi măng 1 : cát 3.

3. Khi dán mosaic tường, diện tích vữa dán quét mỗi lần không quá 3 m² cho một thợ gạch.

4. Khe điều chỉnh co giãn mặt tường gạch được đặt tránh vị trí khe dẫn nứt của bê tông nền.', NULL, '4', 'Khe co giãn lớp ốp cần tương ứng với khe của nền để chuyển vị được giải phóng; đặt tránh như lựa chọn 4 có thể khiến gạch nứt phía trên khe nền. Không chỉ xét mặt hoàn thiện mà phải xét liên hệ với nền.', '[{"term": "伸縮調整目地", "reading": "しんしゅくちょうせいめじ", "meaning": "Khe điều chỉnh co giãn"}, {"term": "誘発目地", "reading": "ゆうはつめじ", "meaning": "Khe dẫn nứt"}, {"term": "敷モルタル", "reading": "しきモルタル", "meaning": "Vữa lót"}]'::jsonb, 74);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 25, '床コンクリートの直均し仕上げに関する記述として，最も不適当なものはどれか。

1．床仕上げレベルを確認するためのガイドレールは，床コンクリートを打ち込んだ後に4m間隔で設置した。

2．木ごてを用いた中むら取りは，コンクリート面を指で押しても少ししか入らない程度になった時期に行った。

3．金ごて中ずりは，表面にセメントペーストがあまり浮き出ないように行った。

4．張物下地において，散水養生は，最終こて押えの後，12時間程度を経てから行った。', 'Về hoàn thiện xoa trực tiếp sàn bê tông, phát biểu nào không thích hợp nhất?

1. Thanh dẫn để xác nhận cao độ hoàn thiện sàn được đặt cách nhau 4 m sau khi đổ bê tông sàn.

2. Dùng bàn xoa gỗ để sửa độ không phẳng trung gian khi ấn ngón tay vào mặt bê tông chỉ lún một ít.

3. Xoa trung gian bằng bàn xoa kim loại sao cho không làm quá nhiều hồ xi măng nổi lên.

4. Với nền để dán lớp phủ, bắt đầu dưỡng hộ phun nước sau khoảng 12 giờ kể từ lần xoa cuối.', NULL, '1', 'Thanh dẫn cao độ cần được định vị trước khi đổ và san để làm chuẩn kiểm soát. Đặt sau khi đổ như lựa chọn 1 không phục vụ đúng mục đích này. Phân biệt thiết lập mốc với kiểm tra bề mặt sau đổ.', '[{"term": "直均し仕上げ", "reading": "じかならししあげ", "meaning": "Hoàn thiện xoa trực tiếp"}, {"term": "木ごて", "reading": "きごて", "meaning": "Bàn xoa gỗ"}, {"term": "金ごて", "reading": "かなごて", "meaning": "Bàn xoa kim loại"}]'::jsonb, 75);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 26, '外部に面するサッシ等のガラス工事に関する記述として，最も不適当なものはどれか。

1．網入板ガラスは，ガラスの下辺小口及び縦小口の下端より1/4の高さまで防錆処置をした。

2．高層階のバルコニーのガラス手すりは，合わせガラスを使用した。

3．グレイジングチャンネルの継目の位置は，ガラスの下辺中央部とした。

4．ガラス溝内に置くセッティングブロックは，ガラス1枚につき2か所設置した。', 'Về lắp kính cho cửa sổ và bộ phận tương tự hướng ra ngoài, phát biểu nào không thích hợp nhất?

1. Kính có lưới thép được chống gỉ ở cạnh dưới và phần cạnh đứng từ đáy lên tới 1/4 chiều cao kính.

2. Tay vịn kính ban công tầng cao dùng kính dán nhiều lớp.

3. Mối nối gioăng kênh kính đặt ở giữa cạnh dưới của kính.

4. Mỗi tấm kính có hai vị trí kê setting block trong rãnh kính.', NULL, '3', 'Mối nối gioăng kênh đặt phía trên, thường giữa cạnh trên, để hạn chế nước lọt ở mép dưới. Lựa chọn 3 chọn sai vị trí. Kê kính và nối gioăng là hai chức năng khác nhau.', '[{"term": "網入板ガラス", "reading": "あみいりいたガラス", "meaning": "Kính có lưới thép"}, {"term": "合わせガラス", "reading": "あわせガラス", "meaning": "Kính dán nhiều lớp"}, {"term": "防錆処置", "reading": "ぼうせいしょち", "meaning": "Xử lý chống gỉ"}]'::jsonb, 76);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 27, '内部仕上げの改修工事に関する記述として，最も不適当なものはどれか。

1．モルタル下地面に残ったビニル床タイルの接着剤は，ディスクサンダを用いて除去した。

2．モルタル下地の磁器質床タイルの張替え部は，斫り用ののみを用いて，手作業で存置部分と縁切りをした。

3．大規模なコンクリート間仕切壁の撤去には，油圧クラッシャを用いた。

4．既存の合成樹脂塗床材の上に同じ材質の塗床材を塗り重ねる際，接着性を高めるため，既存仕上げ材の表面に目荒しを行った。', 'Về sửa chữa hoàn thiện nội thất, phát biểu nào không thích hợp nhất?

1. Keo gạch sàn vinyl còn trên nền vữa được loại bỏ bằng máy mài đĩa.

2. Phần thay gạch sàn porcelain trên nền vữa được tách với phần giữ lại bằng đục tay.

3. Tường ngăn bê tông lớn được phá bằng máy nghiền thủy lực.

4. Khi phủ lớp sàn nhựa tổng hợp cùng vật liệu lên lớp cũ, làm nhám bề mặt cũ để tăng bám dính.', NULL, '2', 'Cần cắt tách ranh bằng máy cắt phù hợp trước khi đục bỏ gạch, thay vì đục tay ngay đường ranh như lựa chọn 2; đục tại ranh có thể làm nứt phần muốn giữ lại. Sau khi cắt tách mới đục bỏ trong vùng thay. Xử lý keo ở lựa chọn 1 và làm nhám ở lựa chọn 4 phục vụ chuẩn bị nền.', '[{"term": "目荒し", "reading": "めあらし", "meaning": "Làm nhám bề mặt"}, {"term": "縁切り", "reading": "えんきり", "meaning": "Tách ranh phần giữ lại"}, {"term": "斫り", "reading": "はつり", "meaning": "Đục phá"}]'::jsonb, 77);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 28, '事前調査に関する記述として，最も不適当なものはどれか。

1．着工に当たって，埋蔵文化財の有無について調査を行うこととした。

2．防護棚の設置に当たって，敷地の高低差や地中埋設配管の位置の確認をすることとした。

3．敷地内の排水工事に当たって，公設桝まで排水管の勾配が確保できるか調査を行うこととした。

4．山留め壁の位置を検討するに当たって，敷地境界や近接構造物までの離隔距離を確認することとした。', 'Về khảo sát trước thi công, phát biểu nào không thích hợp nhất?

1. Khi khởi công, quyết định khảo sát có hay không di sản văn hóa chôn ngầm.

2. Khi lắp sàn che bảo vệ, quyết định xác nhận chênh cao khu đất và vị trí đường ống chôn ngầm.

3. Khi thi công thoát nước trong khu đất, quyết định khảo sát có bảo đảm độ dốc ống đến hố ga công cộng hay không.

4. Khi xem xét vị trí tường chắn hố đào, quyết định xác nhận ranh đất và khoảng cách đến kết cấu gần đó.', NULL, '2', 'Sàn che bảo vệ cần khảo sát đường và công trình liền kề, không gian phía trên và phạm vi bảo vệ. Chênh cao đất và ống ngầm là nội dung phù hợp hơn với công tác đào hoặc nền móng, nên cặp mục đích–khảo sát ở lựa chọn 2 ít phù hợp nhất.', '[{"term": "埋蔵文化財", "reading": "まいぞうぶんかざい", "meaning": "Di sản văn hóa chôn ngầm"}, {"term": "山留め壁", "reading": "やまどめかべ", "meaning": "Tường chắn hố đào"}, {"term": "離隔距離", "reading": "りかくきょり", "meaning": "Khoảng cách tách"}]'::jsonb, 78);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 29, '仮設計画に関する記述として，最も不適当なものはどれか。

1．既存の塀が所定の高さを有し，危害を十分防止し得る構造であったため，仮囲いとして使用することとした。

2．工事完成間近において，工事事務所は，適当な移転先がなかったため，監理者の承認を得て，施工中の建築物の一部を使用することとした。

3．下小屋は，材料置場の近くに設置し，電力や水道等の設備を設けることとした。

4．工事用ゲートの有効高さは，鉄筋コンクリート構造の工事のため，最大積載時のトラックアジテータの高さとすることとした。', 'Về kế hoạch công trình tạm, phát biểu nào không thích hợp nhất?

1. Vì tường rào hiện hữu đủ cao và có cấu tạo đủ ngăn nguy hại, quyết định dùng làm hàng rào tạm.

2. Gần hoàn thành công trình, do không có nơi di chuyển văn phòng công trường thích hợp, được người giám sát chấp thuận dùng một phần công trình đang thi công.

3. Xưởng gia công tạm đặt gần bãi vật liệu, có điện, nước và thiết bị tương tự.

4. Vì thi công bê tông cốt thép, chiều cao thông thủy cổng công trường được lấy bằng chiều cao xe trộn bê tông ở trạng thái chở đầy tối đa.', NULL, '4', 'Cổng phải có khoảng dự phòng cao độ và xét chiều cao lớn nhất của xe, không lấy vừa đúng chiều cao xe đầy tải. Xe không tải có thể cao hơn do hệ treo; cần xét trạng thái bất lợi và khoảng hở an toàn.', '[{"term": "仮囲い", "reading": "かりがこい", "meaning": "Hàng rào tạm"}, {"term": "有効高さ", "reading": "ゆうこうたかさ", "meaning": "Chiều cao thông thủy"}, {"term": "トラックアジテータ", "reading": "トラックアジテータ", "meaning": "Xe trộn/vận chuyển bê tông"}]'::jsonb, 79);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 30, '工事現場における材料の保管に関する記述として，最も不適当なものはどれか。

1．ロールカーペットは，横に倒して2段から3段までの俵積みとした。

2．袋詰めセメントは，通風を避けて保管した。

3．アスファルトルーフィングは，屋内の乾燥した場所に平積みで保管した。

4．スレート板は，平積みとし，積上げ高さを1m以下とした。', 'Về bảo quản vật liệu tại công trường, phát biểu nào không thích hợp nhất?

1. Thảm cuộn được đặt nằm, xếp kiểu bao theo hai đến ba tầng.

2. Xi măng đóng bao được bảo quản tránh thông gió.

3. Màng chống thấm asphalt cuộn được xếp nằm ở nơi khô trong nhà.

4. Tấm slate được xếp nằm, chiều cao chồng không quá 1 m.', NULL, '3', 'Màng asphalt cuộn cần dựng đứng để tránh bẹp, biến dạng và dính lớp do tải chồng. Không áp dụng cách xếp của thảm cuộn cho mọi vật liệu dạng cuộn.', '[{"term": "アスファルトルーフィング", "reading": "アスファルトルーフィング", "meaning": "Màng chống thấm asphalt"}, {"term": "袋詰めセメント", "reading": "ふくろづめセメント", "meaning": "Xi măng đóng bao"}, {"term": "俵積み", "reading": "たわらづみ", "meaning": "Xếp kiểu bao"}]'::jsonb, 80);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 31, '工程管理に関する記述として，最も不適当なものはどれか。

1．工程計画を立てるに当たっては，その地域の雨天日や強風日等を推定した作業不能日を考慮し，全体の日程を求める。

2．基本工程表には，監理者の検査，承認等の日程を記入する。

3．各作業の実働日数は，作業の総施工数量に1日当たりの施工数量を乗じて求める。

4．暦日とは，実働日数に作業休止日を考慮した日数である。', 'Về quản lý tiến độ, phát biểu nào không thích hợp nhất?

1. Khi lập tiến độ, tính lịch toàn thể có xét ngày không thể làm việc được ước tính từ ngày mưa và gió mạnh của khu vực.

2. Tiến độ cơ bản ghi lịch kiểm tra, chấp thuận và việc tương tự của người giám sát.

3. Số ngày làm việc thực tế của từng công việc được tính bằng tổng khối lượng thi công nhân khối lượng thi công mỗi ngày.

4. Số ngày theo lịch là số ngày có xét các ngày nghỉ việc vào số ngày làm việc thực tế.', NULL, '3', 'Số ngày thực làm = tổng khối lượng ÷ năng suất mỗi ngày. Nhân hai đại lượng ở lựa chọn 3 vừa sai phép tính vừa sai đơn vị. Ví dụ 100 m³ ÷ 20 m³/ngày = 5 ngày.', '[{"term": "実働日数", "reading": "じつどうにっすう", "meaning": "Số ngày thực làm"}, {"term": "暦日", "reading": "れきじつ", "meaning": "Ngày theo lịch"}, {"term": "施工数量", "reading": "せこうすうりょう", "meaning": "Khối lượng thi công"}]'::jsonb, 81);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 32, 'バーチャート工程表の一般的な特徴に関する記述として，最も不適当なものはどれか。

1．工程表に出来高曲線を表示すると，進捗状況が把握しやすい。

2．工程上で重点管理する必要がある作業が判断しやすい。

3．工程における作業の先行，後続の関係が表現しにくい。

4．全体工期の短縮を検討する場合，工程のどこを縮めればいいのかわかりにくい。', 'Về đặc điểm thông thường của biểu đồ tiến độ thanh, phát biểu nào không thích hợp nhất?

1. Thể hiện đường cong khối lượng hoàn thành trên tiến độ giúp nắm tình trạng tiến triển.

2. Dễ nhận biết công việc cần quản lý trọng điểm về tiến độ.

3. Khó thể hiện quan hệ trước–sau giữa các công việc.

4. Khi xem xét rút ngắn tổng thời gian, khó nhận ra nên rút ngắn chỗ nào trong tiến độ.', NULL, '2', 'Biểu đồ thanh dễ thấy lịch nhưng không thể hiện rõ logic và đường găng, nên khó nhận ra công việc cần quản lý trọng điểm. Lựa chọn 2 nêu ngược đặc điểm này. Đừng nhầm “dễ nhìn lịch” với “dễ xác định việc chi phối”.', '[{"term": "先行", "reading": "せんこう", "meaning": "Đi trước"}, {"term": "後続", "reading": "こうぞく", "meaning": "Theo sau"}, {"term": "重点管理", "reading": "じゅうてんかんり", "meaning": "Quản lý trọng điểm"}]'::jsonb, 82);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 33, '品質管理に関する記述として，最も不適当なものはどれか。

1．川上管理とは，品質に与える影響が大きい前段階や工程の上流で品質を管理することである。

2．品質管理とは，建築工事においては，施工計画書に基づいて工事のあらゆる段階で問題点や改善方法等を見出しながら，合理的，かつ，経済的に施工を行うことである。

3．施工品質管理表（QC工程表）の管理項目は，目指す品質に直接関係している要因から取りあげる。

4．試験とは，性質又は状態を調べ，判定基準と比較して良否の判断までを下すことである。', 'Về quản lý chất lượng, phát biểu nào không thích hợp nhất?

1. Quản lý thượng nguồn là quản lý chất lượng ở giai đoạn trước hoặc đầu quá trình có ảnh hưởng lớn đến chất lượng.

2. Trong xây dựng, quản lý chất lượng là thi công hợp lý và kinh tế, dựa trên kế hoạch thi công, đồng thời tìm vấn đề và cách cải thiện ở mọi giai đoạn.

3. Các mục quản lý trong bảng quản lý chất lượng thi công (biểu đồ quá trình QC) được chọn từ yếu tố liên quan trực tiếp đến chất lượng mục tiêu.

4. Thử nghiệm là kiểm tra tính chất hoặc trạng thái, so với tiêu chí và đưa ra kết luận tốt/xấu.', NULL, '4', 'Thử nghiệm thu thập kết quả về tính chất hoặc trạng thái; việc so tiêu chí và kết luận đạt/không đạt là kiểm tra. Lựa chọn 4 mô tả 検査 thay cho 試験. Hai bước có thể cùng trong một quy trình nhưng thuật ngữ khác nhau.', '[{"term": "川上管理", "reading": "かわかみかんり", "meaning": "Quản lý thượng nguồn"}, {"term": "試験", "reading": "しけん", "meaning": "Thử nghiệm"}, {"term": "判定基準", "reading": "はんていきじゅん", "meaning": "Tiêu chí đánh giá"}]'::jsonb, 83);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 34, 'フレッシュコンクリートの荷卸し地点での試験及び検査に関する記述として，最も不適当なものはどれか。

1．スランプ試験は，0.5cm単位で測定する。

2．スランプの許容差は，指定したスランプの値にかかわらず一定とする。

3．空気量の許容差は，指定した空気量の値にかかわらず一定とする。

4．温度測定は，試料に挿入した状態の温度計の値を1℃単位で読み取り，記録する。', 'Về thử nghiệm và kiểm tra bê tông tươi tại điểm dỡ hàng, phát biểu nào không thích hợp nhất?

1. Thử độ sụt đo theo đơn vị 0,5 cm.

2. Dung sai độ sụt là hằng số, bất kể giá trị độ sụt chỉ định.

3. Dung sai hàm lượng khí không đổi, bất kể hàm lượng khí chỉ định.

4. Đo nhiệt độ bằng cách đọc và ghi theo đơn vị 1 ℃ khi nhiệt kế vẫn cắm trong mẫu.', NULL, '2', 'Dung sai độ sụt được chia theo phạm vi độ sụt chỉ định, nên không luôn bằng nhau. Phải tra mức tương ứng; không áp dụng dung sai của hàm lượng khí cho độ sụt.', '[{"term": "フレッシュコンクリート", "reading": "フレッシュコンクリート", "meaning": "Bê tông tươi"}, {"term": "許容差", "reading": "きょようさ", "meaning": "Dung sai cho phép"}, {"term": "空気量", "reading": "くうきりょう", "meaning": "Hàm lượng khí"}]'::jsonb, 84);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 35, '品質管理に用いる図表及び用語に関する記述として，最も不適当なものはどれか。

1．散布図とは，対応する2つの特性を横軸と縦軸にとり，観測値を打点してつくるグラフ表示である。

2．マトリックス図法とは，行と列に配置した二元表によって2つの事象の関係を示す交点の情報を記号化することで必要な情報を得る手法である。

3．PDCAサイクルとは，品質を向上させるために，計画，実施，コスト，処置のサイクルを繰り返す取組みである。

4．QCDSEとは，施工管理において基本の項目となる品質，原価，工期，安全，環境のことである。', 'Về biểu đồ và thuật ngữ dùng trong quản lý chất lượng, phát biểu nào không thích hợp nhất?

1. Biểu đồ phân tán được tạo bằng lấy hai đặc tính tương ứng làm trục ngang và đứng, rồi chấm các giá trị quan sát.

2. Phương pháp ma trận dùng bảng hai chiều với hàng, cột; ký hiệu hóa thông tin ở giao điểm quan hệ giữa hai sự việc để lấy thông tin cần thiết.

3. Chu trình PDCA là hoạt động lặp kế hoạch, thực hiện, chi phí, xử lý để nâng cao chất lượng.

4. QCDSE là các mục cơ bản của quản lý thi công: chất lượng, chi phí, thời hạn, an toàn, môi trường.', NULL, '3', 'C trong PDCA là Check (kiểm tra), không phải Cost (chi phí). Chu trình đúng là Plan–Do–Check–Act. C trong QCDSE lại là Cost; đây là điểm dễ nhầm giữa hai chữ viết tắt.', '[{"term": "散布図", "reading": "さんぷず", "meaning": "Biểu đồ phân tán"}, {"term": "マトリックス図法", "reading": "マトリックスずほう", "meaning": "Phương pháp biểu đồ ma trận"}, {"term": "品質", "reading": "ひんしつ", "meaning": "Chất lượng"}]'::jsonb, 85);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 36, '作業主任者を選任すべき作業として，「労働安全衛生法」上，定められていないものはどれか。

1．工作物のコンクリートの打込み

2．解体工事における石綿の除去

3．高さが5mの足場の組立て

4．建築物の骨組みの高さが5mの鉄骨の組立て', 'Theo Luật An toàn và vệ sinh lao động, công việc nào không được quy định phải chỉ định người phụ trách công việc?

1. Đổ bê tông cho công trình.

2. Loại bỏ amiăng trong công tác phá dỡ.

3. Lắp giàn giáo cao 5 m.

4. Lắp kết cấu thép của công trình có khung cao 5 m.', NULL, '1', 'Công tác đổ bê tông thông thường không thuộc danh mục phải có 作業主任者 được hỏi. Các công việc amiăng, giàn giáo và lắp khung thép theo ngưỡng đề nêu thuộc nhóm tương ứng. Vẫn phải tổ chức an toàn cho công tác đổ bê tông.', '[{"term": "石綿", "reading": "いしわた", "meaning": "Amiăng"}, {"term": "打込み", "reading": "うちこみ", "meaning": "Đổ bê tông"}, {"term": "作業主任者", "reading": "さぎょうしゅにんしゃ", "meaning": "Người phụ trách công việc theo luật"}]'::jsonb, 86);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 37, '足場に関する記述として，最も不適当なものはどれか。

1．単管足場の隣接する建地の継手部は，千鳥となるように配置した。

2．単管足場において，単管と単管の交点の緊結金具は，直交型クランプ又は自在型クランプを使用した。

3．くさび緊結式足場において，壁つなぎの間隔は，単管足場の法令で定められた間隔を適用した。

4．単管足場の沈下防止のため，敷角の上に単管パイプを直接乗せて，脚部に根がらみを設けた。', 'Về giàn giáo, phát biểu nào không thích hợp nhất?

1. Mối nối các cột đứng liền kề của giàn giáo ống đơn được bố trí so le.

2. Tại giao điểm các ống, dùng khóa vuông góc hoặc khóa xoay để liên kết.

3. Khoảng cách liên kết tường của giàn giáo nêm dùng khoảng cách pháp định của giàn giáo ống đơn.

4. Để chống lún giàn giáo ống đơn, đặt trực tiếp ống lên gỗ kê và bố trí giằng chân.', NULL, '4', 'Chân ống cần đế chân/base và kê phù hợp để phân bố tải; không đặt trực tiếp đầu ống lên gỗ như lựa chọn 4. Giằng chân chống chuyển vị ngang không thay thế bộ phận phân bố tải dưới chân.', '[{"term": "単管足場", "reading": "たんかんあしば", "meaning": "Giàn giáo ống đơn"}, {"term": "建地", "reading": "たてじ", "meaning": "Cột đứng giàn giáo"}, {"term": "根がらみ", "reading": "ねがらみ", "meaning": "Giằng chân"}]'::jsonb, 87);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 38, '鉄筋のかぶり厚さに関する記述として，最も不適当なものはどれか。

1．設計かぶり厚さは，最小かぶり厚さに施工誤差を考慮した割増しを加えたものである。

2．かぶり厚さの確保には，火熱による鉄筋の強度低下防止等の目的がある。

3．杭基礎におけるベース筋の最小かぶり厚さは，杭頭から確保する。

4．腹筋を外付けする大梁の最小かぶり厚さは，幅止め筋の外側表面から確保する。

5．土に接するスラブにおける最小かぶり厚さは，捨コンクリートを含めた厚さとする。', 'Về chiều dày lớp bê tông bảo vệ cốt thép, phát biểu nào không thích hợp nhất?

1. Chiều dày bảo vệ thiết kế là chiều dày tối thiểu cộng phần tăng thêm xét sai số thi công.

2. Bảo đảm lớp bảo vệ có mục đích như ngăn cốt thép giảm cường độ do nhiệt cháy.

3. Lớp bảo vệ tối thiểu của thép đáy móng cọc được bảo đảm tính từ đầu cọc.

4. Với dầm chính có thép hông đặt ngoài, bảo đảm lớp bảo vệ tối thiểu tính từ mặt ngoài thép giữ bề rộng.

5. Lớp bảo vệ tối thiểu của bản tiếp xúc đất là chiều dày có tính cả bê tông lót.', NULL, '5', 'Bê tông lót không được tính vào lớp bảo vệ của kết cấu. Khoảng bảo vệ phải nằm trong bê tông cấu kiện, đo tới thép ngoài cùng theo trường hợp. Lựa chọn 5 cộng một lớp không thuộc bê tông kết cấu.', '[{"term": "かぶり厚さ", "reading": "かぶりあつさ", "meaning": "Chiều dày lớp bảo vệ"}, {"term": "最小かぶり厚さ", "reading": "さいしょうかぶりあつさ", "meaning": "Lớp bảo vệ tối thiểu"}, {"term": "施工誤差", "reading": "せこうごさ", "meaning": "Sai số thi công"}]'::jsonb, 88);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 39, 'コンクリートの調合に関する記述として，最も不適当なものはどれか。

1．水セメント比は，耐久性を確保するためには，一般に低いほうがよい。

2．細骨材率は，乾燥収縮によるひび割れを少なくするためには，高くするほうがよい。

3．単位セメント量は，過少であるとコンクリートのワーカビリティーが低下する。

4．AE減水剤は，所定のスランプを得るのに必要な単位水量を減らすことができる。

5．粗骨材として用いる川砂利と砕石は，それぞれが所定の品質を満足していれば，混合して使用してもよい。', 'Về cấp phối bê tông, phát biểu nào không thích hợp nhất?

1. Để bảo đảm độ bền lâu, tỷ lệ nước/xi măng nói chung nên thấp.

2. Để giảm nứt do co ngót khô, nên tăng tỷ lệ cốt liệu nhỏ.

3. Lượng xi măng trên đơn vị thể tích quá ít làm giảm tính công tác của bê tông.

4. Phụ gia giảm nước cuốn khí AE có thể giảm lượng nước cần thiết để đạt độ sụt chỉ định.

5. Có thể trộn sỏi sông và đá dăm làm cốt liệu lớn nếu mỗi loại đạt chất lượng quy định.', NULL, '2', 'Tăng tỷ lệ cốt liệu nhỏ không phải biện pháp giảm co ngót; nó có thể tăng nhu cầu nước/hồ và co ngót. Cần tối ưu cấp phối, hạn chế nước và bảo đảm thi công, dưỡng hộ phù hợp. Đừng suy rằng nhiều hạt nhỏ luôn tạo bê tông bền lâu hơn.', '[{"term": "細骨材率", "reading": "さいこつざいりつ", "meaning": "Tỷ lệ cốt liệu nhỏ"}, {"term": "水セメント比", "reading": "みずセメントひ", "meaning": "Tỷ lệ nước/xi măng"}, {"term": "乾燥収縮", "reading": "かんそうしゅうしゅく", "meaning": "Co ngót khô"}]'::jsonb, 89);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 40, 'といの施工に関する記述として，最も不適当なものはどれか。

1．硬質塩化ビニル製軒どいは，とい受け金物に金属線で取り付けた。

2．硬質塩化ビニル製たてどいは，継いだ長さが10mを超えたため，エキスパンション継手を設けた。

3．硬質塩化ビニル製軒どいの両端は，接着剤を用いて集水器に堅固に取り付けた。

4．塗装鋼板製谷どいの継手部は，シーリング材を入れ60mm重ね合わせて，リベットで留め付けた。

5．鋼板製はいどいは，上の階のたてどいから下の階の集水器まで，屋根の流れに沿って取り付けた。', 'Về thi công máng và ống thoát nước mái, phát biểu nào không thích hợp nhất?

1. Máng mái PVC cứng được gắn vào giá đỡ bằng dây kim loại.

2. Vì tổng chiều dài nối ống đứng PVC cứng vượt 10 m, bố trí mối nối giãn nở.

3. Hai đầu máng PVC cứng được gắn chắc vào phễu thu nước bằng keo.

4. Mối nối máng khe mái bằng tôn sơn được chồng 60 mm, có vật liệu trám và cố định bằng đinh tán.

5. Máng dẫn bằng thép từ ống đứng tầng trên tới phễu thu tầng dưới được lắp theo dốc mái.', NULL, '3', 'Máng PVC cần cho phép giãn nở nhiệt tại chỗ nối với phễu thu; dán cứng hai đầu như lựa chọn 3 khóa chuyển vị, dễ gây biến dạng. Phân biệt nối kín với nối cứng hoàn toàn.', '[{"term": "軒どい", "reading": "のきどい", "meaning": "Máng mái"}, {"term": "たてどい", "reading": "たてどい", "meaning": "Ống thoát đứng"}, {"term": "エキスパンション継手", "reading": "エキスパンションつぎて", "meaning": "Mối nối giãn nở"}]'::jsonb, 90);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 41, 'せっこうボード張りに関する記述として，最も不適当なものはどれか。

1．天井の仕上げ張りは，中央部より張り始め，周囲に向かって張り進めた。

2．下張りせっこうボードに上張りせっこうボードを張り付けるために使用する接着剤は，200mm間隔で点付けした。

3．木製下地にせっこうボードを直接張り付けるため，ボード厚さの3倍程度の長さのせっこうボード用くぎを用いた。

4．壁の出隅部を補強するため，亜鉛めっき鋼板製のコーナービードを用いた。

5．薄手の壁紙仕上げの下地ボードとして使用するため，小ねじの頭は，ボード表面と同面になるまでねじ込んだ。', 'Về lắp tấm thạch cao, phát biểu nào không thích hợp nhất?

1. Lớp hoàn thiện trần được bắt đầu từ giữa và tiếp tục ra xung quanh.

2. Keo để dán tấm thạch cao lớp trên lên lớp dưới được chấm theo khoảng cách 200 mm.

3. Để gắn trực tiếp tấm thạch cao vào nền gỗ, dùng đinh thạch cao dài khoảng ba lần chiều dày tấm.

4. Dùng nẹp góc bằng thép mạ kẽm để gia cường góc ngoài tường.

5. Vì tấm dùng làm nền giấy dán tường mỏng, đầu vít được vặn tới khi ngang mặt tấm.', NULL, '5', 'Đầu vít cần chìm nhẹ để xử lý bột trám phẳng, nhưng không làm rách giấy mặt. Chỉ ngang mặt như lựa chọn 5 dễ lộ đầu vít dưới giấy mỏng. Chìm quá sâu cũng sai; phải bảo toàn lớp giấy giữ tấm.', '[{"term": "せっこうボード", "reading": "せっこうボード", "meaning": "Tấm thạch cao"}, {"term": "出隅", "reading": "ですみ", "meaning": "Góc ngoài"}, {"term": "小ねじ", "reading": "こねじ", "meaning": "Vít nhỏ"}]'::jsonb, 91);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 42, '次のうち，建築物の品質管理に関する用語として，最も関係の少ないものはどれか。

1．ばらつき

2．管理図

3．ロット

4．サンプリング

5．ISO14000シリーズ', 'Trong các mục sau, mục nào ít liên quan nhất với thuật ngữ quản lý chất lượng công trình?

1. Độ phân tán.

2. Biểu đồ kiểm soát.

3. Lô.

4. Lấy mẫu.

5. Bộ tiêu chuẩn ISO 14000.', NULL, '5', 'ISO 14000 chủ yếu về quản lý môi trường; ISO 9000 là họ tiêu chuẩn quản lý chất lượng. Các lựa chọn 1–4 là khái niệm trực tiếp của quản lý chất lượng. Phân biệt hai họ tiêu chuẩn theo mục đích.', '[{"term": "ばらつき", "reading": "ばらつき", "meaning": "Độ phân tán"}, {"term": "管理図", "reading": "かんりず", "meaning": "Biểu đồ kiểm soát"}, {"term": "サンプリング", "reading": "サンプリング", "meaning": "Lấy mẫu"}]'::jsonb, 92);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 43, '建築確認手続き等に関する記述として，「建築基準法」上，誤っているものはどれか。

1．建築主は，やむを得ない理由があるときを除き，工事が完了した日から7日以内に建築主事等に到達するように完了検査を申請しなければならない。

2．施工者は，工事現場の見やすい場所に，国土交通省令で定める様式によって，建築確認があった旨の表示をしなければならない。

3．建築主は，高さが4mを超える広告塔を設置しようとする場合においては，確認済証の交付を受けなければならない。

4．建築主は，建築確認申請が必要な建築物を建築する場合，当該工事に着手する前に確認済証の交付を受けなければならない。', 'Theo Luật Tiêu chuẩn xây dựng, phát biểu nào về thủ tục xác nhận xây dựng và các việc liên quan sai?

1. Trừ khi có lý do bất khả kháng, chủ đầu tư phải xin kiểm tra hoàn thành sao cho yêu cầu đến cơ quan chủ sự xây dựng hoặc cơ quan tương ứng trong 7 ngày kể từ ngày hoàn thành.

2. Đơn vị thi công phải niêm yết tại chỗ dễ thấy ở công trường rằng đã có xác nhận xây dựng, theo mẫu của thông tư Bộ Đất đai, Hạ tầng, Giao thông và Du lịch.

3. Chủ đầu tư định đặt tháp quảng cáo cao hơn 4 m phải nhận giấy chứng nhận xác nhận.

4. Khi xây công trình cần xin xác nhận xây dựng, chủ đầu tư phải nhận giấy chứng nhận trước khi khởi công.', NULL, '1', 'Thời hạn xin kiểm tra hoàn thành về nguyên tắc là 4 ngày kể từ ngày hoàn thành, không phải 7 ngày. Lựa chọn 1 sai con số. Phân biệt thời hạn nộp yêu cầu với thời hạn cơ quan tiến hành kiểm tra.', '[{"term": "完了検査", "reading": "かんりょうけんさ", "meaning": "Kiểm tra hoàn thành"}, {"term": "確認済証", "reading": "かくにんずみしょう", "meaning": "Giấy chứng nhận xác nhận"}, {"term": "建築主", "reading": "けんちくぬし", "meaning": "Chủ đầu tư xây dựng"}]'::jsonb, 93);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 44, '次の記述のうち，「建築基準法」上，誤っているものはどれか。

1．最下階の居室の床が木造である場合，原則として，外壁の床下部分には，壁の長さ5m以下ごとに所定の換気孔を設けるものとする。

2．最下階の居室の床が木造である場合における床の上面の高さは，原則として，直下の地面から45cm以上とする。

3．一戸建ての住宅における階段の踏面は，15cm以上とする。

4．集会場における客用の屋内階段の幅は，120cm以上とする。', 'Theo Luật Tiêu chuẩn xây dựng, phát biểu nào sau đây sai?

1. Nếu sàn phòng sử dụng ở tầng thấp nhất là sàn gỗ, về nguyên tắc phải có lỗ thông gió quy định tại phần tường ngoài dưới sàn, theo khoảng chiều dài tường không quá 5 m.

2. Nếu sàn phòng sử dụng tầng thấp nhất là sàn gỗ, mặt trên sàn về nguyên tắc phải cách mặt đất ngay bên dưới ít nhất 45 cm.

3. Mặt bậc cầu thang trong nhà riêng một hộ phải rộng ít nhất 15 cm.

4. Cầu thang trong nhà dành cho khách ở hội trường phải rộng ít nhất 120 cm.', NULL, '4', 'Bề rộng cầu thang trong nhà dành cho khách của hội trường thuộc mức 140 cm trở lên trong bảng quy định tương ứng, không phải 120 cm. Không chuyển tiêu chuẩn của loại cầu thang khác sang hội trường.', '[{"term": "踏面", "reading": "ふみづら", "meaning": "Mặt bậc"}, {"term": "換気孔", "reading": "かんきこう", "meaning": "Lỗ thông gió"}, {"term": "集会場", "reading": "しゅうかいじょう", "meaning": "Hội trường"}]'::jsonb, 94);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 45, '建設業の許可に関する記述として，「建設業法」上，誤っているものはどれか。

1．一般建設業の許可を受けようとする者は，一の都道府県の区域内にのみ営業所を設けて営業をしようとする場合，許可申請書を当該営業所の所在地を管轄する都道府県知事に提出しなければならない。

2．一般建設業の許可を受けようとする者は，営業所ごとに置く技術者を専任の者としなければならない。

3．一般建設業の許可を受けた業者と特定建設業の許可を受けた業者では，発注者から直接請け負うことができる工事の請負代金の額が異なる。

4．一般建設業の許可を受けた建設業者は，許可申請書に記載した営業所の所在する都道府県以外の地域においても建設工事を施工することができる。', 'Theo Luật Ngành xây dựng, phát biểu nào về giấy phép xây dựng sai?

1. Người muốn nhận giấy phép kinh doanh xây dựng thông thường, chỉ đặt cơ sở kinh doanh trong một tỉnh/thành cấp tỉnh, phải nộp đơn cho tỉnh trưởng quản lý địa chỉ cơ sở đó.

2. Người muốn nhận giấy phép kinh doanh xây dựng thông thường phải bố trí kỹ thuật viên chuyên trách ở mỗi cơ sở kinh doanh.

3. Doanh nghiệp có giấy phép thông thường và doanh nghiệp có giấy phép đặc định khác nhau về số tiền hợp đồng công trình có thể nhận trực tiếp từ chủ đầu tư.

4. Doanh nghiệp có giấy phép thông thường có thể thi công ở khu vực khác với tỉnh nơi đặt cơ sở ghi trong đơn giấy phép.', NULL, '3', 'Giấy phép thông thường/đặc định không giới hạn khác nhau về giá trị nhận trực tiếp từ chủ đầu tư; khác biệt gắn với quy mô giao thầu phụ và trách nhiệm tương ứng. Giấy phép cấp tỉnh cũng không giới hạn chỉ thi công trong tỉnh.', '[{"term": "一般建設業", "reading": "いっぱんけんせつぎょう", "meaning": "Kinh doanh xây dựng thông thường"}, {"term": "専任", "reading": "せんにん", "meaning": "Chuyên trách"}, {"term": "請負代金", "reading": "うけおいだいきん", "meaning": "Giá trị hợp đồng nhận thầu"}]'::jsonb, 95);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 46, '工事現場における技術者に関する記述として，「建設業法」上，誤っているものはどれか。

1．建築一式工事に関し10年以上実務の経験を有する者は，建築一式工事における主任技術者になることができる。

2．学校教育法による高等学校を卒業後，防水工事に関し5年以上実務の経験を有する者で在学中に国土交通省令で定める学科を修めたものは，防水工事における主任技術者になることができる。

3．国又は地方公共団体が発注する建築一式工事以外の建設工事で，請負代金の額が3,500万円の工事現場に置く主任技術者は，専任の者でなければならない。

4．共同住宅の建築一式工事で，請負代金の額が9,000万円の工事現場に置く主任技術者は，専任の者でなければならない。', 'Theo Luật Ngành xây dựng, phát biểu nào về kỹ thuật viên công trường sai?

1. Người có ít nhất 10 năm kinh nghiệm thực tế công trình xây dựng tổng hợp có thể làm kỹ thuật viên phụ trách của công trình xây dựng tổng hợp.

2. Người có ít nhất 5 năm kinh nghiệm chống thấm sau tốt nghiệp trung học theo Luật Giáo dục nhà trường, đã học chuyên ngành do thông tư bộ quy định, có thể làm kỹ thuật viên phụ trách chống thấm.

3. Kỹ thuật viên phụ trách tại công trường không thuộc xây dựng tổng hợp, do Nhà nước hoặc chính quyền địa phương đặt hàng, có hợp đồng 3.500万円, phải là người chuyên trách.

4. Kỹ thuật viên phụ trách công trình xây dựng tổng hợp nhà ở tập thể có hợp đồng 9.000万円 phải là người chuyên trách.', NULL, '3', 'Ngưỡng chuyên trách áp dụng trong đề là 4.500万円 cho công việc không phải xây dựng tổng hợp và 9.000万円 cho xây dựng tổng hợp. 3.500万円 thấp hơn ngưỡng đầu, nên lựa chọn 3 sai. Đúng bằng ngưỡng đã thuộc “từ ... trở lên”; vẫn cần phân biệt các ngoại lệ pháp định với điều kiện cơ bản của câu hỏi.', '[{"term": "主任技術者", "reading": "しゅにんぎじゅつしゃ", "meaning": "Kỹ thuật viên phụ trách"}, {"term": "実務経験", "reading": "じつむけいけん", "meaning": "Kinh nghiệm thực tế"}, {"term": "建築一式工事", "reading": "けんちくいっしきこうじ", "meaning": "Công trình xây dựng tổng hợp"}]'::jsonb, 96);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 47, '次の記述のうち，「労働基準法」上，誤っているものはどれか。

1．使用者は，労働契約に附随して貯蓄の契約をさせてはならない。

2．使用者は，労働契約の締結に際し，労働者に対して就業の場所及び従事すべき業務に関する事項を明示しなければならない。

3．使用者は，労働者が業務上負傷し，又は疾病にかかり療養のために休業する期間及びその後14日間は，原則として解雇してはならない。

4．使用者は，労働者の退職の場合において，権利者の請求があった場合においては，7日以内に賃金を支払い，労働者の権利に属する金品を返還しなければならない。', 'Theo Luật Tiêu chuẩn lao động, phát biểu nào sau đây sai?

1. Người sử dụng lao động không được buộc người lao động ký hợp đồng tiết kiệm gắn với hợp đồng lao động.

2. Khi ký hợp đồng lao động, người sử dụng lao động phải thông báo rõ nơi làm việc và công việc phải đảm nhiệm cho người lao động.

3. Về nguyên tắc, không được sa thải người lao động trong thời gian nghỉ để điều trị chấn thương hoặc bệnh do công việc và 14 ngày sau đó.

4. Khi người lao động nghỉ việc, nếu người có quyền yêu cầu, phải trả lương và hoàn trả tiền, tài sản thuộc quyền người lao động trong 7 ngày.', NULL, '3', 'Thời gian bảo vệ sau đợt nghỉ điều trị tai nạn/bệnh nghề nghiệp là 30 ngày, không phải 14 ngày. Đừng nhầm với mốc thông báo sa thải hoặc thanh toán khi nghỉ việc; đây là hạn chế sa thải riêng.', '[{"term": "解雇", "reading": "かいこ", "meaning": "Sa thải"}, {"term": "療養", "reading": "りょうよう", "meaning": "Điều trị"}, {"term": "労働契約", "reading": "ろうどうけいやく", "meaning": "Hợp đồng lao động"}]'::jsonb, 97);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 48, '「労働安全衛生法」上，事業者が，所轄労働基準監督署長へ報告を行う必要がないものはどれか。

1．産業医を選任したとき

2．安全衛生推進者を選任したとき

3．積載荷重が0.25tの工事用のエレベーターにおいて，搬器の墜落事故が発生したとき

4．つり上げ荷重が0.5tの移動式クレーンにおいて，ワイヤロープの切断事故が発生したとき', 'Theo Luật An toàn và vệ sinh lao động, trường hợp nào doanh nghiệp không cần báo cáo cho trưởng cơ quan thanh tra tiêu chuẩn lao động có thẩm quyền?

1. Khi chỉ định bác sĩ lao động.

2. Khi chỉ định người thúc đẩy an toàn và vệ sinh.

3. Khi xảy ra tai nạn rơi cabin của thang máy công trường có tải chở 0,25 t.

4. Khi xảy ra tai nạn đứt cáp thép của cần trục di động có tải trọng nâng 0,5 t.', NULL, '2', 'Việc chỉ định người thúc đẩy an toàn và vệ sinh không phải báo cáo bổ nhiệm như trường hợp bác sĩ lao động. Hai tai nạn thiết bị được nêu thuộc nhóm báo cáo sự cố tương ứng. Không nhầm nghĩa vụ chỉ định với nghĩa vụ báo cáo việc chỉ định.', '[{"term": "産業医", "reading": "さんぎょうい", "meaning": "Bác sĩ lao động"}, {"term": "安全衛生推進者", "reading": "あんぜんえいせいすいしんしゃ", "meaning": "Người thúc đẩy an toàn vệ sinh"}, {"term": "労働基準監督署", "reading": "ろうどうきじゅんかんとくしょ", "meaning": "Cơ quan thanh tra tiêu chuẩn lao động"}]'::jsonb, 98);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 49, '建設工事に使用する資材のうち，「建設工事に係る資材の再資源化等に関する法律（建設リサイクル法）」上，特定建設資材に該当するものはどれか。

1．タイル

2．粘土瓦

3．モルタル

4．パーティクルボード', 'Trong các vật liệu sử dụng trong xây dựng, loại nào thuộc vật liệu xây dựng đặc định theo Luật Tái tài nguyên hóa vật liệu liên quan công trình xây dựng (Luật Tái chế xây dựng)?

1. Gạch ốp lát.

2. Ngói đất sét.

3. Vữa.

4. Ván dăm.', NULL, '4', 'Ván dăm thuộc nhóm vật liệu gỗ của danh mục đặc định. Vữa đứng riêng không được đồng nhất với bê tông; ngói và gạch ceramic cũng không thuộc bốn nhóm đặc định theo câu hỏi.', '[{"term": "パーティクルボード", "reading": "パーティクルボード", "meaning": "Ván dăm"}, {"term": "粘土瓦", "reading": "ねんどがわら", "meaning": "Ngói đất sét"}, {"term": "特定建設資材", "reading": "とくていけんせつしざい", "meaning": "Vật liệu xây dựng đặc định"}]'::jsonb, 99);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 50, '次の記述のうち，「道路法」上，道路の占用の許可を受ける必要がないものはどれか。

1．道路の上部に，防護棚を設置する。

2．道路に，コンクリート打込み作業のためのポンプ車を駐車する。

3．道路を挟んで向かい合う百貨店どうしを行き来できるよう，道路の地下を地下街でつなげる。

4．道路に，工事用電力を引き込むための仮設電柱を設置する。', 'Theo Luật Đường bộ, trường hợp nào sau đây không cần giấy phép chiếm dụng đường?

1. Đặt sàn che bảo vệ phía trên đường.

2. Đỗ xe bơm bê tông trên đường để đổ bê tông.

3. Nối hai cửa hàng bách hóa đối diện qua đường bằng khu phố ngầm bên dưới đường để đi qua lại.

4. Đặt cột điện tạm trên đường để dẫn điện công trường vào.', NULL, '2', 'Xe bơm đỗ tạm phục vụ tác nghiệp không thuộc dạng lắp công trình chiếm dụng đường như ba lựa chọn còn lại. Tuy nhiên việc dùng đường cho tác nghiệp có thể cần giấy phép sử dụng đường theo luật giao thông; không cần 占用 không đồng nghĩa được tự do sử dụng đường.', '[{"term": "道路占用", "reading": "どうろせんよう", "meaning": "Chiếm dụng đường"}, {"term": "道路使用", "reading": "どうろしよう", "meaning": "Sử dụng đường"}, {"term": "仮設電柱", "reading": "かせつでんちゅう", "meaning": "Cột điện tạm"}, {"term": "Mẫu câu tiếng Nhật", "reading": "Cách đọc bằng kana", "meaning": "Nghĩa tiếng Việt / cách xử lý"}, {"term": "最も不適当なものはどれか。", "reading": "もっともふてきとうなものはどれか。", "meaning": "Chọn phát biểu không thích hợp nhất; tìm nội dung sai."}, {"term": "不適当なものはどれか。", "reading": "ふてきとうなものはどれか。", "meaning": "Chọn phát biểu không thích hợp."}, {"term": "正しいものはどれか。", "reading": "ただしいものはどれか。", "meaning": "Chọn nội dung đúng, không chọn phát biểu sai."}, {"term": "誤っているものはどれか。", "reading": "あやまっているものはどれか。", "meaning": "Chọn phát biểu sai."}, {"term": "最も関係の少ないものはどれか。", "reading": "もっともかんけいのすくないものはどれか。", "meaning": "Chọn cặp hoặc thuật ngữ ít liên quan nhất."}, {"term": "定められていないものはどれか。", "reading": "さだめられていないものはどれか。", "meaning": "Tìm mục không được luật/quy định nêu."}, {"term": "必要がないものはどれか。", "reading": "ひつようがないものはどれか。", "meaning": "Chọn trường hợp không cần thực hiện nghĩa vụ đang hỏi."}, {"term": "ただし，〈内容〉とする。", "reading": "ただし，〈ないよう〉とする。", "meaning": "Với điều kiện〈nội dung〉; giữ điều kiện khi chọn công thức/quy định."}, {"term": "〈内容〉に関する記述として", "reading": "〈ないよう〉にかんするきじゅつとして", "meaning": "Xét các phát biểu liên quan đến〈nội dung〉"}, {"term": "［a］に当てはまる語句", "reading": "［エー］にあてはまるごく", "meaning": "Từ thích hợp điền vào ô ［a］; xem cả ngữ pháp và kỹ thuật."}, {"term": "図に示す", "reading": "ずにしめす", "meaning": "Được thể hiện trong hình; đọc đủ nhãn và số liệu."}, {"term": "値の大きさ", "reading": "あたいのおおきさ", "meaning": "Độ lớn giá trị; phân biệt độ lớn với dấu của đại lượng."}, {"term": "〈内容〉以上／〈内容〉以下／〈内容〉未満／〈内容〉を超える", "reading": "〈ないよう〉いじょう／〈ないよう〉いか／〈ないよう〉みまん／〈ないよう〉をこえる", "meaning": "≥ / ≤ / < / >; chú ý có hay không lấy giá trị biên."}, {"term": "〈内容〉に係わらず", "reading": "〈ないよう〉にかかわらず", "meaning": "Bất kể〈nội dung〉; kiểm tra xem đại lượng có thực sự độc lập hay không."}, {"term": "原則として", "reading": "げんそくとして", "meaning": "Về nguyên tắc; phân biệt nguyên tắc với ngoại lệ."}, {"term": "〈内容〉を除くものとする", "reading": "〈ないよう〉をのぞくものとする", "meaning": "Loại trừ〈nội dung〉; không dùng quy định của nhóm đã bị loại."}, {"term": "全問題を解答してください。", "reading": "ぜんもんだいをかいとうしてください。", "meaning": "Trả lời toàn bộ câu thuộc nhóm chỉ định."}, {"term": "〈内容〉問題を選択し，解答してください。", "reading": "〈ないよう〉もんだいをせんたくし，かいとうしてください。", "meaning": "Chọn đúng số câu quy định rồi trả lời."}]'::jsonb, 100);
END $$;
