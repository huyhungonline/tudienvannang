# IT Passport PDF extraction

`structured/` contains one JSON file per exam in quiz schema v2. Each question has
a stable `id`, `question.ja/vi`, four bilingual `options` with IDs A–D and original
Japanese labels, `correct_option_id`, `explanation_vi`, `knowledge_group`,
`passage_id`, `assets`, `source`, and `review_status`.
No attempt history or user tracking is stored.

Shared passages are stored once in the exam's `passages` array. `assets` entries
reference pages of the original PDF via `type: "pdf_page"`, `path`, and `pages`;
they are not cropped image files. Reference appendices are excluded.
`review_status: "pending"` means the question has not had a full manual review.

`structured_backup/` preserves the original extraction files. The normalization
script reads this backup on subsequent runs and caches model-assisted parsing.

The Japanese text comes from OCR. Figures, diagrams, and ambiguous option labels
should be checked against the original PDF in `IT-PP/`.

## Run in WSL

Install `requirements.txt` into a Python environment. Configure the variables in
`azure.env.example`; use your Azure deployment name for `OPENAI_DEPLOYMENT`.
The example file is documentation and is not loaded automatically.

```bash
cd /mnt/c/source/dic
set -a
. tool/.azure-run.env
set +a
tool/.venv-wsl/bin/python -u tool/run_itpp_all.py
tool/.venv-wsl/bin/python -u tool/normalize_quiz_json.py
```

`run_itpp_all.py` processes up to eight exams concurrently and requires exactly
100 unique question numbers with 100 matching official answers per exam.
It saves `structured/run_report.json` as exams finish. `.ocr-cache/` and
`.llm-cache/` allow interrupted work to resume. Completed outputs are skipped.
Azure keys and caches are ignored by Git.

```bash
tool/.venv-wsl/bin/python tool/test_extract_itpp.py
tool/.venv-wsl/bin/python tool/test_normalize_quiz.py
tool/.venv-wsl/bin/python tool/check_itpp_pdfs.py
```
