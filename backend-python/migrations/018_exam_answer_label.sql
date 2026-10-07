-- Support multiple-choice exams (answer is a letter like ア/イ/ウ/エ) in addition
-- to true/false exams (answer is ○/×). answer_correct stays for the old format;
-- answer_label is the generic display value going forward.

ALTER TABLE certificate_exam_questions ALTER COLUMN answer_correct DROP NOT NULL;
ALTER TABLE certificate_exam_questions ADD COLUMN IF NOT EXISTS answer_label VARCHAR(10);

UPDATE certificate_exam_questions
SET answer_label = CASE WHEN answer_correct THEN '○' ELSE '×' END
WHERE answer_label IS NULL AND answer_correct IS NOT NULL;
