-- Real-exam parameters per certificate: how many questions a paper has and
-- how long candidates get. The mock exam uses these instead of letting the
-- learner pick a size, so a practice run matches the real sitting.
--
-- `required_answers` covers exams where the paper contains more questions than
-- the candidate must answer (2級建築施工管理: 50 printed, 40 to be answered).

CREATE TABLE IF NOT EXISTS certificate_exam_config (
  certificate_id INTEGER PRIMARY KEY REFERENCES certificates(id) ON DELETE CASCADE,
  question_count INTEGER NOT NULL CHECK (question_count > 0),
  duration_minutes INTEGER NOT NULL CHECK (duration_minutes > 0),
  required_answers INTEGER,
  note TEXT,
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

-- Seed from the official exam formats. Keyed by code so it is safe to re-run.
INSERT INTO certificate_exam_config
  (certificate_id, question_count, duration_minutes, required_answers, note)
SELECT c.id, v.question_count, v.duration_minutes, v.required_answers, v.note
FROM (VALUES
  ('kikaihozen3',    30,  60, NULL, NULL),
  ('seibi2',         40,  80, NULL, NULL),
  ('kikaokako3',     30,  60, NULL, NULL),
  ('seibi3',         30,  60, NULL, NULL),
  ('denkihozen2',    50, 100, NULL, NULL),
  ('denkihozen3',    30,  60, NULL, NULL),
  ('itpp',          100, 120, NULL, NULL),
  ('sg',             60, 120, NULL, NULL),
  ('kenchikukanri',  50, 150, 40,   'Đề có 50 câu, thí sinh chỉ cần trả lời 40 câu.'),
  ('kakakubunseki3', 30,  60, NULL, NULL)
) AS v(code, question_count, duration_minutes, required_answers, note)
JOIN certificates c ON c.code = v.code
ON CONFLICT (certificate_id) DO UPDATE SET
  question_count   = EXCLUDED.question_count,
  duration_minutes = EXCLUDED.duration_minutes,
  required_answers = EXCLUDED.required_answers,
  note             = EXCLUDED.note,
  updated_at       = NOW();
