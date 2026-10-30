-- Replace the 機械保全技能検定 sign-up with QC検定 3級.
--
-- `kikai-hozen` stays allowed in the constraint so any registration already
-- recorded under it remains valid; it is simply no longer offered in the UI.

ALTER TABLE class_registrations
  DROP CONSTRAINT IF EXISTS class_registrations_course_check;

ALTER TABLE class_registrations
  ADD CONSTRAINT class_registrations_course_check
  CHECK (course IN ('it-passport', 'kikai-hozen', 'qc-kentei-3'));
