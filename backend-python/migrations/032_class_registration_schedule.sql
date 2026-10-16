ALTER TABLE class_registrations
ADD COLUMN IF NOT EXISTS schedule TEXT
CHECK (schedule IN ('sat-tue-20-22', 'sun-thu-20-22'));
