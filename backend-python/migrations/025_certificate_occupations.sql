-- Related occupations/industries info shown on the certificate detail page

ALTER TABLE certificates ADD COLUMN IF NOT EXISTS related_occupations TEXT;

UPDATE certificates SET related_occupations =
    'Kỹ thuật viên bảo trì - bảo dưỡng máy móc, thợ sửa chữa thiết bị công nghiệp, nhân viên bảo trì nhà máy sản xuất, công nhân vận hành máy CNC, kỹ sư cơ khí tại xưởng/nhà máy.'
WHERE code = 'kikaihozen3';

UPDATE certificates SET related_occupations =
    'Thợ tiện, thợ gia công cơ khí (tiện, phay, khoan), công nhân vận hành máy công cụ, kỹ thuật viên sản xuất linh kiện cơ khí chính xác.'
WHERE code = 'kikaokako3';

UPDATE certificates SET related_occupations =
    'Kỹ thuật viên điện công nghiệp, thợ điện, nhân viên bảo trì hệ thống điện nhà máy, kỹ sư điện - điện tử, kỹ thuật viên PLC và tự động hóa, nhân viên vận hành thiết bị điện.'
WHERE code = 'denkihozen3';

UPDATE certificates SET related_occupations =
    'Kỹ thuật viên phân tích hóa học, nhân viên QC/KCS tại nhà máy thực phẩm - dược phẩm - hóa chất, nhân viên phòng thí nghiệm, kiểm nghiệm viên chất lượng sản phẩm.'
WHERE code = 'kakakubunseki3';

UPDATE certificates SET related_occupations =
    'Nhân viên văn phòng sử dụng CNTT, lập trình viên/kỹ sư IT mới vào nghề, nhân viên hỗ trợ kỹ thuật (IT support), trợ lý quản lý dự án IT, nhân viên kinh doanh/tư vấn giải pháp CNTT.'
WHERE code = 'itpp';

UPDATE certificates SET related_occupations =
    'Chuyên viên an toàn thông tin, quản trị viên hệ thống/mạng, nhân viên IT phụ trách bảo mật doanh nghiệp, nhân viên kiểm toán/tuân thủ CNTT, cán bộ quản lý an ninh thông tin (CISO cấp cơ sở).'
WHERE code = 'sg';

UPDATE certificates SET related_occupations =
    'Kỹ sư giám sát thi công xây dựng, chỉ huy trưởng công trình, quản lý dự án xây dựng, kỹ sư quản lý chất lượng - an toàn công trình, tư vấn giám sát xây dựng.'
WHERE code = 'kenchikukanri';
