CREATE TABLE IF NOT EXISTS admin_email_contacts (
    id BIGSERIAL PRIMARY KEY,
    email VARCHAR(254) NOT NULL UNIQUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT admin_email_contacts_normalized CHECK (email = LOWER(BTRIM(email)))
);
