"""Mock exam (thi thử) logic: build a randomised paper, grade it, store attempts.

Two question styles live in `certificate_exam_questions`:

  * True/false  -> `answer_correct` holds t/f and `answer_label` is 〇 / ×
  * Multiple choice -> `answer_correct` is NULL and `answer_label` holds the
    chosen marker (ア/イ/ウ/エ, (1)-(4), 1-5). The option texts are embedded in
    `question_ja` rather than stored separately, so the paper presents the
    marker buttons and the learner reads the options from the question body.

`answer_label` is stored with decorations in some rows ("○ — Đúng"), so every
comparison goes through `normalise_label()`.
"""
import json
import re
import uuid

import db

# A cancelled question in the real exam: every answer counts as correct.
ALL_CORRECT_MARKER = "※"

TRUE_FALSE_LABELS = {"○", "×"}


def normalise_label(label: str | None) -> str:
    """Reduce a stored or submitted label to its bare marker.

    "○ — Đúng" -> "○",  "(3)" -> "3",  "ア" -> "ア"
    """
    if not label:
        return ""
    # Take the part before any explanatory dash.
    head = re.split(r"\s*[—–-]\s*", label.strip(), maxsplit=1)[0].strip()
    # Unify full-width circle variants sometimes used for "correct".
    head = head.replace("〇", "○").replace("◯", "○")
    # "(3)" and "3" are the same choice.
    m = re.fullmatch(r"\((\d+)\)", head)
    if m:
        return m.group(1)
    return head


KATAKANA_ORDER = "アイウエオカキクケコ"


def _sort_markers(markers: set[str]) -> list[str]:
    """Order katakana by the Japanese sequence, digits numerically."""
    items = list(markers)
    if all(m.isdigit() for m in items):
        return sorted(items, key=int)
    return sorted(
        items,
        key=lambda c: KATAKANA_ORDER.find(c) if c in KATAKANA_ORDER else 99,
    )


def extract_choice_labels(question_ja: str, answer_label: str | None) -> list[str]:
    """Work out which markers the learner can pick for a question.

    True/false questions always offer 〇 and ×. For multiple choice we scan the
    question body for the marker set in use.

    The detected set is always widened to include the correct answer. Some
    questions embed tables of figures that look like choice markers, or use
    markers up to キ/ク, so detection alone can produce a set that omits the
    right answer — which would make the question impossible to answer.
    """
    norm_answer = normalise_label(answer_label)
    if norm_answer in TRUE_FALSE_LABELS:
        return ["○", "×"]

    text = question_ja or ""
    detected: set[str] = set()

    # Katakana markers (ア イ ウ エ オ ...) at the start of a line.
    kata = set(re.findall(r"^[\s　]*([ア-ン])[\s　]", text, flags=re.MULTILINE))
    if len(kata) >= 2:
        detected = kata
    else:
        # Parenthesised numbers (1) (2) (3) (4)
        paren = set(re.findall(r"\((\d+)\)", text))
        if len(paren) >= 2:
            detected = paren
        else:
            # Bare numbered lines: "1 ...", "2 ..."
            bare = set(re.findall(r"^[\s　]*(\d)[\s　．.、]", text, flags=re.MULTILINE))
            if len(bare) >= 2:
                detected = bare

    # Fall back to a default set when nothing usable was found.
    if not detected:
        if norm_answer.isdigit():
            detected = {"1", "2", "3", "4"}
        else:
            detected = {"ア", "イ", "ウ", "エ"}

    # The correct answer must always be offered.
    if norm_answer and norm_answer != ALL_CORRECT_MARKER:
        answer_is_digit = norm_answer.isdigit()
        detected_are_digits = all(m.isdigit() for m in detected)
        if answer_is_digit != detected_are_digits:
            # Detection picked the wrong marker family (e.g. table figures read
            # as numbers while the answer is katakana). Rebuild around the answer.
            if answer_is_digit:
                detected = {"1", "2", "3", "4"}
            else:
                idx = KATAKANA_ORDER.find(norm_answer)
                span = max(4, idx + 1) if idx >= 0 else 4
                detected = set(KATAKANA_ORDER[:span])
        detected.add(norm_answer)

    return _sort_markers(detected)


def is_true_false(answer_label: str | None, answer_correct) -> bool:
    """A question is true/false when its answer marker is 〇 or ×."""
    if answer_correct is not None:
        return True
    return normalise_label(answer_label) in TRUE_FALSE_LABELS


async def get_certificate_by_code(code: str) -> dict | None:
    return await db.query_one(
        "SELECT id, code, name_ja, name_vi FROM certificates WHERE code = $1", code
    )


async def list_exam_sessions(certificate_id: int) -> list[dict]:
    """Available (year, round) pairs with question counts, for the start screen."""
    rows = await db.query(
        "SELECT exam_year, exam_round, count(*) AS question_count "
        "FROM certificate_exam_questions WHERE certificate_id = $1 "
        "GROUP BY exam_year, exam_round ORDER BY exam_year DESC, exam_round",
        certificate_id,
    )
    return [
        {
            "year": r["exam_year"],
            "round": r["exam_round"],
            "questionCount": r["question_count"],
        }
        for r in rows
    ]


async def build_paper(
    certificate_id: int,
    limit: int,
    exam_year: str | None = None,
    exam_round: str | None = None,
) -> list[dict]:
    """Pick questions for an attempt, without exposing any answer data."""
    params: list = [certificate_id]
    where = "certificate_id = $1"

    if exam_year:
        params.append(exam_year)
        where += f" AND exam_year = ${len(params)}"
        if exam_round:
            params.append(exam_round)
            where += f" AND exam_round = ${len(params)}"

    params.append(limit)
    rows = await db.query(
        f"SELECT id, question_no, question_ja, answer_label, answer_correct "
        f"FROM certificate_exam_questions WHERE {where} "
        f"ORDER BY random() LIMIT ${len(params)}",
        *params,
    )

    paper = []
    for idx, r in enumerate(rows, start=1):
        paper.append(
            {
                "id": r["id"],
                "displayNo": idx,
                "questionNo": r["question_no"],
                "questionJa": r["question_ja"],
                "isTrueFalse": is_true_false(r["answer_label"], r["answer_correct"]),
                "choices": extract_choice_labels(r["question_ja"], r["answer_label"]),
            }
        )
    return paper


async def grade_attempt(
    user_id: str,
    certificate_id: int,
    submissions: list[dict],
    duration_seconds: int | None,
) -> dict:
    """Grade the submitted answers, persist the attempt, and return a review."""
    if not submissions:
        raise ValueError("No answers submitted")

    question_ids = [s["questionId"] for s in submissions]
    rows = await db.query(
        "SELECT id, question_no, question_ja, translation_vi, answer_label, "
        "answer_correct, explanation_vi, vocab_json "
        "FROM certificate_exam_questions WHERE id = ANY($1)",
        question_ids,
    )
    by_id = {r["id"]: r for r in rows}

    selected_by_id = {s["questionId"]: s.get("selectedLabel") for s in submissions}

    results = []
    correct_count = 0
    for qid in question_ids:
        row = by_id.get(qid)
        if not row:
            continue
        expected = normalise_label(row["answer_label"])
        chosen = normalise_label(selected_by_id.get(qid))

        # A cancelled exam question is credited to everyone.
        if expected == ALL_CORRECT_MARKER:
            is_correct = True
        else:
            is_correct = bool(chosen) and chosen == expected

        if is_correct:
            correct_count += 1

        vocab = row["vocab_json"]
        if isinstance(vocab, str):
            vocab = json.loads(vocab)

        results.append(
            {
                "questionId": qid,
                "questionNo": row["question_no"],
                "questionJa": row["question_ja"],
                "selectedLabel": selected_by_id.get(qid) or "",
                "correctLabel": row["answer_label"],
                "isCorrect": is_correct,
                "translationVi": row["translation_vi"],
                "explanationVi": row["explanation_vi"],
                "vocab": vocab or [],
            }
        )

    total = len(results)
    if total == 0:
        raise ValueError("No valid questions in submission")

    attempt = await db.query_one(
        "INSERT INTO mock_exam_attempts "
        "(user_id, certificate_id, total_questions, correct_count, duration_seconds) "
        "VALUES ($1, $2, $3, $4, $5) RETURNING id, finished_at",
        uuid.UUID(user_id), certificate_id, total, correct_count, duration_seconds,
    )

    for r in results:
        await db.execute(
            "INSERT INTO mock_exam_attempt_answers "
            "(attempt_id, question_id, selected_label, is_correct) "
            "VALUES ($1, $2, $3, $4) "
            "ON CONFLICT (attempt_id, question_id) DO NOTHING",
            attempt["id"], r["questionId"], r["selectedLabel"], r["isCorrect"],
        )

    return {
        "attemptId": attempt["id"],
        "totalQuestions": total,
        "correctCount": correct_count,
        "scorePercent": round(correct_count * 100 / total, 1),
        "durationSeconds": duration_seconds,
        "results": results,
    }


async def list_user_attempts(user_id: str, certificate_id: int, limit: int = 10) -> list[dict]:
    rows = await db.query(
        "SELECT id, total_questions, correct_count, duration_seconds, finished_at "
        "FROM mock_exam_attempts WHERE user_id = $1 AND certificate_id = $2 "
        "ORDER BY finished_at DESC LIMIT $3",
        uuid.UUID(user_id), certificate_id, limit,
    )
    return [
        {
            "attemptId": r["id"],
            "totalQuestions": r["total_questions"],
            "correctCount": r["correct_count"],
            "scorePercent": round(r["correct_count"] * 100 / r["total_questions"], 1)
            if r["total_questions"] else 0,
            "durationSeconds": r["duration_seconds"],
            "finishedAt": r["finished_at"].isoformat(),
        }
        for r in rows
    ]
