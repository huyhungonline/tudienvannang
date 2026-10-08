-- Certificates feature: seibi3 (cokhi category) — generated from
-- doccument/seibi3/sach_on_tap_Nhat_Viet.md via a one-off parsing script

INSERT INTO certificates (code, category, name_ja, name_vi, related_occupations)
VALUES (
    'seibi3', 'cokhi', '三級自動車ガソリン・エンジン', 'Kỹ năng bảo dưỡng ô tô - động cơ xăng 3級',
    'Thợ sửa chữa/bảo dưỡng ô tô, kỹ thuật viên gara ô tô, kỹ thuật viên kiểm định xe, nhân viên dịch vụ hậu mãi của đại lý ô tô, kỹ sư động cơ đốt trong.'
)
ON CONFLICT (code) DO NOTHING;

DO $$
DECLARE cert_id INT;
BEGIN
    SELECT id INTO cert_id FROM certificates WHERE code = 'seibi3';
    DELETE FROM certificate_vocabulary WHERE certificate_id = cert_id;

    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'IC（集積回路）', 'あいしー（しゅうせきかいろ）', 'mạch tích hợp', '', '', '', 1);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'PCV', 'ぴーしーぶい', 'thông gió cácte cưỡng bức', '', '', '', 2);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'NPN型', 'えぬぴーえぬがた', 'transistor loại NPN', '', '', '', 3);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'N型／P型', 'えぬがた／ぴーがた', 'bán dẫn loại N／P', '', '', '', 4);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'HC', 'えいちしー', 'hydrocarbon chưa cháy', '', '', '', 5);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'CO', 'しーおー', 'cacbon monoxit', '', '', '', 6);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'NOₓ', 'えぬおーえっくす', 'các oxit nitơ', '', '', '', 7);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'H₂O／O₂／N₂', 'えいちつーおー／おーつー／えぬつー', 'nước／oxy／nitơ', '', '', '', 8);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ON／OFF', 'おん／おふ', 'bật／tắt; đóng／hở theo ngữ cảnh', '', '', '', 9);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'Ah／A', 'あんぺああわー／あんぺあ', 'ampe giờ (dung lượng)／ampe (dòng điện)', '', '', '', 10);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'V／W／Ω', 'ぼると／わっと／おーむ', 'vôn／oát／ôm', '', '', '', 11);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'min⁻¹', 'まいふん', 'số vòng mỗi phút trong các câu tốc độ quay', '', '', '', 12);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'cd', 'かんでら', 'candela; đơn vị cường độ sáng', '', '', '', 13);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'レシプロ・エンジン', 'れしぷろ・えんじん', 'động cơ pít-tông tịnh tiến', '', '', '', 14);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ピストン・リング', 'ぴすとん・りんぐ', 'xéc-măng pít-tông', '', '', '', 15);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'インテーク／エキゾースト', 'いんてーく／えきぞーすと', 'nạp／xả', '', '', '', 16);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'フライホイール', 'ふらいほいーる', 'bánh đà', '', '', '', 17);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ダイヤル・ゲージ', 'だいやる・げーじ', 'đồng hồ so', '', '', '', 18);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'シックネス・ゲージ', 'しっくねす・げーじ', 'căn lá', '', '', '', 19);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'プラスチ・ゲージ', 'ぷらすち・げーじ', 'dây đo khe hở Plastigage', '', '', '', 20);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'サーモスタット', 'さーもすたっと', 'van hằng nhiệt', '', '', '', 21);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'オルタネータ', 'おるたねーた', 'máy phát xoay chiều', '', '', '', 22);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'リダクション式スタータ', 'りだくしょんしきすたーた', 'máy khởi động giảm tốc', '', '', '', 23);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'チャコール・キャニスタ', 'ちゃこーる・きゃにすた', 'bình than hoạt tính giữ hơi nhiên liệu', '', '', '', 24);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ソレノイド・コイル', 'それのいど・こいる', 'cuộn dây điện từ solenoid', '', '', '', 25);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'トロコイド式', 'とろこいどしき', 'kiểu trochoid (rôto trong/ngoài)', '', '', '', 26);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'Vリブド・ベルト', 'ぶいりぶど・べると', 'đai V nhiều gân', '', '', '', 27);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'グリース／リーマ', 'ぐりーす／りーま', 'mỡ bôi trơn／dao doa', '', '', '', 28);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'ケルメット', 'けるめっと', 'hợp kim đồng–chì dùng cho ổ trục', '', '', '', 29);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'サーミスタ', 'さーみすた', 'nhiệt điện trở', '', '', '', 30);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'リーン／リッチ', 'りーん／りっち', 'hỗn hợp nghèo／đậm', '', '', '', 31);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 1, 'Thuật ngữ viết tắt và katakana', 'マフラ／レゾネータ', 'まふら／れぞねーた', 'bộ giảm thanh／bộ cộng hưởng', '', '', '', 32);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', 'Mẫu câu tiếng Nhật', 'Cách đọc bằng kana', 'Nghĩa tiếng Việt / cách xử lý khi làm bài', '', '', '', 33);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～に関する記述として', '～にかんするきじゅつとして', 'Trong các phát biểu về …; xác định đúng đối tượng được hỏi.', '', '', '', 34);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '適切なものは次のうちどれか。', 'てきせつなものはつぎのうちどれか。', 'Lựa chọn nào phù hợp? Chọn phát biểu đúng.', '', '', '', 35);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '不適切なものは次のうちどれか。', 'ふてきせつなものはつぎのうちどれか。', 'Lựa chọn nào không phù hợp? Chọn phát biểu sai; chú ý 不.', '', '', '', 36);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '図に示す～', 'ずにしめす～', '… thể hiện ở hình; đối chiếu mũi tên, nhãn và đơn vị.', '', '', '', 37);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '［a］に当てはまるものとして', '［えー］にあてはまるものとして', 'Lựa chọn để điền vào ［a］; đọc cả câu sau khi điền.', '', '', '', 38);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '下の組み合わせのうち', 'したのくみあわせのうち', 'Trong các tổ hợp dưới đây; cả hai ô phải đồng thời đúng.', '', '', '', 39);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', 'ただし、～ものとする。', 'ただし、～ものとする。', 'Tuy nhiên, giả sử …; giữ điều kiện như không trượt/không có điện trở dây.', '', '', '', 40);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', 'なお、～を示す。', 'なお、～をしめす。', 'Lưu ý … biểu thị …; đọc định nghĩa dữ liệu và ký hiệu.', '', '', '', 41);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～と比較して', '～とひかくして', 'So với …; phân biệt vật đang xét và đối tượng chuẩn.', '', '', '', 42);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～ほど～なる。', '～ほど～なる。', 'Càng … càng …; kiểm tra chiều tăng/giảm.', '', '', '', 43);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～に照らし', '～にてらし', 'Căn cứ theo …; dùng đúng quy định và nhóm xe được nêu.', '', '', '', 44);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～を超えてはならない。', '～をこえてはならない。', 'Không được vượt …; đây là giới hạn trên.', '', '', '', 45);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', '～しなければならない。', '～しなければならない。', 'Phải …; là nghĩa vụ bắt buộc.', '', '', '', 46);
    INSERT INTO certificate_vocabulary (certificate_id, category_no, category_name, term_ja, reading, meaning_vi, example_ja, example_reading, example_vi, sort_order) VALUES (cert_id, 2, 'Mẫu câu thường gặp trong đề', 'その事由があった日から～以内に', 'そのじゆうがあったひから～いないに', 'Trong vòng … kể từ ngày phát sinh sự việc; xác định đúng mốc thời gian.', '', '', '', 47);
END $$;

DO $$
DECLARE cert_id INT;
BEGIN
    SELECT id INTO cert_id FROM certificates WHERE code = 'seibi3';
    DELETE FROM certificate_exam_questions WHERE certificate_id = cert_id;

    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 1, 'レシプロ・エンジンのバルブ機構に関する記述として、適切なものは次のうちどれか。

(1) バルブ・スプリングには、高速時の異常振動などを防ぐため、シリンダ・ヘッド側のピッチを広くした不等ピッチのスプリングが用いられている。

(2) カムシャフトのカムは卵形状で、カムの長径をカム・リフトという。

(3) カムシャフト・タイミング・スプロケットは、クランクシャフト・タイミング・スプロケットの1/2の回転速度で回る。

(4) エキゾースト・バルブのバルブ・ヘッドの外径は、一般に排気効率を向上させるため、インテーク・バルブより大きい。', 'Trong các phát biểu về cơ cấu xupáp của động cơ pít-tông tịnh tiến, phát biểu nào phù hợp?

(1) Lò xo xupáp dùng bước xoắn không đều, với bước phía nắp xi lanh rộng hơn, nhằm ngăn rung bất thường khi tốc độ cao.

(2) Vấu cam trên trục cam có dạng quả trứng; đường kính dài của cam gọi là độ nâng cam.

(3) Đĩa xích dẫn động trục cam quay với tốc độ bằng 1/2 đĩa xích dẫn động trục khuỷu.

(4) Đường kính ngoài của nấm xupáp xả thường lớn hơn xupáp nạp nhằm nâng hiệu quả xả.', NULL, '(3)', 'Một chu trình 4 kỳ cần trục khuỷu quay hai vòng nhưng trục cam chỉ một vòng, nên (3) đúng. Bước lò xo phía nắp xi lanh hẹp hơn; độ nâng cam là chênh lệch giữa bán kính đỉnh vấu và vòng tròn cơ sở, không phải đường kính dài. Xupáp nạp thường có nấm lớn hơn xupáp xả.', '[{"term": "バルブ機構", "reading": "ばるぶきこう", "meaning": "cơ cấu xupáp"}, {"term": "不等ピッチ", "reading": "ふとうぴっち", "meaning": "bước xoắn không đều"}, {"term": "回転速度", "reading": "かいてんそくど", "meaning": "tốc độ quay"}]'::jsonb, 1);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 2, 'ピストン・リングに関する記述として、不適切なものは次のうちどれか。

(1) バレル・フェース型は、しゅう動面が円弧状になっているため、初期なじみの際の異常摩耗を防止できる。

(2) アンダ・カット型は、最も基本的な形状で、気密性、熱伝導性が優れている。

(3) インナ・ベベル型は、オイルをかき落とす性能に優れているので、一般にトップ・リング又はセカンド・リングに使用されている。

(4) 組み合わせ型オイル・リングは、サイド・レールとスペーサ・エキスパンダを組み合わせている。', 'Trong các phát biểu về xéc-măng pít-tông, phát biểu nào không phù hợp?

(1) Loại barrel-face có bề mặt trượt dạng cung tròn nên ngăn được mòn bất thường trong giai đoạn rà khít ban đầu.

(2) Loại undercut có hình dạng cơ bản nhất, tính kín khí và dẫn nhiệt tốt.

(3) Loại inner-bevel gạt dầu tốt nên thường dùng làm xéc-măng thứ nhất hoặc thứ hai.

(4) Xéc-măng dầu tổ hợp kết hợp các vòng bên với vòng giãn cách.', NULL, '(2)', '(2) sai vì dạng cơ bản có tính kín khí và truyền nhiệt tốt là dạng chữ nhật, không phải undercut. Dạng undercut có phần cắt khuyết để tăng tác dụng gạt dầu. Đừng nhầm đặc điểm hình học của từng loại với tên vị trí xéc-măng.', '[{"term": "しゅう動面", "reading": "しゅうどうめん", "meaning": "bề mặt trượt"}, {"term": "気密性", "reading": "きみつせい", "meaning": "tính kín khí"}, {"term": "熱伝導性", "reading": "ねつでんどうせい", "meaning": "tính dẫn nhiệt"}]'::jsonb, 2);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 3, 'フライホイール及びリング・ギヤに関する記述として、不適切なものは次のうちどれか。

(1) リング・ギヤには、一般に炭素鋼製のスパー・ギヤが用いられる。

(2) フライホイールの振れの点検は、ダイヤル・ゲージを用いて測定する。

(3) フライホイールは、燃焼（膨張）によって変化するクランクシャフトの回転力を平均化する働きをする。

(4) リング・ギヤは、フライホイールの外周にボルトで固定されている。', 'Trong các phát biểu về bánh đà và vành răng, phát biểu nào không phù hợp?

(1) Vành răng thường dùng bánh răng trụ răng thẳng bằng thép cacbon.

(2) Kiểm tra độ đảo của bánh đà bằng đồng hồ so.

(3) Bánh đà làm đều mômen quay của trục khuỷu vốn thay đổi do cháy (giãn nở).

(4) Vành răng được cố định bằng bu lông ở chu vi ngoài của bánh đà.', NULL, '(4)', '(4) sai: vành răng thường được lắp ép co nhiệt ở chu vi bánh đà. Đồng hồ so đo độ đảo; quán tính bánh đà tích trữ và trả năng lượng để làm đều chuyển động quay. Phân biệt cách gắn vành răng với cách bắt bánh đà vào trục khuỷu.', '[{"term": "炭素鋼", "reading": "たんそこう", "meaning": "thép cacbon"}, {"term": "振れ", "reading": "ふれ", "meaning": "độ đảo"}, {"term": "外周", "reading": "がいしゅう", "meaning": "chu vi ngoài"}]'::jsonb, 3);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 4, '図に示すクランクシャフトのAからDのうち、クランク・ピンを表すものとして、適切なものは次のうちどれか。

(1) A

(2) B

(3) C

(4) D

![Hình câu 4](march_q04_hinh.png)', 'Trong các vị trí A đến D trên trục khuỷu ở hình, vị trí nào biểu thị chốt khuỷu?

(1) A

(2) B

(3) C

(4) D

Nhãn hình: A, B, C, D: các ký hiệu vị trí trên trục khuỷu, giữ nguyên để đối chiếu lựa chọn.', NULL, '(3)', 'Chốt khuỷu là cổ trục lệch tâm nơi đầu to thanh truyền lắp vào; trong hình đó là C, tương ứng (3). Các cổ nằm trên đường tâm quay là cổ trục chính. Nhận biết bằng vị trí lệch tâm, không dựa vào kích thước nét vẽ.', '[{"term": "クランク・ピン", "reading": "くらんく・ぴん", "meaning": "chốt khuỷu"}, {"term": "クランクシャフト", "reading": "くらんくしゃふと", "meaning": "trục khuỷu"}, {"term": "図に示す", "reading": "ずにしめす", "meaning": "thể hiện trong hình"}]'::jsonb, 4);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 5, 'ガソリン・エンジンに関する記述として、不適切なものは次のうちどれか。

(1) 熱勘定とは、有効な仕事に変えられた熱量と、供給された燃料の発熱量との比をいう。

(2) ノッキングの害の一つに、異音の発生がある。

(3) 燃料蒸発ガスとは、フューエル・タンクなどの燃料装置から燃料が蒸発し、大気中に放出されるガスをいう。

(4) 一般に始動時、高負荷時などには、理論空燃比より濃い混合気が必要となる。', 'Trong các phát biểu về động cơ xăng, phát biểu nào không phù hợp?

(1) Cân bằng nhiệt là tỷ số giữa nhiệt lượng chuyển thành công hữu ích và nhiệt trị của nhiên liệu được cung cấp.

(2) Một tác hại của kích nổ là phát sinh tiếng động bất thường.

(3) Khí bay hơi nhiên liệu là khí do nhiên liệu bay hơi từ hệ thống nhiên liệu như bình nhiên liệu và thoát ra khí quyển.

(4) Thông thường khi khởi động hoặc tải cao, cần hỗn hợp đậm hơn tỷ lệ không khí–nhiên liệu lý thuyết.', NULL, '(1)', '(1) mô tả hiệu suất nhiệt: η = công hữu ích / nhiệt lượng nhiên liệu cung cấp. 熱勘定 là cân bằng/phân bố nhiệt giữa công hữu ích, nhiệt thoát qua khí xả, hệ thống làm mát và các tổn thất. Kích nổ gây tiếng gõ; hỗn hợp đậm hỗ trợ khởi động và tải cao.', '[{"term": "熱勘定", "reading": "ねつかんじょう", "meaning": "cân bằng nhiệt"}, {"term": "発熱量", "reading": "はつねつりょう", "meaning": "nhiệt trị"}, {"term": "高負荷", "reading": "こうふか", "meaning": "tải cao"}]'::jsonb, 5);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 6, '点火装置に用いられるイグニション・コイルの二次コイルと比べたときの一次コイルの特徴に関する記述として、適切なものは次のうちどれか。

(1) 銅線が太く巻き数が多い。

(2) 銅線が細く巻き数が多い。

(3) 銅線が細く巻き数が少ない。

(4) 銅線が太く巻き数が少ない。', 'So với cuộn thứ cấp của bôbin đánh lửa, phát biểu nào phù hợp về đặc điểm cuộn sơ cấp?

(1) Dây đồng to và nhiều vòng quấn.

(2) Dây đồng nhỏ và nhiều vòng quấn.

(3) Dây đồng nhỏ và ít vòng quấn.

(4) Dây đồng to và ít vòng quấn.', NULL, '(4)', 'Cuộn sơ cấp chịu dòng lớn nên dây đồng to, số vòng ít; cuộn thứ cấp có dây nhỏ và nhiều vòng để tạo điện áp cao. Vì vậy chọn (4). Đừng đảo đặc điểm sơ cấp và thứ cấp; tỷ số vòng quấn liên quan đến khả năng tăng điện áp.', '[{"term": "一次コイル", "reading": "いちじこいる", "meaning": "cuộn sơ cấp"}, {"term": "二次コイル", "reading": "にじこいる", "meaning": "cuộn thứ cấp"}, {"term": "巻き数", "reading": "まきすう", "meaning": "số vòng quấn"}]'::jsonb, 6);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 7, '点火順序が1－3－4－2の4サイクル直列4シリンダ・エンジンの第2シリンダが燃焼行程の下死点にあり、この状態からクランクシャフトを回転方向に360°回したときに排気行程の上死点にあるシリンダとして、適切なものは次のうちどれか。

(1) 第1シリンダ

(2) 第2シリンダ

(3) 第3シリンダ

(4) 第4シリンダ', 'Trong động cơ 4 kỳ, 4 xi lanh thẳng hàng, thứ tự đánh lửa 1－3－4－2, xi lanh số 2 đang ở điểm chết dưới của kỳ cháy. Từ trạng thái này, quay trục khuỷu theo chiều quay 360°; xi lanh nào ở điểm chết trên của kỳ xả?

(1) Xi lanh số 1.

(2) Xi lanh số 2.

(3) Xi lanh số 3.

(4) Xi lanh số 4.', NULL, '(1)', 'Lấy thời điểm bắt đầu cháy của xi lanh 2 làm 0°: trạng thái đầu là 180°, sau khi quay là 540°. Xi lanh 1 đánh lửa ở 180°; đến 540° nó đã qua 360°, kết thúc kỳ xả tại điểm chết trên. Chọn (1). Phải phân biệt điểm chết trên cuối nén với cuối xả.', '[{"term": "点火順序", "reading": "てんかじゅんじょ", "meaning": "thứ tự đánh lửa"}, {"term": "下死点", "reading": "かしてん", "meaning": "điểm chết dưới"}, {"term": "上死点", "reading": "じょうしてん", "meaning": "điểm chết trên"}]'::jsonb, 7);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 8, '全流ろ過圧送式潤滑装置に関する記述として、適切なものは次のうちどれか。

(1) オイル・パン内部のバッフル・プレートは、オイル・パン底部にたまった鉄粉を吸着する働きがある。

(2) トロコイド式オイル・ポンプのアウタ・ロータの山とインナ・ロータの山とのすき間をサイド・クリアランスという。

(3) オイル・ポンプのリリーフ・バルブは、ポンプから圧送されるオイルの圧力が規定値以上になると余分なオイルをオイル・パンなどに戻す。

(4) オイル・プレッシャ・スイッチは、油圧が規定値以上になると、コンビネーション・メータ内のオイル・プレッシャ・ランプを点灯させる。', 'Trong các phát biểu về hệ thống bôi trơn cưỡng bức lọc toàn dòng, phát biểu nào phù hợp?

(1) Tấm chắn trong cácte dầu hút giữ mạt sắt tích ở đáy cácte.

(2) Khe hở giữa đỉnh rôto ngoài và đỉnh rôto trong của bơm dầu trochoid được gọi là khe hở bên.

(3) Van giảm áp của bơm dầu đưa dầu thừa về cácte dầu hoặc nơi tương tự khi áp suất dầu do bơm cung cấp đạt từ giá trị quy định trở lên.

(4) Công tắc áp suất dầu bật đèn báo áp suất dầu trong cụm đồng hồ khi áp suất dầu đạt từ giá trị quy định trở lên.', NULL, '(3)', '(3) đúng: van giảm áp giới hạn áp suất. Tấm chắn hạn chế dầu dao động; khe giữa các đỉnh là tip clearance, còn side clearance là khe mặt bên. Đèn cảnh báo dầu sáng khi áp suất quá thấp, không phải khi đủ cao.', '[{"term": "潤滑装置", "reading": "じゅんかつそうち", "meaning": "hệ thống bôi trơn"}, {"term": "圧送", "reading": "あっそう", "meaning": "cấp bằng áp lực"}, {"term": "規定値", "reading": "きていち", "meaning": "giá trị quy định"}]'::jsonb, 8);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 9, 'ワックス・ペレット型サーモスタットに関する記述として、不適切なものは次のうちどれか。

(1) サーモスタットの取り付け位置による水温制御の方法には、出口制御式と入口制御式とがある。

(2) 冷却水温度が低いときは、スプリングのばね力によってバルブは開いている。

(3) 冷却水温度が低くなると、液体のワックスが固体となって収縮し、圧縮されていた合成ゴムは元の状態に戻る。

(4) ジグル・バルブは、冷却水の循環系統内に残留している空気がない場合、浮力と水圧により閉じている。', 'Trong các phát biểu về van hằng nhiệt kiểu viên sáp, phát biểu nào không phù hợp?

(1) Tùy vị trí lắp van hằng nhiệt, có phương pháp điều khiển nhiệt độ nước kiểu cửa ra và kiểu cửa vào.

(2) Khi nhiệt độ nước làm mát thấp, lực lò xo giữ van mở.

(3) Khi nhiệt độ nước làm mát giảm, sáp lỏng đông đặc và co lại, cao su tổng hợp từng bị nén trở về trạng thái ban đầu.

(4) Khi không còn không khí trong hệ tuần hoàn nước làm mát, van jiggle đóng nhờ lực nổi và áp lực nước.', NULL, '(2)', '(2) sai: khi lạnh, lò xo giữ van chính đóng để động cơ nhanh nóng lên. Khi sáp nóng chảy và giãn nở, van mở đường đến két nước. Van jiggle hỗ trợ thoát khí; không nhầm nó với van chính.', '[{"term": "冷却水", "reading": "れいきゃくすい", "meaning": "nước làm mát"}, {"term": "収縮", "reading": "しゅうしゅく", "meaning": "co lại"}, {"term": "浮力", "reading": "ふりょく", "meaning": "lực nổi"}]'::jsonb, 9);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 10, 'エア・クリーナに関する記述として、不適切なものは次のうちどれか。

(1) エレメントが汚れて目詰まりを起こすと吸入空気量が減少し、有害排気ガスが発生する原因になる。

(2) 吸気経路の途中に設けられたレゾネータは、共鳴効果を利用して吸気騒音を小さくする。

(3) エンジンに吸入される空気は、エレメントを通過することによってごみなどが取り除かれる。

(4) ビスカス式エレメントの清掃は、エレメントの内側（空気の流れの下流側）から圧縮空気を吹き付けて行う。', 'Trong các phát biểu về bộ lọc không khí, phát biểu nào không phù hợp?

(1) Khi phần tử lọc bẩn và tắc, lượng không khí nạp giảm, có thể gây khí thải độc hại.

(2) Bộ cộng hưởng trên đường nạp dùng hiệu ứng cộng hưởng để giảm tiếng ồn nạp.

(3) Không khí vào động cơ được loại bỏ bụi và tạp chất khi đi qua phần tử lọc.

(4) Làm sạch phần tử lọc kiểu viscous bằng cách thổi khí nén từ phía trong (phía hạ lưu của dòng khí).', NULL, '(4)', '(4) sai: phần tử lọc viscous được tẩm chất giữ bụi; thổi khí nén có thể làm mất lớp này và hỏng lọc. Khi đến hạn cần thay theo quy định. Phương pháp thổi ngược dòng của một số lọc khô không áp dụng máy móc cho lọc viscous.', '[{"term": "目詰まり", "reading": "めづまり", "meaning": "tắc nghẽn"}, {"term": "共鳴効果", "reading": "きょうめいこうか", "meaning": "hiệu ứng cộng hưởng"}, {"term": "圧縮空気", "reading": "あっしゅくくうき", "meaning": "khí nén"}]'::jsonb, 10);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 11, '電子制御式燃料噴射装置に関する記述として、不適切なものは次のうちどれか。

(1) チャコール・キャニスタは、燃料蒸発ガスが大気中に放出されるのを防止している。

(2) プレッシャ・レギュレータは、インジェクタのソレノイド・コイルへの通電時間を制御している。

(3) インジェクタのソレノイド・コイルに電流が流れると、ニードル・バルブが全開位置に移動し、燃料が噴射される。

(4) くら型のフューエル・タンクでは、ジェット・ポンプによりサブ室からメーン室に燃料を移送している。', 'Trong các phát biểu về hệ thống phun nhiên liệu điều khiển điện tử, phát biểu nào không phù hợp?

(1) Bình than hoạt tính ngăn hơi nhiên liệu thoát vào khí quyển.

(2) Bộ điều áp điều khiển thời gian cấp điện cho cuộn solenoid của kim phun.

(3) Khi dòng điện chạy qua cuộn solenoid của kim phun, van kim dịch đến vị trí mở hoàn toàn và nhiên liệu được phun.

(4) Trong bình nhiên liệu dạng yên ngựa, bơm tia chuyển nhiên liệu từ khoang phụ sang khoang chính.', NULL, '(2)', '(2) sai: bộ điều áp điều chỉnh áp suất nhiên liệu; ECU điều khiển thời gian cấp điện cho kim phun. Lượng phun phụ thuộc thời gian mở và chênh áp qua kim phun. Bình than hoạt tính giữ hơi xăng, còn bơm tia chuyển nhiên liệu giữa các khoang.', '[{"term": "燃料噴射装置", "reading": "ねんりょうふんしゃそうち", "meaning": "hệ thống phun nhiên liệu"}, {"term": "通電時間", "reading": "つうでんじかん", "meaning": "thời gian cấp điện"}, {"term": "移送", "reading": "いそう", "meaning": "chuyển sang nơi khác"}]'::jsonb, 11);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 12, 'リダクション式スタータに関する記述として、不適切なものは次のうちどれか。

(1) オーバランニング・クラッチは、アーマチュアの回転を増速させる働きをしている。

(2) 内接式のリダクション式スタータは、一般にプラネタリ・ギヤ式とも呼ばれている。

(3) 減速ギヤ部によって、アーマチュアの回転を減速し、駆動トルクを増大させてピニオン・ギヤに伝えている。

(4) 直結式スタータより小型軽量化ができる利点がある。', 'Trong các phát biểu về máy khởi động giảm tốc, phát biểu nào không phù hợp?

(1) Ly hợp vượt tốc làm tăng tốc quay của phần ứng.

(2) Máy khởi động giảm tốc kiểu ăn khớp trong thường còn gọi là kiểu bánh răng hành tinh.

(3) Cụm bánh răng giảm tốc giảm tốc độ phần ứng, tăng mômen dẫn động rồi truyền đến bánh răng nhỏ.

(4) Có ưu điểm nhỏ và nhẹ hơn máy khởi động truyền động trực tiếp.', NULL, '(1)', '(1) sai: ly hợp vượt tốc truyền lực từ máy khởi động đến động cơ nhưng ngắt truyền ngược khi động cơ đã chạy, tránh phần ứng bị quay quá tốc độ. Tác dụng giảm tốc và tăng mômen thuộc cụm bánh răng, không thuộc ly hợp.', '[{"term": "減速", "reading": "げんそく", "meaning": "giảm tốc"}, {"term": "駆動トルク", "reading": "くどうとるく", "meaning": "mômen dẫn động"}, {"term": "小型軽量化", "reading": "こがたけいりょうか", "meaning": "làm nhỏ và nhẹ"}]'::jsonb, 12);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 13, '水冷・加圧式の冷却装置に関する記述として、適切なものは次のうちどれか。

(1) サーモスタットは、ラジエータ内に設けられている。

(2) 標準型のサーモスタットのバルブは、冷却水温度が上昇し規定温度に達すると閉じ、冷却水がラジエータを循環して冷却水温度が下がる。

(3) 冷却水の凍結温度は、不凍液の混合率を30%にしたとき最も低い。

(4) 電動式ウォータ・ポンプは、補機駆動用ベルトやタイミング・ベルトによって駆動されるものと比べて、燃費を低減させることができる。', 'Trong các phát biểu về hệ thống làm mát bằng nước có áp suất, phát biểu nào phù hợp?

(1) Van hằng nhiệt được đặt bên trong két nước.

(2) Van của bộ hằng nhiệt tiêu chuẩn đóng khi nước làm mát tăng đến nhiệt độ quy định, khiến nước tuần hoàn qua két và hạ nhiệt.

(3) Nhiệt độ đông đặc của nước làm mát thấp nhất khi tỷ lệ pha chất chống đông là 30%.

(4) Bơm nước điện có thể giảm mức tiêu hao nhiên liệu so với loại dẫn động bằng đai phụ hoặc đai cam.', NULL, '(4)', '(4) đúng: bơm điện có thể điều chỉnh lưu lượng theo nhu cầu thay vì luôn gắn với tốc độ động cơ. Van hằng nhiệt nằm trên đường tuần hoàn và mở khi nóng; mức chống đông tối ưu không phải 30% (đề dùng kiến thức hỗn hợp ethylene glycol, khoảng 60%). Tránh hiểu “giảm 燃費” ở đây thành giảm hiệu quả nhiên liệu.', '[{"term": "加圧式", "reading": "かあつしき", "meaning": "kiểu có áp suất"}, {"term": "凍結温度", "reading": "とうけつおんど", "meaning": "nhiệt độ đông đặc"}, {"term": "燃費", "reading": "ねんぴ", "meaning": "mức tiêu hao nhiên liệu"}]'::jsonb, 13);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 14, '電子制御装置のセンサに関する記述として、不適切なものは次のうちどれか。

(1) 吸気温センサには、磁気抵抗素子が用いられている。

(2) バキューム・センサには、半導体が用いられている。

(3) 空燃比センサには、ジルコニア素子が用いられている。

(4) 水温センサには、サーミスタが用いられている。', 'Trong các phát biểu về cảm biến của hệ thống điều khiển điện tử, phát biểu nào không phù hợp?

(1) Cảm biến nhiệt độ khí nạp dùng phần tử từ điện trở.

(2) Cảm biến chân không dùng chất bán dẫn.

(3) Cảm biến tỷ lệ không khí–nhiên liệu dùng phần tử zirconia.

(4) Cảm biến nhiệt độ nước dùng nhiệt điện trở.', NULL, '(1)', '(1) sai: cảm biến nhiệt độ khí nạp thường dùng nhiệt điện trở, tương tự cảm biến nhiệt độ nước. Phần tử từ điện trở dùng để phát hiện từ trường/chuyển động ở các ứng dụng khác. Cần phân biệt đại lượng được đo trước khi chọn phần tử cảm biến.', '[{"term": "吸気温", "reading": "きゅうきおん", "meaning": "nhiệt độ khí nạp"}, {"term": "磁気抵抗素子", "reading": "じきていこうそし", "meaning": "phần tử từ điện trở"}, {"term": "半導体", "reading": "はんどうたい", "meaning": "chất bán dẫn"}]'::jsonb, 14);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 15, '排気装置のマフラに関する記述として、適切なものは次のうちどれか。

(1) 高温・高圧の排気ガスは、マフラ内の圧力を上げることで消音される。

(2) 吸音材料により音波を吸収する。

(3) 管の断面積を急に大きくし、排気ガスを膨張させることにより圧力を上げて音を減少させる。

(4) 排気の通路を広げ、圧力の変動を抑えることで音を減少させる。', 'Trong các phát biểu về bộ giảm thanh của hệ thống xả, phát biểu nào phù hợp?

(1) Khí xả nóng, áp suất cao được giảm âm bằng cách tăng áp suất trong bộ giảm thanh.

(2) Vật liệu hấp thụ âm hấp thụ sóng âm.

(3) Tăng đột ngột tiết diện ống cho khí xả giãn nở để tăng áp suất và giảm âm.

(4) Mở rộng đường khí xả để hạn chế biến động áp suất và giảm âm.', NULL, '(2)', '(2) đúng vì vật liệu hấp thụ biến năng lượng âm thành nhiệt. (1) và (3) sai ở ý tăng áp suất khi giãn nở. (4) quy tác dụng giảm âm đơn thuần cho việc mở rộng đường xả; bộ giảm thanh cần cấu trúc hấp thụ, phản xạ và giao thoa phù hợp, không chỉ đường ống rộng hơn.', '[{"term": "吸音材料", "reading": "きゅうおんざいりょう", "meaning": "vật liệu hấp thụ âm"}, {"term": "断面積", "reading": "だんめんせき", "meaning": "diện tích tiết diện"}, {"term": "消音", "reading": "しょうおん", "meaning": "giảm âm"}]'::jsonb, 15);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 16, '図に示すスパーク・プラグの中心電極を表すものとして、適切なものは次のうちどれか。

(1) A

(2) B

(3) C

(4) D

![Hình câu 16](march_q16_hinh.png)', 'Trong hình bugi, ký hiệu nào biểu thị điện cực trung tâm?

(1) A

(2) B

(3) C

(4) D

Nhãn hình: A, B, C, D: các ký hiệu bộ phận bugi, giữ nguyên để đối chiếu lựa chọn.', NULL, '(3)', 'Điện cực trung tâm nằm trên trục bugi và kết thúc ở đầu đánh lửa, ký hiệu C, nên chọn (3). A là khu vực đầu nối, B chỉ phần cách điện, D chỉ điện cực bên. Nhận diện đúng đầu mũi tên để tránh nhầm sứ cách điện với điện cực.', '[{"term": "中心電極", "reading": "ちゅうしんでんきょく", "meaning": "điện cực trung tâm"}, {"term": "絶縁", "reading": "ぜつえん", "meaning": "cách điện"}, {"term": "スパーク・プラグ", "reading": "すぱーく・ぷらぐ", "meaning": "bugi"}]'::jsonb, 16);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 17, 'スパーク・プラグに関する記述として、不適切なものは次のうちどれか。

(1) 低熱価型プラグは、標準熱価型プラグと比較して、放熱しやすく電極部は焼けにくい。

(2) 電極には腐食に強いニッケル合金、中軸には銅又は銅合金が用いられる。

(3) 高熱価型プラグは、標準熱価型プラグと比較して碍子脚部が短い。

(4) 絶縁碍子は、電極の支持と高電圧の漏電を防ぐ働きをしている。', 'Trong các phát biểu về bugi, phát biểu nào không phù hợp?

(1) Bugi có trị số nhiệt thấp tản nhiệt dễ hơn và phần điện cực ít bị nung nóng hơn bugi tiêu chuẩn.

(2) Điện cực dùng hợp kim niken chống ăn mòn, lõi giữa dùng đồng hoặc hợp kim đồng.

(3) Bugi có trị số nhiệt cao có chân sứ ngắn hơn bugi tiêu chuẩn.

(4) Sứ cách điện đỡ điện cực và ngăn rò điện cao áp.', NULL, '(1)', '(1) sai vì trị số nhiệt thấp tương ứng bugi nóng: chân sứ dài, khó thoát nhiệt hơn, đầu đánh lửa nóng hơn. Trị số nhiệt cao tương ứng bugi lạnh: chân sứ ngắn, tản nhiệt tốt. “Trị số nhiệt cao” không có nghĩa nhiệt độ bugi cao.', '[{"term": "低熱価型", "reading": "ていねつかがた", "meaning": "loại trị số nhiệt thấp"}, {"term": "碍子脚部", "reading": "がいしきゃくぶ", "meaning": "chân sứ cách điện"}, {"term": "漏電", "reading": "ろうでん", "meaning": "rò điện"}]'::jsonb, 17);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 18, 'ブラシ型オルタネータ（IC式ボルテージ・レギュレータ内蔵）に関する記述として、適切なものは次のうちどれか。

(1) 一般にステータには、一体化された冷却用ファンが取り付けられる。

(2) ステータ・コイルに発生する誘導起電力の大きさは、ステータ・コイルの巻き数が多いほど小さくなる。

(3) オルタネータは、ステータ・コイルに発生した交流電流をトランジスタによって整流している。

(4) ロータ・コアは、スリップ・リングを通してロータ・コイルに電流を流すことによって磁化される。', 'Trong các phát biểu về máy phát xoay chiều có chổi than (tích hợp bộ điều áp IC), phát biểu nào phù hợp?

(1) Thông thường quạt làm mát tích hợp được gắn vào stato.

(2) Suất điện động cảm ứng trong cuộn stato nhỏ đi khi số vòng cuộn stato tăng.

(3) Máy phát dùng transistor để chỉnh lưu dòng xoay chiều sinh ra trong cuộn stato.

(4) Lõi rôto được từ hóa bằng dòng điện chạy qua cuộn rôto thông qua vành trượt.', NULL, '(4)', '(4) đúng: dòng điện đi qua chổi than và vành trượt vào cuộn rôto, tạo từ trường và từ hóa lõi rôto. Quạt làm mát thường gắn với rôto, không phải stato; nhiều vòng quấn làm suất điện động cảm ứng lớn hơn; chỉnh lưu dòng xoay chiều bằng điốt, không phải transistor. Transistor trong bộ điều áp điều khiển dòng kích từ, cần phân biệt với điốt chỉnh lưu.', '[{"term": "誘導起電力", "reading": "ゆうどうきでんりょく", "meaning": "suất điện động cảm ứng"}, {"term": "整流", "reading": "せいりゅう", "meaning": "chỉnh lưu"}, {"term": "磁化", "reading": "じか", "meaning": "từ hóa"}]'::jsonb, 18);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 19, '電子制御装置に用いられるセンサに関する記述として、適切なものは次のうちどれか。

(1) 電子制御式スロットル装置のスロットル・ポジション・センサは、アクセル・ペダルの踏み込み角度を検出している。

(2) 熱線式エア・フロー・メータの出力電圧は、吸入空気量が少ないほど高くなる。

(3) バキューム・センサの圧力信号の電圧特性は、インテーク・マニホールド圧力が真空から大気圧に近付くほど出力電圧が大きくなる。

(4) 空燃比センサは、インテーク・マニホールドに取り付けられている。', 'Trong các phát biểu về cảm biến dùng trong hệ thống điều khiển điện tử, phát biểu nào phù hợp?

(1) Cảm biến vị trí bướm ga của hệ thống bướm ga điện tử phát hiện góc đạp bàn đạp ga.

(2) Điện áp ra của lưu lượng kế khí nạp dây nóng tăng khi lượng khí nạp giảm.

(3) Đặc tính điện áp tín hiệu áp suất của cảm biến chân không là: áp suất ống góp nạp càng gần áp suất khí quyển từ trạng thái chân không, điện áp ra càng lớn.

(4) Cảm biến tỷ lệ không khí–nhiên liệu được lắp trên ống góp nạp.', NULL, '(3)', '(3) đúng với đặc tính cảm biến áp suất trong đề. Cảm biến bướm ga đo góc bướm ga; góc bàn đạp do cảm biến bàn đạp đo. Lưu lượng khí lớn thường làm tín hiệu lưu lượng kế lớn hơn. Cảm biến tỷ lệ không khí–nhiên liệu đặt trên đường xả.', '[{"term": "踏み込み角度", "reading": "ふみこみかくど", "meaning": "góc đạp"}, {"term": "大気圧", "reading": "たいきあつ", "meaning": "áp suất khí quyển"}, {"term": "出力電圧", "reading": "しゅつりょくでんあつ", "meaning": "điện áp đầu ra"}]'::jsonb, 19);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 20, '半導体に関する記述として、不適切なものは次のうちどれか。

(1) 真性半導体は、シリコンやゲルマニウムに他の原子をごく少量加えたものである。

(2) 発光ダイオードは、順方向の電圧を加えて電流を流すと発光するものである。

(3) IC（集積回路）は、「はんだ付けによる故障が少ない」、「超小型化が可能になる」、「消費電力が少ない」などの特長がある。

(4) N型半導体は、自由電子が多くあるようにつくられた不純物半導体である。', 'Trong các phát biểu về chất bán dẫn, phát biểu nào không phù hợp?

(1) Bán dẫn nội tại là silic hoặc germani được thêm một lượng rất nhỏ nguyên tử khác.

(2) Điốt phát quang phát sáng khi đặt điện áp thuận và cho dòng điện chạy qua.

(3) IC (mạch tích hợp) có các ưu điểm như ít hỏng do mối hàn, có thể thu nhỏ mạnh và tiêu thụ điện ít.

(4) Bán dẫn loại N là bán dẫn pha tạp được chế tạo để có nhiều electron tự do.', NULL, '(1)', '(1) sai: bán dẫn nội tại là vật liệu tinh khiết; thêm tạp chất tạo bán dẫn ngoại lai. Loại N có electron là hạt tải đa số, loại P có lỗ trống là hạt tải đa số. LED cần phân cực thuận để phát sáng.', '[{"term": "真性半導体", "reading": "しんせいはんどうたい", "meaning": "bán dẫn nội tại"}, {"term": "順方向", "reading": "じゅんほうこう", "meaning": "chiều thuận"}, {"term": "自由電子", "reading": "じゆうでんし", "meaning": "electron tự do"}]'::jsonb, 20);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 21, '図に示すベルト伝達機構において、Aのプーリが600 min⁻¹で回転しているとき、Bのプーリの回転速度として、適切なものは次のうちどれか。ただし、滑り及び機械損失はないものとして計算しなさい。なお、図中の（ ）内の数値はプーリの有効半径を示す。

(1) 225 min⁻¹

(2) 400 min⁻¹

(3) 900 min⁻¹

(4) 1,350 min⁻¹

![Hình câu 21](march_q21_hinh.png)', 'Trong cơ cấu truyền đai ở hình, khi puli A quay 600 min⁻¹, tốc độ quay của puli B là bao nhiêu? Tính với giả thiết không trượt và không có tổn thất cơ khí. Các số trong ngoặc ở hình là bán kính hiệu dụng của puli.

(1) 225 min⁻¹

(2) 400 min⁻¹

(3) 900 min⁻¹

(4) 1,350 min⁻¹

Nhãn hình: A（60 mm）, B（90 mm）, C（75 mm）: các puli và bán kính hiệu dụng tương ứng.', NULL, '(2)', 'Tốc độ dài của đai bằng nhau: nA × rA = nB × rB. Với rA = 60 mm, rB = 90 mm, nB = 600 × 60/90 = 400 min⁻¹, chọn (2). Puli C có bán kính 75 mm không làm đổi quan hệ A–B; đừng đảo tỷ số bán kính.', '[{"term": "伝達機構", "reading": "でんたつきこう", "meaning": "cơ cấu truyền động"}, {"term": "有効半径", "reading": "ゆうこうはんけい", "meaning": "bán kính hiệu dụng"}, {"term": "機械損失", "reading": "きかいそんしつ", "meaning": "tổn thất cơ khí"}]'::jsonb, 21);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Technology', 22, 'Vリブド・ベルトに関する記述として、不適切なものは次のうちどれか。

(1) Vベルトと比較して張力の低下が少ない。

(2) Vベルトと同様に、オルタネータなどを駆動している。

(3) Vベルトと比較してベルト断面が薄いため、耐屈曲性及び耐疲労性に優れている。

(4) Vベルトと比較して伝達効率が低い。', 'Trong các phát biểu về đai V nhiều gân, phát biểu nào không phù hợp?

(1) Độ giảm sức căng ít hơn so với đai V.

(2) Dẫn động máy phát và các thiết bị tương tự như đai V.

(3) Vì tiết diện đai mỏng hơn đai V nên có khả năng chịu uốn và chịu mỏi tốt.

(4) Hiệu suất truyền động thấp hơn đai V.', NULL, '(4)', '(4) sai: đai nhiều gân mỏng, mềm dẻo và có hiệu suất truyền động tốt hơn đai V thông thường. Nhiều gân tăng diện tích làm việc trong khi giảm tổn thất uốn. Không suy ra “mỏng hơn” nghĩa là truyền lực kém hơn.', '[{"term": "張力", "reading": "ちょうりょく", "meaning": "sức căng"}, {"term": "耐屈曲性", "reading": "たいくっきょくせい", "meaning": "khả năng chịu uốn"}, {"term": "伝達効率", "reading": "でんたつこうりつ", "meaning": "hiệu suất truyền động"}]'::jsonb, 22);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Management', 23, '潤滑剤に用いられるグリースに関する記述として、適切なものは次のうちどれか。

(1) グリースは、常温では半固体状であるが、潤滑部が作動し始めると摩擦熱で徐々に柔らかくなる。

(2) リチウム石けんグリースは、ウォータ・ポンプなどに用いられ、耐水性に優れていることが第一条件である。

(3) カルシウム石けんグリースは、マルチパーパス・グリースともいわれている。

(4) 石けん系のグリースには、ベントン・グリースやシリカゲル・グリースなどがある。', 'Trong các phát biểu về mỡ dùng làm chất bôi trơn, phát biểu nào phù hợp?

(1) Mỡ có trạng thái bán rắn ở nhiệt độ thường, nhưng mềm dần do nhiệt ma sát khi bộ phận được bôi trơn bắt đầu hoạt động.

(2) Mỡ xà phòng liti dùng cho bơm nước và các bộ phận tương tự, với điều kiện hàng đầu là khả năng chịu nước tốt.

(3) Mỡ xà phòng canxi còn gọi là mỡ đa dụng.

(4) Mỡ loại xà phòng gồm mỡ benton và mỡ silica gel.', NULL, '(1)', '(1) đúng trong phạm vi mô tả của đề. Mỡ đa dụng thông thường là mỡ xà phòng liti; mỡ canxi nổi bật về chịu nước. Benton và silica gel là chất làm đặc không xà phòng. Phải phân biệt loại chất làm đặc với dầu gốc và tên ứng dụng.', '[{"term": "潤滑剤", "reading": "じゅんかつざい", "meaning": "chất bôi trơn"}, {"term": "半固体状", "reading": "はんこたいじょう", "meaning": "trạng thái bán rắn"}, {"term": "耐水性", "reading": "たいすいせい", "meaning": "khả năng chịu nước"}]'::jsonb, 23);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Strategy', 24, 'リーマの用途に関する記述として、適切なものは次のうちどれか。

(1) 金属材料の「はつり」及び切断に使用する。

(2) おねじのねじ立てに使用する。

(3) 金属材料の穴の内面仕上げに使用する。

(4) ベアリングやブッシュなどの脱着に使用する。', 'Trong các phát biểu về công dụng của dao doa, phát biểu nào phù hợp?

(1) Dùng đục bóc và cắt vật liệu kim loại.

(2) Dùng tạo ren ngoài.

(3) Dùng gia công tinh bề mặt trong của lỗ trên vật liệu kim loại.

(4) Dùng tháo lắp ổ trục và bạc lót.', NULL, '(3)', 'Dao doa lấy một lượng dư nhỏ để hoàn thiện kích thước và bề mặt lỗ đã có, nên (3) đúng. Đục bóc dùng đục; ren ngoài thường dùng bàn ren; tháo ổ trục dùng dụng cụ tháo/ép thích hợp. Dao doa không phải dụng cụ khoan lỗ từ vật liệu đặc.', '[{"term": "リーマ", "reading": "りーま", "meaning": "dao doa"}, {"term": "内面仕上げ", "reading": "ないめんしあげ", "meaning": "gia công tinh mặt trong"}, {"term": "おねじ", "reading": "おねじ", "meaning": "ren ngoài"}]'::jsonb, 24);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Management', 25, '自動車に用いられる非鉄金属に関する記述として、適切なものは次のうちどれか。

(1) 青銅は、銅に錫を加えた合金で、耐摩耗性に優れ、潤滑油とのなじみもよい。

(2) ケルメットは、銀に鉛を加えたもので、軸受合金として使用されている。

(3) アルミニウムは、比重が鉄の約3倍、線膨張係数は鉄の約2倍である。

(4) 黄銅（真ちゅう）は、銅にアルミニウムを加えたもので、加工性に優れている。', 'Trong các phát biểu về kim loại màu dùng trên ô tô, phát biểu nào phù hợp?

(1) Đồng thanh là hợp kim đồng thêm thiếc, chịu mài mòn tốt và tương hợp tốt với dầu bôi trơn.

(2) Kelmet là bạc thêm chì, dùng làm hợp kim ổ trục.

(3) Nhôm có tỷ trọng khoảng 3 lần sắt và hệ số giãn nở dài khoảng 2 lần sắt.

(4) Đồng thau là đồng thêm nhôm, có tính gia công tốt.', NULL, '(1)', '(1) đúng. Kelmet là hợp kim đồng–chì; nhôm có tỷ trọng khoảng 1/3 sắt, còn giãn nở dài khoảng gấp đôi; đồng thau là đồng–kẽm. Điểm dễ nhầm là đảo tỷ trọng và hệ số giãn nở hoặc nhầm thiếc với kẽm.', '[{"term": "非鉄金属", "reading": "ひてつきんぞく", "meaning": "kim loại màu"}, {"term": "青銅", "reading": "せいどう", "meaning": "đồng thanh"}, {"term": "黄銅", "reading": "おうどう", "meaning": "đồng thau"}]'::jsonb, 25);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Management', 26, '図に示す電気回路において、次の文章の［a］に当てはまるものとして、適切なものはどれか。ただし、バッテリ、配線等の抵抗はないものとする。回路における電流計Aが示す電流値は［a］Aである。

(1) 0.5

(2) 1

(3) 1.5

(4) 2

![Hình câu 26](march_q26_hinh.png)', 'Trong mạch điện ở hình, lựa chọn nào điền thích hợp vào ［a］ của câu sau? Giả sử điện trở của ắc quy, dây dẫn và các phần tương tự bằng không. Dòng điện mà ampe kế A trong mạch chỉ là ［a］A.

(1) 0.5

(2) 1

(3) 1.5

(4) 2

Nhãn hình: バッテリ（12 V）: ắc quy 12 V; A: ampe kế; 8 Ω, 6 Ω, 12 Ω: điện trở.', NULL, '(2)', 'Hai điện trở 6 Ω và 12 Ω song song có điện trở tương đương (6 × 12)/(6 + 12) = 4 Ω. Nối tiếp với 8 Ω được 12 Ω. Dòng tổng I = 12 V / 12 Ω = 1 A, chọn (2). Ampe kế nằm trên nhánh chung nên đo dòng tổng, không chỉ dòng qua 6 Ω.', '[{"term": "電流計", "reading": "でんりゅうけい", "meaning": "ampe kế"}, {"term": "抵抗", "reading": "ていこう", "meaning": "điện trở"}, {"term": "配線", "reading": "はいせん", "meaning": "dây dẫn điện"}]'::jsonb, 26);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Management', 27, '鉛バッテリの充電に関する記述として、不適切なものは次のうちどれか。

(1) 急速充電時の最大電流値は、充電しようとするバッテリの定格容量（Ah）の数値にアンペア（A）をつけた値である。

(2) 充電中は、電解液の温度が45℃（急速充電の場合は55℃）を超えないように注意する。

(3) 定電流充電法では、一般に定格容量の1/10程度の電流で充電を行う。

(4) 補充電とは、放電状態にあるバッテリを、短時間でその放電量の幾らかを補うために、大電流（定電流充電の数倍～十倍程度）で充電を行う方法である。', 'Trong các phát biểu về nạp ắc quy chì, phát biểu nào không phù hợp?

(1) Dòng điện cực đại khi nạp nhanh có giá trị bằng số biểu thị dung lượng định mức (Ah) của ắc quy cần nạp, đổi đơn vị thành ampe (A).

(2) Khi nạp, chú ý không để nhiệt độ dung dịch điện phân vượt 45℃ (55℃ khi nạp nhanh).

(3) Phương pháp nạp dòng không đổi thường dùng dòng khoảng 1/10 dung lượng định mức.

(4) Nạp bổ sung là nạp bằng dòng lớn (vài lần đến khoảng mười lần dòng nạp không đổi) trong thời gian ngắn để bù một phần điện lượng đã phóng của ắc quy.', NULL, '(4)', '(4) mô tả nạp nhanh, không phải nạp bổ sung. Nạp bổ sung khôi phục điện lượng thiếu bằng chế độ nạp thích hợp; không đồng nghĩa dòng lớn trong thời gian ngắn. Các số nhiệt độ và tỷ lệ dòng trong lựa chọn là quy tắc của đề; khi thao tác thực tế phải theo loại ắc quy và hướng dẫn thiết bị.', '[{"term": "定格容量", "reading": "ていかくようりょう", "meaning": "dung lượng định mức"}, {"term": "電解液", "reading": "でんかいえき", "meaning": "dung dịch điện phân"}, {"term": "補充電", "reading": "ほじゅうでん", "meaning": "nạp bổ sung"}]'::jsonb, 27);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Management', 28, '「道路運送車両法」に照らし、次の文章の［a］に当てはまるものとして、適切なものはどれか。自動車の使用者は、自動車検査証記録事項について変更があったときは、その事由があった日から［a］以内に、当該変更について、国土交通大臣が行う自動車検査証の変更記録を受けなければならない。

(1) 10日

(2) 15日

(3) 20日

(4) 25日', 'Theo Luật phương tiện giao thông đường bộ, lựa chọn nào điền thích hợp vào ［a］? Khi các thông tin ghi trong giấy chứng nhận kiểm định xe thay đổi, người sử dụng xe phải làm thủ tục ghi nhận thay đổi trên giấy chứng nhận do Bộ trưởng Bộ Đất đai, Hạ tầng, Giao thông và Du lịch thực hiện, trong vòng ［a］ kể từ ngày phát sinh sự việc.

(1) 10 ngày.

(2) 15 ngày.

(3) 20 ngày.

(4) 25 ngày.', NULL, '(2)', 'Thời hạn là 15 ngày, nên chọn (2). Mốc tính là ngày phát sinh lý do thay đổi, không phải ngày người sử dụng bắt đầu làm thủ tục. Phân biệt thay đổi thông tin giấy chứng nhận với chu kỳ kiểm định định kỳ.', '[{"term": "記録事項", "reading": "きろくじこう", "meaning": "thông tin được ghi"}, {"term": "事由", "reading": "じゆう", "meaning": "lý do/sự việc làm căn cứ"}, {"term": "変更記録", "reading": "へんこうきろく", "meaning": "ghi nhận thay đổi"}]'::jsonb, 28);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Management', 29, '「道路運送車両の保安基準」及び「道路運送車両の保安基準の細目を定める告示」に照らし、車幅が1.69 mの四輪の小型自動車の後退灯に関する次の文章の［a］と［b］に当てはまるものとして、下の組み合わせのうち、適切なものはどれか。後退灯は、［a］にその後方［b］mの距離から点灯を確認できるものであり、かつ、その照射光線は、他の交通を妨げないものであること。

| 選択肢 | ［a］ | ［b］ |
| --- | --- | --- |
| (1) | 昼間 | 300 |
| (2) | 夜間 | 300 |
| (3) | 昼間 | 100 |
| (4) | 夜間 | 100 |', 'Theo Tiêu chuẩn an toàn phương tiện giao thông đường bộ và Thông báo quy định chi tiết tiêu chuẩn này, đối với đèn lùi của ô tô nhỏ bốn bánh rộng 1.69 m, tổ hợp nào điền thích hợp vào ［a］ và ［b］? Đèn lùi phải có thể được xác nhận đang sáng từ khoảng cách ［b］m phía sau vào ［a］, và chùm sáng không được cản trở giao thông khác.

| Lựa chọn | ［a］ | ［b］ |
| --- | --- | --- |
| (1) | Ban ngày | 300. |
| (2) | Ban đêm | 300. |
| (3) | Ban ngày | 100. |
| (4) | Ban đêm | 100. |', NULL, '(3)', 'Chọn (3): ban ngày, 100 m. Đây là khả năng nhìn thấy đèn đang sáng từ phía sau, không phải khả năng đèn chiếu sáng vật cản ở 100 m. Điều kiện không gây cản trở giao thông cũng phải giữ trong cách hiểu quy định.', '[{"term": "後退灯", "reading": "こうたいとう", "meaning": "đèn lùi"}, {"term": "照射光線", "reading": "しょうしゃこうせん", "meaning": "chùm tia chiếu sáng"}, {"term": "昼間", "reading": "ちゅうかん", "meaning": "ban ngày"}]'::jsonb, 29);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2025', 'Management', 30, '「道路運送車両法」及び「自動車点検基準」に照らし、1年ごとに定期点検整備をしなければならない自動車として、適切なものは次のうちどれか。

(1) 乗車定員5人の小型乗用自動車のレンタカー

(2) 総排気量2.00 ℓの自動車運送事業用の自動車

(3) 車両総重量9 tの自家用自動車

(4) 自家用乗用自動車', 'Theo Luật phương tiện giao thông đường bộ và Tiêu chuẩn kiểm tra ô tô, xe nào phải kiểm tra, bảo dưỡng định kỳ mỗi năm?

(1) Ô tô con loại nhỏ cho thuê có số chỗ định mức 5 người.

(2) Ô tô dùng kinh doanh vận tải có tổng dung tích xi lanh 2.00 ℓ.

(3) Ô tô sử dụng riêng có tổng trọng lượng xe 9 t.

(4) Ô tô con sử dụng riêng.', NULL, '(4)', 'Chọn (4): ô tô con sử dụng riêng thuộc nhóm kiểm tra định kỳ 1 năm. Xe con cho thuê thường kiểm tra 6 tháng; xe kinh doanh vận tải và xe riêng tổng trọng lượng từ 8 t thuộc nhóm 3 tháng. Đừng nhầm chu kỳ bảo dưỡng kiểm tra với thời hạn hiệu lực kiểm định.', '[{"term": "定期点検整備", "reading": "ていきてんけんせいび", "meaning": "kiểm tra và bảo dưỡng định kỳ"}, {"term": "自家用", "reading": "じかよう", "meaning": "sử dụng riêng"}, {"term": "車両総重量", "reading": "しゃりょうそうじゅうりょう", "meaning": "tổng trọng lượng xe"}]'::jsonb, 30);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 1, 'ピストン・リングに関する記述として、適切なものは次のうちどれか。

(1) アンダ・カット型は、サイド・レールとスペーサ・エキスパンダを組み合わせている。

(2) インナ・ベベル型は、オイルをかき落とす性能に優れているので、一般にトップ・リング又はセカンド・リングに使用されている。

(3) コンプレッション・リングの摩耗・衰損、シリンダの摩耗などがあっても、オイル消費量には影響しない。

(4) バレル・フェース型は、しゅう動面がテーパ状になっているため、シリンダ壁には線接触となってなじみやすい。', 'Trong các phát biểu về xéc-măng pít-tông, phát biểu nào phù hợp?

(1) Loại undercut kết hợp vòng bên và vòng giãn cách.

(2) Loại inner-bevel gạt dầu tốt nên thường dùng làm xéc-măng thứ nhất hoặc thứ hai.

(3) Mòn, hư hỏng xéc-măng khí hoặc mòn xi lanh không ảnh hưởng lượng dầu tiêu hao.

(4) Loại barrel-face có mặt trượt dạng côn nên tiếp xúc đường với thành xi lanh và dễ rà khít.', NULL, '(2)', '(2) đúng. Vòng bên và vòng giãn cách là cấu tạo xéc-măng dầu tổ hợp, không phải undercut. Mòn xéc-măng/xi lanh có thể tăng tiêu hao dầu. Barrel-face có mặt dạng cung tròn, không phải dạng côn.', '[{"term": "摩耗", "reading": "まもう", "meaning": "mài mòn"}, {"term": "オイル消費量", "reading": "おいるしょうひりょう", "meaning": "lượng dầu tiêu hao"}, {"term": "線接触", "reading": "せんせっしょく", "meaning": "tiếp xúc đường"}]'::jsonb, 31);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 2, 'インテーク・マニホールド及びエキゾースト・マニホールドに関する記述として、適切なものは次のうちどれか。

(1) 金属製のインテーク・マニホールドにおいて、シリンダ・ヘッド側の取り付け面のひずみの点検は、ダイヤル・ゲージを用いて行う。

(2) エキゾースト・マニホールドは、サージ・タンクと一体になっているものもある。

(3) インテーク・マニホールドは、吸気抵抗を小さくすることで、各シリンダへ分配する吸入空気の体積効率を高めている。

(4) エキゾースト・マニホールドは、一般にシリンダ・ブロックに取り付けられている。', 'Trong các phát biểu về ống góp nạp và ống góp xả, phát biểu nào phù hợp?

(1) Độ cong vênh mặt lắp phía nắp xi lanh của ống góp nạp kim loại được kiểm tra bằng đồng hồ so.

(2) Một số ống góp xả liền với bình tích khí nạp.

(3) Ống góp nạp giảm sức cản nạp để nâng hiệu suất thể tích của không khí phân phối đến từng xi lanh.

(4) Ống góp xả thường được lắp vào thân xi lanh.', NULL, '(3)', '(3) đúng. Độ phẳng mặt lắp thường kiểm tra bằng thước thẳng và căn lá. Bình tích khí thuộc phía nạp; ống góp xả gắn vào nắp xi lanh. Đừng nhầm シリンダ・ヘッド với シリンダ・ブロック.', '[{"term": "ひずみ", "reading": "ひずみ", "meaning": "biến dạng/cong vênh"}, {"term": "吸気抵抗", "reading": "きゅうきていこう", "meaning": "sức cản nạp"}, {"term": "体積効率", "reading": "たいせきこうりつ", "meaning": "hiệu suất thể tích"}]'::jsonb, 32);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 3, '中心電極の碍子脚部が標準熱価型と比較して短いスパーク・プラグに関する記述として、適切なものは次のうちどれか。

(1) 冷え型と呼ばれる。

(2) ホット・タイプと呼ばれる。

(3) 放熱しにくく電極部が焼けやすい。

(4) 低熱価型と呼ばれる。', 'Về bugi có chân sứ điện cực trung tâm ngắn hơn loại trị số nhiệt tiêu chuẩn, phát biểu nào phù hợp?

(1) Được gọi là loại lạnh.

(2) Được gọi là loại nóng (hot type).

(3) Khó tản nhiệt và phần điện cực dễ bị nung nóng.

(4) Được gọi là loại trị số nhiệt thấp.', NULL, '(1)', 'Chân sứ ngắn rút ngắn đường thoát nhiệt, tản nhiệt tốt hơn, nên đây là bugi lạnh, trị số nhiệt cao: (1). Chân sứ dài là bugi nóng, trị số nhiệt thấp. Không đồng nhất trị số nhiệt với nhiệt độ hoạt động.', '[{"term": "冷え型", "reading": "ひえがた", "meaning": "loại lạnh"}, {"term": "標準熱価型", "reading": "ひょうじゅんねつかがた", "meaning": "loại trị số nhiệt tiêu chuẩn"}, {"term": "放熱", "reading": "ほうねつ", "meaning": "tản nhiệt"}]'::jsonb, 33);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 4, 'フライホイールの振れを測定するときに用いられるものとして、適切なものは次のうちどれか。

(1) プラスチ・ゲージ

(2) コンプレッション・ゲージ

(3) シックネス・ゲージ

(4) ダイヤル・ゲージ', 'Dụng cụ nào thích hợp để đo độ đảo bánh đà?

(1) Dây đo khe hở Plastigage.

(2) Đồng hồ đo áp suất nén.

(3) Căn lá.

(4) Đồng hồ so.', NULL, '(4)', 'Chọn (4): đặt đầu đo đồng hồ so vào bề mặt cần kiểm tra và quay bánh đà để đọc biến thiên. Plastigage đo khe hở ổ trục; đồng hồ nén đo áp suất; căn lá đo khe hở. Độ đảo là biến thiên khi quay, khác với một khe hở tĩnh.', '[{"term": "振れ", "reading": "ふれ", "meaning": "độ đảo"}, {"term": "測定", "reading": "そくてい", "meaning": "đo"}, {"term": "ダイヤル・ゲージ", "reading": "だいやる・げーじ", "meaning": "đồng hồ so"}]'::jsonb, 34);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 5, '水冷・加圧式の冷却装置に関する記述として、不適切なものは次のうちどれか。

(1) プレッシャ型ラジエータ・キャップは、ラジエータ内の圧力を調整する。

(2) 冷却水は、不凍液の混合率が60%のとき、凍結温度が最も低い。

(3) シュラウドは、ラジエータを通過した全ての空気をファンによって吸い込めるようにしている。

(4) 不凍液の主成分はエチレン・グリコールであり、酸化による劣化はない。', 'Trong các phát biểu về hệ thống làm mát bằng nước có áp suất, phát biểu nào không phù hợp?

(1) Nắp két nước kiểu áp suất điều chỉnh áp suất trong két.

(2) Nước làm mát có nhiệt độ đông đặc thấp nhất khi tỷ lệ chất chống đông là 60%.

(3) Chụp quạt giúp quạt hút toàn bộ không khí đã đi qua két nước.

(4) Thành phần chính của chất chống đông là ethylene glycol, không bị suy giảm do oxy hóa.', NULL, '(4)', '(4) sai: ethylene glycol và phụ gia có thể suy giảm trong quá trình sử dụng, kể cả do oxy hóa; cần thay đúng kỳ hạn. Tỷ lệ khoảng 60% là đặc tính hỗn hợp chống đông được đề sử dụng, không phải yêu cầu pha cho mọi sản phẩm. Nắp áp suất và chụp quạt có chức năng khác nhau.', '[{"term": "不凍液", "reading": "ふとうえき", "meaning": "chất chống đông"}, {"term": "酸化", "reading": "さんか", "meaning": "oxy hóa"}, {"term": "劣化", "reading": "れっか", "meaning": "suy giảm phẩm chất"}]'::jsonb, 35);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 6, 'トロコイド式オイル・ポンプに関する記述として、適切なものは次のうちどれか。

(1) インナ・ロータ及びアウタ・ロータは、それぞれのマーク面を上側に向けてタイミング・チェーン・カバー（オイル・ポンプ・ボデー）に組み付ける。

(2) インナ・ロータが回転すると、アウタ・ロータはインナ・ロータとは逆方向に回転する。

(3) チップ・クリアランスの測定は、プラスチ・ゲージを用いて行う。

(4) ボデー・クリアランスとは、ロータとオイル・ポンプ・カバー取り付け面との隙間をいう。', 'Trong các phát biểu về bơm dầu trochoid, phát biểu nào phù hợp?

(1) Lắp rôto trong và rôto ngoài vào nắp xích cam (thân bơm dầu) với mặt đánh dấu của mỗi rôto hướng lên trên.

(2) Khi rôto trong quay, rôto ngoài quay ngược chiều rôto trong.

(3) Khe hở đỉnh được đo bằng Plastigage.

(4) Khe hở thân là khe giữa rôto và mặt lắp nắp bơm dầu.', NULL, '(1)', '(1) là hướng lắp theo mô tả trong đề. Hai rôto quay cùng chiều; khe đỉnh đo bằng căn lá; khe giữa rôto và mặt nắp là khe bên. Khe thân là khe giữa rôto ngoài và thân bơm. Khi bảo dưỡng cần đối chiếu dấu lắp đúng mẫu bơm.', '[{"term": "組み付ける", "reading": "くみつける", "meaning": "lắp vào"}, {"term": "隙間", "reading": "すきま", "meaning": "khe hở"}, {"term": "逆方向", "reading": "ぎゃくほうこう", "meaning": "chiều ngược lại"}]'::jsonb, 36);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 7, '図に示す排気ガスの三元触媒の浄化特性において、［a］と［b］に当てはまるものとして、下の組み合わせのうち、適切なものはどれか。

| 選択肢 | ［a］ | ［b］ |
| --- | --- | --- |
| (1) | H₂O | HC |
| (2) | O₂ | NOₓ |
| (3) | NOₓ | HC |
| (4) | N₂ | NOₓ |

![Hình câu 7](october_q07_hinh.png)', 'Trong đồ thị đặc tính làm sạch khí xả của bộ xúc tác ba thành phần, tổ hợp nào phù hợp cho ［a］ và ［b］?

| Lựa chọn | ［a］ | ［b］ |
| --- | --- | --- |
| (1) | H₂O | HC. |
| (2) | O₂ | NOₓ. |
| (3) | NOₓ | HC. |
| (4) | N₂ | NOₓ. |

Nhãn hình: 浄化率（%）: tỷ lệ làm sạch (%); 空燃比: tỷ lệ không khí–nhiên liệu; 小さい（濃い）: nhỏ (đậm); 大きい（薄い）: lớn (nghèo); 理論空燃比: tỷ lệ lý thuyết; 制御範囲: phạm vi điều khiển; （イ）=［a］, （ロ）=［b］; CO: cacbon monoxit.', NULL, '(3)', 'Chọn (3). Đường ［a］ giảm mạnh khi hỗn hợp nghèo là NOₓ: quá nhiều oxy cản trở phản ứng khử. Đường ［b］ tăng khi hỗn hợp chuyển từ đậm sang nghèo là HC được oxy hóa. CO cũng cần oxy; cả ba đạt hiệu quả đồng thời gần tỷ lệ lý thuyết. H₂O và N₂ là sản phẩm, không phải chất ô nhiễm cần loại ở đây.', '[{"term": "三元触媒", "reading": "さんげんしょくばい", "meaning": "xúc tác ba thành phần"}, {"term": "浄化率", "reading": "じょうかりつ", "meaning": "tỷ lệ làm sạch"}, {"term": "理論空燃比", "reading": "りろんくうねんぴ", "meaning": "tỷ lệ không khí–nhiên liệu lý thuyết"}]'::jsonb, 37);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 8, 'ブローバイ・ガス還元装置（クローズド・タイプ）に関する次の文章の［a］と［b］に当てはまるものとして、下の組み合わせのうち、適切なものはどれか。ただし、参考として図に示すPCVバルブの状態は、エンジン停止時を表す。エンジンの高負荷時は、軽負荷時と比較してインテーク・マニホールドの負圧が［a］、PCVバルブのブローバイ・ガスの通過面積は［b］する。

| 選択肢 | ［a］ | ［b］ |
| --- | --- | --- |
| (1) | 低く（小さく） | 減少 |
| (2) | 低く（小さく） | 増大 |
| (3) | 高く（大きく） | 減少 |
| (4) | 高く（大きく） | 増大 |

![Hình câu 8](october_q08_hinh.png)', 'Về hệ thống đưa khí lọt cácte trở lại đường nạp (kiểu kín), tổ hợp nào điền thích hợp vào ［a］ và ［b］? Hình van PCV được đưa để tham khảo thể hiện trạng thái khi động cơ dừng. Khi tải cao so với tải nhẹ, độ chân không trong ống góp nạp ［a］ và diện tích cho khí lọt cácte đi qua van PCV ［b］.

| Lựa chọn | ［a］ | ［b］ |
| --- | --- | --- |
| (1) | Thấp hơn (nhỏ hơn) | giảm. |
| (2) | Thấp hơn (nhỏ hơn) | tăng. |
| (3) | Cao hơn (lớn hơn) | giảm. |
| (4) | Cao hơn (lớn hơn) | tăng. |

Nhãn hình: Hình cắt van PCV: trạng thái khi động cơ dừng; không có nhãn bộ phận trong hình gốc.', NULL, '(2)', 'Chọn (2): tải cao làm bướm ga mở hơn, độ chân không nhỏ hơn; van PCV tăng diện tích thông để xử lý lượng khí lọt lớn hơn. Tải nhẹ có độ chân không lớn, van hạn chế tiết diện. Hình là trạng thái dừng, không được coi là trạng thái tải cao.', '[{"term": "負圧", "reading": "ふあつ", "meaning": "áp suất âm/độ chân không"}, {"term": "軽負荷", "reading": "けいふか", "meaning": "tải nhẹ"}, {"term": "通過面積", "reading": "つうかめんせき", "meaning": "diện tích thông qua"}]'::jsonb, 38);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 9, 'フライホイール及びリング・ギヤに関する記述として、適切なものは次のうちどれか。

(1) リング・ギヤには、一般に炭素鋼製のスパイラル・ベベル・ギヤが用いられる。

(2) リング・ギヤは、フライホイールの外周にボルトで固定されている。

(3) フライホイールは、一般にアルミニウム合金製で、クランクシャフトの後端部に取り付けられている。

(4) フライホイールは、クランクシャフトからクラッチへ動力を伝達する役目がある。', 'Trong các phát biểu về bánh đà và vành răng, phát biểu nào phù hợp?

(1) Vành răng thường là bánh răng côn xoắn bằng thép cacbon.

(2) Vành răng được bắt bu lông ở chu vi ngoài bánh đà.

(3) Bánh đà thường bằng hợp kim nhôm và lắp ở đầu sau trục khuỷu.

(4) Bánh đà truyền công suất từ trục khuỷu đến ly hợp.', NULL, '(4)', '(4) đúng. Vành răng là bánh răng trụ răng thẳng, thường lắp co nhiệt. Bánh đà thông thường làm bằng gang hoặc thép, không phải nhôm như khẳng định (3), dù vị trí đầu sau là đúng. Một lựa chọn có một vế đúng vẫn có thể sai toàn bộ.', '[{"term": "動力", "reading": "どうりょく", "meaning": "công suất/động lực"}, {"term": "後端部", "reading": "こうたんぶ", "meaning": "phần đầu sau"}, {"term": "クラッチ", "reading": "くらっち", "meaning": "ly hợp"}]'::jsonb, 39);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 10, '図に示すブラシ型オルタネータに用いられているロータのAの名称として、適切なものは次のうちどれか。

(1) スリップ・リング

(2) シャフト

(3) ロータ・コイル

(4) ロータ・コア

![Hình câu 10](october_q10_hinh.png)', 'Trong hình rôto dùng cho máy phát có chổi than, tên phù hợp của bộ phận A là gì?

(1) Vành trượt.

(2) Trục.

(3) Cuộn rôto.

(4) Lõi rôto.

Nhãn hình: A: ký hiệu bộ phận rôto cần nhận diện.', NULL, '(4)', 'Mũi tên A chỉ lõi rôto dạng móng cực, chọn (4). Cuộn kích từ nằm trong lõi; vành trượt ở đầu trục để cấp dòng qua chổi than. Phải đọc điểm kết thúc mũi tên, không chọn theo bộ phận lớn nhất của hình.', '[{"term": "ロータ・コア", "reading": "ろーた・こあ", "meaning": "lõi rôto"}, {"term": "スリップ・リング", "reading": "すりっぷ・りんぐ", "meaning": "vành trượt"}, {"term": "ブラシ", "reading": "ぶらし", "meaning": "chổi than"}]'::jsonb, 40);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 11, '点火順序が1－3－4－2の4サイクル直列4シリンダ・エンジンの第2シリンダが圧縮行程の上死点にあり、この状態からクランクシャフトを回転方向に540°回したとき、吸入行程の下死点にあるシリンダとして、適切なものは次のうちどれか。

(1) 第1シリンダ

(2) 第2シリンダ

(3) 第3シリンダ

(4) 第4シリンダ', 'Trong động cơ 4 kỳ, 4 xi lanh thẳng hàng, thứ tự đánh lửa 1－3－4－2, xi lanh 2 ở điểm chết trên cuối kỳ nén. Từ đây quay trục khuỷu theo chiều quay 540°; xi lanh nào ở điểm chết dưới của kỳ nạp?

(1) Xi lanh số 1.

(2) Xi lanh số 2.

(3) Xi lanh số 3.

(4) Xi lanh số 4.', NULL, '(2)', 'Xi lanh 2 bắt đầu cháy ở 0°; sau 180° kết thúc giãn nở, 360° kết thúc xả, 540° kết thúc nạp tại điểm chết dưới. Chọn (2). Bài này không cần suy từ các xi lanh khác nếu theo dõi đúng chu trình của xi lanh 2.', '[{"term": "圧縮行程", "reading": "あっしゅくこうてい", "meaning": "kỳ nén"}, {"term": "吸入行程", "reading": "きゅうにゅうこうてい", "meaning": "kỳ nạp"}, {"term": "回転方向", "reading": "かいてんほうこう", "meaning": "chiều quay"}]'::jsonb, 41);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 12, 'レシプロ・エンジンのバルブ機構に関する記述として、適切なものは次のうちどれか。

(1) バルブ・スプリングには、高速時の異常振動などを防ぐため、シリンダ・ヘッド側のピッチを狭くした不等ピッチのスプリングが用いられている。

(2) カムシャフト・タイミング・スプロケットの回転速度は、クランクシャフト・タイミング・スプロケットの2倍である。

(3) カムシャフトのカムの形状は卵形状で、カムの長径をカム・リフトという。

(4) エキゾースト・バルブのバルブ・ヘッドの外径は、一般に排気効率を向上させるため、インテーク・バルブより大きい。', 'Trong các phát biểu về cơ cấu xupáp của động cơ pít-tông tịnh tiến, phát biểu nào phù hợp?

(1) Để ngăn rung bất thường ở tốc độ cao, lò xo xupáp dùng bước không đều với bước phía nắp xi lanh hẹp hơn.

(2) Tốc độ đĩa xích dẫn động trục cam gấp 2 lần tốc độ đĩa xích dẫn động trục khuỷu.

(3) Cam trên trục cam có dạng quả trứng; đường kính dài của cam gọi là độ nâng cam.

(4) Đường kính ngoài nấm xupáp xả thường lớn hơn xupáp nạp để nâng hiệu quả xả.', NULL, '(1)', '(1) đúng: bố trí bước không đều giúp hạn chế cộng hưởng lò xo. Trục cam quay bằng 1/2 trục khuỷu; độ nâng cam không phải đường kính dài; nấm xupáp nạp thường lớn hơn nấm xupáp xả. Câu này đảo “rộng” thành “hẹp” so với đề tháng 3.', '[{"term": "ピッチ", "reading": "ぴっち", "meaning": "bước xoắn"}, {"term": "異常振動", "reading": "いじょうしんどう", "meaning": "rung bất thường"}, {"term": "カム・リフト", "reading": "かむ・りふと", "meaning": "độ nâng cam"}]'::jsonb, 42);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 13, 'ワックス・ペレット型サーモスタットに関する記述として、適切なものは次のうちどれか。

(1) 冷却水温度が低いときは、バルブ・スプリングのばね力によってバルブは開いている。

(2) サーモスタットは、冷却水の循環経路に設けられ、ラジエータへ流れる冷却水の流量を制御して温度を調節している。

(3) 冷却水の循環系統内に残留している空気がないとき、ジグル・バルブは浮力と水圧により開いている。

(4) 冷却水温度が低くなると、ペレット内の固体のワックスが液体となって膨張する。', 'Trong các phát biểu về van hằng nhiệt kiểu viên sáp, phát biểu nào phù hợp?

(1) Khi nước làm mát lạnh, lực lò xo xupáp giữ van mở.

(2) Van hằng nhiệt đặt trên đường tuần hoàn nước làm mát, điều chỉnh nhiệt độ bằng cách điều khiển lưu lượng nước đến két.

(3) Khi không còn không khí trong hệ tuần hoàn, van jiggle mở do lực nổi và áp lực nước.

(4) Khi nước làm mát lạnh đi, sáp rắn trong viên chuyển thành lỏng và giãn nở.', NULL, '(2)', '(2) đúng. Khi lạnh, van chính đóng; khi nóng, sáp hóa lỏng và giãn nở để mở van. Van jiggle đóng khi không còn khí. Các lựa chọn sai đảo trạng thái mở/đóng hoặc đảo chiều biến đổi nhiệt.', '[{"term": "循環経路", "reading": "じゅんかんけいろ", "meaning": "đường tuần hoàn"}, {"term": "流量", "reading": "りゅうりょう", "meaning": "lưu lượng"}, {"term": "膨張", "reading": "ぼうちょう", "meaning": "giãn nở"}]'::jsonb, 43);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 14, '燃料装置に関する記述として、不適切なものは次のうちどれか。

(1) くら型のフューエル・タンクでは、ジェット・ポンプによりサブ室からメーン室に燃料を移送している。

(2) インジェクタのソレノイド・コイルに電流が流れると、ニードル・バルブが全開位置に移動し、燃料が噴射される。

(3) フューエル・タンク本体には、タンク内が負圧になり破損するのを防止するために、負圧弁を設けている。

(4) チャコール・キャニスタは、燃料蒸発ガスが大気中に放出されるのを防止している。', 'Trong các phát biểu về hệ thống nhiên liệu, phát biểu nào không phù hợp?

(1) Ở bình nhiên liệu dạng yên ngựa, bơm tia chuyển nhiên liệu từ khoang phụ sang khoang chính.

(2) Khi dòng chạy qua cuộn solenoid của kim phun, van kim chuyển đến vị trí mở hoàn toàn và nhiên liệu được phun.

(3) Van chân không được đặt trên thân bình nhiên liệu để ngăn bình hỏng do áp suất âm bên trong.

(4) Bình than hoạt tính ngăn hơi nhiên liệu thoát ra khí quyển.', NULL, '(3)', '(3) sai ở vị trí lắp trong cấu tạo được đề dùng: van chân không bố trí ở nắp bình, không phải thân bình. Van cho không khí vào khi áp suất trong bình giảm. Chức năng chống áp suất âm là đúng nhưng vị trí nêu trong lựa chọn sai.', '[{"term": "負圧弁", "reading": "ふあつべん", "meaning": "van chân không"}, {"term": "破損", "reading": "はそん", "meaning": "hư hỏng"}, {"term": "燃料蒸発ガス", "reading": "ねんりょうじょうはつがす", "meaning": "hơi nhiên liệu bay hơi"}]'::jsonb, 44);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 15, '電子制御装置に用いられるセンサに関する記述として、適切なものは次のうちどれか。

(1) 水温センサのサーミスタ（負特性）は、冷却水温度が低いときほど抵抗値は低く（小さく）なる。

(2) 吸気温センサは、エンジンに吸入される空気の温度と空燃比の状態を検出している。

(3) バキューム・センサの圧力信号の電圧特性は、圧力が真空から大気圧に近付くほど出力電圧が小さくなる。

(4) 空燃比センサの出力特性は、リーン（薄い）になるほど、空燃比センサ出力は高くなる。', 'Trong các phát biểu về cảm biến dùng trong hệ thống điều khiển điện tử, phát biểu nào phù hợp?

(1) Nhiệt điện trở hệ số âm của cảm biến nhiệt độ nước có điện trở thấp hơn (nhỏ hơn) khi nước càng lạnh.

(2) Cảm biến nhiệt độ khí nạp phát hiện nhiệt độ khí vào động cơ và tình trạng tỷ lệ không khí–nhiên liệu.

(3) Đặc tính tín hiệu cảm biến chân không là áp suất càng gần áp suất khí quyển từ chân không thì điện áp ra càng nhỏ.

(4) Đặc tính đầu ra của cảm biến tỷ lệ không khí–nhiên liệu là hỗn hợp càng nghèo thì tín hiệu cảm biến càng cao.', NULL, '(4)', '(4) đúng theo đặc tính cảm biến A/F trong đề. Nhiệt điện trở hệ số âm có điện trở giảm khi nhiệt độ tăng; cảm biến khí nạp đo nhiệt độ; cảm biến áp suất có điện áp tăng khi áp suất tăng. Không nhầm cảm biến A/F với điện áp cảm biến oxy dải hẹp.', '[{"term": "抵抗値", "reading": "ていこうち", "meaning": "giá trị điện trở"}, {"term": "負特性", "reading": "ふとくせい", "meaning": "đặc tính hệ số âm"}, {"term": "空燃比", "reading": "くうねんぴ", "meaning": "tỷ lệ không khí–nhiên liệu"}]'::jsonb, 45);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 16, 'スタータの作動に関する次の文章の［a］に当てはまるものとして、適切なものはどれか。スタータ・スイッチをONにし、プランジャが吸引されメーン接点が閉じた後、［a］の磁力による吸引力だけでプランジャは保持されている。

(1) フィールド・コイル

(2) アーマチュア・コイル

(3) プルイン・コイル

(4) ホールディング・コイル', 'Trong câu mô tả hoạt động máy khởi động, lựa chọn nào điền thích hợp vào ［a］? Sau khi bật công tắc khởi động ON, pít-tông từ được hút và tiếp điểm chính đóng, pít-tông từ được giữ chỉ bằng lực hút từ của ［a］.

(1) Cuộn kích từ.

(2) Cuộn phần ứng.

(3) Cuộn hút.

(4) Cuộn giữ.', NULL, '(4)', 'Chọn (4). Lúc đầu cuộn hút và cuộn giữ cùng tạo lực; khi tiếp điểm chính đóng, hai đầu cuộn hút có điện thế gần bằng nhau nên không còn dòng hữu hiệu qua cuộn hút. Cuộn giữ tiếp tục giữ pít-tông từ. Phải xét trạng thái sau khi tiếp điểm đóng.', '[{"term": "メーン接点", "reading": "めーんせってん", "meaning": "tiếp điểm chính"}, {"term": "吸引力", "reading": "きゅういんりょく", "meaning": "lực hút"}, {"term": "保持", "reading": "ほじ", "meaning": "giữ"}]'::jsonb, 46);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 17, 'リダクション式スタータに関する記述として、適切なものは次のうちどれか。

(1) オーバランニング・クラッチは、アーマチュアがエンジンの回転によって逆に駆動され、オーバランすることによるスタータの破損を防止している。

(2) アーマチュアの回転速度より、ピニオン・ギヤの回転速度の方が速い。

(3) 減速ギヤ部によって、駆動トルクを減少させてピニオン・ギヤに伝えている。

(4) モータのフィールドは、ヨーク、ポール・コア（鉄心）、アーマチュア・コアなどで構成されている。', 'Trong các phát biểu về máy khởi động giảm tốc, phát biểu nào phù hợp?

(1) Ly hợp vượt tốc ngăn máy khởi động hư hỏng do phần ứng bị động cơ dẫn động ngược trở lại và quay quá tốc độ.

(2) Bánh răng nhỏ quay nhanh hơn phần ứng.

(3) Cụm bánh răng giảm tốc làm giảm mômen rồi truyền đến bánh răng nhỏ.

(4) Phần tạo từ trường của mô tơ gồm gông từ, lõi cực (lõi sắt), lõi phần ứng và các bộ phận tương tự.', NULL, '(1)', '(1) đúng. Bộ giảm tốc làm bánh răng nhỏ quay chậm hơn nhưng có mômen lớn hơn phần ứng. Lõi phần ứng thuộc phần quay, không phải bộ phận field; field gồm gông, cực từ và cuộn kích từ hoặc nam châm. “Dẫn động ngược” nói chiều truyền công suất, không nhất thiết chiều quay đảo.', '[{"term": "鉄心", "reading": "てっしん", "meaning": "lõi sắt"}, {"term": "破損", "reading": "はそん", "meaning": "hư hỏng"}, {"term": "ヨーク", "reading": "よーく", "meaning": "gông từ"}]'::jsonb, 47);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 18, '図に示すNPN型トランジスタに関する次の文章の［a］と［b］に当てはまるものとして、下の組み合わせのうち、適切なものはどれか。ベース電流は［a］に流れ、コレクタ電流は［b］に流れる。

| 選択肢 | ［a］ | ［b］ |
| --- | --- | --- |
| (1) | BからE | CからE |
| (2) | BからC | CからE |
| (3) | CからB | BからE |
| (4) | CからE | BからE |

![Hình câu 18](october_q18_hinh.png)', 'Về transistor NPN trong hình, tổ hợp nào điền thích hợp vào ［a］ và ［b］? Dòng bazơ chạy ［a］, dòng colectơ chạy ［b］.

| Lựa chọn | ［a］ | ［b］ |
| --- | --- | --- |
| (1) | Từ B đến E | từ C đến E. |
| (2) | Từ B đến C | từ C đến E. |
| (3) | Từ C đến B | từ B đến E. |
| (4) | Từ C đến E | từ B đến E. |

Nhãn hình: B: bazơ; C: colectơ; E: emitơ. Mũi tên là chiều dòng điện quy ước ở emitơ.', NULL, '(1)', 'Chọn (1): với NPN hoạt động bình thường, dòng điện quy ước vào B và C, ra E. Dòng E bằng tổng dòng B và C. B là bazơ, C là colectơ, E là emitơ; chiều electron ngược chiều dòng điện quy ước, không dùng để chọn đáp án này.', '[{"term": "ベース電流", "reading": "べーすでんりゅう", "meaning": "dòng bazơ"}, {"term": "コレクタ電流", "reading": "これくたでんりゅう", "meaning": "dòng colectơ"}, {"term": "トランジスタ", "reading": "とらんじすた", "meaning": "transistor"}]'::jsonb, 48);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 19, 'ブラシ型オルタネータ（IC式ボルテージ・レギュレータ内蔵）に関する記述として、不適切なものは次のうちどれか。

(1) オルタネータは、ロータ、ステータ、ダイオードなどで構成されている。

(2) ステータ・コイルに発生する誘導起電力の大きさは、ステータ・コイルの巻き数が多いほど大きくなる。

(3) ステータ・コアの内にはスロット（溝）が設けられており、ここにロータ・コイルが巻かれている。

(4) ロータ・コアは、スリップ・リングを通してロータ・コイルに電流を流すことによって磁化される。', 'Trong các phát biểu về máy phát xoay chiều có chổi than (tích hợp bộ điều áp IC), phát biểu nào không phù hợp?

(1) Máy phát gồm rôto, stato, điốt và các bộ phận khác.

(2) Suất điện động cảm ứng trong cuộn stato lớn hơn khi số vòng quấn cuộn stato nhiều hơn.

(3) Trong lõi stato có rãnh, cuộn rôto được quấn trong các rãnh này.

(4) Lõi rôto được từ hóa bằng dòng qua cuộn rôto thông qua vành trượt.', NULL, '(3)', '(3) sai: trong rãnh stato là cuộn stato, không phải cuộn rôto. Rôto tạo từ trường quay; cuộn stato sinh điện xoay chiều; điốt chỉnh lưu. Tên cuộn dây phải khớp bộ phận mang nó.', '[{"term": "溝", "reading": "みぞ", "meaning": "rãnh"}, {"term": "ステータ・コイル", "reading": "すてーた・こいる", "meaning": "cuộn stato"}, {"term": "内蔵", "reading": "ないぞう", "meaning": "tích hợp bên trong"}]'::jsonb, 49);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Technology', 20, '半導体に関する記述として、適切なものは次のうちどれか。

(1) 真性半導体は、シリコンやゲルマニウムに他の原子をごく少量加えたものである。

(2) フォト・ダイオードは、光信号から電気信号への変換などに用いられている。

(3) ダイオードは、直流を交流に変換する整流回路などに使われている。

(4) P型半導体は、自由電子が多くあるようにつくられた不純物半導体である。', 'Trong các phát biểu về chất bán dẫn, phát biểu nào phù hợp?

(1) Bán dẫn nội tại là silic hoặc germani được thêm một lượng rất nhỏ nguyên tử khác.

(2) Điốt quang được dùng để chuyển tín hiệu ánh sáng thành tín hiệu điện và các mục đích tương tự.

(3) Điốt dùng trong mạch chỉnh lưu để biến dòng một chiều thành xoay chiều.

(4) Bán dẫn loại P được pha tạp để có nhiều electron tự do.', NULL, '(2)', '(2) đúng: điốt quang chuyển đổi ánh sáng thành tín hiệu điện. Bán dẫn nội tại là tinh khiết; chỉnh lưu chuyển xoay chiều thành một chiều; loại P có lỗ trống là hạt tải đa số. Phân biệt điốt quang thu ánh sáng với LED phát ánh sáng.', '[{"term": "光信号", "reading": "ひかりしんごう", "meaning": "tín hiệu ánh sáng"}, {"term": "変換", "reading": "へんかん", "meaning": "chuyển đổi"}, {"term": "不純物半導体", "reading": "ふじゅんぶつはんどうたい", "meaning": "bán dẫn pha tạp"}]'::jsonb, 50);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Strategy', 21, 'ドライバの種類と構造・機能に関する記述として、不適切なものは次のうちどれか。

(1) 角軸形の外観は普通形と同じであるが、軸が柄の中を貫通しているため頑丈である。

(2) 普通形は、軸が柄の途中まで入っており、柄は一般に木やプラスチックなどで作られている。

(3) ショック・ドライバは、ねじなどを、衝撃を与えながら緩めるときに用いるものである。

(4) スタッビ形は、短いドライバで、柄が太く強い力を与えることができる。', 'Trong các phát biểu về loại, cấu tạo và chức năng của tua vít, phát biểu nào không phù hợp?

(1) Loại trục vuông có ngoại hình như loại thông thường nhưng bền chắc vì trục xuyên suốt cán.

(2) Loại thông thường có trục cắm một phần vào cán, cán thường làm bằng gỗ hoặc nhựa.

(3) Tua vít đóng dùng để nới vít và các chi tiết tương tự bằng tác động va đập.

(4) Loại stubby là tua vít ngắn, cán to, có thể tác dụng lực lớn.', NULL, '(1)', '(1) nhầm loại trục vuông với loại xuyên cán. Trục vuông cho phép dùng cờ lê tác dụng mômen lên trục; đặc điểm xuyên qua cán thuộc tua vít xuyên cán. Tua vít đóng dùng va đập, loại ngắn thích hợp không gian hẹp.', '[{"term": "角軸形", "reading": "かくじくがた", "meaning": "loại trục vuông"}, {"term": "柄", "reading": "え", "meaning": "cán"}, {"term": "貫通", "reading": "かんつう", "meaning": "xuyên suốt"}]'::jsonb, 51);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 22, '図に示す電気回路において、ランプを図のように接続したときの電気抵抗が3 Ωである場合、ランプの消費電力として、適切なものは次のうちどれか。ただし、バッテリ、配線等の抵抗はないものとする。

(1) 24 W

(2) 36 W

(3) 48 W

(4) 72 W

![Hình câu 22](october_q22_hinh.png)', 'Trong mạch điện ở hình, khi điện trở của đèn được nối như hình là 3 Ω, công suất tiêu thụ của đèn là bao nhiêu? Giả sử điện trở của ắc quy, dây dẫn và các phần tương tự bằng không.

(1) 24 W

(2) 36 W

(3) 48 W

(4) 72 W

Nhãn hình: ランプ: đèn; バッテリ（12 V）: ắc quy 12 V.', NULL, '(3)', 'Đèn được đặt trực tiếp vào nguồn 12 V. P = V²/R = 12²/3 = 48 W, chọn (3). Có thể kiểm tra I = 12/3 = 4 A và P = VI = 48 W. Không dùng P = VR vì sai công thức và đơn vị.', '[{"term": "消費電力", "reading": "しょうひでんりょく", "meaning": "công suất tiêu thụ"}, {"term": "電気抵抗", "reading": "でんきていこう", "meaning": "điện trở"}, {"term": "ランプ", "reading": "らんぷ", "meaning": "đèn"}]'::jsonb, 52);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 23, 'ガソリンに関する記述として、不適切なものは次のうちどれか。

(1) 単位量（1 kg）の燃料が完全燃焼をするときに発生する熱量を、その燃料の発熱量という。

(2) 主成分は炭化水素である。

(3) オクタン価91のものより100のものの方がノッキングを起こしやすい。

(4) 完全燃焼すると炭酸ガスと水が発生する。', 'Trong các phát biểu về xăng, phát biểu nào không phù hợp?

(1) Nhiệt lượng sinh ra khi một đơn vị lượng nhiên liệu (1 kg) cháy hoàn toàn được gọi là nhiệt trị của nhiên liệu đó.

(2) Thành phần chính là hydrocarbon.

(3) Xăng có trị số octan 100 dễ gây kích nổ hơn loại octan 91.

(4) Khi cháy hoàn toàn, sinh ra khí cacbonic và nước.', NULL, '(3)', '(3) sai: trị số octan cao thể hiện khả năng chống kích nổ tốt hơn. Octan 100 ít có xu hướng kích nổ hơn octan 91 trong điều kiện so sánh tương đương. Trị số octan không trực tiếp biểu thị nhiệt trị hoặc bảo đảm tăng công suất cho mọi động cơ.', '[{"term": "完全燃焼", "reading": "かんぜんねんしょう", "meaning": "cháy hoàn toàn"}, {"term": "炭化水素", "reading": "たんかすいそ", "meaning": "hydrocarbon"}, {"term": "オクタン価", "reading": "おくたんか", "meaning": "trị số octan"}]'::jsonb, 53);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 24, '次に示す諸元のエンジンの総排気量について、適切なものは次のうちどれか。

・燃焼室容積：55 cm³

・圧縮比：9

・シリンダ数：4

(1) 670 cm³

(2) 1,240 cm³

(3) 1,760 cm³

(4) 2,080 cm³', 'Với các thông số động cơ dưới đây, tổng dung tích xi lanh nào phù hợp?

• Thể tích buồng cháy: 55 cm³

• Tỷ số nén: 9

• Số xi lanh: 4

(1) 670 cm³

(2) 1,240 cm³

(3) 1,760 cm³

(4) 2,080 cm³', NULL, '(3)', 'Thông số gốc: 燃焼室容積：55 cm³（thể tích buồng cháy: 55 cm³）; 圧縮比：9（tỷ số nén: 9）; シリンダ数：4（số xi lanh: 4）. Tỷ số nén ε = (Vs + Vc)/Vc, nên dung tích công tác mỗi xi lanh Vs = (9 − 1) × 55 = 440 cm³. Tổng = 440 × 4 = 1,760 cm³, chọn (3). Không lấy 9 × 55 vì kết quả đó gồm cả buồng cháy.', '[{"term": "諸元", "reading": "しょげん", "meaning": "thông số kỹ thuật"}, {"term": "燃焼室容積", "reading": "ねんしょうしつようせき", "meaning": "thể tích buồng cháy"}, {"term": "総排気量", "reading": "そうはいきりょう", "meaning": "tổng dung tích xi lanh"}]'::jsonb, 54);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 25, '鉛バッテリに関する次の文章の［a］と［b］に当てはまるものとして、下の組み合わせのうち、適切なものはどれか。電解液は、バッテリが完全充電状態のとき、液温［a］に換算して、一般に比重［b］のものが使用されている。

| 選択肢 | ［a］ | ［b］ |
| --- | --- | --- |
| (1) | 20℃ | 1.260 |
| (2) | 20℃ | 1.280 |
| (3) | 25℃ | 1.260 |
| (4) | 25℃ | 1.280 |', 'Về ắc quy chì, tổ hợp nào điền thích hợp vào ［a］ và ［b］? Khi ắc quy được nạp đầy, thường dùng dung dịch điện phân có tỷ trọng ［b］ quy đổi về nhiệt độ dung dịch ［a］.

| Lựa chọn | ［a］ | ［b］ |
| --- | --- | --- |
| (1) | 20℃ | 1.260. |
| (2) | 20℃ | 1.280. |
| (3) | 25℃ | 1.260. |
| (4) | 25℃ | 1.280. |', NULL, '(2)', 'Chọn (2): 1.280 quy đổi về 20℃ theo quy ước của đề. Tỷ trọng thay đổi theo nhiệt độ nên phải so sánh ở cùng nhiệt độ chuẩn. Đây là ắc quy chì có dung dịch đo được; không mở ắc quy kín để áp dụng phép đo này.', '[{"term": "鉛バッテリ", "reading": "なまりばってり", "meaning": "ắc quy chì"}, {"term": "完全充電状態", "reading": "かんぜんじゅうでんじょうたい", "meaning": "trạng thái nạp đầy"}, {"term": "比重", "reading": "ひじゅう", "meaning": "tỷ trọng"}]'::jsonb, 55);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 26, '自動車に用いられる非鉄金属に関する記述として、適切なものは次のうちどれか。

(1) ケルメットは、銀に鉛を加えたもので、軸受合金として使用されている。

(2) 青銅は、銅に錫を加えた合金で、耐摩耗性に優れ、潤滑油とのなじみもよい。

(3) 黄銅（真ちゅう）は、銅にアルミニウムを加えた合金で、加工性に優れている。

(4) アルミニウムは、比重が鉄の約3倍、線膨張係数は鉄の約2倍である。', 'Trong các phát biểu về kim loại màu dùng trên ô tô, phát biểu nào phù hợp?

(1) Kelmet là bạc thêm chì, dùng làm hợp kim ổ trục.

(2) Đồng thanh là đồng thêm thiếc, chịu mài mòn tốt và tương hợp tốt với dầu bôi trơn.

(3) Đồng thau là hợp kim đồng thêm nhôm, có tính gia công tốt.

(4) Nhôm có tỷ trọng khoảng 3 lần sắt và hệ số giãn nở dài khoảng 2 lần sắt.', NULL, '(2)', '(2) đúng. Kelmet là đồng–chì; đồng thau là đồng–kẽm; nhôm có tỷ trọng khoảng 1/3 sắt. Hệ số giãn nở của nhôm khoảng gấp đôi sắt là vế đúng nhưng không cứu được vế tỷ trọng sai của (4).', '[{"term": "錫", "reading": "すず", "meaning": "thiếc"}, {"term": "鉛", "reading": "なまり", "meaning": "chì"}, {"term": "線膨張係数", "reading": "せんぼうちょうけいすう", "meaning": "hệ số giãn nở dài"}]'::jsonb, 56);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 27, '図に示す電気回路の電圧測定において、接続されている電圧計AからDが表示する電圧値として、適切なものは次のうちどれか。ただし、回路中のスイッチはOFF（開）で、バッテリ、配線等の抵抗はないものとする。

(1) 電圧計Aは0 Vを表示する。

(2) 電圧計Bは0 Vを表示する。

(3) 電圧計Cは0 Vを表示する。

(4) 電圧計Dは12 Vを表示する。

![Hình câu 27](october_q27_hinh.png)', 'Khi đo điện áp trong mạch ở hình, phát biểu nào phù hợp về số chỉ của các vôn kế A đến D đã nối? Công tắc trong mạch đang OFF (hở); điện trở ắc quy, dây dẫn và các phần tương tự bằng không.

(1) Vôn kế A chỉ 0 V.

(2) Vôn kế B chỉ 0 V.

(3) Vôn kế C chỉ 0 V.

(4) Vôn kế D chỉ 12 V.

Nhãn hình: バッテリ 12 V: ắc quy 12 V; ヒュージブル・リンク: dây chảy bảo vệ; リレー: rơle; スイッチ: công tắc; ヒューズ: cầu chì; ランプ: đèn; A, B, C, D: vôn kế; ＋/－: cực đo dương/âm; ký hiệu nối đất: mass.', NULL, '(3)', 'Chọn (3). Khi công tắc hở, không có dòng kích cuộn rơle; hai đầu cuộn ở cùng điện thế nguồn nên C đo 0 V. A và B đo nguồn so với mass, khoảng 12 V; tiếp điểm rơle chưa đóng nên nhánh đèn không được cấp nguồn, D đo 0 V. Hở mạch không có nghĩa mọi điểm đều có điện áp bằng 0.', '[{"term": "電圧計", "reading": "でんあつけい", "meaning": "vôn kế"}, {"term": "開", "reading": "かい", "meaning": "hở"}, {"term": "表示", "reading": "ひょうじ", "meaning": "hiển thị"}]'::jsonb, 57);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 28, '「道路運送車両の保安基準」及び「道路運送車両の保安基準の細目を定める告示」に照らし、最高速度が100 km/hで、車幅1.69 mの四輪の小型自動車の走行用前照灯に関する記述として、不適切なものは次のうちどれか。

(1) 最高光度の合計は、430,000 cdを超えないこと。

(2) 数は、2個であること。

(3) 灯光の色は、白色であること。

(4) そのすべてを照射したときには、夜間にその前方100 mの距離にある交通上の障害物を確認できる性能を有するものであること。', 'Theo Tiêu chuẩn an toàn phương tiện giao thông đường bộ và Thông báo quy định chi tiết, đối với đèn chiếu xa của ô tô nhỏ bốn bánh rộng 1.69 m, tốc độ tối đa 100 km/h, phát biểu nào không phù hợp?

(1) Tổng cường độ sáng cực đại không vượt 430,000 cd.

(2) Số lượng phải là 2 đèn.

(3) Ánh sáng phải có màu trắng.

(4) Khi bật tất cả các đèn, phải có khả năng nhận biết vật cản giao thông cách 100 m phía trước vào ban đêm.', NULL, '(2)', '(2) sai vì số lượng có thể là 2 hoặc 4 trong nhóm xe của đề, không chỉ 2. Các giới hạn khác mô tả tiêu chuẩn trong đề. Đừng nhầm đèn chiếu xa với đèn chiếu gần hoặc áp dụng ngoại lệ dành cho xe có kích thước/tốc độ khác.', '[{"term": "走行用前照灯", "reading": "そうこうようぜんしょうとう", "meaning": "đèn chiếu xa"}, {"term": "最高光度", "reading": "さいこうこうど", "meaning": "cường độ sáng cực đại"}, {"term": "障害物", "reading": "しょうがいぶつ", "meaning": "vật cản"}]'::jsonb, 58);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 29, '「道路運送車両の保安基準」に照らし、自動車の高さに関する基準として、適切なものは次のうちどれか。

(1) 3.2 mを超えてはならない。

(2) 3.4 mを超えてはならない。

(3) 3.6 mを超えてはならない。

(4) 3.8 mを超えてはならない。', 'Theo Tiêu chuẩn an toàn phương tiện giao thông đường bộ, quy định nào phù hợp về chiều cao ô tô?

(1) Không được vượt 3.2 m.

(2) Không được vượt 3.4 m.

(3) Không được vượt 3.6 m.

(4) Không được vượt 3.8 m.', NULL, '(4)', 'Giới hạn chiều cao cơ bản là 3.8 m, chọn (4). Đây là kích thước phương tiện theo tiêu chuẩn an toàn, không phải chiều cao thông thủy của đường hoặc giới hạn riêng của từng tuyến. Các trường hợp được miễn/giảm áp dụng cần thủ tục riêng và không làm đổi đáp án câu này.', '[{"term": "高さ", "reading": "たかさ", "meaning": "chiều cao"}, {"term": "保安基準", "reading": "ほあんきじゅん", "meaning": "tiêu chuẩn an toàn"}, {"term": "超える", "reading": "こえる", "meaning": "vượt quá"}]'::jsonb, 59);
    INSERT INTO certificate_exam_questions (certificate_id, exam_year, exam_round, question_no, question_ja, translation_vi, answer_correct, answer_label, explanation_vi, vocab_json, sort_order) VALUES (cert_id, '2026', 'Management', 30, '「道路運送車両法」に照らし、次の文章の［a］に当てはまるものとして、適切なものはどれか。「道路運送車両」とは、［a］をいう。

(1) 自動車、原動機付自転車及び軽車両

(2) 原動機付自転車及び軽車両

(3) 自動車及び原動機付自転車

(4) 自動車及び軽車両', 'Theo Luật phương tiện giao thông đường bộ, lựa chọn nào điền thích hợp vào ［a］? “Phương tiện vận chuyển đường bộ” có nghĩa là ［a］.

(1) Ô tô, xe gắn động cơ thuộc nhóm 原動機付自転車 và phương tiện thô sơ.

(2) Xe gắn động cơ thuộc nhóm 原動機付自転車 và phương tiện thô sơ.

(3) Ô tô và xe gắn động cơ thuộc nhóm 原動機付自転車.

(4) Ô tô và phương tiện thô sơ.', NULL, '(1)', 'Chọn (1): định nghĩa bao gồm cả ba nhóm. 軽車両 là nhóm phương tiện thô sơ như xe đạp, khác 軽自動車 là ô tô kei. 原動機付自転車 là thuật ngữ pháp lý Nhật; không thay bằng một phân loại dung tích theo pháp luật Việt Nam.', '[{"term": "道路運送車両", "reading": "どうろうんそうしゃりょう", "meaning": "phương tiện vận chuyển đường bộ"}, {"term": "原動機付自転車", "reading": "げんどうきつきじてんしゃ", "meaning": "xe gắn động cơ theo nhóm pháp lý Nhật"}, {"term": "軽車両", "reading": "けいしゃりょう", "meaning": "phương tiện thô sơ"}, {"term": "Mẫu câu tiếng Nhật", "reading": "Cách đọc bằng kana", "meaning": "Nghĩa tiếng Việt / cách xử lý khi làm bài"}, {"term": "～に関する記述として", "reading": "～にかんするきじゅつとして", "meaning": "Trong các phát biểu về …; xác định đúng đối tượng được hỏi."}, {"term": "適切なものは次のうちどれか。", "reading": "てきせつなものはつぎのうちどれか。", "meaning": "Lựa chọn nào phù hợp? Chọn phát biểu đúng."}, {"term": "不適切なものは次のうちどれか。", "reading": "ふてきせつなものはつぎのうちどれか。", "meaning": "Lựa chọn nào không phù hợp? Chọn phát biểu sai; chú ý 不."}, {"term": "図に示す～", "reading": "ずにしめす～", "meaning": "… thể hiện ở hình; đối chiếu mũi tên, nhãn và đơn vị."}, {"term": "［a］に当てはまるものとして", "reading": "［えー］にあてはまるものとして", "meaning": "Lựa chọn để điền vào ［a］; đọc cả câu sau khi điền."}, {"term": "下の組み合わせのうち", "reading": "したのくみあわせのうち", "meaning": "Trong các tổ hợp dưới đây; cả hai ô phải đồng thời đúng."}, {"term": "ただし、～ものとする。", "reading": "ただし、～ものとする。", "meaning": "Tuy nhiên, giả sử …; giữ điều kiện như không trượt/không có điện trở dây."}, {"term": "なお、～を示す。", "reading": "なお、～をしめす。", "meaning": "Lưu ý … biểu thị …; đọc định nghĩa dữ liệu và ký hiệu."}, {"term": "～と比較して", "reading": "～とひかくして", "meaning": "So với …; phân biệt vật đang xét và đối tượng chuẩn."}, {"term": "～ほど～なる。", "reading": "～ほど～なる。", "meaning": "Càng … càng …; kiểm tra chiều tăng/giảm."}, {"term": "～に照らし", "reading": "～にてらし", "meaning": "Căn cứ theo …; dùng đúng quy định và nhóm xe được nêu."}, {"term": "～を超えてはならない。", "reading": "～をこえてはならない。", "meaning": "Không được vượt …; đây là giới hạn trên."}, {"term": "～しなければならない。", "reading": "～しなければならない。", "meaning": "Phải …; là nghĩa vụ bắt buộc."}, {"term": "その事由があった日から～以内に", "reading": "そのじゆうがあったひから～いないに", "meaning": "Trong vòng … kể từ ngày phát sinh sự việc; xác định đúng mốc thời gian."}]'::jsonb, 60);
END $$;
