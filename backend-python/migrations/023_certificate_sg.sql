-- Certificates feature: sg (itpp category) — generated from
-- doccument/SG/SG-2025-2026-on-tap-nhat-viet.md via a one-off parsing script

INSERT INTO certificates (code, category, name_ja, name_vi)
VALUES ('sg', 'itpp', 'セキュリティーマネジメント試験', 'Kỳ thi Quản lý An toàn Thông tin (Security Management)')
ON CONFLICT (code) DO NOTHING;

DO $$
DECLARE cert_id INT;
BEGIN
    SELECT id INTO cert_id FROM certificates WHERE code = 'sg';
    DELETE FROM certificate_vocabulary WHERE certificate_id = cert_id;

    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'IT', 'アイティー', 'Information Technology; công nghệ thông tin', '', '', '', 1);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ICT', 'アイシーティー', 'Information and Communication Technology; công nghệ thông tin và truyền thông', '', '', '', 2);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ISMS', 'アイエスエムエス', 'Information Security Management System; hệ thống quản lý an toàn thông tin', '', '', '', 3);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'CSIRT', 'シーサート', 'Computer Security Incident Response Team; đội ứng phó sự cố an toàn máy tính', '', '', '', 4);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'JPCERT/CC', 'ジェーピーサート・シーシー', 'Japan Computer Emergency Response Team Coordination Center', '', '', '', 5);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'DMZ', 'ディーエムゼット', 'Demilitarized Zone; vùng mạng trung gian', '', '', '', 6);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'TLS', 'ティーエルエス', 'Transport Layer Security; bảo vệ truyền thông', '', '', '', 7);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'HTTPS', 'エイチティーティーピーエス', 'HTTP over TLS; HTTP qua kênh TLS', '', '', '', 8);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'DNS', 'ディーエヌエス', 'Domain Name System; hệ thống phân giải tên miền', '', '', '', 9);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'SIEM', 'シーム', 'Security Information and Event Management; quản lý thông tin/sự kiện bảo mật', '', '', '', 10);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'IDS', 'アイディーエス', 'Intrusion Detection System; hệ thống phát hiện xâm nhập', '', '', '', 11);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'UTM', 'ユーティーエム', 'Unified Threat Management; quản lý mối đe dọa hợp nhất', '', '', '', 12);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'CVSS', 'シーブイエスエス', 'Common Vulnerability Scoring System; hệ thống chấm điểm lỗ hổng', '', '', '', 13);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'RASIS', 'レイシス', 'Reliability, Availability, Serviceability, Integrity, Security', '', '', '', 14);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'MTBF', 'エムティービーエフ', 'Mean Time Between Failures; thời gian trung bình giữa các lần hỏng', '', '', '', 15);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'MTTR', 'エムティーティーアール', 'Mean Time To Repair; thời gian sửa chữa trung bình', '', '', '', 16);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'RPO', 'アールピーオー', 'Recovery Point Objective; điểm phục hồi mục tiêu', '', '', '', 17);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'RTO', 'アールティーオー', 'Recovery Time Objective; thời gian phục hồi mục tiêu', '', '', '', 18);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'CISO', 'シーアイエスオー', 'Chief Information Security Officer; người đứng đầu an toàn thông tin', '', '', '', 19);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'DX', 'ディーエックス', 'Digital Transformation; chuyển đổi số', '', '', '', 20);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'AI', 'エーアイ', 'Artificial Intelligence; trí tuệ nhân tạo', '', '', '', 21);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'SNS', 'エスエヌエス', 'Social Networking Service; dịch vụ mạng xã hội', '', '', '', 22);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'PC', 'ピーシー', 'Personal Computer; máy tính cá nhân', '', '', '', 23);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'OS', 'オーエス', 'Operating System; hệ điều hành', '', '', '', 24);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'IP', 'アイピー', 'Internet Protocol; giao thức Internet', '', '', '', 25);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'URL', 'ユーアールエル', 'Uniform Resource Locator; địa chỉ tài nguyên', '', '', '', 26);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ID', 'アイディー', 'Identifier; mã định danh', '', '', '', 27);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ICカード', 'アイシーカード', 'thẻ có vi mạch; Integrated Circuit card', '', '', '', 28);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'QRコード', 'キューアールコード', 'mã QR; Quick Response code', '', '', '', 29);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ログ', 'ログ', 'nhật ký sự kiện', '', '', '', 30);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'クラウド', 'クラウド', 'đám mây', '', '', '', 31);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'オンプレミス', 'オンプレミス', 'hệ thống triển khai tại cơ sở tổ chức', '', '', '', 32);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'バックアップ', 'バックアップ', 'bản sao lưu; thao tác sao lưu', '', '', '', 33);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'リストア', 'リストア', 'khôi phục từ bản sao lưu', '', '', '', 34);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'フルバックアップ', 'フルバックアップ', 'sao lưu đầy đủ', '', '', '', 35);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'インシデント', 'インシデント', 'sự cố', '', '', '', 36);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'マルウェア', 'マルウェア', 'phần mềm độc hại', '', '', '', 37);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ゼロトラスト', 'ゼロトラスト', 'không mặc nhiên tin cậy theo vị trí mạng', '', '', '', 38);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'チャレンジレスポンス', 'チャレンジレスポンス', 'xác thực bằng thách thức và đáp lại', '', '', '', 39);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ホワイトボックステスト', 'ホワイトボックステスト', 'kiểm thử hộp trắng', '', '', '', 40);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'フォローアップ', 'フォローアップ', 'theo dõi việc khắc phục sau kiểm toán', '', '', '', 41);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'データクレンジング', 'データクレンジング', 'làm sạch dữ liệu', '', '', '', 42);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'データマート', 'データマート', 'kho dữ liệu cho mục đích/nhóm cụ thể', '', '', '', 43);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'デジタイゼーション', 'デジタイゼーション', 'chuyển dữ liệu vật lý/tương tự thành số', '', '', '', 44);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'デジタライゼーション', 'デジタライゼーション', 'số hóa một nghiệp vụ/quy trình', '', '', '', 45);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'デジタルトランスフォーメーション', 'デジタルトランスフォーメーション', 'chuyển đổi số ở phạm vi toàn tổ chức/mô hình kinh doanh', '', '', '', 46);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'トップ（ボトム）コーディング', 'トップ（ボトム）コーディング', 'gộp các giá trị ở đầu trên/dưới của phân bố', '', '', '', 47);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', 'Mẫu câu', 'Cách đọc', 'Nghĩa / cách làm', '', '', '', 48);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～に関する記述のうち，適切なものはどれか。', '～にかんするきじゅつのうち，てきせつなものはどれか。', 'Trong các phát biểu về（原表の後続行省略）, phát biểu nào phù hợp? Xác định khái niệm cần xét và kiểm tra từng lựa chọn.', '', '', '', 49);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '最も適切なものを選べ。', 'もっともてきせつなものをえらべ。', 'Chọn phương án phù hợp nhất. So mức đáp ứng đúng điều kiện, không chỉ tìm phương án có vẻ đúng chung chung.', '', '', '', 50);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '該当するものはどれか。', 'がいとうするものはどれか。', 'Phương án nào tương ứng/thuộc loại được hỏi? So dấu hiệu định nghĩa.', '', '', '', 51);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '表中の［［a1］］～［［a3］］に入れる組合せ', 'ひょうちゅうの［エーいち］～［エーさん］にいれるくみあわせ', 'Tổ hợp điền vào các ô. Giải từng ô, sau đó đối chiếu cả hàng đáp án.', '', '', '', 52);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', 'ここで，～ものとする。', 'ここで，～ものとする。', 'Ở đây, giả định/quy định rằng（原表の後続行省略） Phải dùng đúng giả định này để tính hoặc suy luận.', '', '', '', 53);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～の場合', '～のばあい', 'Trong trường hợp（原表の後続行省略） Xác định điều kiện kích hoạt quy tắc.', '', '', '', 54);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～に限り', '～にかぎり', 'Chỉ giới hạn ở（原表の後続行省略） Chú ý phạm vi thời gian, đối tượng hoặc quyền.', '', '', '', 55);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～を除く', '～をのぞく', 'Ngoại trừ（原表の後続行省略） Loại nhóm này trước khi xét các trường hợp còn lại.', '', '', '', 56);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～していないことが確認できれば', '～していないことがかくにんできれば', 'Nếu xác nhận được rằng chưa（原表の後続行省略） Phân biệt bằng chứng cho một sự kiện với bằng chứng cho sự kiện khác.', '', '', '', 57);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '少なくとも～しなければならない。', 'すくなくとも～しなければならない。', 'Tối thiểu phải（原表の後続行省略） Đây là yêu cầu giới hạn, không nhất thiết là giá trị vận hành thực tế.', '', '', '', 58);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～に基づいて', '～にもとづいて', 'Dựa trên（原表の後続行省略） Xác định quy tắc/bảng làm căn cứ.', '', '', '', 59);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～に沿っているかどうか', '～にそっているかどうか', 'Có tuân theo（原表の後続行省略） hay không? Kiểm tra lần lượt từng yêu cầu, không dựa vào quan hệ cá nhân hoặc thói quen.', '', '', '', 60);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', 'なお，～しても構わない。', 'なお，～してもかまわない。', 'Ngoài ra, có thể（原表の後続行省略） Điều kiện cho phép, không phải nghĩa vụ.', '', '', '', 61);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '直ちに影響がある。', 'ただちにえいきょうがある。', 'Bị ảnh hưởng ngay. Phân biệt tác động tức thời với tác động có thể xuất hiện lâu dài.', '', '', '', 62);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '次式で計算するものとする。', 'じしきでけいさんするものとする。', 'Quy định tính bằng công thức sau. Dùng mẫu số và đơn vị của đề.', '', '', '', 63);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '指摘事項として記載すべきもの', 'してきじこうとしてきさいすべきもの', 'Nội dung cần ghi là phát hiện kiểm toán. Tìm điểm có vấn đề cần sửa.', '', '', '', 64);
END $$;

DO $$
DECLARE cert_id INT;
BEGIN
    SELECT id INTO cert_id FROM certificates WHERE code = 'sg';
    DELETE FROM certificate_exam_questions WHERE certificate_id = cert_id;

    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Quản lý rủi ro và kỹ thuật bảo mật', 1, 'JIS Q 31000:2019（リスクマネジメント－指針）におけるリスクマネジメントプロセスに関する記述のうち，適切なものはどれか。

ア リスク対応の意義は，プロセスの設計，実施及び結末の質及び効果を保証し，改善することである。

イ リスク特定の意義は，リスクに対処するための選択肢を選定し，実施することである。

ウ リスク評価の意義は，組織の目的の達成を助ける又は妨害する可能性のあるリスクを発見し，認識し，記述することである。

エ リスク分析の意義は，必要に応じてリスクのレベルを含め，リスクの性質及び特徴を理解することである。', 'Trong các phát biểu về quy trình quản lý rủi ro theo JIS Q 31000:2019 (Quản lý rủi ro — Hướng dẫn), phát biểu nào phù hợp?

ア Ý nghĩa của xử lý rủi ro là bảo đảm và cải thiện chất lượng, hiệu quả của thiết kế, thực hiện và kết quả của quy trình.

イ Ý nghĩa của nhận diện rủi ro là lựa chọn và thực hiện các phương án đối phó với rủi ro.

ウ Ý nghĩa của đánh giá rủi ro là tìm, nhận biết và mô tả các rủi ro có thể giúp hoặc cản trở việc đạt mục tiêu tổ chức.

エ Ý nghĩa của phân tích rủi ro là hiểu bản chất và đặc điểm của rủi ro, bao gồm mức rủi ro khi cần.', NULL, 'エ', 'Phân tích rủi ro giúp hiểu bản chất, đặc điểm và mức rủi ro, nên エ đúng. ア mô tả theo dõi và xem xét; イ là xử lý rủi ro; ウ là nhận diện rủi ro. Trình tự cần phân biệt: nhận diện “có rủi ro gì”, phân tích “rủi ro có đặc điểm/mức độ nào”, đánh giá “có cần ưu tiên xử lý không”, xử lý “chọn và thực hiện biện pháp nào”.', '[{"term": "リスク特定", "reading": "リスクとくてい", "meaning": "nhận diện rủi ro"}, {"term": "リスク分析", "reading": "リスクぶんせき", "meaning": "phân tích rủi ro"}, {"term": "リスク評価", "reading": "リスクひょうか", "meaning": "đánh giá rủi ro"}, {"term": "リスク対応", "reading": "リスクたいおう", "meaning": "xử lý rủi ro"}, {"term": "妨害", "reading": "ぼうがい", "meaning": "cản trở"}]'::jsonb, 1);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Quản lý rủi ro và kỹ thuật bảo mật', 2, 'SIEM製品によるセキュリティ上の効果として，最も適切なものはどれか。

ア 様々な機器のログを集中管理することによって，横断的な分析や相関分析が可能になり，単純な目視だけでは発見困難な兆候を検知，分析，可視化することが可能になる。

イ 通信経路上を流れるパケットをキャプチャし，暗号化されたデータが改ざんされていないかどうかをチェックすることが可能になる。

ウ ファイアウォール，IDS，マルウェア対策といった複数のネットワークセキュリティ機能を一つの機器で実現することが可能になる。

エ ファイルの改ざんを検知すると，事前に取得済みのバックアップを用いて直ちに修復することが可能になる。', 'Hiệu quả bảo mật nào của sản phẩm SIEM là phù hợp nhất?

ア Quản lý tập trung nhật ký của nhiều thiết bị cho phép phân tích xuyên các thiết bị và phân tích tương quan, nhờ đó phát hiện, phân tích và trực quan hóa những dấu hiệu khó phát hiện chỉ bằng quan sát thủ công đơn giản.

イ Bắt gói tin trên đường truyền và kiểm tra dữ liệu đã mã hóa có bị sửa đổi hay không.

ウ Thực hiện nhiều chức năng bảo mật mạng như tường lửa, IDS, chống mã độc trong một thiết bị.

エ Khi phát hiện tệp bị sửa đổi, lập tức khôi phục bằng bản sao lưu đã lấy trước.', NULL, 'ア', 'SIEM tổng hợp sự kiện và nhật ký, phân tích tương quan để phát hiện dấu hiệu bất thường. ア mô tả đúng lợi ích này. ウ gần với UTM, một thiết bị hợp nhất nhiều chức năng bảo mật. イ là kiểm tra ở mức gói tin/đường truyền; エ là phục hồi tệp. Thu thập log tập trung không đồng nghĩa với tự động khôi phục mọi tệp.', '[{"term": "集中管理", "reading": "しゅうちゅうかんり", "meaning": "quản lý tập trung"}, {"term": "相関分析", "reading": "そうかんぶんせき", "meaning": "phân tích tương quan"}, {"term": "兆候", "reading": "ちょうこう", "meaning": "dấu hiệu"}, {"term": "可視化", "reading": "かしか", "meaning": "trực quan hóa"}, {"term": "改ざん", "reading": "かいざん", "meaning": "sửa đổi trái phép"}]'::jsonb, 2);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Quản lý rủi ro và kỹ thuật bảo mật', 3, 'ゼロトラストの説明として，最も適切なものはどれか。

ア 機器やソフトウェアの脆弱性のうち，開発元から対策方法，修正プログラムなどが提供されていない脆弱性が残っている状態のこと

イ 内部ネットワークであっても必ずしも安全ではないことを前提として対策を講じる考え方のこと

ウ 秘密情報そのものは明かさずに，自分が秘密情報を知っていることを相手に知らせる方法のこと

エ マルウェア定義ファイルを用いず，PC の振る舞いからマルウェア感染を検知する手法のこと', 'Mô tả nào về zero trust là phù hợp nhất?

ア Trạng thái thiết bị hoặc phần mềm còn lỗ hổng mà nhà phát triển chưa cung cấp biện pháp xử lý hay bản vá.

イ Cách tiếp cận triển khai biện pháp dựa trên giả định rằng ngay cả mạng nội bộ cũng không nhất thiết an toàn.

ウ Phương pháp cho đối phương biết mình biết một thông tin bí mật mà không tiết lộ chính thông tin đó.

エ Phương pháp phát hiện PC nhiễm mã độc từ hành vi của PC mà không dùng tệp định nghĩa mã độc.', NULL, 'イ', 'Zero trust không mặc nhiên tin thiết bị/người dùng chỉ vì nằm trong mạng nội bộ, nên イ đúng. ア mô tả tình trạng lỗ hổng chưa có biện pháp/bản vá, liên quan zero-day. ウ là chứng minh không tiết lộ tri thức. エ là phát hiện dựa vào hành vi. Cùng có yếu tố “không dùng” hoặc “zero” không có nghĩa là cùng một khái niệm.', '[{"term": "ゼロトラスト", "reading": "ゼロトラスト", "meaning": "zero trust"}, {"term": "脆弱性", "reading": "ぜいじゃくせい", "meaning": "lỗ hổng"}, {"term": "前提", "reading": "ぜんてい", "meaning": "tiền đề; giả định"}, {"term": "対策を講じる", "reading": "たいさくをこうじる", "meaning": "triển khai biện pháp"}, {"term": "振る舞い", "reading": "ふるまい", "meaning": "hành vi"}]'::jsonb, 3);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Quản lý rủi ro và kỹ thuật bảo mật', 4, '不正が発生する際には“不正のトライアングル”の3要素全てが存在すると考えられている。“不正のトライアングル”の構成要素の説明として，適切なものはどれか。

ア “機会”とは，情報システムなどの技術や物理的な環境，組織のルールなど，内部者による不正行為の実行を可能又は容易にする環境の存在である。

イ “情報と伝達”とは，必要な情報が識別，把握及び処理され，組織内外及び関係者相互に正しく伝えられるようにすることである。

ウ “正当化”とは，ノルマによるプレッシャなどのことである。

エ “動機”とは，良心のかしゃくを乗り越える都合の良い解釈や他人への責任転嫁など，内部者が不正行為を自ら納得させるための自分勝手な理由付けである。', 'Khi gian lận xảy ra, được cho rằng cả ba yếu tố của “tam giác gian lận” đều tồn tại. Giải thích nào về thành phần của tam giác này là phù hợp?

ア “Cơ hội” là sự tồn tại của môi trường cho phép hoặc tạo thuận lợi cho người nội bộ thực hiện hành vi gian lận, như kỹ thuật hệ thống thông tin, môi trường vật lý và quy tắc tổ chức.

イ “Thông tin và truyền đạt” là bảo đảm thông tin cần thiết được nhận diện, nắm bắt, xử lý và truyền đúng trong/ngoài tổ chức cũng như giữa các bên liên quan.

ウ “Hợp lý hóa” là áp lực do chỉ tiêu, v.v.

エ “Động cơ” là việc tự đặt lý do ích kỷ để thuyết phục bản thân chấp nhận hành vi gian lận, như diễn giải có lợi nhằm vượt qua cắn rứt lương tâm hoặc đổ trách nhiệm cho người khác.', NULL, 'ア', 'Ba yếu tố là động cơ/áp lực, cơ hội và hợp lý hóa. ア đúng vì nói đến điều kiện cho phép thực hiện gian lận. ウ thực ra mô tả động cơ/áp lực. エ mô tả hợp lý hóa. イ là một khái niệm trong kiểm soát nội bộ, không phải thành phần tam giác gian lận. Điểm dễ nhầm là phân biệt áp lực khiến muốn làm với lý lẽ dùng để tự biện hộ cho việc làm.', '[{"term": "不正のトライアングル", "reading": "ふせいのトライアングル", "meaning": "tam giác gian lận"}, {"term": "機会", "reading": "きかい", "meaning": "cơ hội"}, {"term": "動機", "reading": "どうき", "meaning": "động cơ"}, {"term": "正当化", "reading": "せいとうか", "meaning": "hợp lý hóa; tự biện hộ"}, {"term": "責任転嫁", "reading": "せきにんてんか", "meaning": "đổ trách nhiệm"}]'::jsonb, 4);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Quản lý rủi ro và kỹ thuật bảo mật', 5, 'DNSキャッシュサーバでのDNSキャッシュポイズニング攻撃の対策はどれか。

ア DNSサービスの待ち受けポートを53番に固定する。

イ 外部のDNSクライアントからの再帰的問合せを受け付けない設定にする。

ウ 権威DNSサーバへの問合せに使用するトランザクションIDを固定する。

エ 権威DNSサーバへの非再帰的問合せを行う設定にする。', 'Biện pháp nào chống tấn công đầu độc bộ nhớ đệm DNS tại máy chủ DNS cache?

ア Cố định cổng lắng nghe dịch vụ DNS ở số 53.

イ Thiết lập không nhận truy vấn đệ quy từ DNS client bên ngoài.

ウ Cố định transaction ID dùng trong truy vấn đến máy chủ DNS có thẩm quyền.

エ Thiết lập thực hiện truy vấn không đệ quy đến máy chủ DNS có thẩm quyền.', NULL, 'イ', 'Trong các lựa chọn, hạn chế truy vấn đệ quy từ client bên ngoài làm giảm khả năng kẻ bên ngoài lợi dụng máy chủ cache để khởi phát truy vấn phục vụ đầu độc. ア chỉ là cấu hình cổng dịch vụ thông thường. ウ làm ID dễ đoán, bất lợi cho bảo mật. エ mô tả cách hỏi máy chủ có thẩm quyền, không phải biện pháp hạn chế nguồn client gây truy vấn. Không hiểu イ là bảo đảm tuyệt đối loại bỏ mọi kiểu đầu độc; đây là biện pháp phù hợp trong nhóm đáp án.', '[{"term": "再帰的問合せ", "reading": "さいきてきといあわせ", "meaning": "truy vấn đệ quy"}, {"term": "権威DNSサーバ", "reading": "けんいディーエヌエスサーバ", "meaning": "máy chủ DNS có thẩm quyền"}, {"term": "待ち受けポート", "reading": "まちうけポート", "meaning": "cổng lắng nghe"}, {"term": "固定", "reading": "こてい", "meaning": "cố định"}, {"term": "キャッシュポイズニング", "reading": "キャッシュポイズニング", "meaning": "đầu độc bộ nhớ đệm"}]'::jsonb, 5);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Quản lý rủi ro và kỹ thuật bảo mật', 6, 'CVSSv3 について，基本評価基準，現状評価基準，環境評価基準のうち，現状評価基準の特徴はどれか。

ア 攻撃コードの出現の有無，利用可能な対策のレベルなどに応じ，評価結果は時間の経過で変化する。

イ 脆弱性及び想定される脅威に応じ，製品利用者ごとに評価結果は異なる。

ウ 製品利用者が脆弱性への対応を決めるための評価に用いる基準であり，評価結果は時間の経過で変化しない。

エ 評価結果は利用環境によらず同じで，かつ，時間の経過でも変化しない。', 'Trong ba nhóm tiêu chí CVSS v3 gồm cơ bản, hiện trạng và môi trường, đặc điểm của tiêu chí hiện trạng là gì?

ア Kết quả thay đổi theo thời gian tùy sự xuất hiện mã khai thác, mức độ sẵn có của biện pháp xử lý, v.v.

イ Kết quả khác nhau theo từng người sử dụng sản phẩm tùy lỗ hổng và mối đe dọa dự kiến.

ウ Là tiêu chí để người sử dụng đánh giá nhằm quyết định ứng phó với lỗ hổng; kết quả không thay đổi theo thời gian.

エ Kết quả giống nhau bất kể môi trường sử dụng và cũng không thay đổi theo thời gian.', NULL, 'ア', 'Nhóm hiện trạng (Temporal) phản ánh những yếu tố có thể thay đổi theo thời gian: độ trưởng thành mã khai thác, mức khắc phục và độ tin cậy thông tin. ア đúng. Nhóm cơ bản (Base) phản ánh đặc tính vốn có; nhóm môi trường (Environmental) điều chỉnh theo môi trường sử dụng. イ gợi nhóm môi trường; エ mô tả tính ổn định của nhóm cơ bản. ウ phủ nhận biến đổi theo thời gian nên không phù hợp.', '[{"term": "基本評価基準", "reading": "きほんひょうかきじゅん", "meaning": "tiêu chí đánh giá cơ bản"}, {"term": "現状評価基準", "reading": "げんじょうひょうかきじゅん", "meaning": "tiêu chí đánh giá hiện trạng"}, {"term": "環境評価基準", "reading": "かんきょうひょうかきじゅん", "meaning": "tiêu chí đánh giá môi trường"}, {"term": "攻撃コード", "reading": "こうげきコード", "meaning": "mã khai thác/tấn công"}, {"term": "時間の経過", "reading": "じかんのけいか", "meaning": "sự trôi qua của thời gian"}]'::jsonb, 6);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Pháp luật và kiểm toán', 7, '特定電子メール法の説明として，適切なものはどれか。

ア 特定電子メール法は，広告のための電子メールの送信を受託した事業者だけを規制している。

イ 特定電子メール法の規制は，受信者から受信拒否の通知があった場合にだけ広告宣伝メールを禁止するオプトアウト方式を採用している。

ウ 特定電子メール法の目的は，取引の公平の観点から広告宣伝メールを規制すること及び犯罪捜査のための通信傍受である。

エ 特定電子メール法は，規制の対象となる電子メールの送信者及び送信委託者に対する義務を規定している。', 'Giải thích nào về Luật thư điện tử đặc định là phù hợp?

ア Luật chỉ điều chỉnh doanh nghiệp được thuê gửi email quảng cáo.

イ Luật áp dụng cơ chế opt-out: chỉ cấm email quảng cáo khi người nhận thông báo từ chối nhận.

ウ Mục đích của luật là điều chỉnh email quảng cáo từ góc độ công bằng giao dịch và nghe lén truyền thông để điều tra tội phạm.

エ Luật quy định nghĩa vụ của người gửi và người ủy thác gửi các email thuộc phạm vi điều chỉnh.', NULL, 'エ', 'Đáp án エ xác định đúng cả người gửi và người ủy thác gửi là đối tượng có nghĩa vụ. ア thu hẹp sai đối tượng thành bên nhận thuê gửi. イ nhầm cơ chế opt-out với nguyên tắc opt-in áp dụng cho email quảng cáo thuộc phạm vi luật, có các ngoại lệ theo quy định. ウ ghép thêm mục đích nghe lén điều tra không thuộc nội dung mà câu hỏi mô tả. Đây là giải thích khái niệm theo đề năm 2025.', '[{"term": "特定電子メール法", "reading": "とくていでんしメールほう", "meaning": "Luật thư điện tử đặc định"}, {"term": "送信委託者", "reading": "そうしんいたくしゃ", "meaning": "người ủy thác gửi"}, {"term": "受託", "reading": "じゅたく", "meaning": "nhận ủy thác"}, {"term": "受信拒否", "reading": "じゅしんきょひ", "meaning": "từ chối nhận"}, {"term": "義務", "reading": "ぎむ", "meaning": "nghĩa vụ"}]'::jsonb, 7);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Pháp luật và kiểm toán', 8, '情報セキュリティ違反を犯した従業員に対する懲戒手続を規定した就業規則を含む社内規程の内容について，情報セキュリティ管理基準（平成 28 年）に基づき監査を実施した。監査人が，指摘事項として監査報告書に記載すべきものはどれか。

ア 従業員による情報セキュリティ違反の可能性を認識したら，直ちに懲戒手続を開始することを定めていた。

イ 懲戒手続は，情報セキュリティ違反による業務への影響度，違反を犯した従業員に対する教育の実施状況などを考慮した段階別の対応を定めていた。

ウ 懲戒手続は，情報セキュリティ違反を犯した従業員に対する恣意性を排除した公平な取扱いを定めていた。

エ 懲戒手続を具体化した細則を策定すること，及び従業員に周知徹底することを定めていた。', 'Kiểm toán nội dung quy định nội bộ, bao gồm nội quy lao động quy định thủ tục kỷ luật nhân viên vi phạm an toàn thông tin, dựa trên tiêu chuẩn quản lý an toàn thông tin năm Heisei 28 (2016). Điểm nào kiểm toán viên cần ghi là phát hiện cần khắc phục trong báo cáo?

ア Quy định bắt đầu ngay thủ tục kỷ luật khi nhận biết khả năng có vi phạm an toàn thông tin của nhân viên.

イ Quy định xử lý theo từng cấp độ, cân nhắc mức ảnh hưởng đến nghiệp vụ và tình hình đào tạo nhân viên vi phạm, v.v.

ウ Quy định đối xử công bằng, loại bỏ sự tùy tiện với nhân viên vi phạm.

エ Quy định xây dựng chi tiết thủ tục và phổ biến đầy đủ cho nhân viên.', NULL, 'ア', 'ア là điểm cần nêu: chỉ nhận biết khả năng vi phạm chưa đủ để ngay lập tức bắt đầu kỷ luật; cần xác minh vi phạm trước khi áp dụng quy trình chính thức. Các lựa chọn còn lại nói đến tương xứng mức độ, công bằng và quy định rõ/phổ biến, đều phù hợp. Câu hỏi hỏi “điểm cần chỉ ra”, nên phải chọn nội dung có vấn đề chứ không chọn quy định tốt.', '[{"term": "懲戒手続", "reading": "ちょうかいてつづき", "meaning": "thủ tục kỷ luật"}, {"term": "就業規則", "reading": "しゅうぎょうきそく", "meaning": "nội quy lao động"}, {"term": "恣意性", "reading": "しいせい", "meaning": "tính tùy tiện"}, {"term": "段階別", "reading": "だんかいべつ", "meaning": "theo từng cấp độ"}, {"term": "周知徹底", "reading": "しゅうちてってい", "meaning": "phổ biến đầy đủ"}]'::jsonb, 8);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Dịch vụ, dữ liệu và chuyển đổi số', 9, 'サービス満足度の目標値を“サービス満足度に関する調査アンケートの満足度の平均点が5点満点中4.0点”と設定したサービスがある。調査アンケートの集計結果が表のとおりであるとき，目標達成率は幾らか。ここで，目標達成率は次式で計算するものとする。

目標達成率 ＝ 満足度の平均点 ÷ 満足度の目標値

〔集計結果〕

| 満足度（点） | 回答数 |
| --- | --- |
| 5 | 50 |
| 4 | 250 |
| 3 | 150 |
| 2 | 50 |
| 1 | 0 |

ア 0.6 イ 0.72 ウ 0.8 エ 0.9', 'Một dịch vụ đặt mục tiêu “điểm hài lòng trung bình trong khảo sát là 4,0 trên tối đa 5 điểm”. Kết quả tổng hợp như bảng. Tỷ lệ đạt mục tiêu bằng bao nhiêu? Tính theo công thức:

Tỷ lệ đạt mục tiêu = điểm hài lòng trung bình ÷ giá trị mục tiêu hài lòng.

| Điểm hài lòng | Số câu trả lời |
|---|---|
| 5 | 50 |
| 4 | 250 |
| 3 | 150 |
| 2 | 50 |
| 1 | 0 |

ア 0,6　イ 0,72　ウ 0,8　エ 0,9.', NULL, 'エ', 'Số phản hồi = 50 + 250 + 150 + 50 = 500. Tổng điểm = 5×50 + 4×250 + 3×150 + 2×50 = 1.800. Trung bình = 1.800/500 = 3,6; tỷ lệ đạt mục tiêu = 3,6/4,0 = 0,9, tức 90%. Chia cho 5 sẽ ra 0,72 nhưng 5 là điểm tối đa, không phải mục tiêu 4,0. Phải dùng trung bình có trọng số theo số phản hồi.', '[{"term": "満足度", "reading": "まんぞくど", "meaning": "mức hài lòng"}, {"term": "目標達成率", "reading": "もくひょうたっせいりつ", "meaning": "tỷ lệ đạt mục tiêu"}, {"term": "集計結果", "reading": "しゅうけいけっか", "meaning": "kết quả tổng hợp"}, {"term": "平均点", "reading": "へいきんてん", "meaning": "điểm trung bình"}, {"term": "満点", "reading": "まんてん", "meaning": "điểm tối đa"}]'::jsonb, 9);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Dịch vụ, dữ liệu và chuyển đổi số', 10, 'システムの信頼性指標であるRASISの，安全性を除く四つに関する記述のうち，適切なものはどれか。

ア Rの信頼性は，システムのMTBFによって表す。

イ Aの可用性は，システムが稼働している時間の平均値によって表す。

ウ Sの保守性は，システムの稼働率によって表す。

エ Iの完全性は，システムの故障率によって表す。', 'Trong bốn yếu tố của RASIS ngoài tính an toàn/bảo mật, phát biểu nào phù hợp?

ア R, độ tin cậy, được biểu thị bằng MTBF của hệ thống.

イ A, tính sẵn sàng, được biểu thị bằng giá trị trung bình của thời gian hệ thống đang hoạt động.

ウ S, tính bảo trì, được biểu thị bằng tỷ lệ hoạt động của hệ thống.

エ I, tính toàn vẹn, được biểu thị bằng tỷ lệ hỏng của hệ thống.', NULL, 'ア', 'R là Reliability, thường đánh giá bằng MTBF: thời gian trung bình giữa các lần hỏng; MTBF lớn hơn thường thể hiện độ tin cậy cao hơn. A là Availability, liên quan tỷ lệ sẵn sàng MTBF/(MTBF + MTTR), không chỉ thời gian hoạt động trung bình. S (Serviceability) liên quan khả năng bảo trì/khôi phục, thường dùng MTTR. I (Integrity) là tính toàn vẹn, không phải tỷ lệ hỏng. S cuối trong RASIS là Security và đã được loại khỏi phạm vi câu hỏi.', '[{"term": "信頼性", "reading": "しんらいせい", "meaning": "độ tin cậy"}, {"term": "可用性", "reading": "かようせい", "meaning": "tính sẵn sàng"}, {"term": "保守性", "reading": "ほしゅせい", "meaning": "tính bảo trì"}, {"term": "完全性", "reading": "かんぜんせい", "meaning": "tính toàn vẹn"}, {"term": "稼働率", "reading": "かどうりつ", "meaning": "tỷ lệ hoạt động"}]'::jsonb, 10);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Dịch vụ, dữ liệu và chuyển đổi số', 11, '企業全体で使用するデータを統合・整理したデータウェアハウスから，特定の分析目的のためにデータを加工して構築したものはどれか。

ア データカタログ イ データマート

ウ データリネージ エ データレイク', 'Từ kho dữ liệu đã tích hợp và sắp xếp dữ liệu dùng cho toàn doanh nghiệp, xử lý dữ liệu để xây dựng một tập phục vụ mục đích phân tích cụ thể. Tập đó gọi là gì?

ア Data catalogue (danh mục dữ liệu).

イ Data mart (kho dữ liệu chuyên biệt).

ウ Data lineage (dòng nguồn gốc dữ liệu).

エ Data lake (hồ dữ liệu).', NULL, 'イ', 'Data mart là tập/kho dữ liệu tập trung cho một phòng ban hoặc mục đích phân tích cụ thể, có thể được tạo từ data warehouse toàn doanh nghiệp. Catalogue hỗ trợ tìm và hiểu dữ liệu; lineage mô tả nguồn gốc và quá trình biến đổi; data lake lưu lượng lớn dữ liệu ở nhiều dạng, thường cả dạng thô. Từ khóa quyết định là “mục đích phân tích cụ thể”.', '[{"term": "データウェアハウス", "reading": "データウェアハウス", "meaning": "kho dữ liệu"}, {"term": "データマート", "reading": "データマート", "meaning": "kho dữ liệu chuyên biệt"}, {"term": "統合", "reading": "とうごう", "meaning": "tích hợp"}, {"term": "加工", "reading": "かこう", "meaning": "xử lý; biến đổi"}, {"term": "特定", "reading": "とくてい", "meaning": "cụ thể; xác định"}]'::jsonb, 11);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Dịch vụ, dữ liệu và chuyển đổi số', 12, '経済産業省が取りまとめた“DX レポート 2”では，組織が DX 実現に至る段階をデジタイゼーション，デジタライゼーション，デジタルトランスフォーメーションに分けている。製造業のデジタル化事例において，デジタルトランスフォーメーションの段階に達しているものはどれか。

| DX実現に至る段階 | 説明 |
| --- | --- |
| デジタイゼーション | アナログ・物理データのデジタルデータ化 |
| デジタライゼーション | 個別の業務・製造プロセスのデジタル化 |
| デジタルトランスフォーメーション | 組織横断／全体の業務・製造プロセスのデジタル化，“顧客起点の価値創出”のための事業やビジネスモデルの変革 |

ア 3D 画像撮影用の高性能カメラを生産ラインに設置し，カメラの前を通過する製造物のデジタル画像をリアルタイムで記録して，出荷検査の証拠データとする。

イ 技術継承のために，生産ラインに設置したカメラと，熟練工の手に装着したウェアラブルセンサーによって，熟練工の所作をデジタルデータとして保存した上で，AIを用いて熟練工の動きをモデル化する。

ウ 顧客から販売・在庫情報を，部品メーカーから生産・在庫情報をデジタルデータで逐次入手し，AI を用いて複数の需給調整案を高速でシミュレーションすることによって，サプライチェーン全体を最適化する。

エ 生産ラインで取得したデジタル画像データから良品，不良品の特徴を AI に学習させた上で，AI で画像解析を行うことによって，自社の出荷時検品作業を効率化する。', '“DX Report 2” do Bộ Kinh tế, Thương mại và Công nghiệp tổng hợp chia các giai đoạn để tổ chức đạt DX thành digitization, digitalization và digital transformation. Trong các ví dụ số hóa ngành sản xuất, ví dụ nào đã đạt giai đoạn digital transformation?

| Giai đoạn | Mô tả |
|---|---|
| Digitization | Chuyển dữ liệu tương tự/vật lý thành dữ liệu số. |
| Digitalization | Số hóa từng nghiệp vụ/quy trình sản xuất riêng lẻ. |
| Digital transformation | Số hóa nghiệp vụ/quy trình sản xuất xuyên tổ chức hoặc toàn bộ; biến đổi hoạt động kinh doanh và mô hình kinh doanh để tạo giá trị xuất phát từ khách hàng. |

ア Đặt camera hiệu năng cao chụp ảnh 3D trên dây chuyền; ghi ảnh số của sản phẩm đi qua theo thời gian thực làm dữ liệu chứng cứ kiểm tra xuất hàng.

イ Để kế thừa kỹ thuật, dùng camera trên dây chuyền và cảm biến đeo trên tay thợ lành nghề để lưu thao tác thành dữ liệu số, sau đó dùng AI mô hình hóa chuyển động của thợ.

ウ Liên tục lấy dữ liệu số bán hàng/tồn kho từ khách hàng và sản xuất/tồn kho từ nhà sản xuất linh kiện; dùng AI mô phỏng nhanh nhiều phương án điều chỉnh cung cầu để tối ưu toàn chuỗi cung ứng.

エ Cho AI học đặc điểm hàng tốt/hàng lỗi từ ảnh số trên dây chuyền, rồi dùng AI phân tích ảnh để nâng hiệu quả kiểm tra trước khi xuất hàng của công ty.', NULL, 'ウ', 'ウ mở rộng đến khách hàng, nhà cung cấp và toàn chuỗi cung ứng, tối ưu xuyên tổ chức theo nhu cầu khách hàng; phù hợp mức transformation của bảng. ア chủ yếu tạo dữ liệu số. イ và エ dùng dữ liệu/AI để cải tiến một khâu cụ thể. Không phải cứ dùng AI là DX ở giai đoạn cao nhất; cần xét phạm vi biến đổi và giá trị khách hàng.', '[{"term": "顧客起点", "reading": "こきゃくきてん", "meaning": "xuất phát từ khách hàng"}, {"term": "組織横断", "reading": "そしきおうだん", "meaning": "xuyên tổ chức"}, {"term": "需給調整", "reading": "じゅきゅうちょうせい", "meaning": "điều chỉnh cung cầu"}, {"term": "熟練工", "reading": "じゅくれんこう", "meaning": "thợ lành nghề"}, {"term": "技術継承", "reading": "ぎじゅつけいしょう", "meaning": "kế thừa kỹ thuật"}, {"term": "最適化", "reading": "さいてきか", "meaning": "tối ưu hóa"}]'::jsonb, 12);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Tình huống an toàn thông tin', 13, 'A社は従業員300名のITサービス企業であり，ヘルプデスク業務のアウトソーシングサービスを提供している。A 社はオンプレミスのシステムを所有しておらず，顧客向けサービスのほか，社内業務でもクラウドサービスを利用している。A 社では，各従業員に PC 及びスマートフォンを貸与している。スマートフォンは勤怠管理などの社内業務だけに利用している。

A 社では，クラウドサービスについての可用性に関する重要度の評価（以下，可用性に関する重要度の評価を可用性評価という）を本来実施すべきであったが，実施できていなかった。そこで，A 社の情報セキュリティリーダーである B 主任が，表 1 のとおり，A 社がリスク評価で用いる可用性評価の基準を用いて可用性評価を実施することになった。

表1 A社がリスク評価で用いる可用性評価の基準

| 重要度 | 可用性評価の基準 | 該当するサービスの例 |
| --- | --- | --- |
| 2 | サービスが利用できなくなると自社だけではなく，顧客にも直ちに影響がある。 | 顧客に提供しているサービス，顧客にサービスを提供するために利用している外部のサービス |
| 1 | サービスが利用できなくなると自社にだけ，直ちに影響がある。 | 重要度 0 のサービスを除く，社内で利用しているサービス |
| 0 | サービスが利用できなくなっても自社及び顧客に，直ちに影響はない。 | 社内でデータの長期保存に利用しているサービス |

B 主任は A 社が利用しているクラウドサービスについて可用性評価を実施し，利用方法及び可用性に関する重要度を表2のとおりまとめた。

表2 B主任がまとめた可用性評価の結果（抜粋）

| A社が利用しているクラウドサービス | 利用方法 | 可用性に関する重要度 |
| --- | --- | --- |
| 電子メール | ヘルプデスク利用者からの電子メールによる問合せの受付及び回答に利用する。回答は原則として電子メールで行うが，回答に機密性の高い情報が含まれる場合は，あらかじめ登録されているヘルプデスク利用者の電話番号にA社から電話する。 | ［a1］ |
| 人事・労務管理 | マイナンバーを含む人事情報の管理及び労務管理に利用する。 | ［a2］ |

B 主任は，表 2 の内容を A 社の情報セキュリティ委員会に報告し，可用性に関する重要度が適切であることの承認を得た。

設問 表2中の ［a1］ ， ［a2］ に入れる数値の適切な組合せを，aに関する

解答群の中から選べ。

aに関する解答群

| 選択肢 | ［a1］ | ［a2］ |
| --- | --- | --- |
| ア | 0 | 0 |
| イ | 0 | 1 |
| ウ | 0 | 2 |
| エ | 1 | 0 |
| オ | 1 | 1 |
| カ | 1 | 2 |
| キ | 2 | 0 |
| ク | 2 | 1 |
| ケ | 2 | 2 |', 'A là doanh nghiệp dịch vụ IT có 300 nhân viên, cung cấp dịch vụ thuê ngoài nghiệp vụ help desk. A không sở hữu hệ thống on-premises; sử dụng dịch vụ đám mây cho cả dịch vụ khách hàng và nghiệp vụ nội bộ. A cho mỗi nhân viên mượn PC và điện thoại thông minh. Điện thoại chỉ dùng cho nghiệp vụ nội bộ như quản lý chấm công.

A đáng lẽ phải đánh giá mức quan trọng về tính sẵn sàng của dịch vụ đám mây (sau đây gọi là đánh giá tính sẵn sàng), nhưng chưa thực hiện được. Vì vậy B, trưởng nhóm phụ trách an toàn thông tin, sẽ thực hiện đánh giá theo tiêu chí mà A dùng trong đánh giá rủi ro ở bảng 1.

**Bảng 1. Tiêu chí đánh giá tính sẵn sàng**

| Mức quan trọng | Tiêu chí | Ví dụ dịch vụ |
|---|---|---|
| 2 | Khi không dùng được dịch vụ, không chỉ A mà khách hàng cũng bị ảnh hưởng ngay. | Dịch vụ cung cấp cho khách hàng; dịch vụ bên ngoài được dùng để cung cấp dịch vụ cho khách hàng. |
| 1 | Khi không dùng được dịch vụ, chỉ A bị ảnh hưởng ngay. | Dịch vụ dùng nội bộ, trừ dịch vụ mức 0. |
| 0 | Dù không dùng được dịch vụ, A và khách hàng không bị ảnh hưởng ngay. | Dịch vụ dùng để lưu dữ liệu dài hạn trong nội bộ. |

B đánh giá các dịch vụ đám mây A đang dùng và tổng hợp cách sử dụng, mức quan trọng về tính sẵn sàng vào bảng 2.

**Bảng 2. Kết quả đánh giá của B (trích)**

| Dịch vụ đám mây | Cách sử dụng | Mức quan trọng |
|---|---|---|
| Email | Tiếp nhận và trả lời câu hỏi qua email từ người dùng help desk. Nguyên tắc là trả lời bằng email, nhưng nếu câu trả lời chứa thông tin bảo mật cao thì A gọi đến số điện thoại người dùng help desk đã đăng ký trước. | ［a1］ |
| Quản lý nhân sự/lao động | Quản lý thông tin nhân sự có My Number và quản lý lao động. | ［a2］ |

B báo cáo nội dung bảng 2 cho ủy ban an toàn thông tin A và được phê duyệt rằng mức quan trọng về tính sẵn sàng là phù hợp.

**Câu hỏi:** Chọn tổ hợp số thích hợp điền vào ［a1］, ［a2］ trong bảng 2 từ nhóm đáp án a.

| Lựa chọn | a1 | a2 |
|---|---|---|
| ア | 0 | 0 |
| イ | 0 | 1 |
| ウ | 0 | 2 |
| エ | 1 | 0 |
| オ | 1 | 1 |
| カ | 1 | 2 |
| キ | 2 | 0 |
| ク | 2 | 1 |
| ケ | 2 | 2 |', NULL, 'ク', 'a1 = 2 vì email là kênh tiếp nhận/trả lời help desk, mất dịch vụ ảnh hưởng ngay cả khách hàng. Việc gọi điện khi câu trả lời có thông tin nhạy cảm không thay thế toàn bộ chức năng email. a2 = 1 vì hệ thống nhân sự/lao động phục vụ nghiệp vụ nội bộ và gián đoạn ảnh hưởng ngay đến A. Có My Number làm tăng yêu cầu bảo mật, nhưng câu hỏi đang đánh giá tính sẵn sàng, không phải tính bí mật. Mức 0 dành cho dịch vụ lưu dài hạn không gây ảnh hưởng tức thời, không phù hợp hai dịch vụ này.', '[{"term": "可用性評価", "reading": "かようせいひょうか", "meaning": "đánh giá tính sẵn sàng"}, {"term": "重要度", "reading": "じゅうようど", "meaning": "mức quan trọng"}, {"term": "直ちに", "reading": "ただちに", "meaning": "ngay lập tức"}, {"term": "勤怠管理", "reading": "きんたいかんり", "meaning": "quản lý chấm công"}, {"term": "労務管理", "reading": "ろうむかんり", "meaning": "quản lý lao động"}, {"term": "貸与", "reading": "たいよ", "meaning": "cho mượn; cấp sử dụng"}]'::jsonb, 13);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Tình huống an toàn thông tin', 14, 'A 社は，従業員 300 名の部品メーカーである。A 社ではこれまで，業務に必要なファイルを他社との間で受け渡す場合には電子メール（以下，メールという）を利用してきた。最近になって，取引先の B 社から，ファイルの受渡しについては，C サービスというクラウドストレージサービスを利用して欲しいとの要請を受けた。図1は，Cサービスを利用した場合のファイル受渡しの流れである。

1 ファイルの送信者は，受信者に渡したいファイルを C サービス上にアップロードする。アップロードされたファイルは，Cサービス上では暗号化されて保存される。

2 ファイルの送信者は，受信者をメールアドレスで指定して，ファイルのアクセス権を付与する。アクセス権の付与や取消しはいつでも行える。

3 受信者にアクセス権が付与されると，ファイルのダウンロード用 URL が生成され，指定されたメールアドレスにメールで通知される。なお，URLには推測困難な文字列が含まれている。

4 受信者が，メールに記載された URL にアクセスして自身のメールアドレスを入力すると，復号されたファイルがダウンロードされる。

5 ファイルがダウンロードされると，送信者の利用者 ID，アップロード日時，ファイル名，ファイルのダウンロード用URL，ダウンロードの際のアクセス元IPアドレス，4で入力したメールアドレス及びダウンロード日時がログに記録される。

6 送信者は，自身のアップロードしたファイルについて，ダウンロードのログを確認できる。

注記 Cサービスとの通信にはHTTPS（HTTP over TLS）が用いられている。

図1 ファイル受渡しの流れそこで A 社では，C サービスを利用した場合のリスクを評価するために，検討会を開催した。検討会において，情報セキュリティリーダーのD主任は，次のとおり説明した。

C サービスを利用することによって，情報漏えいのリスクを低減でき，さらに情報漏えいの有無も確認できる。具体的には，ファイルの送信者は，誤ったメールアドレスを指定してメールを送信してしまった場合に，誤りに気付いた時点で，すぐに［a1］ を行うことができる。次に，ファイルが ［a2］ されていないことがログによって確認できれば， ［a3］ していないと判断することができる。

設問 本文中の ［a1］ 〜 ［a3］ に入れる次の字句の組合せはどれか。a に関する解答群のうち，最も適切なものを選べ。

(一) アクセス権の取消し

(二) アップロード

(三) 情報漏えい

(四) ダウンロード

(五) メールで通知

(六) メールに記載されたURLに受信者はまだアクセス

aに関する解答群

| 選択肢 | ［a1］ | ［a2］ | ［a3］ |
| --- | --- | --- | --- |
| ア | (一) | (二) | (三) |
| イ | (一) | (二) | (六) |
| ウ | (一) | (四) | (三) |
| エ | (一) | (四) | (六) |
| オ | (五) | (二) | (三) |
| カ | (五) | (二) | (六) |
| キ | (五) | (四) | (三) |
| ク | (五) | (四) | (六) |', 'A là nhà sản xuất linh kiện có 300 nhân viên. Trước đây A dùng email để trao đổi tệp cần cho công việc với doanh nghiệp khác. Gần đây đối tác B yêu cầu sử dụng dịch vụ lưu trữ đám mây C để trao đổi tệp. Hình 1 là quy trình khi dùng C.

**Hình 1. Quy trình trao đổi tệp**

1. Người gửi tải tệp muốn chuyển cho người nhận lên C. Tệp được lưu dưới dạng mã hóa trên C.
2. Người gửi chỉ định người nhận bằng địa chỉ email và cấp quyền truy cập tệp. Có thể cấp hoặc hủy quyền bất kỳ lúc nào.
3. Khi người nhận được cấp quyền, URL tải tệp được tạo và thông báo bằng email tới địa chỉ đã chỉ định. URL chứa chuỗi ký tự khó đoán.
4. Khi người nhận truy cập URL trong email và nhập địa chỉ email của mình, tệp đã giải mã được tải xuống.
5. Khi tệp được tải xuống, log ghi: ID người gửi, thời điểm tải lên, tên tệp, URL tải tệp, IP nguồn truy cập khi tải xuống, địa chỉ email nhập ở bước 4 và thời điểm tải xuống.
6. Người gửi có thể kiểm tra log tải xuống của tệp mình đã tải lên.

Chú thích: Truyền thông với C dùng HTTPS (HTTP over TLS).

A tổ chức cuộc họp để đánh giá rủi ro khi sử dụng C. Trong cuộc họp, D, trưởng nhóm phụ trách an toàn thông tin, giải thích như sau:

Sử dụng C có thể giảm rủi ro rò rỉ thông tin, đồng thời kiểm tra có rò rỉ hay không. Cụ thể, nếu người gửi chỉ định nhầm địa chỉ email và gửi email, ngay khi nhận ra sai sót có thể thực hiện ［a1］. Tiếp theo, nếu xác nhận qua log rằng tệp chưa bị ［a2］, có thể kết luận chưa ［a3］.

**Câu hỏi:** Chọn tổ hợp từ điền vào ［a1］–［a3］ trong đoạn văn. Chọn phương án phù hợp nhất trong nhóm a.

(一) Hủy quyền truy cập.

(二) Tải lên.

(三) Rò rỉ thông tin.

(四) Tải xuống.

(五) Thông báo bằng email.

(六) Người nhận vẫn chưa truy cập URL ghi trong email.

| Lựa chọn | a1 | a2 | a3 |
|---|---|---|---|
| ア | (一) | (二) | (三) |
| イ | (一) | (二) | (六) |
| ウ | (一) | (四) | (三) |
| エ | (一) | (四) | (六) |
| オ | (五) | (二) | (三) |
| カ | (五) | (二) | (六) |
| キ | (五) | (四) | (三) |
| ク | (五) | (四) | (六) |', NULL, 'ウ', 'a1 = hủy quyền truy cập, a2 = tải xuống, a3 = rò rỉ thông tin. Hủy quyền giúp chặn việc tải tệp tiếp theo sau khi phát hiện gửi nhầm. Log trong đề được ghi khi tải xuống; nếu không có lần tải xuống thì, theo cơ chế và giả định của tình huống, nội dung tệp chưa bị tiết lộ qua việc tải đó. Không thể suy ra người nhận chưa từng truy cập URL: việc mở URL và việc tải tệp là hai sự kiện khác nhau, trong khi log được mô tả chỉ ghi lần tải xuống. HTTPS bảo vệ truyền thông, không sửa sai sót chọn người nhận. Gửi email báo lại cũng không tương đương thu hồi quyền.', '[{"term": "受渡し", "reading": "うけわたし", "meaning": "trao đổi; bàn giao"}, {"term": "アクセス権の取消し", "reading": "アクセスけんのとりけし", "meaning": "hủy quyền truy cập"}, {"term": "復号", "reading": "ふくごう", "meaning": "giải mã"}, {"term": "情報漏えい", "reading": "じょうほうろうえい", "meaning": "rò rỉ thông tin"}, {"term": "推測困難", "reading": "すいそくこんなん", "meaning": "khó đoán"}, {"term": "アクセス元", "reading": "アクセスもと", "meaning": "nguồn truy cập"}]'::jsonb, 14);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Tình huống an toàn thông tin', 15, 'A 社は，スマートフォン用ヘルスケア関連アプリケーションソフトウェア（以下，A アプリという）の開発，販売を行う会社である。A アプリは，ヘルスケアデータ収集機能によって，利用者の体重や歩数のデータを収集するとともに，アンケート機能によって，勤務先の業種，年収などのデータを収集している。

営業部は，保険会社である B 社と共同のビジネスを検討している。その中で，A アプリで収集したデータ及び今後収集するデータから匿名加工情報を作成した上で，その匿名加工情報を B 社に第三者提供することを検討している。B 社では，提供を受けた匿名加工情報を分析して，B 社の保険商品のマーケティングに活用しようとしている。分析の対象は，年代，性別，年収区分，住んでいる地域区分及び勤務先の業種と体重及び歩数との関係である。ここで，地域区分とは，北海道，東北，南関東などの区分のことをいう。

加工対象となる“個人情報データベース等”（以下，加工対象情報という）は，表

1 の顧客属性データと表 2 のヘルスケアデータの 2 種類からなり，利用者番号によって関連付けられている。

表1 顧客属性データ

| 利用者番号 | 氏名 | 性別 | 生年月日 | 電子メールアドレス | 住所 | 勤務先の業種 | 年収 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 114567 | 情報 一郎 | 男 | 1984年4月4日 | ichiro@●●●.ne.jp | 愛知県名古屋市中区上前津X-X-X | 金融業 | 1,850万 |
| 114568 | 積招 花子 | 女 | 2003年3月31日 | sekimane@▲▲▲.ne.jp | 東京都文京区本駒込X-X-X | 小売業 | 380万 |
| 114573 | 試験 五郎 | 男 | 1951年12月9日 | shiken@■■■.ne.jp | 東京都中央区月島X-X-X | 製造業 | 630万 |
| （原表の後続行省略） | （原表の後続行省略） | （原表の後続行省略） | （原表の後続行省略） | （原表の後続行省略） | （原表の後続行省略） | （原表の後続行省略） | （原表の後続行省略） |

表2 ヘルスケアデータ

| 利用者番号 | 記録日 | 体重 | 歩数 |
| --- | --- | --- | --- |
| 114567 | 202N年02月11日 | 121.3 | 5,321 |
| 114568 | 202N年02月11日 | 43.5 | 33,012 |
| 114568 | 202N年02月12日 | 43.0 | 12,007 |
| 114573 | 202N年02月12日 | 63.0 | 7,604 |
| （原表の後続行省略） | （原表の後続行省略） | （原表の後続行省略） | （原表の後続行省略） |

営業部の情報セキュリティリーダーであるC課長は，加工対象情報に含まれる各情報の項目について，適用する匿名加工情報の作成に係る手法（以下，匿名加工情報の作成に係る手法を匿名加工手法という）を表3にまとめた。

表3 匿名加工手法

| 項番 | 手法名 | 解説 |
| --- | --- | --- |
| （一） | 項目削除 | 加工対象情報に含まれる個人情報の項目を削除すること。例えば，年齢のデータを加工対象情報から削除すること。 |
| （二） | 一般化 | 加工対象情報に含まれる記述などについて，上位概念に置き換えること。例えば，購買履歴のデータで“きゅうり”を“野菜”に置き換えること。 |
| （三） | トップ（ボトム）コーディング | 加工対象情報に含まれる数値について，特に大きい又は小さい数値をまとめること。例えば，年齢に関するデータで，“98 歳”，“115歳”といった数値データを“80歳以上”というデータにまとめること。 |
| （四） | 丸め | 加工対象情報に含まれる数値について，四捨五入などして丸めること。例えば，生年月日から“34 歳”とされる場合について，“30代”のように年代に置き換えること。 |

注記 本表は，個人情報保護委員会事務局“仮名加工情報・匿名加工情報 信頼ある個人情報の利活用に向けてー制度編ー(第2版)"を基にC課長が作成した。

C課長は，加工対象情報である表1及び表2に示す各データに対して，表3 の匿名加工手法を必要に応じて適用し匿名加工情報を作成する案を用意した。その案を法務部の D 課長に報告したところ，D 課長からは，想定するマーケティング用途にも有効であり，匿名加工手法の適用も適切であるとの回答を得た。

設問 解答群に示した 3 項目それぞれについて，C 課長が適用した匿名加工手法はどれか。表3の手法のうち，適用したものの組合せを，解答群の中から選べ。なお，各項目に対して複数の匿名加工手法を適用しても構わないし，一つも適用せずに“加工なし”としても構わない。

解答群

| 選択肢 | 電子メールアドレス | 勤務先の業種 | 体重 |
| --- | --- | --- | --- |
| ア | 加工なし | 加工なし | （三） |
| イ | 加工なし | 加工なし | （三），（四） |
| ウ | 加工なし | （一） | （一） |
| エ | 加工なし | （一） | （三） |
| オ | 加工なし | （一） | （三），（四） |
| カ | （一） | 加工なし | （三） |
| キ | （一） | 加工なし | （三），（四） |
| ク | （一） | （一） | （一） |
| ケ | （一） | （一） | （三） |
| コ | （一） | （一） | （三），（四） |

### データのキー／Khóa dữ liệu

Đề nêu liên kết bằng 利用者番号 nhưng không khai báo ràng buộc khóa. Theo cấu trúc bảng, 利用者番号 là khóa chính hợp lý của bảng 1; trong bảng 2 là khóa ngoại tham chiếu bảng 1. Cặp (利用者番号, 記録日) là khóa ghép hợp lý của bảng 2 nếu mỗi người chỉ có một bản ghi trong ngày; đây là diễn giải cấu trúc, không phải ràng buộc được đề khẳng định.', 'A phát triển và bán phần mềm ứng dụng chăm sóc sức khỏe cho điện thoại, gọi là ứng dụng A. Chức năng thu thập dữ liệu sức khỏe lấy dữ liệu cân nặng, số bước của người dùng; chức năng khảo sát lấy dữ liệu ngành làm việc, thu nhập hằng năm, v.v.

Bộ phận kinh doanh xem xét hoạt động hợp tác với công ty bảo hiểm B. Họ dự định tạo thông tin đã xử lý ẩn danh từ dữ liệu ứng dụng A đã thu thập và sẽ thu thập, rồi cung cấp thông tin ẩn danh đó cho bên thứ ba là B. B sẽ phân tích để dùng cho tiếp thị sản phẩm bảo hiểm. Đối tượng phân tích là quan hệ giữa nhóm tuổi, giới tính, nhóm thu nhập, nhóm vùng cư trú, ngành làm việc với cân nặng và số bước. Nhóm vùng là các vùng như Hokkaido, Tohoku, Nam Kanto, v.v.

“Cơ sở dữ liệu thông tin cá nhân, v.v.” cần xử lý, gọi là thông tin đầu vào xử lý, gồm hai loại: dữ liệu thuộc tính khách hàng ở bảng 1 và dữ liệu sức khỏe ở bảng 2, liên kết bằng 利用者番号 (số người dùng).

**Bảng 1. Thuộc tính khách hàng**

| 利用者番号 | Họ tên | Giới tính | Ngày sinh | Email | Địa chỉ | Ngành làm việc | Thu nhập năm |
|---|---|---|---|---|---|---|---|
| 114567 | 情報 一郎 | Nam | 1984-04-04 | ichiro@●●●.ne.jp | 愛知県名古屋市中区上前津X-X-X | Tài chính | 1.850 vạn yên |
| 114568 | 積招 花子 | Nữ | 2003-03-31 | sekimane@▲▲▲.ne.jp | 東京都文京区本駒込X-X-X | Bán lẻ | 380 vạn yên |
| 114573 | 試験 五郎 | Nam | 1951-12-09 | shiken@■■■.ne.jp | 東京都中央区月島X-X-X | Sản xuất | 630 vạn yên |

Dòng tiếp theo trong bảng gốc biểu thị các bản ghi khác không được đề cung cấp; không có dữ liệu cụ thể để khôi phục.

**Bảng 2. Dữ liệu sức khỏe**

| 利用者番号 | Ngày ghi nhận | Cân nặng | Số bước |
|---|---|---|---|
| 114567 | 202N-02-11 | 121,3 | 5.321 |
| 114568 | 202N-02-11 | 43,5 | 33.012 |
| 114568 | 202N-02-12 | 43,0 | 12.007 |
| 114573 | 202N-02-12 | 63,0 | 7.604 |

Dòng tiếp theo trong bảng gốc biểu thị các bản ghi khác không được đề cung cấp. Giữ 202N là ký hiệu năm của đề.

**Quan hệ dữ liệu:** Đề nêu liên kết bằng 利用者番号 nhưng không khai báo ràng buộc khóa. Theo cấu trúc bảng, 利用者番号 là khóa chính hợp lý của bảng 1; trong bảng 2 là khóa ngoại tham chiếu bảng 1. Cặp (利用者番号, 記録日) là khóa ghép hợp lý của bảng 2 nếu mỗi người chỉ có một bản ghi trong ngày; đây là diễn giải cấu trúc, không phải ràng buộc được đề khẳng định.

C, trưởng bộ phận phụ trách an toàn thông tin của kinh doanh, tổng hợp các phương pháp tạo thông tin ẩn danh áp dụng cho từng trường dữ liệu vào bảng 3.

**Bảng 3. Phương pháp xử lý ẩn danh**

| Mục | Tên | Giải thích |
|---|---|---|
| (一) | Xóa trường | Xóa trường thông tin cá nhân khỏi thông tin đầu vào, ví dụ xóa dữ liệu tuổi. |
| (二) | Tổng quát hóa | Thay mô tả bằng khái niệm cấp cao hơn, ví dụ thay “dưa chuột” bằng “rau” trong lịch sử mua hàng. |
| (三) | Top/bottom coding | Gộp các giá trị số đặc biệt lớn hoặc nhỏ; ví dụ gộp “98 tuổi”, “115 tuổi” thành “từ 80 tuổi trở lên”. |
| (四) | Làm tròn | Làm tròn số, chẳng hạn làm tròn thông thường; ví dụ thay tuổi “34” tính từ ngày sinh thành nhóm “tuổi 30”. |

Chú thích của bảng: C lập bảng dựa trên ấn bản thứ 2 phần chế độ của tài liệu “Thông tin xử lý giả danh/thông tin xử lý ẩn danh — hướng tới sử dụng thông tin cá nhân đáng tin cậy” của văn phòng Ủy ban Bảo vệ thông tin cá nhân.

C chuẩn bị phương án tạo thông tin ẩn danh bằng cách áp dụng bảng 3 khi cần cho dữ liệu bảng 1 và 2, rồi báo cáo cho D, trưởng bộ phận pháp chế. D trả lời rằng phương án hữu ích cho mục đích tiếp thị dự kiến và áp dụng phương pháp ẩn danh phù hợp.

**Câu hỏi:** Với từng trường trong ba trường của nhóm đáp án, C đã áp dụng phương pháp nào? Chọn tổ hợp từ các phương pháp trong bảng 3. Mỗi trường có thể áp dụng nhiều phương pháp hoặc không áp dụng phương pháp nào, tức “không xử lý”.

| Lựa chọn | Email | Ngành làm việc | Cân nặng |
|---|---|---|---|
| ア | Không xử lý | Không xử lý | (三) |
| イ | Không xử lý | Không xử lý | (三), (四) |
| ウ | Không xử lý | (一) | (一) |
| エ | Không xử lý | (一) | (三) |
| オ | Không xử lý | (一) | (三), (四) |
| カ | (一) | Không xử lý | (三) |
| キ | (一) | Không xử lý | (三), (四) |
| ク | (一) | (一) | (一) |
| ケ | (一) | (一) | (三) |
| コ | (一) | (一) | (三), (四) |', NULL, 'キ', 'Đáp án chính thức キ: xóa email; giữ ngành làm việc; áp dụng top/bottom coding và làm tròn cho cân nặng. Email có thể nhận diện cá nhân và không cần cho phân tích dự kiến nên xóa trường. Ngành làm việc là biến cần phân tích, nên xóa nó sẽ mất thông tin phục vụ mục đích kinh doanh. Cân nặng cũng phải được giữ để phân tích nhưng cần giảm độ chi tiết và xử lý giá trị cực trị: top/bottom coding gộp ngoại lệ; làm tròn giảm độ chính xác. カ chỉ có gộp cực trị, thiếu làm tròn theo đáp án chính thức. Đề không đưa ngưỡng gộp hay số chữ số làm tròn, nên không tự đặt giá trị đã xử lý. Chỉ xử lý ba trường này chưa phải một chứng minh đầy đủ rằng toàn bộ tập dữ liệu đã đạt mọi yêu cầu ẩn danh; câu hỏi giới hạn ở tổ hợp phương pháp cho ba trường.', '[{"term": "匿名加工情報", "reading": "とくめいかこうじょうほう", "meaning": "thông tin đã xử lý ẩn danh"}, {"term": "第三者提供", "reading": "だいさんしゃていきょう", "meaning": "cung cấp cho bên thứ ba"}, {"term": "項目削除", "reading": "こうもくさくじょ", "meaning": "xóa trường"}, {"term": "一般化", "reading": "いっぱんか", "meaning": "tổng quát hóa"}, {"term": "丸め", "reading": "まるめ", "meaning": "làm tròn"}, {"term": "業種", "reading": "ぎょうしゅ", "meaning": "ngành nghề"}, {"term": "関連付け", "reading": "かんれんづけ", "meaning": "liên kết"}]'::jsonb, 15);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Rủi ro, ứng phó và kỹ thuật bảo mật', 1, '情報セキュリティのリスクマネジメントにおける残留リスクに関する記述のうち，適切なものはどれか。

ア 経営者の意思決定に従って保有したリスクは，残留リスクに含まれない。

イ 特定されていないリスクは，残留リスクに含まれない。

ウ リスク対応を行った後に残るリスクは，残留リスクである。

エ リスクを生じさせる活動を継続しないという決定によって回避したリスクは，残留リスクである。', 'Trong quản lý rủi ro an toàn thông tin, phát biểu nào sau đây về rủi ro còn lại là phù hợp?

ア Rủi ro được giữ lại theo quyết định của ban lãnh đạo không thuộc rủi ro còn lại.

イ Rủi ro chưa được nhận diện không thuộc rủi ro còn lại.

ウ Rủi ro còn tồn tại sau khi thực hiện xử lý rủi ro là rủi ro còn lại.

エ Rủi ro đã được tránh bằng quyết định không tiếp tục hoạt động làm phát sinh rủi ro là rủi ro còn lại.', NULL, 'ウ', 'Rủi ro còn lại là phần rủi ro vẫn tồn tại sau xử lý. Biện pháp kiểm soát thường làm giảm rủi ro chứ không bảo đảm đưa rủi ro về 0. Phần được lãnh đạo chấp nhận giữ lại vẫn có thể là rủi ro còn lại, nên ア sai. Rủi ro còn lại có thể bao gồm rủi ro chưa được nhận diện, nên イ sai. エ mô tả tránh rủi ro bằng cách dừng hoạt động, không phải rủi ro còn tồn tại của hoạt động đó.', '[{"term": "残留リスク", "reading": "ざんりゅうリスク", "meaning": "rủi ro còn lại"}, {"term": "リスク対応", "reading": "リスクたいおう", "meaning": "xử lý rủi ro"}, {"term": "保有", "reading": "ほゆう", "meaning": "giữ lại; chấp nhận giữ"}, {"term": "回避", "reading": "かいひ", "meaning": "tránh"}, {"term": "意思決定", "reading": "いしけってい", "meaning": "ra quyết định"}]'::jsonb, 16);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Rủi ro, ứng phó và kỹ thuật bảo mật', 2, '組織的なインシデント対応体制の構築を支援する目的で JPCERT コーディネーションセンターが作成したものはどれか。

ア CSIRTマテリアル

イ ISMSユーザーズガイド

ウ 証拠保全ガイドライン

エ 組織における内部不正防止ガイドライン', 'JPCERT Coordination Center đã tạo ra tài liệu nào nhằm hỗ trợ xây dựng cơ chế ứng phó sự cố ở cấp tổ chức?

ア CSIRT Material.

イ Hướng dẫn dành cho người sử dụng ISMS.

ウ Hướng dẫn bảo toàn chứng cứ.

エ Hướng dẫn phòng ngừa gian lận nội bộ trong tổ chức.', NULL, 'ア', 'CSIRT マテリアル là bộ tài liệu hỗ trợ xây dựng và vận hành CSIRT, phù hợp trực tiếp với mục đích trong câu hỏi. Điểm phân biệt là “cơ chế ứng phó sự cố của tổ chức”: ISMS là hệ thống quản lý an toàn thông tin; bảo toàn chứng cứ và phòng ngừa gian lận nội bộ là các chủ đề chuyên biệt khác.', '[{"term": "組織的", "reading": "そしきてき", "meaning": "mang tính tổ chức"}, {"term": "対応体制", "reading": "たいおうたいせい", "meaning": "cơ chế ứng phó"}, {"term": "構築", "reading": "こうちく", "meaning": "xây dựng"}, {"term": "証拠保全", "reading": "しょうこほぜん", "meaning": "bảo toàn chứng cứ"}, {"term": "内部不正", "reading": "ないぶふせい", "meaning": "gian lận nội bộ"}]'::jsonb, 17);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Rủi ro, ứng phó và kỹ thuật bảo mật', 3, 'DMZはどれか。

ア インターネットと内部ネットワークとの間に設置されるネットワーク

イ 外部から持ち込んだ PC がマルウェアなどに感染していないかどうかを社内ネットワークに接続する前にチェックするための，社内ネットワークとは隔離された専用のネットワーク

ウ 通信内容を監視し，あらかじめ設定された不正な通信パターンと一致した場合に通信を遮断するネットワーク

エ 不正通信を検知する際に利用するためにセキュリティベンダーから入手するシグネチャ情報', 'DMZ là gì?

ア Mạng được đặt giữa Internet và mạng nội bộ.

イ Mạng chuyên dụng tách biệt với mạng công ty, dùng kiểm tra PC mang từ ngoài vào có bị nhiễm mã độc hay không trước khi kết nối vào mạng công ty.

ウ Mạng giám sát nội dung truyền thông và chặn truyền thông khi nội dung khớp mẫu truyền thông bất hợp pháp đã thiết lập trước.

エ Thông tin chữ ký nhận từ nhà cung cấp bảo mật để sử dụng khi phát hiện truyền thông bất hợp pháp.', NULL, 'ア', 'DMZ là phân đoạn mạng trung gian giữa mạng bên ngoài và mạng nội bộ, thường chứa dịch vụ cần được truy cập từ ngoài. イ là mạng cách ly/kiểm dịch thiết bị. ウ mô tả chức năng phát hiện và ngăn chặn xâm nhập. エ là dữ liệu chữ ký phát hiện, không phải một vùng mạng.', '[{"term": "内部ネットワーク", "reading": "ないぶネットワーク", "meaning": "mạng nội bộ"}, {"term": "隔離", "reading": "かくり", "meaning": "cách ly"}, {"term": "遮断", "reading": "しゃだん", "meaning": "chặn; ngắt"}, {"term": "シグネチャ", "reading": "シグネチャ", "meaning": "chữ ký phát hiện"}, {"term": "持ち込む", "reading": "もちこむ", "meaning": "mang từ ngoài vào"}]'::jsonb, 18);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Rủi ro, ứng phó và kỹ thuật bảo mật', 4, 'チャレンジレスポンス認証方式に該当するものはどれか。

ア 固定パスワードを，TLS による暗号通信を使い，クライアントからサーバに送信して，サーバで検証する。

イ 端末のシリアル番号を，クライアントで秘密鍵を使って暗号化し，サーバに送信して，サーバで検証する。

ウ トークンという機器が自動的に表示する，認証のたびに異なる数字列をパスワードとしてサーバに送信して，サーバで検証する。

エ 利用者が入力したパスワードと，サーバから受け取ったランダムなデータとをクライアントで演算し，その結果をサーバに送信して，サーバで検証する。', 'Phương án nào tương ứng với phương thức xác thực challenge–response?

ア Gửi mật khẩu cố định từ máy khách đến máy chủ bằng truyền thông mã hóa TLS, rồi kiểm tra tại máy chủ.

イ Mã hóa số sê-ri của thiết bị bằng khóa bí mật ở máy khách, gửi đến máy chủ, rồi kiểm tra tại máy chủ.

ウ Gửi chuỗi số do thiết bị gọi là token tự động hiển thị, khác nhau trong mỗi lần xác thực, đến máy chủ dưới dạng mật khẩu, rồi kiểm tra tại máy chủ.

エ Ở máy khách, thực hiện phép tính với mật khẩu do người dùng nhập và dữ liệu ngẫu nhiên nhận từ máy chủ; gửi kết quả đến máy chủ để máy chủ kiểm tra.', NULL, 'エ', 'Máy chủ gửi một challenge ngẫu nhiên; máy khách kết hợp challenge với bí mật để tạo response. エ có đầy đủ hai bước này. ア chỉ bảo vệ đường truyền mật khẩu. イ dùng số sê-ri cố định, không có challenge mới từ máy chủ. ウ mô tả mật khẩu dùng một lần nhưng chưa có thao tác đáp lại challenge từ máy chủ; “mỗi lần khác nhau” tự nó chưa đủ để kết luận là challenge–response.', '[{"term": "認証方式", "reading": "にんしょうほうしき", "meaning": "phương thức xác thực"}, {"term": "乱数／ランダムなデータ", "reading": "らんすう／ランダムなデータ", "meaning": "số/dữ liệu ngẫu nhiên"}, {"term": "演算", "reading": "えんざん", "meaning": "thực hiện phép tính"}, {"term": "秘密鍵", "reading": "ひみつかぎ", "meaning": "khóa bí mật"}, {"term": "検証", "reading": "けんしょう", "meaning": "kiểm tra; xác minh"}]'::jsonb, 19);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Rủi ro, ứng phó và kỹ thuật bảo mật', 5, '情報セキュリティでの脆弱性の検出に用いられるホワイトボックステストに該当するものはどれか。

ア 検査対象のソフトウェア製品に対して，外部仕様を基に，問題を引き起こしそうなデータを大量に送り込み，その応答や挙動を監視することによって脆弱性を検出する。

イ 検査対象のネットワークに対して，ネットワークの構成図や機器名などの情報を得ずに，TCP/IP に係る既知の脆弱性を攻撃し，実際に侵入できるかどうかを確認することによって脆弱性を検出する。

ウ 検査対象のプログラムの内部構造及び内部仕様を基に，脆弱性の可能性がある箇所の処理で使われる入力値を変化させて実行することによって脆弱性を検出する。

エ 検査対象のプログラムの内部仕様を参照せずに，変数領域のあふれを見つけ出すツールを利用して，バッファオーバフローの脆弱性を検出する。', 'Phương án nào là kiểm thử hộp trắng dùng để phát hiện lỗ hổng an toàn thông tin?

ア Dựa vào đặc tả bên ngoài của sản phẩm phần mềm, gửi vào lượng lớn dữ liệu có khả năng gây vấn đề; theo dõi phản hồi và hành vi để phát hiện lỗ hổng.

イ Không thu thập sơ đồ cấu trúc mạng hoặc tên thiết bị của mạng cần kiểm tra; tấn công các lỗ hổng TCP/IP đã biết và xác nhận có thực sự xâm nhập được không.

ウ Dựa vào cấu trúc và đặc tả bên trong của chương trình, thay đổi giá trị đầu vào dùng trong xử lý tại những vị trí có khả năng có lỗ hổng, rồi thực thi để phát hiện lỗ hổng.

エ Không tham khảo đặc tả bên trong chương trình; sử dụng công cụ tìm vùng biến bị tràn để phát hiện lỗ hổng tràn bộ đệm.', NULL, 'ウ', 'Dấu hiệu quyết định của hộp trắng là biết và sử dụng cấu trúc/đặc tả bên trong. ウ nêu rõ điều đó. ア gần với fuzzing từ góc nhìn bên ngoài; イ là kiểm thử xâm nhập không có thông tin nội bộ; エ cũng nói rõ không tham khảo đặc tả bên trong. Việc dùng công cụ hoặc phát hiện tràn bộ đệm không tự biến phép kiểm tra thành hộp trắng.', '[{"term": "脆弱性", "reading": "ぜいじゃくせい", "meaning": "lỗ hổng"}, {"term": "内部構造", "reading": "ないぶこうぞう", "meaning": "cấu trúc bên trong"}, {"term": "外部仕様", "reading": "がいぶしよう", "meaning": "đặc tả bên ngoài"}, {"term": "入力値", "reading": "にゅうりょくち", "meaning": "giá trị đầu vào"}, {"term": "バッファオーバフロー", "reading": "バッファオーバフロー", "meaning": "tràn bộ đệm"}]'::jsonb, 20);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Rủi ro, ứng phó và kỹ thuật bảo mật', 6, 'セキュアOSのアクセス制御と管理者権限管理を説明した適切な組みはどれか。

| 選択肢 | アクセス制御 | 管理者権限管理 |
| --- | --- | --- |
| ア | リソースやプログラムのアクセス権は，OS の管理者が定めたセキュリティポリシーの下で一元的に制御され，リソースやプログラムの所有者が変更できない。 | OS の管理の分野ごとに異なる管理用アカウントを作成し，各アカウントに必要最小限の管理者特権を与える。 |
| イ | リソースやプログラムのアクセス権は，OS の管理者が定めたセキュリティポリシーの下で一元的に制御され，リソースやプログラムの所有者が変更できない。 | OS の管理用に特権アカウントを作成し，特権アカウントに全ての権限を与える。 |
| ウ | リソースやプログラムのアクセス権は，リソースやプログラムの所有者が保持し，制御する。 | OS の管理の分野ごとに異なる管理用アカウントを作成し，各アカウントに必要最小限の管理者特権を与える。 |
| エ | リソースやプログラムのアクセス権は，リソースやプログラムの所有者が保持し，制御する。 | OS の管理用に特権アカウントを作成し，特権アカウントに全ての権限を与える。 |', 'Tổ hợp nào giải thích đúng về kiểm soát truy cập và quản lý quyền quản trị của secure OS?

| Lựa chọn | Kiểm soát truy cập | Quản lý quyền quản trị |
|---|---|---|
| ア | Quyền truy cập tài nguyên và chương trình được kiểm soát tập trung theo chính sách bảo mật do quản trị viên OS đặt ra; chủ sở hữu không thể thay đổi. | Tạo tài khoản quản trị riêng cho từng lĩnh vực quản lý OS, chỉ cấp đặc quyền tối thiểu cần thiết cho mỗi tài khoản. |
| イ | Quyền truy cập tài nguyên và chương trình được kiểm soát tập trung theo chính sách bảo mật do quản trị viên OS đặt ra; chủ sở hữu không thể thay đổi. | Tạo tài khoản đặc quyền để quản lý OS và cấp mọi quyền cho tài khoản đó. |
| ウ | Chủ sở hữu tài nguyên hoặc chương trình giữ và kiểm soát quyền truy cập. | Tạo tài khoản quản trị riêng cho từng lĩnh vực quản lý OS, chỉ cấp đặc quyền tối thiểu cần thiết cho mỗi tài khoản. |
| エ | Chủ sở hữu tài nguyên hoặc chương trình giữ và kiểm soát quyền truy cập. | Tạo tài khoản đặc quyền để quản lý OS và cấp mọi quyền cho tài khoản đó. |', NULL, 'ア', 'Secure OS kết hợp kiểm soát truy cập bắt buộc (MAC) với phân chia đặc quyền quản trị theo nguyên tắc quyền tối thiểu. Vì vậy cần chọn hàng có cả kiểm soát tập trung, chủ sở hữu không được tùy ý sửa, và đặc quyền tối thiểu theo lĩnh vực. イ sai ở việc cấp toàn bộ quyền; ウ sai ở quyền truy cập do chủ sở hữu tự kiểm soát; エ sai cả hai mặt.', '[{"term": "アクセス制御", "reading": "アクセスせいぎょ", "meaning": "kiểm soát truy cập"}, {"term": "管理者権限", "reading": "かんりしゃけんげん", "meaning": "quyền quản trị"}, {"term": "一元的", "reading": "いちげんてき", "meaning": "tập trung; thống nhất"}, {"term": "所有者", "reading": "しょゆうしゃ", "meaning": "chủ sở hữu"}, {"term": "必要最小限", "reading": "ひつようさいしょうげん", "meaning": "mức tối thiểu cần thiết"}]'::jsonb, 21);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Pháp luật, kiểm toán và dịch vụ', 7, '刑法の電子計算機損壊等業務妨害に該当する行為はどれか。

ア 自社のWebサイトで海賊版のソフトウェアを故意に販売した。

イ 存在しない商品をインターネットのオークションサイトに故意に出品し，落札者に現金を振り込ませてだまし取った。

ウ 他人の著作物を著作者に許可なく，引用元の記載もせずに，営業目的の自社のWebサイトに故意に掲載した。

エ プロバイダのサーバに侵入し，サーバに保管されていたある企業が業務に使用しているWebページの内容を故意に消去したり，書き換えたりした。', 'Hành vi nào tương ứng với tội cản trở hoạt động kinh doanh bằng việc làm hư hại máy tính, v.v., trong Bộ luật hình sự?

ア Cố ý bán phần mềm lậu trên website của công ty mình.

イ Cố ý đăng món hàng không tồn tại lên website đấu giá Internet, khiến người trúng đấu giá chuyển tiền và chiếm đoạt tiền bằng lừa đảo.

ウ Cố ý đăng tác phẩm của người khác lên website công ty phục vụ kinh doanh, không xin phép tác giả và không ghi nguồn trích dẫn.

エ Xâm nhập máy chủ của nhà cung cấp dịch vụ rồi cố ý xóa hoặc sửa nội dung trang Web được lưu trên máy chủ mà một doanh nghiệp đang dùng cho hoạt động kinh doanh.', NULL, 'エ', 'エ tác động trực tiếp vào dữ liệu phục vụ nghiệp vụ trên máy chủ, làm cản trở hoạt động sử dụng hệ thống của doanh nghiệp; phù hợp loại hành vi mà đề hỏi. ア và ウ liên quan đến quyền tác giả. イ mô tả hành vi lừa đảo chiếm đoạt tiền. Cần phân biệt đối tượng bị tác động: dữ liệu/hệ thống phục vụ nghiệp vụ, tài sản tiền, hay tác phẩm có bản quyền.', '[{"term": "電子計算機損壊等業務妨害", "reading": "でんしけいさんきそんかいとうぎょうむぼうがい", "meaning": "cản trở nghiệp vụ bằng phá hoại máy tính, v.v."}, {"term": "故意", "reading": "こい", "meaning": "cố ý"}, {"term": "消去", "reading": "しょうきょ", "meaning": "xóa"}, {"term": "海賊版", "reading": "かいぞくばん", "meaning": "bản lậu"}, {"term": "落札者", "reading": "らくさつしゃ", "meaning": "người trúng đấu giá"}]'::jsonb, 22);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Pháp luật, kiểm toán và dịch vụ', 8, 'システム監査におけるフォローアップの説明として，適切なものはどれか。

ア 監査の品質管理体制を，システム監査人が事前に確かめておくこと

イ 監査報告書の指摘事項に基づいて監査対象先が実施した改善措置を，システム監査人が確認すること

ウ システム監査の対象範囲に関する事項を，システム監査人が文書化すること

エ システム監査の目的に応じた適切な形式で作成した監査報告書を，監査の依頼者及び関係者に提出すること', 'Phát biểu nào giải thích đúng về follow-up trong kiểm toán hệ thống?

ア Kiểm toán viên hệ thống xác nhận trước cơ chế quản lý chất lượng kiểm toán.

イ Kiểm toán viên hệ thống xác nhận các biện pháp cải tiến mà đơn vị được kiểm toán đã thực hiện dựa trên những điểm được nêu trong báo cáo kiểm toán.

ウ Kiểm toán viên hệ thống lập văn bản về phạm vi đối tượng của kiểm toán hệ thống.

エ Nộp báo cáo kiểm toán được lập theo hình thức phù hợp với mục đích kiểm toán cho bên yêu cầu kiểm toán và các bên liên quan.', NULL, 'イ', 'Follow-up diễn ra sau khi đã nêu các phát hiện kiểm toán: kiểm tra đơn vị được kiểm toán có thực hiện cải tiến hay chưa và cải tiến có phù hợp không. イ là bước này. ア là kiểm tra chất lượng trước đó; ウ là xác định/lập hồ sơ phạm vi; エ là báo cáo kết quả. Kiểm toán viên xác nhận việc khắc phục, còn đơn vị được kiểm toán thực hiện khắc phục.', '[{"term": "システム監査", "reading": "システムかんさ", "meaning": "kiểm toán hệ thống"}, {"term": "指摘事項", "reading": "してきじこう", "meaning": "điểm được chỉ ra; phát hiện kiểm toán"}, {"term": "改善措置", "reading": "かいぜんそち", "meaning": "biện pháp cải tiến"}, {"term": "監査対象先", "reading": "かんさたいしょうさき", "meaning": "đơn vị được kiểm toán"}, {"term": "文書化", "reading": "ぶんしょか", "meaning": "lập thành văn bản"}]'::jsonb, 23);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Pháp luật, kiểm toán và dịch vụ', 9, 'サービスマネジメントにおける，サービスレベル目標の説明はどれか。

ア 意図した結果を達成するために，知識及び技能を適用する能力

イ 組織が約束する，具体的に測定可能なサービスの特性

ウ トップマネジメントによって正式に表明された組織の意図及び方向付け

エ 明示されているか，通常，暗黙のうちに了解されているか，又は義務として要求されているニーズ又は期待', 'Trong quản lý dịch vụ, đâu là mô tả mục tiêu mức dịch vụ?

ア Năng lực áp dụng kiến thức và kỹ năng để đạt kết quả mong muốn.

イ Đặc tính cụ thể và có thể đo lường của dịch vụ mà tổ chức cam kết.

ウ Ý định và định hướng của tổ chức được lãnh đạo cao nhất chính thức công bố.

エ Nhu cầu hoặc kỳ vọng được nêu rõ, thường được ngầm hiểu, hoặc được yêu cầu như một nghĩa vụ.', NULL, 'イ', 'Mục tiêu mức dịch vụ phải nói được tổ chức cam kết đặc tính dịch vụ nào và đo được ra sao, chẳng hạn tỷ lệ sẵn sàng hoặc thời gian phản hồi. イ phù hợp. ア là năng lực; ウ là chính sách; エ là yêu cầu. Điểm dễ nhầm là “yêu cầu” có thể rộng và định tính, còn mục tiêu mức dịch vụ được xác định cụ thể để đo lường.', '[{"term": "サービスレベル目標", "reading": "サービスレベルもくひょう", "meaning": "mục tiêu mức dịch vụ"}, {"term": "測定可能", "reading": "そくていかのう", "meaning": "có thể đo lường"}, {"term": "特性", "reading": "とくせい", "meaning": "đặc tính"}, {"term": "意図", "reading": "いと", "meaning": "ý định"}, {"term": "暗黙", "reading": "あんもく", "meaning": "ngầm hiểu"}]'::jsonb, 24);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Mạng, dữ liệu và chi phí', 10, '次の IP アドレスとサブネットマスクをもつ PC がある。この PC のネットワークアドレスとして，適切なものはどれか。

IPアドレス： 10.170.70.19サブネットマスク： 255.255.255.240

ア 10.170.70.0 イ 10.170.70.16

ウ 10.170.70.31 エ 10.170.70.255', 'Một PC có địa chỉ IP và subnet mask sau đây. Địa chỉ mạng của PC này là địa chỉ nào?

Địa chỉ IP: 10.170.70.19. Subnet mask: 255.255.255.240.

ア 10.170.70.0　イ 10.170.70.16　ウ 10.170.70.31　エ 10.170.70.255.', NULL, 'イ', 'Mask 255.255.255.240 là /28, mỗi khối có 16 địa chỉ. Octet cuối 19 thuộc khối 16–31 nên địa chỉ mạng là 10.170.70.16. Có thể tính AND: 19 = 00010011; 240 = 11110000; kết quả 00010000 = 16. .31 là địa chỉ broadcast của khối này; .0 là mạng của khối trước; .255 không phải địa chỉ mạng của PC.', '[{"term": "ネットワークアドレス", "reading": "ネットワークアドレス", "meaning": "địa chỉ mạng"}, {"term": "サブネットマスク", "reading": "サブネットマスク", "meaning": "mặt nạ mạng con"}, {"term": "適切", "reading": "てきせつ", "meaning": "phù hợp"}, {"term": "ビット", "reading": "ビット", "meaning": "bit"}]'::jsonb, 25);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Mạng, dữ liệu và chi phí', 11, 'e コマース運営会社がビッグデータを用いて新たなニーズを発掘し，その後のビジネス戦略に生かそうとしている。ビッグデータの収集から活用までのフローを次の図のようにしたとき，データの分析で行うことはどれか。ここで，選択肢ア～エは，フロー図のa～dのいずれかに対応している。

a：ビッグデータの収集 → b：必要なデータの整備 → c：データの分析 → d：ビジネス戦略への活用

ア 機械学習を用いて自然言語処理やクラスタリングを行い，新しい傾向を導き出す。

イ 取扱い製品に関するSNSでの評価などを自動プログラムで取得する。

ウ ノイズリダクション処理やデータクレンジング処理を行う。

エ 発見した新しい傾向を見極めて，注力すべきビジネス戦略を立案する。', 'Một công ty vận hành thương mại điện tử muốn dùng dữ liệu lớn để phát hiện nhu cầu mới và áp dụng vào chiến lược kinh doanh tiếp theo. Khi quy trình từ thu thập đến sử dụng dữ liệu lớn được tổ chức như sơ đồ sau, việc nào được thực hiện ở bước phân tích dữ liệu? Các lựa chọn ア–エ tương ứng với một trong các bước a–d.

| Bước | Thao tác |
|---|---|
| a | Thu thập dữ liệu lớn |
| b | Chuẩn bị dữ liệu cần thiết |
| c | Phân tích dữ liệu |
| d | Sử dụng vào chiến lược kinh doanh |

Thứ tự: a → b → c → d.

ア Dùng học máy để xử lý ngôn ngữ tự nhiên và phân cụm, từ đó rút ra xu hướng mới.

イ Dùng chương trình tự động thu thập đánh giá trên SNS về sản phẩm đang kinh doanh, v.v.

ウ Thực hiện giảm nhiễu và làm sạch dữ liệu.

エ Đánh giá xu hướng mới đã phát hiện để lập chiến lược kinh doanh cần tập trung.', NULL, 'ア', 'Phân tích là biến dữ liệu đã chuẩn bị thành hiểu biết, chẳng hạn xu hướng hoặc nhóm khách hàng. ア là bước c. イ tương ứng a (thu thập), ウ tương ứng b (chuẩn bị), エ tương ứng d (sử dụng kết quả). Tránh nhầm làm sạch dữ liệu với rút ra xu hướng: làm sạch chủ yếu tạo đầu vào phù hợp cho phân tích.', '[{"term": "発掘", "reading": "はっくつ", "meaning": "khám phá; phát hiện"}, {"term": "整備", "reading": "せいび", "meaning": "chuẩn bị; chỉnh lý"}, {"term": "自然言語処理", "reading": "しぜんげんごしょり", "meaning": "xử lý ngôn ngữ tự nhiên"}, {"term": "クラスタリング", "reading": "クラスタリング", "meaning": "phân cụm"}, {"term": "傾向", "reading": "けいこう", "meaning": "xu hướng"}]'::jsonb, 26);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Mạng, dữ liệu và chi phí', 12, '良品である確率が 0.9，不良品である確率が 0.1 の外注部品について，受入検査を行いたい。受入検査には四つの案があり，それぞれの良品と不良品1個に掛かる諸費用は表のとおりである。期待費用が最も低い案はどれか。

単位 円

| 案 | 良品に掛かる費用 | 不良品に掛かる費用 |
| --- | --- | --- |
| A | 0 | 1,500 |
| B | 40 | 1,000 |
| C | 80 | 500 |
| D | 120 | 200 |

ア A イ B ウ C エ D', 'Muốn kiểm tra tiếp nhận linh kiện thuê ngoài có xác suất là hàng tốt 0,9 và hàng lỗi 0,1. Có bốn phương án kiểm tra; chi phí cho một linh kiện tốt và một linh kiện lỗi của mỗi phương án như bảng. Phương án nào có chi phí kỳ vọng thấp nhất?

| Phương án | Chi phí hàng tốt (yên) | Chi phí hàng lỗi (yên) |
|---|---|---|
| A | 0 | 1.500 |
| B | 40 | 1.000 |
| C | 80 | 500 |
| D | 120 | 200 |

ア A　イ B　ウ C　エ D.', NULL, 'ウ', 'Chi phí kỳ vọng = 0,9 × chi phí hàng tốt + 0,1 × chi phí hàng lỗi. A: 150 yên; B: 36 + 100 = 136 yên; C: 72 + 50 = 122 yên; D: 108 + 20 = 128 yên. C nhỏ nhất, nên chọn ウ. Không chỉ so chi phí hàng lỗi: D có chi phí hàng lỗi thấp nhất nhưng tổng kỳ vọng cao hơn C do 90% linh kiện là hàng tốt.', '[{"term": "良品", "reading": "りょうひん", "meaning": "hàng tốt"}, {"term": "不良品", "reading": "ふりょうひん", "meaning": "hàng lỗi"}, {"term": "外注部品", "reading": "がいちゅうぶひん", "meaning": "linh kiện thuê ngoài"}, {"term": "受入検査", "reading": "うけいれけんさ", "meaning": "kiểm tra tiếp nhận"}, {"term": "期待費用", "reading": "きたいひよう", "meaning": "chi phí kỳ vọng"}]'::jsonb, 27);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Tình huống an toàn thông tin', 13, 'A 社は，従業員 300 名の専門商社であり，機密性の高い情報も取り扱っている。最近，A社は，駅前のBビルの6階に移転した。6階にはA社だけが入居している。

B ビルの 2 階から最上階の 17 階には多数の企業が入居しており，通常時はエレベーターを使用して各階に移動することができる。B ビルのビル管理業務は B 社が行っている。B 社はビルの入退館と入居企業の執務エリアの入退室を管理するシステム（以下，C システムという）を導入している。各入居企業は，C システムが発行するICカード（以下，Bカードという）を従業員に貸与している。各入居企業の執務エリアの出入口のドアは，当該企業が従業員に貸与した B カードをドア横の IC カードリーダーにかざすことによって解錠できる。

B ビルのエントランスホールは 1 階にあり，エレベーターホールとの境界には，フラッパーゲートが設置されている。フラッパーゲートを通過するには，フラッパーゲートのリーダーに B カード又は入館用に一時的に発行された QR コードをかざす必要がある。フラッパーゲートを通過すれば，平日の昼間はエレベーターの行先階ボタンを押すことで各階に自由に移動ができる。夜間と休日は，行先階の入居企業が従業員に貸与したBカードをエレベーター内のICカードリーダーにかざす必要がある。

フラッパーゲートのすぐ外には階段室に入るための階段口があり，階段口にある非常ドアは通常時，エントランスホールには出られるが，階段室には入れない仕組みになっている。ほかの階の階段口にある非常ドアは通常時，各フロアには出られないが，階段室には入れる仕組みになっている。ただし，どの階の非常ドアも清掃時などに一時的に出入り可能になることがある。また，非常時は自動的に出入り可能になる。フラッパーゲートの脇にはごみ箱が設置されている。

〔来訪者管理〕B ビルへの来訪者は，C システムで管理している。入居企業が C システムに，来訪者氏名，所属，来訪日，来訪者メールアドレスを登録すると，来訪日にだけ有効なゲスト入館用の QR コード付き入館証（以下，ゲスト入館証という）の画像ファイルが添付された電子メールが来訪者メールアドレスに送付される。来訪者は，来訪日当日に有効なゲスト入館証の QR コードを自身のスマートフォンの画面に表示するか又は印刷してフラッパーゲートのリーダーにかざすことによってフラッパーゲートを通過できる。当日に限り，同じ入館証で繰り返し入退館が可能なようにCシステムは設定

されている。

〔Bビルの物理的セキュリティにおける課題とB社への依頼〕ある日，突然，取引先の D 社のE 氏が予約なしに，A 社の情報セキュリティリーダーのF部長を訪ねて6階の受付エリアにやって来た。驚いたF部長は，E氏が来たことをきっかけにBビルの物理的セキュリティについて調査し，複数の課題があることを発見した。そして，F部長はその課題とB社への依頼を表1にまとめた。

表1 Bビルの物理的セキュリティにおける課題とB社への依頼（抜粋）

| 項番 | 課題 | B社への依頼 |
| --- | --- | --- |
| 1 | フラッパーゲート脇に設置されたごみ箱から印刷された使用済のゲスト入館証を拾えば，1階のフラッパーゲートを通過し入館できてしまう。 | ［a1］ |
| 2 | 6階以外への来訪者が，ゲスト入館証で1階のフラッパーゲートを通過すれば，平日の昼間はエレベーターで6階に移動できてしまう。 | ［a2］ |

設問 次の依頼のうち，表 1 中の ［a1］ ， ［a2］ に入れるものの組合せはどれか。aに関する解答群のうち，最も適切なものを選べ。

(一) C システムの設定を変更し，ゲスト入館証の QR コードの誤り訂正レベルの設定を高くする。

(二) Cシステムの設定を変更し，ゲスト入館証は1回限り入館可能にする。

(三) エレベーターで行先階に移動するためには，平日の昼間も IC カードリーダーにBカードをかざすことを必要とする。そのため，各入居企業には，当該企業の従業員が1階のエレベーター前から当該企業まで来訪者をアテンドするよう要請する。

(四) 警備員を1階のフラッパーゲート脇に配置し，不正に入館しようとしている者がいないかどうかを監視する。

aに関する解答群

| 選択肢 | ［a1］ | ［a2］ |
| --- | --- | --- |
| ア | (一) | (二) |
| イ | (一) | (三) |
| ウ | (二) | (一) |
| エ | (二) | (三) |
| オ | (二) | (四) |
| カ | (三) | (一) |
| キ | (三) | (二) |
| ク | (三) | (四) |
| ケ | (四) | (一) |
| コ | (四) | (二) |', 'A là công ty thương mại chuyên ngành có 300 nhân viên, xử lý cả thông tin có tính bảo mật cao. Gần đây A chuyển đến tầng 6 của tòa nhà B gần ga. Chỉ có công ty A thuê tầng 6.

Từ tầng 2 đến tầng cao nhất là tầng 17 có nhiều doanh nghiệp thuê; bình thường có thể dùng thang máy để di chuyển giữa các tầng. Công ty B quản lý tòa nhà và đã triển khai hệ thống quản lý ra/vào tòa nhà và ra/vào khu vực làm việc của các doanh nghiệp thuê, gọi là hệ thống C. Mỗi doanh nghiệp cho nhân viên mượn thẻ IC do C phát hành, gọi là thẻ B. Cửa ra/vào khu vực làm việc mở khóa khi đưa thẻ B do chính doanh nghiệp đó cấp cho nhân viên đến đầu đọc IC cạnh cửa.

Sảnh chính ở tầng 1; giữa sảnh chính và sảnh thang máy có cổng kiểm soát dạng cánh chắn. Muốn đi qua phải đưa thẻ B hoặc mã QR cấp tạm thời để vào tòa nhà đến đầu đọc. Sau khi qua cổng, ban ngày các ngày làm việc chỉ cần bấm nút tầng đến trên thang máy là có thể tự do đến các tầng. Ban đêm và ngày nghỉ phải đưa thẻ B do doanh nghiệp ở tầng đến cấp cho nhân viên đến đầu đọc IC trong thang máy.

Ngay bên ngoài cổng có lối vào buồng cầu thang. Bình thường cửa thoát hiểm ở lối này cho phép đi từ buồng cầu thang ra sảnh, nhưng không cho đi từ sảnh vào buồng cầu thang. Ở các tầng khác, cửa thoát hiểm bình thường không cho ra tầng đó từ buồng cầu thang, nhưng cho đi từ tầng vào buồng cầu thang. Tuy nhiên, cửa ở bất kỳ tầng nào có thể tạm thời cho đi cả hai chiều khi vệ sinh, v.v.; khi có tình huống khẩn cấp, cửa tự động cho đi cả hai chiều. Có thùng rác bên cạnh cổng kiểm soát.

**Quản lý khách đến thăm**

Khách đến tòa nhà B được quản lý bằng C. Khi doanh nghiệp thuê nhập tên, đơn vị, ngày đến và email của khách vào C, hệ thống gửi email tới địa chỉ khách, đính kèm ảnh giấy vào tòa nhà dành cho khách có mã QR chỉ có hiệu lực trong ngày đến. Khách có thể hiển thị mã QR hợp lệ trong ngày trên điện thoại hoặc in ra, rồi đưa đến đầu đọc để qua cổng. C được thiết lập cho phép dùng cùng giấy vào tòa nhà để ra/vào nhiều lần, nhưng chỉ trong ngày đó.

**Vấn đề an ninh vật lý của tòa nhà B và yêu cầu gửi công ty B**

Một ngày, ông E của đối tác D bất ngờ đến khu tiếp tân tầng 6 để gặp trưởng bộ phận F, người phụ trách an toàn thông tin của A, mà không hẹn trước. F ngạc nhiên, lấy sự việc này làm lý do điều tra an ninh vật lý của tòa nhà; phát hiện nhiều vấn đề và tổng hợp vấn đề cùng yêu cầu gửi B vào bảng 1.

**Bảng 1. Vấn đề và yêu cầu (trích)**

| Mục | Vấn đề | Yêu cầu gửi B |
|---|---|---|
| 1 | Nhặt giấy vào tòa nhà dành cho khách đã dùng và được in ra từ thùng rác cạnh cổng là có thể qua cổng tầng 1 để vào tòa nhà. | ［a1］ |
| 2 | Khách đến tầng khác ngoài tầng 6, sau khi dùng giấy khách để qua cổng tầng 1, có thể dùng thang máy đến tầng 6 vào ban ngày các ngày làm việc. | ［a2］ |

**Câu hỏi:** Chọn tổ hợp yêu cầu điền vào ［a1］, ［a2］ của bảng 1. Chọn phương án phù hợp nhất trong nhóm đáp án a.

(一) Đổi cấu hình C, tăng mức sửa lỗi của mã QR trên giấy khách.

(二) Đổi cấu hình C, chỉ cho phép dùng giấy khách để vào tòa nhà một lần.

(三) Yêu cầu đưa thẻ B đến đầu đọc IC để thang máy đi đến tầng đích ngay cả ban ngày các ngày làm việc. Vì vậy, yêu cầu mỗi doanh nghiệp thuê bố trí nhân viên đón và đi cùng khách từ trước thang máy tầng 1 đến doanh nghiệp mình.

(四) Bố trí bảo vệ cạnh cổng tầng 1 để giám sát có người định vào trái phép hay không.

| Lựa chọn | a1 | a2 |
|---|---|---|
| ア | (一) | (二) |
| イ | (一) | (三) |
| ウ | (二) | (一) |
| エ | (二) | (三) |
| オ | (二) | (四) |
| カ | (三) | (一) |
| キ | (三) | (二) |
| ク | (三) | (四) |
| ケ | (四) | (一) |
| コ | (四) | (二) |', NULL, 'エ', 'a1 = (二), a2 = (三). Giấy đã dùng còn tái sử dụng được là nguyên nhân của vấn đề 1; giới hạn một lần vào loại bỏ việc nhặt giấy đã dùng để vào lại. Vấn đề 2 xảy ra sau khi khách đã vào tòa nhà hợp lệ: cần kiểm soát tầng đến, nên phải yêu cầu thẻ B cả ban ngày và có nhân viên đi cùng khách. Tăng sửa lỗi QR chỉ giúp đọc mã khi bị hỏng, không hạn chế quyền truy cập. Bảo vệ ở cổng không trực tiếp ngăn một khách hợp lệ đi nhầm/đi trái phép đến tầng khác.', '[{"term": "入退館", "reading": "にゅうたいかん", "meaning": "ra/vào tòa nhà"}, {"term": "入退室", "reading": "にゅうたいしつ", "meaning": "ra/vào phòng"}, {"term": "解錠", "reading": "かいじょう", "meaning": "mở khóa"}, {"term": "来訪者", "reading": "らいほうしゃ", "meaning": "khách đến thăm"}, {"term": "行先階", "reading": "ゆきさきかい", "meaning": "tầng đến"}, {"term": "誤り訂正", "reading": "あやまりていせい", "meaning": "sửa lỗi"}, {"term": "アテンド", "reading": "アテンド", "meaning": "đón và đi cùng"}]'::jsonb, 28);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Tình huống an toàn thông tin', 14, 'A 社は従業員 200 名の電子機器メーカーである。東京に本社があり，新潟に工場がある。

A社では，ファイルサーバを図1のように運用している。

・ファイルサーバは本社と工場のサーバルームに設置している。

・ファイルサーバは，磁気テープを使用してファイルのバックアップを取得している。

・土曜日の午前 2 時からフルバックアップを取得し，翌週の火曜日と木曜日の午前 2 時から増分バックアップを取得している。

・情報システム部の担当者は毎週月曜日，火曜日，木曜日の朝 10 時頃，バックアップジョブの実行結果の確認と磁気テープの交換を行い，磁気テープは耐火金庫に保管している。

・磁気テープには上書きモードでバックアップを取得し，1 か月分の磁気テープを世代管理している。

・これまで，フルバックアップからのリストアには平均して 4 時間，1 回の増分バックアップからは平均して0.25時間掛かっている。

・A社はICT継続のための試験を実施しており，ファイルサーバも試験対象である。

注記 事業影響度分析の結果に基づき，ファイルサーバは，72時間の目標復旧時点（RPO）と120時間の目標復旧時間(RTO)が要求事項として定められている。

図1 A社のファイルサーバの運用A 社は ISMS 認証を取得しており，最高情報セキュリティ責任者（CISO）を中心に情報セキュリティに取り組み，定期的に，情報セキュリティリスクアセスメントを行っている。今般，ISMS 認証基準が JIS Q 27001:2023 に改正されたことを受け，情報セキュリティリーダーのBさんは，新基準への移行審査に向けて準備することになった。改正によって新たに追加された情報セキュリティ管理策について，B さんは情報システム部の担当者に取組状況を確認し，その評価結果を表1にまとめた。

表1 Bさんの評価結果（抜粋）

| 項番 | 情報セキュリティ管理策 | 評価結果 |
| --- | --- | --- |
| 1 | （事業継続のための ICT の備え）事業継続の目的及び ICT 継続の要求事項に基づいて，ICT の備えを計画し，実施し，維持し，試験しなければならない。 | 実施している |

B さんは，移行審査前の内部監査で，内部監査室から表1 の項番 1 に関するファイルサーバの運用について何点か質問を受け，表2のとおり回答した。

表2 内部監査室へのBさんの回答（抜粋）

| 項番 | Bさんの回答 |
| --- | --- |
| 1 | 例えば，金曜日の正午に障害が発生した場合，少なくとも ［a1］ の時点のデータは復元しなければならない。 |
| 2 | 例えば，木曜日の正午に障害が発生し，ファイルサーバの全データが消失したとすると，バックアップからのリストアには ［a2］ 時間掛かると予想される。 |
| 3 | ICT継続の計画書は，［a3］が承認している。 |

設問 表 2 中の ［a1］ ～ ［a3］ に入れる字句の適切な組合せを，a に関する解答群の中から選べ。

aに関する解答群

| 選択肢 | ［a1］ | ［a2］ | ［a3］ |
| --- | --- | --- | --- |
| ア | 月曜日の正午 | 4.25 | CISO |
| イ | 月曜日の正午 | 4.25 | 情報システム部の担当者 |
| ウ | 月曜日の正午 | 4.25 | 内部監査室長 |
| エ | 月曜日の正午 | 4.50 | CISO |
| オ | 月曜日の正午 | 4.50 | 情報システム部の担当者 |
| カ | 火曜日の正午 | 4.25 | 情報システム部の担当者 |
| キ | 火曜日の正午 | 4.25 | 内部監査室長 |
| ク | 火曜日の正午 | 4.50 | CISO |
| ケ | 火曜日の正午 | 4.50 | 情報システム部の担当者 |
| コ | 火曜日の正午 | 4.50 | 内部監査室長 |', 'A là nhà sản xuất thiết bị điện tử có 200 nhân viên, trụ sở tại Tokyo và nhà máy tại Niigata. A vận hành máy chủ tệp như hình 1.

**Hình 1. Vận hành máy chủ tệp**

- Máy chủ tệp được đặt trong phòng máy chủ ở trụ sở và nhà máy.
- Sao lưu tệp bằng băng từ.
- Bắt đầu sao lưu đầy đủ lúc 2 giờ sáng thứ Bảy; bắt đầu sao lưu tăng dần lúc 2 giờ sáng thứ Ba và thứ Năm tuần tiếp theo.
- Mỗi tuần, khoảng 10 giờ sáng thứ Hai, thứ Ba và thứ Năm, nhân viên bộ phận hệ thống thông tin kiểm tra kết quả chạy tác vụ sao lưu, thay băng từ và cất băng trong két chống cháy.
- Sao lưu lên băng theo chế độ ghi đè; quản lý các thế hệ băng đủ một tháng.
- Từ trước đến nay, khôi phục từ bản sao lưu đầy đủ mất trung bình 4 giờ; từ một lần sao lưu tăng dần mất trung bình 0,25 giờ.
- A tiến hành kiểm thử để bảo đảm tính liên tục ICT; máy chủ tệp cũng thuộc đối tượng kiểm thử.

Chú thích: Dựa trên kết quả phân tích tác động kinh doanh, máy chủ tệp được yêu cầu RPO = 72 giờ và RTO = 120 giờ.

A đã có chứng nhận ISMS; triển khai an toàn thông tin với CISO làm trung tâm và định kỳ đánh giá rủi ro. Khi tiêu chuẩn chứng nhận ISMS được sửa thành JIS Q 27001:2023, B, người phụ trách an toàn thông tin, chuẩn bị cho đợt đánh giá chuyển đổi. B xác nhận với nhân viên bộ phận hệ thống thông tin tình hình thực hiện những biện pháp kiểm soát an toàn thông tin mới được bổ sung và tổng hợp đánh giá vào bảng 1.

**Bảng 1. Kết quả đánh giá của B (trích)**

| Mục | Biện pháp kiểm soát | Kết quả |
|---|---|---|
| 1 | (Chuẩn bị ICT cho duy trì kinh doanh) Phải lập kế hoạch, thực hiện, duy trì và kiểm thử sự chuẩn bị ICT dựa trên mục đích duy trì kinh doanh và yêu cầu duy trì ICT. | Đang thực hiện |

Trong kiểm toán nội bộ trước đánh giá chuyển đổi, phòng kiểm toán nội bộ hỏi B một số điểm về vận hành máy chủ tệp liên quan mục 1. B trả lời như bảng 2.

**Bảng 2. Câu trả lời của B (trích)**

| Mục | Câu trả lời |
|---|---|
| 1 | Ví dụ, nếu xảy ra sự cố vào trưa thứ Sáu, tối thiểu phải phục hồi được dữ liệu tại thời điểm ［a1］. |
| 2 | Ví dụ, nếu sự cố xảy ra vào trưa thứ Năm và toàn bộ dữ liệu máy chủ tệp bị mất, dự kiến khôi phục từ bản sao lưu mất ［a2］ giờ. |
| 3 | Kế hoạch duy trì ICT được ［a3］ phê duyệt. |

**Câu hỏi:** Chọn tổ hợp từ thích hợp điền vào ［a1］–［a3］ trong bảng 2 từ nhóm đáp án a.

| Lựa chọn | a1 | a2 | a3 |
|---|---|---|---|
| ア | Trưa thứ Hai | 4,25 | CISO |
| イ | Trưa thứ Hai | 4,25 | Nhân viên bộ phận hệ thống thông tin |
| ウ | Trưa thứ Hai | 4,25 | Trưởng phòng kiểm toán nội bộ |
| エ | Trưa thứ Hai | 4,50 | CISO |
| オ | Trưa thứ Hai | 4,50 | Nhân viên bộ phận hệ thống thông tin |
| カ | Trưa thứ Ba | 4,25 | Nhân viên bộ phận hệ thống thông tin |
| キ | Trưa thứ Ba | 4,25 | Trưởng phòng kiểm toán nội bộ |
| ク | Trưa thứ Ba | 4,50 | CISO |
| ケ | Trưa thứ Ba | 4,50 | Nhân viên bộ phận hệ thống thông tin |
| コ | Trưa thứ Ba | 4,50 | Trưởng phòng kiểm toán nội bộ |', NULL, 'ク', 'a1 = trưa thứ Ba; a2 = 4,50 giờ; a3 = CISO. RPO 72 giờ là mức mất dữ liệu tối đa tính ngược từ thời điểm sự cố: trưa thứ Sáu trừ 72 giờ = trưa thứ Ba. Đây là yêu cầu tối thiểu về thời điểm dữ liệu, không phải lịch sao lưu thực tế. Sự cố trưa thứ Năm xảy ra sau bản tăng dần lúc 2 giờ sáng thứ Năm; cần bản đầy đủ thứ Bảy và cả hai bản tăng dần thứ Ba, thứ Năm: 4 + 0,25 + 0,25 = 4,50 giờ. Sao lưu tăng dần chỉ chứa thay đổi từ lần sao lưu trước, nên không thể bỏ bản thứ Ba. Người phê duyệt kế hoạch là CISO trong cơ chế lãnh đạo an toàn thông tin của tình huống. RTO 120 giờ là yêu cầu về thời gian phục hồi, khác với RPO 72 giờ về lượng dữ liệu có thể mất.', '[{"term": "増分バックアップ", "reading": "ぞうぶんバックアップ", "meaning": "sao lưu tăng dần"}, {"term": "磁気テープ", "reading": "じきテープ", "meaning": "băng từ"}, {"term": "耐火金庫", "reading": "たいかきんこ", "meaning": "két chống cháy"}, {"term": "目標復旧時点", "reading": "もくひょうふっきゅうじてん", "meaning": "điểm phục hồi mục tiêu; RPO"}, {"term": "目標復旧時間", "reading": "もくひょうふっきゅうじかん", "meaning": "thời gian phục hồi mục tiêu; RTO"}, {"term": "移行審査", "reading": "いこうしんさ", "meaning": "đánh giá chuyển đổi"}, {"term": "承認", "reading": "しょうにん", "meaning": "phê duyệt"}]'::jsonb, 29);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Tình huống an toàn thông tin', 15, 'A社は従業員300名の商社である。総務部が定めたA社の文書管理ルールを図1に示す。

〔文書の機密区分〕極秘 ：経営に関する重要な文書であり，経営企画に関わる者だけに開示する。経営企画書など。

関係者外秘 ：特定の関係者だけに開示する。議事メモ，顧客情報など。

社外秘 ：社内だけに開示する。クレーム情報，社内報など。

公開 ：社外に公開可能なもの。商品カタログなど。

〔機密区分のラベリング〕

・文書を作成した部署の責任者が，機密区分を判断する。

・“極秘”，“関係者外秘”及び“社外秘”の文書は，機密区分をその文書のヘッダー部に明記する。

・“極秘”と“関係者外秘”に関しては開示範囲を明示するため，“役員だけ 極秘”や“〇〇部だけ 関係者外秘”という形式で明記する。

〔文書の保管〕

・“極秘”及び“関係者外秘”の紙の文書は，使わないときや利用中に離席するときはキャビネットに保管する。キャビネットは常時施錠し，関係者だけが解錠できるようにする。

〔文書の廃棄〕

・“極秘”，“関係者外秘”及び“社外秘”の紙の文書を廃棄する際は，シュレッダーで細断する。

図1 文書管理ルール（抜粋）総務部の情報セキュリティリーダーであるSさんは，各部に対し年次の自己点検を指示した。その結果を基に，図1のルールに沿って文書を取り扱っているかを確認するために，A 社の一部の従業員にヒアリングしたところ，図 2 に示す事例が得られた。

(1) 営業部の B さんの大学の後輩である C さんは，A 社の入社試験を受ける予定なので，BさんはCさんに社内報を見せた。

(2) “営業部だけ 関係者外秘”の議事メモは，営業部員だけが解錠できるキャビネットに保管している。不要となったものは毎週水曜日に，シュレッダーで細断して廃棄している。

(3) 昨年営業部に異動した元人事部の D さんが，営業部の事業計画の参考にするため，人事部のEさんから“人事部だけ 関係者外秘”の来年度の採用計画を見せてもらった。

(4) 経営企画部の G さんは，来期の経営企画書のうち一部の作成を指示されていたが，机の上の本立てに最終原稿を差し込んで会議に向かった。

(5) 人事部の I さんは就職セミナーで，営業部から借りた商品カタログを参加者に見せながら会社紹介をした。

図2 SさんがA社の従業員へのヒアリングによって得た事例Sさんは図2 の事例について，図1に沿っているかどうかを評価し，表1のとおりまとめた。

表1 ヒアリングで得た事例に対する評価

| 図2の項番 | 評価 |
| --- | --- |
| (1) | （省略） |
| (2) | ［a1］ |
| (3) | ［a2］ |
| (4) | ［a3］ |
| (5) | （省略） |

注記 評価は，図1に沿っていれば“〇”，沿っていなければ“×”とする。

設問 表 1 中の ［a1］ ～ ［a3］ に入れる評価の適切な組合せを解答群の中から選べ。

aに関する解答群

| 選択肢 | ［a1］ | ［a2］ | ［a3］ |
| --- | --- | --- | --- |
| ア | 〇 | 〇 | 〇 |
| イ | 〇 | 〇 | × |
| ウ | 〇 | × | 〇 |
| エ | 〇 | × | × |
| オ | × | 〇 | 〇 |
| カ | × | 〇 | × |
| キ | × | × | 〇 |
| ク | × | × | × |', 'A là công ty thương mại có 300 nhân viên. Hình 1 trình bày quy tắc quản lý tài liệu do bộ phận tổng vụ quy định.

**Hình 1. Quy tắc quản lý tài liệu (trích)**

**Phân loại bảo mật tài liệu**

| Loại | Quy định và ví dụ |
|---|---|
| 極秘 (tuyệt mật) | Tài liệu quan trọng liên quan quản trị doanh nghiệp; chỉ cung cấp cho người tham gia hoạch định quản trị. Ví dụ: kế hoạch quản trị. |
| 関係者外秘 (chỉ người liên quan) | Chỉ cung cấp cho những người liên quan cụ thể. Ví dụ: ghi chép cuộc họp, thông tin khách hàng. |
| 社外秘 (nội bộ) | Chỉ cung cấp trong công ty. Ví dụ: thông tin khiếu nại, bản tin nội bộ. |
| 公開 (công khai) | Có thể công bố ngoài công ty. Ví dụ: catalogue sản phẩm. |

**Gắn nhãn phân loại bảo mật**

- Người phụ trách bộ phận tạo tài liệu quyết định loại bảo mật.
- Với tài liệu 極秘, 関係者外秘 và 社外秘, ghi rõ loại bảo mật tại phần đầu trang tài liệu.
- Với 極秘 và 関係者外秘, để chỉ rõ phạm vi cung cấp, dùng dạng “chỉ ban điều hành — tuyệt mật” hoặc “chỉ bộ phận 〇〇 — chỉ người liên quan”.

**Lưu giữ tài liệu**

- Tài liệu giấy loại 極秘 và 関係者外秘 phải được cất trong tủ khi không dùng hoặc khi rời chỗ trong lúc đang sử dụng. Tủ luôn được khóa và chỉ người liên quan có thể mở.

**Hủy tài liệu**

- Khi hủy tài liệu giấy loại 極秘, 関係者外秘 và 社外秘, phải cắt vụn bằng máy hủy giấy.

S, người phụ trách an toàn thông tin của tổng vụ, yêu cầu các bộ phận tự kiểm tra hằng năm. Dựa trên kết quả, S phỏng vấn một số nhân viên để xác nhận tài liệu có được xử lý theo hình 1 không và thu được các trường hợp trong hình 2.

**Hình 2. Các trường hợp thu được qua phỏng vấn**

(1) C là đàn em đại học của B thuộc bộ phận kinh doanh và dự định thi tuyển vào A; B cho C xem bản tin nội bộ.

(2) Ghi chép cuộc họp mang nhãn “chỉ bộ phận kinh doanh — 関係者外秘” được cất trong tủ mà chỉ nhân viên kinh doanh có thể mở. Tài liệu không còn cần dùng được cắt vụn bằng máy hủy giấy và bỏ đi vào mỗi thứ Tư.

(3) D, trước thuộc nhân sự và đã chuyển sang kinh doanh từ năm ngoái, muốn tham khảo cho kế hoạch kinh doanh của bộ phận; E thuộc nhân sự cho D xem kế hoạch tuyển dụng năm tới mang nhãn “chỉ bộ phận nhân sự — 関係者外秘”.

(4) G thuộc bộ phận hoạch định quản trị được yêu cầu soạn một phần kế hoạch quản trị kỳ tới; G đặt bản thảo cuối vào giá sách trên bàn rồi đi họp.

(5) I thuộc nhân sự giới thiệu công ty tại hội thảo việc làm, đồng thời cho người tham dự xem catalogue sản phẩm mượn từ kinh doanh.

S đánh giá các trường hợp trong hình 2 có theo hình 1 không và tổng hợp vào bảng 1.

**Bảng 1. Đánh giá trường hợp phỏng vấn**

| Mục trong hình 2 | Đánh giá |
|---|---|
| (1) | (Lược bỏ trong đề) |
| (2) | ［a1］ |
| (3) | ［a2］ |
| (4) | ［a3］ |
| (5) | (Lược bỏ trong đề) |

Chú thích: Nếu theo hình 1 thì ghi 〇, nếu không thì ghi ×.

**Câu hỏi:** Chọn tổ hợp đánh giá thích hợp điền vào ［a1］–［a3］ trong bảng 1.

| Lựa chọn | a1 | a2 | a3 |
|---|---|---|---|
| ア | 〇 | 〇 | 〇 |
| イ | 〇 | 〇 | × |
| ウ | 〇 | × | 〇 |
| エ | 〇 | × | × |
| オ | × | 〇 | 〇 |
| カ | × | 〇 | × |
| キ | × | × | 〇 |
| ク | × | × | × |', NULL, 'エ', 'a1 = 〇, a2 = ×, a3 = ×. (2) đúng: tủ giới hạn người mở là nhân viên kinh doanh và tài liệu được hủy bằng máy cắt giấy. (3) sai: D hiện thuộc kinh doanh; việc từng thuộc nhân sự không tạo quyền xem tài liệu “chỉ nhân sự”. (4) sai: kế hoạch quản trị thuộc 極秘 và phải cất vào tủ khóa khi rời chỗ; giá sách trên bàn không đáp ứng. Để hiểu toàn bộ quy tắc: (1) cũng không phù hợp vì bản tin nội bộ là 社外秘 và C chưa là nhân viên; (5) phù hợp vì catalogue là 公開. Hai đánh giá này không phải các ô cần điền.', '[{"term": "機密区分", "reading": "きみつくぶん", "meaning": "phân loại bảo mật"}, {"term": "極秘", "reading": "ごくひ", "meaning": "tuyệt mật"}, {"term": "関係者外秘", "reading": "かんけいしゃがいひ", "meaning": "chỉ người liên quan"}, {"term": "社外秘", "reading": "しゃがいひ", "meaning": "không công bố ngoài công ty"}, {"term": "施錠", "reading": "せじょう", "meaning": "khóa"}, {"term": "離席", "reading": "りせき", "meaning": "rời chỗ"}, {"term": "細断", "reading": "さいだん", "meaning": "cắt vụn"}]'::jsonb, 30);
END $$;
