-- Certificates feature: IT Passport — generated from
-- doccument/ITPP/IT_Passport_2026_Giai_thich_va_Tu_vung.md via a one-off parsing script

INSERT INTO certificates (code, category, name_ja, name_vi)
VALUES ('itpp', 'itpp', 'ITパスポート試験', 'Kỳ thi IT Passport')
ON CONFLICT (code) DO NOTHING;

DO $$
DECLARE cert_id INT;
BEGIN
    SELECT id INTO cert_id FROM certificates WHERE code = 'itpp';
    DELETE FROM certificate_vocabulary WHERE certificate_id = cert_id;

    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'BYOD', 'ビー・ワイ・オー・ディー', 'Bring Your Own Device — dùng thiết bị cá nhân trong công việc', '', '', '', 1);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'AI', 'エーアイ', 'Artificial Intelligence — trí tuệ nhân tạo', '', '', '', 2);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'DX', 'ディーエックス', 'Digital Transformation — chuyển đổi số', '', '', '', 3);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'IoT', 'アイ・オー・ティー', 'Internet of Things — Internet vạn vật', '', '', '', 4);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'CSR', 'シー・エス・アール', 'Trách nhiệm xã hội doanh nghiệp', '', '', '', 5);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ASP', 'エー・エス・ピー', 'Nhà cung cấp dịch vụ ứng dụng', '', '', '', 6);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'RFP', 'アール・エフ・ピー', 'Yêu cầu gửi đề xuất', '', '', '', 7);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'RPA', 'アール・ピー・エー', 'Tự động hóa quy trình bằng robot phần mềm', '', '', '', 8);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'SCM', 'エス・シー・エム', 'Quản lý chuỗi cung ứng', '', '', '', 9);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'WBS', 'ダブリュー・ビー・エス', 'Cấu trúc phân rã công việc', '', '', '', 10);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'SLA', 'エス・エル・エー', 'Thỏa thuận mức dịch vụ', '', '', '', 11);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'SLM', 'エス・エル・エム', 'Quản lý mức dịch vụ', '', '', '', 12);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'DBMS', 'ディー・ビー・エム・エス', 'Hệ quản trị cơ sở dữ liệu', '', '', '', 13);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'UX', 'ユー・エックス', 'Trải nghiệm người dùng', '', '', '', 14);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'WPA2', 'ダブリュー・ピー・エー・ツー', 'Cơ chế bảo mật Wi-Fi', '', '', '', 15);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'VRAM', 'ブイ・ラム', 'Bộ nhớ phục vụ hiển thị', '', '', '', 16);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'DNS', 'ディー・エヌ・エス', 'Hệ thống phân giải tên miền', '', '', '', 17);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'SMTP', 'エス・エム・ティー・ピー', 'Giao thức gửi/chuyển email', '', '', '', 18);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'IMAP4', 'アイマップ・フォー', 'Giao thức truy cập hộp thư', '', '', '', 19);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'POP3', 'ポップ・スリー', 'Giao thức nhận email', '', '', '', 20);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'OSS', 'オー・エス・エス', 'Phần mềm nguồn mở', '', '', '', 21);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'LPWA', 'エル・ピー・ダブリュー・エー', 'Truyền thông công suất thấp, vùng phủ rộng', '', '', '', 22);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'BLE', 'ビー・エル・イー', 'Bluetooth Low Energy', '', '', '', 23);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'NAS', 'ナス', 'Thiết bị lưu trữ gắn mạng', '', '', '', 24);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'PKI', 'ピー・ケー・アイ', 'Hạ tầng khóa công khai', '', '', '', 25);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ISMS', 'アイ・エス・エム・エス', 'Hệ thống quản lý an toàn thông tin', '', '', '', 26);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'APT', 'エー・ピー・ティー', 'Tấn công có mục tiêu, kiên trì lâu dài', '', '', '', 27);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'SQL', 'エス・キュー・エル（シークェルとも）', 'Ngôn ngữ truy vấn dữ liệu', '', '', '', 28);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'dpi', 'ディー・ピー・アイ', 'Số điểm trên một inch; độ phân giải', '', '', '', 29);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'bps', 'ビー・ピー・エス', 'Bit trên giây; tốc độ truyền', '', '', '', 30);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ハッカソン', 'はっかそん', 'Hackathon, sự kiện cùng phát triển trong thời gian ngắn', '', '', '', 31);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'バリューエンジニアリング', 'ばりゅーえんじにありんぐ', 'Phân tích giá trị theo chức năng/chi phí', '', '', '', 32);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ブレーンストーミング', 'ぶれーんすとーみんぐ', 'Phát ý tưởng tự do, hoãn phê bình', '', '', '', 33);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'パブリシティ権', 'パブリシティけん', 'Quyền đối với giá trị thương mại của tên/hình ảnh người nổi tiếng', '', '', '', 34);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'キャズム', 'きゃずむ', 'Khoảng cách giữa early adopter và early majority', '', '', '', 35);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'アノテーション', 'あのてーしょん', 'Gán nhãn dữ liệu', '', '', '', 36);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'コンカレントエンジニアリング', 'こんかれんとえんじにありんぐ', 'Phối hợp hoạt động phát triển song song', '', '', '', 37);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'エスクローサービス', 'えすくろーさーびす', 'Dịch vụ bên thứ ba giữ tiền giao dịch', '', '', '', 38);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ウォーターフォール', 'うぉーたーふぉーる', 'Mô hình phát triển tuần tự', '', '', '', 39);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'アジャイル', 'あじゃいる', 'Phát triển lặp, thích ứng thay đổi', '', '', '', 40);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'チェックポイント', 'ちぇっくぽいんと', 'Điểm mốc ghi dữ liệu để hỗ trợ phục hồi', '', '', '', 41);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ウィザード', 'うぃざーど', 'Hướng dẫn thao tác từng bước bằng đối thoại', '', '', '', 42);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'コピーレフト', 'こぴーれふと', 'Điều kiện giữ giấy phép khi phân phối phần mềm phái sinh', '', '', '', 43);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'バックプロパゲーション', 'ばっくぷろぱげーしょん', 'Lan truyền ngược sai số', '', '', '', 44);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'サニタイジング', 'さにたいじんぐ', 'Xử lý đầu vào nguy hiểm thành an toàn', '', '', '', 45);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'プロンプトエンジニアリング', 'ぷろんぷとえんじにありんぐ', 'Thiết kế câu hỏi/chỉ dẫn cho AI', '', '', '', 46);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '最も適切なものはどれか', 'もっともてきせつなものはどれか', 'Chọn phương án phù hợp nhất.', '', '', '', 47);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '適切なものだけを全て挙げたもの', 'てきせつなものだけをすべてあげたもの', 'Chọn tổ hợp gồm tất cả và chỉ những phát biểu đúng.', '', '', '', 48);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', 'a、bに入れる字句', 'エー、ビーにいれるじく', 'Từ/cụm cần điền vào a,b.', '', '', '', 49);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', 'ここで', 'ここで', 'Trong câu này, quy ước rằng…; đọc kỹ điều kiện.', '', '', '', 50);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '以上／以下', 'いじょう／いか', '≥ / ≤; có bao gồm mốc.', '', '', '', 51);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', 'より大きい／より小さい', 'よりおおきい／よりちいさい', '> / <; không bao gồm mốc.', '', '', '', 52);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '未満', 'みまん', '<; không bao gồm mốc.', '', '', '', 53);
END $$;

DO $$
DECLARE cert_id INT;
BEGIN
    SELECT id INTO cert_id FROM certificates WHERE code = 'itpp';
    DELETE FROM certificate_exam_questions WHERE certificate_id = cert_id;

    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 1, '問1 生成AIを用いた生成物の取扱いに関して,既存の著作物の著作権者から許諾を得ることが必要となる可能性のあるものだけを,全て挙げたものはどれか。
a 好みのアーティストの楽曲に似た音楽が得られるように生成AIを用いて楽曲を生成し，その楽曲をインターネット上にアップロードし,無料で公開した。
b 好みのアーティストの楽曲に似た音楽が得られるように生成AIを用いて楽曲を生成し,その楽曲を自分のPC上に保管し,個人で視聴した。
c 生成AIで音楽を生成したところ,偶然好みのアーティストの楽曲に似た音楽が生成できたので,自分のPC上に保管し,個人で視聴した。
ア a
イ a, b
ウ a, b, c
エ b, c', 'Về việc sử dụng sản phẩm được tạo bằng AI tạo sinh, phương án nào liệt kê **tất cả và chỉ những trường hợp có khả năng cần được chủ thể quyền tác giả của tác phẩm có sẵn cho phép**?
- a: Dùng AI tạo sinh để tạo một bài nhạc sao cho giống bài nhạc của nghệ sĩ mình yêu thích, rồi tải bài nhạc đó lên Internet và công khai miễn phí.
- b: Dùng AI tạo sinh để tạo một bài nhạc sao cho giống bài nhạc của nghệ sĩ mình yêu thích, rồi lưu bài nhạc đó trên PC của mình và nghe/xem với mục đích cá nhân.
- c: Khi dùng AI tạo sinh để tạo nhạc, tình cờ tạo được một bài nhạc giống bài nhạc của nghệ sĩ mình yêu thích, nên lưu trên PC của mình và nghe/xem với mục đích cá nhân.
ア a; イ a, b; ウ a, b, c; エ b, c.', NULL, 'ア', 'Chỉ a có khả năng cần xin phép: tạo nhạc giống tác phẩm có sẵn rồi đăng công khai lên Internet. Miễn phí không đồng nghĩa được miễn bản quyền. b và c chỉ lưu, nghe cá nhân trong tình huống đề; điểm phân biệt là sử dụng cá nhân với công bố. Đề hỏi “có khả năng”, không khẳng định mọi nhạc AI giống nhau đều vi phạm.', '[{"term": "生成物", "reading": "せいせいぶつ", "meaning": "sản phẩm được tạo ra"}, {"term": "著作権者", "reading": "ちょさくけんしゃ", "meaning": "chủ thể quyền tác giả"}, {"term": "許諾", "reading": "きょだく", "meaning": "sự cho phép"}]'::jsonb, 1);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 2, '問2 BYODに関する記述として,適切なものはどれか。
ア 企業の業務に,従業員が私物の携帯情報端末を許可を得た上で利用すること
イ 企業の業務の定型的な作業をソフトウェアのロボットで効率化すること
ウ 企業の業務の流れを分析し,継続的に改善,最適化していくこと
エ 企業の業務の流れを見直し,抜本的にデザインし直すこと', '', NULL, 'ア', 'BYOD là Bring Your Own Device: nhân viên dùng thiết bị cá nhân cho công việc sau khi được công ty cho phép. イ là RPA; ウ là BPM (cải tiến liên tục quy trình); エ là BPR (thiết kế lại căn bản quy trình).', '[{"term": "従業員", "reading": "じゅうぎょういん", "meaning": "nhân viên"}, {"term": "私物", "reading": "しぶつ", "meaning": "đồ dùng cá nhân"}, {"term": "携帯情報端末", "reading": "けいたいじょうほうたんまつ", "meaning": "thiết bị thông tin di động"}]'::jsonb, 2);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 3, '問3 投資会社であるA社が,それぞれの投資戦略を採る場合の利益は,表のように予想される。A社がマクシミン戦略を採り,かつ,市況が好転した場合の利益はどれか。マクシミン戦略とは,戦略ごとに予想される利益の最小値が最も大きくなるように戦略を採用する理論である。
| 投資戦略 | 市況が好転 | 市況が悪化 |
|---|---:|---:|
| 投資戦略a | 20 | −15 |
| 投資戦略b | 5 | 0 |
ア −15
イ 0
ウ 5
エ 20', 'Lợi nhuận dự kiến của công ty đầu tư A khi chọn từng chiến lược đầu tư được thể hiện trong bảng. Nếu A áp dụng **chiến lược maximin**, và sau đó tình hình thị trường cải thiện, lợi nhuận là bao nhiêu?
Maximin là lý thuyết chọn chiến lược sao cho **giá trị nhỏ nhất của lợi nhuận dự kiến theo từng chiến lược là lớn nhất**.
| Chiến lược | Thị trường cải thiện | Thị trường xấu đi |
|---|---:|---:|
| a | 20 | −15 |
| b | 5 | 0 |
ア −15; イ 0; ウ 5; エ 20.', NULL, 'ウ', 'Lấy lợi nhuận thấp nhất của từng chiến lược: a = min(20, −15) = −15; b = min(5, 0) = 0. Chọn b vì 0 lớn hơn −15. Sau đó thị trường tốt lên thì lợi nhuận của b là 5, chọn ウ. Bẫy: 0 là mức tối thiểu để chọn chiến lược, chưa phải giá trị đề hỏi.', '[{"term": "投資戦略", "reading": "とうしせんりゃく", "meaning": "chiến lược đầu tư"}, {"term": "市況", "reading": "しきょう", "meaning": "tình hình thị trường"}, {"term": "最小値", "reading": "さいしょうち", "meaning": "giá trị nhỏ nhất"}]'::jsonb, 3);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 4, '問4 特定の目的の達成や課題の解決をテーマとして,ソフトウェアの開発者や企画者などが短期集中的にアイディアを出し合い,ソフトウェアの開発などの共同作業を行い,成果を競い合うイベントはどれか。
ア トレードフェア
イ ハッカソン
ウ パネルディスカッション
エ レセプション', '', NULL, 'イ', 'Hackathon là sự kiện tập trung trong thời gian ngắn để cùng lên ý tưởng, phát triển phần mềm và so tài kết quả. Trade fair là hội chợ thương mại; panel discussion là thảo luận nhóm diễn giả; reception là buổi tiếp đón.', '[{"term": "課題", "reading": "かだい", "meaning": "vấn đề/nhiệm vụ"}, {"term": "共同作業", "reading": "きょうどうさぎょう", "meaning": "công việc hợp tác"}, {"term": "成果", "reading": "せいか", "meaning": "thành quả"}]'::jsonb, 4);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 5, '問5 インターネットを利用した企業広告に関する新たなビジネスモデルを知的財産として出願し,コンピュータシステムとして実現した。このビジネスモデルを知的財産として,保護する法律はどれか。
ア 意匠法
イ 実用新案法
ウ 著作権法
エ 特許法', '', NULL, 'エ', 'Tình huống mô tả một mô hình kinh doanh được thực hiện bằng hệ thống máy tính và đăng ký như tài sản trí tuệ: chọn 特許法. Quyền tác giả bảo hộ cách thể hiện, không bảo hộ ý tưởng kinh doanh tự thân; luật kiểu dáng thiên về thiết kế. Đây là phân loại theo đề, không có nghĩa mọi mô hình kinh doanh đều đủ điều kiện được cấp bằng.', '[{"term": "知的財産", "reading": "ちてきざいさん", "meaning": "tài sản trí tuệ"}, {"term": "出願", "reading": "しゅつがん", "meaning": "nộp đơn đăng ký"}, {"term": "特許法", "reading": "とっきょほう", "meaning": "luật sáng chế"}]'::jsonb, 5);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 6, '問6 デジタルトランスフォーメーションに関する説明として,最も適切なものはどれか。
ア PCやスマートフォンなどのデジタル製品を使いこなせる人と,使いこなせない人の間で様々な機会に差が生じて,社会的な格差につながること
イ 生まれた時からインターネット,PCやスマートフォンなどのデジタル製品が身近にあり,それらを利用しながら育った世代のこと
ウ 音声を収集するマイクロフォンなどからのアナログ信号を,電子ファイルとして保存するためにデジタル信号に変換すること
エ デジタル技術が,人間の生活やビジネスなどのあらゆる面に影響を与え,変革をもたらしていくこと', 'Mô tả nào phù hợp nhất về chuyển đổi số (Digital Transformation)?
- ア: Người sử dụng thành thạo các sản phẩm số như PC và smartphone có những cơ hội khác với người không sử dụng thành thạo, dẫn tới chênh lệch xã hội.
- イ: Thế hệ mà Internet và các sản phẩm số như PC, smartphone đã hiện diện gần gũi từ khi họ sinh ra, và họ lớn lên cùng việc sử dụng những sản phẩm đó.
- ウ: Chuyển tín hiệu analog, chẳng hạn từ microphone thu âm, thành tín hiệu số để lưu dưới dạng tệp điện tử.
- エ: Công nghệ số tác động đến mọi mặt của đời sống con người và hoạt động kinh doanh, mang lại sự biến đổi.', NULL, 'エ', 'DX là công nghệ số tạo ra sự thay đổi trong đời sống và kinh doanh. ア mô tả khoảng cách số; イ là thế hệ digital native; ウ là chuyển tín hiệu analog thành digital. Số hóa dữ liệu chỉ là một hoạt động, DX nói đến biến đổi rộng hơn.', '[{"term": "格差", "reading": "かくさ", "meaning": "chênh lệch"}, {"term": "変換", "reading": "へんかん", "meaning": "chuyển đổi"}, {"term": "変革", "reading": "へんかく", "meaning": "cải cách/biến đổi"}]'::jsonb, 6);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 7, '問7 製品やサービスの価値を機能とコストの関係で把握し,価値の向上をはかる“バリューエンジニアリング”という手法がある。バリューエンジニアリングにおける価値,機能,コストの関係性を示すものとして,適切なものはどれか。
ア 価値=機能/(コスト+機能)
イ 価値=機能/コスト
ウ 価値=機能×コスト
エ 価値=コスト/機能', 'Có một phương pháp gọi là “Value Engineering”, nắm bắt giá trị của sản phẩm/dịch vụ thông qua quan hệ giữa chức năng và chi phí, nhằm nâng cao giá trị. Công thức nào thể hiện đúng quan hệ giữa giá trị, chức năng và chi phí trong phương pháp này?
- ア: Giá trị = Chức năng / (Chi phí + Chức năng).
- イ: Giá trị = Chức năng / Chi phí.
- ウ: Giá trị = Chức năng × Chi phí.
- エ: Giá trị = Chi phí / Chức năng.', NULL, 'イ', 'Giá trị = chức năng / chi phí. Tăng chức năng với chi phí giữ nguyên, hoặc giảm chi phí với chức năng giữ nguyên, đều làm tăng giá trị. Chọn イ.', '[{"term": "価値", "reading": "かち", "meaning": "giá trị"}, {"term": "機能", "reading": "きのう", "meaning": "chức năng"}, {"term": "向上", "reading": "こうじょう", "meaning": "nâng cao"}]'::jsonb, 7);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 8, '問8 IoTを利用したシステムの事例として,最も適切なものはどれか。
ア 資金調達において,不特定多数の借り手と貸し手をインターネット上で仲介するサービスを行う。
イ ソーシャルメディアへの書込みや,コールセンターの通話内容などから,商品やサービスに対する利用者の感情を分析する。
ウ 店舗や工場などの設備に設置したセンサーの情報をインターネット経由で集め,設備の状況について,従業員がスマートフォンを用いて監視する。
エ 文書や画像などの電子ファイルを保存するためのインターネット上のストレージを,サービスとして提供する。', 'Ví dụ nào phù hợp nhất về hệ thống sử dụng IoT?
- ア: Trong huy động vốn, cung cấp dịch vụ trung gian qua Internet giữa nhiều người vay và người cho vay không xác định trước.
- イ: Phân tích cảm xúc của người dùng đối với sản phẩm/dịch vụ từ bài viết trên mạng xã hội, nội dung cuộc gọi tới tổng đài, v.v.
- ウ: Thu thập qua Internet thông tin từ các cảm biến lắp trên thiết bị tại cửa hàng, nhà máy, v.v.; nhân viên dùng smartphone để giám sát tình trạng thiết bị.
- エ: Cung cấp dưới dạng dịch vụ một hệ thống lưu trữ trên Internet để lưu các tệp điện tử như văn bản và hình ảnh.', NULL, 'ウ', 'ウ: cảm biến trên thiết bị cửa hàng/nhà máy gửi dữ liệu qua Internet để nhân viên giám sát bằng smartphone. Có thiết bị vật lý, thu thập dữ liệu và kết nối mạng. Các đáp án còn lại là trung gian tài chính, phân tích cảm xúc và lưu trữ đám mây.', '[{"term": "設備", "reading": "せつび", "meaning": "thiết bị/cơ sở vật chất"}, {"term": "経由", "reading": "けいゆ", "meaning": "thông qua"}, {"term": "監視", "reading": "かんし", "meaning": "giám sát"}]'::jsonb, 8);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 9, '問9 製品の製造に関連して発生する次の費用のうち,間接費だけを全て挙げたものはどれか。
a 完成した製品を検査する労務費
b 工場の電気供給設備を保守する労務費
c 製品の外注加工費
ア a, b
イ b
ウ b, c
エ c', '', NULL, 'イ', 'Chỉ b: nhân công bảo trì hệ thống cấp điện của cả nhà máy là chi phí gián tiếp, khó quy trực tiếp cho một sản phẩm. Trong phân loại của đề, a là nhân công kiểm tra sản phẩm có thể gắn trực tiếp với sản phẩm; c là phí gia công thuê ngoài cho sản phẩm, cũng là chi phí trực tiếp. イ = b. Bẫy: không phải mọi công việc hỗ trợ/kiểm tra đều mặc nhiên là chi phí gián tiếp.', '[{"term": "間接費", "reading": "かんせつひ", "meaning": "chi phí gián tiếp"}, {"term": "労務費", "reading": "ろうむひ", "meaning": "chi phí nhân công"}, {"term": "外注加工費", "reading": "がいちゅうかこうひ", "meaning": "chi phí gia công thuê ngoài"}]'::jsonb, 9);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 10, '問10 会議に関する記述のうち,ブレーンストーミングの進め方として,適切なものだけを全て挙げたものはどれか。
a 自由奔放なアイディアは控え,実現可能なアイディアの提出を求める。
b ほかのメンバーのアイディアに便乗した案であっても,とがめずに進める。
c メンバーから出されるアイディアの中で,テーマに適したものを選択しながら進める。
ア a
イ a, b
ウ a, b, c
エ b', '', NULL, 'エ', 'Chỉ b đúng: được phát triển ý tưởng dựa trên ý tưởng của người khác. Brainstorming khuyến khích tự do, nhiều ý tưởng, kết hợp ý tưởng và hoãn phê bình/đánh giá. a hạn chế ý tưởng tự do; c chọn lọc ngay trong lúc phát ý tưởng, đều không đúng. エ = b.', '[{"term": "自由奔放", "reading": "じゆうほんぽう", "meaning": "tự do phóng khoáng"}, {"term": "便乗", "reading": "びんじょう", "meaning": "dựa theo/tận dụng"}, {"term": "提出", "reading": "ていしゅつ", "meaning": "nộp/đưa ra"}]'::jsonb, 10);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 11, '問11 プロサッカーチームのファンの集いで,人気のある選手が背広姿でサインをしている姿を撮影し,プリントしてフリーマーケットで販売した。この行為によって侵害されるおそれがある選手が有する権利として,最も適切なものはどれか。
ア 意匠権
イ 商標権
ウ 著作権
エ パブリシティ権', 'Tại một buổi gặp gỡ người hâm mộ của đội bóng đá chuyên nghiệp, một cầu thủ nổi tiếng mặc vest đang ký tặng. Một người chụp lại cảnh đó, in ảnh rồi bán tại chợ đồ cũ/chợ tự do. Quyền nào của cầu thủ có khả năng bị hành vi này xâm phạm, phù hợp nhất trong các lựa chọn?
- ア: Quyền đối với kiểu dáng.
- イ: Quyền nhãn hiệu.
- ウ: Quyền tác giả.
- エ: Quyền publicity — quyền đối với giá trị thu hút khách hàng của tên tuổi/hình ảnh cá nhân.', NULL, 'エ', 'Bán ảnh cầu thủ nổi tiếng để khai thác sức hút thương mại có thể xâm phạm パブリシティ権. Ý chính là giá trị thu hút khách hàng của tên tuổi/hình ảnh người nổi tiếng. Không phải quyền sáng chế, nhãn hiệu hay quyền tác giả của cầu thủ đối với ảnh người khác chụp.', '[{"term": "侵害", "reading": "しんがい", "meaning": "xâm phạm"}, {"term": "権利", "reading": "けんり", "meaning": "quyền"}, {"term": "販売", "reading": "はんばい", "meaning": "bán hàng"}]'::jsonb, 11);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 12, '問12 A社は,自社の業務プロセスの課題を抽出し,見直しをするために流れ図を用いて業務プロセスを可視化することにした。A社が流れ図の作成において利用する記述様式として,最も適切なものはどれか。
ア CRUD図
イ DMM(Diamond Mandala Matrix)
ウ E-R図
エ WFA(Work Flow Architecture)', '', NULL, 'エ', 'WFA (Work Flow Architecture) dùng biểu diễn dòng công việc để nhìn rõ quy trình. CRUD mô tả tạo/đọc/sửa/xóa dữ liệu; E-R thể hiện thực thể và quan hệ; DMM là khung tổ chức ý tưởng dạng ma trận mandala.', '[{"term": "流れ図", "reading": "ながれず", "meaning": "lưu đồ"}, {"term": "可視化", "reading": "かしか", "meaning": "trực quan hóa"}, {"term": "記述様式", "reading": "きじゅつようしき", "meaning": "cách thức biểu diễn"}]'::jsonb, 12);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 13, '問13 個人情報保護法に規定された匿名加工情報の説明として,最も適切なものはどれか。
ア 厚生労働省や総務省統計局などが公開している統計情報を自社向けに加工し自社の保有する情報とひも付けて新たな価値をもたせた情報
イ 個人情報のうち氏名を一定の規則に基づいて匿名化するが,元の個人情報への復元を担保した情報
ウ 個人情報を法令に定める方法で匿名化し,復元できないようにしたもので,一定のルールの下で本人の同意なく利活用できる情報
エ 利用者から個人情報を収集する際に,氏名を取得せず個人番号などほかの情報で個人を識別できるようにして収集した情報', 'Mô tả nào phù hợp nhất về “thông tin được xử lý ẩn danh” được quy định trong Luật bảo vệ thông tin cá nhân?
- ア: Thông tin thống kê do các cơ quan như Bộ Y tế, Lao động và Phúc lợi, Cục Thống kê thuộc Bộ Nội vụ và Truyền thông công bố, được xử lý cho doanh nghiệp mình và liên kết với thông tin đang sở hữu để tạo giá trị mới.
- イ: Thông tin cá nhân có họ tên được ẩn danh theo một quy tắc nhất định, nhưng vẫn bảo đảm có thể khôi phục về thông tin cá nhân ban đầu.
- ウ: Thông tin cá nhân được ẩn danh bằng phương pháp luật định, khiến không thể khôi phục, và có thể được khai thác/sử dụng theo những quy tắc nhất định mà không cần sự đồng ý của chính người đó.
- エ: Thông tin được thu thập mà không lấy họ tên, nhưng dùng thông tin khác như mã số cá nhân để vẫn nhận diện được người đó.', NULL, 'ウ', 'ウ: xử lý thông tin cá nhân theo phương pháp luật định để không xác định được cá nhân và không khôi phục được dữ liệu gốc; có thể sử dụng theo những quy tắc nhất định mà không cần sự đồng ý của chính người đó. Chỉ thay tên nhưng vẫn phục hồi được chưa đáp ứng mô tả này.', '[{"term": "匿名加工情報", "reading": "とくめいかこうじょうほう", "meaning": "thông tin được xử lý ẩn danh"}, {"term": "復元", "reading": "ふくげん", "meaning": "khôi phục"}, {"term": "同意", "reading": "どうい", "meaning": "sự đồng ý"}]'::jsonb, 13);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 14, '問14 ISO 26000とは,組織の社会的責任についての国際規格である。ISO 26000で定められている,企業が果たすべき社会的責任を表す用語として,最も適切なものはどれか。
ア CSR
イ SDGs
ウ コーポレートガバナンス
エ ソーシャルメディアポリシー', '', NULL, 'ア', 'CSR = Corporate Social Responsibility, trách nhiệm xã hội của doanh nghiệp. ISO 26000 hướng dẫn trách nhiệm xã hội. SDGs là mục tiêu phát triển bền vững; corporate governance là quản trị doanh nghiệp; social media policy là chính sách sử dụng mạng xã hội.', '[{"term": "社会的責任", "reading": "しゃかいてきせきにん", "meaning": "trách nhiệm xã hội"}, {"term": "国際規格", "reading": "こくさいきかく", "meaning": "tiêu chuẩn quốc tế"}, {"term": "組織", "reading": "そしき", "meaning": "tổ chức"}]'::jsonb, 14);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 15, '問15 マーケティングにおけるイノベーター理論では,新しい製品やサービスが普及していく過程に沿って,消費者を,イノベーター,アーリーアダプター,アーリーマジョリティ,レイトマジョリティ,ラガードという五つのグループに分ける。このとき,アーリーアダプターからアーリーマジョリティへの普及において生じる,越えることが困難な隔たりを表す用語として,最も適切なものはどれか。
ア カニバリゼーション
イ キャズム
ウ 死の谷
エ レッドオーシャン', 'Trong marketing, lý thuyết về người đổi mới chia người tiêu dùng thành năm nhóm theo quá trình phổ biến sản phẩm/dịch vụ mới: người đổi mới (innovator), người sớm chấp nhận (early adopter), đa số sớm (early majority), đa số muộn (late majority) và người chấp nhận sau cùng (laggard).
Thuật ngữ nào phù hợp nhất để chỉ **khoảng cách khó vượt qua xuất hiện khi sản phẩm phổ biến từ nhóm early adopter sang early majority**?
- ア: Cannibalization — hiện tượng các sản phẩm của cùng doanh nghiệp làm giảm doanh số của nhau.
- イ: Chasm — khoảng cách/hố ngăn cách.
- ウ: “Thung lũng chết”.
- エ: Red ocean — đại dương đỏ.', NULL, 'イ', 'キャズム là khoảng cách khó vượt qua giữa nhóm sớm chấp nhận sản phẩm và đa số sớm. Cannibalization là sản phẩm của mình ăn vào doanh số sản phẩm khác; “thung lũng chết” thường gắn với khó khăn thương mại hóa; red ocean là thị trường cạnh tranh gay gắt.', '[{"term": "普及", "reading": "ふきゅう", "meaning": "phổ biến"}, {"term": "消費者", "reading": "しょうひしゃ", "meaning": "người tiêu dùng"}, {"term": "隔たり", "reading": "へだたり", "meaning": "khoảng cách"}]'::jsonb, 15);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 16, '問16 教師あり学習において,正解となる情報を付与する作業を表す用語として,最も適切なものはどれか。
ア アノテーション
イ エンコード
ウ データクレンジング
エ フィルタリング', '', NULL, 'ア', 'Trong học có giám sát, annotation là gán nhãn/đáp án đúng cho dữ liệu huấn luyện. Encoding là mã hóa biểu diễn; data cleansing làm sạch dữ liệu; filtering là lọc dữ liệu.', '[{"term": "教師あり学習", "reading": "きょうしありがくしゅう", "meaning": "học có giám sát"}, {"term": "付与", "reading": "ふよ", "meaning": "gán/cấp"}, {"term": "正解", "reading": "せいかい", "meaning": "đáp án đúng"}]'::jsonb, 16);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 17, '問17 AIを利活用する上で留意すべき事項として,適切なものだけを全て挙げたものはどれか。
a AIの意図しない動作によって,人間の生命や身体などに危害を及ぼす可能性
b AIの判断に差別的な内容が含まれる可能性
c AIの判断にプライバシーの侵害となる内容が含まれる可能性
ア a, b
イ a, b, c
ウ a, c
エ b, c', '', NULL, 'イ', 'Cả a, b, c đều cần lưu ý: AI có thể gây nguy hại đến con người, xâm phạm riêng tư hoặc đưa ra phán đoán phân biệt đối xử. Chọn イ = a, b, c. Không được mặc định kết quả AI luôn an toàn, công bằng.', '[{"term": "留意", "reading": "りゅうい", "meaning": "lưu ý"}, {"term": "危害", "reading": "きがい", "meaning": "tổn hại"}, {"term": "差別的", "reading": "さべつてき", "meaning": "mang tính phân biệt đối xử"}]'::jsonb, 17);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 18, '問18 コンカレントエンジニアリングを採用する目的として,最も適切なものはどれか。
ア 開発期間や納期の短縮
イ 開発製品におけるセキュリティの確保
ウ 開発製品の省エネルギー性能の確保
エ 開発製品への最新技術の活用', '', NULL, 'ア', 'Thực hiện song song, phối hợp các hoạt động thiết kế/phát triển liên quan nhằm rút ngắn thời gian phát triển và thời hạn giao hàng. Mục tiêu trực tiếp trong các lựa chọn là ア; bảo mật, tiết kiệm năng lượng hay dùng công nghệ mới không phải định nghĩa mục đích của phương pháp.', '[{"term": "開発期間", "reading": "かいはつきかん", "meaning": "thời gian phát triển"}, {"term": "納期", "reading": "のうき", "meaning": "hạn giao hàng"}, {"term": "短縮", "reading": "たんしゅく", "meaning": "rút ngắn"}]'::jsonb, 18);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 19, '問19 サーバ上にインストールされたアプリケーションソフトウェアを,インターネット経由で利用者に提供する事業者,又はそのサービス形態として,適切なものはどれか。
ア ASP
イ ISP
ウ アウトソーシング
エ データウェアハウス', '', NULL, 'ア', 'ASP (Application Service Provider) cung cấp ứng dụng được cài trên máy chủ cho người dùng qua Internet. ISP cung cấp kết nối Internet; data warehouse là kho dữ liệu phân tích; outsourcing là khái niệm thuê ngoài rộng hơn.', '[{"term": "事業者", "reading": "じぎょうしゃ", "meaning": "đơn vị kinh doanh"}, {"term": "提供", "reading": "ていきょう", "meaning": "cung cấp"}, {"term": "利用者", "reading": "りようしゃ", "meaning": "người sử dụng"}]'::jsonb, 19);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 20, '問20 システム開発におけるRFPの説明として,適切なものはどれか。
ア ITベンダーが,情報システム開発の必要性をユーザーに提案するために作成した提案文書
イ 発注者側が,開発すべき情報システムの調達条件などをITベンダーに示すために作成した文書
ウ 発注者と受注したITベンダーが,開発するシステムの仕様を明確にするために共同で作成した設計文書
エ ユーザー部門が,情報システム部門に情報システム開発の必要性と開発要件を明確にするように求めた文書', '', NULL, 'イ', 'RFP (Request for Proposal) do bên đặt hàng lập để thông báo yêu cầu và điều kiện mua sắm hệ thống cho nhà cung cấp, yêu cầu họ gửi đề xuất. Vì vậy chọn イ. Không phải đề xuất tự phát của vendor hay tài liệu thiết kế cùng lập sau khi ký hợp đồng.', '[{"term": "発注者", "reading": "はっちゅうしゃ", "meaning": "bên đặt hàng"}, {"term": "調達条件", "reading": "ちょうたつじょうけん", "meaning": "điều kiện mua sắm"}, {"term": "提案", "reading": "ていあん", "meaning": "đề xuất"}]'::jsonb, 20);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 21, '問21 サイバーセキュリティ基本法の立法趣旨を説明したものはどれか。
ア コンピュータへの不正アクセス行為を定義し,その行為を禁止するとともに罰則を定め,ネットワーク通信秩序の維持を図ること
イ 情報セキュリティに関する適切なコントロールを整備,運用するための実践的な規範を定め,企業などで効果的な情報セキュリティ対策の推進を促すこと
ウ 情報通信ネットワークを通じたコンピュータへの不正侵入などの行為に対する防御施策に関し,基本理念を定め,国及び地方公共団体の責務などを明らかにして,施策の総合的かつ効果的な推進を図ること
エ デジタルコンテンツの複製防止のための技術的制限手段を無効化する行為などを規制することによって,企業などの営業上の利益を確保すること', 'Mô tả nào thể hiện mục đích lập pháp của Luật cơ bản về an ninh mạng?
- ア: Định nghĩa hành vi truy cập trái phép vào máy tính, cấm hành vi đó và quy định hình phạt, nhằm duy trì trật tự truyền thông trên mạng.
- イ: Quy định các chuẩn mực thực hành để xây dựng và vận hành những biện pháp kiểm soát an toàn thông tin phù hợp, thúc đẩy đối sách an toàn thông tin hiệu quả tại doanh nghiệp và các tổ chức khác.
- ウ: Về các biện pháp phòng vệ trước hành vi như xâm nhập trái phép vào máy tính qua mạng thông tin truyền thông, quy định nguyên tắc cơ bản, làm rõ trách nhiệm của nhà nước và chính quyền địa phương, v.v., nhằm thúc đẩy các biện pháp một cách tổng thể và hiệu quả.
- エ: Bảo đảm lợi ích kinh doanh của doanh nghiệp, v.v. bằng việc điều chỉnh các hành vi như vô hiệu hóa biện pháp hạn chế kỹ thuật dùng để ngăn sao chép nội dung số.', NULL, 'ウ', 'ウ mô tả nguyên tắc cơ bản, trách nhiệm của chính phủ và chính quyền địa phương, thúc đẩy tổng thể và hiệu quả các biện pháp an ninh mạng. ア là hướng mô tả luật cấm truy cập trái phép; イ là quy phạm thực hành kiểm soát an toàn thông tin; エ liên quan chống hành vi vô hiệu hóa biện pháp bảo vệ nội dung số.', '[{"term": "立法趣旨", "reading": "りっぽうしゅし", "meaning": "mục đích lập pháp"}, {"term": "責務", "reading": "せきむ", "meaning": "trách nhiệm phải thực hiện"}, {"term": "施策", "reading": "しさく", "meaning": "biện pháp/chính sách"}]'::jsonb, 21);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 22, '問22 伝票入力処理などの定型的な事務作業を,ソフトウェアロボットに代替させることによって,自動化や効率化を図る手段として,最も適切なものはどれか。
ア BPO
イ EUC
ウ FA
エ RPA', '', NULL, 'エ', 'RPA tự động hóa thao tác văn phòng có tính lặp lại bằng robot phần mềm, ví dụ nhập chứng từ. BPO là thuê ngoài quy trình; EUC là người dùng tự xử lý/phát triển công cụ; FA là tự động hóa nhà máy.', '[{"term": "伝票", "reading": "でんぴょう", "meaning": "chứng từ"}, {"term": "定型的", "reading": "ていけいてき", "meaning": "theo khuôn mẫu"}, {"term": "代替", "reading": "だいたい", "meaning": "thay thế"}]'::jsonb, 22);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 23, '問23 インターネット広告の手法の一つである,リスティング広告に関する記述として,最も適切なものはどれか。
ア Webサイトの閲覧履歴やオンラインショッピングの購買履歴などの利用者の行動履歴を基にして,広告を表示する。
イ 検索エンジンの利用者が検索ボックスに入力したキーワードに連動して,広告を表示する。
ウ 事前に広告メールの受信を許諾した利用者に対して,広告メールを配信する。
エ 定期的に発行するメールマガジンに,広告を掲載して配信する。', '', NULL, 'イ', 'イ: hiển thị quảng cáo theo từ khóa người dùng nhập vào công cụ tìm kiếm. ア dựa trên lịch sử hành vi; ウ là email đã được cho phép; エ là quảng cáo trong bản tin email. Nhớ “từ khóa tìm kiếm → listing ads” trong đề này.', '[{"term": "閲覧履歴", "reading": "えつらんりれき", "meaning": "lịch sử xem"}, {"term": "購買履歴", "reading": "こうばいりれき", "meaning": "lịch sử mua"}, {"term": "連動", "reading": "れんどう", "meaning": "hoạt động gắn với nhau"}]'::jsonb, 23);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 24, '問24 コーポレートガバナンスの説明として,適切なものはどれか。
ア 株主を始めとした利害関係者による経営者への監視や監督を中心とした,企業活動を律する枠組みのこと
イ 企業が活動を行う上で必要な資本の調達のこと
ウ 企業の理念や特性を,統一されたイメージやデザインなどで発信し,企業のブランド価値の向上を図ること
エ 競合他社では提供が不可能な価値をもたらす,企業が有する独自のスキルや技術のこと', '', NULL, 'ア', 'ア: khuôn khổ giám sát và kiểm soát người điều hành bởi cổ đông và các bên liên quan. イ là huy động vốn; ウ là nhận diện doanh nghiệp; エ là năng lực cốt lõi.', '[{"term": "株主", "reading": "かぶぬし", "meaning": "cổ đông"}, {"term": "利害関係者", "reading": "りがいかんけいしゃ", "meaning": "bên có quyền lợi liên quan"}, {"term": "監督", "reading": "かんとく", "meaning": "giám sát/chỉ đạo"}]'::jsonb, 24);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 25, '問25 大容量,頻繁な更新,多種多様という三つの要素をもつ情報資産を“ビッグデータ”と定義する考え方がある。このビッグデータを特徴づける三つの要素を総称して何というか。
ア 3C
イ 3D
ウ 3G
エ 3V', '', NULL, 'エ', '3V = Volume (khối lượng), Velocity (tốc độ phát sinh/cập nhật), Variety (đa dạng). Ba mô tả trong đề tương ứng ba V, chọn エ. Không nhầm 3C của phân tích marketing với 3V của big data.', '[{"term": "大容量", "reading": "だいようりょう", "meaning": "dung lượng lớn"}, {"term": "頻繁", "reading": "ひんぱん", "meaning": "thường xuyên"}, {"term": "多種多様", "reading": "たしゅたよう", "meaning": "nhiều loại đa dạng"}]'::jsonb, 25);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 26, '問26 表はA社の貸借対照表である。A社の自己資本比率は何%か。
単位：百万円
| 資産の部 | 金額 | 負債・純資産の部 | 金額 |
|---|---:|---|---:|
| 流動資産 | 730 | 流動負債 | 200 |
| | | 固定負債 | 500 |
| | | **純資産の部** | |
| 固定資産 | 270 | 資本金 | 300 |
ア 30
イ 54
ウ 70
エ 90', '', NULL, 'ア', 'Tổng tài sản = 730 + 270 = 1.000 triệu yen. Vốn chủ sở hữu trong bảng = 300. Tỷ lệ = 300 / 1.000 × 100 = 30%, chọn ア. 700 là nợ phải trả, không phải vốn chủ.', '[{"term": "貸借対照表", "reading": "たいしゃくたいしょうひょう", "meaning": "bảng cân đối kế toán"}, {"term": "自己資本比率", "reading": "じこしほんひりつ", "meaning": "tỷ lệ vốn chủ sở hữu"}, {"term": "負債", "reading": "ふさい", "meaning": "nợ phải trả"}]'::jsonb, 26);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 27, '問27 AIを,様々な課題に対して判断できる“強いAI”と,特定の課題だけを判断できる“弱いAI”に分類した場合,“弱いAI”の記述として,最も適切なものはどれか。
ア 人間と同等の知能がコンピュータ上で再現され,人間のように判断することができるが,人間と同じような判断ミスをすることもある。
イ 人間のように質問そのものの意味を理解したり,考えたりしているわけではないが,判断の結果を示すことはできる。
ウ 人間よりも賢く,人間の手助けがなくても自らの判断力を高めることができる。
エ 自らがもつ知識や能力を自律的に適用することによって,柔軟に判断できる能力がある。', 'Giả sử phân loại AI thành “AI mạnh”, có thể phán đoán đối với nhiều loại vấn đề khác nhau, và “AI yếu”, chỉ có thể phán đoán đối với những vấn đề cụ thể. Mô tả nào phù hợp nhất về AI yếu?
- ア: Trí tuệ ngang con người được tái hiện trên máy tính; AI có thể phán đoán như con người, nhưng đôi khi cũng mắc lỗi phán đoán tương tự con người.
- イ: AI không hiểu ý nghĩa của chính câu hỏi hoặc suy nghĩ như con người, nhưng có thể đưa ra kết quả phán đoán.
- ウ: AI thông minh hơn con người và có thể tự nâng cao năng lực phán đoán mà không cần con người giúp đỡ.
- エ: AI có khả năng phán đoán linh hoạt bằng cách tự chủ áp dụng kiến thức và năng lực của mình.', NULL, 'イ', 'イ: AI chuyên biệt có thể đưa ra kết quả đánh giá nhưng không hiểu ý nghĩa/cân nhắc như con người theo cách phân loại của đề. Các lựa chọn còn lại gán khả năng tổng quát, tự chủ hoặc vượt con người cho AI.', '[{"term": "判断", "reading": "はんだん", "meaning": "phán đoán"}, {"term": "自律的", "reading": "じりつてき", "meaning": "một cách tự chủ"}, {"term": "知能", "reading": "ちのう", "meaning": "trí tuệ"}]'::jsonb, 27);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 28, '問28 インターネット上の商取引に関連したリスクのうち,エスクローサービスを利用することによって低減できるリスクとして,適切なものはどれか。
ア オークションサイトに誤った購入金額を入力したときに,取引を取り消せない。
イ 商品の代金を支払ったにもかかわらず,商品が配送されない。
ウ ショッピングサイトで使用しているパスワードが漏えいする。
エ 発注した商品を一旦受け取ると,自己都合では解約できない。', '', NULL, 'イ', 'Escrow là bên thứ ba giữ tiền và chuyển cho người bán theo điều kiện giao dịch, giúp giảm rủi ro đã trả tiền nhưng không được giao hàng (イ). Nó không trực tiếp ngăn nhập nhầm giá, lộ mật khẩu hay đảm bảo được hủy vì lý do cá nhân.', '[{"term": "商取引", "reading": "しょうとりひき", "meaning": "giao dịch thương mại"}, {"term": "代金", "reading": "だいきん", "meaning": "tiền thanh toán"}, {"term": "配送", "reading": "はいそう", "meaning": "giao hàng"}]'::jsonb, 28);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 29, '問29 プログラム開発業務の委託に当たり,請負契約における注文者及び請負業者の権利や義務について特段の取決めがない場合の説明として,適切なものはどれか。
ア 請負業者が,更に別の業者に仕事の一部を請け負わせる場合は,事前に注文者の承諾を得なければならない。
イ 完成したプログラムに欠陥があるときは,注文者はいつでも欠陥の改修を請求することができる。
ウ 注文者には,プログラムの引渡しを受けた時点で,報酬を支払う義務が生じる。
エ 注文者は,プログラムの完成前であればいつでも請負業者に対して損害を賠償することなく請負契約を解除することができる。', 'Khi thuê ngoài công việc phát triển chương trình, nếu không có thỏa thuận riêng về quyền và nghĩa vụ của bên đặt hàng và bên nhận khoán trong hợp đồng khoán việc, mô tả nào là phù hợp?
- ア: Nếu bên nhận khoán tiếp tục giao một phần công việc cho nhà thầu khác, phải được bên đặt hàng đồng ý trước.
- イ: Khi chương trình hoàn thành có lỗi, bên đặt hàng có thể yêu cầu sửa lỗi bất cứ lúc nào.
- ウ: Nghĩa vụ thanh toán thù lao của bên đặt hàng phát sinh tại thời điểm nhận bàn giao chương trình.
- エ: Trước khi chương trình hoàn thành, bên đặt hàng có thể hủy hợp đồng khoán việc bất cứ lúc nào mà không phải bồi thường thiệt hại cho bên nhận khoán.', NULL, 'ウ', 'ウ: trong điều kiện đề không có thỏa thuận riêng, bên đặt hàng phải trả thù lao khi nhận bàn giao chương trình. ア khẳng định luôn phải xin phép trước khi thuê lại là quá tuyệt đối; イ “bất cứ lúc nào” đòi sửa là sai; エ hủy trước hoàn thành mà không bồi thường là sai theo tình huống đề.', '[{"term": "請負契約", "reading": "うけおいけいやく", "meaning": "hợp đồng khoán việc"}, {"term": "引渡し", "reading": "ひきわたし", "meaning": "bàn giao"}, {"term": "報酬", "reading": "ほうしゅう", "meaning": "thù lao"}]'::jsonb, 29);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 30, '問30 事業部制組織の事例はどれか。
ア AさんはX事業を実施している部門の購買組織に所属している。Y事業の購買はY事業を実施している部門の購買組織が担当している。
イ Bさんは複数の事業の人事機能を担当する組織に所属している。開発,生産,販売機能も同様に,それぞれ専門の組織が担当している。
ウ Cさんは地域Mで製品Xの販売を担当しており,地域Mの販売に責任をもつ上司と製品Xの販売に責任をもつ上司の,2人の上司の指示を受けている。
エ Dさんは新規事業の企画開発を目的として関係部署から横断的に人材を集めた組織に所属している。この組織は企画開発が終わり次第解散する。', 'Trường hợp nào là ví dụ về cơ cấu tổ chức theo đơn vị kinh doanh?
- ア: A thuộc tổ chức mua hàng của bộ phận thực hiện hoạt động kinh doanh X. Việc mua hàng của hoạt động kinh doanh Y do tổ chức mua hàng của bộ phận kinh doanh Y phụ trách.
- イ: B thuộc một tổ chức phụ trách chức năng nhân sự của nhiều hoạt động kinh doanh. Các chức năng phát triển, sản xuất và bán hàng cũng do từng tổ chức chuyên môn phụ trách tương tự.
- ウ: C phụ trách bán sản phẩm X tại khu vực M, và nhận chỉ thị từ hai cấp trên: người chịu trách nhiệm bán hàng của khu vực M và người chịu trách nhiệm bán sản phẩm X.
- エ: D thuộc tổ chức tập hợp nhân lực từ nhiều phòng ban để lập kế hoạch/phát triển một hoạt động kinh doanh mới. Tổ chức này giải thể ngay khi công việc lập kế hoạch/phát triển kết thúc.', NULL, 'ア', 'ア: bộ phận kinh doanh X có tổ chức mua hàng riêng; kinh doanh Y cũng có tổ chức mua riêng. Đây là phân chia theo đơn vị kinh doanh. イ là cơ cấu chức năng; ウ có hai cấp quản lý theo vùng và sản phẩm, là ma trận; エ là tổ chức dự án tạm thời.', '[{"term": "事業部制組織", "reading": "じぎょうぶせいそしき", "meaning": "cơ cấu theo đơn vị kinh doanh"}, {"term": "購買", "reading": "こうばい", "meaning": "mua hàng"}, {"term": "所属", "reading": "しょぞく", "meaning": "trực thuộc"}]'::jsonb, 30);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 31, '問31 リーン生産方式による業務改善の観点であるムリ,ムラ,ムダのうち,ムダに当たるものとして,最も適切なものはどれか。
ア 属人化していて,担当者によって作成物の品質が異なる作業
イ 組織の能力以上に負荷をかける無謀な計画や作業標準
ウ 待機や必要以上の加工など,付加価値を生まない動作
エ 長時間,身体の一部に負担がかかり,健康を害するおそれのある作業', '', NULL, 'ウ', 'ウ: chờ đợi và gia công quá mức không tạo giá trị gia tăng là ムダ (lãng phí). ムリ là quá tải/vượt khả năng; ムラ là không đồng đều, ví dụ chất lượng khác nhau tùy người làm.', '[{"term": "付加価値", "reading": "ふかかち", "meaning": "giá trị gia tăng"}, {"term": "待機", "reading": "たいき", "meaning": "chờ đợi"}, {"term": "属人化", "reading": "ぞくじんか", "meaning": "phụ thuộc vào một cá nhân"}]'::jsonb, 31);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 32, '問32 ニッチ戦略の事例として,最も適切なものはどれか。
ア アパレルメーカーA社は,生産コストを下げるために,生産拠点を海外に移した。また,大量に販売が見込めるカジュアルウェアを中心に,安価な商品を全国で販売することにした。
イ 業界2位の食品メーカーB社は,トップシェアを獲得するために,業界3位のC社と経営統合することにした。
ウ 金属加工メーカーD社は,自社固有の加工技術を生かして,密閉度の極めて高い高価な無水調理鍋を高級レストラン向けに販売することにした。
エ 電機メーカーE社は,販売量が減ってきた中型テレビ事業を売却し,完全撤退することにした。', 'Trường hợp nào phù hợp nhất với chiến lược thị trường ngách (niche)?
- ア: Công ty may mặc A chuyển cơ sở sản xuất ra nước ngoài để giảm chi phí. Đồng thời, công ty quyết định bán trên toàn quốc các sản phẩm giá rẻ, chủ yếu là quần áo thường ngày có khả năng bán với số lượng lớn.
- イ: Công ty thực phẩm B đứng thứ hai trong ngành quyết định hợp nhất với công ty C đứng thứ ba để giành thị phần lớn nhất.
- ウ: Công ty gia công kim loại D tận dụng kỹ thuật gia công riêng có, quyết định bán nồi nấu không cần nước giá cao, có độ kín rất cao, cho các nhà hàng cao cấp.
- エ: Công ty điện tử E quyết định bán mảng TV cỡ trung đang giảm lượng tiêu thụ và rút hoàn toàn khỏi mảng kinh doanh đó.', NULL, 'ウ', 'ウ: tận dụng kỹ thuật riêng để bán nồi chuyên dụng giá cao cho nhà hàng cao cấp, nhắm phân khúc hẹp với nhu cầu đặc thù. ア là cạnh tranh chi phí thấp đại trà; イ là hợp nhất để giành thị phần; エ là rút khỏi ngành.', '[{"term": "固有", "reading": "こゆう", "meaning": "riêng có"}, {"term": "密閉度", "reading": "みっぺいど", "meaning": "độ kín"}, {"term": "撤退", "reading": "てったい", "meaning": "rút lui"}]'::jsonb, 32);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 33, '問33 購買,製造,販売という供給者から消費者までを結ぶ一連の業務のつながりを総合的に管理し,資材の調達から顧客への販売に至る在庫などの無駄をなくして,プロセス全体の最適化を図るものはどれか。
ア CRM
イ POS
ウ SCM
エ SFA', '', NULL, 'ウ', 'SCM quản lý tổng thể chuỗi cung ứng từ mua nguyên liệu, sản xuất đến bán cho khách, giảm tồn kho/lãng phí và tối ưu toàn chuỗi. CRM quản lý khách hàng; POS ghi nhận bán hàng; SFA hỗ trợ/tự động hóa hoạt động bán hàng.', '[{"term": "供給者", "reading": "きょうきゅうしゃ", "meaning": "nhà cung cấp"}, {"term": "在庫", "reading": "ざいこ", "meaning": "hàng tồn kho"}, {"term": "最適化", "reading": "さいてきか", "meaning": "tối ưu hóa"}]'::jsonb, 33);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 34, '問34 IT基本計画の策定の際,明確にすべき事項だけを全て挙げたものはどれか。
a ITシステムの利活用に関わるステークホルダ
b 組織体の現在及び将来的なニーズへの対応
c 発生したインシデントに関する管理手順
d 利用者及び関係者との合意に基づいた業務要件とその優先順位
ア a, b
イ a, b, c
ウ a, b, d
エ b, c, d', '', NULL, 'ア', 'a và b: ở bước lập kế hoạch IT cơ bản cần xác định stakeholder và đáp ứng nhu cầu hiện tại/tương lai của tổ chức. c là quy trình quản lý incident trong vận hành; d là yêu cầu nghiệp vụ và ưu tiên đã thống nhất ở mức xác định yêu cầu cụ thể, không phải nội dung của bước IT基本計画 đang hỏi. ア = a,b. Cần đọc đúng cấp độ của kế hoạch, không gom mọi nội dung hữu ích vào cùng một bước.', '[{"term": "策定", "reading": "さくてい", "meaning": "xây dựng/ban hành kế hoạch"}, {"term": "業務要件", "reading": "ぎょうむようけん", "meaning": "yêu cầu nghiệp vụ"}, {"term": "優先順位", "reading": "ゆうせんじゅんい", "meaning": "thứ tự ưu tiên"}]'::jsonb, 34);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 35, '問35 情報システムの企画,開発,運用,保守に関わるマネジメントとプロセスに対して,ITガバナンスにおける経営陣の活動として,評価,指示,モニターを実施する必要がある。ITガバナンスにおける経営陣の活動に関する記述として,適切なものだけを全て挙げたものはどれか。
a 外部のコンサルタントに責任と権限を委譲し,戦略立案からモニタリングまで全面的に任せる。
b 情報システム戦略で想定した効果が,どの程度達成されているか確認するための情報を収集する。
c 情報システム戦略を実現するために,必要な責任と要員を組織に割り当てる。
d 情報システムの複数の将来像を想定し,外部の情報システムの専門家に比較分析を依頼して評価する。
ア a, b, c
イ a, c
ウ b, c
エ b, c, d', 'Đối với hoạt động quản lý và các quy trình liên quan đến lập kế hoạch, phát triển, vận hành và bảo trì hệ thống thông tin, ban lãnh đạo cần thực hiện đánh giá, chỉ đạo và theo dõi trong khuôn khổ IT governance. Phương án nào liệt kê tất cả và chỉ các phát biểu phù hợp về hoạt động của ban lãnh đạo?
- a: Chuyển giao trách nhiệm và thẩm quyền cho tư vấn bên ngoài, giao hoàn toàn mọi việc từ lập chiến lược đến theo dõi.
- b: Thu thập thông tin để xác nhận các hiệu quả dự kiến trong chiến lược hệ thống thông tin đã được đạt đến mức nào.
- c: Phân bổ cho tổ chức những trách nhiệm và nhân lực cần thiết để thực hiện chiến lược hệ thống thông tin.
- d: Hình dung nhiều phương án tương lai của hệ thống thông tin, nhờ chuyên gia bên ngoài so sánh, phân tích và tiến hành đánh giá.
ア a, b, c; イ a, c; ウ b, c; エ b, c, d.', NULL, 'エ', 'b, c, d đúng: thu thập dữ liệu để theo dõi hiệu quả, phân bổ trách nhiệm và nhân lực, đánh giá các phương án tương lai với hỗ trợ chuyên gia. a sai vì ban lãnh đạo không được giao toàn bộ trách nhiệm quản trị cho tư vấn. エ = b,c,d.', '[{"term": "経営陣", "reading": "けいえいじん", "meaning": "ban lãnh đạo"}, {"term": "権限", "reading": "けんげん", "meaning": "thẩm quyền"}, {"term": "要員", "reading": "よういん", "meaning": "nhân lực"}]'::jsonb, 35);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 36, '問36 クライアントPCへのソフトウェアの導入作業が契約に含まれるシステム開発プロジェクトがある。導入作業の行動に関する記述のうち,適切なものだけを全て挙げたものはどれか。
a 導入作業中に契約外のPCが見つかった。そのPCを導入対象外とした。
b 導入作業中に契約外のPCへの導入を依頼された。依頼に基づいて,その対応を無償で行った。
c 導入作業の続行が困難な状態となった。発注者と合意し,導入前の状態に復旧した。
ア a
イ a, b
ウ a, c
エ b, c', '', NULL, 'ウ', 'a và c đúng: máy ngoài hợp đồng không tự động thuộc phạm vi triển khai; khi không thể tiếp tục thì thống nhất với bên đặt hàng rồi khôi phục trạng thái trước triển khai. b tự nhận thêm việc miễn phí theo yêu cầu mà không xử lý thay đổi phạm vi là không phù hợp. ウ = a,c.', '[{"term": "導入", "reading": "どうにゅう", "meaning": "triển khai/đưa vào dùng"}, {"term": "契約外", "reading": "けいやくがい", "meaning": "ngoài hợp đồng"}, {"term": "復旧", "reading": "ふっきゅう", "meaning": "khôi phục hoạt động"}]'::jsonb, 36);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 37, '問37 Aさんは新規プロジェクトの計画段階の作業をしており,開発コストの見積りに着手した。この段階で短期的に概算費用を見積もる方法として,最も適切なものはどれか。
ア FP法を用いて見積もる。
イ 作業単位のコストを見積もり,合算して全体を見積もる。
ウ 予想されるソフトウェアのコード行数を基に見積もる。
エ 類似プロジェクトを参考に見積もる。', '', NULL, 'エ', 'Ở giai đoạn lập kế hoạch sớm, cần nhanh một con số sơ bộ: tham khảo dự án tương tự (analogous estimation), chọn エ. Bottom-up cần phân rã công việc chi tiết; ước lượng dòng mã hoặc FP cần thêm dữ liệu đầu vào.', '[{"term": "概算費用", "reading": "がいさんひよう", "meaning": "chi phí ước tính sơ bộ"}, {"term": "見積り", "reading": "みつもり", "meaning": "ước lượng/báo giá"}, {"term": "類似", "reading": "るいじ", "meaning": "tương tự"}]'::jsonb, 37);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 38, '問38 要求事項が明確であり仕様変更が少ないことが見込まれるソフトウェアの開発に用いる開発モデル・手法として,最も適切なものはどれか。
ア アジャイル開発
イ ウォーターフォールモデル
ウ スパイラルモデル
エ プロトタイピングモデル', '', NULL, 'イ', 'Yêu cầu rõ và ít thay đổi phù hợp waterfall: đi tuần tự qua các giai đoạn. Agile thích ứng thay đổi; prototype dùng khám phá/làm rõ yêu cầu; spiral lặp lại có đánh giá rủi ro.', '[{"term": "要求事項", "reading": "ようきゅうじこう", "meaning": "các yêu cầu"}, {"term": "仕様変更", "reading": "しようへんこう", "meaning": "thay đổi đặc tả"}, {"term": "明確", "reading": "めいかく", "meaning": "rõ ràng"}]'::jsonb, 38);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 39, '問39 システム開発のプロジェクトマネジメントにおけるWBSの説明として,最も適切なものはどれか。
ア クリティカルパス上の作業を記載したものである。
イ 主要な成果物に関する予定開始日と予定終了日を記載したものである。
ウ 全ての成果物を作成するための作業を階層的に分解して記載したものである。
エ プロジェクトで使用するツールを記載したものである。', '', NULL, 'ウ', 'WBS phân rã theo cấp bậc toàn bộ công việc để tạo các deliverable của dự án. Bản đáp án chọn ウ. Dễ nhầm với critical path (đường quyết định thời gian), lịch bắt đầu/kết thúc và danh sách công cụ; WBS tập trung vào phạm vi công việc.', '[{"term": "成果物", "reading": "せいかぶつ", "meaning": "sản phẩm bàn giao"}, {"term": "階層的", "reading": "かいそうてき", "meaning": "theo cấp bậc"}, {"term": "分解", "reading": "ぶんかい", "meaning": "phân rã"}]'::jsonb, 39);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 40, '問40 企業の活動に関する記述のうち,内部統制の活動内容として,最も適切なものはどれか。
ア 決算発表の内容に重大な誤りがあった場合は,速やかに外部に公表する。
イ 支払伝票を起票した際は,起票者が責任をもって確認し最終承認を行う。
ウ 定期的にリスクを評価し,洗い出されたリスクの全てを“回避”で対応する。
エ 内部通報は必ず直属の上司を通じて行うことを,ルールとして徹底する。', '', NULL, 'ア', 'ア: có sai sót trọng yếu trong công bố quyết toán thì nhanh chóng công bố ra ngoài. イ để người lập phiếu tự phê duyệt cuối cùng thiếu phân tách nhiệm vụ; ウ không phải mọi rủi ro đều xử lý bằng tránh né; エ ép tố giác phải qua cấp trên trực tiếp có thể cản trở báo cáo.', '[{"term": "内部統制", "reading": "ないぶとうせい", "meaning": "kiểm soát nội bộ"}, {"term": "決算", "reading": "けっさん", "meaning": "quyết toán"}, {"term": "内部通報", "reading": "ないぶつうほう", "meaning": "tố giác/báo cáo nội bộ"}]'::jsonb, 40);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 41, '問41 ITガバナンスの活動において,取締役会等のリーダーシップに関するリスクの記述として,最も適切なものはどれか。
ア 権限委譲して策定させた成果物であるIT戦略は,担当部門に最終的な責任をもたせないと,取締役会等の説明責任が果たせない。
イ 組織体としてのパフォーマンスの期待値は,取締役会等が設定に関与すると,現状踏襲型となり組織体の目的を達成できない。
ウ 取締役会等が規範を策定し,率先して遵守しないと,組織体にその倫理的な行動が徹底されない。
エ 取締役会等が組織体のITガバナンス方針を明示すると,情報システム部門主導の活動に偏重してしまう。', 'Trong hoạt động IT governance, mô tả nào phù hợp nhất về rủi ro liên quan đến vai trò lãnh đạo của hội đồng quản trị và các cơ quan tương đương?
- ア: Đối với chiến lược IT được xây dựng sau khi ủy quyền, nếu không giao trách nhiệm cuối cùng cho bộ phận phụ trách thì hội đồng quản trị không thể thực hiện trách nhiệm giải trình.
- イ: Nếu hội đồng quản trị tham gia thiết lập mức hiệu quả hoạt động kỳ vọng của tổ chức, tổ chức sẽ chỉ tiếp nối hiện trạng và không thể đạt mục tiêu.
- ウ: Nếu hội đồng quản trị ban hành chuẩn mực nhưng không đi đầu tuân thủ, hành vi đạo đức đó sẽ không được thực hiện triệt để trong tổ chức.
- エ: Nếu hội đồng quản trị nêu rõ chính sách IT governance của tổ chức, hoạt động sẽ bị thiên lệch về phía bộ phận hệ thống thông tin chủ trì.', NULL, 'ウ', 'ウ: nếu hội đồng quản trị ban hành quy tắc nhưng không đi đầu tuân thủ, hành vi đạo đức khó được thực hiện trong tổ chức. Giao quyền không có nghĩa bỏ trách nhiệm cuối cùng; lãnh đạo vẫn phải định hướng, đặt kỳ vọng và giám sát.', '[{"term": "取締役会", "reading": "とりしまりやくかい", "meaning": "hội đồng quản trị"}, {"term": "率先", "reading": "そっせん", "meaning": "đi đầu"}, {"term": "遵守", "reading": "じゅんしゅ", "meaning": "tuân thủ"}]'::jsonb, 41);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 42, '問42 サービスデスクに関する記述として,最も適切なものはどれか。
ア 受入テストの段階で,利用者からの不具合の報告を受け付ける窓口
イ システム稼働後の段階で,利用者からの問合せを受け付ける窓口
ウ プログラム開発の段階で,利用者からの質問を受け付ける窓口
エ 要件定義の段階で,利用者からの要求を受け付ける窓口', '', NULL, 'イ', 'Service desk là đầu mối tiếp nhận thắc mắc/yêu cầu của người dùng khi hệ thống đã vận hành, chọn イ. Không phải riêng cổng nhận yêu cầu ở giai đoạn định nghĩa yêu cầu, lập trình hay kiểm thử nghiệm thu.', '[{"term": "稼働", "reading": "かどう", "meaning": "vận hành"}, {"term": "問合せ", "reading": "といあわせ", "meaning": "thắc mắc/yêu cầu hỏi"}, {"term": "窓口", "reading": "まどぐち", "meaning": "đầu mối tiếp nhận"}]'::jsonb, 42);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 43, '問43 ある企業でスマートフォン向けのアプリケーションソフトウェアの開発を計画しており,2週間ごとに新機能や不具合の修正を含めた新しいバージョンを繰り返しリリースすることにした。新機能の候補や不具合は一覧表で管理し,優先順位をつけて開発し,逐次リリースする方針にした。この開発に採用するソフトウェア開発モデルとして,最も適切なものはどれか。
ア DevOps
イ アジャイル
ウ ウォーターフォール
エ リバースエンジニアリング', 'Một doanh nghiệp dự định phát triển ứng dụng cho smartphone. Doanh nghiệp quyết định cứ hai tuần lại phát hành một phiên bản mới, bao gồm tính năng mới và sửa lỗi. Những tính năng đang cân nhắc và lỗi được quản lý bằng một danh sách, sắp thứ tự ưu tiên rồi phát triển và phát hành lần lượt. Mô hình phát triển phần mềm nào phù hợp nhất cho cách phát triển này?
ア DevOps; イ Agile; ウ Waterfall; エ Reverse engineering — kỹ nghệ đảo ngược.', NULL, 'イ', 'Phát hành mỗi 2 tuần, quản lý danh sách tính năng/lỗi theo ưu tiên, triển khai và phát hành lặp lại là Agile. DevOps nhấn mạnh hợp tác phát triển-vận hành; waterfall tuần tự; reverse engineering phân tích ngược sản phẩm có sẵn.', '[{"term": "不具合", "reading": "ふぐあい", "meaning": "lỗi/trục trặc"}, {"term": "繰り返し", "reading": "くりかえし", "meaning": "lặp lại"}, {"term": "逐次", "reading": "ちくじ", "meaning": "lần lượt"}]'::jsonb, 43);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 44, '問44 あるサービスデスクでは,電子メールによる問合せに対応しており,受付担当者がメールの内容を確認し,回答担当者の割当てをしていた。このたび,割当て業務の効率化を目的に,自動割当てツールを導入した。自動割当てツールは,メールの内容を基に自動で回答担当者の割当てを行うが,割当てができないことや割当てミスをすることがあり,それらについては,人手で対応している。導入前及び導入半年後の状況が次のとき,割当ての時間はサービスデスク全体で何%削減できたか。ここで,割当ての時間の削減率(%)は小数第1位を四捨五入するものとする。
| 時点 | 項目 | 件数・割合 | 割当ての時間 |
|---|---|---|---|
| 導入前 | 問合せ件数 | 1,000件/日 | 2分/件 |
| 導入半年後 | 問合せ件数 | 1,000件/日 | |
| | 自動割当てができた割合 | 90% | 0分/件 |
| | うち，割当てミスの割合 | 5% | 4分/件 |
| | 自動割当てができなかった割合 | 10% | 2分/件 |
ア 80
イ 81
ウ 85
エ 86', 'Một service desk xử lý các yêu cầu hỏi qua email. Trước đây, nhân viên tiếp nhận đọc nội dung email và phân công người trả lời. Để nâng cao hiệu quả phân công, service desk đã đưa vào một công cụ tự động phân công. Công cụ phân công người trả lời dựa trên nội dung email, nhưng đôi khi không phân công được hoặc phân công sai; những trường hợp đó được con người xử lý.
Với tình hình trước khi triển khai và sáu tháng sau khi triển khai như dưới đây, **thời gian phân công của toàn service desk đã giảm bao nhiêu phần trăm**? Tỷ lệ giảm (%) được làm tròn đến số nguyên bằng cách xét chữ số thập phân thứ nhất.
| Thời điểm | Hạng mục | Số lượng/tỷ lệ | Thời gian phân công |
|---|---|---|---|
| Trước triển khai | Số yêu cầu hỏi | 1.000 yêu cầu/ngày | 2 phút/yêu cầu |
| Sau triển khai 6 tháng | Số yêu cầu hỏi | 1.000 yêu cầu/ngày | |
| | Tỷ lệ phân công tự động được | 90% | 0 phút/yêu cầu |
| | Trong số đó, tỷ lệ phân công sai | 5% | 4 phút/yêu cầu |
| | Tỷ lệ không phân công tự động được | 10% | 2 phút/yêu cầu |
ア 80%; イ 81%; ウ 85%; エ 86%.', NULL, 'イ', 'Trước: 1.000 × 2 = 2.000 phút/ngày. Sau: 900 lượt phân tự động, sai 5% của 900 = 45 lượt × 4 = 180 phút; 100 lượt không tự động × 2 = 200 phút. Tổng 380 phút. Giảm (2.000−380)/2.000 ×100 = 81%, chọn イ. Bẫy: 5% tính trên 90% được tự động, không phải toàn bộ 1.000.', '[{"term": "割当て", "reading": "わりあて", "meaning": "phân công/phân bổ"}, {"term": "削減率", "reading": "さくげんりつ", "meaning": "tỷ lệ cắt giảm"}, {"term": "四捨五入", "reading": "ししゃごにゅう", "meaning": "làm tròn"}]'::jsonb, 44);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 45, '問45 プロジェクトにおいて,新規プロジェクトを正式に認可する文書として,適切なものはどれか。
ア ステークホルダ登録簿
イ プロジェクト憲章
ウ プロジェクトスコープ記述書
エ リスク登録簿', '', NULL, 'イ', 'プロジェクト憲章 (project charter) chính thức cho phép dự án được triển khai. Stakeholder register liệt kê các bên liên quan; scope statement mô tả phạm vi; risk register ghi rủi ro.', '[{"term": "憲章", "reading": "けんしょう", "meaning": "hiến chương/văn bản thành lập"}, {"term": "認可", "reading": "にんか", "meaning": "chấp thuận chính thức"}, {"term": "登録簿", "reading": "とうろくぼ", "meaning": "sổ đăng ký"}]'::jsonb, 45);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 46, '問46 ITサービスマネジメントのプロセスである問題管理の説明として,適切なものはどれか。
ア ITサービスを提供するためのハードウェア,ソフトウェア,ドキュメントなどの構成情報を維持管理する。
イ 計画外のITサービスの中断に対して,迅速にサービスを復旧する。
ウ 障害の根本原因を調査し,問題の解決策を提示する。
エ プログラム修正を実施するための計画を立て,確実に修正されるように管理する。', '', NULL, 'ウ', 'ウ: điều tra nguyên nhân gốc và đưa giải pháp để xử lý vấn đề/ngăn tái diễn. イ là incident management, ưu tiên khôi phục nhanh dịch vụ; ア là configuration management; エ thiên về quản lý thay đổi/sửa chương trình.', '[{"term": "根本原因", "reading": "こんぽんげんいん", "meaning": "nguyên nhân gốc"}, {"term": "障害", "reading": "しょうがい", "meaning": "sự cố"}, {"term": "解決策", "reading": "かいけつさく", "meaning": "giải pháp"}]'::jsonb, 46);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 47, '問47 監査を会計監査,業務監査,情報セキュリティ監査,システム監査に分けたとき,システム監査に関する記述として,最も適切なものはどれか。
ア 業務で使用している情報の漏えいに関するリスクマネジメントが効果的に実施されていることの検証
イ 財務諸表の作成に至る業務全般に関して,不正や誤りがなく処理されていることの検証
ウ 情報システムに係るリスクに対して,組織において適切に対応していることの検証
エ 情報システムの利用を含めた組織内の諸業務が組織の方針に従って,合理的かつ効率的に運用されていることの検証', 'Khi chia kiểm toán thành kiểm toán kế toán, kiểm toán nghiệp vụ, kiểm toán an toàn thông tin và kiểm toán hệ thống, mô tả nào phù hợp nhất về kiểm toán hệ thống?
- ア: Xác minh rằng việc quản lý rủi ro rò rỉ thông tin sử dụng trong công việc được thực hiện hiệu quả.
- イ: Xác minh rằng toàn bộ nghiệp vụ dẫn tới lập báo cáo tài chính được xử lý mà không có gian lận hay sai sót.
- ウ: Xác minh rằng tổ chức ứng phó phù hợp với các rủi ro liên quan đến hệ thống thông tin.
- エ: Xác minh rằng các nghiệp vụ trong tổ chức, bao gồm sử dụng hệ thống thông tin, được vận hành hợp lý và hiệu quả theo chính sách của tổ chức.', NULL, 'ウ', 'ウ: xác minh tổ chức có ứng phó thích hợp với rủi ro liên quan hệ thống thông tin hay không. ア tập trung bảo mật; イ tập trung báo cáo tài chính; エ là kiểm toán nghiệp vụ rộng hơn. System audit cần đánh giá độc lập về quản trị/kiểm soát hệ thống.', '[{"term": "監査", "reading": "かんさ", "meaning": "kiểm toán/kiểm tra độc lập"}, {"term": "検証", "reading": "けんしょう", "meaning": "xác minh"}, {"term": "財務諸表", "reading": "ざいむしょひょう", "meaning": "báo cáo tài chính"}]'::jsonb, 47);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 48, '問48 ある組織では,IT資産を管理しているグループが,共有ディスクの使用量を月次でチェックし,容量が不足しそうなときは,不要なファイルを消すよう呼び掛けたり,すぐに使わないファイルを別のメディアに退避したりして,容量が不足することを回避する対応を行っている。共有ディスクの増設の対応は,年単位で計画して実施している。ある日,共有ディスクの使用量が上限に達し,組織の業務に支障が出る事象が発生した。この事象への対応を,インシデント管理,問題管理,サービスマネジメントシステムの改善に分けて考えるとき,サービスマネジメントシステムの改善として,適切なものだけを全て挙げたものはどれか。
a 共有ディスクの使用量が大きいファイルを調べ,当面の業務に使用しないものを一時的に別のストレージに移動する。
b 共有ディスクの使用量が上限に達した原因を特定し,再発防止策を検討する。
c 共有ディスクの使用量をタイムリーに把握し,容量不足の兆候を早期に検知できるようにする。
d すぐに共有ディスクの増設の手続を進める。
ア a, d
イ b, d
ウ c
エ c, d', 'Tại một tổ chức, nhóm quản lý tài sản IT kiểm tra lượng sử dụng đĩa dùng chung hằng tháng. Khi dung lượng có vẻ sắp thiếu, nhóm yêu cầu xóa tệp không cần thiết hoặc chuyển tệp chưa dùng ngay sang phương tiện lưu trữ khác để tránh thiếu dung lượng. Việc bổ sung đĩa dùng chung được lập kế hoạch và thực hiện theo năm.
Một ngày, lượng sử dụng đạt giới hạn trên và xảy ra sự kiện gây trở ngại cho hoạt động của tổ chức. Khi phân loại cách ứng phó với sự kiện này thành quản lý incident, quản lý problem và cải tiến hệ thống quản lý dịch vụ, phương án nào liệt kê **tất cả và chỉ các biện pháp thuộc cải tiến hệ thống quản lý dịch vụ**?
- a: Kiểm tra các tệp chiếm nhiều dung lượng trên đĩa dùng chung và tạm chuyển những tệp chưa cần cho công việc trước mắt sang nơi lưu trữ khác.
- b: Xác định nguyên nhân lượng sử dụng đĩa dùng chung đạt giới hạn trên và xem xét biện pháp ngăn tái diễn.
- c: Nắm bắt lượng sử dụng đĩa dùng chung kịp thời để có thể phát hiện sớm dấu hiệu thiếu dung lượng.
- d: Tiến hành ngay thủ tục bổ sung đĩa dùng chung.
ア a, d; イ b, d; ウ c; エ c, d.', NULL, 'ウ', 'c: theo dõi dung lượng kịp thời và phát hiện dấu hiệu thiếu sớm là cải tiến cách quản lý để ngăn sự cố. a di chuyển file tạm thời nhằm khôi phục là xử lý incident; b tìm nguyên nhân là problem management; d bổ sung đĩa ngay là ứng phó trực tiếp. ウ = c.', '[{"term": "上限", "reading": "じょうげん", "meaning": "giới hạn trên"}, {"term": "兆候", "reading": "ちょうこう", "meaning": "dấu hiệu"}, {"term": "再発防止", "reading": "さいはつぼうし", "meaning": "ngăn tái diễn"}]'::jsonb, 48);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 49, '問49 システム開発プロジェクトで開催するプロジェクト会議に関する記述のうち,最も適切なものはどれか。
ア 会議で決まった内容を周知徹底するために,議事録を作成して必要な関係者と共有する。
イ 議論が中途半端にならないように,会議の終了時刻は決めずに実施する。
ウ 効率よくシステム開発プロジェクトを遂行するために,全ての会議にステークホルダ全員が常に参加する。
エ 様々な内容を会議で議論できるように,会議の開始直後に会議の議題を参加メンバーから募って確定する。', '', NULL, 'ア', 'ア: lập biên bản và chia sẻ với người liên quan để quyết định được phổ biến và thực hiện. Nên có giờ kết thúc, chọn người tham dự phù hợp và chuẩn bị agenda trước; không cần mọi stakeholder dự mọi cuộc họp.', '[{"term": "議事録", "reading": "ぎじろく", "meaning": "biên bản họp"}, {"term": "周知徹底", "reading": "しゅうちてってい", "meaning": "phổ biến đầy đủ"}, {"term": "議題", "reading": "ぎだい", "meaning": "chủ đề cuộc họp"}]'::jsonb, 49);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 50, '問50 次の表の作業を3名で実施するとき,全ての作業を終わらせるのに必要な最短の日数は何日か。ここで,複数要員が必要な作業は全員がそろわないと着手できず,指定された要員数以上の要員を充てても所要日数は短縮できない。また,着手した作業は作業が完了するまで中断できないものとする。
| 作業名 | 前提作業 | 要員数 | 所要日数 |
|---|---|---|---|
| A | − | 1名 | 3日 |
| B | A | 2名 | 3日 |
| C | A | 2名 | 3日 |
| D | B | 1名 | 3日 |
| E | C | 2名 | 3日 |
| F | D, E | 1名 | 3日 |
ア 9日
イ 12日
ウ 15日
エ 18日', 'Nếu ba người thực hiện các công việc trong bảng dưới đây, cần ít nhất bao nhiêu ngày để hoàn thành tất cả công việc?
Đối với công việc cần nhiều người, chỉ được bắt đầu khi đủ tất cả số người cần thiết. Dù bố trí nhiều hơn số người được chỉ định, số ngày cần để thực hiện cũng không giảm. Một công việc đã bắt đầu thì không được ngắt giữa chừng cho đến khi hoàn thành.
| Công việc | Công việc phải hoàn thành trước | Số người | Thời gian |
|---|---|---:|---|
| A | Không có | 1 | 3 ngày |
| B | A | 2 | 3 ngày |
| C | A | 2 | 3 ngày |
| D | B | 1 | 3 ngày |
| E | C | 2 | 3 ngày |
| F | D, E | 1 | 3 ngày |
ア 9 ngày; イ 12 ngày; ウ 15 ngày; エ 18 ngày.', NULL, 'ウ', '15 ngày, ウ. Lịch khả thi: ngày 1–3 A(1 người); 4–6 B(2); 7–9 C(2) và D(1); 10–12 E(2); 13–15 F(1). B và C mỗi việc cần 2 người nên không thể cùng chạy với tổng 3 người; mỗi việc kéo dài 3 ngày và không được ngắt. Chuỗi A→(B,C phải tuần tự)→E→F đã buộc ít nhất 15 ngày; lịch trên đạt cận đó.', '[{"term": "前提作業", "reading": "ぜんていさぎょう", "meaning": "công việc tiền đề"}, {"term": "所要日数", "reading": "しょようにっすう", "meaning": "số ngày cần"}, {"term": "中断", "reading": "ちゅうだん", "meaning": "gián đoạn"}]'::jsonb, 50);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 51, '問51 システム監査において,各部署の外部媒体の管理状況について調査することにした。システム監査を,監査計画,予備調査,本調査,評価・結論のプロセスに分けて実施するとき,収集した結果に基づき,外部媒体の管理状況についての監査意見を検討するプロセスはどれか。
ア 監査計画
イ 予備調査
ウ 本調査
エ 評価・結論', 'Trong kiểm toán hệ thống, người ta quyết định điều tra tình trạng quản lý các phương tiện lưu trữ bên ngoài của từng phòng ban. Nếu chia quy trình kiểm toán hệ thống thành lập kế hoạch kiểm toán, điều tra sơ bộ, điều tra chính thức và đánh giá/kết luận, thì việc xem xét ý kiến kiểm toán về tình trạng quản lý các phương tiện lưu trữ bên ngoài, dựa trên kết quả đã thu thập, thuộc bước nào?
ア Lập kế hoạch kiểm toán; イ Điều tra sơ bộ; ウ Điều tra chính thức; エ Đánh giá/kết luận.', NULL, 'エ', 'Sau khi thu thập bằng chứng, xem xét ý kiến kiểm toán thuộc 評価・結論 (đánh giá, kết luận), chọn エ. Lập kế hoạch quyết định phạm vi/cách làm; điều tra sơ bộ tìm hiểu; điều tra chính thu thập, kiểm tra bằng chứng.', '[{"term": "外部媒体", "reading": "がいぶばいたい", "meaning": "phương tiện lưu trữ bên ngoài"}, {"term": "監査意見", "reading": "かんさいけん", "meaning": "ý kiến kiểm toán"}, {"term": "結論", "reading": "けつろん", "meaning": "kết luận"}]'::jsonb, 51);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 52, '問52 業務システムの開発において,開発者がシステム要件定義を実施する場合,利用者の関わり方として,最も適切なものはどれか。
ア 開発者が行うシステム要件のレビューに参加し,妥当性を確認する。
イ 開発者に全て任せ,その決定に従う。
ウ システムの保守が可能かどうかを見極める。
エ システム要件の技術的な実現性を検証する。', '', NULL, 'ア', 'ア: người dùng tham gia review yêu cầu hệ thống và xác nhận tính phù hợp với nghiệp vụ. Không giao hết cho nhà phát triển. Khả năng bảo trì và tính khả thi kỹ thuật cần chuyên môn kỹ thuật, không phải vai trò trọng tâm của người dùng trong câu này.', '[{"term": "要件定義", "reading": "ようけんていぎ", "meaning": "định nghĩa yêu cầu"}, {"term": "妥当性", "reading": "だとうせい", "meaning": "tính phù hợp/hợp lý"}, {"term": "実現性", "reading": "じつげんせい", "meaning": "tính khả thi"}]'::jsonb, 52);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 53, '問53 SLAの計画立案,サービス内容の交渉,草案作成,合意,導入,測定などの活動を行うものはどれか。
ア アウトソーシング
イ サービスレベル管理
ウ サービスレベル契約
エ リエンジニアリング', '', NULL, 'イ', 'サービスレベル管理 (SLM) quản lý việc lập kế hoạch, thương lượng, soạn, thống nhất, áp dụng và đo lường SLA. SLA là thỏa thuận/kết quả tài liệu; SLM là hoạt động quản lý thỏa thuận đó.', '[{"term": "交渉", "reading": "こうしょう", "meaning": "đàm phán"}, {"term": "草案", "reading": "そうあん", "meaning": "bản dự thảo"}, {"term": "合意", "reading": "ごうい", "meaning": "thống nhất"}]'::jsonb, 53);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 54, '問54 ある組織では過去には全員出社して業務を遂行していたが,現在は出社とテレワークの両方を使い分けて業務を遂行している。この組織において,ファシリティマネジメントの観点で改善を図っている事例として,適切なものだけを全て挙げたものはどれか。
a 従業員のPCにインストールされたWeb会議用のソフトウェアを常に最新にし,Web会議における利便性及びセキュリティを向上させる。
b 執務室のレイアウト変更や大画面のTV会議室の設置を行い,従業員間のコミュニケーションを取りやすくする。
c 出社率を踏まえてフリーアドレスエリアの割合を増加し,オフィスを縮小させる。
d 短時間勤務や自宅外での業務を可能とする制度を導入し,様々な従業員が業務に参画しやすくする。
ア a, d
イ b
ウ b, c
エ b, d', 'Một tổ chức trước đây yêu cầu tất cả nhân viên đến công ty làm việc; hiện nay tổ chức kết hợp làm việc tại công ty và làm việc từ xa. Phương án nào liệt kê tất cả và chỉ các ví dụ cải tiến từ góc nhìn quản lý cơ sở vật chất (facility management)?
- a: Luôn cập nhật phần mềm họp Web trên PC của nhân viên lên phiên bản mới nhất để nâng cao tiện ích và bảo mật khi họp Web.
- b: Thay đổi bố trí phòng làm việc và lắp đặt phòng họp video có màn hình lớn để nhân viên dễ giao tiếp với nhau.
- c: Dựa vào tỷ lệ nhân viên đến công ty, tăng tỷ lệ khu bàn làm việc không cố định và thu nhỏ văn phòng.
- d: Áp dụng chế độ cho phép làm việc thời gian ngắn và làm việc ở nơi ngoài nhà riêng, để nhiều nhóm nhân viên dễ tham gia công việc hơn.
ア a, d; イ b; ウ b, c; エ b, d.', NULL, 'ウ', 'b và c: đổi bố trí phòng làm việc/lắp phòng họp màn hình lớn, tăng khu bàn linh hoạt và thu nhỏ văn phòng theo tỷ lệ đến công ty. Đây là quản lý không gian/cơ sở vật chất. a cập nhật phần mềm; d chế độ làm việc/nhân sự. ウ = b,c.', '[{"term": "執務室", "reading": "しつむしつ", "meaning": "phòng làm việc"}, {"term": "出社率", "reading": "しゅっしゃりつ", "meaning": "tỷ lệ đến công ty"}, {"term": "縮小", "reading": "しゅくしょう", "meaning": "thu nhỏ"}]'::jsonb, 54);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 55, '問55 IoTのセキュリティに関する次の記述中のa，bに入れる字句の適切な組合せはどれか。
ネットワークカメラの画像を盗み見される脅威のうち，ネットワークカメラへの［a］対策として，第三者がカメラにアクセスして映像を閲覧できないようにするためには，［b］で利用しない。
| 選択肢 | a | b |
|---|---|---|
| ア | DDoS攻撃 | 初期パスワード |
| イ | DDoS攻撃 | 有線回線 |
| ウ | 不正侵入 | 初期パスワード |
| エ | 不正侵入 | 有線回線 |', 'Chọn tổ hợp từ thích hợp để điền vào a và b trong mô tả về bảo mật IoT sau đây.
Trong các mối đe dọa làm hình ảnh từ camera mạng bị xem trộm, để ứng phó với việc［a］vào camera mạng và ngăn bên thứ ba truy cập camera để xem hình ảnh, không sử dụng camera với［b］.
| Lựa chọn | a | b |
|---|---|---|
| ア | Tấn công DDoS | Mật khẩu ban đầu/mặc định |
| イ | Tấn công DDoS | Đường truyền có dây |
| ウ | Xâm nhập trái phép | Mật khẩu ban đầu/mặc định |
| エ | Xâm nhập trái phép | Đường truyền có dây |', NULL, 'ウ', 'ウ: chống 不正侵入 (xâm nhập trái phép) bằng cách không dùng 初期パスワード (mật khẩu mặc định). DDoS gây quá tải dịch vụ, không phải hành vi trực tiếp xem trộm hình ảnh; tránh mạng có dây không giải quyết việc mật khẩu mặc định.', '[{"term": "不正侵入", "reading": "ふせいしんにゅう", "meaning": "xâm nhập trái phép"}, {"term": "初期パスワード", "reading": "しょきパスワード", "meaning": "mật khẩu ban đầu"}, {"term": "盗み見", "reading": "ぬすみみ", "meaning": "xem trộm"}]'::jsonb, 55);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 56, '問56 DBMSにおけるチェックポイントの説明として,適切なものはどれか。
ア トランザクションが正常に処理されたときに,トランザクションの一連の処理を確定させること
イ トランザクションが何らかの理由で正常に処理されなかったときに,データベースをトランザクションの処理開始前の状態に戻すこと
ウ 複数のトランザクションを並列に処理しているときに,ロックの影響によってトランザクション同士が互いに相手のロックの解放を待つ状態になること
エ 複数のトランザクションによるメモリ上のデータ更新の結果を,一度にまとめてHDDなどの外部記憶装置に書き込む操作や,操作が行われた時点のこと', 'Mô tả nào phù hợp về checkpoint trong DBMS?
- ア: Khi transaction được xử lý bình thường, xác nhận/chốt toàn bộ chuỗi xử lý của transaction đó.
- イ: Khi transaction không được xử lý bình thường vì một nguyên nhân nào đó, đưa cơ sở dữ liệu trở về trạng thái trước khi transaction bắt đầu xử lý.
- ウ: Khi nhiều transaction được xử lý song song, tác động của khóa khiến các transaction rơi vào trạng thái mỗi bên đều chờ bên kia giải phóng khóa.
- エ: Thao tác ghi đồng loạt kết quả cập nhật dữ liệu trong bộ nhớ của nhiều transaction xuống thiết bị lưu trữ ngoài như HDD, hoặc thời điểm thao tác đó được thực hiện.', NULL, 'エ', 'エ: thao tác hoặc thời điểm ghi tập hợp kết quả cập nhật dữ liệu trong bộ nhớ xuống thiết bị lưu trữ ngoài. ア là commit; イ rollback; ウ deadlock. Checkpoint giúp việc phục hồi sau lỗi có điểm mốc.', '[{"term": "確定", "reading": "かくてい", "meaning": "xác nhận/chốt"}, {"term": "並列", "reading": "へいれつ", "meaning": "song song"}, {"term": "外部記憶装置", "reading": "がいぶきおくそうち", "meaning": "thiết bị lưu trữ ngoài"}]'::jsonb, 56);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 57, '問57 関係データベースで管理している“学生”表,“科目”表,“成績”表がある。1人の学生は複数の科目を履修するものとし,“学生”表に登録されていない学生や,“科目”表に登録されていない科目は“成績”表に登録できないものとするとき,外部キーとして設定するのが適切なものはどれか。ここで,表中の下線は主キーを表す。
**学生**
| 学生番号（主キー） | 学生名 |
|---|---|
| G001 | 鈴木 次郎 |
| G002 | 山田 春子 |
**科目**
| 科目コード（主キー） | 科目名 |
|---|---|
| K001 | データベース |
| K002 | コンピュータ |
| K003 | ネットワーク |
**成績**（学生番号と科目コードの組合せが主キー）
| 学生番号 | 科目コード | 成績 |
|---|---|---|
| G001 | K001 | 優 |
| G001 | K002 | 可 |
| G002 | K002 | 良 |
| G002 | K003 | 優 |
ア “学生”表の学生番号，“成績”表の学生番号
イ “学生”表の学生名，“科目”表の科目名
ウ “成績”表の学生番号と科目コード
エ “成績”表の成績', 'Có các bảng “Sinh viên”, “Môn học” và “Kết quả học tập” được quản lý bằng cơ sở dữ liệu quan hệ. Một sinh viên học nhiều môn. Không thể đăng ký vào bảng “Kết quả học tập” một sinh viên chưa có trong bảng “Sinh viên”, hoặc một môn chưa có trong bảng “Môn học”. Trong điều kiện đó, nên đặt những cột nào làm khóa ngoại? Các phần gạch chân trong bảng gốc biểu thị khóa chính.
Các bảng có nội dung như sau:
- Sinh viên: mã sinh viên G001 — 鈴木 次郎; G002 — 山田 春子. Khóa chính: mã sinh viên.
- Môn học: K001 — Cơ sở dữ liệu; K002 — Máy tính; K003 — Mạng. Khóa chính: mã môn học.
- Kết quả học tập: G001/K001 — 優 (xuất sắc); G001/K002 — 可 (đạt); G002/K002 — 良 (tốt); G002/K003 — 優 (xuất sắc). Khóa chính là tổ hợp mã sinh viên và mã môn học.
Các lựa chọn:
- ア: Mã sinh viên trong bảng “Sinh viên” và mã sinh viên trong bảng “Kết quả học tập”.
- イ: Tên sinh viên trong bảng “Sinh viên” và tên môn học trong bảng “Môn học”.
- ウ: Mã sinh viên và mã môn học trong bảng “Kết quả học tập”.
- エ: Điểm/xếp loại trong bảng “Kết quả học tập”.', NULL, 'ウ', 'Trong bảng 成績, 学生番号 tham chiếu bảng 学生 và 科目コード tham chiếu bảng 科目: chọn ウ. Hai cột này cùng tạo khóa chính ghép của bảng điểm, đồng thời mỗi cột là khóa ngoại. Khóa chính và khóa ngoại không loại trừ nhau.', '[{"term": "外部キー", "reading": "がいぶキー", "meaning": "khóa ngoại"}, {"term": "主キー", "reading": "しゅキー", "meaning": "khóa chính"}, {"term": "履修", "reading": "りしゅう", "meaning": "học/đăng ký môn"}]'::jsonb, 57);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 58, '問58 UXデザインで用いられることがある構造化シナリオ法における，三つのシナリオはどれか。
ア アクティビティ，インタラクション，バリュー
イ アクティビティ，インタラクション，ペルソナ
ウ アクティビティ，バリュー，ペルソナ
エ インタラクション，バリュー，ペルソナ', '', NULL, 'ア', 'Ba loại là value, activity và interaction, chọn ア. Value mô tả giá trị với người dùng; activity mô tả hoạt động; interaction mô tả tương tác cụ thể. Persona là hình mẫu người dùng, không thuộc bộ ba scenario được hỏi.', '[{"term": "構造化", "reading": "こうぞうか", "meaning": "cấu trúc hóa"}, {"term": "価値", "reading": "かち", "meaning": "giá trị"}, {"term": "相互作用", "reading": "そうごさよう", "meaning": "tương tác"}]'::jsonb, 58);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 59, '問59 無線LANで使用するWPA2の機能として,適切なものはどれか。
ア 2本のアンテナを用いることによってデータの送受信を高速化する。
イ アクセスポイントをステルス化する。
ウ 通信データを暗号化する。
エ 登録されたMACアドレスをもつ機器以外からのアクセスを拒否する。', '', NULL, 'ウ', 'ウ: mã hóa dữ liệu truyền trên mạng Wi-Fi. Hai anten để tăng tốc liên quan MIMO; ẩn AP là stealth/SSID hiding; chỉ cho MAC đã đăng ký là MAC filtering. Chúng không phải chức năng được hỏi của WPA2.', '[{"term": "無線LAN", "reading": "むせんラン", "meaning": "mạng LAN không dây"}, {"term": "暗号化", "reading": "あんごうか", "meaning": "mã hóa"}, {"term": "送受信", "reading": "そうじゅしん", "meaning": "gửi và nhận"}]'::jsonb, 59);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 60, '問60 レスポンシブWebデザインに関する記述として,適切なものはどれか。
ア PC,スマートフォンなど,多くの種類の端末で,見やすく,かつ操作しやすくなるように,表示する端末の画面サイズなどに応じてWebサイトの画面レイアウトが変化する。
イ Webブラウザで動画コンテンツをストリーミング再生するとき,サーバやネットワークの負荷が軽減されるように,複数のコンテンツ配信サーバのうち,利用者に適したサーバに接続させてデータを取得する。
ウ スマートフォンなどの端末向けのWebアプリケーションにおいて,歩数や移動速度などを計測できるように,端末に内蔵された加速度センサーやジャイロセンサーのデータを使用する。
エ 操作説明書を読まなくてもWebサイトの使用方法を理解できるように,Webブラウザの利用者がマウスポインタをWebコンテンツに重ねたとき,ポップアップを用いて機能の説明,対象の状態などを表示する。', 'Mô tả nào phù hợp về responsive Web design — thiết kế Web thích ứng?
- ア: Để website dễ nhìn và dễ thao tác trên nhiều loại thiết bị như PC và smartphone, bố cục màn hình website thay đổi theo kích thước màn hình và các đặc điểm tương ứng của thiết bị hiển thị.
- イ: Khi phát trực tuyến nội dung video trên trình duyệt Web, kết nối người dùng đến máy chủ phù hợp trong số nhiều máy chủ phân phối nội dung để lấy dữ liệu, nhằm giảm tải máy chủ và mạng.
- ウ: Trong ứng dụng Web cho thiết bị như smartphone, dùng dữ liệu từ cảm biến gia tốc và cảm biến con quay tích hợp trong thiết bị để đo số bước, tốc độ di chuyển, v.v.
- エ: Để người dùng hiểu cách sử dụng website mà không cần đọc hướng dẫn, khi họ đặt con trỏ chuột lên nội dung Web, dùng cửa sổ bật lên để hiển thị giải thích chức năng, trạng thái đối tượng, v.v.', NULL, 'ア', 'ア: bố cục website thay đổi theo kích thước màn hình để dễ nhìn, dễ thao tác trên PC/smartphone. イ là phân phối nội dung kiểu CDN; ウ dùng cảm biến thiết bị; エ hiển thị thông tin khi rê chuột.', '[{"term": "画面", "reading": "がめん", "meaning": "màn hình"}, {"term": "端末", "reading": "たんまつ", "meaning": "thiết bị đầu cuối"}, {"term": "操作", "reading": "そうさ", "meaning": "thao tác"}]'::jsonb, 60);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 61, '問61 PCの画面表示に必要なデータを保持するのに使われる,画面表示専用メモリはどれか。
ア EEPROM
イ VRAM
ウ キャッシュメモリ
エ フラッシュメモリ', '', NULL, 'イ', 'VRAM giữ dữ liệu phục vụ hiển thị màn hình, chọn イ. Cache giảm thời gian truy cập dữ liệu; flash và EEPROM là bộ nhớ không mất dữ liệu khi tắt nguồn, không phải loại bộ nhớ chuyên dùng cho hiển thị trong câu hỏi.', '[{"term": "表示", "reading": "ひょうじ", "meaning": "hiển thị"}, {"term": "保持", "reading": "ほじ", "meaning": "lưu giữ"}, {"term": "専用", "reading": "せんよう", "meaning": "chuyên dùng"}]'::jsonb, 61);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 62, '問62 システムの性能評価におけるベンチマークテストに関する記述として,適切なものはどれか。
ア 評価対象のシステムで使われるものと同じデータ,同じプログラムを,ほかの疑似システム上で実行させて性能を評価する。
イ 評価対象のシステムの動作特性を,取扱いの容易な形にモデル化したものを用いて,ほかの疑似システム上で実行させて性能を評価する。
ウ 評価対象のシステムのプログラムステップ数,ハードウェア性能,I/O回数の机上計算値などを基に処理時間を積算して性能を評価する。
エ 標準的な処理を設定し,それを実行する評価用プログラムを,評価対象のシステム上で実際に実行させて性能を評価する。', 'Mô tả nào phù hợp về benchmark test trong đánh giá hiệu năng hệ thống?
- ア: Chạy cùng dữ liệu và cùng chương trình được dùng trong hệ thống cần đánh giá trên một hệ thống mô phỏng khác để đánh giá hiệu năng.
- イ: Dùng mô hình biểu diễn đặc tính hoạt động của hệ thống cần đánh giá dưới dạng dễ xử lý, chạy trên một hệ thống mô phỏng khác để đánh giá hiệu năng.
- ウ: Cộng dồn thời gian xử lý dựa trên các giá trị tính toán lý thuyết như số bước chương trình, hiệu năng phần cứng và số lần I/O của hệ thống cần đánh giá.
- エ: Xác định công việc xử lý chuẩn, thực sự chạy chương trình đánh giá thực hiện công việc đó trên chính hệ thống cần đánh giá để đo hiệu năng.', NULL, 'エ', 'エ: dùng chương trình đánh giá với công việc chuẩn, chạy thật trên hệ thống cần đánh giá rồi đo hiệu năng. Mô phỏng trên hệ thống giả lập hoặc cộng thời gian theo thông số lý thuyết không phải benchmark thực chạy này.', '[{"term": "性能評価", "reading": "せいのうひょうか", "meaning": "đánh giá hiệu năng"}, {"term": "標準的", "reading": "ひょうじゅんてき", "meaning": "mang tính chuẩn"}, {"term": "実行", "reading": "じっこう", "meaning": "thực thi"}]'::jsonb, 62);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 63, '問63 PCに保存されたファイルを使用できなくするランサムウェアによる被害を低減させるための対策として,適切なものはどれか。
ア UPSの導入
イ データの暗号化
ウ データのバックアップ
エ ログインパスワードの変更', '', NULL, 'ウ', 'ウ: backup dữ liệu để phục hồi khi file bị mã hóa/không dùng được. UPS chống mất điện; tự mã hóa dữ liệu hoặc đổi mật khẩu không trực tiếp tạo bản phục hồi. Trong thực tế, bản sao cần được bảo vệ khỏi cùng sự cố.', '[{"term": "被害", "reading": "ひがい", "meaning": "thiệt hại"}, {"term": "低減", "reading": "ていげん", "meaning": "giảm bớt"}, {"term": "保存", "reading": "ほぞん", "meaning": "lưu trữ"}]'::jsonb, 63);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 64, '問64 キャリアアグリゲーションの説明として,適切なものはどれか。
ア 移動中に携帯電話が接続する基地局を切り替える技術
イ 携帯電話の通信のセキュリティ機能を高める技術
ウ 複数の異なる周波数の電波を束ねることによって,無線通信を高速化する技術
エ 無線LANにおいて,アクセスポイントと呼ばれる基地局を経由して端末同士が通信を行う技術', '', NULL, 'ウ', 'ウ: gộp nhiều băng tần khác nhau để tăng tốc truyền thông không dây. Chuyển trạm khi di chuyển là handover; đi qua AP là chế độ infrastructure của WLAN.', '[{"term": "周波数", "reading": "しゅうはすう", "meaning": "tần số"}, {"term": "電波", "reading": "でんぱ", "meaning": "sóng vô tuyến"}, {"term": "束ねる", "reading": "たばねる", "meaning": "gộp/bó lại"}]'::jsonb, 64);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 65, '問65 DNSサーバの役割に関する記述として,適切なものはどれか。
ア LAN上のPCからインターネット上のWebサーバへのリクエストを中継するものであり,PCの代理としてインターネット上のWebサーバへアクセスして,その応答をPCに返す。
イ PCからサーバへのファイルの送受信の要求を受け付け,ファイルを転送する。
ウ PCに対してIPアドレスを自動で割り当て,サブネットマスクとデフォルトゲートウェイのIPアドレスの通知を行う。
エ ドメイン名をIPアドレスに変換する,又はIPアドレスをドメイン名に変換する。', 'Mô tả nào phù hợp về vai trò của máy chủ DNS?
- ア: Trung chuyển yêu cầu từ PC trên LAN đến máy chủ Web trên Internet; thay mặt PC truy cập máy chủ Web và trả phản hồi về PC.
- イ: Tiếp nhận yêu cầu gửi/nhận tệp từ PC tới máy chủ và chuyển tệp.
- ウ: Tự động cấp địa chỉ IP cho PC, thông báo subnet mask và địa chỉ IP của default gateway.
- エ: Chuyển tên miền thành địa chỉ IP, hoặc chuyển địa chỉ IP thành tên miền.', NULL, 'エ', 'エ: phân giải tên miền thành IP hoặc phân giải ngược IP thành tên miền. ア là proxy; イ là dịch vụ truyền file; ウ là DHCP (cấp IP, subnet mask, gateway).', '[{"term": "中継", "reading": "ちゅうけい", "meaning": "chuyển tiếp"}, {"term": "代理", "reading": "だいり", "meaning": "đại diện/thay mặt"}, {"term": "変換", "reading": "へんかん", "meaning": "chuyển đổi"}]'::jsonb, 65);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 66, '問66 アプリケーションソフトウェアの操作を行うとき,質問に答えていく対話形式によって,煩雑な操作を簡単に行えるようにする機能はどれか。
ア アーカイブ
イ ウィザード
ウ オートコンプリート
エ ポップアップウインドウ', '', NULL, 'イ', 'Wizard hướng dẫn từng bước bằng câu hỏi/hộp thoại để đơn giản hóa thao tác phức tạp, chọn イ. Autocomplete tự hoàn thành phần nhập; archive là lưu trữ/đóng gói; popup là cửa sổ hiện lên.', '[{"term": "対話形式", "reading": "たいわけいしき", "meaning": "hình thức đối thoại"}, {"term": "煩雑", "reading": "はんざつ", "meaning": "rườm rà/phức tạp"}, {"term": "簡単", "reading": "かんたん", "meaning": "đơn giản"}]'::jsonb, 66);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 67, '問67 手続sortは，要素数が2以上の整数型の配列を引数numberArrayで受け取り，その要素を昇順に並べ替えた結果を出力する。手続sortの動作確認のために，処理の途中でjの値とworkArrayの全ての要素を出力する。配列numberArrayを{3, 5, 1, 2, 4}とし，手続sortをsort(numberArray)として呼び出したとき，jの値が3と出力された直後のworkArrayの全ての要素の出力はどれか。ここで，配列の要素番号は1から始まる。
〔プログラム〕
```text
○sort(整数型の配列: numberArray)
  整数型: minIndex, j, k
  整数型の配列: workArray ← numberArray  // 配列の複製を作る
  for (jを1から(workArrayの要素数 − 1)まで1ずつ増やす)
    // j番目から末尾までの要素の中で最も小さい値をもつ要素の要素番号を
    // 一つ求める
    minIndex ← j
    for (kを(j ＋ 1)からworkArrayの要素数まで1ずつ増やす)
      if (workArray[k]がworkArray[minIndex]より小さい)
        minIndex ← k
      endif
    endfor
    workArray[j]とworkArray[minIndex]の値を入れ替える
    // 動作確認のために，jの値とworkArrayの全ての要素を出力する
    jの値を出力する
    workArrayの全ての要素を先頭から順にコンマ区切りで出力する
  endfor
  workArrayの全ての要素を先頭から順にコンマ区切りで出力する
```
ア 1, 2, 3, 4, 5
イ 1, 2, 3, 5, 4
ウ 4, 5, 3, 2, 1
エ 5, 4, 3, 2, 1', 'Thủ tục `sort` nhận qua đối số `numberArray` một mảng số nguyên có ít nhất hai phần tử, rồi xuất kết quả sau khi sắp xếp các phần tử theo thứ tự tăng dần. Để kiểm tra hoạt động của thủ tục, trong quá trình xử lý, chương trình xuất giá trị `j` và tất cả phần tử của `workArray`.
Cho `numberArray = {3, 5, 1, 2, 4}` và gọi `sort(numberArray)`. **Ngay sau khi giá trị j = 3 được xuất**, toàn bộ phần tử của `workArray` được xuất ra là phương án nào? Chỉ số phần tử của mảng bắt đầu từ **1**.
Mã giả, dịch phần mô tả thao tác sang tiếng Việt và giữ tên biến:
```text
sort(mảng số nguyên: numberArray)
  số nguyên: minIndex, j, k
  mảng số nguyên: workArray ← numberArray  // tạo bản sao mảng
  for (j từ 1 đến số phần tử của workArray − 1, tăng mỗi lần 1)
    // tìm chỉ số của một phần tử nhỏ nhất trong đoạn từ vị trí j đến cuối
    minIndex ← j
    for (k từ j + 1 đến số phần tử của workArray, tăng mỗi lần 1)
      if (workArray[k] nhỏ hơn workArray[minIndex])
        minIndex ← k
      endif
    endfor
    hoán đổi giá trị workArray[j] và workArray[minIndex]
    // xuất dữ liệu để kiểm tra hoạt động
    xuất giá trị j
    xuất tất cả phần tử workArray từ đầu, ngăn cách bằng dấu phẩy
  endfor
  xuất tất cả phần tử workArray từ đầu, ngăn cách bằng dấu phẩy
```
ア 1, 2, 3, 4, 5; イ 1, 2, 3, 5, 4; ウ 4, 5, 3, 2, 1; エ 5, 4, 3, 2, 1.', NULL, 'イ', 'Mảng đầu [3,5,1,2,4]. j=1 tìm min=1 rồi đổi chỗ → [1,5,3,2,4]; j=2 tìm min=2 → [1,2,3,5,4]; j=3 min=3 đã đúng vị trí → [1,2,3,5,4]. Chọn イ. Chưa được lấy kết quả sau vòng j=4 là [1,2,3,4,5].', '[{"term": "昇順", "reading": "しょうじゅん", "meaning": "thứ tự tăng dần"}, {"term": "要素番号", "reading": "ようそばんごう", "meaning": "chỉ số phần tử"}, {"term": "入れ替える", "reading": "いれかえる", "meaning": "hoán đổi"}]'::jsonb, 67);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 68, '問68 メールソフトが電子メールの送受信に用いるプロトコルの組合せとして,適切なものはどれか。
| 選択肢 | 送信プロトコル | 受信プロトコル |
|---|---|---|
| ア | IMAP4 | POP3 |
| イ | IMAP4 | SMTP |
| ウ | POP3 | SMTP |
| エ | SMTP | IMAP4 |', '', NULL, 'エ', 'エ: gửi dùng SMTP, nhận dùng IMAP4 trong tổ hợp đáp án của đề. POP3 cũng là giao thức nhận thư, nhưng phải khớp tổ hợp cụ thể của bảng. SMTP không phải giao thức để mail client đọc hộp thư.', '[{"term": "送信", "reading": "そうしん", "meaning": "gửi"}, {"term": "受信", "reading": "じゅしん", "meaning": "nhận"}, {"term": "組合せ", "reading": "くみあわせ", "meaning": "tổ hợp"}]'::jsonb, 68);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 69, '問69 関係データベースにおけるデータの正規化に関する次の記述中のa,bに入れる字句の適切な組合せはどれか。
正規化の主な目的として，データの重複を排除し，［a］ことが挙げられる。
正規化には複数の段階があり，これを進めていくと，［b］。
| 選択肢 | a | b |
|---|---|---|
| ア | 圧縮率を向上させる | 一つの表が複数の表に分割される |
| イ | 圧縮率を向上させる | 複数の表が一つの表に統合される |
| ウ | 一貫性を保つ | 一つの表が複数の表に分割される |
| エ | 一貫性を保つ | 複数の表が一つの表に統合される |', 'Chọn tổ hợp từ thích hợp để điền vào a và b trong mô tả về chuẩn hóa dữ liệu của cơ sở dữ liệu quan hệ.
Một mục đích chính của chuẩn hóa là loại bỏ dữ liệu trùng lặp để［a］. Chuẩn hóa có nhiều mức; khi tiếp tục thực hiện chuẩn hóa thì［b］.
| Lựa chọn | a | b |
|---|---|---|
| ア | Nâng cao tỷ lệ nén | Một bảng được chia thành nhiều bảng |
| イ | Nâng cao tỷ lệ nén | Nhiều bảng được hợp nhất thành một bảng |
| ウ | Giữ tính nhất quán | Một bảng được chia thành nhiều bảng |
| エ | Giữ tính nhất quán | Nhiều bảng được hợp nhất thành một bảng |', NULL, 'ウ', 'a = 一貫性を保つ (giữ nhất quán); b = một bảng được tách thành nhiều bảng, chọn ウ. Chuẩn hóa giảm dữ liệu trùng và bất thường cập nhật, không nhằm tăng tỷ lệ nén hay gom mọi bảng thành một.', '[{"term": "正規化", "reading": "せいきか", "meaning": "chuẩn hóa"}, {"term": "重複", "reading": "ちょうふく", "meaning": "trùng lặp"}, {"term": "一貫性", "reading": "いっかんせい", "meaning": "tính nhất quán"}]'::jsonb, 69);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 70, '問70 ISMSにおける情報セキュリティインシデントの管理に関する記述のうち,適切なものはどれか。
ア 情報セキュリティインシデントには臨機応変な対応が求められるので,あらかじめ対応手順を文書化しておくのではなく,実際の対応内容を記録する。
イ 情報セキュリティインシデントから得られた知識は,模倣を防ぐために情報セキュリティの管理策の強化には用いない。
ウ 情報セキュリティ事象は,その評価を待つことなく,報告された時点で情報セキュリテイインシデントに分類される。
エ 情報セキュリティ事象は,適切な管理者へ速やかに報告するために,あらかじめその連絡経路と仕組みを用意しておく。', 'Trong các mô tả về quản lý incident an toàn thông tin trong ISMS, mô tả nào phù hợp?
- ア: Incident an toàn thông tin cần ứng phó linh hoạt theo tình huống, nên thay vì lập văn bản quy trình ứng phó trước, chỉ ghi lại nội dung ứng phó thực tế.
- イ: Để ngăn bắt chước, kiến thức thu được từ incident an toàn thông tin không được dùng để tăng cường các biện pháp kiểm soát an toàn thông tin.
- ウ: Sự kiện an toàn thông tin được phân loại thành incident ngay khi được báo cáo, không chờ đánh giá.
- エ: Chuẩn bị trước kênh liên lạc và cơ chế để sự kiện an toàn thông tin được báo cáo nhanh đến người quản lý phù hợp.', NULL, 'エ', 'エ: chuẩn bị trước kênh liên lạc và cơ chế để báo cáo nhanh các sự kiện bảo mật cho người quản lý phù hợp. Cần quy trình trước sự cố, học từ sự cố để cải tiến và đánh giá sự kiện trước khi phân loại là incident.', '[{"term": "事象", "reading": "じしょう", "meaning": "sự kiện"}, {"term": "連絡経路", "reading": "れんらくけいろ", "meaning": "kênh liên lạc"}, {"term": "速やか", "reading": "すみやか", "meaning": "nhanh chóng"}]'::jsonb, 70);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 71, '問71 インターネットバンキングなどのWebサイトで利用されているリスクベース認証の例として,適切なものはどれか。
ア 利用者がいつもログインに使っているPCとは異なるPCからのログインであったので,本人しか知らない秘密の質問による追加の認証を行った。
イ 利用者がログインした後,画面操作が一定時間なかったので,自動的にログアウトして,再度ログインを求めた。
ウ 利用者がログインするときにパスワードを連続して複数回間違って入力したので,アカウントをロックした。
エ 利用者がログインに使っているパスワードが長期間変更されていなかったので,パスワードの変更を促した。', 'Trường hợp nào là ví dụ phù hợp về xác thực dựa trên rủi ro được sử dụng tại website như dịch vụ ngân hàng trực tuyến?
- ア: Vì người dùng đăng nhập từ PC khác với PC thường sử dụng, hệ thống xác thực bổ sung bằng câu hỏi bí mật mà chỉ chính người dùng biết.
- イ: Sau khi người dùng đăng nhập, không có thao tác màn hình trong một khoảng thời gian nhất định, nên hệ thống tự đăng xuất và yêu cầu đăng nhập lại.
- ウ: Vì người dùng nhập sai mật khẩu liên tiếp nhiều lần khi đăng nhập, hệ thống khóa tài khoản.
- エ: Vì mật khẩu đăng nhập chưa được đổi trong một thời gian dài, hệ thống nhắc người dùng đổi mật khẩu.', NULL, 'ア', 'ア: đăng nhập từ PC khác thường dùng làm tăng rủi ro, nên hệ thống yêu cầu xác thực thêm. Timeout, khóa sau nhiều lần sai mật khẩu và nhắc đổi mật khẩu là biện pháp khác; điểm cốt lõi là tăng mức kiểm tra theo tín hiệu rủi ro.', '[{"term": "本人", "reading": "ほんにん", "meaning": "chính người đó"}, {"term": "追加", "reading": "ついか", "meaning": "bổ sung"}, {"term": "認証", "reading": "にんしょう", "meaning": "xác thực"}]'::jsonb, 71);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 72, '問72 関係データベースで管理している“口座”表,“顧客”表及び“取引明細”表がある。新たな顧客が口座の開設と同時に1万円を入金するとき,表にデータを追加する順序として,適切なものはどれか。ここで,下線のうち実線は主キーを,破線は外部キーを表す。
**口座**
| 口座番号（主キー） | 口座種別 | 残高 | 顧客番号（外部キー） |
|---|---|---|---|
**顧客**
| 顧客番号（主キー） | 顧客名 |
|---|---|
**取引明細**
| 取引番号（主キー） | 取引日時 | 取引種別 | 取引金額 | 口座番号（外部キー） |
|---|---|---|---|---|
ア 口座 → 顧客 → 取引明細
イ 顧客 → 口座 → 取引明細
ウ 顧客 → 取引明細 → 口座
エ 取引明細 → 口座 → 顧客', 'Có các bảng “Tài khoản”, “Khách hàng” và “Chi tiết giao dịch” được quản lý bằng cơ sở dữ liệu quan hệ. Một khách hàng mới mở tài khoản và đồng thời nộp **10.000 yen**. Thứ tự nào phù hợp để thêm dữ liệu vào các bảng? Trong bảng gốc, gạch chân liền biểu thị khóa chính và gạch chân đứt biểu thị khóa ngoại.
- Tài khoản: số tài khoản (khóa chính), loại tài khoản, số dư, mã khách hàng (khóa ngoại).
- Khách hàng: mã khách hàng (khóa chính), tên khách hàng.
- Chi tiết giao dịch: mã giao dịch (khóa chính), thời điểm giao dịch, loại giao dịch, số tiền giao dịch, số tài khoản (khóa ngoại).
Các lựa chọn:
- ア: Tài khoản → Khách hàng → Chi tiết giao dịch.
- イ: Khách hàng → Tài khoản → Chi tiết giao dịch.
- ウ: Khách hàng → Chi tiết giao dịch → Tài khoản.
- エ: Chi tiết giao dịch → Tài khoản → Khách hàng.', NULL, 'イ', 'イ: 顧客 → 口座 → 取引明細. Tạo khách hàng trước để tài khoản tham chiếu được khách hàng; tạo tài khoản trước để chi tiết giao dịch tham chiếu được tài khoản. Đừng chọn thứ tự theo các dòng OCR bị đảo.', '[{"term": "口座", "reading": "こうざ", "meaning": "tài khoản ngân hàng"}, {"term": "顧客", "reading": "こきゃく", "meaning": "khách hàng"}, {"term": "取引明細", "reading": "とりひきめいさい", "meaning": "chi tiết giao dịch"}]'::jsonb, 72);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 73, '問73 OSS(Open Source Software)のライセンスにおけるコピーレフトに関する記述として,適切なものはどれか。
ア OSSの作成者が,ソフトウェアの著作権を放棄している。
イ OSSの著作権者は,利用者がソフトウェアを利用することに対して金銭的な対価を要求しなければならない。
ウ OSSの利用者が改変して作成した派生ソフトウェアは,改変部分のソースコードを非公開としたまま,配布することができる。
エ OSSの利用者が改変して作成した派生ソフトウェアを配布する場合には,元のOSSのライセンスと同じライセンスを適用しなければならない。', 'Mô tả nào phù hợp về copyleft trong giấy phép của phần mềm nguồn mở (OSS)?
- ア: Tác giả OSS từ bỏ quyền tác giả đối với phần mềm.
- イ: Chủ thể quyền tác giả của OSS phải yêu cầu người dùng trả tiền cho việc sử dụng phần mềm.
- ウ: Có thể phân phối phần mềm phái sinh mà người dùng tạo bằng cách sửa OSS, trong khi vẫn không công khai mã nguồn phần đã sửa.
- エ: Khi phân phối phần mềm phái sinh được tạo bằng cách sửa OSS, phải áp dụng cùng giấy phép với OSS ban đầu.', NULL, 'エ', 'エ: khi phân phối phần mềm phái sinh đã sửa đổi từ OSS thuộc loại giấy phép này, phải áp dụng giấy phép cùng loại theo điều kiện của nó. Copyleft không có nghĩa tác giả từ bỏ bản quyền hoặc bắt buộc thu tiền. Không được khái quát quy tắc copyleft cho mọi giấy phép OSS.', '[{"term": "改変", "reading": "かいへん", "meaning": "sửa đổi"}, {"term": "派生", "reading": "はせい", "meaning": "phái sinh"}, {"term": "配布", "reading": "はいふ", "meaning": "phân phối"}]'::jsonb, 73);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 74, '問74 表計算ソフトを用いて，二つの2進数α，βの和を求める。α，βの桁数は2桁に限定し，2の位，1の位の順に各桁の値がセルB3，セルC3とセルB4，セルC4に入力されている。ワークシートは2進数α＝10，β＝11の例である。結果は，4の位，2の位，1の位の順にセルA5，セルB5，セルC5に表示したい。セルB2は1の位からの繰り上がりの情報を格納するために用いられ，式 IF(C3＋C4＝2, 1, 0) が入力されている。セルB5に入力する式はどれか。
| 行 | A | B | C | D |
|---|---|---|---|---|
| 1 | 4の位 | 2の位 | 1の位 | |
| 2 | | 0 | | ：1の位からの繰上げ |
| 3 | | 1 | 0 | ：2進数αの値 |
| 4 | | 1 | 1 | ：2進数βの値 |
| 5 | 1 | 0 | 1 | ：結果の表示 |
ア `IF(合計(B2:B4)＜2, 合計(B2:B4), IF(合計(B2:B4)＝2, 0, 1))`
イ `IF(合計(B2:B4)＜2, 合計(B2:B4), IF(合計(B2:B4)＝2, 1, 0))`
ウ `IF(合計(B2:B4)＞2, 合計(B2:B4), IF(合計(B2:B4)＝2, 0, 1))`
エ `IF(合計(B2:B4)＞2, 合計(B2:B4), IF(合計(B2:B4)＝2, 1, 0))`', 'Dùng phần mềm bảng tính để tính tổng hai số nhị phân α và β. Mỗi số chỉ có **hai chữ số**. Theo thứ tự hàng có trọng số 2 rồi hàng có trọng số 1, các bit của α được nhập vào B3, C3; các bit của β vào B4, C4. Bảng minh họa trường hợp α = 10₂ và β = 11₂.
Muốn hiển thị kết quả theo thứ tự hàng trọng số 4, 2, 1 tại A5, B5, C5. Ô B2 lưu bit nhớ từ hàng trọng số 1; ô này có công thức `IF(C3+C4=2, 1, 0)`. **Cần nhập công thức nào vào B5?**
| Hàng | A | B | C | Ghi chú |
|---|---|---|---|---|
| 1 | Hàng 4 | Hàng 2 | Hàng 1 | |
| 2 | | 0 | | Bit nhớ từ hàng 1 |
| 3 | | 1 | 0 | Số nhị phân α |
| 4 | | 1 | 1 | Số nhị phân β |
| 5 | 1 | 0 | 1 | Hiển thị kết quả |
Trong các lựa chọn, `SUM` dưới đây dịch hàm `合計` của đề là hàm tính tổng:
- ア: `IF(SUM(B2:B4)<2, SUM(B2:B4), IF(SUM(B2:B4)=2, 0, 1))`.
- イ: `IF(SUM(B2:B4)<2, SUM(B2:B4), IF(SUM(B2:B4)=2, 1, 0))`.
- ウ: `IF(SUM(B2:B4)>2, SUM(B2:B4), IF(SUM(B2:B4)=2, 0, 1))`.
- エ: `IF(SUM(B2:B4)>2, SUM(B2:B4), IF(SUM(B2:B4)=2, 1, 0))`.', NULL, 'ア', 'Đặt S = tổng B2:B4 (bit nhớ + hai bit hàng 2). Bit kết quả tại B5 là S mod 2: S=0→0, 1→1, 2→0, 3→1. ア có dạng IF(S<2,S,IF(S=2,0,1)), đúng cả bốn trường hợp. Ví dụ 10₂ + 11₂ = 101₂.', '[{"term": "繰り上がり", "reading": "くりあがり", "meaning": "nhớ khi cộng"}, {"term": "桁", "reading": "けた", "meaning": "chữ số/hàng số"}, {"term": "合計", "reading": "ごうけい", "meaning": "tổng"}]'::jsonb, 74);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 75, '問75 電子メールの宛先入力におけるBcc欄に関する記述のうち,適切なものはどれか。
ア Bcc欄に入力したメールアドレスには,To欄やCc欄に入力したメールアドレスは通知されない。
イ Bcc欄に入力したメールアドレスには,自動的に暗号化された電子メールが送信される。
ウ Bcc欄に入力したメールアドレスには,添付ファイルが削除された電子メールが送信される。
エ To欄やCc欄に入力したメールアドレスには,Bcc欄に入力したメールアドレスは通知されない。', '', NULL, 'エ', 'エ: địa chỉ trong Bcc không được thông báo cho người nhận trong To hoặc Cc. Bcc không tự mã hóa thư, không xóa file đính kèm và không che To/Cc với người nhận Bcc.', '[{"term": "宛先", "reading": "あてさき", "meaning": "người/địa chỉ nhận"}, {"term": "欄", "reading": "らん", "meaning": "ô/mục"}, {"term": "添付ファイル", "reading": "てんぷファイル", "meaning": "tệp đính kèm"}]'::jsonb, 75);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 76, '問76 IoTデバイスで用いられるLPWAに関する次の記述中のa,bに入れる字句の適切な組合せはどれか。
LPWAに分類される無線通信方式の特徴は，通信可能な範囲が無線LANに比べて［a］，消費する電力が第4世代移動通信規格（4G）に比べて［b］。
| 選択肢 | a | b |
|---|---|---|
| ア | 狭く | 多い |
| イ | 狭く | 少ない |
| ウ | 広く | 多い |
| エ | 広く | 少ない |', '', NULL, 'エ', 'LPWA = Low Power Wide Area: phạm vi rộng hơn WLAN, điện năng tiêu thụ ít hơn 4G trong mô tả đề. エ = 広い/少ない. Phù hợp cảm biến IoT truyền ít dữ liệu, không phải tối đa hóa tốc độ.', '[{"term": "範囲", "reading": "はんい", "meaning": "phạm vi"}, {"term": "消費", "reading": "しょうひ", "meaning": "tiêu thụ"}, {"term": "電力", "reading": "でんりょく", "meaning": "điện năng"}]'::jsonb, 76);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 77, '問77 ある企業では,サーバ室への入室管理を暗証番号で行っていたが,虹彩認証装置による本人確認を加えることによって,無許可の者の入室をより確実に防止する対策とした。これは,サーバ室における情報セキュリティ要素のうち,どれを高める対策に該当するか。
ア 可用性
イ 完全性
ウ 機密性
エ 否認防止', 'Một doanh nghiệp trước đây quản lý việc vào phòng máy chủ bằng mã PIN. Để ngăn người không được phép vào phòng một cách chắc chắn hơn, doanh nghiệp bổ sung việc xác minh danh tính bằng thiết bị nhận dạng mống mắt. Biện pháp này nâng cao yếu tố an toàn thông tin nào của phòng máy chủ?
ア Tính sẵn sàng; イ Tính toàn vẹn; ウ Tính bí mật; エ Chống chối bỏ.', NULL, 'ウ', 'Thêm xác thực mống mắt để ngăn người không được phép vào phòng server làm tăng 機密性 (confidentiality), chọn ウ. 可用性 là sẵn sàng; 完全性 là toàn vẹn; 否認防止 là chống chối bỏ.', '[{"term": "虹彩", "reading": "こうさい", "meaning": "mống mắt"}, {"term": "機密性", "reading": "きみつせい", "meaning": "tính bí mật"}, {"term": "無許可", "reading": "むきょか", "meaning": "không được cho phép"}]'::jsonb, 77);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 78, '問78 IoTデバイスとIoTサーバで構成され,IoTデバイスが計測した外気温をIoTサーバへ送り,IoTサーバからの指示でIoTデバイスが窓を開閉するシステムがある。このシステムのIoTデバイスに搭載された,外気温を電気信号に変換する役割をもつものはどれか。
ア アクチュエーター
イ エッジコンピューティング
ウ キャリアアグリゲーション
エ センサー', 'Có một hệ thống gồm thiết bị IoT và máy chủ IoT. Thiết bị đo nhiệt độ bên ngoài rồi gửi đến máy chủ; thiết bị cũng đóng/mở cửa sổ theo chỉ thị từ máy chủ. Trong hệ thống này, thành phần được lắp trên thiết bị IoT và có vai trò **chuyển nhiệt độ bên ngoài thành tín hiệu điện** là thành phần nào?
ア Bộ chấp hành (actuator); イ Điện toán biên; ウ Gộp băng tần (carrier aggregation); エ Cảm biến (sensor).', NULL, 'エ', 'エ: sensor biến đại lượng vật lý như nhiệt độ thành tín hiệu điện. Actuator chuyển lệnh/tín hiệu thành hành động vật lý như mở cửa sổ. Edge computing là xử lý gần nguồn dữ liệu; carrier aggregation gộp băng tần.', '[{"term": "外気温", "reading": "がいきおん", "meaning": "nhiệt độ ngoài trời"}, {"term": "電気信号", "reading": "でんきしんごう", "meaning": "tín hiệu điện"}, {"term": "開閉", "reading": "かいへい", "meaning": "đóng mở"}]'::jsonb, 78);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 79, '問79 企業のリスクマネジメントの一環として行われるサイバーセキュリティリスク対策の推進において,経営者に求められる役割として,最も適切なものはどれか。
ア IT部門のセキュリティ担当者に,部門ごとのサイバーセキュリティリスク対応方針の策定と実行を全て任せる。
イ サイバーセキュリティ対策を実施する上での責任者となるCISOを任命し,実行や判断を全て任せる。
ウ 実施方針の検討,予算や人材の割当て,実施状況の確認や問題の把握と対応を通じて自らリーダーシップを発揮する。
エ 専門家である外部の経営コンサルタントに,自社の組織や事業におけるリスクの分析と対策の推進に関する権限と責任を委譲する。', 'Khi thúc đẩy các đối sách rủi ro an ninh mạng như một phần của quản lý rủi ro doanh nghiệp, vai trò nào phù hợp nhất mà người điều hành doanh nghiệp cần thực hiện?
- ア: Giao toàn bộ việc xây dựng và thực hiện chính sách ứng phó rủi ro an ninh mạng của từng bộ phận cho nhân viên bảo mật thuộc bộ phận IT.
- イ: Bổ nhiệm CISO làm người chịu trách nhiệm thực hiện các đối sách an ninh mạng, rồi giao toàn bộ việc thực hiện và phán đoán cho người đó.
- ウ: Tự thể hiện vai trò lãnh đạo qua việc xem xét chính sách thực hiện, phân bổ ngân sách và nhân lực, kiểm tra tình hình thực hiện, nắm bắt vấn đề và ứng phó.
- エ: Chuyển giao cho chuyên gia tư vấn quản trị bên ngoài thẩm quyền và trách nhiệm phân tích rủi ro, thúc đẩy đối sách đối với tổ chức và hoạt động kinh doanh của mình.', NULL, 'ウ', 'ウ: lãnh đạo tự định hướng, phân bổ ngân sách/nhân lực, kiểm tra tiến độ, hiểu vấn đề và chỉ đạo ứng phó. Có thể bổ nhiệm CISO và dùng chuyên gia nhưng không chuyển toàn bộ trách nhiệm và quyết định cho họ.', '[{"term": "予算", "reading": "よさん", "meaning": "ngân sách"}, {"term": "任命", "reading": "にんめい", "meaning": "bổ nhiệm"}, {"term": "把握", "reading": "はあく", "meaning": "nắm bắt"}]'::jsonb, 79);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 80, '問80 バイオメトリクス認証に関する次の記述中のa,bに入れる字句の適切な組合せはどれか。
バイオメトリクス認証を利用したシステムの設計を始めるときには，システムの目的と認証の用途を明らかにし，認証精度の設定方針を策定することが必要である。
他人受入率が［a］なるように設定した場合は，安全性を重視した認証になり，本人拒否率が［b］なるように設定した場合は，本人の利便性を重視した認証になるといえる。
| 選択肢 | a | b |
|---|---|---|
| ア | 高く | 高く |
| イ | 高く | 低く |
| ウ | 低く | 高く |
| エ | 低く | 低く |', 'Chọn tổ hợp từ thích hợp để điền vào a và b trong mô tả về xác thực sinh trắc học sau đây.
Khi bắt đầu thiết kế hệ thống xác thực sinh trắc học, cần làm rõ mục đích của hệ thống và mục đích sử dụng xác thực, đồng thời xây dựng chính sách thiết lập độ chính xác xác thực. Nếu đặt tỷ lệ chấp nhận nhầm người khác ở mức［a］thì xác thực chú trọng an toàn. Nếu đặt tỷ lệ từ chối nhầm chính người cần xác thực ở mức［b］thì xác thực chú trọng sự thuận tiện cho người đó.
| Lựa chọn | a | b |
|---|---|---|
| ア | Cao | Cao |
| イ | Cao | Thấp |
| ウ | Thấp | Cao |
| エ | Thấp | Thấp |', NULL, 'エ', 'FAR (nhận nhầm người khác) thấp → chú trọng an toàn. FRR (từ chối nhầm chủ thể thật) thấp → chú trọng tiện lợi. Cả hai chỗ điền là 低く, chọn エ. Thắt ngưỡng thường giảm FAR nhưng tăng FRR nên cần cân đối theo mục đích.', '[{"term": "他人受入率", "reading": "たにんうけいれりつ", "meaning": "tỷ lệ chấp nhận nhầm người khác"}, {"term": "本人拒否率", "reading": "ほんにんきょひりつ", "meaning": "tỷ lệ từ chối nhầm người thật"}, {"term": "利便性", "reading": "りべんせい", "meaning": "tính tiện lợi"}]'::jsonb, 80);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 81, '問81 Bluetoothの規格に含まれ,デバイス間の省電力通信を実現させるものはどれか。
ア BLE
イ LPWA
ウ LTE
エ PLC', '', NULL, 'ア', 'BLE = Bluetooth Low Energy, chọn ア. LPWA là nhóm mạng công suất thấp phạm vi rộng; LTE là công nghệ di động; PLC truyền thông qua đường dây điện.', '[{"term": "省電力", "reading": "しょうでんりょく", "meaning": "tiết kiệm điện"}, {"term": "規格", "reading": "きかく", "meaning": "tiêu chuẩn"}, {"term": "通信", "reading": "つうしん", "meaning": "truyền thông"}]'::jsonb, 81);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 82, '問82 ニューラルネットワークの学習に用いられるバックプロパゲーションで行われていることはどれか。
ア 各ノードの重みを調整して,誤差を小さくする。
イ 各ノードの重みを調整して,最適な活性化関数を選択する。
ウ ノードの数を変更して,誤差を小さくする。
エ ノードの数を変更して,処理速度を高める。', '', NULL, 'ア', 'ア: lan truyền sai số ngược để tính hướng điều chỉnh trọng số, qua đó giảm sai số. Không phải thay số node, chọn hàm kích hoạt tối ưu hay tăng tốc bằng giảm node. Nhớ “học → chỉnh trọng số”.', '[{"term": "重み", "reading": "おもみ", "meaning": "trọng số"}, {"term": "誤差", "reading": "ごさ", "meaning": "sai số"}, {"term": "調整", "reading": "ちょうせい", "meaning": "điều chỉnh"}]'::jsonb, 82);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 83, '問83 職場のPCに適用する情報セキュリティ対策a~cのうち,マルウェア対策ソフトの導入のほかに,マルウェア感染を防止するための対策として,適切なものだけを全て挙げたものはどれか。
a OSのセキュリティパッチ(修正モジュール)の適用
b 起動ドライブとなっているハードディスクに対するパスワード設定
c 複雑かつ十分な長さをもつログインパスワードの導入
ア a
イ a, b
ウ b
エ c', '', NULL, 'ア', 'Chỉ a: áp dụng security patch của OS để vá lỗ hổng mà malware có thể khai thác, ア. Mật khẩu ổ khởi động và mật khẩu đăng nhập mạnh chủ yếu chống truy cập trái phép; không thay thế việc vá lỗi để ngăn nhiễm trong câu hỏi.', '[{"term": "感染", "reading": "かんせん", "meaning": "nhiễm"}, {"term": "適用", "reading": "てきよう", "meaning": "áp dụng"}, {"term": "修正", "reading": "しゅうせい", "meaning": "sửa chữa"}]'::jsonb, 83);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 84, '問84 ある推論システムは，演繹推論，帰納推論，仮説形成などの推論が実行できる。この推論システムへの入力と得られた出力に関する記述のうち，演繹推論を実行した例として，適切なものはどれか。
ア “HDDとSSDは記憶装置である”と入力した後に，“HDDの台数を増やすと記憶容量が増える”と入力した。出力は，“SSDの台数を増やすと記憶容量が増える”となった。
イ “HDDは台数を増やすと記憶容量が増える”と入力した後に，“記憶装置は台数を増やすと記憶容量が増える”と入力した。出力は，“HDDは記憶装置である”となった。
ウ “記憶装置であるHDDは記憶容量をもつ”と入力し，同時に“記憶装置であるSSDは記憶容量をもつ”と入力した。出力は，“全ての記憶装置は記憶容量をもつ”となった。
エ “全ての記憶装置は記憶容量をもつ”と入力した後に，“HDDは記憶装置である”と入力した。出力は，“HDDは記憶容量をもつ”となった。', 'Một hệ thống suy luận có thể thực hiện suy luận diễn dịch, suy luận quy nạp, hình thành giả thuyết, v.v. Trong các mô tả về dữ liệu nhập vào và kết quả nhận được sau đây, ví dụ nào phù hợp với việc thực hiện **suy luận diễn dịch**?
- ア: Nhập “HDD và SSD là thiết bị lưu trữ”, rồi nhập “Tăng số lượng HDD thì dung lượng lưu trữ tăng”. Kết quả: “Tăng số lượng SSD thì dung lượng lưu trữ tăng”.
- イ: Nhập “Tăng số lượng HDD thì dung lượng lưu trữ tăng”, rồi nhập “Tăng số lượng thiết bị lưu trữ thì dung lượng lưu trữ tăng”. Kết quả: “HDD là thiết bị lưu trữ”.
- ウ: Nhập “HDD, là thiết bị lưu trữ, có dung lượng lưu trữ” và đồng thời nhập “SSD, là thiết bị lưu trữ, có dung lượng lưu trữ”. Kết quả: “Tất cả thiết bị lưu trữ đều có dung lượng lưu trữ”.
- エ: Nhập “Tất cả thiết bị lưu trữ đều có dung lượng lưu trữ”, rồi nhập “HDD là thiết bị lưu trữ”. Kết quả: “HDD có dung lượng lưu trữ”.', NULL, 'エ', 'エ: “mọi thiết bị lưu trữ có dung lượng” + “HDD là thiết bị lưu trữ” → “HDD có dung lượng”. Đây là suy từ quy tắc chung xuống trường hợp riêng. ウ đi từ vài ví dụ tới quy tắc chung là quy nạp; suy ngược từ kết quả để đặt giả thuyết không phải suy diễn chắc chắn.', '[{"term": "演繹推論", "reading": "えんえきすいろん", "meaning": "suy luận diễn dịch"}, {"term": "帰納推論", "reading": "きのうすいろん", "meaning": "suy luận quy nạp"}, {"term": "仮説形成", "reading": "かせつけいせい", "meaning": "hình thành giả thuyết"}]'::jsonb, 84);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 85, '問85 関数isPrimeは,引数として与えられた正の整数が,素数であればtrueを,素数でなければfalseを戻り値とする。例えば,関数isPrimeをisPrime(2)として呼び出したときの戻り値はtrueである。プログラム中のa,bに入れる字句の適切な組合せはどれか。
〔プログラム〕
```text
○論理型: isPrime(整数型: num)
  整数型: div ← 2
  if (numが2［a］)
    return false
  else
    while (numがdiv［b］)
      if (num ÷ div の余りが0と等しい)
        return false
      else
        div ← div ＋ 1
      endif
    endwhile
    return true
  endif
```
| 選択肢 | a | b |
|---|---|---|
| ア | 以下 | と等しい |
| イ | 以下 | より大きい |
| ウ | より小さい | と等しい |
| エ | より小さい | より大きい |', 'Hàm `isPrime` nhận một số nguyên dương qua đối số. Nếu số đó là số nguyên tố thì trả về `true`; nếu không thì trả về `false`. Ví dụ, giá trị trả về khi gọi `isPrime(2)` là `true`. Chọn tổ hợp từ thích hợp để điền vào a và b trong chương trình.
Mã giả dịch phần thao tác, giữ tên biến và các ô trống:
```text
hàm logic isPrime(số nguyên: num)
  số nguyên: div ← 2
  if (num［a］2)
    return false
  else
    while (num［b］div)
      if (số dư của phép chia num ÷ div bằng 0)
        return false
      else
        div ← div + 1
      endif
    endwhile
    return true
  endif
```
Trong bản dịch,［a］và［b］là quan hệ so sánh của `num` với số ở phía sau:
| Lựa chọn | a | b |
|---|---|---|
| ア | Nhỏ hơn hoặc bằng | Bằng |
| イ | Nhỏ hơn hoặc bằng | Lớn hơn |
| ウ | Nhỏ hơn | Bằng |
| エ | Nhỏ hơn | Lớn hơn |', NULL, 'エ', 'a = より小さい: nếu num < 2 trả false; không dùng ≤2 vì 2 là số nguyên tố. b = より大きい: lặp khi num > div, tức chỉ thử ước từ 2 đến num−1. Nếu thử cả div=num thì số nào cũng chia hết cho chính nó và bị báo không phải nguyên tố. エ đúng.', '[{"term": "素数", "reading": "そすう", "meaning": "số nguyên tố"}, {"term": "引数", "reading": "ひきすう", "meaning": "tham số/đối số"}, {"term": "戻り値", "reading": "もどりち", "meaning": "giá trị trả về"}]'::jsonb, 85);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 86, '問86 データベースの障害に備えて,毎日業務終了後にバックアップファイルを取得している。毎週土曜日にはフルバックアップファイルを取得し,日曜日から金曜日は差分バックアップファイルを取得する。差分バックアップファイルとは,最後のフルバックアップファイルから,差分バックアップファイルを取得する当日までの,全ての差分データのバックアップファイルである。水曜日にデータベースが破損したので,前日の火曜日の業務終了時点のデータベースに復旧することにした。このとき,データベースを復旧させるために最低限必要なバックアップファイルはどれか。
ア 日曜日,月曜日及び火曜日の差分バックアップファイル
イ 火曜日の差分バックアップファイル
ウ 土曜日のフルバックアップファイルと,日曜日,月曜日及び火曜日の差分バックアップファイル
エ 土曜日のフルバックアップファイルと,火曜日の差分バックアップファイル', 'Để đề phòng sự cố cơ sở dữ liệu, mỗi ngày sau khi kết thúc công việc đều lấy một tệp backup. Mỗi thứ Bảy lấy bản **full backup**; từ Chủ nhật đến thứ Sáu lấy bản **differential backup**. Differential backup chứa **tất cả dữ liệu thay đổi kể từ bản full backup gần nhất cho đến ngày lấy bản differential đó**.
Vào thứ Tư, cơ sở dữ liệu bị hỏng, nên quyết định khôi phục về trạng thái khi kết thúc công việc ngày thứ Ba hôm trước. Những tệp backup nào là tối thiểu cần có để khôi phục?
- ア: Các bản differential của Chủ nhật, thứ Hai và thứ Ba.
- イ: Bản differential của thứ Ba.
- ウ: Bản full của thứ Bảy và các bản differential của Chủ nhật, thứ Hai, thứ Ba.
- エ: Bản full của thứ Bảy và bản differential của thứ Ba.', NULL, 'エ', 'エ: bản full ngày thứ Bảy + bản differential ngày thứ Ba. Differential chứa tất cả thay đổi kể từ bản full gần nhất, nên không cần differential Chủ nhật và thứ Hai. Nếu là incremental mới cần chuỗi các bản tăng dần.', '[{"term": "差分", "reading": "さぶん", "meaning": "phần chênh lệch"}, {"term": "破損", "reading": "はそん", "meaning": "hư hỏng"}, {"term": "最低限", "reading": "さいていげん", "meaning": "tối thiểu"}]'::jsonb, 86);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 87, '問87 NASの説明として,適切なものはどれか。
ア PCやスマートフォンなどからネットワーク経由で利用できるように,ネットワークに直接接続して使用する外部記憶装置
イ 記憶媒体上のデータの位置や書込み順序に関係なく,求めるデータに直接アクセスできるファイル形式
ウ 複数の記憶装置を1台の装置として管理し,データを分散して格納することによってアクセスの高速化や耐障害性の向上を図る技術
エ 無線LANのネットワークを識別するために用いられる文字列', '', NULL, 'ア', 'ア: thiết bị lưu trữ kết nối trực tiếp vào mạng để PC/smartphone truy cập qua mạng. ウ mô tả RAID; エ là SSID; イ nói đến cách truy cập dữ liệu chứ không mô tả NAS.', '[{"term": "記憶装置", "reading": "きおくそうち", "meaning": "thiết bị lưu trữ"}, {"term": "耐障害性", "reading": "たいしょうがいせい", "meaning": "khả năng chịu lỗi"}, {"term": "識別", "reading": "しきべつ", "meaning": "nhận diện"}]'::jsonb, 87);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 88, '問88 プログラミングすることによって,ペンの上げ下げ,直進及び右回りの方向転換が可能なロボットがある。このロボットに1辺が1mの正六角形を描画させるプログラムを作成した。次の正六角形描画プログラムのa,bに入れる字句の適切な組合せはどれか。
〔正六角形描画プログラム〕
```text
(1) ペンを下ろす。
(2) 処理回数のカウンタに［a］を設定する。
(3) 次の処理を順に実行する。
    ・1m直進する。
    ・右回りに［b］度方向転換する。
    ・処理回数のカウンタに1を加える。
(4) 処理回数のカウンタが6未満の場合は，(3)に戻る。
(5) ペンを上げる。
```
| 選択肢 | a | b |
|---|---:|---:|
| ア | 0 | 60 |
| イ | 0 | 120 |
| ウ | 1 | 60 |
| エ | 1 | 120 |', 'Có một robot mà thông qua lập trình có thể nâng/hạ bút, đi thẳng và quay theo chiều phải. Người ta tạo chương trình để robot vẽ một hình lục giác đều có cạnh dài 1 m. Chọn tổ hợp thích hợp để điền vào a và b trong chương trình vẽ lục giác đều dưới đây.
```text
(1) Hạ bút xuống.
(2) Đặt bộ đếm số lần xử lý bằng［a］.
(3) Thực hiện lần lượt các thao tác sau:
    ・Đi thẳng 1 m.
    ・Quay sang phải［b］độ.
    ・Cộng 1 vào bộ đếm số lần xử lý.
(4) Nếu bộ đếm nhỏ hơn 6 thì quay lại bước (3).
(5) Nâng bút lên.
```
| Lựa chọn | a | b |
|---|---:|---:|
| ア | 0 | 60 |
| イ | 0 | 120 |
| ウ | 1 | 60 |
| エ | 1 | 120 |', NULL, 'ア', 'Khởi tạo counter=0, mỗi vòng tăng 1; khi counter chưa đạt 6 thì lặp, tổng 6 cạnh. Sau mỗi cạnh quay góc ngoài 360/6 = 60°, không phải góc trong 120°. ア = 0,60.', '[{"term": "正六角形", "reading": "せいろっかくけい", "meaning": "lục giác đều"}, {"term": "描画", "reading": "びょうが", "meaning": "vẽ"}, {"term": "未満", "reading": "みまん", "meaning": "nhỏ hơn (không gồm mốc)"}]'::jsonb, 88);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 89, '問89 情報セキュリティに関する次の記述中のa，bに入れる字句の適切な組合せはどれか。
守るべき情報資産に対して望ましくない影響を及ぼす可能性のある原因のことを［a］といい，情報資産自身の価値を損なう可能性をもつ弱点のことを［b］という。
| 選択肢 | a | b |
|---|---|---|
| ア | インシデント | リスク |
| イ | 脅威 | 脆弱性 |
| ウ | 脆弱性 | インシデント |
| エ | リスク | 脅威 |', '', NULL, 'イ', 'a = 脅威 (nguồn có thể gây tác động xấu); b = 脆弱性 (điểm yếu của tài sản/kiểm soát), chọn イ. Risk là rủi ro gắn với khả năng và hậu quả; incident là sự cố đã được xác định, khác với nguồn đe dọa hoặc điểm yếu.', '[{"term": "脅威", "reading": "きょうい", "meaning": "mối đe dọa"}, {"term": "脆弱性", "reading": "ぜいじゃくせい", "meaning": "điểm yếu/lỗ hổng"}, {"term": "情報資産", "reading": "じょうほうしさん", "meaning": "tài sản thông tin"}]'::jsonb, 89);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 90, '問90 PKI(公開鍵基盤)の特徴として,適切なものはどれか。
ア 共通鍵の所有者を確認する方法が提供されている。
イ 知人が署名した鍵は信頼するという“信頼の輪”によって,公開鍵が正当であることを確認する。
ウ 電子証明書の正当性を認証局が保証する。
エ 秘密鍵を安全に公開する方法が提供されている。', '', NULL, 'ウ', 'ウ: CA (cơ quan chứng thực) bảo đảm tính hợp lệ của chứng thư số theo cơ chế PKI. Chứng thư liên kết danh tính với khóa công khai. “Web of trust” là mô hình khác; khóa bí mật không được công khai.', '[{"term": "公開鍵基盤", "reading": "こうかいかぎきばん", "meaning": "hạ tầng khóa công khai"}, {"term": "認証局", "reading": "にんしょうきょく", "meaning": "cơ quan chứng thực"}, {"term": "電子証明書", "reading": "でんししょうめいしょ", "meaning": "chứng thư số"}]'::jsonb, 90);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 91, '問91 デジタル署名やブロックチェーンで用いられるハッシュ関数には,SHA-256,SHA-512などがある。このようなハッシュ関数に関する記述として,適切なものはどれか。
ア あるハッシュ関数を用いて得たハッシュ値を,そのハッシュ関数に入力することによって,元のデータを復元することができる。
イ 同じデータを異なるハッシュ関数にそれぞれ入力したとき,得られるハッシュ値は全て同じになる。
ウ 同じハッシュ関数を用いる場合,入力したデータが同じであれば,得られるハッシュ値は常に同じになる。
エ どのハッシュ関数にもそれぞれの逆関数が存在し,ハッシュ値から元のデータを復元することができる。', 'Các hàm băm dùng trong chữ ký số và blockchain gồm SHA-256, SHA-512, v.v. Mô tả nào phù hợp về các hàm băm này?
- ア: Có thể khôi phục dữ liệu ban đầu bằng cách đưa giá trị băm đã nhận được vào chính hàm băm đó.
- イ: Khi đưa cùng dữ liệu vào các hàm băm khác nhau, tất cả giá trị băm thu được đều giống nhau.
- ウ: Khi sử dụng cùng một hàm băm, nếu dữ liệu đầu vào giống nhau thì giá trị băm nhận được luôn giống nhau.
- エ: Mỗi hàm băm đều có hàm nghịch đảo, cho phép khôi phục dữ liệu ban đầu từ giá trị băm.', NULL, 'ウ', 'ウ: cùng dữ liệu đầu vào và cùng hàm băm thì luôn cho cùng hash. Không thể lấy hash đưa lại vào hàm để phục hồi dữ liệu gốc; hàm hash mật mã không có phép nghịch đảo phục hồi duy nhất. Hàm khác nhau không buộc cho hash giống nhau.', '[{"term": "ハッシュ値", "reading": "ハッシュち", "meaning": "giá trị băm"}, {"term": "復元", "reading": "ふくげん", "meaning": "khôi phục"}, {"term": "逆関数", "reading": "ぎゃくかんすう", "meaning": "hàm nghịch đảo"}]'::jsonb, 91);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 92, '問92 ゼロトラストセキュリティの考え方に基づいた情報セキュリティ対策の例として,適切なものはどれか。
ア インターネットと内部ネットワークの境界にファイアウォールを配置し,インターネットからの脅威を境界で遮断する。
イ 内部ネットワークからであっても外部ネットワークからであっても,ネットワーク上の情報資源へのアクセスには二要素認証を利用する。
ウ 内部ネットワークに接続するPCにインストールされたソフトウェアに脆弱性が発見されたときに,そのセキュリティパッチは公開後直ちに適用する。
エ 内部ネットワークに接続するPCのうち,インターネットにアクセスするPCだけにマルウェア対策ソフトをインストールする。', 'Biện pháp nào là ví dụ phù hợp về đối sách an toàn thông tin dựa trên tư tưởng zero trust?
- ア: Đặt firewall ở ranh giới giữa Internet và mạng nội bộ, chặn mối đe dọa từ Internet tại ranh giới đó.
- イ: Dù truy cập từ mạng nội bộ hay mạng bên ngoài, đều dùng xác thực hai yếu tố khi truy cập tài nguyên thông tin trên mạng.
- ウ: Khi phát hiện lỗ hổng trong phần mềm cài trên PC nối mạng nội bộ, áp dụng bản vá bảo mật ngay sau khi được công bố.
- エ: Trong các PC nối mạng nội bộ, chỉ cài phần mềm chống malware trên những PC có truy cập Internet.', NULL, 'イ', 'イ: truy cập tài nguyên từ mạng nội bộ hay bên ngoài đều cần xác thực hai yếu tố theo ví dụ đề. Không mặc nhiên tin chỉ vì ở bên trong mạng. Firewall biên hay vá lỗi là biện pháp hữu ích nhưng chưa thể hiện điểm phân biệt này.', '[{"term": "二要素認証", "reading": "にようそにんしょう", "meaning": "xác thực hai yếu tố"}, {"term": "境界", "reading": "きょうかい", "meaning": "ranh giới"}, {"term": "遮断", "reading": "しゃだん", "meaning": "chặn/ngắt"}]'::jsonb, 92);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 93, '問93 次のISMSにおける実施項目のうち,最初に行うものはどれか。
ア ISMSの適用範囲の決定
イ 情報セキュリティリスクアセスメント
ウ 情報セキュリティリスク対応
エ 内部監査', '', NULL, 'ア', 'ア: quyết định phạm vi áp dụng ISMS trước. Sau khi biết tài sản/bộ phận/phạm vi nào thuộc hệ thống quản lý mới đánh giá rủi ro, chọn cách xử lý, rồi kiểm toán. Tránh bắt đầu đánh giá khi chưa biết đối tượng và ranh giới.', '[{"term": "適用範囲", "reading": "てきようはんい", "meaning": "phạm vi áp dụng"}, {"term": "決定", "reading": "けってい", "meaning": "quyết định"}, {"term": "内部監査", "reading": "ないぶかんさ", "meaning": "kiểm toán nội bộ"}]'::jsonb, 93);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 94, '問94 情報セキュリティ対策を,“技術的セキュリティ対策”,“人的セキュリティ対策”及び“物理的セキュリティ対策”に分類したとき,“物理的セキュリティ対策”の例として,適切なものはどれか。
ア 機密情報の取扱いに関して,罰則を含めた規則を制定し,これを遵守させるために,関係者に定期的な教育を実施する。
イ 被災によるシステム障害が発生してもサービスを継続できるように,遠隔地にバックアップシステムを用意する。
ウ ますます方法が巧妙化されるサイバー攻撃による被害を防ぐために,サイバー攻撃の方法や対策に関する情報を従業員に周知する。
エ マルウェアによる被害を防ぐために,マルウェア対策ソフトを導入し,定義ファイルを常に最新に保つ。', 'Khi phân loại các đối sách an toàn thông tin thành đối sách kỹ thuật, đối sách con người và đối sách vật lý, trường hợp nào là ví dụ phù hợp về **đối sách vật lý**?
- ア: Ban hành quy định về xử lý thông tin mật, bao gồm hình phạt; định kỳ đào tạo người liên quan để họ tuân thủ.
- イ: Chuẩn bị hệ thống backup ở địa điểm xa để tiếp tục cung cấp dịch vụ ngay cả khi thiên tai gây sự cố hệ thống.
- ウ: Phổ biến cho nhân viên thông tin về phương pháp tấn công mạng và đối sách để tránh thiệt hại từ những cuộc tấn công ngày càng tinh vi.
- エ: Cài phần mềm chống malware và luôn giữ tệp định nghĩa ở phiên bản mới nhất để tránh thiệt hại do malware.', NULL, 'イ', 'イ: chuẩn bị hệ thống backup ở địa điểm xa để tiếp tục dịch vụ khi thiên tai làm hỏng hệ thống là đối sách vật lý. ア và ウ là giáo dục/quy định cho con người; エ là giải pháp kỹ thuật chống malware.', '[{"term": "物理的", "reading": "ぶつりてき", "meaning": "thuộc vật lý"}, {"term": "被災", "reading": "ひさい", "meaning": "chịu thiên tai"}, {"term": "遠隔地", "reading": "えんかくち", "meaning": "địa điểm ở xa"}]'::jsonb, 94);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 95, '問95 SQLインジェクションの対策などで用いられ,処理の誤動作を招かないように,利用者がWebサイトに入力した内容に含まれる有害な文字列を無害な文字列に置き換えることを何と呼ぶか。
ア MACアドレスフィルタリング
イ サニタイジング
ウ ストライピング
エ ソーシャルエンジニアリング', '', NULL, 'イ', 'イ: サニタイジング là xử lý đầu vào để ký tự/chuỗi nguy hiểm không gây hành vi ngoài ý định. MAC filtering kiểm soát thiết bị mạng; striping phân tán dữ liệu trên đĩa; social engineering lợi dụng con người. Với SQL, việc nhớ thuật ngữ này không thay thế nguyên tắc dùng truy vấn tham số hóa.', '[{"term": "有害", "reading": "ゆうがい", "meaning": "có hại"}, {"term": "無害", "reading": "むがい", "meaning": "vô hại"}, {"term": "置き換える", "reading": "おきかえる", "meaning": "thay thế"}]'::jsonb, 95);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 96, '問96 機密情報の取得などを目的として,特定の組織や個人に対して,複数の攻撃手法を使うなどして長期間にわたり継続的に攻撃を行うという特徴をもつ,サイバー攻撃はどれか。
ア APT攻撃
イ DDoS攻撃
ウ ゼロデイ攻撃
エ パスワードリスト攻撃', '', NULL, 'ア', 'APT là tấn công có mục tiêu, kiên trì trong thời gian dài, có thể dùng nhiều kỹ thuật để lấy thông tin mật, chọn ア. DDoS làm quá tải; zero-day khai thác lỗi chưa có bản vá; password list dùng cặp thông tin đăng nhập bị lộ.', '[{"term": "機密情報", "reading": "きみつじょうほう", "meaning": "thông tin mật"}, {"term": "継続的", "reading": "けいぞくてき", "meaning": "liên tục"}, {"term": "攻撃手法", "reading": "こうげきしゅほう", "meaning": "phương pháp tấn công"}]'::jsonb, 96);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 97, '問97 OSS(Open Source Software)の取扱いに関する記述のうち,適切なものだけを全て挙げたものはどれか。
a OSSを集めた記録媒体を,顧客に有償で提供する。
b 改変したOSSを,特定の利用分野に制限してOSSとして提供する。
c 不具合を発見して修正したOSSのソースコードを,自分のWebサイトで提供する。
ア a
イ a, c
ウ b, c
エ c', '', NULL, 'イ', 'a và c đúng: có thể bán phương tiện chứa OSS và cung cấp mã nguồn đã sửa theo điều kiện giấy phép. b hạn chế một lĩnh vực sử dụng nhưng vẫn gọi là OSS không đáp ứng nguyên tắc không phân biệt lĩnh vực hoạt động. イ = a,c. OSS không đồng nghĩa luôn miễn phí; vẫn phải tuân thủ license.', '[{"term": "有償", "reading": "ゆうしょう", "meaning": "có thu phí"}, {"term": "利用分野", "reading": "りようぶんや", "meaning": "lĩnh vực sử dụng"}, {"term": "取扱い", "reading": "とりあつかい", "meaning": "cách sử dụng/xử lý"}]'::jsonb, 97);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 98, '問98 AIにおけるプロンプトエンジニアリングの説明として,適切なものはどれか。
ア AIが,多数の事象やデータから普遍的なルールや知識を獲得すること
イ AIに対する質問や指示などが入力できる状態であることを,画面上に記号や文字列で示すこと
ウ 意図した回答を得るためにAIに対する質問や指示の内容,情報の提供,出力形式の指定などを工夫すること
エ 神経細胞が作るネットワークをコンピュータで模した,AIで用いられる計算モデルのこと', '', NULL, 'ウ', 'ウ: điều chỉnh câu hỏi/chỉ dẫn, thông tin cung cấp và định dạng đầu ra để nhận câu trả lời mong muốn từ AI. ア mô tả học/tổng quát hóa; イ mô tả dấu nhắc nhập liệu; エ mô tả neural network.', '[{"term": "意図", "reading": "いと", "meaning": "ý định"}, {"term": "指示", "reading": "しじ", "meaning": "chỉ dẫn"}, {"term": "出力形式", "reading": "しゅつりょくけいしき", "meaning": "định dạng đầu ra"}]'::jsonb, 98);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 99, '問99 入力装置に関する次の記述中のa,bに入れる字句の適切な組合せはどれか。
［a］は，紙などに光を当て，反射光を読み取り，文字や図形をデジタルデータに変換してPCに取り込む。［a］が文字や図形をどの程度細かく読み取れるかの性能を示す単位として［b］が使われる。
| 選択肢 | a | b |
|---|---|---|
| ア | イメージスキャナー | bps |
| イ | イメージスキャナー | dpi |
| ウ | スクリーンリーダー | bps |
| エ | スクリーンリーダー | dpi |', 'Chọn tổ hợp từ thích hợp để điền vào a và b trong mô tả về thiết bị nhập sau đây.
［a］chiếu ánh sáng lên giấy hoặc vật tương tự, đọc ánh sáng phản xạ, chuyển chữ/hình thành dữ liệu số và đưa vào PC. Để thể hiện［a］có thể đọc chữ/hình chi tiết đến mức nào, sử dụng đơn vị［b］.
| Lựa chọn | a | b |
|---|---|---|
| ア | Máy quét hình ảnh | bps |
| イ | Máy quét hình ảnh | dpi |
| ウ | Trình đọc màn hình | bps |
| エ | Trình đọc màn hình | dpi |', NULL, 'イ', 'a = image scanner: chiếu sáng giấy, đọc ánh sáng phản xạ và số hóa chữ/hình. b = dpi: dots per inch, thể hiện độ phân giải, chọn イ. Screen reader đọc nội dung màn hình; bps là bit/giây, đo tốc độ truyền.', '[{"term": "反射光", "reading": "はんしゃこう", "meaning": "ánh sáng phản xạ"}, {"term": "入力装置", "reading": "にゅうりょくそうち", "meaning": "thiết bị nhập"}, {"term": "解像度", "reading": "かいぞうど", "meaning": "độ phân giải"}]'::jsonb, 99);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 100, '問100 ISMSの活動に関する記述として,最も適切なものはどれか。
ア 企業のコスト削減や製品の品質,サービスの改善などのために,業務プロセスを改善する。
イ 顧客の満足度を高めるために,ITサービスの品質を継続的に改善する。
ウ 情報資産を洗い出し,リスクの特定と分析及び評価を行い,情報資産を管理する。
エ 製品とサービスの開発プロセスの成熟度を評価し,改善する。', '', NULL, 'ウ', 'ウ: xác định tài sản thông tin, nhận diện/phân tích/đánh giá rủi ro và quản lý tài sản đó. ア cải tiến quy trình kinh doanh; イ cải thiện chất lượng dịch vụ IT và sự hài lòng; エ đánh giá độ trưởng thành quy trình phát triển. ISMS tập trung quản lý an toàn thông tin.', '[{"term": "洗い出し", "reading": "あらいだし", "meaning": "liệt kê/nhận diện đầy đủ"}, {"term": "特定", "reading": "とくてい", "meaning": "xác định"}, {"term": "成熟度", "reading": "せいじゅくど", "meaning": "mức trưởng thành"}, {"term": "最も適切なものはどれか", "reading": "もっともてきせつなものはどれか", "meaning": "Chọn phương án phù hợp nhất."}, {"term": "適切なものだけを全て挙げたもの", "reading": "てきせつなものだけをすべてあげたもの", "meaning": "Chọn tổ hợp gồm tất cả và chỉ những phát biểu đúng."}, {"term": "a、bに入れる字句", "reading": "エー、ビーにいれるじく", "meaning": "Từ/cụm cần điền vào a,b."}, {"term": "ここで", "reading": "ここで", "meaning": "Trong câu này, quy ước rằng…; đọc kỹ điều kiện."}, {"term": "以上／以下", "reading": "いじょう／いか", "meaning": "≥ / ≤; có bao gồm mốc."}, {"term": "より大きい／より小さい", "reading": "よりおおきい／よりちいさい", "meaning": "> / <; không bao gồm mốc."}, {"term": "未満", "reading": "みまん", "meaning": "<; không bao gồm mốc."}]'::jsonb, 100);
END $$;
