-- Book customers captured from social media messages (TikTok, Facebook...).
-- Separate from `workbook_orders`, which is the self-service web form.

CREATE TABLE IF NOT EXISTS book_customers (
  id SERIAL PRIMARY KEY,
  full_name TEXT NOT NULL,
  phone TEXT,
  email TEXT,
  address TEXT,
  book_type TEXT,
  note TEXT,
  paid_at TIMESTAMP WITH TIME ZONE,
  shipped_at TIMESTAMP WITH TIME ZONE,
  source TEXT NOT NULL DEFAULT 'manual',
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_book_customers_created
  ON book_customers(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_book_customers_phone
  ON book_customers(phone);
CREATE INDEX IF NOT EXISTS idx_book_customers_status
  ON book_customers(paid_at, shipped_at);
