-- Public search log (auto-saved on every split request, no login required)
CREATE TABLE IF NOT EXISTS public_searches (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  input_text TEXT NOT NULL,
  target_language VARCHAR(50) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_public_searches_created ON public_searches(created_at DESC);
