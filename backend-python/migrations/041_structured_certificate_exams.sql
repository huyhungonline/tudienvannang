-- Structured question banks; existing certificates/questions remain intact.
CREATE TABLE IF NOT EXISTS certificate_exams (
    id SERIAL PRIMARY KEY,
    certificate_id INTEGER NOT NULL REFERENCES certificates(id),
    source_key TEXT NOT NULL,
    exam_year TEXT NOT NULL,
    exam_round TEXT NOT NULL,
    source_pdf TEXT NOT NULL,
    answer_pdf TEXT NOT NULL,
    metadata_json JSONB NOT NULL DEFAULT '{}',
    UNIQUE (certificate_id, source_key),
    UNIQUE (id, certificate_id)
);

CREATE TABLE IF NOT EXISTS certificate_passages (
    id SERIAL PRIMARY KEY,
    exam_id INTEGER NOT NULL REFERENCES certificate_exams(id),
    source_key TEXT NOT NULL,
    text_ja TEXT NOT NULL,
    text_vi TEXT NOT NULL,
    assets_json JSONB NOT NULL DEFAULT '[]',
    review_status TEXT NOT NULL DEFAULT 'pending',
    UNIQUE (exam_id, source_key),
    UNIQUE (id, exam_id)
);

ALTER TABLE certificate_exam_questions
    ADD COLUMN IF NOT EXISTS source_key TEXT,
    ADD COLUMN IF NOT EXISTS exam_id INTEGER,
    ADD COLUMN IF NOT EXISTS passage_id INTEGER,
    ADD COLUMN IF NOT EXISTS options_json JSONB NOT NULL DEFAULT '[]',
    ADD COLUMN IF NOT EXISTS knowledge_group TEXT,
    ADD COLUMN IF NOT EXISTS assets_json JSONB NOT NULL DEFAULT '[]',
    ADD COLUMN IF NOT EXISTS source_json JSONB NOT NULL DEFAULT '{}',
    ADD COLUMN IF NOT EXISTS review_notes_json JSONB NOT NULL DEFAULT '[]',
    ADD COLUMN IF NOT EXISTS review_status TEXT NOT NULL DEFAULT 'pending';

CREATE UNIQUE INDEX IF NOT EXISTS idx_cert_question_source
    ON certificate_exam_questions(certificate_id, source_key);
CREATE INDEX IF NOT EXISTS idx_cert_question_topic
    ON certificate_exam_questions(certificate_id, knowledge_group, exam_id, question_no);

DO $$ BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'fk_cert_question_exam'
                   AND conrelid = 'certificate_exam_questions'::regclass) THEN
        ALTER TABLE certificate_exam_questions ADD CONSTRAINT fk_cert_question_exam
            FOREIGN KEY (exam_id, certificate_id) REFERENCES certificate_exams(id, certificate_id);
        ALTER TABLE certificate_exam_questions ADD CONSTRAINT fk_cert_question_passage
            FOREIGN KEY (passage_id, exam_id) REFERENCES certificate_passages(id, exam_id);
        ALTER TABLE certificate_exam_questions ADD CONSTRAINT ck_cert_question_options
            CHECK (source_key IS NULL OR
                   (exam_id IS NOT NULL AND jsonb_typeof(options_json) = 'array'
                    AND jsonb_array_length(options_json) = 4
                    AND answer_label IS NOT NULL AND answer_label IN ('ア', 'イ', 'ウ', 'エ')));
    END IF;
END $$;
