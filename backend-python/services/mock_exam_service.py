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
import asyncio
import json
import re
import uuid

import db
from services import email_service
from services import quiz_content_service as content

# A cancelled question in the real exam: every answer counts as correct.
ALL_CORRECT_MARKER = "※"

TRUE_FALSE_LABELS = {"○", "×"}

# IT Passport: the nine knowledge groups roll up into three scored fields.
ITPP_FIELD_OF = {
    "企業と法務": "strategy", "経営戦略": "strategy", "システム戦略": "strategy",
    "開発技術": "management", "プロジェクトマネジメント": "management",
    "サービスマネジメント": "management",
    "基礎理論": "technology", "コンピュータシステム": "technology",
    "技術要素": "technology",
}
# Real paper composition (100 questions), in display order.
ITPP_FIELD_QUOTA = {"strategy": 35, "management": 20, "technology": 45}
ITPP_FIELD_NAMES = {
    "strategy": "ストラテジ系", "management": "マネジメント系", "technology": "テクノロジ系",
}
ITPP_PASS_TOTAL = 600
ITPP_PASS_FIELD = 300
SCORE_SCALE = 1000


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


# Used when a certificate has no row in certificate_exam_config yet.
DEFAULT_QUESTION_COUNT = 30
DEFAULT_DURATION_MINUTES = 60


async def get_exam_config(certificate_id: int) -> dict:
    """Real-exam format for a certificate: paper size and time limit.

    Falls back to a sensible default so a newly added certificate still works
    before its official format has been recorded.
    """
    row = await db.query_one(
        "SELECT question_count, duration_minutes, required_answers, note "
        "FROM certificate_exam_config WHERE certificate_id = $1",
        certificate_id,
    )
    pool = await db.query_one(
        f"SELECT count(*) AS n FROM certificate_exam_questions q WHERE certificate_id = $1 AND {content.BANK_SCOPE}",
        certificate_id,
    )
    available = pool["n"] if pool else 0

    if row:
        configured = row["question_count"]
        duration = row["duration_minutes"]
        required = row["required_answers"]
        note = row["note"]
    else:
        configured = DEFAULT_QUESTION_COUNT
        duration = DEFAULT_DURATION_MINUTES
        required = None
        note = None

    # Never ask for more questions than exist; without this the paper would
    # silently be short and the score would be computed against the wrong total.
    effective = min(configured, available)

    return {
        "configuredCount": configured,
        "effectiveCount": effective,
        "availableCount": available,
        "durationMinutes": duration,
        "requiredAnswers": required,
        "note": note,
        "isShortOfPool": effective < configured,
    }


async def _pick_by_field_quota(certificate_id: int, limit: int) -> list[dict]:
    """Random questions following the real 35/20/45 field composition.

    A field short of its quota is topped up from the leftover pool so the paper
    still reaches `limit` questions.
    """
    pool = await db.query(
        f"SELECT {content.CONTENT_COLUMNS} "
        f"FROM certificate_exam_questions q {content.PASSAGE_JOIN} WHERE q.certificate_id = $1 AND {content.BANK_SCOPE} "
        "ORDER BY random()",
        certificate_id,
    )
    by_field: dict[str, list[dict]] = {f: [] for f in ITPP_FIELD_QUOTA}
    for r in pool:
        field = ITPP_FIELD_OF.get(r.get("knowledge_group"))
        if field:
            by_field[field].append(r)

    # Scale the quota when the paper is smaller than the real 100 questions.
    total_quota = sum(ITPP_FIELD_QUOTA.values())
    chosen: list[dict] = []
    for field, quota in ITPP_FIELD_QUOTA.items():
        want = round(quota * limit / total_quota)
        chosen.extend(by_field[field][:want])
    chosen_ids = {r["id"] for r in chosen}
    spare = [r for r in pool if r["id"] not in chosen_ids]
    chosen.extend(spare[: max(0, limit - len(chosen))])
    chosen = chosen[:limit]

    # Present in field order (strategy, management, technology) like the real paper.
    order = list(ITPP_FIELD_QUOTA)
    chosen.sort(key=lambda r: order.index(ITPP_FIELD_OF.get(r.get("knowledge_group"), "technology")))
    return chosen


async def build_paper(certificate_id: int, limit: int, code: str | None = None) -> list[dict]:
    """Pick `limit` distinct random questions, exposing no answer data.

    Randomness comes from `ORDER BY random()` over the whole pool, and because
    rows are selected by primary key no question can appear twice in one paper.
    IT Passport papers follow the real field composition instead.
    """
    if code == "itpp":
        rows = await _pick_by_field_quota(certificate_id, limit)
    else:
        rows = await db.query(
            f"SELECT {content.CONTENT_COLUMNS} "
            f"FROM certificate_exam_questions q {content.PASSAGE_JOIN} WHERE q.certificate_id = $1 AND {content.BANK_SCOPE} "
            "ORDER BY random() LIMIT $2",
            certificate_id, limit,
        )

    paper = []
    for idx, r in enumerate(rows, start=1):
        paper.append(
            {
                "id": r["id"],
                "displayNo": idx,
                "questionNo": r["question_no"],
                **content.public_question(r),
                "isTrueFalse": is_true_false(r["answer_label"], r["answer_correct"]),
                "choices": ([o['label'] for o in content.decoded(r.get('options_json'), [])]
                            or extract_choice_labels(r["question_ja"], r["answer_label"])),
            }
        )
    return paper


def itpp_scoring(results: list[dict]) -> dict:
    """Estimated 1000-point score and pass/fail, per the real IT Passport rules.

    The official score uses IRT and is not published, so each question is worth
    an equal share. Pass = total >= 600 and every field >= 300.
    """
    fields = {f: [0, 0] for f in ITPP_FIELD_QUOTA}  # [correct, total]
    for r in results:
        field = ITPP_FIELD_OF.get(r.get("knowledgeGroup"))
        if field:
            fields[field][1] += 1
            fields[field][0] += 1 if r["isCorrect"] else 0

    total = sum(t for _, t in fields.values())
    correct = sum(c for c, _ in fields.values())
    total_score = round(correct * SCORE_SCALE / total) if total else 0

    field_scores = []
    failing = []
    for field, (c, t) in fields.items():
        score = round(c * SCORE_SCALE / t) if t else 0
        field_scores.append({
            "field": field, "nameJa": ITPP_FIELD_NAMES[field],
            "correct": c, "total": t, "score": score,
            "passed": score >= ITPP_PASS_FIELD,
        })
        if t and score < ITPP_PASS_FIELD:
            failing.append(field)

    return {
        "totalScore": total_score,
        "maxScore": SCORE_SCALE,
        "passTotal": ITPP_PASS_TOTAL,
        "passField": ITPP_PASS_FIELD,
        "fieldScores": field_scores,
        "passed": total_score >= ITPP_PASS_TOTAL and not failing,
        "totalPassed": total_score >= ITPP_PASS_TOTAL,
        "failingFields": failing,
    }


async def grade_attempt(
    user_id: str,
    certificate_id: int,
    submissions: list[dict],
    duration_seconds: int | None,
    persist: bool = True,
    scoring: str | None = None,
) -> dict:
    """Grade the submitted answers, persist the attempt, and return a review."""
    if not submissions:
        raise ValueError("No answers submitted")

    question_ids = [s["questionId"] for s in submissions]
    if len(question_ids) != len(set(question_ids)):
        raise ValueError("Duplicate question IDs")
    if duration_seconds is not None and duration_seconds < 0:
        raise ValueError("Invalid duration")
    rows = await db.query(
        f"SELECT {content.CONTENT_COLUMNS} "
        f"FROM certificate_exam_questions q {content.PASSAGE_JOIN} "
        f"WHERE q.id = ANY($1) AND q.certificate_id=$2 AND {content.BANK_SCOPE}",
        question_ids, certificate_id,
    )
    by_id = {r["id"]: r for r in rows}
    if set(by_id) != set(question_ids):
        raise ValueError("Unknown question or question from another certificate")

    selected_by_id = {s["questionId"]: s.get("selectedLabel") for s in submissions}

    results = []
    correct_count = 0
    for qid in question_ids:
        row = by_id.get(qid)
        if not row:
            continue
        expected = normalise_label(row["answer_label"])
        chosen = normalise_label(selected_by_id.get(qid))
        options = content.decoded(row.get('options_json'), [])
        if options and chosen:
            selected = next((o for o in options if chosen in (o['id'],o['label'])),None)
            if selected is None:
                raise ValueError("Invalid option")
            chosen = selected['label']

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
                **content.public_question(row, include_translation=True),
                "selectedLabel": selected_by_id.get(qid) or "",
                "correctLabel": row["answer_label"],
                "isCorrect": is_correct,
                "translationVi": row["translation_vi"],
                "explanationVi": row["explanation_vi"],
                "vocab": vocab or [],
                "correctOptionId": content.answer_details(row)['correctOptionId'],
            }
        )

    total = len(results)
    if total == 0:
        raise ValueError("No valid questions in submission")

    extra = {"itppScore": itpp_scoring(results)} if scoring == "itpp" else {}

    if not persist:
        return {
            "attemptId": None, "totalQuestions": total, "correctCount": correct_count,
            "scorePercent": round(correct_count * 100 / total, 1),
            "durationSeconds": duration_seconds, "results": results, **extra,
        }

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

    score_percent = round(correct_count * 100 / total, 1)

    # Email the score. Runs in the background so a slow or failing SMTP server
    # never delays or breaks the result the learner is waiting for.
    asyncio.create_task(
        _send_result_email(
            user_id=user_id,
            certificate_id=certificate_id,
            total=total,
            correct_count=correct_count,
            score_percent=score_percent,
            duration_seconds=duration_seconds,
            results=results,
        )
    )

    return {
        "attemptId": attempt["id"],
        "totalQuestions": total,
        "correctCount": correct_count,
        "scorePercent": score_percent,
        "durationSeconds": duration_seconds,
        "results": results,
        **extra,
    }


async def _send_result_email(
    user_id: str,
    certificate_id: int,
    total: int,
    correct_count: int,
    score_percent: float,
    duration_seconds: int | None,
    results: list[dict],
) -> None:
    """Look up the learner's address and mail the score. Never raises."""
    try:
        user = await db.query_one(
            "SELECT email FROM users WHERE id = $1", uuid.UUID(user_id)
        )
        if not user or not user.get("email"):
            return

        cert = await db.query_one(
            "SELECT name_ja, name_vi FROM certificates WHERE id = $1", certificate_id
        )
        if cert:
            cert_name = cert["name_vi"] or cert["name_ja"]
        else:
            cert_name = "chứng chỉ"

        wrong = [
            {
                "questionNo": r["questionNo"],
                "correctLabel": r["correctLabel"],
                "selectedLabel": r["selectedLabel"],
            }
            for r in results
            if not r["isCorrect"]
        ]

        await asyncio.to_thread(
            email_service.send_mock_exam_result_email,
            user["email"],
            cert_name,
            total,
            correct_count,
            score_percent,
            duration_seconds,
            wrong,
        )
    except Exception as e:
        # A failed notification must not affect the recorded attempt.
        print(f"Mock exam result email failed for user {user_id}: {e}")


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
