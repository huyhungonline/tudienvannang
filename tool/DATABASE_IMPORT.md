# IT Passport database import

Migration `041_structured_certificate_exams.sql` extends the existing PostgreSQL
certificate tables. Apply it before starting the updated backend. Existing
questions and attempt records are retained. Once a certificate has imported
questions, API lists and random papers use that bank instead of older seed rows.

## Import

Run from the repository root with `asyncpg` and `python-dotenv` installed:

```bash
python tool/import_itpp_questions.py --dry-run
python tool/import_itpp_questions.py --apply-migration
```

The importer loads `DATABASE_URL` from the environment or root `.env`. For a
Docker service hostname, `--db-host 127.0.0.1` can select the published port.
Migration and data writes run in a single transaction with an advisory lock.
Validation failures roll back the import. Upserts retain existing database IDs;
no questions are deleted. JSON files are the source of imported content, so
reimporting overwrites edits to those imported fields.

On an older database without certificate tables, add `--bootstrap-base`. This
creates certificate prerequisites and IT Passport configuration without loading
other certificate seed content. Missing admin/VIP columns are added with false
defaults; no account permissions are granted.

For the currently running local Docker stack, credentials can be inherited from
the backend container without printing or writing them:

```bash
tool/.venv-wsl/bin/python tool/with_local_database.py \
  tool/.venv-wsl/bin/python tool/import_itpp_questions.py --apply-migration
```

The import summary is saved as `tool/structured/database_import_report.json`.

## API

Certificate code: `itpp`. Existing VIP/admin authorization remains in place.

- `GET /api/certificates/itpp/exams`: list imported exam codes and counts.
- `GET /api/certificates/itpp/topics`: groups and question counts.
- `GET /api/certificates/itpp/exam?exam=2016h28a&knowledge_group=企業と法務`:
  filter by exam, topic, or both; omit either filter to include all values.
- `GET /api/certificates/exam-question/{database_id}/answer`: reveal bilingual
  options, the correct option ID, explanation, notes, and translated passage.
- Mock-exam start returns structured options and legacy fields for existing
  clients. Submit accepts a Japanese label or A–D, rejects duplicate IDs and
  questions belonging to another certificate. IT Passport submission returns
  `attemptId: null` and writes no attempts, answers, or email jobs.
- IT Passport history returns an empty list. Other certificates retain their
  existing history behavior.

PDF references are served under `/api/certificates/documents/{filename}`.
`EXAM_PDFS_PATH` selects their directory; local development defaults to
`tool/IT-PP`. Docker Compose mounts this folder read-only at `/exam_pdfs`.
Only exam question PDFs matching the filename allowlist are served.

Review status is preserved; importing does not imply manual content approval.
The seed guard in migration 019 preserves imported questions when deploy.sh
replays old migrations.

## Tests

```bash
tool/.venv-wsl/bin/python tool/with_local_database.py \
  tool/.venv-wsl/bin/python test/test_itpp_database.py
npm run build --workspace frontend
```

Database tests create a temporary schema inside a transaction and roll it back.
They check real imports, stable IDs on reimport, seed replay protection, source
counts, topic/exam filters, PDF serving, answer hiding, and stateless grading.

## Production deployment

Stage the intended code, `tool/structured/*_qs.json`, and source PDFs explicitly,
then run `bash deploy.sh`. The script commits only already staged files and
pushes main. It does not stage the workspace or overwrite the server's `.env`.

On the VPS, deployment locks out concurrent runs, preserves local Git edits,
saves a PostgreSQL custom-format backup and the old revision under
`backups/deploy/`, fast-forwards Git, compares database/session settings against
the running backend, builds images, validates/imports data transactionally,
and replaces backend/frontend while leaving PostgreSQL running. It applies the
structured-bank migration through the importer instead of replaying seed SQL.
Post-deployment checks validate all imported questions, stateless grading,
and API/PDF responses before reporting success.

Migration/import failure stops deployment. Database backups are never restored
automatically, since a restore could discard writes made by active users.
