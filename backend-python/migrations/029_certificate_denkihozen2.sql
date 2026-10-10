-- Certificates feature: denkihozen2 (dien category) — generated from
-- doccument/denkihozen2/sach_on_tap_Nhat_Viet.md via a one-off parsing script

INSERT INTO certificates (code, category, name_ja, name_vi, related_occupations)
VALUES (
    'denkihozen2', 'dien', '機械保全技能士 2級（電気系保全作業）', 'Kỹ năng bảo trì điện 2級',
    'Kỹ thuật viên điện công nghiệp bậc cao, tổ trưởng bảo trì điện nhà máy, kỹ sư điện - điện tử, kỹ thuật viên PLC và tự động hóa, quản lý bảo trì thiết bị điện.'
)
ON CONFLICT (code) DO NOTHING;

DO $$
DECLARE cert_id INT;
BEGIN
    SELECT id INTO cert_id FROM certificates WHERE code = 'denkihozen2';
    DELETE FROM certificate_vocabulary WHERE certificate_id = cert_id;

    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'FMEA', 'エフエムイーエー', 'Phân tích dạng hư hỏng và ảnh hưởng', '', '', '', 1);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'FTA', 'エフティーエー', 'Phân tích cây hư hỏng', '', '', '', 2);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'MTBF', 'エムティービーエフ', 'Thời gian trung bình giữa các hư hỏng', '', '', '', 3);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'MTTF', 'エムティーティーエフ', 'Thời gian đến hư hỏng trung bình', '', '', '', 4);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'SSR', 'エスエスアール', 'Rơle trạng thái rắn', '', '', '', 5);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'PID', 'ピーアイディー', 'Điều khiển tỷ lệ–tích phân–vi phân', '', '', '', 6);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'PTP', 'ピーティーピー', 'Điều khiển từ điểm đến điểm', '', '', '', 7);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'NC', 'エヌシー', 'Điều khiển số', '', '', '', 8);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'VDT', 'ブイディーティー', 'Thiết bị hiển thị; công việc với màn hình', '', '', '', 9);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'JIS', 'ジス', 'Tiêu chuẩn công nghiệp Nhật Bản', '', '', '', 10);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'SUS304', 'サスさんまるよん', 'Mác thép không gỉ austenit', '', '', '', 11);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'DC', 'ディーシー', 'Dòng điện một chiều', '', '', '', 12);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'AC', 'エーシー', 'Dòng điện xoay chiều', '', '', '', 13);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'COM', 'コモン', 'Cực chung', '', '', '', 14);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ON', 'オン', 'Trạng thái bật/dẫn', '', '', '', 15);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'Vベルト', 'ブイベルト', 'Đai V', '', '', '', 16);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'マシニングセンタ', 'マシニングセンタ', 'Trung tâm gia công', '', '', '', 17);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ロータリエンコーダ', 'ロータリエンコーダ', 'Encoder quay', '', '', '', 18);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'インクリメンタル', 'インクリメンタル', 'Kiểu gia tăng, đếm xung', '', '', '', 19);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'アブソリュート', 'アブソリュート', 'Kiểu tuyệt đối', '', '', '', 20);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'クローズドループ', 'クローズドループ', 'Vòng kín', '', '', '', 21);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'オープンループ', 'オープンループ', 'Vòng hở', '', '', '', 22);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'フィードフォワード', 'フィードフォワード', 'Điều khiển đón trước', '', '', '', 23);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'カスケード制御', 'カスケードせいぎょ', 'Điều khiển nối tầng', '', '', '', 24);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'バスタブ曲線', 'バスタブきょくせん', 'Đường cong bồn tắm', '', '', '', 25);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'エロージョン', 'エロージョン', 'Xói mòn cơ học', '', '', '', 26);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'サージング', 'サージング', 'Dao động áp suất và lưu lượng', '', '', '', 27);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ウォータハンマ', 'ウォータハンマ', 'Búa nước', '', '', '', 28);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'フールプルーフ', 'フールプルーフ', 'Thiết kế phòng sai thao tác', '', '', '', 29);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'フェールセーフ', 'フェールセーフ', 'Thiết kế an toàn khi hỏng', '', '', '', 30);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'デューティ比', 'デューティひ', 'Tỷ số thời gian ON với chu kỳ', '', '', '', 31);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'リアクタンス', 'リアクタンス', 'Điện kháng', '', '', '', 32);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'クランプメータ', 'クランプメータ', 'Ampe kìm', '', '', '', 33);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'リード', 'リード', 'Bước tiến ren', '', '', '', 34);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ピッチ', 'ピッチ', 'Bước ren', '', '', '', 35);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'アクチュエータ', 'アクチュエータ', 'Cơ cấu chấp hành', '', '', '', 36);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', 'Mẫu câu tiếng Nhật', 'Cách đọc bằng kana', 'Nghĩa tiếng Việt / cách xử lý khi làm bài', '', '', '', 37);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～とは、～である。', '～とは、～である。', 'Định nghĩa “X là…”. Kiểm tra đặc trưng, phạm vi và điều kiện trong định nghĩa.', '', '', '', 38);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～に関する記述のうち、適切なものはどれか。', '～にかんするきじゅつのうち、てきせつなものはどれか。', 'Trong các phát biểu về…, phát biểu nào phù hợp? Chọn một phát biểu đúng.', '', '', '', 39);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～に関する記述のうち、適切でないものはどれか。', '～にかんするきじゅつのうち、てきせつでないものはどれか。', 'Phát biểu nào không phù hợp? Chú ý phủ định でない trước khi chọn.', '', '', '', 40);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～の組合せとして、適切なものはどれか。', '～のくみあわせとして、てきせつなものはどれか。', 'Tổ hợp nào phù hợp? Kiểm tra mọi thành phần trong cùng một lựa chọn.', '', '', '', 41);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '下図に示す～', 'かずにしめす～', '…được thể hiện trong hình dưới. Đọc cả nhãn, số liệu và đường nối.', '', '', '', 42);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '下表のデータで～を作成する場合、', 'かひょうのデータで～をさくせいするばあい、', 'Khi lập… từ dữ liệu bảng dưới. Xác định đại lượng trước khi tính.', '', '', '', 43);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～に当てはまる語句', '～にあてはまるごく', 'Từ/cụm từ phù hợp để điền vào chỗ trống.', '', '', '', 44);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～と比べ、～', '～とくらべ、～', 'So với…; giữ đúng đối tượng làm mốc so sánh.', '', '', '', 45);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～ほど～', '～ほど～', 'Càng… càng…; kiểm tra chiều tăng/giảm.', '', '', '', 46);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～を超える', '～をこえる', 'Vượt quá…; là >, khác với 以上 là ≥.', '', '', '', 47);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～を考慮しない場合、', '～をこうりょしないばあい、', 'Nếu không xét…; bỏ đúng yếu tố được nêu, không tự thêm giả thiết.', '', '', '', 48);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～に従って～', '～にしたがって～', 'Theo…; nhận ra quy trình hoặc chương trình chi phối thao tác.', '', '', '', 49);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～として、もっとも適切なものはどれか。', '～として、もっともてきせつなものはどれか。', 'Chọn phương án phù hợp nhất, xét đầy đủ ứng dụng và điều kiện.', '', '', '', 50);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～しなければならない。', '～しなければならない。', 'Phải…; kiểm tra tính bắt buộc và điều kiện áp dụng.', '', '', '', 51);
END $$;

DO $$
DECLARE cert_id INT;
BEGIN
    SELECT id INTO cert_id FROM certificates WHERE code = 'denkihozen2';
    DELETE FROM certificate_exam_questions WHERE certificate_id = cert_id;

    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Gia công, điện và điều khiển cơ bản', 1, 'ボール盤のドリルにおいて、切り先のねじれ角が大きくなるほど切れ味は上がるが、刃先
が欠けやすくなる。', 'Ở mũi khoan của máy khoan bàn, góc xoắn ở phần mũi cắt càng lớn thì khả năng cắt càng tốt, nhưng lưỡi cắt càng dễ bị mẻ.', NULL, '○ — Đúng', 'Góc xoắn lớn giúp thoát phoi và cắt nhẹ hơn, nhưng làm phần lưỡi yếu hơn. Đừng nhầm khả năng cắt tốt với độ bền hoặc độ cứng vững cao.', '[{"term": "ボール盤", "reading": "ボールばん", "meaning": "máy khoan bàn"}, {"term": "ねじれ角", "reading": "ねじれかく", "meaning": "góc xoắn"}, {"term": "刃先", "reading": "はさき", "meaning": "lưỡi cắt"}, {"term": "欠ける", "reading": "かける", "meaning": "bị mẻ"}]'::jsonb, 1);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Gia công, điện và điều khiển cơ bản', 2, '放電加工機は、工具を陰極、工作物を陽極として、電解液中で電極間に電流を流すこと
で加工する工作機械である。', 'Máy gia công phóng điện là máy công cụ gia công bằng cách dùng dụng cụ làm cực âm, phôi làm cực dương và cho dòng điện chạy giữa các điện cực trong dung dịch điện phân.', NULL, '× — Sai', 'Phát biểu mô tả cơ chế gia công điện hóa. Gia công phóng điện sử dụng các xung phóng điện trong chất lỏng điện môi để bóc vật liệu bằng tác dụng nhiệt. Không dùng dòng điện phân liên tục làm cơ chế gia công. Cực tính điện cực còn tùy điều kiện gia công.', '[{"term": "放電加工機", "reading": "ほうでんかこうき", "meaning": "máy gia công phóng điện"}, {"term": "工作物", "reading": "こうさくぶつ", "meaning": "phôi"}, {"term": "電解液", "reading": "でんかいえき", "meaning": "dung dịch điện phân"}, {"term": "陰極", "reading": "いんきょく", "meaning": "cực âm"}]'::jsonb, 2);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Gia công, điện và điều khiển cơ bản', 3, '電流と電圧の位相差をθとする時、力率はsinθであらわされる。', 'Khi gọi độ lệch pha giữa dòng điện và điện áp là θ, hệ số công suất được biểu diễn bằng sinθ.', NULL, '× — Sai', 'Với điện áp và dòng điện hình sin, hệ số công suất là cosθ = P/S. sinθ liên quan đến thành phần công suất phản kháng. Khi θ = 0, hệ số công suất bằng 1, giúp kiểm tra ngay sự nhầm lẫn.', '[{"term": "位相差", "reading": "いそうさ", "meaning": "độ lệch pha"}, {"term": "力率", "reading": "りきりつ", "meaning": "hệ số công suất"}, {"term": "電圧", "reading": "でんあつ", "meaning": "điện áp"}]'::jsonb, 3);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Gia công, điện và điều khiển cơ bản', 4, 'SSR（ソリッドステートリレー）は、無接点リレーの一種である。', 'SSR (rơle trạng thái rắn) là một loại rơle không tiếp điểm.', NULL, '○ — Đúng', 'SSR đóng cắt bằng linh kiện bán dẫn, không dùng tiếp điểm cơ khí chuyển động. Tuy không có mài mòn tiếp điểm, vẫn cần chú ý dòng rò khi tắt và nhiệt phát sinh khi dẫn.', '[{"term": "無接点", "reading": "むせってん", "meaning": "không tiếp điểm"}, {"term": "ソリッドステートリレー", "reading": "ソリッドステートリレー", "meaning": "rơle trạng thái rắn"}, {"term": "リレー", "reading": "リレー", "meaning": "rơle"}]'::jsonb, 4);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Gia công, điện và điều khiển cơ bản', 5, 'カスケード制御とは、1つの制御装置の出力信号によって他の制御系の目標値を決定す
る制御である。', 'Điều khiển cascade là điều khiển trong đó tín hiệu đầu ra của một bộ điều khiển quyết định giá trị đặt của hệ điều khiển khác.', NULL, '○ — Đúng', 'Đầu ra vòng điều khiển ngoài trở thành giá trị đặt của vòng trong. Hai vòng có quan hệ nối tầng; không phải hai bộ điều khiển cùng hoạt động độc lập.', '[{"term": "制御装置", "reading": "せいぎょそうち", "meaning": "bộ điều khiển"}, {"term": "出力信号", "reading": "しゅつりょくしんごう", "meaning": "tín hiệu đầu ra"}, {"term": "目標値", "reading": "もくひょうち", "meaning": "giá trị đặt"}]'::jsonb, 5);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Bảo trì, độ tin cậy và hư hỏng', 6, '改良保全とは、設備を使用開始前の状態に戻す保全方式である。', 'Bảo trì cải tiến là phương thức bảo trì đưa thiết bị trở về trạng thái trước khi bắt đầu sử dụng.', NULL, '× — Sai', 'Bảo trì cải tiến thay đổi cấu tạo hoặc điều kiện để nâng độ tin cậy, khả năng bảo trì và giảm hư hỏng lặp lại. Khôi phục trạng thái ban đầu là sửa chữa hoặc phục hồi, chưa thể gọi là cải tiến.', '[{"term": "改良保全", "reading": "かいりょうほぜん", "meaning": "bảo trì cải tiến"}, {"term": "保全方式", "reading": "ほぜんほうしき", "meaning": "phương thức bảo trì"}, {"term": "設備", "reading": "せつび", "meaning": "thiết bị"}]'::jsonb, 6);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Bảo trì, độ tin cậy và hư hỏng', 7, '解析方法の1つであるFMEAは、故障の木解析と呼ばれる。', 'FMEA, một phương pháp phân tích, được gọi là phân tích cây hư hỏng.', NULL, '× — Sai', 'FMEA là phân tích dạng hư hỏng và ảnh hưởng: xét từng dạng hư hỏng rồi đánh giá tác động. Phân tích cây hư hỏng là FTA, đi từ sự kiện đỉnh xuống các nguyên nhân.', '[{"term": "故障", "reading": "こしょう", "meaning": "hư hỏng"}, {"term": "解析", "reading": "かいせき", "meaning": "phân tích"}, {"term": "故障の木解析", "reading": "こしょうのきかいせき", "meaning": "phân tích cây hư hỏng"}]'::jsonb, 7);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Bảo trì, độ tin cậy và hư hỏng', 8, '設備の時間稼働率(%)は下記の式で求められる。
稼働時間 ÷ 負荷時間 × 100', 'Tỷ lệ hoạt động theo thời gian (%) của thiết bị được tính bằng công thức sau.
Thời gian hoạt động ÷ thời gian tải × 100.', NULL, '○ — Đúng', 'Thời gian tải là thời gian dự kiến dành cho sản xuất; thời gian hoạt động bằng thời gian tải trừ thời gian dừng. Vì vậy tỷ lệ này đo mức sử dụng thời gian, không phải tỷ lệ sản phẩm đạt hoặc hiệu suất tốc độ.', '[{"term": "時間稼働率", "reading": "じかんかどうりつ", "meaning": "tỷ lệ hoạt động theo thời gian"}, {"term": "稼働時間", "reading": "かどうじかん", "meaning": "thời gian hoạt động"}, {"term": "負荷時間", "reading": "ふかじかん", "meaning": "thời gian tải"}]'::jsonb, 8);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Bảo trì, độ tin cậy và hư hỏng', 9, '故障のメカニズムとは、機械が故障してから、生産活動に影響が及ぶまでの過程である。', 'Cơ chế hư hỏng là quá trình từ lúc máy hư hỏng đến lúc hoạt động sản xuất bị ảnh hưởng.', NULL, '× — Sai', 'Cơ chế hư hỏng là quá trình vật lý, hóa học hoặc cơ học dẫn đến hư hỏng, như mỏi, ăn mòn hoặc phá hủy cách điện. Hậu quả đối với sản xuất xuất hiện sau đó và không phải định nghĩa của cơ chế.', '[{"term": "メカニズム", "reading": "メカニズム", "meaning": "cơ chế"}, {"term": "生産活動", "reading": "せいさんかつどう", "meaning": "hoạt động sản xuất"}, {"term": "影響", "reading": "えいきょう", "meaning": "ảnh hưởng"}]'::jsonb, 9);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Bảo trì, độ tin cậy và hư hỏng', 10, 'MTＢＦとは、ある期間中の総動作時間を総故障数で除した値である。', 'MTＢＦ là giá trị lấy tổng thời gian vận hành trong một khoảng thời gian chia cho tổng số hư hỏng.', NULL, '○ — Đúng', 'MTBF = tổng thời gian vận hành / số hư hỏng, dùng cho đối tượng có thể sửa chữa. Đơn vị là thời gian, chẳng hạn giờ. Không nhầm với MTTR là thời gian sửa chữa trung bình hoặc MTTF của đối tượng không sửa chữa.', '[{"term": "総動作時間", "reading": "そうどうさじかん", "meaning": "tổng thời gian vận hành"}, {"term": "総故障数", "reading": "そうこしょうすう", "meaning": "tổng số hư hỏng"}, {"term": "除する", "reading": "じょする", "meaning": "chia"}]'::jsonb, 10);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Bảo trì, độ tin cậy và hư hỏng', 11, 'バスタブ曲線における摩耗故障期間とは、故障率がほぼ一定と見なすことができる期間
のことである。', 'Giai đoạn hư hỏng do hao mòn trong đường cong bồn tắm là giai đoạn có thể coi tỷ lệ hư hỏng gần như không đổi.', NULL, '× — Sai', 'Tỷ lệ hư hỏng gần như không đổi là giai đoạn hư hỏng ngẫu nhiên. Ở giai đoạn hao mòn cuối vòng đời, tỷ lệ hư hỏng tăng theo thời gian do lão hóa và mài mòn.', '[{"term": "バスタブ曲線", "reading": "バスタブきょくせん", "meaning": "đường cong bồn tắm"}, {"term": "摩耗故障期間", "reading": "まもうこしょうきかん", "meaning": "giai đoạn hư hỏng do hao mòn"}, {"term": "故障率", "reading": "こしょうりつ", "meaning": "tỷ lệ hư hỏng"}]'::jsonb, 11);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Bảo trì, độ tin cậy và hư hỏng', 12, 'ライフサイクルコストとは、設備の運用中にかかった保全費用の合計である。', 'Chi phí vòng đời là tổng chi phí bảo trì phát sinh trong khi vận hành thiết bị.', NULL, '× — Sai', 'Chi phí vòng đời bao gồm chi phí mua sắm, lắp đặt, vận hành, bảo trì và xử lý cuối vòng đời. Chi phí bảo trì trong vận hành chỉ là một phần của tổng này.', '[{"term": "ライフサイクルコスト", "reading": "ライフサイクルコスト", "meaning": "chi phí vòng đời"}, {"term": "保全費用", "reading": "ほぜんひよう", "meaning": "chi phí bảo trì"}, {"term": "運用", "reading": "うんよう", "meaning": "vận hành"}]'::jsonb, 12);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Bảo trì, độ tin cậy và hư hỏng', 13, 'エロージョンとは、配管のエルボなどの曲がり部分の内面が、流体の摩擦作用により徐々
に摩耗する機械的な浸食現象である。', 'Erosion là hiện tượng xâm thực cơ học, trong đó bề mặt trong tại các đoạn cong như khuỷu ống bị mài mòn dần bởi tác động ma sát của chất lưu.', NULL, '○ — Đúng', 'Dòng chảy, đặc biệt khi có hạt rắn hoặc đổi hướng tại khuỷu, có thể bóc vật liệu bề mặt. Phân biệt erosion do cơ học với corrosion do phản ứng hóa học và cavitation do sự hình thành, vỡ bọt hơi.', '[{"term": "エロージョン", "reading": "エロージョン", "meaning": "xói mòn cơ học"}, {"term": "配管", "reading": "はいかん", "meaning": "đường ống"}, {"term": "エルボ", "reading": "エルボ", "meaning": "khuỷu ống"}, {"term": "流体", "reading": "りゅうたい", "meaning": "chất lưu"}]'::jsonb, 13);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Kiểm tra chất lượng và thống kê', 14, '抜取検査では、同一の生産条件で生産された製品の集まりについて、無作為に一部を取
り出して検査をする。', 'Trong kiểm tra lấy mẫu, lấy ngẫu nhiên một phần từ tập hợp sản phẩm được sản xuất trong cùng điều kiện để kiểm tra.', NULL, '○ — Đúng', 'Mẫu được lấy từ một lô có điều kiện sản xuất chung. Lấy ngẫu nhiên giúp hạn chế thiên lệch; kết quả mẫu được dùng để đánh giá lô theo tiêu chuẩn lấy mẫu. Không phải kiểm tra mọi sản phẩm.', '[{"term": "抜取検査", "reading": "ぬきとりけんさ", "meaning": "kiểm tra lấy mẫu"}, {"term": "無作為", "reading": "むさくい", "meaning": "ngẫu nhiên"}, {"term": "生産条件", "reading": "せいさんじょうけん", "meaning": "điều kiện sản xuất"}]'::jsonb, 14);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Kiểm tra chất lượng và thống kê', 15, '正規分布において、平均値μ±3σ内にデータが現れる確率は97%である。', 'Trong phân phối chuẩn, xác suất dữ liệu xuất hiện trong khoảng giá trị trung bình μ ± 3σ là 97%.', NULL, '× — Sai', 'Khoảng μ ± 3σ chứa khoảng 99,73% dữ liệu của phân phối chuẩn. σ là độ lệch chuẩn; μ ± 2σ chứa khoảng 95,45%. Không nhầm số lần σ với tỷ lệ phần trăm.', '[{"term": "正規分布", "reading": "せいきぶんぷ", "meaning": "phân phối chuẩn"}, {"term": "平均値", "reading": "へいきんち", "meaning": "giá trị trung bình"}, {"term": "確率", "reading": "かくりつ", "meaning": "xác suất"}]'::jsonb, 15);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Kiểm tra chất lượng và thống kê', 16, '管理図を用いたデータ解析における計数値の例として、故障発生件数が挙げられる。', 'Số lần phát sinh hư hỏng là một ví dụ về dữ liệu đếm trong phân tích dữ liệu bằng biểu đồ kiểm soát.', NULL, '○ — Đúng', 'Dữ liệu đếm là số nguyên thu được bằng đếm sự kiện hoặc sản phẩm. Số lần hư hỏng thuộc loại này; chiều dài, nhiệt độ hoặc khối lượng là dữ liệu đo.', '[{"term": "管理図", "reading": "かんりず", "meaning": "biểu đồ kiểm soát"}, {"term": "計数値", "reading": "けいすうち", "meaning": "dữ liệu đếm"}, {"term": "故障発生件数", "reading": "こしょうはっせいけんすう", "meaning": "số lần phát sinh hư hỏng"}]'::jsonb, 16);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Kiểm tra chất lượng và thống kê', 17, 'np管理図は、不適合品率を管理する場合に用いる。', 'Biểu đồ kiểm soát np được dùng khi kiểm soát tỷ lệ sản phẩm không phù hợp.', NULL, '× — Sai', 'Biểu đồ np theo dõi số sản phẩm không phù hợp khi cỡ mẫu n cố định. Biểu đồ p theo dõi tỷ lệ sản phẩm không phù hợp. Đừng nhầm số lượng np với tỷ lệ p.', '[{"term": "不適合品率", "reading": "ふてきごうひんりつ", "meaning": "tỷ lệ sản phẩm không phù hợp"}, {"term": "不適合品", "reading": "ふてきごうひん", "meaning": "sản phẩm không phù hợp"}, {"term": "管理", "reading": "かんり", "meaning": "kiểm soát"}]'::jsonb, 17);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Vật liệu và nhiệt luyện', 18, 'ステンレス鋼は、炭素を10.5％以上含む合金鋼である。', 'Thép không gỉ là thép hợp kim chứa từ 10.5％ cacbon trở lên.', NULL, '× — Sai', 'Thành phần tạo tính không gỉ là crôm, với hàm lượng tối thiểu khoảng 10,5% khối lượng; không phải 10,5% cacbon. Crôm tạo màng thụ động bảo vệ bề mặt.', '[{"term": "ステンレス鋼", "reading": "ステンレスこう", "meaning": "thép không gỉ"}, {"term": "炭素", "reading": "たんそ", "meaning": "cacbon"}, {"term": "合金鋼", "reading": "ごうきんこう", "meaning": "thép hợp kim"}]'::jsonb, 18);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Vật liệu và nhiệt luyện', 19, 'アルミニウムは、鉄に比べ融点が低い。', 'Nhôm có nhiệt độ nóng chảy thấp hơn sắt.', NULL, '○ — Đúng', 'Nhôm nguyên chất nóng chảy khoảng 660°C, sắt nguyên chất khoảng 1.538°C. So sánh này nói về nhiệt độ nóng chảy, không phải nhiệt độ làm việc cho phép hoặc độ bền.', '[{"term": "アルミニウム", "reading": "アルミニウム", "meaning": "nhôm"}, {"term": "鉄", "reading": "てつ", "meaning": "sắt"}, {"term": "融点", "reading": "ゆうてん", "meaning": "nhiệt độ nóng chảy"}]'::jsonb, 19);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Vật liệu và nhiệt luyện', 20, '鋼の焼入れは、鋼を硬化させ、強度を高めるために行う。', 'Tôi thép được thực hiện nhằm làm thép cứng hơn và tăng độ bền.', NULL, '○ — Đúng', 'Tôi gồm nung đến vùng thích hợp rồi làm nguội nhanh để tạo tổ chức cứng, thường là martensit. Sau tôi thường cần ram để giảm giòn và ứng suất; tôi không đồng nghĩa với ủ mềm.', '[{"term": "焼入れ", "reading": "やきいれ", "meaning": "tôi"}, {"term": "硬化", "reading": "こうか", "meaning": "làm cứng"}, {"term": "強度", "reading": "きょうど", "meaning": "độ bền"}]'::jsonb, 20);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Thiết kế an toàn và an toàn lao động', 21, 'フールプルーフ設計は、機械の操作手順を間違えても、あるいは危険性などをよく理解し
ていない作業者が操作しても危険が生じないようにした設計である。', 'Thiết kế foolproof là thiết kế sao cho không phát sinh nguy hiểm dù người vận hành làm sai trình tự thao tác máy, hoặc người chưa hiểu rõ nguy hiểm thực hiện thao tác.', NULL, '○ — Đúng', 'Foolproof phòng ngừa nguy hiểm do thao tác sai, ví dụ cơ cấu không cho khởi động khi cửa bảo vệ mở. Fail-safe hướng đến trạng thái an toàn khi thiết bị hư hỏng. Hai khái niệm có mục tiêu khác nhau.', '[{"term": "操作手順", "reading": "そうさてじゅん", "meaning": "trình tự thao tác"}, {"term": "作業者", "reading": "さぎょうしゃ", "meaning": "người làm việc"}, {"term": "危険性", "reading": "きけんせい", "meaning": "tính nguy hiểm"}]'::jsonb, 21);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Thiết kế an toàn và an toàn lao động', 22, '職業性疾病の原因となるＶＤＴ作業の例として、パソコンを用いたデータ入力が挙げられ
る。', 'Nhập dữ liệu bằng máy tính là một ví dụ về công việc VDT có thể gây bệnh nghề nghiệp.', NULL, '○ — Đúng', 'VDT là làm việc với màn hình hiển thị. Nhìn màn hình và thao tác lâu có thể gây mỏi mắt, khó chịu cơ xương và căng thẳng; nhập dữ liệu bằng máy tính là ví dụ điển hình.', '[{"term": "職業性疾病", "reading": "しょくぎょうせいしっぺい", "meaning": "bệnh nghề nghiệp"}, {"term": "データ入力", "reading": "データにゅうりょく", "meaning": "nhập dữ liệu"}, {"term": "作業", "reading": "さぎょう", "meaning": "công việc"}]'::jsonb, 22);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Thiết kế an toàn và an toàn lao động', 23, '空気中の酸素濃度が16%の場合、酸素欠乏状態にあるといえる。', 'Nếu nồng độ oxy trong không khí là 16%, có thể nói đó là trạng thái thiếu oxy.', NULL, '○ — Đúng', 'Quy định Nhật Bản xác định thiếu oxy khi nồng độ oxy dưới 18%. Vì 16% < 18%, phát biểu đúng. Đừng dùng mức oxy không khí bình thường khoảng 21% làm ngưỡng pháp lý.', '[{"term": "酸素濃度", "reading": "さんそのうど", "meaning": "nồng độ oxy"}, {"term": "酸素欠乏", "reading": "さんそけつぼう", "meaning": "thiếu oxy"}, {"term": "空気中", "reading": "くうきちゅう", "meaning": "trong không khí"}]'::jsonb, 23);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Thiết kế an toàn và an toàn lao động', 24, 'B火災とは、木材、紙、繊維などが燃える火災のことである。', 'Cháy loại B là cháy các vật như gỗ, giấy và sợi.', NULL, '× — Sai', 'Gỗ, giấy và sợi thuộc cháy loại A. Cháy loại B là cháy dầu và chất lỏng dễ cháy như xăng. Phân biệt với cháy điện loại C trong cách phân loại dùng ở Nhật.', '[{"term": "火災", "reading": "かさい", "meaning": "hỏa hoạn"}, {"term": "木材", "reading": "もくざい", "meaning": "gỗ"}, {"term": "繊維", "reading": "せんい", "meaning": "sợi"}]'::jsonb, 24);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Thiết kế an toàn và an toàn lao động', 25, 'クレーン等安全規則によると、玉掛け作業において、ワイヤロープの直径の減少が公称径
の7%を超えるものは使用不可である。', 'Theo Quy tắc an toàn cần trục và thiết bị liên quan, trong công việc móc buộc tải, không được dùng cáp thép có mức giảm đường kính vượt quá 7% đường kính danh nghĩa.', NULL, '○ — Đúng', 'Điều 215 cấm dùng cáp móc tải khi đường kính giảm quá 7% so với danh nghĩa. Nếu d₀ là đường kính danh nghĩa và d là đường kính đo được, mức giảm = (d₀ − d)/d₀ × 100%. Chú ý từ “vượt quá”, không đổi thành “từ 7% trở lên”.', '[{"term": "玉掛け", "reading": "たまかけ", "meaning": "móc buộc tải"}, {"term": "ワイヤロープ", "reading": "ワイヤロープ", "meaning": "cáp thép"}, {"term": "公称径", "reading": "こうしょうけい", "meaning": "đường kính danh nghĩa"}]'::jsonb, 25);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Động cơ và điều khiển tự động', 26, '誘導電動機の速度制御に関する記述のうち、適切なものはどれか。
ア 回生制動において、極数を切り換えても停止までの制動はできない。
イ 機械制動は、回生制動に比べてエネルギー効率がよい制動方法である。
ウ 極数変換電動機の極数を多い方から少ない方に切り換えることにより回転数が小さ
くなる。
エ 一次周波数制御において、周波数を低い方から高い方に切り換えることにより回転
数が小さくなる。', 'Trong các phát biểu về điều khiển tốc độ động cơ cảm ứng, phát biểu nào phù hợp?
ア Khi hãm tái sinh, dù đổi số cực cũng không thể hãm đến khi dừng hẳn.
イ Hãm cơ khí có hiệu suất năng lượng tốt hơn hãm tái sinh.
ウ Đổi động cơ đổi cực từ số cực nhiều sang ít sẽ làm tốc độ quay giảm.
エ Trong điều khiển tần số sơ cấp, đổi tần số từ thấp sang cao sẽ làm tốc độ quay giảm.', NULL, 'ア', 'Hãm tái sinh của động cơ cảm ứng xảy ra khi tốc độ rôto vượt tốc độ đồng bộ; khi tốc độ giảm đến gần đồng bộ, không thể tiếp tục hãm đến 0 bằng cơ chế này. nₛ = 120f/p: giảm số cực hoặc tăng tần số đều tăng tốc độ đồng bộ. Hãm cơ khí tiêu tán năng lượng, còn tái sinh trả năng lượng về nguồn.', '[{"term": "誘導電動機", "reading": "ゆうどうでんどうき", "meaning": "động cơ cảm ứng"}, {"term": "回生制動", "reading": "かいせいせいどう", "meaning": "hãm tái sinh"}, {"term": "極数", "reading": "きょくすう", "meaning": "số cực"}]'::jsonb, 26);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Động cơ và điều khiển tự động', 27, '電動機に関する記述のうち、適切でないものはどれか。
ア サーボモータに適した制御は、クローズドループ方式である。
イ 同期電動機は、始動トルクがゼロである。
ウ 三相誘導電動機は、すべりが小さくなるほど回転速度が速くなる。
エ 同期電動機は、直流電動機に分類される。', 'Trong các phát biểu về động cơ điện, phát biểu nào không phù hợp?
ア Điều khiển phù hợp với động cơ servo là vòng kín.
イ Động cơ đồng bộ có mômen khởi động bằng không.
ウ Ở động cơ cảm ứng ba pha, độ trượt càng nhỏ thì tốc độ quay càng nhanh.
エ Động cơ đồng bộ được phân loại là động cơ một chiều.', NULL, 'エ', 'Động cơ đồng bộ thuộc động cơ xoay chiều. n = nₛ(1 − s), nên độ trượt s nhỏ hơn làm tốc độ gần nₛ hơn. Động cơ đồng bộ thông thường không tự khởi động với nguồn tần số cố định; thiết bị thực tế có thể có phương tiện khởi động hỗ trợ. Servo thường dùng phản hồi vòng kín.', '[{"term": "同期電動機", "reading": "どうきでんどうき", "meaning": "động cơ đồng bộ"}, {"term": "始動トルク", "reading": "しどうトルク", "meaning": "mômen khởi động"}, {"term": "すべり", "reading": "すべり", "meaning": "độ trượt"}]'::jsonb, 27);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Động cơ và điều khiển tự động', 28, '一次巻線の巻数が200、二次巻線の巻数が100の理想的変圧器がある。この変圧器の
一次側に2Aの電流が流れたとき、二次側に流れる電流として、適切なものはどれか。
ア 1A
イ 2A
ウ 3A
エ 4A', 'Có một máy biến áp lý tưởng với 200 vòng ở cuộn sơ cấp và 100 vòng ở cuộn thứ cấp. Khi dòng sơ cấp là 2A, dòng thứ cấp nào phù hợp?
ア 1A
イ 2A
ウ 3A
エ 4A', NULL, 'エ', 'Ở máy biến áp lý tưởng, N₁I₁ = N₂I₂. Do đó I₂ = 200/100 × 2A = 4A. Tỷ số dòng điện ngược với tỷ số điện áp; ít vòng hơn ở thứ cấp dẫn đến điện áp thấp hơn nhưng dòng cao hơn.', '[{"term": "一次巻線", "reading": "いちじまきせん", "meaning": "cuộn sơ cấp"}, {"term": "二次巻線", "reading": "にじまきせん", "meaning": "cuộn thứ cấp"}, {"term": "巻数", "reading": "まきすう", "meaning": "số vòng dây"}]'::jsonb, 28);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Động cơ và điều khiển tự động', 29, '電子機器を使用した自動制御に関する記述のうち、適切なものはどれか。
ア PID制御とは、比例動作、積分動作、および微分動作の３つの動作を含む制御方式
である。
イ 予測制御とは、制御量を目標値と比較し、それらを一致させるように操作量を生成す
る制御方式である。
ウ フィードフォワード制御とは、あらかじめ定められた順序または手続きに従って制御の
各段階を逐次進めていく制御方式である。
エ PTP制御とは、あらかじめ定められた変化をする目標値に追従させる制御方式であ
る。', 'Trong các phát biểu về điều khiển tự động sử dụng thiết bị điện tử, phát biểu nào phù hợp?
ア PID là phương thức gồm ba tác động: tỷ lệ, tích phân và vi phân.
イ Điều khiển dự đoán so sánh đại lượng điều khiển với giá trị đặt và tạo đại lượng tác động để chúng trùng nhau.
ウ Điều khiển feedforward lần lượt tiến hành các bước theo thứ tự hoặc thủ tục đã định trước.
エ Điều khiển PTP làm đại lượng điều khiển bám theo giá trị đặt biến đổi theo quy luật định trước.', NULL, 'ア', 'PID gồm P, I và D. イ mô tả phản hồi; ウ mô tả điều khiển trình tự; エ mô tả điều khiển chương trình. PTP là điều khiển từ điểm đến điểm, chủ yếu đảm bảo vị trí đích, không định nghĩa toàn bộ quỹ đạo giữa các điểm.', '[{"term": "比例動作", "reading": "ひれいどうさ", "meaning": "tác động tỷ lệ"}, {"term": "積分動作", "reading": "せきぶんどうさ", "meaning": "tác động tích phân"}, {"term": "微分動作", "reading": "びぶんどうさ", "meaning": "tác động vi phân"}]'::jsonb, 29);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Động cơ và điều khiển tự động', 30, '2相式ロータリエンコーダに関する記述のうち、適切でないものはどれか。
ア インクリメンタル方式は、電源遮断時の位置を記憶できる。
イ アブソリュート方式は、電源遮断時の位置を記憶できる。
ウ インクリメンタル方式は、回転方向を検出できる。
エ アブソリュート方式は、回転方向を検出できる。', 'Trong các phát biểu về encoder quay hai pha, phát biểu nào không phù hợp?
ア Kiểu incremental có thể nhớ vị trí khi nguồn bị ngắt.
イ Kiểu absolute có thể nhớ vị trí khi nguồn bị ngắt.
ウ Kiểu incremental có thể phát hiện chiều quay.
エ Kiểu absolute có thể phát hiện chiều quay.', NULL, 'ア', 'Encoder incremental chỉ cung cấp xung dịch chuyển; hệ thống thông thường mất thông tin vị trí khi tắt nguồn và phải lấy lại gốc. Encoder absolute mã hóa vị trí tuyệt đối. Hai pha lệch nhau cho phép xác định chiều quay; một bộ đếm có pin bên ngoài không biến bản thân encoder incremental thành absolute.', '[{"term": "ロータリエンコーダ", "reading": "ロータリエンコーダ", "meaning": "encoder quay"}, {"term": "電源遮断", "reading": "でんげんしゃだん", "meaning": "ngắt nguồn"}, {"term": "回転方向", "reading": "かいてんほうこう", "meaning": "chiều quay"}]'::jsonb, 30);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Điện, điện tử và đo lường', 31, '電気および磁気に関する記述のうち、適切なものはどれか。
ア コンデンサに交流電圧を印加した場合、電流は静電容量に正比例する。
イ 比透磁率とは、磁性体の温度変化による透磁率の変化の割合のことである。
ウ 物質中の2つの電荷の間に働く力は電荷間の距離に比例する。
エ 磁力線は、Ｓ極から出てＮ極に入る。', 'Trong các phát biểu về điện và từ, phát biểu nào phù hợp?
ア Khi đặt điện áp xoay chiều lên tụ điện, dòng điện tỷ lệ thuận với điện dung.
イ Độ từ thẩm tương đối là tỷ lệ thay đổi độ từ thẩm do nhiệt độ của vật liệu từ thay đổi.
ウ Lực tác dụng giữa hai điện tích trong vật chất tỷ lệ thuận với khoảng cách giữa chúng.
エ Đường sức từ đi ra từ cực S và đi vào cực N.', NULL, 'ア', 'Với cùng tần số và điện áp, I = 2πfCU nên dòng qua tụ tỷ lệ với C. Độ từ thẩm tương đối μᵣ = μ/μ₀. Lực Coulomb tỷ lệ nghịch với bình phương khoảng cách; ngoài nam châm, đường sức từ đi từ N đến S.', '[{"term": "静電容量", "reading": "せいでんようりょう", "meaning": "điện dung"}, {"term": "比透磁率", "reading": "ひとうじりつ", "meaning": "độ từ thẩm tương đối"}, {"term": "磁力線", "reading": "じりょくせん", "meaning": "đường sức từ"}]'::jsonb, 31);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Điện, điện tử và đo lường', 32, '電子に関する記述のうち、適切なものはどれか。
ア 価電子とは、原子のもっとも外側の軌道にある電子である。
イ 自由電子の数が多い物質を絶縁体という。
ウ 帯電した物質が持つ電気の量（電荷）の単位は、［Q］である。
エ 電子1個は、約3×10⁸Ｃの正の電気量をもつ。', 'Trong các phát biểu về electron, phát biểu nào phù hợp?
ア Electron hóa trị là electron ở lớp quỹ đạo ngoài cùng của nguyên tử.
イ Chất có nhiều electron tự do được gọi là chất cách điện.
ウ Đơn vị lượng điện (điện tích) của vật đã nhiễm điện là ［Q］.
エ Một electron có điện lượng dương khoảng 3×10⁸Ｃ.', NULL, 'ア', 'Electron hóa trị ở lớp ngoài cùng. Nhiều electron tự do thường giúp dẫn điện. Q là ký hiệu đại lượng điện tích, đơn vị là C (coulomb). Điện tích electron là âm, khoảng −1,602×10⁻¹⁹ C, không phải giá trị dương ghi trong đề.', '[{"term": "価電子", "reading": "かでんし", "meaning": "electron hóa trị"}, {"term": "自由電子", "reading": "じゆうでんし", "meaning": "electron tự do"}, {"term": "絶縁体", "reading": "ぜつえんたい", "meaning": "chất cách điện"}]'::jsonb, 32);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Điện, điện tử và đo lường', 33, 'リアクタンスに関する文中の［a］内の数字に当てはまる語句の組合せとして、適切なも
のはどれか｡
「リアクタンスとは、交流回路のコイルやコンデンサにおける［a］と［b］の比であ
る。」
ア ［a］:電圧 ［b］:電流
イ ［a］:電圧 ［b］:抵抗
ウ ［a］:周波数 ［b］:電流
エ ［a］:周波数 ［b］:抵抗', 'Chọn tổ hợp từ phù hợp để điền vào ［a］/［b］ trong câu về điện kháng.
“Điện kháng là tỷ số giữa ［a］ và ［b］ ở cuộn cảm hoặc tụ điện trong mạch xoay chiều.”
ア ［a］: điện áp; ［b］: dòng điện
イ ［a］: điện áp; ［b］: điện trở
ウ ［a］: tần số; ［b］: dòng điện
エ ［a］: tần số; ［b］: điện trở', NULL, 'ア', 'Điện kháng có đơn vị Ω và bằng tỷ số độ lớn điện áp với dòng điện ở phần tử thuần phản kháng. X_L = 2πfL; X_C = 1/(2πfC). Không nhầm điện kháng với điện trở thuần hay tổng trở của mạch có cả R và X.', '[{"term": "リアクタンス", "reading": "リアクタンス", "meaning": "điện kháng"}, {"term": "交流回路", "reading": "こうりゅうかいろ", "meaning": "mạch xoay chiều"}, {"term": "コイル", "reading": "コイル", "meaning": "cuộn cảm"}]'::jsonb, 33);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Điện, điện tử và đo lường', 34, '下図の回路図において、電流をIとするとき、数値の組合せとして、適切なものはどれか。
ア I：3A Ⓐの電流：2A Ⓥの電圧：15V 回路の合成抵抗：15Ω
イ I：3A Ⓐの電流：1A Ⓥの電圧：30V 回路の合成抵抗：15Ω
ウ I：1.5A Ⓐの電流：1A Ⓥの電圧：15V 回路の合成抵抗：30Ω
エ I：1.5A Ⓐの電流：2A Ⓥの電圧：30V 回路の合成抵抗：30Ω

![Hình câu 34](images/2024_cau_34.png)', 'Trong sơ đồ dưới đây, gọi dòng điện là I. Tổ hợp số liệu nào phù hợp?
ア I: 3A; dòng qua ampe kế Ⓐ: 2A; điện áp vôn kế Ⓥ: 15V; điện trở tương đương: 15Ω.
イ I: 3A; dòng qua Ⓐ: 1A; điện áp Ⓥ: 30V; điện trở tương đương: 15Ω.
ウ I: 1.5A; dòng qua Ⓐ: 1A; điện áp Ⓥ: 15V; điện trở tương đương: 30Ω.
エ I: 1.5A; dòng qua Ⓐ: 2A; điện áp Ⓥ: 30V; điện trở tương đương: 30Ω.
Hình: nguồn 45V; cụm trái gồm 30Ω song song 15Ω; cụm phải gồm hai điện trở 10Ω song song.', NULL, 'イ', 'Cụm trái: 30×15/(30+15) = 10Ω. Cụm phải: 10×10/(10+10) = 5Ω. Tổng 15Ω nên I = 45/15 = 3A. Điện áp cụm trái 3×10 = 30V, dòng nhánh 30Ω là 30/30 = 1A. Vôn kế mắc song song, ampe kế đo dòng nhánh chứ không đo toàn mạch.', '[{"term": "合成抵抗", "reading": "ごうせいていこう", "meaning": "điện trở tương đương"}, {"term": "電流", "reading": "でんりゅう", "meaning": "dòng điện"}, {"term": "回路図", "reading": "かいろず", "meaning": "sơ đồ mạch"}]'::jsonb, 34);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Điện, điện tử và đo lường', 35, '電子回路に関する記述のうち、適切でないものはどれか。
ア パルス発生器には、無安定マルチバイブレータなどが用いられる。
イ パルス信号のデューティ比とは、パルスON時間÷パルスの周期で表される。
ウ パルス符号変調方式は、雑音に強い。
エ パルス増幅回路は、映像増幅回路などに用いられる。', 'Trong các phát biểu về mạch điện tử, phát biểu nào không phù hợp?
ア Bộ tạo xung sử dụng các mạch như đa hài phi ổn.
イ Hệ số duty của tín hiệu xung được biểu diễn bằng thời gian ON của xung ÷ chu kỳ xung.
ウ Phương thức điều chế mã xung có khả năng chống nhiễu tốt.
エ Mạch khuếch đại xung được dùng trong các mạch như khuếch đại hình ảnh.', NULL, 'イ', 'Bảng đáp án ghi イ. Tuy nhiên, công thức in tại lựa chọn イ là D = t_ON/T, đúng với định nghĩa duty thông thường; nếu biểu diễn phần trăm thì nhân 100%. Có sự không nhất quán giữa nội dung đề và đáp án được cung cấp. Giữ nguyên đáp án chính thức và không tạo lý do kỹ thuật giả để coi công thức này là sai. Cần bản đính chính hoặc xác nhận của đơn vị ra đề để kết luận nguyên nhân.', '[{"term": "パルス", "reading": "パルス", "meaning": "xung"}, {"term": "デューティ比", "reading": "デューティひ", "meaning": "hệ số duty"}, {"term": "周期", "reading": "しゅうき", "meaning": "chu kỳ"}, {"term": "雑音", "reading": "ざつおん", "meaning": "nhiễu"}]'::jsonb, 35);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Điện, điện tử và đo lường', 36, '2進数「10110110」を16進数に変換したものとして、適切なものはどれか。
ア 0xA5
イ 0xA6
ウ 0xB5
エ 0xB6', 'Giá trị nào phù hợp khi đổi số nhị phân “10110110” sang hệ thập lục phân?
ア 0xA5
イ 0xA6
ウ 0xB5
エ 0xB6', NULL, 'エ', 'Chia từ bên phải thành nhóm bốn bit: 1011 và 0110. 1011 = 11 = B; 0110 = 6. Ghép lại thành 0xB6; tiền tố 0x chỉ hệ thập lục phân.', '[{"term": "2進数", "reading": "にしんすう", "meaning": "số nhị phân"}, {"term": "16進数", "reading": "じゅうろくしんすう", "meaning": "số thập lục phân"}, {"term": "変換", "reading": "へんかん", "meaning": "chuyển đổi"}]'::jsonb, 36);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Điện, điện tử và đo lường', 37, '下図に示す交流回路は負荷の電圧・電流・電力を測定する回路である。図中に示す計器
a～cの組合せとして、適切なものはどれか。
ア a：電圧計 b：電流計 c：電力計
イ a：電圧計 b：電力計 c：電流計
ウ a：電流計 b：電圧計 c：電力計
エ a：電力計 b：電流計 c：電圧計

![Hình câu 37](images/2024_cau_37.png)', 'Mạch xoay chiều dưới đây đo điện áp, dòng điện và công suất của tải. Tổ hợp dụng cụ a–c nào phù hợp?
ア a: vôn kế; b: ampe kế; c: oát kế
イ a: vôn kế; b: oát kế; c: ampe kế
ウ a: ampe kế; b: vôn kế; c: oát kế
エ a: oát kế; b: ampe kế; c: vôn kế
Nhãn hình: 電源 = nguồn điện; 負荷 = tải.', NULL, 'ア', 'a mắc song song nên là vôn kế; b nối tiếp nên là ampe kế. c có đường dòng nối tiếp và nhánh điện áp song song nên là oát kế. Đừng nhận dạng dụng cụ chỉ theo vị trí trái/phải; phải theo cách nối dây.', '[{"term": "電圧計", "reading": "でんあつけい", "meaning": "vôn kế"}, {"term": "電流計", "reading": "でんりゅうけい", "meaning": "ampe kế"}, {"term": "電力計", "reading": "でんりょくけい", "meaning": "oát kế"}, {"term": "負荷", "reading": "ふか", "meaning": "tải"}]'::jsonb, 37);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Cảm biến, PLC và bảo trì điện', 38, '反射形光電センサの相互干渉対策として、適切でないものはどれか。
ア スリットで光の広がりを抑える。
イ 感度を低く調整する。
ウ 光軸をずらす。
エ 干渉しない距離だけ離す。', 'Biện pháp nào không phù hợp để chống nhiễu lẫn nhau giữa các cảm biến quang điện kiểu phản xạ?
ア Dùng khe chắn để hạn chế sự mở rộng của ánh sáng.
イ Điều chỉnh độ nhạy thấp hơn.
ウ Dịch lệch trục quang.
エ Đặt cách nhau đủ xa để không gây nhiễu.', NULL, 'ア', 'Đáp án là ア: khe chắn không phải biện pháp phù hợp theo dạng cảm biến phản xạ trong đề. Giảm độ nhạy, thay đổi hướng/trục hoặc tăng khoảng cách có thể giảm việc nhận ánh sáng của cảm biến khác. Khe chắn thường được áp dụng cho kiểu thu phát riêng để thu hẹp chùm tia; không khái quát cho mọi cảm biến.', '[{"term": "光電センサ", "reading": "こうでんセンサ", "meaning": "cảm biến quang điện"}, {"term": "相互干渉", "reading": "そうごかんしょう", "meaning": "nhiễu lẫn nhau"}, {"term": "光軸", "reading": "こうじく", "meaning": "trục quang"}]'::jsonb, 38);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Cảm biến, PLC và bảo trì điện', 39, 'リレーのうなりの原因として、適切でないものはどれか。
ア DCタイプをACラインで使用
イ 可動片と鉄心間の異物混入
ウ 接点への過電流
エ 電源電圧の変動', 'Nguyên nhân nào không phù hợp để giải thích tiếng ù của rơle?
ア Dùng loại DC trên đường điện AC
イ Dị vật lọt giữa phần động và lõi sắt
ウ Quá dòng tại tiếp điểm
エ Điện áp nguồn biến động', NULL, 'ウ', 'Tiếng ù thường liên quan đến lực hút điện từ hoặc khe hở làm phần động rung: dùng sai nguồn, dị vật hoặc điện áp không ổn định. Quá dòng ở tiếp điểm chủ yếu gây nóng, cháy hoặc hàn dính tiếp điểm; không phải nguyên nhân trực tiếp của tiếng ù cơ cấu từ trong câu này.', '[{"term": "うなり", "reading": "うなり", "meaning": "tiếng ù"}, {"term": "可動片", "reading": "かどうへん", "meaning": "phần động"}, {"term": "鉄心", "reading": "てっしん", "meaning": "lõi sắt"}, {"term": "過電流", "reading": "かでんりゅう", "meaning": "quá dòng"}]'::jsonb, 39);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Cảm biến, PLC và bảo trì điện', 40, '高調波の影響によって生じる現象と、その現象が発生する機器の組合せとして、適切で
ないものはどれか。
ア 現象：焼損 機器：コンデンサ
イ 現象：焼損 機器：リアクトル
ウ 現象：誤動作 機器：漏電遮断器
エ 現象：誤動作 機器：電磁接触器', 'Tổ hợp hiện tượng và thiết bị nào không phù hợp với ảnh hưởng của sóng hài?
ア Hiện tượng: cháy hỏng; thiết bị: tụ điện
イ Hiện tượng: cháy hỏng; thiết bị: cuộn kháng
ウ Hiện tượng: tác động sai; thiết bị: aptomat chống rò điện
エ Hiện tượng: tác động sai; thiết bị: công tắc tơ điện từ', NULL, 'エ', 'Sóng hài có thể làm dòng qua tụ hoặc cuộn kháng tăng, gây quá nhiệt; thành phần dòng tần số cao có thể ảnh hưởng aptomat chống rò. Tổ hợp công tắc tơ và tác động sai là lựa chọn không phù hợp theo đề. Không suy rộng thành khẳng định thiết bị hoàn toàn miễn nhiễm với mọi chất lượng nguồn xấu.', '[{"term": "高調波", "reading": "こうちょうは", "meaning": "sóng hài"}, {"term": "焼損", "reading": "しょうそん", "meaning": "cháy hỏng"}, {"term": "漏電遮断器", "reading": "ろうでんしゃだんき", "meaning": "aptomat chống rò"}, {"term": "電磁接触器", "reading": "でんじせっしょくき", "meaning": "công tắc tơ"}]'::jsonb, 40);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Cảm biến, PLC và bảo trì điện', 41, 'トランジスタ出力（シンク出力タイプ）方式のプログラマブルコントローラに負荷を接続し、
プログラマブルコントローラから制御する場合、適切なものはどれか。
ア
イ
ウ
エ

![Hình câu 41](images/2024_cau_41.png)', 'Khi nối tải vào bộ điều khiển lập trình có ngõ ra transistor kiểu sink và điều khiển tải bằng bộ điều khiển đó, sơ đồ nào phù hợp?
Các lựa chọn ア・イ・ウ・エ là bốn sơ đồ trong hình.
Nhãn hình: 負荷 = tải; 出力 = ngõ ra; ヒューズ = cầu chì; DC電源 = nguồn DC; AC100V電源 = nguồn AC100V; プログラマブルコントローラ = bộ điều khiển lập trình; COM = cực chung.', NULL, 'ア', 'Ngõ ra sink hút dòng về COM âm. Mạch đúng đi từ cực dương nguồn DC qua cầu chì và tải vào ngõ ra, rồi qua transistor về cực âm. ア có cách nối và cực tính phù hợp; không cấp AC trực tiếp cho ngõ ra transistor DC hoặc đảo cực nguồn.', '[{"term": "シンク出力", "reading": "シンクしゅつりょく", "meaning": "ngõ ra sink"}, {"term": "ヒューズ", "reading": "ヒューズ", "meaning": "cầu chì"}, {"term": "負荷", "reading": "ふか", "meaning": "tải"}, {"term": "接続", "reading": "せつぞく", "meaning": "kết nối"}]'::jsonb, 41);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Cảm biến, PLC và bảo trì điện', 42, '正常運転していた三相誘導電動機が異常発熱した。この場合の対応処置として、適切で
ないものはどれか。
ア 電磁開閉器を点検する。
イ 接地状態を点検する。
ウ 欠相していないかを点検する。
エ 電源電圧を点検する。', 'Một động cơ cảm ứng ba pha trước đó vận hành bình thường bị phát nhiệt bất thường. Biện pháp xử lý nào không phù hợp trong trường hợp này?
ア Kiểm tra bộ khởi động điện từ.
イ Kiểm tra tình trạng nối đất.
ウ Kiểm tra có mất pha hay không.
エ Kiểm tra điện áp nguồn.', NULL, 'イ', 'Mất pha, tiếp điểm kém hoặc điện áp bất thường có thể gây dòng tăng và nóng động cơ. Kiểm tra nối đất là việc an toàn quan trọng, nhưng không trực tiếp chẩn đoán các nguyên nhân phát nhiệt trong danh sách này, nên イ là lựa chọn cần loại theo câu hỏi.', '[{"term": "異常発熱", "reading": "いじょうはつねつ", "meaning": "phát nhiệt bất thường"}, {"term": "欠相", "reading": "けっそう", "meaning": "mất pha"}, {"term": "接地", "reading": "せっち", "meaning": "nối đất"}]'::jsonb, 42);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Cảm biến, PLC và bảo trì điện', 43, '電気設備に関する技術基準を定める省令において、絶縁電線の接続の条件として、適切
でないものはどれか。
ア 接続箇所は、その絶縁電線と同等以上の絶縁効力のあるもので十分に被覆する。
イ 接続箇所には、接続管その他の器具を使用する、またはろう付けする。
ウ 電線の電気抵抗を増加させない。
エ 電線の引張強度を30%以上減少させない。', 'Theo thông tư quy định tiêu chuẩn kỹ thuật thiết bị điện, điều kiện nào không phù hợp khi nối dây cách điện?
ア Bọc đầy đủ chỗ nối bằng vật liệu có hiệu quả cách điện bằng hoặc tốt hơn dây đó.
イ Dùng ống nối hoặc dụng cụ khác tại chỗ nối, hoặc hàn vảy.
ウ Không làm tăng điện trở của dây.
エ Không làm giảm độ bền kéo của dây từ 30% trở lên.', NULL, 'エ', 'Mốc yêu cầu là không giảm độ bền kéo từ 20% trở lên, với ngoại lệ áp dụng cho dây có lực kéo rất nhỏ theo quy định. Vì vậy mốc 30% trong エ không đúng. Chỗ nối đồng thời phải dẫn điện tốt, có độ bền cơ và phục hồi cách điện.', '[{"term": "絶縁電線", "reading": "ぜつえんでんせん", "meaning": "dây điện cách điện"}, {"term": "引張強度", "reading": "ひっぱりきょうど", "meaning": "độ bền kéo"}, {"term": "ろう付け", "reading": "ろうづけ", "meaning": "hàn vảy"}]'::jsonb, 43);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Cảm biến, PLC và bảo trì điện', 44, '下図に示す固定抵抗器において、抵抗値の許容差を示す箇所として、適切なものはどれ
か。
ア A
イ B
ウ C
エ D

![Hình câu 44](images/2024_cau_44.png)', 'Ở điện trở cố định trong hình, vị trí nào biểu thị dung sai của giá trị điện trở?
ア A
イ B
ウ C
エ D
Hình đánh dấu các vòng màu bằng A, B, C, D.', NULL, 'エ', 'Ở điện trở bốn vòng màu, hai vòng đầu là chữ số, vòng thứ ba là hệ số nhân, vòng cuối là dung sai. D là vòng cuối, được tách xa hơn. Không nhầm dung sai với hệ số nhân C.', '[{"term": "固定抵抗器", "reading": "こていていこうき", "meaning": "điện trở cố định"}, {"term": "許容差", "reading": "きょようさ", "meaning": "dung sai"}, {"term": "抵抗値", "reading": "ていこうち", "meaning": "giá trị điện trở"}]'::jsonb, 44);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Cảm biến, PLC và bảo trì điện', 45, '磁心材料として、適切なものはどれか。
ア 黒鉛
イ マグネシウム合金
ウ 真鍮
エ ケイ素鋼', 'Vật liệu nào phù hợp làm lõi từ?
ア Than chì
イ Hợp kim magiê
ウ Đồng thau
エ Thép silic', NULL, 'エ', 'Thép silic là vật liệu từ mềm dùng làm lõi máy biến áp và máy điện, giúp giảm tổn hao. Lõi thường ghép từ lá mỏng để hạn chế dòng điện xoáy. Than chì, hợp kim magiê và đồng thau không phải lựa chọn lõi từ phù hợp ở đây.', '[{"term": "磁心材料", "reading": "じしんざいりょう", "meaning": "vật liệu lõi từ"}, {"term": "ケイ素鋼", "reading": "ケイそこう", "meaning": "thép silic"}, {"term": "真鍮", "reading": "しんちゅう", "meaning": "đồng thau"}]'::jsonb, 45);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Cơ cấu, thủy lực và ký hiệu', 46, 'ねじに関する文中の［a］内に当てはまる語句として、適切なものはどれか。
「ねじの［a］とは、ねじを1回転したときに、ねじが軸方向に移動する距離のことである。」
ア ピッチ
イ 有効径
ウ 呼び径
エ リード', 'Từ nào phù hợp điền vào ［a］ trong câu về ren?
“［a］ của ren là khoảng cách ren dịch chuyển theo phương trục khi ren quay một vòng.”
ア Bước ren
イ Đường kính trung bình của ren
ウ Đường kính danh nghĩa
エ Bước tiến', NULL, 'エ', 'Lead là khoảng tiến theo trục sau một vòng. Với ren một đầu mối, lead bằng pitch; với ren z đầu mối, lead = z × pitch. Việc hai giá trị bằng nhau ở ren một đầu mối không làm hai định nghĩa giống nhau.', '[{"term": "リード", "reading": "リード", "meaning": "bước tiến"}, {"term": "ピッチ", "reading": "ピッチ", "meaning": "bước ren"}, {"term": "有効径", "reading": "ゆうこうけい", "meaning": "đường kính trung bình của ren"}, {"term": "軸方向", "reading": "じくほうこう", "meaning": "phương trục"}]'::jsonb, 46);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Cơ cấu, thủy lực và ký hiệu', 47, '搬送位置決め機構において使用される直動案内の構成部品として、適切でないものはど
れか。
ア レール
イ ブロック（キャリッジ）
ウ ボール
エ チェーン', 'Bộ phận nào không phù hợp với cấu tạo dẫn hướng tuyến tính dùng trong cơ cấu vận chuyển và định vị?
ア Ray
イ Khối trượt (carriage)
ウ Bi
エ Xích', NULL, 'エ', 'Dẫn hướng tuyến tính kiểu bi gồm ray, khối trượt và các viên bi tuần hoàn. Xích có thể truyền chuyển động trong hệ vận chuyển nhưng không phải thành phần của bộ dẫn hướng tuyến tính này.', '[{"term": "直動案内", "reading": "ちょくどうあんない", "meaning": "dẫn hướng tuyến tính"}, {"term": "位置決め", "reading": "いちぎめ", "meaning": "định vị"}, {"term": "構成部品", "reading": "こうせいぶひん", "meaning": "bộ phận cấu thành"}]'::jsonb, 47);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Cơ cấu, thủy lực và ký hiệu', 48, '油圧・空気圧装置に関する文中の［a］内に当てはまる文章として、適切なものはどれ
か。
「油圧装置は、空気圧装置と比べ、［a］。」
ア 応答速度が遅い
イ 小型で大きな出力を得ることができる
ウ 運転速度の調整が難しい
エ 温度変化によるアクチュエータの出力、速度への影響が小さい', 'Câu nào phù hợp điền vào ［a］ trong nội dung về thiết bị thủy lực và khí nén?
“So với thiết bị khí nén, thiết bị thủy lực ［a］.”
ア Có tốc độ đáp ứng chậm
イ Có thể tạo đầu ra lớn với kích thước nhỏ
ウ Khó điều chỉnh tốc độ vận hành
エ Đầu ra và tốc độ của cơ cấu chấp hành ít chịu ảnh hưởng của thay đổi nhiệt độ', NULL, 'イ', 'Thủy lực thường làm việc ở áp suất cao, nên F = pA cho lực lớn với diện tích piston nhỏ. Lưu lượng cho phép điều chỉnh tốc độ; nhiệt độ làm đổi độ nhớt dầu và có thể ảnh hưởng vận hành. Không coi đặc tính đáp ứng là cố định cho mọi hệ.', '[{"term": "油圧", "reading": "ゆあつ", "meaning": "thủy lực"}, {"term": "空気圧", "reading": "くうきあつ", "meaning": "khí nén"}, {"term": "出力", "reading": "しゅつりょく", "meaning": "đầu ra"}, {"term": "アクチュエータ", "reading": "アクチュエータ", "meaning": "cơ cấu chấp hành"}]'::jsonb, 48);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Cơ cấu, thủy lực và ký hiệu', 49, '下図はキリ穴の加工位置を示した図面である。［a］内に当てはまる数値として、適切な
ものはどれか。
ア 1,060
イ 1,140
ウ 1,220
エ 1,300

![Hình câu 49](images/2024_cau_49.png)', 'Hình dưới là bản vẽ vị trí gia công các lỗ khoan. Số nào phù hợp điền vào ［a］ trong hình?
ア 1,060
イ 1,140
ウ 1,220
エ 1,300
Dữ liệu hình: 15×18キリ = 15 lỗ khoan đường kính 18; khoảng cách tâm hai lỗ kề nhau 80; từ mép đến tâm lỗ đầu và cuối đều 50.', NULL, 'ウ', 'Có 15 lỗ nên có 14 khoảng tâm, không phải 15. Tổng chiều dài = 50 + 14×80 + 50 = 1.220. Ký hiệu 15×18キリ mô tả số lỗ và đường kính khoan; không phải 15 khoảng cách. Phần nét ngắt giữa hình chỉ rút ngắn bản vẽ.', '[{"term": "キリ穴", "reading": "キリあな", "meaning": "lỗ khoan"}, {"term": "加工位置", "reading": "かこういち", "meaning": "vị trí gia công"}, {"term": "図面", "reading": "ずめん", "meaning": "bản vẽ"}]'::jsonb, 49);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2024', 'Cơ cấu, thủy lực và ký hiệu', 50, 'JISにおいて、下図に示す電気用図記号の名称として、適切なものはどれか。
ア ブレーク接点（限時開路）
イ ブレーク接点（限時閉路）
ウ メーク接点（限時開路）
エ メーク接点（限時閉路）

![Hình câu 50](images/2024_cau_50.png)', 'Theo JIS, tên nào phù hợp với ký hiệu điện trong hình?
ア Tiếp điểm ngắt (mở có trễ)
イ Tiếp điểm ngắt (đóng có trễ)
ウ Tiếp điểm đóng (mở có trễ)
エ Tiếp điểm đóng (đóng có trễ)', NULL, 'ウ', 'Đáp án là tiếp điểm make với mở có trễ. Make là tiếp điểm thường mở ở trạng thái không tác động; ký hiệu bổ sung cho biết chiều tác động có trễ. Cần đọc cả dạng tiếp điểm và dấu chỉ thời gian, không chỉ nhận ra đây là tiếp điểm của bộ định thời.', '[{"term": "メーク接点", "reading": "メークせってん", "meaning": "tiếp điểm đóng, thường mở"}, {"term": "ブレーク接点", "reading": "ブレークせってん", "meaning": "tiếp điểm ngắt, thường đóng"}, {"term": "限時開路", "reading": "げんじかいろ", "meaning": "mở mạch có trễ"}]'::jsonb, 50);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Gia công, mạch điện và điều khiển', 1, 'ボール盤のドリルにおいて、ねじれ角が大きくなるほど切れ味は下がるが、剛性は上がる。', 'Ở mũi khoan của máy khoan bàn, góc xoắn càng lớn thì khả năng cắt càng giảm nhưng độ cứng vững càng tăng.', NULL, '× — Sai', 'Chiều quan hệ trong câu bị đảo. Góc xoắn lớn thường giúp cắt tốt và thoát phoi hơn, nhưng làm lưỡi yếu hơn và dễ mẻ. Độ cứng vững không tăng chỉ vì tăng góc xoắn.', '[{"term": "ねじれ角", "reading": "ねじれかく", "meaning": "góc xoắn"}, {"term": "切れ味", "reading": "きれあじ", "meaning": "khả năng cắt"}, {"term": "剛性", "reading": "ごうせい", "meaning": "độ cứng vững"}]'::jsonb, 51);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Gia công, mạch điện và điều khiển', 2, 'マシニングセンタは、工具を自動で交換できる装置を持ち、NCのプログラミング制御に
従って穴開けや平面削りなどを１台でこなせる機械である。', 'Trung tâm gia công có thiết bị tự động thay dụng cụ và có thể thực hiện trên một máy các công việc như khoan lỗ và phay mặt phẳng theo điều khiển lập trình NC.', NULL, '○ — Đúng', 'Trung tâm gia công kết hợp điều khiển số với bộ thay dao tự động để thực hiện nhiều nguyên công. Đặc điểm tự động thay dụng cụ giúp phân biệt với máy chỉ có một dụng cụ làm việc.', '[{"term": "マシニングセンタ", "reading": "マシニングセンタ", "meaning": "trung tâm gia công"}, {"term": "工具", "reading": "こうぐ", "meaning": "dụng cụ"}, {"term": "平面削り", "reading": "へいめんけずり", "meaning": "gia công mặt phẳng"}]'::jsonb, 52);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Gia công, mạch điện và điều khiển', 3, '下図に示す回路に流れる電流Iは、20Aである。

![Hình câu 3](images/2025_cau_03.png)', 'Dòng điện I chạy trong mạch dưới đây là 20A.
Hình: nguồn 6V; ba điện trở 12Ω, 12Ω và 6Ω mắc song song.', NULL, '× — Sai', '1/R = 1/12 + 1/12 + 1/6 = 1/3, nên R = 3Ω. I = 6/3 = 2A, không phải 20A. Có thể cộng dòng nhánh: 0,5 + 0,5 + 1 = 2A.', '[{"term": "電流", "reading": "でんりゅう", "meaning": "dòng điện"}, {"term": "回路", "reading": "かいろ", "meaning": "mạch điện"}, {"term": "抵抗", "reading": "ていこう", "meaning": "điện trở"}]'::jsonb, 53);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Gia công, mạch điện và điều khiển', 4, 'すべりを考慮しない場合、極数が4極、電源周波数が50Ｈｚの三相誘導電動機の回転数
は、1,800min⁻¹である。', 'Nếu bỏ qua độ trượt, động cơ cảm ứng ba pha 4 cực, nguồn 50Ｈｚ có tốc độ quay 1,800min⁻¹.', NULL, '× — Sai', 'nₛ = 120f/p = 120×50/4 = 1.500min⁻¹. Giá trị 1.800min⁻¹ ứng với 60Hz và 4 cực. Khi có độ trượt trong chế độ động cơ, tốc độ rôto thấp hơn tốc độ đồng bộ.', '[{"term": "電源周波数", "reading": "でんげんしゅうはすう", "meaning": "tần số nguồn"}, {"term": "極数", "reading": "きょくすう", "meaning": "số cực"}, {"term": "回転数", "reading": "かいてんすう", "meaning": "tốc độ quay"}]'::jsonb, 54);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Gia công, mạch điện và điều khiển', 5, 'カスケード制御とは、フィードバック制御系において、1つの制御装置の出力信号によって
他の制御系の目標値を決定する制御である。', 'Điều khiển cascade là điều khiển trong hệ phản hồi, trong đó tín hiệu đầu ra của một bộ điều khiển quyết định giá trị đặt của hệ điều khiển khác.', NULL, '○ — Đúng', 'Đầu ra vòng điều khiển ngoài trở thành giá trị đặt của vòng trong. Hai vòng có quan hệ nối tầng; không phải hai bộ điều khiển cùng hoạt động độc lập.', '[{"term": "制御装置", "reading": "せいぎょそうち", "meaning": "bộ điều khiển"}, {"term": "出力信号", "reading": "しゅつりょくしんごう", "meaning": "tín hiệu đầu ra"}, {"term": "目標値", "reading": "もくひょうち", "meaning": "giá trị đặt"}]'::jsonb, 55);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Bảo trì, truyền động và dòng chảy', 6, '予知保全とは、設備や機器の劣化の進行を経験から類推して、定期的に部品交換を行う
保全方式である。', 'Bảo trì dự đoán là phương thức suy đoán tiến triển suy giảm của thiết bị hoặc máy móc từ kinh nghiệm và thay bộ phận định kỳ.', NULL, '× — Sai', 'Bảo trì dự đoán dựa vào theo dõi tình trạng và xu hướng suy giảm để dự báo khi cần can thiệp. Thay định kỳ theo lịch gần với bảo trì theo thời gian. Kinh nghiệm có thể hỗ trợ, nhưng không thay thế việc đánh giá tình trạng trong định nghĩa này.', '[{"term": "予知保全", "reading": "よちほぜん", "meaning": "bảo trì dự đoán"}, {"term": "劣化", "reading": "れっか", "meaning": "suy giảm"}, {"term": "部品交換", "reading": "ぶひんこうかん", "meaning": "thay bộ phận"}]'::jsonb, 56);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Bảo trì, truyền động và dòng chảy', 7, '解析手法の1つであるＦＴＡとは、故障発生の過程を遡って樹形図に展開し、トップダウン
で発生原因を解析する手法である。', 'FTA, một phương pháp phân tích, truy ngược quá trình phát sinh hư hỏng, triển khai thành sơ đồ cây và phân tích nguyên nhân theo cách từ trên xuống.', NULL, '○ — Đúng', 'FTA bắt đầu từ sự kiện hư hỏng đỉnh rồi phân rã nguyên nhân bằng các quan hệ logic. Đây là cách top-down. FMEA đi từ dạng hư hỏng của từng bộ phận đến ảnh hưởng, theo hướng bottom-up.', '[{"term": "樹形図", "reading": "じゅけいず", "meaning": "sơ đồ cây"}, {"term": "発生原因", "reading": "はっせいげんいん", "meaning": "nguyên nhân phát sinh"}, {"term": "遡る", "reading": "さかのぼる", "meaning": "truy ngược"}]'::jsonb, 57);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Bảo trì, truyền động và dòng chảy', 8, '修理できない機械が、稼働してから故障するまでの平均時間をＭＴＴＦという。', 'Thời gian trung bình từ khi máy không thể sửa chữa bắt đầu hoạt động đến khi hư hỏng được gọi là ＭＴＴＦ.', NULL, '○ — Đúng', 'MTTF là thời gian đến hư hỏng trung bình của các đối tượng không sửa chữa. MTBF dùng cho đối tượng sửa chữa được và các khoảng vận hành giữa hư hỏng; không dùng hai chỉ số như đồng nghĩa trong mọi trường hợp.', '[{"term": "修理", "reading": "しゅうり", "meaning": "sửa chữa"}, {"term": "平均時間", "reading": "へいきんじかん", "meaning": "thời gian trung bình"}, {"term": "稼働", "reading": "かどう", "meaning": "hoạt động"}]'::jsonb, 58);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Bảo trì, truyền động và dòng chảy', 9, 'バスタブ曲線における摩耗故障期間とは、設備を使用開始後の比較的早い時期に、設
計・製造上の不具合や、使用環境の不適合などによって故障が発生する期間のことであ
る。', 'Giai đoạn hư hỏng do hao mòn trên đường cong bồn tắm là giai đoạn tương đối sớm sau khi bắt đầu dùng thiết bị, khi hư hỏng phát sinh do khiếm khuyết thiết kế, chế tạo hoặc môi trường sử dụng không phù hợp.', NULL, '× — Sai', 'Nội dung này mô tả giai đoạn hư hỏng ban đầu. Giai đoạn hao mòn nằm cuối vòng đời, tỷ lệ hư hỏng tăng do lão hóa và mài mòn. Giữa hai giai đoạn là thời kỳ hư hỏng ngẫu nhiên.', '[{"term": "摩耗", "reading": "まもう", "meaning": "hao mòn"}, {"term": "不具合", "reading": "ふぐあい", "meaning": "khiếm khuyết"}, {"term": "使用環境", "reading": "しようかんきょう", "meaning": "môi trường sử dụng"}]'::jsonb, 59);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Bảo trì, truyền động và dòng chảy', 10, '機械のメンテナンスのために消費される補助材料や工場消耗品の費用は、直接材料費
に分類される。', 'Chi phí vật liệu phụ và vật tư tiêu hao nhà máy dùng để bảo trì máy được phân loại là chi phí vật liệu trực tiếp.', NULL, '× — Sai', 'Vật liệu phụ và vật tư phục vụ chung cho nhà máy thường thuộc chi phí vật liệu gián tiếp, không trực tiếp gắn với từng sản phẩm. Điểm phân biệt là khả năng quy trực tiếp chi phí cho đối tượng sản xuất.', '[{"term": "補助材料", "reading": "ほじょざいりょう", "meaning": "vật liệu phụ"}, {"term": "工場消耗品", "reading": "こうじょうしょうもうひん", "meaning": "vật tư tiêu hao nhà máy"}, {"term": "直接材料費", "reading": "ちょくせつざいりょうひ", "meaning": "chi phí vật liệu trực tiếp"}]'::jsonb, 60);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Bảo trì, truyền động và dòng chảy', 11, 'Vベルトを用いる際は、ベルトと、プーリの溝底との間にすき間を設ける。', 'Khi dùng đai V, phải để khe hở giữa đai và đáy rãnh puli.', NULL, '○ — Đúng', 'Đai V truyền lực nhờ tiếp xúc hai mặt bên với rãnh và hiệu ứng nêm. Nếu đai chạm đáy rãnh, hiệu ứng nêm và khả năng truyền lực giảm; không hiểu việc đai nằm sâu xuống đáy là dấu hiệu lắp tốt.', '[{"term": "Vベルト", "reading": "ブイベルト", "meaning": "đai V"}, {"term": "プーリ", "reading": "プーリ", "meaning": "puli"}, {"term": "溝底", "reading": "みぞそこ", "meaning": "đáy rãnh"}, {"term": "すき間", "reading": "すきま", "meaning": "khe hở"}]'::jsonb, 61);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Bảo trì, truyền động và dòng chảy', 12, 'サージングとは、液体の圧力が下がり、局部的な高い真空が生じて気泡が発生する現象
である。', 'Surging là hiện tượng áp suất chất lỏng giảm, tạo chân không cao cục bộ và sinh bọt khí.', NULL, '× — Sai', 'Nội dung mô tả cavitation: áp suất cục bộ thấp hơn áp suất hơi làm xuất hiện bọt hơi. Surging là dao động không ổn định của áp suất và lưu lượng trong hệ máy bơm hoặc máy nén. Đừng nhầm xung động hệ thống với tạo bọt hơi cục bộ.', '[{"term": "サージング", "reading": "サージング", "meaning": "dao động áp suất và lưu lượng"}, {"term": "真空", "reading": "しんくう", "meaning": "chân không"}, {"term": "気泡", "reading": "きほう", "meaning": "bọt khí"}]'::jsonb, 62);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Bảo trì, truyền động và dòng chảy', 13, 'ウォータハンマの対策として、配管内を流れる液体の流速を変動させることが挙げられ
る。', 'Một biện pháp chống búa nước là làm biến động tốc độ dòng chất lỏng trong đường ống.', NULL, '× — Sai', 'Búa nước phát sinh khi vận tốc dòng chảy đổi đột ngột. Cần giảm biến đổi nhanh, như đóng van chậm hoặc dùng thiết bị giảm xung áp. Chủ động gây biến động vận tốc không phải nguyên tắc phòng chống.', '[{"term": "ウォータハンマ", "reading": "ウォータハンマ", "meaning": "búa nước"}, {"term": "流速", "reading": "りゅうそく", "meaning": "vận tốc dòng chảy"}, {"term": "変動", "reading": "へんどう", "meaning": "biến động"}]'::jsonb, 63);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Chất lượng và thống kê', 14, '抜取検査では、同一の生産条件で生産された製品の集まりについて、無作為に一部を取
り出して検査する。', 'Trong kiểm tra lấy mẫu, lấy ngẫu nhiên một phần từ tập hợp sản phẩm được sản xuất trong cùng điều kiện để kiểm tra.', NULL, '○ — Đúng', 'Mẫu được lấy từ một lô có điều kiện sản xuất chung. Lấy ngẫu nhiên giúp hạn chế thiên lệch; kết quả mẫu được dùng để đánh giá lô theo tiêu chuẩn lấy mẫu. Không phải kiểm tra mọi sản phẩm.', '[{"term": "抜取検査", "reading": "ぬきとりけんさ", "meaning": "kiểm tra lấy mẫu"}, {"term": "無作為", "reading": "むさくい", "meaning": "ngẫu nhiên"}, {"term": "生産条件", "reading": "せいさんじょうけん", "meaning": "điều kiện sản xuất"}]'::jsonb, 64);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Chất lượng và thống kê', 15, 'ヒストグラムでは、データを層別して、大きい順に棒グラフを作成し、累積比率を折れ線グ
ラフで表示する。', 'Trong histogram, phân nhóm dữ liệu rồi vẽ các cột theo thứ tự lớn đến nhỏ và biểu diễn tỷ lệ tích lũy bằng đường gấp khúc.', NULL, '× — Sai', 'Đây là mô tả biểu đồ Pareto. Histogram chia dữ liệu đo thành các khoảng và biểu diễn tần số theo thứ tự khoảng giá trị. Không sắp các khoảng theo cột cao nhất và không bắt buộc có đường tỷ lệ tích lũy.', '[{"term": "ヒストグラム", "reading": "ヒストグラム", "meaning": "biểu đồ tần số"}, {"term": "層別", "reading": "そうべつ", "meaning": "phân tầng, phân nhóm"}, {"term": "累積比率", "reading": "るいせきひりつ", "meaning": "tỷ lệ tích lũy"}]'::jsonb, 65);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Chất lượng và thống kê', 16, '正規分布は、平均値と分散によって定まる左右対称の分布である。', 'Phân phối chuẩn là phân phối đối xứng trái–phải, được xác định bởi giá trị trung bình và phương sai.', NULL, '○ — Đúng', 'μ xác định tâm; phương sai σ² xác định mức phân tán. Hàm mật độ đối xứng quanh μ. Phương sai và độ lệch chuẩn có quan hệ σ = căn bậc hai của phương sai.', '[{"term": "正規分布", "reading": "せいきぶんぷ", "meaning": "phân phối chuẩn"}, {"term": "分散", "reading": "ぶんさん", "meaning": "phương sai"}, {"term": "左右対称", "reading": "さゆうたいしょう", "meaning": "đối xứng trái–phải"}]'::jsonb, 66);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Chất lượng và thống kê', 17, '下表のデータでX̄-R管理図を作成する場合、Rは10である。

| 項目 | n1 | n2 | n3 | n4 | n5 |
|---|---|---|---|---|---|
| 値 | 10 | 9 | 11 | 8 | 12 |', 'Khi lập biểu đồ kiểm soát X̄-R từ dữ liệu ở bảng dưới, R bằng 10.

| Mục | n1 | n2 | n3 | n4 | n5 |
|---|---|---|---|---|---|
| Giá trị | 10 | 9 | 11 | 8 | 12 |', NULL, '× — Sai', 'R là khoảng biến thiên: giá trị lớn nhất trừ giá trị nhỏ nhất = 12 − 8 = 4. Trung bình X̄ = (10+9+11+8+12)/5 = 10. Phát biểu đã nhầm trung bình với khoảng biến thiên.', '[{"term": "管理図", "reading": "かんりず", "meaning": "biểu đồ kiểm soát"}, {"term": "範囲", "reading": "はんい", "meaning": "khoảng biến thiên"}, {"term": "値", "reading": "あたい", "meaning": "giá trị"}]'::jsonb, 67);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Vật liệu và nhiệt luyện', 18, 'SUS304は、オーステナイト系ステンレス鋼である。', 'SUS304 là thép không gỉ thuộc nhóm austenit.', NULL, '○ — Đúng', 'SUS304 là loại thép không gỉ Cr–Ni austenit tiêu biểu, thường gọi loại 18Cr–8Ni. Không nhầm với thép không gỉ ferrit như SUS430 hoặc martensit như SUS410; trạng thái gia công có thể ảnh hưởng tính từ.', '[{"term": "オーステナイト系", "reading": "オーステナイトけい", "meaning": "nhóm austenit"}, {"term": "ステンレス鋼", "reading": "ステンレスこう", "meaning": "thép không gỉ"}, {"term": "材料", "reading": "ざいりょう", "meaning": "vật liệu"}]'::jsonb, 68);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Vật liệu và nhiệt luyện', 19, 'アルミニウムは、鉄に比べ融点が低い。', 'Nhôm có nhiệt độ nóng chảy thấp hơn sắt.', NULL, '○ — Đúng', 'Nhôm nguyên chất nóng chảy khoảng 660°C, sắt nguyên chất khoảng 1.538°C. So sánh này nói về nhiệt độ nóng chảy, không phải nhiệt độ làm việc cho phép hoặc độ bền.', '[{"term": "アルミニウム", "reading": "アルミニウム", "meaning": "nhôm"}, {"term": "鉄", "reading": "てつ", "meaning": "sắt"}, {"term": "融点", "reading": "ゆうてん", "meaning": "nhiệt độ nóng chảy"}]'::jsonb, 69);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Vật liệu và nhiệt luyện', 20, '鋼の焼入れは、鋼を硬化させ、強度を高めるために行う。', 'Tôi thép được thực hiện nhằm làm thép cứng hơn và tăng độ bền.', NULL, '○ — Đúng', 'Tôi gồm nung đến vùng thích hợp rồi làm nguội nhanh để tạo tổ chức cứng, thường là martensit. Sau tôi thường cần ram để giảm giòn và ứng suất; tôi không đồng nghĩa với ủ mềm.', '[{"term": "焼入れ", "reading": "やきいれ", "meaning": "tôi"}, {"term": "硬化", "reading": "こうか", "meaning": "làm cứng"}, {"term": "強度", "reading": "きょうど", "meaning": "độ bền"}]'::jsonb, 70);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Thiết kế an toàn và an toàn lao động', 21, 'フールプルーフ設計は、設備が故障しても、安全側に作動するように配慮した設計のこと
である。', 'Thiết kế foolproof là thiết kế có cân nhắc để thiết bị tác động về phía an toàn ngay cả khi hư hỏng.', NULL, '× — Sai', 'Đây là định nghĩa fail-safe. Foolproof phòng nguy hiểm do người dùng thao tác sai; fail-safe phòng hậu quả nguy hiểm khi thiết bị hư hỏng. Phải phân biệt nguyên nhân là lỗi thao tác hay hỏng thiết bị.', '[{"term": "フールプルーフ", "reading": "フールプルーフ", "meaning": "phòng sai thao tác"}, {"term": "安全側", "reading": "あんぜんがわ", "meaning": "phía an toàn"}, {"term": "作動", "reading": "さどう", "meaning": "tác động"}]'::jsonb, 71);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Thiết kế an toàn và an toàn lao động', 22, 'リスクアセスメントでは、危険性または有害性ごとに、頻度や重大性からリスクを定量的に
見積もる。', 'Trong đánh giá rủi ro, rủi ro được ước lượng định lượng từ tần suất và mức độ nghiêm trọng cho từng nguy cơ hoặc yếu tố có hại.', NULL, '○ — Đúng', 'Đánh giá kết hợp khả năng xảy ra và mức độ hậu quả để xếp mức rủi ro và ưu tiên giảm rủi ro. Có thể dùng thang điểm hoặc ma trận. Không đánh giá chỉ bằng mức nghiêm trọng mà bỏ qua khả năng xảy ra.', '[{"term": "リスクアセスメント", "reading": "リスクアセスメント", "meaning": "đánh giá rủi ro"}, {"term": "有害性", "reading": "ゆうがいせい", "meaning": "tính có hại"}, {"term": "頻度", "reading": "ひんど", "meaning": "tần suất"}, {"term": "重大性", "reading": "じゅうだいせい", "meaning": "mức độ nghiêm trọng"}]'::jsonb, 72);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Thiết kế an toàn và an toàn lao động', 23, '墜落制止用器具を使用する際は、一本つりではなく、U字つりのものを使用しなければな
らない。', 'Khi dùng thiết bị chống rơi, phải dùng loại treo chữ U, không được dùng loại treo một dây.', NULL, '× — Sai', 'Thiết bị giữ người khi rơi thuộc phương thức treo một dây. Treo chữ U phục vụ giữ tư thế làm việc, không thay thế riêng thiết bị hãm rơi; khi dùng phải phối hợp thiết bị bảo vệ phù hợp. Yêu cầu trong câu đã đảo hai chức năng.', '[{"term": "墜落制止用器具", "reading": "ついらくせいしようきぐ", "meaning": "thiết bị chống rơi"}, {"term": "一本つり", "reading": "いっぽんつり", "meaning": "treo một dây"}, {"term": "U字つり", "reading": "ユージつり", "meaning": "treo chữ U"}]'::jsonb, 73);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Thiết kế an toàn và an toàn lao động', 24, 'B火災とは、石油やガソリンなどが燃える火災である。', 'Cháy loại B là cháy dầu mỏ, xăng và các chất tương tự.', NULL, '○ — Đúng', 'Trong phân loại dùng ở đề, B là cháy dầu và chất lỏng dễ cháy. A là cháy vật liệu thông thường như gỗ, giấy; C là cháy liên quan thiết bị điện. Xăng thuộc B.', '[{"term": "石油", "reading": "せきゆ", "meaning": "dầu mỏ"}, {"term": "ガソリン", "reading": "ガソリン", "meaning": "xăng"}, {"term": "火災", "reading": "かさい", "meaning": "hỏa hoạn"}]'::jsonb, 74);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Thiết kế an toàn và an toàn lao động', 25, 'クレーン等安全規則によると、玉掛け作業において、ワイヤロープの直径の減少が公称径
の7%を超えるものは使用不可である。', 'Theo Quy tắc an toàn cần trục và thiết bị liên quan, trong công việc móc buộc tải, không được dùng cáp thép có mức giảm đường kính vượt quá 7% đường kính danh nghĩa.', NULL, '○ — Đúng', 'Điều 215 cấm dùng cáp móc tải khi đường kính giảm quá 7% so với danh nghĩa. Nếu d₀ là đường kính danh nghĩa và d là đường kính đo được, mức giảm = (d₀ − d)/d₀ × 100%. Chú ý từ “vượt quá”, không đổi thành “từ 7% trở lên”.', '[{"term": "玉掛け", "reading": "たまかけ", "meaning": "móc buộc tải"}, {"term": "ワイヤロープ", "reading": "ワイヤロープ", "meaning": "cáp thép"}, {"term": "公称径", "reading": "こうしょうけい", "meaning": "đường kính danh nghĩa"}]'::jsonb, 75);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Động cơ và điều khiển tự động', 26, '直流電動機の速度制御と制動に関する記述のうち、適切なものはどれか。
ア 界磁制御法において、界磁抵抗器の抵抗を小さくすると、回転速度は速くなる。
イ 抵抗制御法には、ワード・レオナード方式やイルグナ方式などがある。
ウ 回生制動は、圧縮空気などで制動機を動作させる機械的な制動方式である。
エ 発電制動とは、運転中の電動機を他励発電機として使用する制動方式である。', 'Trong các phát biểu về điều khiển tốc độ và hãm động cơ một chiều, phát biểu nào phù hợp?
ア Trong điều khiển từ trường, giảm điện trở biến trở kích từ sẽ làm tốc độ quay tăng.
イ Điều khiển điện trở có các phương thức Ward–Leonard và Ilgner.
ウ Hãm tái sinh là cách hãm cơ khí, dùng khí nén và các phương tiện tương tự để tác động bộ hãm.
エ Hãm phát điện là phương thức dùng động cơ đang chạy như máy phát kích từ độc lập.', NULL, 'エ', 'Hãm phát điện biến động năng thành điện năng, thường tiêu tán trên điện trở. Ở điều khiển từ trường, giảm điện trở tăng dòng kích từ và từ thông, làm tốc độ giảm theo n ≈ (U − I_aR_a)/(kΦ). Ward–Leonard/Ilgner thuộc điều khiển điện áp; tái sinh trả điện năng về nguồn, không phải hãm cơ khí.', '[{"term": "界磁制御", "reading": "かいじせいぎょ", "meaning": "điều khiển từ trường"}, {"term": "発電制動", "reading": "はつでんせいどう", "meaning": "hãm phát điện"}, {"term": "他励発電機", "reading": "たれいはつでんき", "meaning": "máy phát kích từ độc lập"}]'::jsonb, 76);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Động cơ và điều khiển tự động', 27, '電動機に関する記述のうち、適切でないものはどれか。
ア 三相誘導電動機は、すべりが小さくなるほど回転速度が速くなる。
イ 同期電動機は、交流電動機に分類される。
ウ サーボモータに用いられる制御方式は、オープンループ方式である。
エ 同期電動機は、始動トルクがゼロである。', 'Trong các phát biểu về động cơ điện, phát biểu nào không phù hợp?
ア Với động cơ cảm ứng ba pha, độ trượt càng nhỏ thì tốc độ quay càng nhanh.
イ Động cơ đồng bộ thuộc động cơ xoay chiều.
ウ Phương thức điều khiển dùng cho động cơ servo là vòng hở.
エ Động cơ đồng bộ có mômen khởi động bằng không.', NULL, 'ウ', 'Servo dùng phản hồi vị trí hoặc tốc độ để giảm sai lệch, tức điều khiển vòng kín. Vòng hở không kiểm tra kết quả bằng phản hồi. Các quan hệ động cơ khác: n = nₛ(1 − s); động cơ đồng bộ là máy AC và cần phương tiện khởi động trong cấu hình thông thường.', '[{"term": "サーボモータ", "reading": "サーボモータ", "meaning": "động cơ servo"}, {"term": "オープンループ", "reading": "オープンループ", "meaning": "vòng hở"}, {"term": "交流電動機", "reading": "こうりゅうでんどうき", "meaning": "động cơ xoay chiều"}]'::jsonb, 77);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Động cơ và điều khiển tự động', 28, '電磁開閉器に関する記述のうち、適切なものはどれか。
ア 電磁接触器からショックリレーを外したものである。
イ 電磁接触器に熱動形過負荷リレーを加えたものである。
ウ 電磁接触器にヒューズを加えたものである。
エ 電磁接触器から遮断器を外したものである。', 'Phát biểu nào phù hợp về bộ khởi động điện từ?
ア Là công tắc tơ điện từ đã tháo shock relay.
イ Là công tắc tơ điện từ bổ sung rơle quá tải kiểu nhiệt.
ウ Là công tắc tơ điện từ bổ sung cầu chì.
エ Là công tắc tơ điện từ đã tháo aptomat.', NULL, 'イ', 'Bộ khởi động điện từ kết hợp công tắc tơ đóng cắt với rơle nhiệt bảo vệ quá tải. Rơle nhiệt không thay thế đầy đủ bảo vệ ngắn mạch của cầu chì hoặc aptomat. Đừng đồng nhất công tắc tơ riêng với toàn bộ bộ khởi động.', '[{"term": "電磁開閉器", "reading": "でんじかいへいき", "meaning": "bộ khởi động điện từ"}, {"term": "熱動形過負荷リレー", "reading": "ねつどうがたかふかリレー", "meaning": "rơle quá tải kiểu nhiệt"}, {"term": "遮断器", "reading": "しゃだんき", "meaning": "aptomat"}]'::jsonb, 78);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Động cơ và điều khiển tự động', 29, 'フィードフォワード制御に関する記述のうち、適切なものはどれか。
ア 前回の制御量を目標値と比較し、それらを一致させるように操作量を生成する制御
方式
イ あらかじめ定められた変化をする目標値に追従させる制御方式
ウ 比例動作、積分動作、および微分動作の３つの動作を含む制御方式
エ 目標値、外乱などの情報に基づいて、操作量を決定する制御方式', 'Phát biểu nào phù hợp về điều khiển feedforward?
ア So sánh đại lượng điều khiển lần trước với giá trị đặt và sinh đại lượng tác động để chúng trùng nhau.
イ Làm đại lượng điều khiển bám giá trị đặt biến đổi theo quy luật định trước.
ウ Gồm ba tác động tỷ lệ, tích phân và vi phân.
エ Quyết định đại lượng tác động dựa trên thông tin như giá trị đặt và nhiễu tác động.', NULL, 'エ', 'Feedforward tính tác động từ thông tin đầu vào hoặc nhiễu đã biết, trước khi sai lệch đầu ra xuất hiện. ア thuộc phản hồi; イ là điều khiển chương trình; ウ là PID. Feedforward có thể kết hợp feedback để bù sai số mô hình.', '[{"term": "外乱", "reading": "がいらん", "meaning": "nhiễu tác động"}, {"term": "操作量", "reading": "そうさりょう", "meaning": "đại lượng tác động"}, {"term": "制御量", "reading": "せいぎょりょう", "meaning": "đại lượng điều khiển"}]'::jsonb, 79);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Động cơ và điều khiển tự động', 30, 'ロータリエンコーダの出力方式に関する記述のうち、適切でないものはどれか。
ア インクリメンタル方式は、電源遮断時の位置を記憶できる。
イ アブソリュート方式は、電源遮断時の位置を記憶できる。
ウ インクリメンタル方式は、回転方向を検出できる。
エ アブソリュート方式は、回転方向を検出できる。', 'Trong các phát biểu về phương thức ngõ ra của encoder quay, phát biểu nào không phù hợp?
ア Kiểu incremental có thể nhớ vị trí khi nguồn bị ngắt.
イ Kiểu absolute có thể nhớ vị trí khi nguồn bị ngắt.
ウ Kiểu incremental có thể phát hiện chiều quay.
エ Kiểu absolute có thể phát hiện chiều quay.', NULL, 'ア', 'Encoder incremental chỉ cung cấp xung dịch chuyển; hệ thống thông thường mất thông tin vị trí khi tắt nguồn và phải lấy lại gốc. Encoder absolute mã hóa vị trí tuyệt đối. Hai pha lệch nhau cho phép xác định chiều quay; một bộ đếm có pin bên ngoài không biến bản thân encoder incremental thành absolute.', '[{"term": "ロータリエンコーダ", "reading": "ロータリエンコーダ", "meaning": "encoder quay"}, {"term": "電源遮断", "reading": "でんげんしゃだん", "meaning": "ngắt nguồn"}, {"term": "回転方向", "reading": "かいてんほうこう", "meaning": "chiều quay"}]'::jsonb, 80);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Điện, điện tử và đo lường', 31, '電気および磁気に関する記述のうち、適切でないものはどれか。
ア コンデンサに交流電圧を印加した場合、電流は静電容量に正比例する。
イ ガラスとビニールをこすり合わせると両者は互いに引き合う。
ウ 比透磁率とは、磁性体の温度変化による透磁率の変化の割合のことである。
エ 2枚の電極間に電荷を蓄えると、静電気力が発生する。', 'Trong các phát biểu về điện và từ, phát biểu nào không phù hợp?
ア Khi đặt điện áp xoay chiều lên tụ, dòng điện tỷ lệ thuận với điện dung.
イ Khi cọ xát thủy tinh và vinyl với nhau, hai vật hút nhau.
ウ Độ từ thẩm tương đối là tỷ lệ thay đổi độ từ thẩm do nhiệt độ vật liệu từ thay đổi.
エ Khi tích điện giữa hai điện cực, lực tĩnh điện xuất hiện.', NULL, 'ウ', 'μᵣ = μ/μ₀ là tỷ số độ từ thẩm vật liệu với chân không, không phải tỷ lệ thay đổi theo nhiệt độ. Dòng qua tụ I = 2πfCU khi f và U cố định. Cọ xát chuyển electron tạo điện tích trái dấu nên hai vật hút nhau.', '[{"term": "比透磁率", "reading": "ひとうじりつ", "meaning": "độ từ thẩm tương đối"}, {"term": "静電気力", "reading": "せいでんきりょく", "meaning": "lực tĩnh điện"}, {"term": "電極", "reading": "でんきょく", "meaning": "điện cực"}]'::jsonb, 81);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Điện, điện tử và đo lường', 32, '電子に関する記述のうち、適切なものはどれか。
ア 自由電子の数が多い物質を絶縁体という。
イ 原子核は、電子全体と同じ量の負の電気量をもつ。
ウ 電子1個は、約3×10⁸Cの正の電気量をもつ。
エ 摩擦電気は、電子の移動により起きる現象である。', 'Trong các phát biểu về electron, phát biểu nào phù hợp?
ア Chất có nhiều electron tự do được gọi là chất cách điện.
イ Hạt nhân có lượng điện âm bằng lượng điện của toàn bộ electron.
ウ Một electron có điện lượng dương khoảng 3×10⁸C.
エ Điện do ma sát là hiện tượng xảy ra bởi sự dịch chuyển electron.', NULL, 'エ', 'Ma sát có thể chuyển electron giữa hai vật. Hạt nhân mang điện dương; electron mang điện âm khoảng −1,602×10⁻¹⁹ C. Nhiều electron tự do là đặc trưng hỗ trợ dẫn điện, không phải cách điện.', '[{"term": "摩擦電気", "reading": "まさつでんき", "meaning": "điện do ma sát"}, {"term": "原子核", "reading": "げんしかく", "meaning": "hạt nhân nguyên tử"}, {"term": "電子", "reading": "でんし", "meaning": "electron"}]'::jsonb, 82);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Điện, điện tử và đo lường', 33, '直流の電気回路に関する記述のうち、適切でないものはどれか。
ア 1Wの電力を1時間使用すると、発生する熱量は、1Jである。
イ 1Ωの抵抗に1Aの電流を流すために必要な電圧は、1Vである。
ウ 1秒間に1Cの電荷が移動するときに流れる電流は、1Aである。
エ 1Vの電圧で1Aの電流が流れたときの電力は、1Wである。', 'Trong các phát biểu về mạch điện một chiều, phát biểu nào không phù hợp?
ア Khi dùng công suất 1W trong 1 giờ, nhiệt lượng phát sinh là 1J.
イ Điện áp cần để cho dòng 1A chạy qua điện trở 1Ω là 1V.
ウ Khi điện tích 1C dịch chuyển trong 1 giây, dòng điện là 1A.
エ Công suất là 1W khi dòng 1A chạy với điện áp 1V.', NULL, 'ア', 'Năng lượng E = Pt. 1 giờ = 3.600 giây, nên 1W×1h = 3.600J. Các lựa chọn còn lại đúng theo U = RI, I = Q/t và P = UI. Đừng nhầm công suất W với năng lượng J.', '[{"term": "電力", "reading": "でんりょく", "meaning": "công suất điện"}, {"term": "熱量", "reading": "ねつりょう", "meaning": "nhiệt lượng"}, {"term": "直流", "reading": "ちょくりゅう", "meaning": "một chiều"}]'::jsonb, 83);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Điện, điện tử và đo lường', 34, '下図の回路図において、電流Iの数値として、適切なものはどれか。
ア 0.3A
イ 0.5A
ウ 0.7A
エ 0.9A

![Hình câu 34](images/2025_cau_34.png)', 'Trong sơ đồ dưới đây, giá trị nào phù hợp cho dòng điện I?
ア 0.3A
イ 0.5A
ウ 0.7A
エ 0.9A
Hình: nguồn 6V; hai điện trở 50Ω song song rồi nối tiếp 5Ω; nhánh đó song song với 20Ω.', NULL, 'イ', '50Ω song song 50Ω cho 25Ω; thêm 5Ω thành 30Ω. 30Ω song song 20Ω cho R = 30×20/(30+20) = 12Ω. I = 6/12 = 0,5A. Phải xác định các nút nối trước khi cộng điện trở.', '[{"term": "回路図", "reading": "かいろず", "meaning": "sơ đồ mạch"}, {"term": "電流", "reading": "でんりゅう", "meaning": "dòng điện"}, {"term": "合成抵抗", "reading": "ごうせいていこう", "meaning": "điện trở tương đương"}]'::jsonb, 84);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Điện, điện tử và đo lường', 35, '基本増幅回路の回路図①、②の種類の組合わせとして、適切なものを選びなさい。
ア ①エミッタ接地増幅回路 ②コレクタ接地増幅回路
イ ①エミッタ接地増幅回路 ②ベース接地増幅回路
ウ ①ベース接地増幅回路 ②コレクタ接地増幅回路
エ ①ベース接地増幅回路 ②エミッタ接地増幅回路

![Hình câu 35](images/2025_cau_35.png)', 'Chọn tổ hợp loại mạch phù hợp cho hai sơ đồ khuếch đại cơ bản ① và ②.
ア ① Khuếch đại emitter chung; ② khuếch đại collector chung
イ ① Khuếch đại emitter chung; ② khuếch đại base chung
ウ ① Khuếch đại base chung; ② khuếch đại collector chung
エ ① Khuếch đại base chung; ② khuếch đại emitter chung
Nhãn hình: Vi = điện áp tín hiệu vào; V_BB = nguồn phân cực base; V_CC = nguồn cấp collector; R = điện trở.', NULL, 'イ', 'Xác định điện cực chung giữa ngõ vào và ngõ ra. ① có emitter chung ở đường dưới; ② có base chung. Không nhận dạng chỉ theo hướng vẽ transistor: cần theo đường nối của các đầu vào và đầu ra.', '[{"term": "増幅回路", "reading": "ぞうふくかいろ", "meaning": "mạch khuếch đại"}, {"term": "エミッタ接地", "reading": "エミッタせっち", "meaning": "emitter chung"}, {"term": "ベース接地", "reading": "ベースせっち", "meaning": "base chung"}]'::jsonb, 85);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Điện, điện tử và đo lường', 36, '下図に示す排他的論理和回路の真理値として、適切なものはどれか。
ア A=0 B=0 X=1
イ A=0 B=1 X=0
ウ A=1 B=0 X=0
エ A=1 B=1 X=0

![Hình câu 36](images/2025_cau_36.png)', 'Giá trị chân lý nào phù hợp với mạch XOR trong hình?
ア A=0 B=0 X=1
イ A=0 B=1 X=0
ウ A=1 B=0 X=0
エ A=1 B=1 X=0
A, B là ngõ vào; X là ngõ ra của mạch.', NULL, 'エ', 'XOR cho X=1 khi hai ngõ vào khác nhau và X=0 khi giống nhau. Vì A=B=1 nên X=0, chọn エ. Không nhầm XOR với OR, vốn cho 1 khi có ít nhất một ngõ vào bằng 1.', '[{"term": "排他的論理和", "reading": "はいたてきろんりわ", "meaning": "phép XOR"}, {"term": "真理値", "reading": "しんりち", "meaning": "giá trị chân lý"}, {"term": "回路", "reading": "かいろ", "meaning": "mạch"}]'::jsonb, 86);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Điện, điện tử và đo lường', 37, '下図に示す交流回路は負荷の電圧・電流・電力を測定する回路である。図中に示す計器
a～cの組合せとして、適切なものはどれか。
ア a：電圧計 b：電流計 c：電力計
イ a：電圧計 b：電力計 c：電流計
ウ a：電流計 b：電圧計 c：電力計
エ a：電力計 b：電流計 c：電圧計

![Hình câu 37](images/2025_cau_37.png)', 'Mạch xoay chiều dưới đây đo điện áp, dòng điện và công suất của tải. Tổ hợp dụng cụ a–c nào phù hợp?
ア a: vôn kế; b: ampe kế; c: oát kế
イ a: vôn kế; b: oát kế; c: ampe kế
ウ a: ampe kế; b: vôn kế; c: oát kế
エ a: oát kế; b: ampe kế; c: vôn kế
Nhãn hình: 電源 = nguồn điện; 負荷 = tải.', NULL, 'ア', 'a mắc song song nên là vôn kế; b nối tiếp nên là ampe kế. c có đường dòng nối tiếp và nhánh điện áp song song nên là oát kế. Đừng nhận dạng dụng cụ chỉ theo vị trí trái/phải; phải theo cách nối dây.', '[{"term": "電圧計", "reading": "でんあつけい", "meaning": "vôn kế"}, {"term": "電流計", "reading": "でんりゅうけい", "meaning": "ampe kế"}, {"term": "電力計", "reading": "でんりょくけい", "meaning": "oát kế"}, {"term": "負荷", "reading": "ふか", "meaning": "tải"}]'::jsonb, 87);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Ứng dụng động cơ và bảo trì điện', 38, '交流電動機の用途と種類の組合せとして、もっとも適切なものはどれか。
ア A：整流子電動機 B：同期電動機 C：かご形三相誘導電動機
D：巻線形三相誘導電動機
イ A：巻線形三相誘導電動機 B：整流子電動機 C：同期電動機
D：かご形三相誘導電動機
ウ A：整流子電動機 B：かご形三相誘導電動機 C：巻線形三相誘導電動機
D：同期電動機
エ A：かご形三相誘導電動機 B：巻線形三相誘導電動機 C：整流子電動機
D：同期電動機

![Hình câu 38](images/2025_cau_38.png)', 'Tổ hợp ứng dụng và loại động cơ xoay chiều nào phù hợp nhất?

| Ứng dụng động cơ xoay chiều | Loại động cơ xoay chiều |
|---|---|
| Tải có tốc độ gần cố định (bơm, quạt thổi, máy công cụ, v.v.) | A |
| Tải cần mômen khởi động lớn và điều khiển tốc độ (cần trục, v.v.) | B |
| Tải công suất nhỏ cần điều khiển tốc độ trong phạm vi rộng (máy hút bụi, khoan điện, v.v.) | C |
| Tải công suất lớn có tốc độ không đổi (máy nén, máy thổi, máy ép nén, v.v.) | D |

ア A: động cơ cổ góp; B: đồng bộ; C: cảm ứng ba pha lồng sóc; D: cảm ứng ba pha rôto dây quấn
イ A: cảm ứng ba pha rôto dây quấn; B: cổ góp; C: đồng bộ; D: cảm ứng ba pha lồng sóc
ウ A: cổ góp; B: cảm ứng ba pha lồng sóc; C: cảm ứng ba pha rôto dây quấn; D: đồng bộ
エ A: cảm ứng ba pha lồng sóc; B: cảm ứng ba pha rôto dây quấn; C: cổ góp; D: đồng bộ', NULL, 'エ', 'Lồng sóc có kết cấu đơn giản và dùng rộng rãi cho tải gần tốc độ cố định. Rôto dây quấn cho phép dùng điện trở ngoài hỗ trợ mômen khởi động và điều chỉnh tốc độ. Động cơ cổ góp thích hợp phạm vi tốc độ rộng; động cơ đồng bộ giữ tốc độ theo tần số nguồn. Đây là ghép ứng dụng điển hình của đề.', '[{"term": "かご形", "reading": "かごがた", "meaning": "kiểu lồng sóc"}, {"term": "巻線形", "reading": "まきせんがた", "meaning": "kiểu dây quấn"}, {"term": "整流子電動機", "reading": "せいりゅうしでんどうき", "meaning": "động cơ cổ góp"}]'::jsonb, 88);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Ứng dụng động cơ và bảo trì điện', 39, '2,400min⁻¹で回転するモータとモータの架台が同じ周波数で振動した場合、架台の振
動周波数として、適切な数値はどれか。
ア 24Hz
イ 40Hz
ウ 60Hz
エ 120Hz', 'Khi động cơ quay ở 2,400min⁻¹ và bệ động cơ rung cùng tần số với động cơ, tần số rung của bệ có giá trị nào phù hợp?
ア 24Hz
イ 40Hz
ウ 60Hz
エ 120Hz', NULL, 'イ', 'Đổi vòng/phút sang vòng/giây: 2.400/60 = 40Hz. Điều kiện đề cho cùng tần số, nên không nhân thêm số cực hay số cánh. Phân biệt tần số quay với tần số điện của nguồn.', '[{"term": "架台", "reading": "かだい", "meaning": "bệ máy"}, {"term": "振動周波数", "reading": "しんどうしゅうはすう", "meaning": "tần số rung"}, {"term": "回転", "reading": "かいてん", "meaning": "quay"}]'::jsonb, 89);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Ứng dụng động cơ và bảo trì điện', 40, '高調波の影響によって生じる現象と、その現象が発生する機器の組合せとして、適切で
ないものはどれか。
ア 機器：漏電遮断器 現象：誤動作
イ 機器：電磁接触器 現象：誤動作
ウ 機器：コンデンサ 現象：焼損
エ 機器：リアクトル 現象：焼損', 'Tổ hợp thiết bị và hiện tượng nào không phù hợp với ảnh hưởng của sóng hài?
ア Thiết bị: aptomat chống rò; hiện tượng: tác động sai
イ Thiết bị: công tắc tơ điện từ; hiện tượng: tác động sai
ウ Thiết bị: tụ điện; hiện tượng: cháy hỏng
エ Thiết bị: cuộn kháng; hiện tượng: cháy hỏng', NULL, 'イ', 'Sóng hài có thể làm dòng qua tụ hoặc cuộn kháng tăng, gây quá nhiệt; thành phần dòng tần số cao có thể ảnh hưởng aptomat chống rò. Tổ hợp イ, công tắc tơ và tác động sai là lựa chọn không phù hợp theo đề. Không suy rộng thành khẳng định thiết bị hoàn toàn miễn nhiễm với mọi chất lượng nguồn xấu.', '[{"term": "高調波", "reading": "こうちょうは", "meaning": "sóng hài"}, {"term": "リアクトル", "reading": "リアクトル", "meaning": "cuộn kháng"}, {"term": "誤動作", "reading": "ごどうさ", "meaning": "tác động sai"}]'::jsonb, 90);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Ứng dụng động cơ và bảo trì điện', 41, 'ノイズの除去に関する記述のうち、適切でないものはどれか。
ア 静電誘導ノイズ対策をする場合、シールド線を両端で確実に接地する。
イ 信号線を撚り合わせて電磁誘導ノイズを打ち消す。
ウ ケーブルに銅テープを巻き、接地する。
エ 動力線の接地場所と信号線の接地場所は、別に設ける。', 'Trong các phát biểu về loại bỏ nhiễu, phát biểu nào không phù hợp?
ア Khi chống nhiễu cảm ứng tĩnh điện, nối đất chắc chắn dây shield ở cả hai đầu.
イ Xoắn các dây tín hiệu với nhau để triệt nhiễu cảm ứng điện từ.
ウ Quấn băng đồng quanh cáp rồi nối đất.
エ Tách vị trí nối đất dây động lực và dây tín hiệu.', NULL, 'ア', 'Trong tình huống cơ bản của đề, shield chống cảm ứng tĩnh điện được nối đất một đầu để tránh vòng đất do chênh thế hai đầu. Vì thế ア không phù hợp. Xoắn đôi giảm diện tích vòng thu nhiễu. Cách nối shield thực tế còn tùy tần số và hướng dẫn thiết bị; không biến đáp án thành quy tắc một đầu cho mọi hệ EMC.', '[{"term": "静電誘導", "reading": "せいでんゆうどう", "meaning": "cảm ứng tĩnh điện"}, {"term": "電磁誘導", "reading": "でんじゆうどう", "meaning": "cảm ứng điện từ"}, {"term": "シールド線", "reading": "シールドせん", "meaning": "dây có lớp chắn nhiễu"}]'::jsonb, 91);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Ứng dụng động cơ và bảo trì điện', 42, '正常運転していた三相誘導電動機が異常発熱した。この場合の対応処置として、適切で
ないものはどれか。
ア 電磁開閉器の導通を確認する。
イ 接地状態を点検する。
ウ 欠相していないかを点検する。
エ 電源電圧を点検する。', 'Một động cơ cảm ứng ba pha trước đó vận hành bình thường bị phát nhiệt bất thường. Biện pháp xử lý nào không phù hợp trong trường hợp này?
ア Kiểm tra tính thông mạch của bộ khởi động điện từ.
イ Kiểm tra tình trạng nối đất.
ウ Kiểm tra có mất pha hay không.
エ Kiểm tra điện áp nguồn.', NULL, 'イ', 'Mất pha, tiếp điểm kém hoặc điện áp bất thường có thể gây dòng tăng và nóng động cơ. Kiểm tra nối đất là việc an toàn quan trọng, nhưng không trực tiếp chẩn đoán các nguyên nhân phát nhiệt trong danh sách này, nên イ là lựa chọn cần loại theo câu hỏi.', '[{"term": "異常発熱", "reading": "いじょうはつねつ", "meaning": "phát nhiệt bất thường"}, {"term": "欠相", "reading": "けっそう", "meaning": "mất pha"}, {"term": "接地", "reading": "せっち", "meaning": "nối đất"}]'::jsonb, 92);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Ứng dụng động cơ và bảo trì điện', 43, 'クランプメータで負荷電流を測定する場合の測定方法として、適切なものはどれか。
ア 三相線路の場合、3相分の電線を、クランプの中心に閉じて測定する。
イ 単相線路の場合、2相分の電線を、クランプの中心に閉じて測定する。
ウ 三相線路、単相線路のどちらの場合でも、2相分の電線を、クランプの中心に閉じて
測定する。
エ 三相線路、単相線路のどちらの場合でも、1相分の電線を、クランプの中心に閉じて
測定する。', 'Khi đo dòng tải bằng ampe kìm, phương pháp nào phù hợp?
ア Với đường ba pha, kẹp cả ba dây pha tại tâm kìm và đóng kìm để đo.
イ Với đường một pha, kẹp hai dây tại tâm kìm và đóng kìm để đo.
ウ Với cả đường ba pha và một pha, kẹp hai dây tại tâm kìm và đóng kìm để đo.
エ Với cả đường ba pha và một pha, kẹp một dây tại tâm kìm và đóng kìm để đo.', NULL, 'エ', 'Đo dòng tải phải kẹp một dây dẫn để đo từ trường do dòng của dây đó. Nếu kẹp cả dây đi và dây về, từ trường có thể triệt tiêu; kẹp toàn bộ dây hoạt động thường phục vụ đo dòng dư/rò bằng dụng cụ phù hợp, không phải dòng tải từng dây.', '[{"term": "クランプメータ", "reading": "クランプメータ", "meaning": "ampe kìm"}, {"term": "負荷電流", "reading": "ふかでんりゅう", "meaning": "dòng tải"}, {"term": "単相", "reading": "たんそう", "meaning": "một pha"}, {"term": "三相", "reading": "さんそう", "meaning": "ba pha"}]'::jsonb, 93);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Ứng dụng động cơ và bảo trì điện', 44, '下図に示す固定抵抗器において、抵抗値の許容差を示す箇所として、適切なものはどれ
か。
ア A
イ B
ウ C
エ D

![Hình câu 44](images/2025_cau_44.png)', 'Ở điện trở cố định trong hình, vị trí nào biểu thị dung sai của giá trị điện trở?
ア A
イ B
ウ C
エ D
Hình đánh dấu các vòng màu bằng A, B, C, D.', NULL, 'エ', 'Ở điện trở bốn vòng màu, hai vòng đầu là chữ số, vòng thứ ba là hệ số nhân, vòng cuối là dung sai. D là vòng cuối, được tách xa hơn. Không nhầm dung sai với hệ số nhân C.', '[{"term": "固定抵抗器", "reading": "こていていこうき", "meaning": "điện trở cố định"}, {"term": "許容差", "reading": "きょようさ", "meaning": "dung sai"}, {"term": "抵抗値", "reading": "ていこうち", "meaning": "giá trị điện trở"}]'::jsonb, 94);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Ứng dụng động cơ và bảo trì điện', 45, '半導体材料として、適切なものはどれか。
ア 黒鉛
イ シリコン
ウ ケイ素鋼
エ 塩化ビニル樹脂', 'Vật liệu nào phù hợp làm vật liệu bán dẫn?
ア Than chì
イ Silic
ウ Thép silic
エ Nhựa polyvinyl chloride', NULL, 'イ', 'Silic là vật liệu bán dẫn tiêu biểu; pha tạp có thể tạo loại n và p. Thép silic là vật liệu lõi từ, không phải silic tinh thể bán dẫn. PVC chủ yếu là chất cách điện; than chì dẫn điện.', '[{"term": "半導体材料", "reading": "はんどうたいざいりょう", "meaning": "vật liệu bán dẫn"}, {"term": "シリコン", "reading": "シリコン", "meaning": "silic"}, {"term": "塩化ビニル樹脂", "reading": "えんかビニルじゅし", "meaning": "nhựa PVC"}]'::jsonb, 95);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Cơ cấu, thủy lực và ký hiệu', 46, 'ねじに関する文中の［a］内に当てはまる語句として、適切なものはどれか。
「ねじの［a］とは、ねじを1回転したときに、ねじが軸方向に移動する距離のことである。」
ア ピッチ
イ 有効径
ウ 呼び径
エ リード', 'Từ nào phù hợp điền vào ［a］ trong câu về ren?
“［a］ của ren là khoảng cách ren dịch chuyển theo phương trục khi ren quay một vòng.”
ア Bước ren
イ Đường kính trung bình của ren
ウ Đường kính danh nghĩa
エ Bước tiến', NULL, 'エ', 'Lead là khoảng tiến theo trục sau một vòng. Với ren một đầu mối, lead bằng pitch; với ren z đầu mối, lead = z × pitch. Việc hai giá trị bằng nhau ở ren một đầu mối không làm hai định nghĩa giống nhau.', '[{"term": "リード", "reading": "リード", "meaning": "bước tiến"}, {"term": "ピッチ", "reading": "ピッチ", "meaning": "bước ren"}, {"term": "有効径", "reading": "ゆうこうけい", "meaning": "đường kính trung bình của ren"}, {"term": "軸方向", "reading": "じくほうこう", "meaning": "phương trục"}]'::jsonb, 96);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Cơ cấu, thủy lực và ký hiệu', 47, '搬送位置決め機構において使用される直動案内の構成部品として、適切でないものはど
れか。
ア レール
イ ブロック（キャリッジ）
ウ ボール
エ チェーン', 'Bộ phận nào không phù hợp với cấu tạo dẫn hướng tuyến tính dùng trong cơ cấu vận chuyển và định vị?
ア Ray
イ Khối trượt (carriage)
ウ Bi
エ Xích', NULL, 'エ', 'Dẫn hướng tuyến tính kiểu bi gồm ray, khối trượt và các viên bi tuần hoàn. Xích có thể truyền chuyển động trong hệ vận chuyển nhưng không phải thành phần của bộ dẫn hướng tuyến tính này.', '[{"term": "直動案内", "reading": "ちょくどうあんない", "meaning": "dẫn hướng tuyến tính"}, {"term": "位置決め", "reading": "いちぎめ", "meaning": "định vị"}, {"term": "構成部品", "reading": "こうせいぶひん", "meaning": "bộ phận cấu thành"}]'::jsonb, 97);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Cơ cấu, thủy lực và ký hiệu', 48, '油圧・空気圧装置に関する文中の［a］内に当てはまる文章として、適切なものはどれ
か。
「油圧装置は、空気圧装置と比べ、［a］。」
ア 応答速度が遅い
イ 小型で大きな出力を得ることができる
ウ 運転速度の調整が難しい
エ 温度変化によるアクチュエータの出力、速度への影響が小さい', 'Câu nào phù hợp điền vào ［a］ trong nội dung về thiết bị thủy lực và khí nén?
“So với thiết bị khí nén, thiết bị thủy lực ［a］.”
ア Có tốc độ đáp ứng chậm
イ Có thể tạo đầu ra lớn với kích thước nhỏ
ウ Khó điều chỉnh tốc độ vận hành
エ Đầu ra và tốc độ của cơ cấu chấp hành ít chịu ảnh hưởng của thay đổi nhiệt độ', NULL, 'イ', 'Thủy lực thường làm việc ở áp suất cao, nên F = pA cho lực lớn với diện tích piston nhỏ. Lưu lượng cho phép điều chỉnh tốc độ; nhiệt độ làm đổi độ nhớt dầu và có thể ảnh hưởng vận hành. Không coi đặc tính đáp ứng là cố định cho mọi hệ.', '[{"term": "油圧", "reading": "ゆあつ", "meaning": "thủy lực"}, {"term": "空気圧", "reading": "くうきあつ", "meaning": "khí nén"}, {"term": "出力", "reading": "しゅつりょく", "meaning": "đầu ra"}, {"term": "アクチュエータ", "reading": "アクチュエータ", "meaning": "cơ cấu chấp hành"}]'::jsonb, 98);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Cơ cấu, thủy lực và ký hiệu', 49, 'JISにおいて、下図に示す油圧用図記号の名称として、適切なものはどれか。
ア 差圧計
イ 圧力計
ウ 流量計
エ 温度計

![Hình câu 49](images/2025_cau_49.png)', 'Theo JIS, tên nào phù hợp với ký hiệu thủy lực trong hình?
ア Đồng hồ chênh áp
イ Đồng hồ áp suất
ウ Đồng hồ lưu lượng
エ Đồng hồ nhiệt độ', NULL, 'イ', 'Vòng tròn có kim chỉ và một đường nối áp suất là ký hiệu đồng hồ áp suất. Không nhầm với đồng hồ chênh áp đo hiệu hai áp suất hoặc thiết bị đo lưu lượng và nhiệt độ.', '[{"term": "油圧用図記号", "reading": "ゆあつようずきごう", "meaning": "ký hiệu sơ đồ thủy lực"}, {"term": "圧力計", "reading": "あつりょくけい", "meaning": "đồng hồ áp suất"}, {"term": "差圧計", "reading": "さあつけい", "meaning": "đồng hồ chênh áp"}]'::jsonb, 99);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Cơ cấu, thủy lực và ký hiệu', 50, 'JISにおいて、下図に示す電気用図記号の名称として、適切なものはどれか。
ア 引きボタンスイッチ
イ 自動復帰しないメーク接点(a接点)
ウ 遮断器
エ 瞬時動作限時復帰のブレーク接点(b接点)

![Hình câu 50](images/2025_cau_50.png)', 'Theo JIS, tên nào phù hợp với ký hiệu điện trong hình?
ア Công tắc nút kéo
イ Tiếp điểm đóng không tự trở về (tiếp điểm a)
ウ Máy cắt/aptomat
エ Tiếp điểm ngắt tác động tức thời, trở về có trễ (tiếp điểm b)', NULL, 'ウ', 'Dấu đặc trưng trên tiếp điểm xác định đây là thiết bị cắt mạch, chọn ウ. Không chỉ nhìn tiếp điểm đang mở để kết luận là tiếp điểm a: ký hiệu cơ cấu đóng cắt đi kèm quyết định loại thiết bị.', '[{"term": "遮断器", "reading": "しゃだんき", "meaning": "máy cắt, aptomat"}, {"term": "引きボタンスイッチ", "reading": "ひきボタンスイッチ", "meaning": "công tắc nút kéo"}, {"term": "自動復帰", "reading": "じどうふっき", "meaning": "tự trở về"}, {"term": "Mẫu câu tiếng Nhật", "reading": "Cách đọc bằng kana", "meaning": "Nghĩa tiếng Việt / cách xử lý khi làm bài"}, {"term": "～とは、～である。", "reading": "～とは、～である。", "meaning": "Định nghĩa “X là…”. Kiểm tra đặc trưng, phạm vi và điều kiện trong định nghĩa."}, {"term": "～に関する記述のうち、適切なものはどれか。", "reading": "～にかんするきじゅつのうち、てきせつなものはどれか。", "meaning": "Trong các phát biểu về…, phát biểu nào phù hợp? Chọn một phát biểu đúng."}, {"term": "～に関する記述のうち、適切でないものはどれか。", "reading": "～にかんするきじゅつのうち、てきせつでないものはどれか。", "meaning": "Phát biểu nào không phù hợp? Chú ý phủ định でない trước khi chọn."}, {"term": "～の組合せとして、適切なものはどれか。", "reading": "～のくみあわせとして、てきせつなものはどれか。", "meaning": "Tổ hợp nào phù hợp? Kiểm tra mọi thành phần trong cùng một lựa chọn."}, {"term": "下図に示す～", "reading": "かずにしめす～", "meaning": "…được thể hiện trong hình dưới. Đọc cả nhãn, số liệu và đường nối."}, {"term": "下表のデータで～を作成する場合、", "reading": "かひょうのデータで～をさくせいするばあい、", "meaning": "Khi lập… từ dữ liệu bảng dưới. Xác định đại lượng trước khi tính."}, {"term": "～に当てはまる語句", "reading": "～にあてはまるごく", "meaning": "Từ/cụm từ phù hợp để điền vào chỗ trống."}, {"term": "～と比べ、～", "reading": "～とくらべ、～", "meaning": "So với…; giữ đúng đối tượng làm mốc so sánh."}, {"term": "～ほど～", "reading": "～ほど～", "meaning": "Càng… càng…; kiểm tra chiều tăng/giảm."}, {"term": "～を超える", "reading": "～をこえる", "meaning": "Vượt quá…; là >, khác với 以上 là ≥."}, {"term": "～を考慮しない場合、", "reading": "～をこうりょしないばあい、", "meaning": "Nếu không xét…; bỏ đúng yếu tố được nêu, không tự thêm giả thiết."}, {"term": "～に従って～", "reading": "～にしたがって～", "meaning": "Theo…; nhận ra quy trình hoặc chương trình chi phối thao tác."}, {"term": "～として、もっとも適切なものはどれか。", "reading": "～として、もっともてきせつなものはどれか。", "meaning": "Chọn phương án phù hợp nhất, xét đầy đủ ứng dụng và điều kiện."}, {"term": "～しなければならない。", "reading": "～しなければならない。", "meaning": "Phải…; kiểm tra tính bắt buộc và điều kiện áp dụng."}]'::jsonb, 100);
END $$;
