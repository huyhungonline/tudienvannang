#!/bin/bash
# Measure how well extract_choice_labels() handles the real question pool:
# for every multiple-choice question, does the detected choice set actually
# contain the correct answer? If not, the learner could never pick it.
cd "$(dirname "$0")/.." || exit 1

scp -q backend-python/services/mock_exam_service.py \
    root@14.225.198.235:/root/tudienvannang/backend-python/services/

cat > /tmp/coverage_probe.py <<'PY'
import asyncio, sys
sys.path.insert(0, '/app')
import db
from services.mock_exam_service import extract_choice_labels, normalise_label, is_true_false

async def main():
    rows = await db.query(
        "SELECT id, question_ja, answer_label, answer_correct "
        "FROM certificate_exam_questions ORDER BY id"
    )
    tf = mc = 0
    ok = bad = 0
    bad_samples = []
    for r in rows:
        if is_true_false(r['answer_label'], r['answer_correct']):
            tf += 1
            continue
        mc += 1
        choices = [normalise_label(c) for c in extract_choice_labels(r['question_ja'], r['answer_label'])]
        answer = normalise_label(r['answer_label'])
        if answer == '※':
            ok += 1
            continue
        if answer in choices:
            ok += 1
        else:
            bad += 1
            if len(bad_samples) < 8:
                bad_samples.append((r['id'], answer, choices))

    print(f"True/false questions      : {tf}")
    print(f"Multiple-choice questions : {mc}")
    print(f"  answer IS selectable    : {ok}")
    print(f"  answer NOT selectable   : {bad}")
    if mc:
        print(f"  coverage                : {ok*100/mc:.1f}%")
    if bad_samples:
        print("\nExamples where the correct answer is not offered:")
        for qid, ans, ch in bad_samples:
            print(f"  id={qid}  correct={ans!r}  offered={ch}")
    await db.close_pool()

asyncio.run(main())
PY

scp -q /tmp/coverage_probe.py root@14.225.198.235:/tmp/
rm -f /tmp/coverage_probe.py

ssh root@14.225.198.235 'bash -s' <<'REMOTE'
cd /root/tudienvannang || exit 1
docker cp backend-python/services/mock_exam_service.py tudienvannang-backend-1:/app/services/
docker cp /tmp/coverage_probe.py tudienvannang-backend-1:/tmp/
docker exec -w /app tudienvannang-backend-1 python3 /tmp/coverage_probe.py
REMOTE
