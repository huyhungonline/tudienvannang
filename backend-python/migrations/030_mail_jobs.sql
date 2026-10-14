CREATE TABLE IF NOT EXISTS mail_jobs (
    id UUID PRIMARY KEY,
    subject TEXT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS mail_job_recipients (
    job_id UUID NOT NULL REFERENCES mail_jobs(id) ON DELETE CASCADE,
    email TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'sending', 'sent', 'failed')),
    attempts INTEGER NOT NULL DEFAULT 0,
    error TEXT,
    PRIMARY KEY (job_id, email)
);
CREATE INDEX IF NOT EXISTS mail_recipients_pending ON mail_job_recipients (job_id) WHERE status = 'pending';
