-- Certificates feature: seibi2 (cokhi category) — generated from
-- doccument/seibi2/sach_on_tap_Nhat_Viet.md via a one-off parsing script

INSERT INTO certificates (code, category, name_ja, name_vi, related_occupations)
VALUES (
    'seibi2', 'cokhi', '二級ガソリン自動車', 'Kỹ năng bảo dưỡng ô tô - động cơ xăng 2級',
    'Thợ sửa chữa/bảo dưỡng ô tô bậc cao, kỹ thuật viên gara ô tô, tổ trưởng kỹ thuật tại xưởng dịch vụ, kỹ thuật viên kiểm định xe, nhân viên dịch vụ hậu mãi của đại lý ô tô.'
)
ON CONFLICT (code) DO NOTHING;

DO $$
DECLARE cert_id INT;
BEGIN
    SELECT id INTO cert_id FROM certificates WHERE code = 'seibi2';
    DELETE FROM certificate_vocabulary WHERE certificate_id = cert_id;

    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ABS', 'エービーエス', 'hệ thống chống bó cứng phanh', '', '', '', 1);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'AT', 'エーティー', 'hộp số tự động', '', '', '', 2);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'CVT', 'シーブイティー', 'hộp số vô cấp', '', '', '', 3);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'CAN', 'キャン', 'mạng truyền thông điều khiển', '', '', '', 4);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'CAN-H／CAN-L', 'キャン・ハイ／キャン・ロー', 'hai đường tín hiệu CAN', '', '', '', 5);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ECU', 'イーシーユー', 'bộ điều khiển điện tử', '', '', '', 6);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'IC', 'アイシー', 'mạch tích hợp', '', '', '', 7);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'LC', 'エルシー', 'mạch cuộn cảm–tụ điện', '', '', '', 8);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'NAND', 'ナンド', 'cổng phủ định AND', '', '', '', 9);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'NPN', 'エヌピーエヌ', 'loại transistor NPN', '', '', '', 10);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ISCV', 'アイエスシーブイ', 'van điều khiển tốc độ không tải', '', '', '', 11);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'SRS', 'エスアールエス', 'hệ thống bảo vệ bổ sung', '', '', '', 12);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'MF', 'エムエフ', 'đặc tính không cần châm nước/bảo dưỡng định kỳ của ắc quy', '', '', '', 13);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'EV', 'イーブイ', 'xe điện', '', '', '', 14);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ON／OFF', 'オン／オフ', 'bật hoặc dẫn／tắt hoặc ngắt', '', '', '', 15);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'O₂', 'オーツー', 'oxy', '', '', '', 16);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'CO', 'シーオー', 'cacbon monoxit', '', '', '', 17);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'CO₂', 'シーオーツー', 'cacbon dioxit', '', '', '', 18);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'NOₓ', 'エヌオーエックス', 'các oxit nitơ', '', '', '', 19);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'Ca／Sb', 'カルシウム／アンチモン', 'canxi／antimon', '', '', '', 20);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'トルク', 'トルク', 'mô men xoắn', '', '', '', 21);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'コンロッド', 'コンロッド', 'thanh truyền', '', '', '', 22);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'クランク・ピン', 'クランク・ピン', 'chốt khuỷu', '', '', '', 23);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ベアリング', 'ベアリング', 'ổ đỡ hoặc bạc', '', '', '', 24);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ピストン・リング', 'ピストン・リング', 'xéc măng pít tông', '', '', '', 25);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'スキッシュ・エリア', 'スキッシュ・エリア', 'vùng ép đẩy hòa khí gần điểm chết trên', '', '', '', 26);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'オーバラップ', 'オーバラップ', 'trùng điệp thời gian mở van nạp và xả', '', '', '', 27);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'オルタネータ', 'オルタネータ', 'máy phát điện xoay chiều trên xe', '', '', '', 28);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'スタータ', 'スタータ', 'máy khởi động', '', '', '', 29);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'スパーク・プラグ', 'スパーク・プラグ', 'bugi', '', '', '', 30);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'トランスミッション', 'トランスミッション', 'hộp số', '', '', '', 31);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'トルク・コンバータ', 'トルク・コンバータ', 'biến mô', '', '', '', 32);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'プーリ', 'プーリ', 'puli', '', '', '', 33);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ディファレンシャル', 'ディファレンシャル', 'vi sai', '', '', '', 34);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'キャスタ', 'キャスタ', 'góc nghiêng trục lái nhìn từ bên hông', '', '', '', 35);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'キャンバ', 'キャンバ', 'góc nghiêng bánh xe nhìn từ trước', '', '', '', 36);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'モノコック・ボデー', 'モノコック・ボデー', 'thân xe liền khối chịu lực', '', '', '', 37);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'エキスパンション・バルブ', 'エキスパンション・バルブ', 'van tiết lưu', '', '', '', 38);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'コンデンサ', 'コンデンサ', 'giàn ngưng tụ trong điều hòa; tụ điện trong mạch điện', '', '', '', 39);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'エバポレータ', 'エバポレータ', 'giàn bay hơi', '', '', '', 40);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'インフレータ', 'インフレータ', 'bộ tạo khí túi khí', '', '', '', 41);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', 'Mẫu câu tiếng Nhật', 'Cách đọc bằng kana', 'Nghĩa tiếng Việt / cách xử lý khi làm bài', '', '', '', 42);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～に関する記述として、適切なものは次のうちどれか。', '～にかんするきじゅつとして、てきせつなものはつぎのうちどれか。', 'Trong các mô tả về…, mô tả nào phù hợp? Chọn phát biểu đúng.', '', '', '', 43);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～に関する記述として、不適切なものは次のうちどれか。', '～にかんするきじゅつとして、ふてきせつなものはつぎのうちどれか。', 'Mô tả nào không phù hợp? Phải chọn phát biểu sai.', '', '', '', 44);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '下の組み合わせのうち、適切なものはどれか。', 'したのくみあわせのうち、てきせつなものはどれか。', 'Tổ hợp nào dưới đây phù hợp? Kiểm tra mọi thành phần của cùng một hàng.', '', '', '', 45);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～に当てはまるものとして', '～にあてはまるものとして', 'Để điền vào…; xác định từng ô trống theo điều kiện.', '', '', '', 46);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', 'ただし、～ものとする。', 'ただし、～ものとする。', 'Tuy nhiên, giả sử…; dùng đúng giả thiết đã cho.', '', '', '', 47);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～に照らし', '～にてらし', 'Căn cứ theo…; xác định phạm vi quy định được hỏi.', '', '', '', 48);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～を超えてはならない。', '～をこえてはならない。', 'Không được vượt…; đây là giới hạn tối đa.', '', '', '', 49);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', 'この限りでない。', 'このかぎりでない。', 'Quy định này không áp dụng trong trường hợp ngoại lệ vừa nêu.', '', '', '', 50);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～に該当しないもの', '～にがいとうしないもの', 'Đối tượng không thuộc…; chú ý phủ định.', '', '', '', 51);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～に該当するもの', '～にがいとうするもの', 'Đối tượng thuộc…; chọn đúng phạm vi.', '', '', '', 52);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～ほど、～なる。', '～ほど、～なる。', 'Càng… thì càng…; kiểm tra chiều tăng hoặc giảm.', '', '', '', 53);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～と比較して', '～とひかくして', 'So với…; xác định đúng đối tượng làm mốc.', '', '', '', 54);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～で除して求める。', '～でじょしてもとめる。', 'Tính bằng cách chia cho…; không đảo tử và mẫu.', '', '', '', 55);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～を乗じた値', '～をじょうじたあたい', 'Giá trị nhân với…; giữ đơn vị và hệ số.', '', '', '', 56);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '少なくとも～ずつ', 'すくなくとも～ずつ', 'Ít nhất… cho mỗi…; phân biệt giới hạn dưới và trên.', '', '', '', 57);
END $$;

DO $$
DECLARE cert_id INT;
BEGIN
    SELECT id INTO cert_id FROM certificates WHERE code = 'seibi2';
    DELETE FROM certificate_exam_questions WHERE certificate_id = cert_id;

    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Technology', 1, 'コンロッド・ベアリングに要求される性質に関する記述として、不適切なものは次のうちどれか。
(1) なじみ性とは、ベアリングをクランク・ピンに組み付けた場合に、最初は当たりが幾分悪くても、すぐにクランク・ピンになじむ性質をいう。
(2) コンロッド・ベアリングに要求される性質のうち、ベアリングとクランク・ピンに金属接触が起きた場合に、ベアリングが焼き付きにくい性質を耐疲労性という。
(3) アルミニウム合金メタルで、すずの含有率の高いものは、低いものに比べて熱膨張率が大きいのでオイル・クリアランスを大きくしている。
(4) 埋没性とは、異物などをベアリングの表面に埋め込んでしまう性質をいう。', 'Trong các mô tả về các tính chất cần có của bạc đầu to thanh truyền sau đây, mô tả nào không phù hợp?
(1) Tính chạy rà là tính chất của bạc nhanh chóng thích nghi với chốt khuỷu sau khi lắp, dù lúc đầu tiếp xúc có phần chưa tốt.
(2) Trong các tính chất cần có của bạc đầu to thanh truyền, tính khó bị bó cháy khi bạc và chốt khuỷu tiếp xúc kim loại với nhau được gọi là độ bền mỏi.
(3) Bạc hợp kim nhôm có hàm lượng thiếc cao có hệ số giãn nở nhiệt lớn hơn loại có hàm lượng thấp, vì vậy khe hở dầu được thiết lập lớn hơn.
(4) Tính vùi hạt là khả năng làm các dị vật bị vùi vào bề mặt bạc.', NULL, '(2)', 'Chọn (2) vì mô tả này là tính chống bó cháy, không phải độ bền mỏi. Độ bền mỏi là khả năng chịu tải lặp lại mà khó bị hư hỏng. Tính chạy rà giúp cải thiện tiếp xúc, còn tính vùi hạt giúp hạn chế dị vật làm xước chốt khuỷu.', '[{"term": "耐疲労性", "reading": "たいひろうせい", "meaning": "độ bền mỏi"}, {"term": "埋没性", "reading": "まいぼつせい", "meaning": "tính vùi hạt"}, {"term": "焼き付き", "reading": "やきつき", "meaning": "bó cháy"}, {"term": "なじみ性", "reading": "なじみせい", "meaning": "tính chạy rà"}]'::jsonb, 1);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Technology', 2, 'クランクシャフトにおけるトーショナル・ダンパの作用に関する記述として、適切なものは次のうちどれか。
(1) クランクシャフトの軸方向の振動を吸収する。
(2) クランクシャフトの剛性を高める。
(3) クランクシャフトのねじり振動を吸収する。
(4) クランクシャフトのバランス・ウェイトの重さを軽減する。', 'Trong các mô tả về tác dụng của bộ giảm chấn xoắn trên trục khuỷu sau đây, mô tả nào phù hợp?
(1) Hấp thụ rung động theo phương dọc trục của trục khuỷu.
(2) Tăng độ cứng của trục khuỷu.
(3) Hấp thụ dao động xoắn của trục khuỷu.
(4) Giảm khối lượng đối trọng của trục khuỷu.', NULL, '(3)', 'Mô men cháy thay đổi theo chu kỳ gây dao động xoắn của trục khuỷu. Bộ giảm chấn xoắn hấp thụ dao động này, nên (3) đúng. Không nhầm dao động xoắn với chuyển động dọc trục hoặc chức năng cân bằng của đối trọng.', '[{"term": "ねじり振動", "reading": "ねじりしんどう", "meaning": "dao động xoắn"}, {"term": "軸方向", "reading": "じくほうこう", "meaning": "phương dọc trục"}, {"term": "剛性", "reading": "ごうせい", "meaning": "độ cứng"}]'::jsonb, 2);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Technology', 3, 'ピストン・リングに関する記述として、適切なものは次のうちどれか。
(1) スティック現象とは、カーボンやスラッジ（燃焼生成物）が固まってリングが動かなくなることをいう。
(2) スカッフ現象は、ピストン・リングの拡張力が小さいほど、ピストン・リング幅が厚いほど、また、ピストン速度が速いほど起こりやすい。
(3) アンダ・カット型のコンプレッション・リングは、外周下面がカットされた形状になっており、一般にトップ・リングに用いられている。
(4) テーパ・フェース型は、しゅう動面が円弧状になっており、初期なじみの際の異常摩耗が少ない。', 'Trong các mô tả về xéc măng pít tông sau đây, mô tả nào phù hợp?
(1) Hiện tượng kẹt xéc măng là việc muội than hoặc cặn bùn (sản phẩm cháy) đông cứng khiến xéc măng không chuyển động được.
(2) Hiện tượng xước dính dễ xảy ra hơn khi lực bung của xéc măng nhỏ hơn, bề rộng xéc măng dày hơn và tốc độ pít tông cao hơn.
(3) Xéc măng khí kiểu cắt chân dưới có phần dưới mặt ngoài được cắt đi và thường dùng làm xéc măng trên cùng.
(4) Kiểu mặt côn có bề mặt trượt hình cung tròn nên ít mòn bất thường trong giai đoạn chạy rà ban đầu.', NULL, '(1)', '(1) mô tả đúng hiện tượng stick: cặn cháy giữ xéc măng trong rãnh. Xước dính liên quan màng dầu bị phá hủy, tải tiếp xúc và nhiệt; kiểu cắt chân dưới thường dùng cho xéc măng thứ hai. Mặt cung tròn thuộc kiểu barrel, còn taper là mặt côn.', '[{"term": "固まる", "reading": "かたまる", "meaning": "đông cứng"}, {"term": "異常摩耗", "reading": "いじょうまもう", "meaning": "mòn bất thường"}, {"term": "しゅう動面", "reading": "しゅうどうめん", "meaning": "bề mặt trượt"}]'::jsonb, 3);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Technology', 4, 'インテーク側に設けられた油圧式の可変バルブ・タイミング機構に関する記述として、適切なものは次のうちどれか。
(1) 遅角時には、インテーク・バルブの開く時期が早くなるので、オーバラップ量が多くなり中速回転時の体積効率が高くなる。
(2) 可変バルブ・タイミング機構は、バルブの作動角は一定のまま、カムの位相を変えてインテーク・バルブの開閉時期を変化させている。
(3) 進角時には、オーバラップ量を少なくしてアイドリング時の安定化を図っている。
(4) エンジン停止時には、ロック装置により最進角状態で固定されている。', 'Trong các mô tả về cơ cấu thay đổi thời điểm phối khí bằng thủy lực phía nạp sau đây, mô tả nào phù hợp?
(1) Khi làm muộn góc, van nạp mở sớm hơn nên độ trùng điệp tăng và hiệu suất nạp thể tích ở tốc độ trung bình tăng.
(2) Cơ cấu thay đổi thời điểm phối khí giữ nguyên góc tác động của van, thay đổi pha cam để thay đổi thời điểm đóng mở van nạp.
(3) Khi làm sớm góc, cơ cấu giảm độ trùng điệp để ổn định chế độ không tải.
(4) Khi động cơ dừng, cơ cấu khóa cố định ở trạng thái sớm góc tối đa.', NULL, '(2)', '(2) đúng: cơ cấu đổi pha cam dịch chuyển cả thời điểm mở và đóng mà không đổi thời gian mở theo góc quay. Làm muộn không có nghĩa mở sớm. Trong cơ cấu nêu ở đề, vị trí khóa khi dừng là phía muộn góc, giúp ổn định khởi động và không tải.', '[{"term": "位相", "reading": "いそう", "meaning": "pha"}, {"term": "進角", "reading": "しんかく", "meaning": "làm sớm góc"}, {"term": "遅角", "reading": "ちかく", "meaning": "làm muộn góc"}, {"term": "開閉時期", "reading": "かいへいじき", "meaning": "thời điểm đóng mở"}]'::jsonb, 4);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Technology', 5, 'シリンダ・ヘッドとピストンで形成されるスキッシュ・エリアに関する記述として、適切なものは次のうちどれか。
(1) 斜めスキッシュ・エリアは、斜め形状であることで吸入通路からの吸気がスムーズになり、渦流の発生を防いでいる。
(2) 吸入混合気に渦流を与えて、吸入行程における火炎伝播の速度を高めている。
(3) スキッシュ・エリアの厚み（クリアランス）が大きくなるほど渦流の流速は高くなる。
(4) 吸入混合気に渦流を与えて、燃焼時間を短縮することで最高燃焼ガス温度の上昇を抑制する。', 'Trong các mô tả về vùng squish tạo bởi nắp xi lanh và pít tông sau đây, mô tả nào phù hợp?
(1) Vùng squish nghiêng làm khí nạp từ đường nạp lưu thông êm hơn nhờ hình dạng nghiêng và ngăn sự hình thành dòng xoáy.
(2) Tạo dòng xoáy cho hòa khí nạp để tăng tốc độ lan truyền ngọn lửa trong hành trình nạp.
(3) Bề dày (khe hở) vùng squish càng lớn thì tốc độ dòng xoáy càng cao.
(4) Tạo dòng xoáy cho hòa khí nạp, rút ngắn thời gian cháy để hạn chế sự tăng nhiệt độ khí cháy cực đại.', NULL, '(4)', '(4) là phát biểu phù hợp. Khi pít tông tiến gần điểm chết trên, hòa khí bị đẩy khỏi khe hẹp, tạo chuyển động mạnh và tăng tốc độ cháy. Khe hở lớn làm hiệu ứng squish yếu hơn; sự lan truyền lửa liên quan hành trình cháy, không phải hành trình nạp.', '[{"term": "渦流", "reading": "かりゅう", "meaning": "dòng xoáy"}, {"term": "火炎伝播", "reading": "かえんでんぱ", "meaning": "lan truyền ngọn lửa"}, {"term": "燃焼時間", "reading": "ねんしょうじかん", "meaning": "thời gian cháy"}]'::jsonb, 5);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Technology', 6, 'エンジンの性能に関する記述として、不適切なものは次のうちどれか。
(1) 機械損失は、ピストン、ピストン・リング、各ベアリングなどの摩擦損失と、ウォータ・ポンプ、オイル・ポンプ、オルタネータなどの補機駆動の損失からなっている。
(2) 一般にガソリン・エンジンの体積効率は0.8程度で、体積効率と充填効率は、平地ではほとんど同じであるが、高山など気圧の低い場所では差が生じる。
(3) 熱効率のうち図示熱効率とは、理論サイクルにおいて仕事に変えることのできる熱量と、供給する熱量との割合をいう。
(4) 実際にエンジンのクランクシャフトから得られる動力を正味仕事率又は軸出力という。', 'Trong các mô tả về tính năng động cơ sau đây, mô tả nào không phù hợp?
(1) Tổn thất cơ học gồm tổn thất ma sát ở pít tông, xéc măng, các ổ đỡ và tổn thất dẫn động thiết bị phụ như bơm nước, bơm dầu, máy phát điện.
(2) Nhìn chung hiệu suất nạp thể tích của động cơ xăng khoảng 0.8; hiệu suất nạp thể tích và hiệu suất nạp theo khối lượng gần như bằng nhau ở đồng bằng nhưng khác nhau ở nơi áp suất khí quyển thấp như núi cao.
(3) Trong các hiệu suất nhiệt, hiệu suất nhiệt chỉ thị là tỷ số giữa lượng nhiệt có thể chuyển thành công trong chu trình lý thuyết và lượng nhiệt cung cấp.
(4) Công suất thực tế thu được từ trục khuỷu động cơ được gọi là công suất có ích hoặc công suất trục.', NULL, '(3)', '(3) nhầm hiệu suất nhiệt chỉ thị với hiệu suất nhiệt lý thuyết. Hiệu suất chỉ thị lấy công chỉ thị thực tế trong xi lanh chia cho nhiệt lượng nhiên liệu cung cấp; hiệu suất lý thuyết xét chu trình lý tưởng. Công suất trục còn phải trừ các tổn thất cơ học.', '[{"term": "図示熱効率", "reading": "ずしねつこうりつ", "meaning": "hiệu suất nhiệt chỉ thị"}, {"term": "充填効率", "reading": "じゅうてんこうりつ", "meaning": "hiệu suất nạp theo khối lượng"}, {"term": "軸出力", "reading": "じくしゅつりょく", "meaning": "công suất trục"}]'::jsonb, 6);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Technology', 7, '点火順序が1－5－3－6－2－4の4サイクル直列6シリンダ・エンジンに関する次の文章の［a］と［b］に当てはまるものとして、適切なものはどれか。
第4シリンダが圧縮上死点のとき、燃焼行程途中にあるのは［a］で、この位置からクランクシャフトを回転方向に480°回転させたとき、バルブがオーバラップの上死点状態にあるのは［b］である。
| 選択肢 | ［a］ | ［b］ |
| --- | --- | --- |
| 1 | 第2シリンダ | 第1シリンダ |
| 2 | 第5シリンダ | 第1シリンダ |
| 3 | 第2シリンダ | 第4シリンダ |
| 4 | 第5シリンダ | 第4シリンダ |', 'Với động cơ 4 kỳ, 6 xi lanh thẳng hàng có thứ tự đánh lửa 1－5－3－6－2－4, lựa chọn nào điền đúng vào ［a］ và ［b］?
Khi xi lanh 4 ở điểm chết trên cuối kỳ nén, xi lanh đang giữa hành trình cháy là ［a］. Từ vị trí đó, khi quay trục khuỷu 480° theo chiều quay, xi lanh có van ở trạng thái trùng điệp tại điểm chết trên là ［b］.
| Lựa chọn | ［a］ | ［b］ |
| --- | --- | --- |
| 1 | Xi lanh 2 | Xi lanh 1 |
| 2 | Xi lanh 5 | Xi lanh 1 |
| 3 | Xi lanh 2 | Xi lanh 4 |
| 4 | Xi lanh 5 | Xi lanh 4 |', NULL, '(1)', 'Khoảng cách đánh lửa là 720°/6 = 120°. Khi xi lanh 4 bắt đầu cháy, xi lanh 2 đã cháy được 120°, nên đang trong kỳ cháy. Từ mốc này, xi lanh 1 đánh lửa sau 120°; sau tổng cộng 480° nó đã đi thêm 360° kể từ đánh lửa, đến điểm chết trên trùng điệp. Chọn (1).', '[{"term": "圧縮上死点", "reading": "あっしゅくじょうしてん", "meaning": "điểm chết trên cuối nén"}, {"term": "点火順序", "reading": "てんかじゅんじょ", "meaning": "thứ tự đánh lửa"}, {"term": "燃焼行程", "reading": "ねんしょうこうてい", "meaning": "hành trình cháy"}]'::jsonb, 7);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Technology', 8, '吸排気装置における過給機に関する記述として、適切なものは次のうちどれか。
(1) 一般に、ターボ・チャージャに用いられているシャフトの周速は、フル・フローティング・ベアリングの周速の約半分である。
(2) ルーツ式のスーパー・チャージャには、過給圧が高くなって規定値以上になると、過給圧の一部を排気側へ逃がし、過給圧を規定値に制御するエア・バイパス・バルブが設けられている。
(3) 2葉ルーツ式のスーパー・チャージャでは、ロータ1回転につき1回の吸入・吐出が行われる。
(4) ターボ・チャージャの特徴として、小型軽量で取り付け位置の自由度は高いが、排気エネルギの小さい低速回転域からの立ち上がりに遅れが生じ易い。', 'Trong các mô tả về bộ tăng áp trong hệ thống nạp xả sau đây, mô tả nào phù hợp?
(1) Thông thường tốc độ chu vi của trục turbo bằng khoảng một nửa tốc độ chu vi của bạc nổi hoàn toàn.
(2) Bộ siêu nạp Roots có van bypass khí; khi áp suất tăng áp vượt giá trị quy định, van xả một phần áp suất sang phía khí xả để giữ áp suất ở giá trị quy định.
(3) Bộ siêu nạp Roots hai thùy thực hiện một lần hút và đẩy trong mỗi vòng quay rô to.
(4) Turbo nhỏ, nhẹ, có độ tự do cao về vị trí lắp nhưng dễ bị trễ đáp ứng khi tăng tốc từ vùng vòng tua thấp có năng lượng khí xả nhỏ.', NULL, '(4)', '(4) đúng với đặc tính turbo lag. (1) đảo quan hệ tốc độ; bạc nổi quay chậm hơn trục. Bypass của Roots hồi khí về phía hút, không phải phía xả động cơ. Với rô to hai thùy, toàn bộ cặp rô to tạo bốn lần hút và đẩy mỗi vòng.', '[{"term": "過給機", "reading": "かきゅうき", "meaning": "bộ tăng áp"}, {"term": "吐出", "reading": "としゅつ", "meaning": "đẩy ra"}, {"term": "排気エネルギ", "reading": "はいきエネルギ", "meaning": "năng lượng khí xả"}]'::jsonb, 8);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Technology', 9, '図に示すオルタネータ回路において、B端子が外れたときの次の文章の［a］と［b］に当てはまるものとして、下の組み合わせのうち、適切なものはどれか。
オルタネータが回転中にB端子が解放状態（外れ）になり、バッテリ電圧（S端子の電圧）が調整電圧以下になると、Tr₁が［a］する。そしてS端子の電圧よりB端子の電圧が規定値より［b］、IC内の制御回路が異常を検出し、チャージ・ランプを点灯させるとともに、B端子の電圧を調整電圧より高めになるように制御する。
| 選択肢 | ［a］ | ［b］ |
| --- | --- | --- |
| 1 | OFF | 低くなると |
| 2 | OFF | 高くなると |
| 3 | ON | 低くなると |
| 4 | ON | 高くなると |

![Hình câu 9](images/m09.png)', 'Trong mạch máy phát ở hình, khi đầu cực B tuột ra, tổ hợp nào điền đúng vào ［a］ và ［b］?
Nếu đầu cực B bị hở (tuột) khi máy phát đang quay, và điện áp ắc quy (điện áp cực S) xuống bằng hoặc dưới điện áp điều chỉnh, Tr₁ sẽ ［a］. Khi điện áp cực B so với điện áp cực S ［b］ mức quy định, mạch điều khiển trong IC phát hiện bất thường, bật đèn báo nạp, đồng thời điều khiển điện áp cực B cao hơn điện áp điều chỉnh.
| Lựa chọn | ［a］ | ［b］ |
| --- | --- | --- |
| 1 | OFF | giảm thấp hơn |
| 2 | OFF | tăng cao hơn |
| 3 | ON | giảm thấp hơn |
| 4 | ON | tăng cao hơn |

**Nhãn hình:** オルタネータ: máy phát; ステータ・コイル: cuộn stato; ロータ・コイル: cuộn rô to; イグニション・スイッチ: khóa điện; チャージ・ランプ: đèn báo nạp; バッテリ: ắc quy; 負荷: tải; IC式ボルテージ・レギュレータ: bộ điều áp kiểu IC; 外れ: tuột/ngắt; B, IG, S, L, F, E, Tr₁, Tr₂, IC giữ nguyên như hình.', NULL, '(4)', 'Chọn (4). Cực S cảm nhận điện áp ắc quy thấp nên Tr₁ dẫn ON để tăng kích từ. Do B bị ngắt khỏi ắc quy, điện áp B tăng cao so với S; IC nhận ra chênh lệch bất thường và bật đèn báo. Phân biệt cực công suất B với cực cảm nhận S.', '[{"term": "端子", "reading": "たんし", "meaning": "đầu cực"}, {"term": "励磁", "reading": "れいじ", "meaning": "kích từ"}, {"term": "調整電圧", "reading": "ちょうせいでんあつ", "meaning": "điện áp điều chỉnh"}]'::jsonb, 9);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Technology', 10, '高熱価型スパーク・プラグに関する記述として、適切なものは次のうちどれか。
(1) ホット・タイプと呼ばれる。
(2) 低熱価型に比べてガス・ポケットの容積が小さい。
(3) 低熱価型に比べて中心電極の温度が上昇しやすい。
(4) 低熱価型に比べて碍子脚部が長い。', 'Trong các mô tả về bugi loại chỉ số nhiệt cao sau đây, mô tả nào phù hợp?
(1) Được gọi là loại nóng.
(2) Thể tích khoang khí nhỏ hơn loại chỉ số nhiệt thấp.
(3) Nhiệt độ điện cực trung tâm dễ tăng hơn loại chỉ số nhiệt thấp.
(4) Chân sứ cách điện dài hơn loại chỉ số nhiệt thấp.', NULL, '(2)', '(2) đúng. Chỉ số nhiệt cao là bugi lạnh, có chân sứ ngắn và đường truyền nhiệt ngắn nên tản nhiệt tốt. Khoang khí nhỏ hơn và điện cực khó nóng lên hơn. Không nhầm chỉ số nhiệt cao với nhiệt độ làm việc cao.', '[{"term": "高熱価型", "reading": "こうねつかがた", "meaning": "loại chỉ số nhiệt cao"}, {"term": "碍子脚部", "reading": "がいしきゃくぶ", "meaning": "chân sứ cách điện"}, {"term": "中心電極", "reading": "ちゅうしんでんきょく", "meaning": "điện cực trung tâm"}]'::jsonb, 10);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Technology', 11, '全流ろ過圧送式の潤滑装置に関する記述として、適切なものは次のうちどれか。
(1) ガソリン・エンジンに装着されているオイル・クーラは、一般に空冷式のものが用いられている。
(2) トロコイド式オイル・ポンプに設けられたリリーフ・バルブは、エンジンの回転速度が上昇して油圧が規定値に達すると、バルブが閉じる。
(3) エンジン・オイルは、一般に油温が200℃でも潤滑性は維持される。
(4) 一般に用いられている水冷式オイル・クーラは、オイルが流れる通路と冷却水が流れる通路を交互に数段積み重ねて一体化した構造になっている。', 'Trong các mô tả về hệ thống bôi trơn cưỡng bức lọc toàn dòng sau đây, mô tả nào phù hợp?
(1) Bộ làm mát dầu trên động cơ xăng thường dùng loại làm mát bằng không khí.
(2) Van an toàn trên bơm dầu trochoid đóng khi vòng tua tăng và áp suất dầu đạt giá trị quy định.
(3) Dầu động cơ nói chung vẫn duy trì tính bôi trơn khi nhiệt độ dầu là 200℃.
(4) Bộ làm mát dầu bằng nước thường dùng có cấu trúc tích hợp nhiều lớp đường dầu và đường nước làm mát xếp xen kẽ.', NULL, '(4)', '(4) mô tả đúng bộ trao đổi nhiệt dầu–nước. Van relief mở để giới hạn áp suất chứ không đóng. Không xem 200℃ là nhiệt độ thông thường vẫn bảo đảm bôi trơn; dầu quá nóng bị giảm độ nhớt và suy giảm tính năng.', '[{"term": "潤滑装置", "reading": "じゅんかつそうち", "meaning": "hệ thống bôi trơn"}, {"term": "油圧", "reading": "ゆあつ", "meaning": "áp suất dầu"}, {"term": "冷却水", "reading": "れいきゃくすい", "meaning": "nước làm mát"}]'::jsonb, 11);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Technology', 12, '半導体に関する記述として、適切なものは次のうちどれか。
(1) NAND回路は、二つの入力がともに“1”のときのみ出力が“0”となる。
(2) LC発振器は、抵抗とコンデンサを使い、コンデンサの放電時間で発振周期を決める。
(3) 可変抵抗は、一方向にしか電流を流さない特性をもっているため、交流を直流に変換する整流回路などに用いられている。
(4) NPN型トランジスタのベース電流が2mA、コレクタ電流が200mA流れた場合の電流増幅率は400である。', 'Trong các mô tả về linh kiện bán dẫn sau đây, mô tả nào phù hợp?
(1) Mạch NAND chỉ có đầu ra “0” khi cả hai đầu vào đều là “1”.
(2) Mạch dao động LC dùng điện trở và tụ điện, xác định chu kỳ dao động bằng thời gian phóng điện của tụ.
(3) Biến trở có đặc tính chỉ cho dòng đi theo một chiều, nên được dùng trong mạch chỉnh lưu biến dòng xoay chiều thành một chiều.
(4) Khi dòng base của transistor NPN là 2mA và dòng collector là 200mA, hệ số khuếch đại dòng là 400.', NULL, '(1)', '(1) đúng theo phép phủ định AND. LC dùng cuộn cảm L và tụ C; mạch dùng điện trở và tụ là RC. Linh kiện chỉnh lưu là diode. Hệ số khuếch đại dòng β = I_C/I_B = 200/2 = 100, không phải 400.', '[{"term": "半導体", "reading": "はんどうたい", "meaning": "bán dẫn"}, {"term": "整流回路", "reading": "せいりゅうかいろ", "meaning": "mạch chỉnh lưu"}, {"term": "電流増幅率", "reading": "でんりゅうぞうふくりつ", "meaning": "hệ số khuếch đại dòng"}]'::jsonb, 12);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Technology', 13, 'スタータのトルクが10N·m、回転速度が1,200min⁻¹のときのスタータの出力として、適切なものは次のうちどれか。ただし、円周率（π）＝3.14として計算しなさい。
(1) 0.746kW
(2) 1.265kW
(3) 2.456kW
(4) 4.726kW', 'Khi mô men máy khởi động là 10N·m và tốc độ quay là 1,200min⁻¹, công suất nào sau đây phù hợp? Hãy tính với số π＝3.14.
(1) 0.746kW
(2) 1.265kW
(3) 2.456kW
(4) 4.726kW', NULL, '※ — Tất cả thí sinh được công nhận đúng', 'Trạng thái chính thức: tất cả thí sinh được công nhận đúng vì câu ra không phù hợp. Kiểm tra kỹ thuật: P = T × 2πn/60 = 10 × 2 × 3.14 × 1,200/60 = 1,256W = 1.256kW. Không lựa chọn nào bằng kết quả này; (2) ghi 1.265kW. Không tự sửa số của lựa chọn hoặc chọn đáp án gần nhất thay cho quyết định chính thức.', '[{"term": "出力", "reading": "しゅつりょく", "meaning": "công suất"}, {"term": "回転速度", "reading": "かいてんそくど", "meaning": "tốc độ quay"}, {"term": "円周率", "reading": "えんしゅうりつ", "meaning": "số pi"}]'::jsonb, 13);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Technology', 14, 'バッテリに関する記述として、不適切なものは次のうちどれか。
(1) 電解液の温度を一定とすると、電解液の比重が1.200の場合より1.300の方が起電力は大きい。
(2) アイドリング・ストップ車専用のカルシウム・バッテリは、深い充・放電の繰り返しへの耐久性を向上させている。
(3) カルシウム・バッテリよりも、低アンチモン・バッテリの方が、自己放電及び電解液の蒸発が少なく長寿命である。
(4) 電解液の比重を一定とすると、電解液の温度が0℃の場合より20℃の方が起電力は大きい。', 'Trong các mô tả về ắc quy sau đây, mô tả nào không phù hợp?
(1) Ở nhiệt độ dung dịch điện phân không đổi, sức điện động khi tỷ trọng là 1.300 lớn hơn khi tỷ trọng là 1.200.
(2) Ắc quy canxi chuyên dùng cho xe tự dừng không tải được tăng độ bền trước các chu kỳ nạp và xả sâu lặp lại.
(3) So với ắc quy canxi, ắc quy ít antimon có tự phóng điện và bay hơi dung dịch điện phân ít hơn, tuổi thọ dài hơn.
(4) Ở tỷ trọng dung dịch điện phân không đổi, sức điện động tại 20℃ lớn hơn tại 0℃.', NULL, '(3)', '(3) đảo ưu điểm của ắc quy canxi: loại canxi có tự phóng điện và hao nước thấp hơn loại ít antimon. Sức điện động còn phụ thuộc tỷ trọng và nhiệt độ dung dịch; cần phân biệt nó với khả năng cấp dòng khi khởi động.', '[{"term": "電解液", "reading": "でんかいえき", "meaning": "dung dịch điện phân"}, {"term": "比重", "reading": "ひじゅう", "meaning": "tỷ trọng"}, {"term": "自己放電", "reading": "じこほうでん", "meaning": "tự phóng điện"}]'::jsonb, 14);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Technology', 15, '電子制御式燃料噴射装置のセンサに関する記述として、不適切なものは次のうちどれか。
(1) バキューム・センサは、インテーク・マニホールド圧力が高くなると出力電圧は大きくなる特性がある。
(2) ホール素子式のスロットル・ポジション・センサは、スロットル・バルブ開度の検出にホール効果を用いて行っている。
(3) 磁気抵抗素子式のカム角センサは、磁気抵抗素子の前面にシグナル・ロータの凸部があるときには、磁気抵抗素子を通る磁束成分が最も多く抵抗値が最大となる。
(4) ジルコニア式O₂センサは、比較電圧よりもO₂センサの出力が高いときは理論空燃比より小さい（濃い）と判定し、逆に出力が低いときは理論空燃比より大きい（薄い）と判定する。', 'Trong các mô tả về cảm biến của hệ thống phun nhiên liệu điều khiển điện tử sau đây, mô tả nào không phù hợp?
(1) Cảm biến chân không có đặc tính điện áp đầu ra tăng khi áp suất ống góp nạp tăng.
(2) Cảm biến vị trí bướm ga dùng phần tử Hall sử dụng hiệu ứng Hall để phát hiện độ mở bướm ga.
(3) Ở cảm biến góc cam dùng phần tử từ trở, khi phần lồi của rô to tín hiệu ở trước phần tử, thành phần từ thông qua phần tử lớn nhất và điện trở đạt giá trị lớn nhất.
(4) Cảm biến O₂ zirconia xác định hòa khí đậm (tỷ lệ không khí/nhiên liệu thấp hơn tỷ lệ lý thuyết) khi đầu ra cao hơn điện áp so sánh; ngược lại, đầu ra thấp được xác định là hòa khí nhạt (tỷ lệ cao hơn lý thuyết).', NULL, '(3)', '(3) sai: trong cơ cấu cảm biến của đề, khi phần lồi đối diện phần tử, thành phần từ thông qua phần tử nhỏ nhất và điện trở nhỏ nhất; khi phần lồi đi xa, chúng tăng lên. Phải xét cấu tạo và hướng từ trường của cảm biến, không dùng một quan hệ chung cho mọi loại từ trở. (1), (2), (4) mô tả đúng tín hiệu xác định tải, vị trí và hòa khí.', '[{"term": "磁気抵抗素子", "reading": "じきていこうそし", "meaning": "phần tử từ trở"}, {"term": "磁束", "reading": "じそく", "meaning": "từ thông"}, {"term": "理論空燃比", "reading": "りろんくうねんひ", "meaning": "tỷ lệ không khí/nhiên liệu lý thuyết"}]'::jsonb, 15);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Technology', 16, 'マニュアル・トランスミッションのクラッチに関する記述として、適切なものは次のうちどれか。
(1) クラッチの伝達トルク容量が、エンジンのトルクに比べて過大であると、クラッチ・フェーシングの摩耗量が急増しやすい。
(2) ダイヤフラム・スプリングは、コイル・スプリングを用いたクラッチ・スプリングと比較して、プレッシャ・プレートに作用するスプリング力が均一である。
(3) 一般にクラッチの伝達トルク容量は、エンジンの最大トルクの1.2倍～2.5倍に設定されており、トラックやバスよりも乗用車の方が、ジーゼル車よりもガソリン車の方が余裕係数は大きい。
(4) クラッチの伝達トルク容量が、エンジンのトルクに比べて過少であると、クラッチの操作が難しく、接続が急になりがちでエンストしやすい。', 'Trong các mô tả về ly hợp hộp số tay sau đây, mô tả nào phù hợp?
(1) Nếu khả năng truyền mô men của ly hợp quá lớn so với mô men động cơ, lượng mòn lớp ma sát ly hợp dễ tăng đột ngột.
(2) So với lò xo ly hợp dạng cuộn, lò xo màng tạo lực lò xo đồng đều hơn lên đĩa ép.
(3) Khả năng truyền mô men ly hợp thường được đặt bằng 1.2～2.5 lần mô men cực đại động cơ; hệ số dự trữ của xe con lớn hơn xe tải và xe buýt, của xe xăng lớn hơn xe diesel.
(4) Nếu khả năng truyền mô men ly hợp quá nhỏ so với mô men động cơ, việc điều khiển khó, đóng ly hợp dễ đột ngột và động cơ dễ chết máy.', NULL, '(2)', '(2) đúng vì lò xo màng phân bố lực đều quanh đĩa ép. Khả năng truyền quá nhỏ chủ yếu gây trượt và nóng; khả năng quá lớn có thể gây đóng gắt. Hệ số dự trữ phải xét tải và đặc tính động cơ, không dùng quan hệ đảo trong (3).', '[{"term": "伝達トルク容量", "reading": "でんたつトルクようりょう", "meaning": "khả năng truyền mô men"}, {"term": "摩耗量", "reading": "まもうりょう", "meaning": "lượng mòn"}, {"term": "余裕係数", "reading": "よゆうけいすう", "meaning": "hệ số dự trữ"}]'::jsonb, 16);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Technology', 17, 'トルク・コンバータに関する記述として、適切なものは次のうちどれか。
(1) 速度比は、タービン軸の回転速度をポンプ軸の回転速度で除して求める。
(2) 速度比がゼロのときの伝達効率は100％である。
(3) カップリング・レンジにおけるトルク比は、2.0～2.5である。
(4) コンバータ・レンジでは、全ての範囲において速度比に比例して伝達効率が上昇する。', 'Trong các mô tả về biến mô sau đây, mô tả nào phù hợp?
(1) Tỷ số tốc độ được tính bằng tốc độ trục tuabin chia cho tốc độ trục bơm.
(2) Khi tỷ số tốc độ bằng không, hiệu suất truyền là 100％.
(3) Tỷ số mô men trong vùng khớp nối là 2.0～2.5.
(4) Trong toàn bộ vùng biến mô, hiệu suất truyền tăng tỷ lệ thuận với tỷ số tốc độ.', NULL, '(1)', '(1) là định nghĩa e = n_t/n_p. Hiệu suất η = tỷ số mô men × e, nên tại e = 0 thì η = 0. Vùng khớp nối có tỷ số mô men gần 1; 2.0～2.5 là mức nhân mô men ở gần trạng thái stall. Quan hệ hiệu suất không tuyến tính trên toàn vùng.', '[{"term": "速度比", "reading": "そくどひ", "meaning": "tỷ số tốc độ"}, {"term": "伝達効率", "reading": "でんたつこうりつ", "meaning": "hiệu suất truyền"}, {"term": "トルク比", "reading": "トルクひ", "meaning": "tỷ số mô men"}]'::jsonb, 17);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Technology', 18, '前進4段のロックアップ機構付き電子制御式ATのストール・テストに関する記述として、適切なものは次のうちどれか。
(1) すべてのレンジでエンジンの規定回転速度より高い場合には、ステータのワンウェイ・クラッチの作動不良（滑り）が考えられる。
(2) エンジンの回転速度が各レンジとも等しく、かつ、基準値内であれば正常である。
(3) 各レンジのエンジンの回転速度は等しいが、全体的に低い場合には、フォワード・クラッチの滑りが考えられる。
(4) 特定のレンジのみがエンジンの規定回転速度より高い場合には、エンジン出力不足が考えられる。', 'Trong các mô tả về thử stall của hộp số AT điều khiển điện tử 4 cấp tiến có khóa biến mô sau đây, mô tả nào phù hợp?
(1) Nếu ở tất cả các dải số vòng tua đều cao hơn quy định, có thể ly hợp một chiều của stato bị trượt.
(2) Nếu vòng tua động cơ ở các dải số bằng nhau và nằm trong giá trị chuẩn thì hệ thống bình thường.
(3) Nếu vòng tua ở các dải số bằng nhau nhưng đều thấp, có thể ly hợp tiến bị trượt.
(4) Nếu chỉ một dải số có vòng tua cao hơn quy định, có thể động cơ thiếu công suất.', NULL, '(2)', '(2) đúng. Trượt bộ phận ma sát ở một dải thường làm vòng tua stall của dải đó cao. Vòng tua thấp trên nhiều dải gợi ý công suất động cơ thấp hoặc biến mô không nhân mô men đủ. Không đảo dấu cao/thấp khi chẩn đoán.', '[{"term": "基準値", "reading": "きじゅんち", "meaning": "giá trị chuẩn"}, {"term": "作動不良", "reading": "さどうふりょう", "meaning": "hoạt động không tốt"}, {"term": "滑り", "reading": "すべり", "meaning": "trượt"}]'::jsonb, 18);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Technology', 19, 'タイヤに関する記述として、適切なものは次のうちどれか。
(1) スキール音とは、タイヤの溝の中の空気が、路面とタイヤの間で圧縮され、排出されるときに出る音をいう。
(2) タイヤの偏平率（％）とは、「断面幅」を「断面高さ」で除したものに、100を乗じた値をいう。
(3) タイヤ（ホイール付き）の一部が他の部分より重い場合、タイヤをゆっくり回転させると重い部分が下になって止まり、このアンバランスをスタティック・アンバランスという。
(4) タイヤに10mmの縦たわみを与えるために必要な静的縦荷重を静的縦ばね定数といい、この値が小さいほど路面から受ける衝撃を吸収しやすく、乗り心地がよい。', 'Trong các mô tả về lốp xe sau đây, mô tả nào phù hợp?
(1) Tiếng rít squeal là âm thanh phát ra khi không khí trong rãnh lốp bị nén giữa lốp và mặt đường rồi thoát ra.
(2) Tỷ lệ mặt cắt lốp (％) là bề rộng mặt cắt chia cho chiều cao mặt cắt, nhân 100.
(3) Nếu một phần của lốp kèm vành nặng hơn phần khác, quay chậm sẽ khiến phần nặng dừng ở dưới; mất cân bằng này gọi là mất cân bằng tĩnh.
(4) Độ cứng đàn hồi đứng tĩnh là tải trọng đứng tĩnh cần để lốp biến dạng đứng 10mm; giá trị càng nhỏ thì lốp càng dễ hấp thụ va đập từ đường và đi êm hơn.', NULL, '(3)', 'Đáp án chính thức chọn (3), mô tả mất cân bằng tĩnh. Squeal do trượt và rung cục bộ của mặt lốp, còn khí trong rãnh gây tiếng bơm khí. Tỷ lệ mặt cắt = chiều cao/bề rộng × 100. Độ cứng đàn hồi là tải trên một đơn vị biến dạng, không phải tải ứng với 10mm như (4).', '[{"term": "偏平率", "reading": "へんぺいりつ", "meaning": "tỷ lệ mặt cắt lốp"}, {"term": "断面高さ", "reading": "だんめんたかさ", "meaning": "chiều cao mặt cắt"}, {"term": "静的縦荷重", "reading": "せいてきたてかじゅう", "meaning": "tải trọng đứng tĩnh"}]'::jsonb, 19);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Technology', 20, 'CVT（スチール・ベルトを用いたベルト式無段変速機）に関する記述として、適切なものは次のうちどれか。
(1) Lレンジ時は、変速領域をプーリ比の最High付近にのみ制限することで、強力な駆動力及びエンジン・ブレーキを確保する。
(2) プライマリ・プーリに掛かる作動油圧が高くなると、プライマリ・プーリに掛かるスチール・ベルトの接触半径は小さくなる。
(3) スチール・ベルトは、エレメントの伸張作用（エレメントの引っ張り）によって動力が伝達される。
(4) プライマリ・プーリに掛かる作動油圧が低くなると、プライマリ・プーリの溝幅は広くなる。', 'Trong các mô tả về CVT (hộp số vô cấp kiểu đai sử dụng đai thép) sau đây, mô tả nào phù hợp?
(1) Ở dải L, vùng biến tốc chỉ giới hạn gần tỷ số puli High cao nhất để bảo đảm lực kéo và phanh động cơ mạnh.
(2) Khi áp suất dầu tác động lên puli sơ cấp tăng, bán kính tiếp xúc đai thép trên puli này giảm.
(3) Đai thép truyền công suất bằng tác dụng kéo giãn (kéo các phần tử đai).
(4) Khi áp suất dầu tác động lên puli sơ cấp giảm, bề rộng rãnh puli sơ cấp tăng.', NULL, '(4)', '(4) đúng: áp suất giảm cho phép hai má puli tách xa nhau. Áp suất tăng làm rãnh hẹp và bán kính tiếp xúc tăng. Đai thép dạng push belt truyền lực bằng các phần tử chịu nén đẩy nhau. Dải L ưu tiên tỷ số Low để tăng lực kéo và phanh động cơ.', '[{"term": "無段変速機", "reading": "むだんへんそくき", "meaning": "hộp số vô cấp"}, {"term": "接触半径", "reading": "せっしょくはんけい", "meaning": "bán kính tiếp xúc"}, {"term": "溝幅", "reading": "みぞはば", "meaning": "bề rộng rãnh"}]'::jsonb, 20);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Technology', 21, 'サスペンションのスプリングに関する記述として、適切なものは次のうちどれか。
(1) 金属スプリングを用いた自動車のボデーの上下方向の固有振動数は、荷重が減少すると大きく、増加すると小さくなる。
(2) ばね定数が大きいスプリングは、小さいスプリングに比べてばねが柔らかい。
(3) エア・スプリングは、金属スプリングと比較して、荷重の変化に対してばね定数が自動的に変化するので、固有振動数は荷重の増加に比例して大きくなる。
(4) エア・スプリングのばね定数は、荷重が増加するとレベリング・バルブの作用により小さくなる。', 'Trong các mô tả về lò xo hệ thống treo sau đây, mô tả nào phù hợp?
(1) Tần số dao động riêng theo phương đứng của thân xe dùng lò xo kim loại tăng khi tải giảm và giảm khi tải tăng.
(2) Lò xo có độ cứng lớn mềm hơn lò xo có độ cứng nhỏ.
(3) So với lò xo kim loại, lò xo khí tự đổi độ cứng theo tải nên tần số dao động riêng tăng tỷ lệ thuận với tải.
(4) Khi tải tăng, van điều chỉnh độ cao làm độ cứng lò xo khí giảm.', NULL, '(1)', '(1) đúng theo f = (1/2π)√(k/m): k gần cố định thì m tăng làm f giảm. Độ cứng lớn nghĩa là lò xo cứng hơn. Lò xo khí có thể tăng độ cứng theo tải để giữ tần số gần ổn định, không tăng tỷ lệ với tải như (3).', '[{"term": "固有振動数", "reading": "こゆうしんどうすう", "meaning": "tần số dao động riêng"}, {"term": "ばね定数", "reading": "ばねていすう", "meaning": "độ cứng lò xo"}, {"term": "荷重", "reading": "かじゅう", "meaning": "tải trọng"}]'::jsonb, 21);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Technology', 22, '差動制限型ディファレンシャルに関する記述として、適切なものは次のうちどれか。
(1) 回転速度差感応式の差動制限力の発生は、ピニオンの歯先とディファレンシャル・ケース内周面との摩擦により行っている。
(2) トルク感応式のヘリカル・ギヤを用いたものは、左右輪の回転速度に差が生じた場合、高回転側から低回転側に駆動力が伝えられ、低回転側に大きな駆動力が発生する。
(3) 回転速度差感応式に用いられているビスカス・カップリングは、インナ・プレートとアウタ・プレートの回転速度差が小さいほど大きなビスカス・トルクが発生する。
(4) トルク感応式のヘリカル・ギヤを用いたものは、ディファレンシャル・ケース内に高粘度のシリコン・オイルが充填されている。', 'Trong các mô tả về vi sai hạn chế trượt sau đây, mô tả nào phù hợp?
(1) Loại nhạy với chênh lệch tốc độ tạo lực hạn chế vi sai bằng ma sát giữa đỉnh răng bánh răng nhỏ và mặt trong vỏ vi sai.
(2) Loại nhạy mô men dùng bánh răng nghiêng truyền lực kéo từ phía quay nhanh sang phía quay chậm khi hai bánh có chênh lệch tốc độ, tạo lực kéo lớn ở phía quay chậm.
(3) Khớp nối nhớt dùng ở loại nhạy chênh lệch tốc độ tạo mô men nhớt càng lớn khi chênh lệch tốc độ giữa các lá trong và ngoài càng nhỏ.
(4) Loại nhạy mô men dùng bánh răng nghiêng được nạp dầu silicone độ nhớt cao trong vỏ vi sai.', NULL, '(2)', '(2) đúng. Loại bánh răng nghiêng phân bố mô men nhờ lực và ma sát của bộ bánh răng; khớp nhớt mới dùng dầu silicone. Mô men nhớt tăng khi chênh lệch tốc độ tăng, nên (3) đảo chiều quan hệ. (1) gán cơ chế ma sát bánh răng cho loại nhạy tốc độ.', '[{"term": "差動制限力", "reading": "さどうせいげんりょく", "meaning": "lực hạn chế vi sai"}, {"term": "感応式", "reading": "かんのうしき", "meaning": "kiểu nhạy theo"}, {"term": "高粘度", "reading": "こうねんど", "meaning": "độ nhớt cao"}]'::jsonb, 22);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Technology', 23, '電動式パワー・ステアリングに関する記述として、適切なものは次のうちどれか。
(1) スリーブ式のトルク・センサは、インプット・シャフトの突起部とコイル間の磁力線密度の変化により、操舵力と操舵方向を検出している。
(2) リング式のトルク・センサでは、インプット・シャフトが磁性体でできており、突起式になっている。
(3) コラム・アシスト式は、ステアリング・ギヤのピニオン部にトルク・センサ及びモータが取り付けられ、ステアリング・ギヤのピニオンに対して補助動力を与えている。
(4) ホールICを用いたトルク・センサは、インプット・シャフトにヨークを配置し、アウトプット・シャフトに多極マグネットが配置されている。', 'Trong các mô tả về trợ lực lái điện sau đây, mô tả nào phù hợp?
(1) Cảm biến mô men kiểu ống lồng phát hiện lực và hướng đánh lái bằng sự thay đổi mật độ đường sức từ giữa phần nhô của trục vào và cuộn dây.
(2) Trong cảm biến mô men kiểu vòng, trục vào làm bằng vật liệu từ tính và có dạng nhô.
(3) Kiểu trợ lực cột lái có cảm biến mô men và mô tơ lắp tại bánh răng nhỏ của cơ cấu lái, cấp lực phụ cho bánh răng đó.
(4) Cảm biến mô men dùng Hall IC bố trí gông từ trên trục vào và nam châm đa cực trên trục ra.', NULL, '(1)', '(1) đúng với cảm biến kiểu sleeve. Kiểu trợ lực cột lái cấp lực trên cột lái; cấp lực ở pinion là kiểu pinion assist. Với cảm biến Hall trong đề, nam châm đa cực ở trục vào và gông từ ở trục ra, nên (4) đảo vị trí.', '[{"term": "操舵力", "reading": "そうだりょく", "meaning": "lực đánh lái"}, {"term": "磁力線密度", "reading": "じりょくせんみつど", "meaning": "mật độ đường sức từ"}, {"term": "磁性体", "reading": "じせいたい", "meaning": "vật liệu từ tính"}]'::jsonb, 23);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Technology', 24, 'ブレーキ装置に関する記述として、適切なものは次のうちどれか。
(1) ブレーキ液の沸点は、ブレーキ液に含まれる水分の量に大きく左右され、水分量が多いほど上昇する。
(2) ブレーキは、自動車の運動エネルギを熱エネルギに変えて制動する装置である。
(3) 制動距離とは、空走距離と停止距離をあわせたものをいう。
(4) ドラム・ブレーキは、ディスク・ブレーキに比べて放熱効果がよいので、フェードしにくい。', 'Trong các mô tả về hệ thống phanh sau đây, mô tả nào phù hợp?
(1) Nhiệt độ sôi của dầu phanh phụ thuộc nhiều vào lượng nước trong dầu; nước càng nhiều thì nhiệt độ sôi càng tăng.
(2) Phanh là thiết bị giảm tốc bằng cách chuyển động năng của xe thành nhiệt năng.
(3) Quãng đường phanh là tổng quãng đường phản ứng và quãng đường dừng.
(4) Phanh tang trống tản nhiệt tốt hơn phanh đĩa nên khó bị suy giảm hiệu lực do nhiệt.', NULL, '(2)', '(2) đúng theo chuyển đổi năng lượng do ma sát. Nước làm giảm nhiệt độ sôi dầu phanh. Quãng đường dừng = quãng đường phản ứng + quãng đường phanh. Phanh đĩa tản nhiệt tốt hơn tang trống nên chống fade tốt hơn.', '[{"term": "沸点", "reading": "ふってん", "meaning": "nhiệt độ sôi"}, {"term": "制動距離", "reading": "せいどうきょり", "meaning": "quãng đường phanh"}, {"term": "空走距離", "reading": "くうそうきょり", "meaning": "quãng đường phản ứng"}]'::jsonb, 24);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Technology', 25, '図に示す電子制御式ABSの油圧回路において、保持ソレノイド・バルブと減圧ソレノイド・バルブに関する記述として、適切なものは次のうちどれか。ただし、図の油圧回路は、通常制動時を表す。
(1) 減圧ソレノイド・バルブは、増圧作動時に通電ONとなり、ポートBを開く。
(2) 減圧ソレノイド・バルブは、保持作動時に通電ONとなり、ポートBを開く。
(3) 保持ソレノイド・バルブは、増圧作動時に通電ONとなり、ポートAを閉じる。
(4) 保持ソレノイド・バルブは、減圧作動時に通電ONとなり、ポートAを閉じる。

![Hình câu 25](images/m25.png)', 'Trong mạch thủy lực ABS điều khiển điện tử ở hình, mô tả nào về van điện từ giữ áp và van điện từ giảm áp là phù hợp? Mạch trong hình biểu thị phanh thông thường.
(1) Khi tăng áp, van điện từ giảm áp được cấp điện ON và mở cửa B.
(2) Khi giữ áp, van điện từ giảm áp được cấp điện ON và mở cửa B.
(3) Khi tăng áp, van điện từ giữ áp được cấp điện ON và đóng cửa A.
(4) Khi giảm áp, van điện từ giữ áp được cấp điện ON và đóng cửa A.

**Nhãn hình:** ポートA/B: cửa A/B; マスタ・シリンダ: xi lanh chính; ポンプ: bơm; 保持ソレノイド・バルブ: van điện từ giữ áp; 減圧ソレノイド・バルブ: van điện từ giảm áp; リザーバ: bình chứa; ハイドロリック・ユニット: cụm thủy lực; ブレーキ・キャリパ: cùm phanh; 油圧（液圧）回路: mạch áp suất dầu (chất lỏng); 駆動信号: tín hiệu điều khiển; ECU: bộ điều khiển điện tử.', NULL, '(4)', '(4) đúng: giảm áp cần đóng đường từ xi lanh chính bằng van giữ áp ON và mở đường xả qua van giảm áp ON. Giữ áp: van giữ ON, van giảm OFF. Tăng áp: van giữ OFF mở A, van giảm OFF đóng B. Chú ý hình thể hiện trạng thái phanh thường, không phải giảm áp.', '[{"term": "保持", "reading": "ほじ", "meaning": "giữ"}, {"term": "減圧", "reading": "げんあつ", "meaning": "giảm áp"}, {"term": "通電", "reading": "つうでん", "meaning": "cấp điện"}]'::jsonb, 25);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Technology', 26, 'エアコンに関する記述として、不適切なものは次のうちどれか。
(1) サブクール式のコンデンサでは、レシーバ部でガス状冷媒と液状冷媒に分離して、液状冷媒をサブクール部に送り、更に冷却することで冷房性能の向上を図っている。
(2) エキスパンション・バルブは、エバポレータ内における冷媒の液化状態に応じて噴射する冷媒の量を調節する。
(3) ハイブリッド自動車や電気自動車（EV）などに用いられている電動式コンプレッサは、一般にスクロール式が採用されている。
(4) リヒート方式では、ヒータ・コアに流れるエンジン冷却水の流量をウォータ・バルブによって変化させることで、吹き出し温度の調整を行う。', 'Trong các mô tả về điều hòa không khí sau đây, mô tả nào không phù hợp?
(1) Bộ ngưng tụ kiểu subcool tách môi chất khí và lỏng tại phần bình chứa, đưa môi chất lỏng đến phần làm lạnh phụ để làm lạnh thêm và tăng hiệu quả làm mát.
(2) Van tiết lưu điều chỉnh lượng môi chất phun theo trạng thái hóa lỏng của môi chất trong giàn bay hơi.
(3) Máy nén điện dùng trên xe hybrid và xe điện (EV) thường là loại scroll.
(4) Phương pháp tái gia nhiệt điều chỉnh nhiệt độ khí thổi ra bằng van nước thay đổi lưu lượng nước làm mát động cơ qua giàn sưởi.', NULL, '(2)', 'Đáp án chính thức là (2): van tiết lưu phản ứng với trạng thái bay hơi/độ quá nhiệt tại đầu ra giàn bay hơi, không phải sự hóa lỏng bên trong giàn. Giàn ngưng tụ hóa lỏng môi chất, giàn bay hơi làm nó bay hơi để lấy nhiệt. Phân biệt hai quá trình này.', '[{"term": "冷媒", "reading": "れいばい", "meaning": "môi chất lạnh"}, {"term": "液化", "reading": "えきか", "meaning": "hóa lỏng"}, {"term": "吹き出し温度", "reading": "ふきだしおんど", "meaning": "nhiệt độ khí thổi ra"}]'::jsonb, 26);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Technology', 27, 'ホイール・アライメントに関する記述として、適切なものは次のうちどれか。
(1) 旋回時に車体が傾斜した場合のキャンバ変化は、独立懸架式ではほとんど変化しないが、車軸懸架式では大きく変化する。
(2) フロント・ホイールを横方向から見て、キング・ピンの頂部が、進行方向（前進）に対して後方に傾いているものをマイナス・キャスタという。
(3) キャンバ・スラストは、キャンバ角が大きくなるに伴って減少する。
(4) キャスタを設けることにより、キング・ピン軸が回転すると、車体を持ち上げようとする力と、車体をもとの水平状態（ホイールを直進状態）に戻そうとする復元力が生まれることで直進性が保たれる。', 'Trong các mô tả về các góc đặt bánh xe sau đây, mô tả nào phù hợp?
(1) Khi thân xe nghiêng trong lúc quay vòng, camber của treo độc lập gần như không đổi nhưng của treo cầu liền thay đổi nhiều.
(2) Nhìn bánh trước từ bên hông, nếu đỉnh trụ đứng nghiêng về sau so với hướng tiến thì gọi là caster âm.
(3) Lực ngang do camber giảm khi góc camber tăng.
(4) Nhờ bố trí caster, khi trục trụ đứng quay sẽ xuất hiện lực nâng thân xe và lực phục hồi đưa thân về trạng thái ngang ban đầu (bánh xe thẳng), giúp giữ khả năng đi thẳng.', NULL, '(4)', '(4) đúng về tác dụng tự trả lái. Đỉnh trụ đứng nghiêng về sau là caster dương. Lực ngang do camber tăng theo góc trong phạm vi làm việc. Khi thân nghiêng, camber ở cầu liền ít thay đổi hơn treo độc lập.', '[{"term": "独立懸架式", "reading": "どくりつけんかしき", "meaning": "treo độc lập"}, {"term": "復元力", "reading": "ふくげんりょく", "meaning": "lực phục hồi"}, {"term": "直進性", "reading": "ちょくしんせい", "meaning": "khả năng đi thẳng"}]'::jsonb, 27);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Technology', 28, 'フレーム及びボデーに関する記述として、適切なものは次のうちどれか。
(1) フレームの亀裂部分に電気溶接をする場合、フレームの板厚、溶接電流の大小などに関係なく、溶接棒はできるだけ太いものを選ぶ必要がある。
(2) モノコック・ボデーは、サスペンションなどからの振動や騒音が伝わりにくいので、防音や防振に優れている。
(3) ボデーの安全構造は、衝突時のエネルギを効率よく吸収し、このエネルギをボデー骨格全体に分散させ客室の変形を最小限に抑えるようにしている。
(4) モノコック・ボデーは、ボデー自体がフレームの役目を担うため、質量を小さくすることができない。', 'Trong các mô tả về khung và thân xe sau đây, mô tả nào phù hợp?
(1) Khi hàn điện chỗ nứt của khung, phải chọn que hàn càng lớn càng tốt bất kể chiều dày tấm và cường độ dòng hàn.
(2) Thân liền khối khó truyền rung và tiếng ồn từ hệ thống treo nên cách âm và chống rung tốt.
(3) Kết cấu an toàn thân xe hấp thụ hiệu quả năng lượng va chạm, phân bố năng lượng ra toàn bộ khung xương thân và hạn chế biến dạng khoang hành khách đến mức nhỏ nhất.
(4) Thân liền khối tự đảm nhiệm vai trò khung nên không thể giảm khối lượng.', NULL, '(3)', '(3) đúng: kết cấu hấp thụ và phân bố lực phải bảo vệ khoang hành khách. Que hàn phải phù hợp chiều dày và dòng hàn. Thân liền khối có ưu điểm giảm khối lượng nhưng dễ truyền rung và tiếng ồn, cần biện pháp cách ly riêng.', '[{"term": "亀裂", "reading": "きれつ", "meaning": "vết nứt"}, {"term": "板厚", "reading": "いたあつ", "meaning": "chiều dày tấm"}, {"term": "溶接棒", "reading": "ようせつぼう", "meaning": "que hàn"}, {"term": "骨格", "reading": "こっかく", "meaning": "khung xương"}]'::jsonb, 28);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Strategy', 29, '外部診断器（スキャン・ツール）に関する記述として、不適切なものは次のうちどれか。
(1) 作業サポートは、外部診断器からECUに指令を出して、アクチュエータを任意に駆動及び停止ができ、機能点検などが容易に行える。
(2) フリーズ・フレーム・データを確認することで、ダイアグノーシス・コードを記憶した原因の究明につながる。
(3) データ・モニタとは、ECUにおけるセンサからの入力値やアクチュエータへの出力値などを複数表示することができ、それらを比較・確認することで迅速な点検・整備ができる。
(4) 外部診断器でダイアグノーシス・コードの消去作業を行うと、ダイアグノーシス・コードとフリーズ・フレーム・データが消去することができ、時計及びラジオなどの再設定の必要がない。', 'Trong các mô tả về thiết bị chẩn đoán ngoài (máy quét) sau đây, mô tả nào không phù hợp?
(1) Chức năng hỗ trợ công việc gửi lệnh từ máy chẩn đoán đến ECU để tùy ý chạy hoặc dừng bộ chấp hành, giúp kiểm tra chức năng dễ dàng.
(2) Kiểm tra dữ liệu freeze frame giúp tìm nguyên nhân khiến mã chẩn đoán được lưu.
(3) Giám sát dữ liệu có thể hiển thị nhiều giá trị cảm biến đầu vào và lệnh đầu ra đến bộ chấp hành của ECU; so sánh và xác nhận các giá trị giúp kiểm tra, bảo dưỡng nhanh.
(4) Xóa mã bằng máy chẩn đoán có thể xóa mã chẩn đoán và dữ liệu freeze frame mà không cần đặt lại đồng hồ, radio.', NULL, '(1)', '(1) mô tả phép thử chủ động (active test), không phải tên chức năng hỗ trợ công việc nêu trong đề. Freeze frame lưu điều kiện lúc phát hiện lỗi; data monitor hiển thị dữ liệu để đối chiếu. Xóa lỗi bằng công cụ không tương đương ngắt ắc quy.', '[{"term": "外部診断器", "reading": "がいぶしんだんき", "meaning": "máy chẩn đoán ngoài"}, {"term": "究明", "reading": "きゅうめい", "meaning": "tìm rõ nguyên nhân"}, {"term": "指令", "reading": "しれい", "meaning": "lệnh"}]'::jsonb, 29);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Strategy', 30, 'ツイスト・ペア線を用いたCAN通信に関する記述として、不適切なものは次のうちどれか。
(1) 一端の終端抵抗が断線した場合、耐ノイズ性には影響はないが、通信速度に影響を与え、ダイアグノーシス・コードが出力されることがある。
(2) 複数のECUが同時に送信を始めてしまった場合には、データ・フレーム同士が衝突してしまうため、各ECUは、アイデンティファイヤ・フィールドにより優先度が高いデータ・フレームを優先して送信する。
(3) 各ECUは、各センサの情報などをデータ・フレームとして、バス・ライン上に送信（定期送信データ）している。
(4) CAN通信は、一つのECUが複数のデータ・フレームを送信したり、バス・ライン上のデータを必要とする複数のECUが同時にデータ・フレームを受信することができる。', 'Trong các mô tả về truyền thông CAN dùng dây xoắn đôi sau đây, mô tả nào không phù hợp?
(1) Nếu điện trở kết thúc ở một đầu bị đứt, khả năng chống nhiễu không bị ảnh hưởng nhưng tốc độ truyền bị ảnh hưởng và có thể xuất hiện mã chẩn đoán.
(2) Khi nhiều ECU đồng thời bắt đầu truyền, các khung dữ liệu va chạm nhau nên ECU ưu tiên truyền khung có độ ưu tiên cao theo trường định danh.
(3) Mỗi ECU gửi thông tin cảm biến dưới dạng khung dữ liệu lên đường bus (dữ liệu truyền định kỳ).
(4) Trong CAN, một ECU có thể gửi nhiều khung dữ liệu và nhiều ECU cần dữ liệu trên bus có thể đồng thời nhận một khung.', NULL, '(1)', '(1) sai: điện trở kết thúc giúp hạn chế phản xạ tín hiệu và bảo đảm chất lượng tín hiệu; đứt điện trở có thể làm truyền không ổn định. Không coi lỗi này là cơ chế tự thay đổi tốc độ bit. CAN phân xử theo định danh và cho phép nhiều nút nhận cùng dữ liệu.', '[{"term": "終端抵抗", "reading": "しゅうたんていこう", "meaning": "điện trở kết thúc"}, {"term": "断線", "reading": "だんせん", "meaning": "đứt mạch"}, {"term": "耐ノイズ性", "reading": "たいノイズせい", "meaning": "khả năng chống nhiễu"}]'::jsonb, 30);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Strategy', 31, '図に示す電気回路において、電圧計Vが示す値として、適切なものは次のうちどれか。ただし、バッテリ、配線等の抵抗はないものとする。
(1) 4.0V
(2) 6.2V
(3) 8.0V
(4) 9.8V

![Hình câu 31](images/m31.png)', 'Trong mạch điện ở hình, giá trị nào mà vôn kế V chỉ là phù hợp? Giả sử ắc quy, dây dẫn và các phần tương tự không có điện trở.
(1) 4.0V
(2) 6.2V
(3) 8.0V
(4) 9.8V

**Nhãn hình:** V: vôn kế; nguồn 12V; điện trở nối tiếp 2Ω và 6Ω; nhánh song song 20Ω và 5Ω.', NULL, '(1)', 'Điện trở song song 20Ω và 5Ω: R = 20×5/(20+5) = 4Ω. Tổng mạch 2+4+6 = 12Ω, dòng mạch 12V/12Ω = 1A. Vôn kế mắc hai đầu nhánh song song nên V = 1×4 = 4.0V, chọn (1). Không lấy điện áp toàn bộ nguồn.', '[{"term": "電圧計", "reading": "でんあつけい", "meaning": "vôn kế"}, {"term": "配線", "reading": "はいせん", "meaning": "dây dẫn"}, {"term": "抵抗", "reading": "ていこう", "meaning": "điện trở"}]'::jsonb, 31);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Management', 32, 'オクタン価に関する記述として、適切なものは次のうちどれか。
(1) 直留ガソリンと分解ガソリンの混合割合をいう。
(2) ガソリンの揮発性を示す数値である。
(3) ガソリンのアンチノック性を示す数値である。
(4) ガソリンに含まれるイソオクタンの混合割合をいう。', 'Trong các mô tả về chỉ số octan sau đây, mô tả nào phù hợp?
(1) Là tỷ lệ trộn xăng chưng cất trực tiếp với xăng cracking.
(2) Là số biểu thị tính bay hơi của xăng.
(3) Là số biểu thị khả năng chống kích nổ của xăng.
(4) Là tỷ lệ isooctan có trong xăng.', NULL, '(3)', '(3) đúng. Chỉ số octan so sánh khả năng chống kích nổ với nhiên liệu chuẩn; nó không trực tiếp biểu thị phần trăm isooctan thực có trong xăng thương mại, cũng không đo tính bay hơi.', '[{"term": "揮発性", "reading": "きはつせい", "meaning": "tính bay hơi"}, {"term": "直留ガソリン", "reading": "ちょくりゅうガソリン", "meaning": "xăng chưng cất trực tiếp"}, {"term": "混合割合", "reading": "こんごうわりあい", "meaning": "tỷ lệ trộn"}]'::jsonb, 32);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Management', 33, '図に示す油圧装置でピストンAの直径が14mm、ピストンBの直径が42mmの場合、ピストンAを0.5kNの力で押したとき、ピストンBにかかる力として、適切なものは次のうちどれか。
(1) 1,500N
(2) 2,300N
(3) 4,500N
(4) 5,700N

![Hình câu 33](images/m33.png)', 'Trong thiết bị thủy lực ở hình, đường kính pít tông A là 14mm và pít tông B là 42mm. Khi đẩy A với lực 0.5kN, lực nào tác dụng lên B là phù hợp?
(1) 1,500N
(2) 2,300N
(3) 4,500N
(4) 5,700N

**Nhãn hình:** ピストンA/B: pít tông A/B; オイル: dầu; mũi tên vào A: 0.5kN; mũi tên ở B: lực đầu ra.', NULL, '(3)', 'Theo định luật Pascal, F_B/F_A = A_B/A_A = (42/14)² = 9. Đổi 0.5kN = 500N; F_B = 500×9 = 4,500N, chọn (3). Phải bình phương tỷ số đường kính vì lực tỷ lệ với diện tích.', '[{"term": "油圧装置", "reading": "ゆあつそうち", "meaning": "thiết bị thủy lực"}, {"term": "直径", "reading": "ちょっけい", "meaning": "đường kính"}, {"term": "押す", "reading": "おす", "meaning": "đẩy"}]'::jsonb, 33);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Management', 34, '自動車の材料に用いられる鉄鋼に関する記述として、不適切なものは次のうちどれか。
(1) 普通鋳鉄は、破断面がねずみ色で、フライホイールやブレーキ・ドラムなどに使用されている。
(2) 球状黒鉛鋳鉄は、普通鋳鉄に含まれる黒鉛を球状化させるために、マグネシウムなどの金属を少量加えて、強度や耐摩耗性などを向上させたものである。
(3) 合金鋳鉄は、普通鋳鉄にクロム、モリブデン、ニッケルなどの金属を一種類又は数種類加えたもので、カムシャフトやシリンダ・ライナなどに使用されている。
(4) 普通鋼（炭素鋼）は、硬鋼と軟鋼に分類され、硬鋼は軟鋼より炭素を含む量が少ない。', 'Trong các mô tả về sắt thép dùng làm vật liệu ô tô sau đây, mô tả nào không phù hợp?
(1) Gang thông thường có mặt gãy màu xám, được dùng làm bánh đà và tang trống phanh.
(2) Gang cầu được thêm lượng nhỏ kim loại như magiê để biến graphit trong gang thông thường thành dạng cầu, tăng độ bền và khả năng chống mòn.
(3) Gang hợp kim là gang thông thường được thêm một hoặc nhiều kim loại như crom, molypden, niken; dùng làm trục cam và ống lót xi lanh.
(4) Thép thông thường (thép cacbon) chia thành thép cứng và thép mềm; thép cứng chứa ít cacbon hơn thép mềm.', NULL, '(4)', '(4) đảo quan hệ hàm lượng cacbon. Thép cứng có lượng cacbon cao hơn thép mềm. Không nhầm gang cầu với gang hợp kim: tên đầu mô tả hình dạng graphit, tên sau nhấn mạnh thành phần hợp kim.', '[{"term": "球状黒鉛鋳鉄", "reading": "きゅうじょうこくえんちゅうてつ", "meaning": "gang cầu"}, {"term": "破断面", "reading": "はだんめん", "meaning": "mặt gãy"}, {"term": "炭素鋼", "reading": "たんそこう", "meaning": "thép cacbon"}]'::jsonb, 34);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Management', 35, '図に示すギヤ（歯車）に関する次の文章の［a］と［b］に当てはまるものとして、下の組み合わせのうち、適切なものはどれか。
図1は、［a］と呼ばれ、トランスミッションなどに用いられており、図2は、［b］と呼ばれ、ファイナル・ギヤなどに用いられている。
| 選択肢 | ［a］ | ［b］ |
| --- | --- | --- |
| 1 | ヘリカル・ギヤ | スパイラル・ベベル・ギヤ |
| 2 | スパー・ギヤ | スパイラル・ベベル・ギヤ |
| 3 | ヘリカル・ギヤ | ハイポイド・ギヤ |
| 4 | スパー・ギヤ | ハイポイド・ギヤ |

![Hình câu 35](images/m35.png)', 'Với các bánh răng ở hình, tổ hợp nào điền đúng vào ［a］ và ［b］?
Hình 1 gọi là ［a］, dùng trong hộp số và các cơ cấu tương tự; hình 2 gọi là ［b］, dùng cho truyền lực cuối và các cơ cấu tương tự.
| Lựa chọn | ［a］ | ［b］ |
| --- | --- | --- |
| 1 | Bánh răng trụ răng nghiêng | Bánh răng côn xoắn |
| 2 | Bánh răng trụ răng thẳng | Bánh răng côn xoắn |
| 3 | Bánh răng trụ răng nghiêng | Bánh răng hypoid |
| 4 | Bánh răng trụ răng thẳng | Bánh răng hypoid |

**Nhãn hình:** 図1/図2: hình 1/hình 2.', NULL, '(1)', 'Chọn (1). Hình 1 có răng nghiêng trên bánh trụ. Hình 2 là bánh răng côn xoắn, hai trục giao nhau. Hypoid có độ lệch giữa hai trục; cần quan sát vị trí trục, không chỉ nhìn răng cong.', '[{"term": "歯車", "reading": "はぐるま", "meaning": "bánh răng"}, {"term": "ヘリカル・ギヤ", "reading": "ヘリカル・ギヤ", "meaning": "bánh răng trụ răng nghiêng"}, {"term": "ファイナル・ギヤ", "reading": "ファイナル・ギヤ", "meaning": "bộ truyền lực cuối"}]'::jsonb, 35);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Management', 36, '「道路運送車両の保安基準」及び「道路運送車両の保安基準の細目を定める告示」に照らし、かじ取装置において基準に適合しないものに関する次の文章の［a］に当てはまるものとして、適切なものはどれか。
4輪以上の自動車のかじ取車輪をサイドスリップ・テスタを用いて計測した場合の横滑り量が、走行1mにつき［a］を超えるもの。ただし、その輪数が4輪以上の自動車のかじ取車輪をサイドスリップ・テスタを用いて計測した場合に、その横滑り量が、指定自動車等の自動車製作者等がかじ取装置について安全な運行を確保できるものとして指定する横滑り量の範囲内にある場合にあっては、この限りでない。
(1) 2mm
(2) 3mm
(3) 4mm
(4) 5mm', 'Theo “Tiêu chuẩn an toàn phương tiện vận tải đường bộ” và “Thông báo quy định chi tiết Tiêu chuẩn an toàn phương tiện vận tải đường bộ”, giá trị nào điền vào ［a］ để mô tả hệ thống lái không đạt tiêu chuẩn?
Xe có từ 4 bánh trở lên có lượng trượt ngang của bánh dẫn hướng đo bằng máy thử side slip vượt quá ［a］ trên mỗi 1m di chuyển. Tuy nhiên, quy định này không áp dụng nếu lượng trượt ngang đo bằng máy side slip của bánh dẫn hướng trên xe từ 4 bánh trở lên nằm trong phạm vi mà nhà sản xuất xe thuộc loại xe được chỉ định và các chủ thể tương tự quy định là bảo đảm vận hành an toàn đối với hệ thống lái.
(1) 2mm
(2) 3mm
(3) 4mm
(4) 5mm', NULL, '(4)', 'Chọn (4): ngưỡng chung là 5mm trên 1m. Phải giữ ngoại lệ theo phạm vi nhà sản xuất chỉ định; không áp dụng máy móc ngưỡng chung khi đề đã nêu ngoại lệ. Đây là lượng trượt ngang đo được, không phải góc đặt bánh.', '[{"term": "保安基準", "reading": "ほあんきじゅん", "meaning": "tiêu chuẩn an toàn"}, {"term": "横滑り量", "reading": "よこすべりりょう", "meaning": "lượng trượt ngang"}, {"term": "適合", "reading": "てきごう", "meaning": "phù hợp tiêu chuẩn"}]'::jsonb, 36);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Management', 37, '「自動車点検基準」の別表第2（自家用乗用自動車等の日常点検基準）に規定されている点検内容として、適切なものは次のうちどれか。
(1) マスタ・シリンダ、ホイール・シリンダ及びディスク・キャリパの液漏れがないこと。
(2) パワー・ステアリング装置のベルトの緩み及び損傷がないこと。
(3) ブレーキ・ペダルの踏みしろが適当で、ブレーキのききが十分であること。
(4) バッテリのターミナル部の接続状態が不良でないこと。', 'Trong các mô tả về nội dung kiểm tra theo Bảng 2 của “Tiêu chuẩn kiểm tra ô tô” (kiểm tra hằng ngày xe con tư nhân và các xe tương tự) sau đây, mô tả nào phù hợp?
(1) Không rò dầu ở xi lanh chính, xi lanh bánh xe và cùm phanh đĩa.
(2) Dây đai hệ thống trợ lực lái không bị lỏng hoặc hư hỏng.
(3) Hành trình đạp bàn đạp phanh phù hợp và hiệu lực phanh đầy đủ.
(4) Tình trạng kết nối đầu cực ắc quy không kém.', NULL, '(3)', '(3) thuộc kiểm tra hằng ngày. Không nhầm kiểm tra hằng ngày do người dùng thực hiện với kiểm tra định kỳ các bộ phận như rò dầu xi lanh, dây đai trợ lực và đầu cực. Kiểm tra hằng ngày của ắc quy tập trung lượng dung dịch.', '[{"term": "日常点検", "reading": "にちじょうてんけん", "meaning": "kiểm tra hằng ngày"}, {"term": "踏みしろ", "reading": "ふみしろ", "meaning": "hành trình đạp"}, {"term": "液漏れ", "reading": "えきもれ", "meaning": "rò chất lỏng"}]'::jsonb, 37);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Management', 38, '「道路運送車両の保安基準」及び「道路運送車両の保安基準の細目を定める告示」に照らし、最高速度が100km/hの四輪の小型自動車の方向指示器に関する次の文章の［a］と［b］に当てはまるものとして、下の組み合わせのうち、適切なものはどれか。
自動車には、方向指示器を自動車の車両中心線上の前方及び後方［a］の距離から照明部が見通すことのできる位置に少なくとも左右1個ずつ備えること。また、方向指示器の灯光の色は、［b］であること。
| 選択肢 | ［a］ | ［b］ |
| --- | --- | --- |
| 1 | 30m | 橙色 |
| 2 | 30m | 白色又は青色 |
| 3 | 100m | 橙色 |
| 4 | 100m | 白色又は青色 |', 'Theo “Tiêu chuẩn an toàn phương tiện vận tải đường bộ” và thông báo quy định chi tiết, với đèn báo rẽ của ô tô cỡ nhỏ bốn bánh có tốc độ tối đa 100km/h, tổ hợp nào điền đúng vào ［a］ và ［b］?
Xe phải có ít nhất một đèn báo rẽ mỗi bên trái và phải, ở vị trí có thể nhìn thấy phần phát sáng từ khoảng cách ［a］ phía trước và sau trên đường tâm xe. Màu ánh sáng của đèn báo rẽ phải là ［b］.
| Lựa chọn | ［a］ | ［b］ |
| --- | --- | --- |
| 1 | 30m | Màu cam |
| 2 | 30m | Màu trắng hoặc xanh lam |
| 3 | 100m | Màu cam |
| 4 | 100m | Màu trắng hoặc xanh lam |', NULL, '(1)', 'Chọn (1): 30m và màu cam. Tốc độ tối đa 100km/h là điều kiện của loại xe được hỏi, không phải khoảng cách quan sát 100m. Cần đọc riêng điều kiện xe, vị trí quan sát và màu đèn.', '[{"term": "方向指示器", "reading": "ほうこうしじき", "meaning": "đèn báo rẽ"}, {"term": "車両中心線", "reading": "しゃりょうちゅうしんせん", "meaning": "đường tâm xe"}, {"term": "橙色", "reading": "だいだいいろ", "meaning": "màu cam"}]'::jsonb, 38);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Management', 39, '「道路運送車両の保安基準」に照らし、次の文章の［a］と［b］に当てはまるものとして、下の組み合わせのうち、適切なものはどれか。
自動車の軸重は、［a］を超えてはならない。また、自動車の輪荷重は、［b］を超えてはならない。ただし、牽引自動車のうち告示で定めるものを除く。
| 選択肢 | ［a］ | ［b］ |
| --- | --- | --- |
| 1 | 20t | 3t |
| 2 | 10t | 3t |
| 3 | 20t | 5t |
| 4 | 10t | 5t |', 'Theo “Tiêu chuẩn an toàn phương tiện vận tải đường bộ”, tổ hợp nào điền đúng vào ［a］ và ［b］?
Tải trọng trục xe không được vượt ［a］; tải trọng bánh xe không được vượt ［b］. Ngoại trừ những xe kéo được quy định trong thông báo.
| Lựa chọn | ［a］ | ［b］ |
| --- | --- | --- |
| 1 | 20t | 3t |
| 2 | 10t | 3t |
| 3 | 20t | 5t |
| 4 | 10t | 5t |', NULL, '(4)', 'Chọn (4): tải trục 10t, tải bánh 5t. Phân biệt tải trên cả một trục với tải ở một bên bánh; không cộng hoặc thay bằng tổng trọng lượng xe. Ngoại lệ cho xe kéo được chỉ định vẫn là một phần điều kiện của đề.', '[{"term": "軸重", "reading": "じくじゅう", "meaning": "tải trọng trục"}, {"term": "輪荷重", "reading": "りんかじゅう", "meaning": "tải trọng bánh"}, {"term": "牽引自動車", "reading": "けんいんじどうしゃ", "meaning": "xe kéo"}]'::jsonb, 39);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 112)', 'Management', 40, '「道路運送車両法」に照らし、自動車登録ファイルに登録を受けたものでなければ運行の用に供してはならない自動車として、該当しないものは次のうちどれか。
(1) 大型特殊自動車
(2) 四輪の小型自動車
(3) 軽自動車
(4) 普通自動車', 'Theo “Luật phương tiện vận tải đường bộ”, loại nào sau đây không thuộc nhóm ô tô chỉ được đưa vào vận hành sau khi đăng ký trong hồ sơ đăng ký ô tô?
(1) Ô tô chuyên dùng cỡ lớn
(2) Ô tô cỡ nhỏ bốn bánh
(3) Ô tô hạng nhẹ kei
(4) Ô tô thông thường', NULL, '(3)', 'Chọn (3): xe kei thuộc chế độ riêng và được loại khỏi nhóm đăng ký nêu trong câu. “Không thuộc nhóm” không có nghĩa được tự do lưu hành không thủ tục; chỉ xác định phạm vi của điều khoản đang hỏi. Từ phủ định 該当しない là điểm dễ bỏ sót.', '[{"term": "登録", "reading": "とうろく", "meaning": "đăng ký"}, {"term": "運行", "reading": "うんこう", "meaning": "vận hành"}, {"term": "軽自動車", "reading": "けいじどうしゃ", "meaning": "ô tô hạng nhẹ kei"}]'::jsonb, 40);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Technology', 1, 'ピストン・リングに関する記述として、不適切なものは次のうちどれか。
(1) ピストン・リングは、耐摩耗性、強じん性、耐熱性及びオイル保持性などが要求されるため、一般にコンプレッション・リングの材料は特殊鋳鉄又は炭素鋼で、オイル・リングは炭素鋼で作られている。
(2) フラッタ現象が起きると、ピストン・リングの機能が損なわれ、ガス漏れによるエンジン出力の低下、オイル消費量の増大、リング溝やリング上下面の異常摩耗などが促進される。
(3) バレル・フェース型のピストン・リングは、吸入行程では、シリンダ壁面と線接触し、また、燃焼（膨張）行程では、高い面圧でシリンダ壁面に密着しており、一般にセカンド・リングに用いられている。
(4) スカッフ現象は、オイルの不良や過度の荷重が加わったとき、あるいはオーバヒートした場合などに起こりやすい。', 'Trong các mô tả về xéc măng pít tông sau đây, mô tả nào không phù hợp?
(1) Xéc măng cần chống mòn, dai bền, chịu nhiệt và giữ dầu; vì vậy xéc măng khí thường làm bằng gang đặc biệt hoặc thép cacbon, còn xéc măng dầu bằng thép cacbon.
(2) Hiện tượng flutter làm suy giảm chức năng xéc măng, thúc đẩy giảm công suất do lọt khí, tăng tiêu hao dầu và mòn bất thường rãnh xéc măng cùng mặt trên, dưới xéc măng.
(3) Xéc măng mặt lồi barrel tiếp xúc đường với thành xi lanh trong kỳ nạp, áp sát thành xi lanh với áp suất bề mặt cao trong kỳ cháy (giãn nở), thường dùng làm xéc măng thứ hai.
(4) Hiện tượng xước dính dễ xảy ra khi dầu kém, chịu tải quá mức hoặc quá nhiệt.', NULL, '(3)', '(3) sai ở vị trí sử dụng: mặt barrel thường dùng cho xéc măng trên cùng. Mặt cong giúp tiếp xúc và làm kín tốt trong điều kiện thay đổi áp suất. Flutter là dao động xéc măng gây mất kín; scuff là xước dính do điều kiện ma sát bất lợi.', '[{"term": "強じん性", "reading": "きょうじんせい", "meaning": "tính dai bền"}, {"term": "面圧", "reading": "めんあつ", "meaning": "áp suất bề mặt"}, {"term": "耐摩耗性", "reading": "たいまもうせい", "meaning": "khả năng chống mòn"}]'::jsonb, 41);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Technology', 2, 'シリンダ・ヘッドとピストンで形成されるスキッシュ・エリアに関する記述として、適切なものは次のうちどれか。
(1) スキッシュ・エリアの厚み（クリアランス）が大きくなるほど渦流の流速は高くなる。
(2) 斜めスキッシュ・エリアは、斜め形状により吸入通路からの吸気がスムーズになり、強い渦流の発生が得られる。
(3) 吸入混合気に渦流を与えて、燃焼時間を長くすることで最高燃焼ガス温度の上昇を促進させている。
(4) 吸入混合気に渦流を与えて、吸入行程における火炎伝播の速度を高めている。', 'Trong các mô tả về vùng squish tạo bởi nắp xi lanh và pít tông sau đây, mô tả nào phù hợp?
(1) Bề dày (khe hở) vùng squish càng lớn thì tốc độ dòng xoáy càng cao.
(2) Vùng squish nghiêng giúp khí nạp từ đường nạp lưu thông êm nhờ hình dạng nghiêng và tạo được dòng xoáy mạnh.
(3) Tạo dòng xoáy cho hòa khí nạp, kéo dài thời gian cháy để thúc đẩy tăng nhiệt độ khí cháy cực đại.
(4) Tạo dòng xoáy cho hòa khí nạp để tăng tốc độ lan truyền lửa trong hành trình nạp.', NULL, '(2)', '(2) đúng. Hình dạng nghiêng hỗ trợ chuyển động của khí và tạo xoáy. Squish tăng tốc độ cháy, không kéo dài thời gian cháy. Khe hở tăng làm hiệu ứng ép đẩy giảm; không có lan truyền lửa của kỳ cháy trong hành trình nạp.', '[{"term": "吸入通路", "reading": "きゅうにゅうつうろ", "meaning": "đường nạp"}, {"term": "渦流", "reading": "かりゅう", "meaning": "dòng xoáy"}, {"term": "クリアランス", "reading": "クリアランス", "meaning": "khe hở"}]'::jsonb, 42);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Technology', 3, 'エンジンの性能に関する記述として、適切なものは次のうちどれか。
(1) 熱損失は、冷却水の温度、潤滑油の粘度のほかにエンジン回転速度の影響が大きい。
(2) ポンプ損失（ポンピング・ロス）は、燃焼室を通して冷却水へ失われる冷却損失、排気ガスにもちさられる排気損失、ふく射熱として周囲に放散されるふく射損失からなっている。
(3) 体積効率と充填効率は、平地や高山など気圧の低い場所でも差はほとんどない。
(4) 機械損失は、ピストン、ピストン・リング、各ベアリングなどの摩擦損失とウォータ・ポンプ、オイル・ポンプ、オルタネータなど補機駆動の損失からなっている。', 'Trong các mô tả về tính năng động cơ sau đây, mô tả nào phù hợp?
(1) Tổn thất nhiệt chịu ảnh hưởng lớn của vòng tua động cơ ngoài nhiệt độ nước làm mát và độ nhớt dầu bôi trơn.
(2) Tổn thất bơm (pumping loss) gồm tổn thất làm mát qua buồng cháy ra nước làm mát, tổn thất theo khí xả và tổn thất bức xạ tỏa ra xung quanh.
(3) Hiệu suất nạp thể tích và hiệu suất nạp theo khối lượng gần như không khác nhau cả ở đồng bằng lẫn nơi áp suất khí quyển thấp như núi cao.
(4) Tổn thất cơ học gồm ma sát pít tông, xéc măng, các ổ đỡ và tổn thất dẫn động bơm nước, bơm dầu, máy phát cùng thiết bị phụ.', NULL, '(4)', '(4) đúng. Tổn thất bơm là công cần cho trao đổi khí nạp và xả, không phải tổng các tổn thất nhiệt liệt kê ở (2). Độ nhớt dầu ảnh hưởng rõ đến tổn thất ma sát. Hiệu suất nạp thể tích và theo khối lượng khác nhau khi mật độ không khí thay đổi ở độ cao.', '[{"term": "粘度", "reading": "ねんど", "meaning": "độ nhớt"}, {"term": "補機駆動", "reading": "ほきくどう", "meaning": "dẫn động thiết bị phụ"}, {"term": "ふく射損失", "reading": "ふくしゃそんしつ", "meaning": "tổn thất bức xạ"}]'::jsonb, 43);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Technology', 4, '直巻式スタータの出力特性に関する次の文章の［a］から［c］に当てはまるものとして、下の組み合わせのうち、適切なものはどれか。
スタータにより、エンジンが回り始めて回転抵抗が減少すると、スタータの駆動トルクの方が［a］ので回転速度は上昇するが、逆向きの誘導起電力が［b］ので、アーマチュアに流れる電流が［c］し、エンジンは一定の回転速度で駆動される。
| 選択肢 | ［a］ | ［b］ | ［c］ |
| --- | --- | --- | --- |
| 1 | 大きい | 減る | 増加 |
| 2 | 大きい | 増える | 減少 |
| 3 | 小さい | 増える | 増加 |
| 4 | 小さい | 減る | 減少 |', 'Về đặc tính đầu ra của máy khởi động mắc nối tiếp, tổ hợp nào điền đúng từ ［a］ đến ［c］?
Khi máy khởi động làm động cơ bắt đầu quay và sức cản quay giảm, mô men dẫn động của máy khởi động ［a］ nên tốc độ tăng. Tuy nhiên, sức điện động cảm ứng ngược ［b］ khiến dòng điện trong phần ứng ［c］, và động cơ được kéo ở tốc độ quay ổn định.
| Lựa chọn | ［a］ | ［b］ | ［c］ |
| --- | --- | --- | --- |
| 1 | Lớn hơn | giảm | tăng |
| 2 | Lớn hơn | tăng | giảm |
| 3 | Nhỏ hơn | tăng | tăng |
| 4 | Nhỏ hơn | giảm | giảm |', NULL, '(2)', '(2) đúng. Khi mô men dẫn động lớn hơn mô men cản, tốc độ tăng. Sức điện động ngược tăng theo tốc độ làm điện áp hữu hiệu trên phần ứng giảm, dòng điện và mô men giảm cho đến khi cân bằng tải. Không nhầm sức điện động ngược với điện áp cấp.', '[{"term": "直巻式", "reading": "ちょくまきしき", "meaning": "kiểu mắc nối tiếp"}, {"term": "誘導起電力", "reading": "ゆうどうきでんりょく", "meaning": "sức điện động cảm ứng"}, {"term": "回転抵抗", "reading": "かいてんていこう", "meaning": "sức cản quay"}]'::jsonb, 44);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Technology', 5, '電子制御式スロットル装置に関する記述として、適切なものは次のうちどれか。
(1) トラクション・コントロール制御は、ブレーキECUなどからの信号によりスロットル・バルブを開閉し、エンジン出力を制御して走行安定性を確保している。
(2) スロットル・ポジション・センサは、スロットル・バルブ・シャフトの同軸上に取り付けられ、アクセル・ペダルの踏み込み角度を検出している。
(3) アイドル回転速度制御は、一般にISCV（アイドル・スピード・コントロール・バルブ）で行っている。
(4) スロットル・バルブの開度制御が通常モードのときは、スロットル・バルブ開度とアクセル・ペダルの踏み込み角度は比例する。', 'Trong các mô tả về hệ thống bướm ga điều khiển điện tử sau đây, mô tả nào phù hợp?
(1) Điều khiển kiểm soát lực kéo đóng mở bướm ga theo tín hiệu từ ECU phanh và các bộ điều khiển khác, điều khiển công suất động cơ để bảo đảm ổn định chạy xe.
(2) Cảm biến vị trí bướm ga lắp đồng trục với trục bướm ga, phát hiện góc đạp bàn đạp ga.
(3) Điều khiển tốc độ không tải thường thực hiện bằng ISCV (van điều khiển tốc độ không tải).
(4) Khi điều khiển độ mở bướm ga ở chế độ thông thường, độ mở bướm ga tỷ lệ thuận với góc đạp bàn đạp ga.', NULL, '(1)', '(1) đúng về phối hợp điều khiển lực kéo. Cảm biến bướm ga đo độ mở bướm ga; cảm biến bàn đạp ga đo góc đạp. Bướm ga điện tử có thể tự điều khiển lượng khí không tải; quan hệ bàn đạp–bướm ga được lập theo yêu cầu mô men nên không luôn tỷ lệ.', '[{"term": "走行安定性", "reading": "そうこうあんていせい", "meaning": "độ ổn định khi chạy"}, {"term": "開度", "reading": "かいど", "meaning": "độ mở"}, {"term": "踏み込み角度", "reading": "ふみこみかくど", "meaning": "góc đạp"}]'::jsonb, 45);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Technology', 6, 'コンロッド・ベアリングに要求される性質に関する記述として、不適切なものは次のうちどれか。
(1) 耐疲労性とは、ベアリングに繰り返し荷重が加えられても、その機械的性質が変化しにくい性質をいう。
(2) 耐食性とは、酸などにより腐食されにくい性質をいう。
(3) 埋没性のよいベアリングは、クランク・ピンに傷を付けやすい。
(4) 非焼付き性とは、ベアリングとクランク・ピンとに金属接触が起きた場合に、ベアリングが焼き付きにくい性質をいう。', 'Trong các mô tả về các tính chất cần có của bạc đầu to thanh truyền sau đây, mô tả nào không phù hợp?
(1) Độ bền mỏi là tính chất khó thay đổi tính chất cơ học dù bạc chịu tải lặp lại.
(2) Khả năng chống ăn mòn là tính khó bị ăn mòn bởi axit và các chất tương tự.
(3) Bạc có tính vùi hạt tốt dễ làm xước chốt khuỷu.
(4) Tính chống bó cháy là tính khó bị bó cháy khi bạc và chốt khuỷu tiếp xúc kim loại.', NULL, '(3)', '(3) sai: tính vùi hạt tốt giữ dị vật trong bề mặt bạc, giúp bảo vệ chốt khuỷu khỏi xước. Độ bền mỏi, chống ăn mòn và chống bó cháy là ba tính chất khác nhau; cần liên hệ đúng với tải lặp, hóa chất và tiếp xúc kim loại.', '[{"term": "耐食性", "reading": "たいしょくせい", "meaning": "khả năng chống ăn mòn"}, {"term": "繰り返し荷重", "reading": "くりかえしかじゅう", "meaning": "tải lặp lại"}, {"term": "非焼付き性", "reading": "ひやきつきせい", "meaning": "tính chống bó cháy"}]'::jsonb, 46);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Technology', 7, '吸排気装置における過給機に関する記述として、適切なものは次のうちどれか。
(1) 一般に、ターボ・チャージャに用いられているフル・フローティング・ベアリングの周速は、シャフトの周速と同じである。
(2) 2葉ルーツ式のスーパー・チャージャでは、ロータ1回転につき2回の吸入・吐出が行われる。
(3) ターボ・チャージャは、小型軽量で取り付け位置の自由度は高いが、排気エネルギの小さい低速回転域からの立ち上がりに遅れが生じ易い。
(4) 2葉ルーツ式のスーパー・チャージャには、過給圧が高くなって規定値以上になると、過給圧の一部を排気側へ逃がし、過給圧を規定値に制御するエア・バイパス・バルブが設けられている。', 'Trong các mô tả về bộ tăng áp trong hệ thống nạp xả sau đây, mô tả nào phù hợp?
(1) Thông thường tốc độ chu vi của bạc nổi hoàn toàn trong turbo bằng tốc độ chu vi trục.
(2) Bộ siêu nạp Roots hai thùy thực hiện hai lần hút và đẩy trong mỗi vòng quay rô to.
(3) Turbo nhỏ, nhẹ, có độ tự do cao về vị trí lắp nhưng dễ bị trễ đáp ứng khi tăng tốc từ vùng vòng tua thấp có năng lượng khí xả nhỏ.
(4) Bộ siêu nạp Roots hai thùy có van bypass khí; khi áp suất tăng áp vượt quy định, van xả một phần sang phía khí xả để giữ áp suất ở giá trị quy định.', NULL, '(3)', 'Chọn (3): turbo nhỏ, nhẹ nhưng có độ trễ khi năng lượng khí xả thấp. Ở Roots hai thùy, mỗi rô to chuyển hai khoang khí trong một vòng; cả cặp rô to tạo bốn lần hút và đẩy, nên (2) ghi hai lần là không đúng cách đếm của đề. Bạc nổi quay chậm hơn trục; van bypass hồi khí về phía hút, không xả sang phía khí xả.', '[{"term": "周速", "reading": "しゅうそく", "meaning": "tốc độ chu vi"}, {"term": "規定値", "reading": "きていち", "meaning": "giá trị quy định"}, {"term": "過給圧", "reading": "かきゅうあつ", "meaning": "áp suất tăng áp"}]'::jsonb, 47);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Technology', 8, '図に示すオルタネータ回路において、発電時（調整電圧以下のとき）の作動に関する次の文章の［a］から［c］に当てはまるものとして、下の組み合わせのうち、適切なものはどれか。
エンジンが始動され、オルタネータの回転が上昇すると、IC内の制御回路によりP端子の電圧を検出し、Tr₁は間欠的なON・OFF動作から連続［a］動作となり、十分な励磁電流が［b］に流れ、発電電圧が急速に上昇する。また、P端子電圧の上昇により、ICはTr₂を［c］してチャージ・ランプを消灯させ、B端子電圧がバッテリ電圧を超えると、バッテリに充電電流が流れる。
| 選択肢 | ［a］ | ［b］ | ［c］ |
| --- | --- | --- | --- |
| 1 | ON | ステータ・コイル | ON |
| 2 | ON | ロータ・コイル | OFF |
| 3 | OFF | ステータ・コイル | OFF |
| 4 | OFF | ロータ・コイル | OFF |

![Hình câu 8](images/o08.png)', 'Trong mạch máy phát ở hình, với hoạt động phát điện (khi điện áp bằng hoặc dưới điện áp điều chỉnh), tổ hợp nào điền đúng từ ［a］ đến ［c］?
Khi động cơ khởi động và tốc độ máy phát tăng, mạch điều khiển IC phát hiện điện áp cực P; Tr₁ chuyển từ đóng ngắt ON・OFF gián đoạn sang ［a］ liên tục. Dòng kích từ đủ lớn đi qua ［b］ làm điện áp phát tăng nhanh. Điện áp cực P tăng cũng khiến IC chuyển Tr₂ sang ［c］ để tắt đèn báo nạp. Khi điện áp cực B vượt điện áp ắc quy, dòng nạp chảy vào ắc quy.
| Lựa chọn | ［a］ | ［b］ | ［c］ |
| --- | --- | --- | --- |
| 1 | ON | Cuộn stato | ON |
| 2 | ON | Cuộn rô to | OFF |
| 3 | OFF | Cuộn stato | OFF |
| 4 | OFF | Cuộn rô to | OFF |

**Nhãn hình:** オルタネータ: máy phát; ステータ・コイル: cuộn stato; ロータ・コイル: cuộn rô to; イグニション・スイッチ: khóa điện; チャージ・ランプ: đèn báo nạp; バッテリ: ắc quy; 負荷: tải; IC式ボルテージ・レギュレータ: bộ điều áp IC. B, IG, S, L, F, P, E, Tr₁, Tr₂, IC giữ nguyên như hình.', NULL, '(2)', '(2) đúng. Tr₁ ON liên tục cấp kích từ cho rô to; stato là nơi sinh điện áp xoay chiều. Tr₂ OFF ngắt đường dòng qua đèn báo nạp nên đèn tắt. Cực P nhận tín hiệu phát điện, còn B là đầu ra công suất.', '[{"term": "間欠的", "reading": "かんけつてき", "meaning": "gián đoạn"}, {"term": "励磁電流", "reading": "れいじでんりゅう", "meaning": "dòng kích từ"}, {"term": "消灯", "reading": "しょうとう", "meaning": "tắt đèn"}]'::jsonb, 48);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Technology', 9, '点火順序が1－5－3－6－2－4の4サイクル直列6シリンダ・エンジンに関する次の文章の［a］と［b］に当てはまるものとして、下の組み合わせのうち、適切なものはどれか。
第3シリンダが圧縮上死点にあり、この位置からクランクシャフトを回転方向に回転させ、第5シリンダのバルブをオーバラップの上死点状態にするために必要な回転角度は［a］である。
その状態から更にクランクシャフトを回転方向に240°回転させたとき、圧縮上死点にあるのは［b］である。
| 選択肢 | ［a］ | ［b］ |
| --- | --- | --- |
| 1 | 240° | 第1シリンダ |
| 2 | 360° | 第3シリンダ |
| 3 | 240° | 第5シリンダ |
| 4 | 360° | 第6シリンダ |', 'Với động cơ 4 kỳ, 6 xi lanh thẳng hàng có thứ tự đánh lửa 1－5－3－6－2－4, tổ hợp nào điền đúng vào ［a］ và ［b］?
Xi lanh 3 ở điểm chết trên cuối kỳ nén. Từ vị trí này quay trục khuỷu theo chiều quay, góc cần thiết để van của xi lanh 5 ở trạng thái trùng điệp tại điểm chết trên là ［a］.
Từ trạng thái đó quay thêm 240° theo chiều quay, xi lanh ở điểm chết trên cuối kỳ nén là ［b］.
| Lựa chọn | ［a］ | ［b］ |
| --- | --- | --- |
| 1 | 240° | Xi lanh 1 |
| 2 | 360° | Xi lanh 3 |
| 3 | 240° | Xi lanh 5 |
| 4 | 360° | Xi lanh 6 |', NULL, '(1)', 'Khoảng cách đánh lửa 120°. Khi xi lanh 3 đánh lửa, xi lanh 5 đã qua điểm chết trên nén 120°. Nó cần thêm 240° để đạt điểm chết trên trùng điệp ở 360°. Tổng góc quay tiếp là 240°+240° = 480°; từ xi lanh 3 qua 6, 2, 4 rồi 1, nên chọn (1).', '[{"term": "回転角度", "reading": "かいてんかくど", "meaning": "góc quay"}, {"term": "直列", "reading": "ちょくれつ", "meaning": "thẳng hàng"}, {"term": "圧縮上死点", "reading": "あっしゅくじょうしてん", "meaning": "điểm chết trên cuối nén"}]'::jsonb, 49);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Technology', 10, '自動車の排気ガスに関する記述として、不適切なものは次のうちどれか。
(1) NOₓの発生は、理論空燃比付近で最大となり、それより空燃比が小さい（濃い）場合や大きい（薄い）場合は急激に低下する。
(2) 空気の供給不足などにより燃料が不完全燃焼したときのCOは、「2C＋O₂＝2CO」のように発生する。
(3) クエンチング・ゾーン（消炎層）にある燃え残りの混合気は、排気行程中にピストンにより押し出されて未燃ガスとして排出される。
(4) CO₂濃度は、理論空燃比付近で最小となり、それより空燃比が大きい（薄い）領域では増加する。', 'Trong các mô tả về khí xả ô tô sau đây, mô tả nào không phù hợp?
(1) NOₓ sinh ra nhiều nhất gần tỷ lệ không khí/nhiên liệu lý thuyết, giảm nhanh khi tỷ lệ thấp hơn (đậm) hoặc cao hơn (nhạt).
(2) CO sinh ra khi nhiên liệu cháy không hoàn toàn do thiếu không khí và các nguyên nhân tương tự, theo phản ứng “2C＋O₂＝2CO”.
(3) Hòa khí chưa cháy còn trong vùng dập lửa (lớp tắt lửa) bị pít tông đẩy ra trong kỳ xả và thải thành khí chưa cháy.
(4) Nồng độ CO₂ thấp nhất gần tỷ lệ không khí/nhiên liệu lý thuyết và tăng trong vùng tỷ lệ lớn hơn (nhạt).', NULL, '(4)', '(4) đảo xu hướng: CO₂ thường đạt cao gần tỷ lệ lý thuyết rồi giảm về phía hòa khí nhạt do dư không khí làm pha loãng. CO liên quan cháy thiếu oxy; HC chưa cháy liên quan lớp dập lửa. Không đánh đồng CO với CO₂.', '[{"term": "不完全燃焼", "reading": "ふかんぜんねんしょう", "meaning": "cháy không hoàn toàn"}, {"term": "消炎層", "reading": "しょうえんそう", "meaning": "lớp dập lửa"}, {"term": "未燃ガス", "reading": "みねんガス", "meaning": "khí chưa cháy"}]'::jsonb, 50);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Technology', 11, 'バッテリに関する記述として、不適切なものは次のうちどれか。
(1) 低アンチモン・バッテリは低コストが利点であるが、メンテナンス・フリー（MF）特性はハイブリッド・バッテリに比べて悪い。
(2) カルシウム・バッテリは、MF特性を向上させるために電極（正極・負極）にカルシウム（Ca）鉛合金を使用している。
(3) ハイブリッド・バッテリは、正極にカルシウム鉛合金、負極にアンチモン（Sb）鉛合金を使用している。
(4) 制御弁式バッテリは、電解液の蒸発がないことから補水できない構造となっておりメンテナンスは不要である。', 'Trong các mô tả về ắc quy sau đây, mô tả nào không phù hợp?
(1) Ắc quy ít antimon có ưu điểm giá thấp nhưng đặc tính không cần bảo dưỡng (MF) kém hơn ắc quy hybrid.
(2) Ắc quy canxi dùng hợp kim chì–canxi (Ca) ở điện cực dương và âm để cải thiện đặc tính MF.
(3) Ắc quy hybrid dùng hợp kim chì–canxi ở cực dương và hợp kim chì–antimon (Sb) ở cực âm.
(4) Ắc quy có van điều áp không có bay hơi dung dịch nên có cấu trúc không thể châm nước, không cần bảo dưỡng.', NULL, '(3)', 'Đáp án chính thức là (3): ắc quy hybrid trong phân loại này dùng hợp kim chì–antimon ở cực dương, chì–canxi ở cực âm. Đây là loại kết hợp vật liệu điện cực của ắc quy chì, không phải pin kéo của xe hybrid. Với loại van điều áp, tái hợp khí giảm mất nước; vẫn cần kiểm tra tình trạng theo quy định sử dụng.', '[{"term": "正極", "reading": "せいきょく", "meaning": "cực dương"}, {"term": "負極", "reading": "ふきょく", "meaning": "cực âm"}, {"term": "補水", "reading": "ほすい", "meaning": "châm nước"}]'::jsonb, 51);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Technology', 12, '点火制御装置に関する記述として、適切なものは次のうちどれか。
(1) ノック補正は、ノック・センサがノッキングを検出すると進角させ、ノッキングがなくなると遅角させる。
(2) 通電時間制御は、エンジン回転速度が高くなるに連れて、トランジスタがONする時期（一次電流が流れ始めるとき）を早めている。
(3) エンジン始動後のアイドリング時の基本進角は、インテーク・マニホールド圧力信号又は吸入空気量信号により、あらかじめ設定された点火時期に制御されている。
(4) アイドル安定化補正は、アイドル回転速度が低くなると点火時期を遅角し、高い場合は進角してアイドル回転速度の安定化を図っている。', 'Trong các mô tả về hệ thống điều khiển đánh lửa sau đây, mô tả nào phù hợp?
(1) Hiệu chỉnh kích nổ làm sớm góc khi cảm biến phát hiện kích nổ và làm muộn khi kích nổ hết.
(2) Điều khiển thời gian cấp điện làm sớm thời điểm transistor ON (bắt đầu dòng sơ cấp) khi vòng tua động cơ tăng.
(3) Góc đánh lửa cơ bản khi không tải sau khởi động được điều khiển đến thời điểm đặt trước theo tín hiệu áp suất ống góp nạp hoặc lượng khí nạp.
(4) Hiệu chỉnh ổn định không tải làm muộn đánh lửa khi vòng tua thấp, làm sớm khi vòng tua cao để ổn định vòng tua.', NULL, '(2)', '(2) đúng: ở vòng tua cao phải bắt đầu nạp năng lượng cuộn đánh lửa sớm hơn để bảo đảm thời gian dòng sơ cấp. Phát hiện kích nổ cần làm muộn góc. Ổn định không tải dùng sớm góc để tăng mô men khi vòng tua thấp và muộn góc để giảm mô men khi vòng tua cao.', '[{"term": "通電時間", "reading": "つうでんじかん", "meaning": "thời gian cấp điện"}, {"term": "一次電流", "reading": "いちじでんりゅう", "meaning": "dòng sơ cấp"}, {"term": "補正", "reading": "ほせい", "meaning": "hiệu chỉnh"}]'::jsonb, 52);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Technology', 13, '図に示す電気用図記号において、AとBの入力に対する出力Qの組み合わせとして、不適切なものはどれか。
| 選択肢 | 入力 A | 入力 B | 出力 Q |
| --- | --- | --- | --- |
| (1) | 1 | 0 | 0 |
| (2) | 1 | 1 | 0 |
| (3) | 0 | 0 | 1 |
| (4) | 0 | 1 | 1 |

![Hình câu 13](images/o13.png)', 'Với ký hiệu điện ở hình, tổ hợp đầu ra Q ứng với đầu vào A và B nào không phù hợp?
| Lựa chọn | Đầu vào A | Đầu vào B | Đầu ra Q |
| --- | --- | --- | --- |
| (1) | 1 | 0 | 0 |
| (2) | 1 | 1 | 0 |
| (3) | 0 | 0 | 1 |
| (4) | 0 | 1 | 1 |

**Nhãn hình:** 入力: đầu vào; 出力: đầu ra; A, B: đầu vào; Q: đầu ra; ≥1 kèm vòng tròn: cổng NOR.', NULL, '(4)', 'Ký hiệu ≥1 là OR, vòng tròn ở đầu ra là phủ định, nên đây là NOR: Q = NOT(A OR B). Với A=0, B=1 thì Q phải là 0. (4) ghi 1 nên không phù hợp. Chỉ khi cả hai đầu vào đều 0 mới có Q=1.', '[{"term": "入力", "reading": "にゅうりょく", "meaning": "đầu vào"}, {"term": "出力", "reading": "しゅつりょく", "meaning": "đầu ra"}, {"term": "図記号", "reading": "ずきごう", "meaning": "ký hiệu sơ đồ"}]'::jsonb, 53);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Technology', 14, 'スパーク・プラグに関する記述として、不適切なものは次のうちどれか。
(1) 混合気の空燃比が大き過ぎる場合は、着火ミスは発生しないが、逆に小さ過ぎる場合は、燃焼が円滑に行われないため、着火ミスが発生する。
(2) 高熱価型プラグは、低熱価型プラグと比較して、火炎にさらされる部分の表面積及びガス・ポケットの容積が小さい。
(3) スパーク・プラグの中心電極を細くすると、飛火性が向上するとともに着火性も向上する。
(4) 着火ミスは、電極の消炎作用が強過ぎるとき、又は吸入混合気の流速が高過ぎる（速過ぎる）場合に起きやすい。', 'Trong các mô tả về bugi sau đây, mô tả nào không phù hợp?
(1) Nếu tỷ lệ không khí/nhiên liệu quá lớn thì không có bỏ lửa; ngược lại nếu quá nhỏ, cháy không êm nên có bỏ lửa.
(2) Bugi chỉ số nhiệt cao có diện tích bề mặt tiếp xúc ngọn lửa và thể tích khoang khí nhỏ hơn loại chỉ số nhiệt thấp.
(3) Làm điện cực trung tâm mảnh hơn giúp tăng khả năng phóng tia lửa và khả năng mồi cháy.
(4) Bỏ lửa dễ xảy ra khi tác dụng dập lửa của điện cực quá mạnh hoặc tốc độ hòa khí nạp quá cao (quá nhanh).', NULL, '(1)', '(1) sai: cả hòa khí quá nhạt và quá đậm đều có thể vượt giới hạn cháy và gây bỏ lửa. Điện cực mảnh giúp tập trung điện trường và giảm dập lửa. Bugi chỉ số nhiệt cao tản nhiệt tốt với vùng tiếp xúc lửa nhỏ hơn.', '[{"term": "着火ミス", "reading": "ちゃっかミス", "meaning": "bỏ lửa"}, {"term": "飛火性", "reading": "ひかせい", "meaning": "khả năng phóng tia lửa"}, {"term": "消炎作用", "reading": "しょうえんさよう", "meaning": "tác dụng dập lửa"}]'::jsonb, 54);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Technology', 15, '電子制御式燃料噴射装置に関する記述として、適切なものは次のうちどれか。
(1) Dジェトロニック方式の基本噴射時間は、エア・フロー・メータで検出した吸入空気量と、クランク角センサにより検出したエンジン回転速度に基づいて算出される。
(2) 高抵抗型インジェクタは、抵抗の大きい導線をソレノイド・コイルに使用し、電流を大きくして発熱を防止している。
(3) インジェクタの噴射信号がONになり、電流が流れ始めてインジェクタが完全に駆動されるまでの燃料が噴射されていない時間を無効噴射時間（無効駆動時間）という。
(4) 始動時噴射時間は、エンジンの吸入空気温度によって決定する始動時基本噴射時間と、吸気温補正及び電圧補正によって決定される。', 'Trong các mô tả về hệ thống phun nhiên liệu điều khiển điện tử sau đây, mô tả nào phù hợp?
(1) Thời gian phun cơ bản của D-Jetronic tính theo lượng khí nạp đo bằng lưu lượng kế khí và vòng tua động cơ đo bằng cảm biến góc trục khuỷu.
(2) Kim phun điện trở cao dùng dây dẫn điện trở lớn trong cuộn điện từ, làm dòng lớn hơn để tránh phát nhiệt.
(3) Khoảng thời gian từ khi tín hiệu phun ON, dòng bắt đầu chạy đến khi kim phun hoạt động hoàn toàn nhưng nhiên liệu chưa được phun gọi là thời gian phun vô hiệu (thời gian tác động vô hiệu).
(4) Thời gian phun khi khởi động được xác định bằng thời gian phun cơ bản khởi động theo nhiệt độ khí nạp, cùng hiệu chỉnh nhiệt độ khí nạp và điện áp.', NULL, '(3)', '(3) là định nghĩa thời gian trễ mở kim phun. D-Jetronic dùng áp suất ống góp nạp cùng vòng tua, còn L-Jetronic dùng đo lượng khí. Điện trở cao giới hạn dòng, không làm dòng tăng. Thời gian phun khởi động cơ bản liên quan nhiệt độ nước làm mát, không chỉ nhiệt độ khí nạp.', '[{"term": "無効噴射時間", "reading": "むこうふんしゃじかん", "meaning": "thời gian phun vô hiệu"}, {"term": "導線", "reading": "どうせん", "meaning": "dây dẫn"}, {"term": "算出", "reading": "さんしゅつ", "meaning": "tính toán"}]'::jsonb, 55);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Technology', 16, 'ホイール・アライメントに関する記述として、不適切なものは次のうちどれか。
(1) キャスタがある場合は、車両の荷重によって車体をもとの水平状態（ホイールを直進状態）に戻そうとする復元力が生まれ直進性が保たれる。
(2) 旋回時に車体が傾斜した場合のキャンバ変化は、車軸懸架式ではほとんど変化しないが、独立懸架式では大きく変化する。
(3) フロント・ホイールを横方向から見て、キング・ピンの頂部が、進行方向（前進）に対して後方に傾いているものをプラス・キャスタという。
(4) 車両を前方から見ると、一般にキング・ピンは内側に傾けて取り付けられており、その中心線と鉛直線のなす角度をセット・バック角という。', 'Trong các mô tả về các góc đặt bánh xe sau đây, mô tả nào không phù hợp?
(1) Khi có caster, tải xe tạo lực phục hồi đưa thân về trạng thái ngang ban đầu (bánh xe thẳng), giúp giữ khả năng đi thẳng.
(2) Khi thân xe nghiêng trong quay vòng, camber của treo cầu liền gần như không đổi nhưng treo độc lập thay đổi nhiều.
(3) Nhìn bánh trước từ bên hông, đỉnh trụ đứng nghiêng về sau so với hướng tiến được gọi là caster dương.
(4) Nhìn từ trước xe, trụ đứng thường lắp nghiêng vào trong; góc giữa đường tâm trụ và đường thẳng đứng gọi là góc setback.', NULL, '(4)', '(4) sai: góc mô tả là góc nghiêng trụ đứng (kingpin inclination), không phải setback. Setback thể hiện độ lệch trước–sau giữa các bánh cùng trục. Caster nhìn từ bên hông, còn góc nghiêng trụ đứng nhìn từ phía trước.', '[{"term": "鉛直線", "reading": "えんちょくせん", "meaning": "đường thẳng đứng"}, {"term": "中心線", "reading": "ちゅうしんせん", "meaning": "đường tâm"}, {"term": "車軸懸架式", "reading": "しゃじくけんかしき", "meaning": "treo cầu liền"}]'::jsonb, 56);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Technology', 17, '電動式パワー・ステアリングに関する記述として、不適切なものは次のうちどれか。
(1) ホールIC式のトルク・センサを用いたものは、トーション・バーにねじれが生じると検出リングの相対位置が変位し、検出コイルに掛かる起電力が変化する。
(2) ピニオン・アシスト式では、ステアリング・ギヤのピニオン部にトルク・センサ及びモータが取り付けられ、ステアリング・ギヤのピニオンに対して補助動力を与えている。
(3) スリーブ式のトルク・センサは、検出コイルとインプット・シャフトの突起部間の磁力線密度の変化により、操舵力と操舵方向を検出している。
(4) コラム・アシスト式では、モータがステアリング・コラムに取り付けられ、ステアリング・シャフトに対して補助動力を与えている。', 'Trong các mô tả về trợ lực lái điện sau đây, mô tả nào không phù hợp?
(1) Loại dùng cảm biến mô men Hall IC làm thay đổi vị trí tương đối của vòng phát hiện khi thanh xoắn bị xoắn, khiến sức điện động trên cuộn phát hiện thay đổi.
(2) Kiểu pinion assist có cảm biến mô men và mô tơ tại phần bánh răng nhỏ của cơ cấu lái, cấp lực phụ cho bánh răng này.
(3) Cảm biến mô men sleeve phát hiện lực và hướng đánh lái bằng thay đổi mật độ đường sức từ giữa cuộn phát hiện và phần nhô của trục vào.
(4) Kiểu column assist có mô tơ lắp trên cột lái, cấp lực phụ cho trục lái.', NULL, '(1)', '(1) gán cơ chế vòng và cuộn phát hiện cho cảm biến Hall IC. Hall phát hiện thay đổi từ trường bằng phần tử Hall; cần phân biệt với cảm biến kiểu vòng/cuộn. (2) và (4) phân loại theo vị trí cấp trợ lực, còn (3) mô tả cảm biến sleeve.', '[{"term": "相対位置", "reading": "そうたいいち", "meaning": "vị trí tương đối"}, {"term": "変位", "reading": "へんい", "meaning": "dịch chuyển"}, {"term": "補助動力", "reading": "ほじょどうりょく", "meaning": "công suất trợ lực"}]'::jsonb, 57);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Technology', 18, '図に示すタイヤの局部摩耗の主な原因として、不適切なものは次のうちどれか。
(1) ブレーキ・ドラムの偏心
(2) ホイール・ベアリングのがた
(3) ホイール・バランスの不良
(4) マイナス・キャンバの過大

![Hình câu 18](images/o18.png)', 'Trong các nguyên nhân chính của tình trạng lốp mòn cục bộ ở hình, nguyên nhân nào không phù hợp?
(1) Tang trống phanh lệch tâm
(2) Độ rơ ổ bi bánh xe
(3) Cân bằng bánh xe không tốt
(4) Camber âm quá lớn', NULL, '(4)', 'Chọn (4). Camber âm quá lớn chủ yếu gây mòn mép trong liên tục theo chu vi, khác vùng mòn cục bộ ở hình. Lệch tâm tang trống, rơ ổ bi và mất cân bằng bánh có thể gây tải/rung không đều và mòn theo vùng.', '[{"term": "局部摩耗", "reading": "きょくぶまもう", "meaning": "mòn cục bộ"}, {"term": "偏心", "reading": "へんしん", "meaning": "lệch tâm"}, {"term": "がた", "reading": "がた", "meaning": "độ rơ"}]'::jsonb, 58);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Technology', 19, 'サスペンションのスプリングに関する記述として、適切なものは次のうちどれか。
(1) エア・スプリングのばね定数は、荷重が大きくなるとレベリング・バルブの作用により小さくなる。
(2) ばね定数が大きいスプリングは、小さいスプリングに比べてばねは柔らかい。
(3) 金属ばねを用いたボデーの上下方向の固有振動数は、荷重が軽いときは大きく、荷重が重くなると小さくなる。
(4) エア・スプリングは、金属スプリングと比較して、荷重の変化に対してばね定数が自動的に変化するので、固有振動数は比例して大きくなる。', 'Trong các mô tả về lò xo hệ thống treo sau đây, mô tả nào phù hợp?
(1) Khi tải tăng, van điều chỉnh độ cao làm độ cứng lò xo khí giảm.
(2) Lò xo có độ cứng lớn mềm hơn lò xo có độ cứng nhỏ.
(3) Tần số dao động riêng theo phương đứng của thân xe dùng lò xo kim loại cao khi tải nhẹ và thấp khi tải nặng.
(4) So với lò xo kim loại, lò xo khí tự thay đổi độ cứng theo tải nên tần số dao động riêng tăng tỷ lệ thuận.', NULL, '(3)', 'Chọn (3): f = (1/2π)√(k/m), tải tăng tương ứng khối lượng m tăng nên tần số giảm khi k gần cố định. Lò xo khí điều chỉnh độ cứng để giữ đặc tính dao động ổn định; độ cứng lớn không có nghĩa mềm hơn.', '[{"term": "金属ばね", "reading": "きんぞくばね", "meaning": "lò xo kim loại"}, {"term": "固有振動数", "reading": "こゆうしんどうすう", "meaning": "tần số dao động riêng"}, {"term": "上下方向", "reading": "じょうげほうこう", "meaning": "phương lên xuống"}]'::jsonb, 59);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Technology', 20, '差動制限型ディファレンシャルに関する記述として、適切なものは次のうちどれか。
(1) 回転速度差感応式で左右輪の回転速度に差が生じると、低回転側から高回転側にビスカス・トルクが伝えられる。
(2) ヘリカル・ギヤを用いたトルク感応式では、ピニオンの歯先とディファレンシャル・ケース内周面との摩擦により差動制限力が発生する。
(3) 回転速度差感応式に用いられているビスカス・カップリングは、インナ・プレートとアウタ・プレートの回転速度差が小さいほど大きなビスカス・トルクが発生する。
(4) トルク感応式のディファレンシャル・ケース内には、高粘度のシリコン・オイルが充填されている。', 'Trong các mô tả về vi sai hạn chế trượt sau đây, mô tả nào phù hợp?
(1) Ở loại nhạy chênh lệch tốc độ, khi tốc độ hai bánh khác nhau, mô men nhớt truyền từ phía quay chậm sang phía quay nhanh.
(2) Ở loại nhạy mô men dùng bánh răng nghiêng, ma sát giữa đỉnh răng bánh răng nhỏ và mặt trong vỏ vi sai tạo lực hạn chế vi sai.
(3) Khớp nối nhớt của loại nhạy chênh lệch tốc độ tạo mô men nhớt lớn hơn khi chênh lệch tốc độ lá trong và ngoài nhỏ hơn.
(4) Vỏ vi sai nhạy mô men được nạp dầu silicone độ nhớt cao.', NULL, '(2)', '(2) đúng về cơ chế ma sát của loại dùng bánh răng nghiêng. Khớp nhớt truyền mô men theo chiều chống chênh lệch tốc độ, từ phía nhanh sang phía chậm; mô men tăng khi chênh lệch tốc độ tăng. Dầu silicone đặc trưng cho khớp nhớt.', '[{"term": "内周面", "reading": "ないしゅうめん", "meaning": "mặt chu vi trong"}, {"term": "歯先", "reading": "はさき", "meaning": "đỉnh răng"}, {"term": "摩擦", "reading": "まさつ", "meaning": "ma sát"}]'::jsonb, 60);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Technology', 21, 'ブレーキに関する記述として、不適切なものは次のうちどれか。
(1) ブレーキは、自動車の運動エネルギを熱エネルギに変えて制動する装置である。
(2) 停止距離とは、運転者がアクセル・ペダルから足を離したときから車両が停止するまでに車両が進んだ距離をいい、空走距離と制動距離を合わせたものをいう。
(3) ブレーキ液の沸点は、ブレーキ液に含まれる水分の量に大きく左右され、水分が多いほど上昇する。
(4) フェードとは、降坂時の連続的制動などの際に、ブレーキ・ライニングが過熱して、材質が一時的に変化し、摩擦係数が下がり、ブレーキの効きが悪くなる現象をいう。', 'Trong các mô tả về phanh sau đây, mô tả nào không phù hợp?
(1) Phanh giảm tốc xe bằng cách chuyển động năng thành nhiệt năng.
(2) Quãng đường dừng là quãng đường xe đi từ khi người lái nhấc chân khỏi bàn đạp ga đến khi xe dừng, bằng tổng quãng đường phản ứng và quãng đường phanh.
(3) Nhiệt độ sôi dầu phanh phụ thuộc nhiều vào lượng nước trong dầu; nước càng nhiều nhiệt độ sôi càng tăng.
(4) Fade là hiện tượng lớp ma sát phanh quá nóng khi phanh liên tục như lúc xuống dốc, vật liệu thay đổi tạm thời, hệ số ma sát giảm và phanh kém hiệu lực.', NULL, '(3)', '(3) sai: dầu phanh hấp thụ nước làm nhiệt độ sôi giảm, dễ sinh hơi khi nóng. Fade là giảm hệ số ma sát do quá nhiệt; cần phân biệt với vapor lock do hơi trong chất lỏng. Quãng đường dừng gồm phản ứng và phanh.', '[{"term": "降坂", "reading": "こうはん", "meaning": "xuống dốc"}, {"term": "摩擦係数", "reading": "まさつけいすう", "meaning": "hệ số ma sát"}, {"term": "過熱", "reading": "かねつ", "meaning": "quá nóng"}]'::jsonb, 61);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Technology', 22, 'ホイール及びタイヤに関する記述として、不適切なものは次のうちどれか。
(1) タイヤの転がり抵抗のうちタイヤの変形による抵抗は、路面の状況、速度及びタイヤの種類、構造、エア圧などの影響を受ける。
(2) アルミニウム合金製ホイールの3ピース構造は、絞り又はプレス加工したインナ・リムとアウタ・リムに、鋳造又は鍛造されたディスクをボルト・ナットで締め付け、更に溶接したものである。
(3) タイヤの走行音のうちスキール音は、タイヤのトレッド部が路面に対してスリップして局部的振動を起こすことによって発生する。
(4) ダイナミック・アンバランスとは、タイヤ（ホイール付き）の一部が他の部分より重い場合、ゆっくり回転させると重い部分が下になって止まることをいう。', 'Trong các mô tả về vành bánh xe và lốp sau đây, mô tả nào không phù hợp?
(1) Trong cản lăn lốp, phần cản do biến dạng lốp chịu ảnh hưởng của mặt đường, tốc độ, loại lốp, kết cấu và áp suất khí.
(2) Vành hợp kim nhôm ba mảnh gồm vành trong và ngoài gia công vuốt hoặc ép, đĩa đúc hoặc rèn được ghép bằng bu lông–đai ốc rồi hàn thêm.
(3) Tiếng squeal khi lốp chạy phát sinh do phần mặt lốp trượt trên đường và gây rung cục bộ.
(4) Mất cân bằng động là hiện tượng một phần lốp kèm vành nặng hơn phần khác và khi quay chậm thì phần nặng dừng ở phía dưới.', NULL, '(4)', '(4) mô tả mất cân bằng tĩnh, không phải động. Mất cân bằng động liên quan phân bố khối lượng không đều theo các mặt phẳng và tạo mô men lắc khi quay. Cân bằng động cần xét cả vị trí dọc bề rộng vành.', '[{"term": "転がり抵抗", "reading": "ころがりていこう", "meaning": "cản lăn"}, {"term": "鍛造", "reading": "たんぞう", "meaning": "rèn"}, {"term": "絞り加工", "reading": "しぼりかこう", "meaning": "gia công vuốt"}]'::jsonb, 62);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Technology', 23, '前進4段のロックアップ機構付き電子制御式ATのトルク・コンバータに関する記述として、不適切なものは次のうちどれか。
(1) カップリング・レンジでは、トルクの増大作用は行われない。
(2) トルク比は、タービン・ランナが停止（速度比ゼロ）しているときが最大である。
(3) コンバータ・レンジでは、速度比に比例して伝達効率が上昇する。
(4) クラッチ・ポイントの速度比は、一般に0.8～0.9程度である。', 'Trong các mô tả về biến mô của AT điện tử 4 cấp tiến có khóa biến mô sau đây, mô tả nào không phù hợp?
(1) Trong vùng khớp nối không có tác dụng nhân mô men.
(2) Tỷ số mô men lớn nhất khi bánh tuabin dừng (tỷ số tốc độ bằng không).
(3) Trong vùng biến mô, hiệu suất truyền tăng tỷ lệ thuận với tỷ số tốc độ.
(4) Tỷ số tốc độ tại điểm chuyển sang khớp nối thường khoảng 0.8～0.9.', NULL, '(3)', '(3) sai ở “tỷ lệ thuận”. Hiệu suất bằng tỷ số mô men nhân tỷ số tốc độ, trong khi tỷ số mô men cũng thay đổi; đường hiệu suất không tuyến tính. Tại stall tỷ số mô men lớn nhất nhưng hiệu suất bằng 0. Vùng khớp nối không nhân mô men.', '[{"term": "増大作用", "reading": "ぞうだいさよう", "meaning": "tác dụng tăng"}, {"term": "比例", "reading": "ひれい", "meaning": "tỷ lệ thuận"}, {"term": "停止", "reading": "ていし", "meaning": "dừng"}]'::jsonb, 63);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Technology', 24, 'ABSに関する記述として、適切なものは次のうちどれか。
(1) エンジン始動後の発進時にゆっくりと加速した場合などに、静かな場所では、エンジン・ルームからABSのポンプ・モータの作動音が聞こえる場合があるが、これはABSのイニシャル・チェックの音である。
(2) ハイドロリック・ユニット部は、ECUからの駆動信号により各ブレーキの液圧の制御とエンジンの出力制御を行っている。
(3) ECUは、各車輪速センサ、スイッチなどからの信号により、路面の状況などに応じて、マスタ・シリンダに作動信号を出力する。
(4) ピックアップ・コイル式車輪速センサのコイルの電圧の周波数は、ロータの回転速度に反比例する。', 'Trong các mô tả về hệ thống ABS sau đây, mô tả nào phù hợp?
(1) Khi từ từ tăng tốc lúc xe bắt đầu chạy sau khởi động, ở nơi yên tĩnh có thể nghe tiếng mô tơ bơm ABS từ khoang động cơ; đó là âm thanh kiểm tra ban đầu của ABS.
(2) Cụm thủy lực điều khiển áp suất chất lỏng từng phanh và công suất động cơ theo tín hiệu điều khiển ECU.
(3) ECU dựa vào tín hiệu cảm biến tốc độ bánh, công tắc và tình trạng đường để gửi tín hiệu hoạt động đến xi lanh chính.
(4) Tần số điện áp cuộn dây của cảm biến tốc độ bánh kiểu pickup tỷ lệ nghịch với tốc độ quay rô to.', NULL, '(1)', '(1) đúng: tiếng bơm ngắn có thể là tự kiểm tra ban đầu. Cụm thủy lực điều khiển áp suất phanh, không trực tiếp điều khiển công suất động cơ. ECU điều khiển cụm van/bơm; cảm biến pickup có tần số tăng theo tốc độ quay, không tỷ lệ nghịch.', '[{"term": "車輪速センサ", "reading": "しゃりんそくセンサ", "meaning": "cảm biến tốc độ bánh"}, {"term": "周波数", "reading": "しゅうはすう", "meaning": "tần số"}, {"term": "反比例", "reading": "はんぴれい", "meaning": "tỷ lệ nghịch"}]'::jsonb, 64);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Technology', 25, 'エアコンに関する記述として、適切なものは次のうちどれか。
(1) エキスパンション・バルブは、レシーバを通ってきた低温・低圧の液状冷媒を、細孔から噴射させることにより、急激に膨張させて、高温・高圧の霧状の冷媒にする。
(2) レシーバは、エバポレータ内における冷媒の気化状態に応じて噴射する冷媒の量を調節する。
(3) コンプレッサは、室内の熱を奪って気体になった冷媒を吸入・圧縮し、液体になりやすい低温・低圧の冷媒にしている。
(4) サブクール式コンデンサは、コンデンサ部から送り出された液状冷媒をサブクール部で更に冷却することで冷房性能の向上を図っている。', 'Trong các mô tả về điều hòa không khí sau đây, mô tả nào phù hợp?
(1) Van tiết lưu phun môi chất lỏng nhiệt độ thấp, áp suất thấp từ bình chứa qua lỗ nhỏ, làm giãn nở nhanh thành môi chất dạng sương nhiệt độ cao, áp suất cao.
(2) Bình chứa điều chỉnh lượng môi chất phun theo trạng thái bay hơi trong giàn bay hơi.
(3) Máy nén hút và nén môi chất đã lấy nhiệt trong cabin và trở thành khí, biến thành môi chất nhiệt độ thấp, áp suất thấp để dễ hóa lỏng.
(4) Bộ ngưng tụ subcool làm lạnh thêm môi chất lỏng từ phần ngưng tụ tại phần làm lạnh phụ để tăng hiệu quả làm mát.', NULL, '(4)', '(4) đúng. Trước van tiết lưu môi chất lỏng có áp suất cao; qua van thành hỗn hợp áp suất thấp, nhiệt độ thấp. Máy nén nâng áp suất và nhiệt độ của khí. Van tiết lưu điều chỉnh lưu lượng, còn bình chứa làm nhiệm vụ chứa/tách và cấp môi chất lỏng.', '[{"term": "気化", "reading": "きか", "meaning": "hóa hơi"}, {"term": "細孔", "reading": "さいこう", "meaning": "lỗ nhỏ"}, {"term": "圧縮", "reading": "あっしゅく", "meaning": "nén"}]'::jsonb, 65);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Technology', 26, 'ツイスト・ペア線を用いたCAN通信に関する記述として、適切なものは次のうちどれか。
(1) CANは、一つのECUが複数のデータ・フレームを送信したり、バス・ライン上のデータを必要とする複数のECUが同時にデータ・フレームを受信することができる。
(2) CAN-H、CAN-Lともに2.5Vの状態をドミナントという。
(3) 一端の終端抵抗が断線していても通信は継続され、耐ノイズ性にも影響はないが、ダイアグノーシス・コードが出力されることがある。
(4) バス・オフ状態とは、エラーを検知し、リカバリ後にエラーが解消し、通信を再開した状態をいう。', 'Trong các mô tả về truyền thông CAN dùng dây xoắn đôi sau đây, mô tả nào phù hợp?
(1) Trong CAN, một ECU có thể gửi nhiều khung dữ liệu và nhiều ECU cần dữ liệu trên bus có thể đồng thời nhận khung dữ liệu.
(2) Trạng thái CAN-H và CAN-L đều bằng 2.5V gọi là dominant.
(3) Dù điện trở kết thúc ở một đầu bị đứt, truyền thông vẫn tiếp tục và chống nhiễu không bị ảnh hưởng, nhưng có thể xuất hiện mã chẩn đoán.
(4) Bus off là trạng thái phát hiện lỗi, sau phục hồi lỗi đã hết và truyền thông được khởi động lại.', NULL, '(1)', '(1) đúng về truyền dữ liệu kiểu quảng bá. Hai dây cùng khoảng 2.5V là recessive, không phải dominant. Bus off là nút bị tách khỏi hoạt động bus vì lỗi, khác trạng thái đã phục hồi. Điện trở kết thúc ảnh hưởng chất lượng tín hiệu và phản xạ.', '[{"term": "送信", "reading": "そうしん", "meaning": "truyền"}, {"term": "受信", "reading": "じゅしん", "meaning": "nhận"}, {"term": "再開", "reading": "さいかい", "meaning": "khởi động lại"}]'::jsonb, 66);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Technology', 27, 'フレーム及びボデーに関する記述として、適切なものは次のうちどれか。
(1) フレームの修正の過程において、電気溶接を行う場合、フレームの板厚、溶接電流の大小に関係なく、溶接棒はできるだけ太いものを選ぶ。
(2) ボデーの安全構造は、衝突時のエネルギを効率よく吸収し、このエネルギで客室を最大限に変形させることにより、衝突エネルギを軽減している。
(3) トラックのフレームは、トラックの全長にわたって貫通した左右2本のサイド・メンバが配列されている。
(4) モノコック・ボデーは、サスペンションなどからの振動や騒音が伝わりにくいので、防音や防振に優れている。', 'Trong các mô tả về khung và thân xe sau đây, mô tả nào phù hợp?
(1) Khi hàn điện trong quá trình nắn sửa khung, chọn que hàn càng lớn càng tốt bất kể chiều dày khung và dòng hàn.
(2) Kết cấu an toàn thân xe hấp thụ năng lượng va chạm hiệu quả, dùng năng lượng này làm biến dạng khoang hành khách tối đa để giảm năng lượng va chạm.
(3) Khung xe tải bố trí hai dầm dọc trái, phải chạy suốt chiều dài xe tải.
(4) Thân liền khối khó truyền rung và tiếng ồn từ treo nên cách âm và chống rung tốt.', NULL, '(3)', '(3) đúng về khung xe tải kiểu dầm dọc. Khoang hành khách cần hạn chế biến dạng, còn vùng hấp thụ va chạm mới được thiết kế biến dạng có kiểm soát. Que hàn phải phù hợp chiều dày và dòng; thân liền khối cần biện pháp chống truyền rung.', '[{"term": "修正", "reading": "しゅうせい", "meaning": "nắn sửa"}, {"term": "全長", "reading": "ぜんちょう", "meaning": "chiều dài toàn bộ"}, {"term": "貫通", "reading": "かんつう", "meaning": "xuyên suốt"}]'::jsonb, 67);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Technology', 28, 'CVT（スチール・ベルトを用いたベルト式無段変速機）に関する記述として、不適切なものは次のうちどれか。
(1) スチール・ベルトは、エレメントの伸張作用（エレメントの引っ張り）によって動力が伝達される。
(2) CVTは、プラネタリ・ギヤ・ユニット式ATより更にごみを嫌うので、点検時等にごみがユニット内に入り込まないように十分注意する必要がある。
(3) 可動シーブは、油圧によりボール・スプラインの軸上をしゅう動し、プーリの溝幅を任意に可変できる仕組みになっている。
(4) プライマリ・プーリに掛かる作動油圧が高いときは、プライマリ・プーリの溝幅が狭くなるため、プライマリ・プーリに掛かるスチール・ベルトの接触半径は大きくなる。', 'Trong các mô tả về CVT (hộp số vô cấp kiểu đai sử dụng đai thép) sau đây, mô tả nào không phù hợp?
(1) Đai thép truyền công suất bằng tác dụng kéo giãn (kéo các phần tử).
(2) CVT nhạy với bụi bẩn hơn AT dùng bộ bánh răng hành tinh, nên phải hết sức tránh bụi lọt vào cụm khi kiểm tra.
(3) Má puli di động trượt trên trục then hoa bi nhờ áp suất dầu, cho phép thay đổi bề rộng rãnh puli theo yêu cầu.
(4) Khi áp suất dầu trên puli sơ cấp cao, rãnh puli hẹp lại nên bán kính tiếp xúc đai thép trên puli sơ cấp tăng.', NULL, '(1)', '(1) sai: đai thép dạng push belt truyền lực nhờ các phần tử nén đẩy nhau. Áp suất cao ép hai má puli gần nhau và đẩy đai ra bán kính lớn hơn. Vệ sinh rất quan trọng vì bụi làm hỏng bề mặt tiếp xúc và hệ thống thủy lực.', '[{"term": "可動シーブ", "reading": "かどうシーブ", "meaning": "má puli di động"}, {"term": "しゅう動", "reading": "しゅうどう", "meaning": "trượt"}, {"term": "伸張作用", "reading": "しんちょうさよう", "meaning": "tác dụng kéo giãn"}]'::jsonb, 68);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Strategy', 29, '前進4段のロックアップ機構付き電子制御式ATの構成部品に関する記述として、適切なものは次のうちどれか。
(1) ローラ式のワンウェイ・クラッチは、インナ・レースとアウタ・レースとの間に設けたスプラグの働きによって、一定の回転方向にだけ動力が伝えられる。
(2) ハイ・クラッチは、2種類のプレート（ドライブ・プレートとドリブン・プレート）が数枚交互に組み付けられており、ピストンに油圧が作用すると両プレートが密着するようになっている。
(3) バンド・ブレーキ機構は、ブレーキ・バンド、ディッシュ・プレートなどで構成されている。
(4) バンド・ブレーキ機構は、リバース・クラッチ・ドラムを介してフロント・インターナル・ギヤを固定する。', 'Trong các mô tả về các bộ phận AT điện tử 4 cấp tiến có khóa biến mô sau đây, mô tả nào phù hợp?
(1) Ly hợp một chiều kiểu con lăn truyền công suất chỉ theo một chiều quay nhờ sprag đặt giữa vòng trong và vòng ngoài.
(2) Ly hợp high có nhiều lá của hai loại (lá chủ động và lá bị động) xếp xen kẽ; khi dầu tác động lên pít tông, hai loại lá ép sát nhau.
(3) Cơ cấu phanh đai gồm đai phanh, đĩa dạng lòng chảo và các chi tiết tương tự.
(4) Cơ cấu phanh đai cố định bánh răng vành trong phía trước qua trống ly hợp lùi.', NULL, '(2)', '(2) mô tả đúng ly hợp nhiều đĩa. Kiểu con lăn dùng con lăn, kiểu sprag dùng sprag; không đổi tên hai loại. Phanh đai dùng đai, trống và cơ cấu tác động, khác phanh nhiều đĩa.', '[{"term": "構成部品", "reading": "こうせいぶひん", "meaning": "bộ phận cấu thành"}, {"term": "密着", "reading": "みっちゃく", "meaning": "ép sát"}, {"term": "交互", "reading": "こうご", "meaning": "xen kẽ"}]'::jsonb, 69);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Strategy', 30, 'SRSエアバッグに関する記述として、適切なものは次のうちどれか。
(1) インパクト・センサは、衝撃を電気信号に変換してセンサ内の衝突判定回路に入力し、衝突の判定を行う。
(2) エアバッグ・アセンブリのコネクタを取り外した場合、コネクタ内で全ての端子が短絡され、静電気などでSRSエアバッグが誤作動しないようになっている。
(3) エアバッグ・アセンブリは、必ず、平坦なものの上にパッド面を下に向けて保管しておくこと。
(4) インフレータは、電気点火装置（スクイブ）、着火剤、ガス発生剤、ケーブル・リール、フィルタなどを金属の容器に収納している。', 'Trong các mô tả về túi khí SRS sau đây, mô tả nào phù hợp?
(1) Cảm biến va chạm chuyển xung lực thành tín hiệu điện, đưa vào mạch đánh giá va chạm bên trong cảm biến để xác định va chạm.
(2) Khi tháo giắc cụm túi khí, tất cả đầu cực trong giắc được nối tắt để tránh SRS kích hoạt nhầm do tĩnh điện và các nguyên nhân tương tự.
(3) Luôn bảo quản cụm túi khí trên mặt phẳng với mặt đệm hướng xuống.
(4) Bộ tạo khí chứa bộ mồi điện (squib), chất mồi, chất sinh khí, cuộn cáp, bộ lọc và các chi tiết tương tự trong vỏ kim loại.', NULL, '(2)', '(2) đúng về cơ chế nối tắt bảo vệ của giắc cụm túi khí được hỏi. Phân biệt cảm biến gửi tín hiệu với mạch đánh giá trong bộ điều khiển. Cụm túi khí đặt mặt đệm hướng lên khi bảo quản theo quy trình; cuộn cáp không nằm trong bộ tạo khí. Không dùng nội dung câu hỏi thay cho quy trình sửa chữa của nhà sản xuất.', '[{"term": "短絡", "reading": "たんらく", "meaning": "nối tắt"}, {"term": "静電気", "reading": "せいでんき", "meaning": "tĩnh điện"}, {"term": "誤作動", "reading": "ごさどう", "meaning": "hoạt động nhầm"}]'::jsonb, 70);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Strategy', 31, 'ねじとベアリングに関する記述として、不適切なものは次のうちどれか。
(1) 「M10×1.25」と表示されるねじの外径は10mmである。
(2) ローリング・ベアリングのうち、ラジアル・ベアリングには、ボール型、ニードル・ローラ型、テーパ・ローラ型があり、トランスミッションなどに用いられている。
(3) プレーン・ベアリングのうち、つば付き半割り形プレーン・ベアリングは、ラジアル方向（軸と直角方向）とスラスト方向（軸と同じ方向）の力を受ける構造になっている。
(4) 戻り止めナット（セルフロッキング・ナット）は、ナットの一部に戻り止めを施し、ナットが緩まないようにしている。', 'Trong các mô tả về ren và ổ đỡ sau đây, mô tả nào không phù hợp?
(1) Ren ghi “M10×1.25” có đường kính ngoài 10mm.
(2) Trong ổ lăn, ổ hướng kính có loại bi, con lăn kim và con lăn côn, được dùng trong hộp số và các bộ phận tương tự.
(3) Trong ổ trượt, ổ trượt nửa vòng có gờ được thiết kế nhận lực hướng kính (vuông góc trục) và lực dọc trục (cùng hướng trục).
(4) Đai ốc chống tự tháo (self-locking nut) có bộ phận chống tháo ở một phần đai ốc để không bị lỏng.', NULL, '(2)', 'Đáp án chính thức là (2). Trong phân loại của tài liệu ô tô dùng cho câu này, ổ con lăn côn được tách khỏi nhóm hướng kính liệt kê vì nhận cả tải hướng kính và dọc trục. Cần tránh diễn giải rằng ổ con lăn côn không chịu tải hướng kính: trên thực tế nó chịu tải kết hợp. M10 là đường kính danh nghĩa, 1.25 là bước ren tính bằng mm.', '[{"term": "外径", "reading": "がいけい", "meaning": "đường kính ngoài"}, {"term": "つば付き", "reading": "つばつき", "meaning": "có gờ"}, {"term": "戻り止め", "reading": "もどりどめ", "meaning": "chống tự tháo"}]'::jsonb, 71);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Management', 32, 'ガソリンに関する記述として、適切なものは次のうちどれか。
(1) オクタン価を高めることで、高圧縮比でもノッキングが発生しにくくなる。
(2) 改質ガソリンとは、高オクタン価のガソリンを低オクタン価のガソリンに転換したものである。
(3) オクタン価とは、そのガソリンに含まれるイソオクタン混合割合をいう。
(4) 直留ガソリンは、原油から直接蒸留して得られるガソリンで、オクタン価が高く自動車用としては最も適している。', 'Trong các mô tả về xăng sau đây, mô tả nào phù hợp?
(1) Tăng chỉ số octan giúp giảm khả năng kích nổ ngay cả khi tỷ số nén cao.
(2) Xăng reforming là xăng có chỉ số octan cao được chuyển thành xăng có chỉ số octan thấp.
(3) Chỉ số octan là tỷ lệ isooctan có trong xăng đó.
(4) Xăng chưng cất trực tiếp từ dầu thô có chỉ số octan cao và phù hợp nhất cho ô tô.', NULL, '(1)', '(1) đúng: chỉ số octan đo khả năng chống kích nổ. Reforming nhằm nâng chỉ số octan, không hạ. Chỉ số octan là giá trị tương đương nhiên liệu chuẩn chứ không phải thành phần thực của xăng; xăng chưng cất trực tiếp thường có khả năng chống kích nổ thấp.', '[{"term": "高圧縮比", "reading": "こうあっしゅくひ", "meaning": "tỷ số nén cao"}, {"term": "改質ガソリン", "reading": "かいしつガソリン", "meaning": "xăng reforming"}, {"term": "蒸留", "reading": "じょうりゅう", "meaning": "chưng cất"}]'::jsonb, 72);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Management', 33, '次の諸元を有するトラックの最大積載時の前軸荷重について、適切なものは次のうちどれか。ただし、乗員1人当たりの荷重は550Nで、その荷重は前車軸の中心に作用し、また、積載物の荷重は荷台に等分布にかかるものとする。
| 諸元 | 値 | 諸元 | 値 |
| --- | --- | --- | --- |
| ホイールベース | 5,000mm | 乗車定員 | 3人 |
| 空車時前軸荷重 | 34,500N | 荷台内側長さ | 6,400mm |
| 空車時後軸荷重 | 25,000N | リヤ・オーバハング（荷台内側まで） | 1,500mm |
| 最大積載荷重 | 40,000N |  |  |
(1) 38,170N
(2) 41,650N
(3) 45,480N
(4) 49,750N', 'Với xe tải có các thông số sau, tải trọng trục trước khi chở tối đa nào là phù hợp? Giả sử tải mỗi người là 550N, tác dụng tại tâm trục trước; tải hàng phân bố đều trên thùng.
| Thông số | Giá trị | Thông số | Giá trị |
| --- | --- | --- | --- |
| Chiều dài cơ sở | 5,000mm | Số người được chở | 3 người |
| Tải trục trước khi xe không tải | 34,500N | Chiều dài bên trong thùng | 6,400mm |
| Tải trục sau khi xe không tải | 25,000N | Phần nhô sau (đến mép trong thùng) | 1,500mm |
| Tải hàng tối đa | 40,000N |  |  |
(1) 38,170N
(2) 41,650N
(3) 45,480N
(4) 49,750N', NULL, '(4)', 'Trọng tâm hàng cách trục sau về trước 6,400/2−1,500 = 1,700mm. Lấy mô men quanh trục sau: phần tải hàng lên trục trước = 40,000×1,700/5,000 = 13,600N. Người ngồi thêm 3×550 = 1,650N tại trục trước. Tổng = 34,500+13,600+1,650 = 49,750N, chọn (4). Tải trục sau không tải là dữ liệu đầy đủ của đề nhưng không cần cộng vào kết quả trục trước.', '[{"term": "諸元", "reading": "しょげん", "meaning": "thông số"}, {"term": "等分布", "reading": "とうぶんぷ", "meaning": "phân bố đều"}, {"term": "前軸荷重", "reading": "ぜんじくかじゅう", "meaning": "tải trọng trục trước"}]'::jsonb, 73);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Management', 34, '自動車の材料に用いられる鉄鋼に関する記述として、適切なものは次のうちどれか。
(1) 球状黒鉛鋳鉄は、普通鋳鉄に含まれる黒鉛を球状化させるためにマグネシウムなどの金属を少量加えて強度や耐摩耗性などを向上させたものである。
(2) 合金鋳鉄は、炭素鋼にクロム、モリブデン、ニッケルなどの金属を一種類又は数種類加えて強度や耐摩耗性などを向上させたものである。
(3) 普通鋳鉄は、熱間圧延鋼板を更に常温で圧延し薄板にしたものである。
(4) 普通鋼は、一般に炭素鋼と呼ばれ、軟鋼と硬鋼に分類され、硬鋼は軟鋼より炭素を含む量が少ない。', 'Trong các mô tả về sắt thép dùng làm vật liệu ô tô sau đây, mô tả nào phù hợp?
(1) Gang cầu được thêm lượng nhỏ kim loại như magiê để cầu hóa graphit trong gang thông thường, nâng độ bền và khả năng chống mòn.
(2) Gang hợp kim được tạo bằng cách thêm một hoặc nhiều kim loại như crom, molypden, niken vào thép cacbon để tăng độ bền và chống mòn.
(3) Gang thông thường là tấm thép cán nóng tiếp tục được cán ở nhiệt độ thường thành tấm mỏng.
(4) Thép thông thường thường gọi là thép cacbon, chia thành thép mềm và thép cứng; thép cứng chứa ít cacbon hơn thép mềm.', NULL, '(1)', '(1) đúng. Gang hợp kim thêm nguyên tố vào gang, không phải thép cacbon. Cán nguội tấm thép không tạo gang. Thép cứng chứa nhiều cacbon hơn thép mềm. Phân biệt quy trình cán với đúc và phân biệt nền gang với nền thép.', '[{"term": "球状化", "reading": "きゅうじょうか", "meaning": "cầu hóa"}, {"term": "熱間圧延", "reading": "ねっかんあつえん", "meaning": "cán nóng"}, {"term": "常温", "reading": "じょうおん", "meaning": "nhiệt độ thường"}]'::jsonb, 74);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Management', 35, '図に示す電気回路において、電流計Aが示す電流値として、適切なものは次のうちどれか。ただし、バッテリ、配線等の抵抗はないものとする。
(1) 5A
(2) 16A
(3) 30A
(4) 55A

![Hình câu 35](images/o35.png)', 'Trong mạch điện ở hình, dòng điện nào mà ampe kế A chỉ là phù hợp? Giả sử ắc quy, dây dẫn và các phần tương tự không có điện trở.
(1) 5A
(2) 16A
(3) 30A
(4) 55A

**Nhãn hình:** バッテリ（12V）: ắc quy (12V); A: ampe kế; bốn điện trở song song từ trên xuống: 1Ω, 4Ω, 1Ω, 4Ω.', NULL, '(3)', 'Bốn điện trở 1Ω, 4Ω, 1Ω, 4Ω mắc song song với nguồn 12V. Các dòng nhánh là 12A, 3A, 12A, 3A; ampe kế đo tổng 30A, chọn (3). Tương đương 1/R = 1+1/4+1+1/4 = 2.5, R = 0.4Ω; 12/0.4 = 30A.', '[{"term": "電流計", "reading": "でんりゅうけい", "meaning": "ampe kế"}, {"term": "電流値", "reading": "でんりゅうち", "meaning": "giá trị dòng điện"}, {"term": "電気回路", "reading": "でんきかいろ", "meaning": "mạch điện"}]'::jsonb, 75);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Management', 36, '「自動車点検基準」の別表第2（自家用乗用自動車等の日常点検基準）に規定されている点検内容として、適切なものは次のうちどれか。
(1) 冷却装置のファン・ベルトの緩み及び損傷がないこと。
(2) バッテリのターミナル部の接続状態が不良でないこと。
(3) ショック・アブソーバの油漏れ及び損傷がないこと。
(4) ブレーキ・ペダルの踏みしろが適当で、ブレーキのききが十分であること。', 'Trong các mô tả về nội dung kiểm tra theo Bảng 2 của “Tiêu chuẩn kiểm tra ô tô” (kiểm tra hằng ngày xe con tư nhân và các xe tương tự) sau đây, mô tả nào phù hợp?
(1) Dây đai quạt hệ thống làm mát không lỏng hoặc hư hỏng.
(2) Tình trạng kết nối đầu cực ắc quy không kém.
(3) Giảm chấn không rò dầu hoặc hư hỏng.
(4) Hành trình đạp bàn đạp phanh phù hợp và hiệu lực phanh đầy đủ.', NULL, '(4)', '(4) thuộc kiểm tra hằng ngày. Ba mục còn lại là các nội dung kiểm tra kỹ thuật định kỳ được phân biệt trong đề. Kiểm tra hằng ngày không chỉ quan sát mà còn xác nhận bàn đạp và hiệu lực phanh.', '[{"term": "緩み", "reading": "ゆるみ", "meaning": "sự lỏng"}, {"term": "損傷", "reading": "そんしょう", "meaning": "hư hỏng"}, {"term": "きき", "reading": "きき", "meaning": "hiệu lực"}]'::jsonb, 76);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Management', 37, '「道路運送車両の保安基準」及び「道路運送車両の保安基準の細目を定める告示」に照らし、後退灯の基準に関する記述として、不適切なものは次のうちどれか。
(1) 照射光線は、他の交通を妨げないものであること。
(2) 昼間にその後方30mの距離から点灯を確認できるものであること。
(3) 灯光の色は、白色であること。
(4) 灯器が損傷し又はレンズ面が著しく汚損しているものでないこと。', 'Theo “Tiêu chuẩn an toàn phương tiện vận tải đường bộ” và thông báo quy định chi tiết, mô tả nào về tiêu chuẩn đèn lùi không phù hợp?
(1) Ánh sáng chiếu ra không được cản trở các phương tiện khác.
(2) Ban ngày có thể xác nhận đèn sáng từ khoảng cách 30m phía sau.
(3) Màu ánh sáng là trắng.
(4) Bộ đèn không hỏng và bề mặt kính không bị bẩn nghiêm trọng.', NULL, '(2)', '(2) sai vì khoảng cách xác nhận đèn lùi ban ngày là 100m trong tiêu chuẩn đang xét, không phải 30m. Đèn lùi có màu trắng và không được gây cản trở giao thông. Không dùng khoảng cách của đèn báo rẽ để trả lời đèn lùi.', '[{"term": "後退灯", "reading": "こうたいとう", "meaning": "đèn lùi"}, {"term": "照射光線", "reading": "しょうしゃこうせん", "meaning": "tia sáng chiếu ra"}, {"term": "汚損", "reading": "おそん", "meaning": "bẩn hỏng"}]'::jsonb, 77);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Management', 38, '「道路運送車両の保安基準」及び「道路運送車両の保安基準の細目を定める告示」に照らし、四輪の小型自動車の前部霧灯に関する基準の記述として、不適切なものは次のうちどれか。
(1) 灯光の色は、白色又は淡黄色であり、その全てが同一であること。
(2) 同時に3個以上点灯しないように取り付けられていること。
(3) 点灯操作状態を運転者席の運転者に表示する装置を備えること。
(4) 照明部の最外縁は、自動車の最外側から600mm以内となるように取り付けられていること。', 'Theo “Tiêu chuẩn an toàn phương tiện vận tải đường bộ” và thông báo quy định chi tiết, mô tả nào về đèn sương mù trước của ô tô cỡ nhỏ bốn bánh không phù hợp?
(1) Màu ánh sáng trắng hoặc vàng nhạt và tất cả đèn cùng màu.
(2) Lắp sao cho không có từ ba đèn trở lên sáng đồng thời.
(3) Có thiết bị hiển thị trạng thái thao tác bật đèn cho người lái tại ghế lái.
(4) Mép ngoài cùng của phần phát sáng được lắp trong phạm vi 600mm tính từ mép ngoài cùng của xe.', NULL, '(4)', '(4) sai ở 600mm: khoảng cách ngang tối đa trong tiêu chuẩn nêu ở đề là 400mm. Giới hạn không sáng đồng thời từ ba đèn trở lên nghĩa là tối đa hai đèn. Trắng hoặc vàng nhạt được phép nhưng các đèn phải cùng màu.', '[{"term": "前部霧灯", "reading": "ぜんぶむとう", "meaning": "đèn sương mù trước"}, {"term": "淡黄色", "reading": "たんこうしょく", "meaning": "màu vàng nhạt"}, {"term": "最外縁", "reading": "さいがいえん", "meaning": "mép ngoài cùng"}]'::jsonb, 78);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Management', 39, '「道路運送車両法」及び「道路運送車両法施行規則」に照らし、四輪の小型自動車の特定整備に該当するものは次のうちどれか。
(1) 原動機を取り外して行う自動車の整備又は改造
(2) かじ取り装置のハンドルを取り外して行う自動車の整備又は改造
(3) 燃料装置の燃料タンクを取り外して行う自動車の整備又は改造
(4) 緩衝装置のトーションバー・スプリングを取り外して行う自動車の整備又は改造', 'Theo “Luật phương tiện vận tải đường bộ” và “Quy tắc thi hành Luật phương tiện vận tải đường bộ”, công việc nào thuộc bảo dưỡng đặc định của ô tô cỡ nhỏ bốn bánh?
(1) Bảo dưỡng hoặc cải tạo xe bằng cách tháo động cơ.
(2) Bảo dưỡng hoặc cải tạo xe bằng cách tháo vô lăng của hệ thống lái.
(3) Bảo dưỡng hoặc cải tạo xe bằng cách tháo thùng nhiên liệu của hệ thống nhiên liệu.
(4) Bảo dưỡng hoặc cải tạo xe bằng cách tháo lò xo thanh xoắn của hệ thống treo.', NULL, '(1)', '(1) thuộc công việc tháo lắp được quy định trong bảo dưỡng đặc định. Phạm vi pháp lý dựa vào bộ phận và thao tác cụ thể, không chỉ dựa vào việc công việc quan trọng hay có tháo chi tiết. Vì vậy không gộp mọi sửa chữa hệ thống lái, nhiên liệu và treo vào cùng nhóm.', '[{"term": "特定整備", "reading": "とくていせいび", "meaning": "bảo dưỡng đặc định"}, {"term": "原動機", "reading": "げんどうき", "meaning": "động cơ"}, {"term": "改造", "reading": "かいぞう", "meaning": "cải tạo"}]'::jsonb, 79);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026 (Kỳ thi 113)', 'Management', 40, '「道路運送車両法」に照らし、「特定整備記録簿の保存期間」に関する次の文章の［a］に当てはまるものとして、適切なものはどれか。
特定整備記録簿は、その記載の日から［a］間保存しなければならない。
(1) 1年
(2) 2年
(3) 3年
(4) 4年', 'Theo “Luật phương tiện vận tải đường bộ”, lựa chọn nào điền đúng vào ［a］ trong câu về “thời hạn lưu sổ ghi bảo dưỡng đặc định”?
Sổ ghi bảo dưỡng đặc định phải được lưu trong thời gian ［a］ kể từ ngày ghi.
(1) 1 năm
(2) 2 năm
(3) 3 năm
(4) 4 năm', NULL, '(2)', 'Chọn (2): lưu hai năm kể từ ngày ghi. Điểm bắt đầu tính là ngày ghi trong sổ, không phải ngày cấp chứng nhận hay ngày đăng ký xe. Phải phân biệt loại sổ được hỏi với hồ sơ kiểm tra, bảo dưỡng khác.', '[{"term": "記録簿", "reading": "きろくぼ", "meaning": "sổ ghi chép"}, {"term": "保存期間", "reading": "ほぞんきかん", "meaning": "thời hạn lưu"}, {"term": "記載", "reading": "きさい", "meaning": "ghi vào"}, {"term": "Mẫu câu tiếng Nhật", "reading": "Cách đọc bằng kana", "meaning": "Nghĩa tiếng Việt / cách xử lý khi làm bài"}, {"term": "～に関する記述として、適切なものは次のうちどれか。", "reading": "～にかんするきじゅつとして、てきせつなものはつぎのうちどれか。", "meaning": "Trong các mô tả về…, mô tả nào phù hợp? Chọn phát biểu đúng."}, {"term": "～に関する記述として、不適切なものは次のうちどれか。", "reading": "～にかんするきじゅつとして、ふてきせつなものはつぎのうちどれか。", "meaning": "Mô tả nào không phù hợp? Phải chọn phát biểu sai."}, {"term": "下の組み合わせのうち、適切なものはどれか。", "reading": "したのくみあわせのうち、てきせつなものはどれか。", "meaning": "Tổ hợp nào dưới đây phù hợp? Kiểm tra mọi thành phần của cùng một hàng."}, {"term": "～に当てはまるものとして", "reading": "～にあてはまるものとして", "meaning": "Để điền vào…; xác định từng ô trống theo điều kiện."}, {"term": "ただし、～ものとする。", "reading": "ただし、～ものとする。", "meaning": "Tuy nhiên, giả sử…; dùng đúng giả thiết đã cho."}, {"term": "～に照らし", "reading": "～にてらし", "meaning": "Căn cứ theo…; xác định phạm vi quy định được hỏi."}, {"term": "～を超えてはならない。", "reading": "～をこえてはならない。", "meaning": "Không được vượt…; đây là giới hạn tối đa."}, {"term": "この限りでない。", "reading": "このかぎりでない。", "meaning": "Quy định này không áp dụng trong trường hợp ngoại lệ vừa nêu."}, {"term": "～に該当しないもの", "reading": "～にがいとうしないもの", "meaning": "Đối tượng không thuộc…; chú ý phủ định."}, {"term": "～に該当するもの", "reading": "～にがいとうするもの", "meaning": "Đối tượng thuộc…; chọn đúng phạm vi."}, {"term": "～ほど、～なる。", "reading": "～ほど、～なる。", "meaning": "Càng… thì càng…; kiểm tra chiều tăng hoặc giảm."}, {"term": "～と比較して", "reading": "～とひかくして", "meaning": "So với…; xác định đúng đối tượng làm mốc."}, {"term": "～で除して求める。", "reading": "～でじょしてもとめる。", "meaning": "Tính bằng cách chia cho…; không đảo tử và mẫu."}, {"term": "～を乗じた値", "reading": "～をじょうじたあたい", "meaning": "Giá trị nhân với…; giữ đơn vị và hệ số."}, {"term": "少なくとも～ずつ", "reading": "すくなくとも～ずつ", "meaning": "Ít nhất… cho mỗi…; phân biệt giới hạn dưới và trên."}]'::jsonb, 80);
END $$;
