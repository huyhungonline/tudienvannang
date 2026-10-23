import json
import uuid
from typing import Optional

from fastapi import APIRouter, Depends, HTTPException, Query
from pydantic import BaseModel

import db
from middleware.auth import get_current_user
from services import mock_exam_service

router = APIRouter(prefix="/api/certificates", tags=["certificates"])


async def require_vip_or_admin(user_id: str = Depends(get_current_user)) -> str:
    """Certificate vocabulary/exam content is restricted to VIP or admin accounts."""
    row = await db.query_one(
        "SELECT is_admin, is_vip FROM users WHERE id = $1", uuid.UUID(user_id)
    )
    if not row or not (row.get("is_admin") or row.get("is_vip")):
        raise HTTPException(status_code=403, detail="VIP or admin account required")
    return user_id

# Fixed top-level menu shown under header "Professional Fields"
CATEGORIES = [
    {"code": "cokhi", "labelJa": "機械系", "labelVi": "Cơ khí, CNC, vận hành máy, đúc", "labelEn": "Mechanical, CNC, Machine Operation, Casting"},
    {"code": "dien", "labelJa": "電気系", "labelVi": "Điện, cơ điện tử, PLC, vận hành điện", "labelEn": "Electrical, Mechatronics, PLC, Electrical Operation"},
    {"code": "xaydung", "labelJa": "建築系", "labelVi": "Xây dựng, kiến trúc, giàn giáo", "labelEn": "Construction, Architecture, Scaffolding"},
    {"code": "thucpham", "labelJa": "食品系", "labelVi": "Thực phẩm, quản lý sản xuất", "labelEn": "Food, Production Management"},
    {"code": "itpp", "labelJa": "IT・通信系", "labelVi": "IT và Viễn thông", "labelEn": "IT and Telecommunications"},
]


@router.get("/categories")
async def get_categories():
    return {"categories": CATEGORIES}


@router.get("")
async def list_certificates(category: Optional[str] = Query(default=None)):
    if category:
        rows = await db.query(
            "SELECT id, code, category, name_ja, name_vi FROM certificates WHERE category = $1 ORDER BY name_ja",
            category,
        )
    else:
        rows = await db.query(
            "SELECT id, code, category, name_ja, name_vi FROM certificates ORDER BY category, name_ja"
        )
    return {"certificates": rows}


@router.get("/{code}")
async def get_certificate(code: str):
    row = await db.query_one(
        "SELECT id, code, category, name_ja, name_vi, related_occupations FROM certificates WHERE code = $1",
        code,
    )
    if not row:
        raise HTTPException(status_code=404, detail="Certificate not found")
    return row


@router.get("/{code}/vocabulary")
async def get_vocabulary(code: str):
    """Return vocabulary entries grouped by category."""
    cert = await db.query_one("SELECT id FROM certificates WHERE code = $1", code)
    if not cert:
        raise HTTPException(status_code=404, detail="Certificate not found")

    rows = await db.query(
        "SELECT category_no, category_name, term_ja, reading, meaning_vi, "
        "example_ja, example_reading, example_vi "
        "FROM certificate_vocabulary WHERE certificate_id = $1 ORDER BY sort_order",
        cert["id"],
    )

    grouped: dict[int, dict] = {}
    order: list[int] = []
    for r in rows:
        key = r["category_no"]
        if key not in grouped:
            grouped[key] = {"categoryNo": key, "categoryName": r["category_name"], "entries": []}
            order.append(key)
        grouped[key]["entries"].append(
            {
                "term": r["term_ja"],
                "reading": r["reading"],
                "meaningVi": r["meaning_vi"],
                "exampleJa": r["example_ja"],
                "exampleReading": r["example_reading"],
                "exampleVi": r["example_vi"],
            }
        )

    return {"categories": [grouped[k] for k in order]}


@router.get("/{code}/exam")
async def get_exam_questions(code: str, _: str = Depends(require_vip_or_admin)):
    """Return exam questions grouped by exam session, WITHOUT the hidden
    translation/answer/explanation/vocab fields — those are only revealed via
    the exam-question/{id}/answer endpoint when the user clicks 'Show answer'."""
    cert = await db.query_one("SELECT id FROM certificates WHERE code = $1", code)
    if not cert:
        raise HTTPException(status_code=404, detail="Certificate not found")

    rows = await db.query(
        "SELECT id, exam_year, exam_round, question_no, question_ja "
        "FROM certificate_exam_questions WHERE certificate_id = $1 ORDER BY sort_order",
        cert["id"],
    )

    grouped: dict[tuple, dict] = {}
    order: list[tuple] = []
    for r in rows:
        key = (r["exam_year"], r["exam_round"])
        if key not in grouped:
            grouped[key] = {"year": r["exam_year"], "round": r["exam_round"], "questions": []}
            order.append(key)
        grouped[key]["questions"].append(
            {"id": r["id"], "questionNo": r["question_no"], "questionJa": r["question_ja"]}
        )

    return {"exams": [grouped[k] for k in order]}


@router.get("/exam-question/{question_id}/answer")
async def get_exam_answer(question_id: int, _: str = Depends(require_vip_or_admin)):
    """Reveal the hidden answer/translation/explanation/vocab for one question."""
    row = await db.query_one(
        "SELECT translation_vi, answer_label, explanation_vi, vocab_json "
        "FROM certificate_exam_questions WHERE id = $1",
        question_id,
    )
    if not row:
        raise HTTPException(status_code=404, detail="Question not found")

    return {
        "translationVi": row["translation_vi"],
        "answerLabel": row["answer_label"],
        "explanationVi": row["explanation_vi"],
        "vocab": json.loads(row["vocab_json"]),
    }


# === Mock exam (thi thử) ===

class MockExamAnswer(BaseModel):
    questionId: int
    selectedLabel: Optional[str] = None


class MockExamSubmission(BaseModel):
    answers: list[MockExamAnswer]
    durationSeconds: Optional[int] = None


@router.get("/{code}/mock-exam/sessions")
async def get_mock_exam_sessions(code: str, _: str = Depends(require_vip_or_admin)):
    """Available exam sessions plus the total pool size, for the start screen."""
    cert = await mock_exam_service.get_certificate_by_code(code)
    if not cert:
        raise HTTPException(status_code=404, detail="Certificate not found")

    sessions = await mock_exam_service.list_exam_sessions(cert["id"])
    total = sum(s["questionCount"] for s in sessions)
    return {
        "certificate": {"code": cert["code"], "nameJa": cert["name_ja"], "nameVi": cert["name_vi"]},
        "sessions": sessions,
        "totalQuestions": total,
    }


@router.get("/{code}/mock-exam/start")
async def start_mock_exam(
    code: str,
    limit: int = Query(default=20, ge=1, le=100),
    exam_year: Optional[str] = Query(default=None),
    exam_round: Optional[str] = Query(default=None),
    _: str = Depends(require_vip_or_admin),
):
    """Build a randomised paper. Deliberately excludes all answer fields so the
    correct answers cannot be read from the network response."""
    cert = await mock_exam_service.get_certificate_by_code(code)
    if not cert:
        raise HTTPException(status_code=404, detail="Certificate not found")

    questions = await mock_exam_service.build_paper(cert["id"], limit, exam_year, exam_round)
    if not questions:
        raise HTTPException(status_code=404, detail="No questions available")

    return {
        "certificate": {"code": cert["code"], "nameJa": cert["name_ja"], "nameVi": cert["name_vi"]},
        "questions": questions,
    }


@router.post("/{code}/mock-exam/submit")
async def submit_mock_exam(
    code: str,
    body: MockExamSubmission,
    user_id: str = Depends(require_vip_or_admin),
):
    """Grade a finished paper, store the attempt, and return a full review."""
    cert = await mock_exam_service.get_certificate_by_code(code)
    if not cert:
        raise HTTPException(status_code=404, detail="Certificate not found")

    try:
        return await mock_exam_service.grade_attempt(
            user_id,
            cert["id"],
            [a.model_dump() for a in body.answers],
            body.durationSeconds,
        )
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))


@router.get("/{code}/mock-exam/history")
async def get_mock_exam_history(code: str, user_id: str = Depends(require_vip_or_admin)):
    """Recent attempts for the signed-in user on this certificate."""
    cert = await mock_exam_service.get_certificate_by_code(code)
    if not cert:
        raise HTTPException(status_code=404, detail="Certificate not found")

    attempts = await mock_exam_service.list_user_attempts(user_id, cert["id"])
    return {"attempts": attempts}
