-- Some certificates use a descriptive exam_year label that includes the exam
-- session number (e.g. "2026 (Kỳ thi 112)"), which exceeded VARCHAR(10).

ALTER TABLE certificate_exam_questions ALTER COLUMN exam_year TYPE VARCHAR(50);

-- Some questions have a special answer label instead of a letter/number
-- (e.g. "※ — Tất cả thí sinh được công nhận đúng" for voided questions),
-- which exceeded VARCHAR(10).
ALTER TABLE certificate_exam_questions ALTER COLUMN answer_label TYPE VARCHAR(100);
