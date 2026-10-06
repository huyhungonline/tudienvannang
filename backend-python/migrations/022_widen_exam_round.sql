-- Some certificates use long chapter titles as the exam_round grouping label
-- (e.g. "Quản lý rủi ro và kỹ thuật bảo mật"), which exceeded VARCHAR(20).

ALTER TABLE certificate_exam_questions ALTER COLUMN exam_round TYPE VARCHAR(200);
