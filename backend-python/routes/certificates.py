import json
import uuid
import os
import re
from pathlib import Path
from typing import Optional

from fastapi import APIRouter, Depends, HTTPException, Query
from fastapi.responses import FileResponse
from pydantic import BaseModel

import db
from middleware.auth import get_current_user
from services import mock_exam_service
from services import quiz_content_service as content

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
async def get_exam_questions(code: str, _: str = Depends(require_vip_or_admin),
                             exam: Optional[str] = Query(default=None),
                             knowledge_group: Optional[str] = Query(default=None)):
    """Return exam questions grouped by exam session, WITHOUT the hidden
    translation/answer/explanation/vocab fields — those are only revealed via
    the exam-question/{id}/answer endpoint when the user clicks 'Show answer'."""
    cert = await db.query_one("SELECT id FROM certificates WHERE code = $1", code)
    if not cert:
        raise HTTPException(status_code=404, detail="Certificate not found")

    rows = await content.exam_questions(cert['id'],exam,knowledge_group)

    grouped: dict[tuple, dict] = {}
    order: list[tuple] = []
    for r in rows:
        key = (r["exam_year"], r["exam_round"])
        if key not in grouped:
            grouped[key] = {"year": r["exam_year"], "round": r["exam_round"], "questions": []}
            order.append(key)
        grouped[key]["questions"].append(
            content.public_question(r)
        )

    return {"exams": [grouped[k] for k in order]}


@router.get("/exam-question/{question_id}/answer")
async def get_exam_answer(question_id: int, _: str = Depends(require_vip_or_admin)):
    """Reveal the hidden answer/translation/explanation/vocab for one question."""
    row = await db.query_one(
        f"SELECT {content.CONTENT_COLUMNS} FROM certificate_exam_questions q "
        f"{content.PASSAGE_JOIN} WHERE q.id = $1",
        question_id,
    )
    if not row:
        raise HTTPException(status_code=404, detail="Question not found")

    return {**content.answer_details(row),
            'passage':content.public_question(row,include_translation=True)['passage']}


@router.get('/documents/{filename}')
async def get_exam_document(filename: str):
    if not re.fullmatch(r'\d{4}[a-z0-9_]+_ip_qs\.pdf',filename):
        raise HTTPException(status_code=404,detail='Document not found')
    directory=Path(os.getenv('EXAM_PDFS_PATH',str(Path(__file__).resolve().parents[2]/'tool/IT-PP')))
    if not directory.is_dir() and 'EXAM_PDFS_PATH' not in os.environ:
        directory=Path('/exam_pdfs')
    path=directory/filename
    if not path.is_file():
        raise HTTPException(status_code=404,detail='Document not found')
    return FileResponse(path,media_type='application/pdf',filename=filename,content_disposition_type='inline')


@router.get('/{code}/topics')
async def get_exam_topics(code: str, _: str = Depends(require_vip_or_admin)):
    cert=await mock_exam_service.get_certificate_by_code(code)
    if not cert:
        raise HTTPException(status_code=404,detail='Certificate not found')
    rows=await db.query(f'''SELECT q.knowledge_group AS topic,count(*) AS count
        FROM certificate_exam_questions q WHERE q.certificate_id=$1 AND {content.BANK_SCOPE}
        AND q.knowledge_group IS NOT NULL GROUP BY q.knowledge_group ORDER BY q.knowledge_group''',cert['id'])
    return {'topics':rows}


@router.get('/{code}/exams')
async def list_structured_exams(code: str, _: str = Depends(require_vip_or_admin)):
    cert=await mock_exam_service.get_certificate_by_code(code)
    if not cert:
        raise HTTPException(status_code=404,detail='Certificate not found')
    return {'exams':await db.query('''SELECT e.source_key AS code,e.exam_year AS year,
        e.exam_round AS round,count(q.id) AS question_count FROM certificate_exams e
        JOIN certificate_exam_questions q ON q.exam_id=e.id WHERE e.certificate_id=$1
        GROUP BY e.id ORDER BY e.source_key''',cert['id'])}


# === Mock exam (thi thử) ===

class MockExamAnswer(BaseModel):
    questionId: int
    selectedLabel: Optional[str] = None


class MockExamSubmission(BaseModel):
    answers: list[MockExamAnswer]
    durationSeconds: Optional[int] = None


@router.get("/{code}/mock-exam/info")
async def get_mock_exam_info(code: str, _: str = Depends(require_vip_or_admin)):
    """Real-exam format for the start screen: paper size and time limit."""
    cert = await mock_exam_service.get_certificate_by_code(code)
    if not cert:
        raise HTTPException(status_code=404, detail="Certificate not found")

    config = await mock_exam_service.get_exam_config(cert["id"])
    return {
        "certificate": {"code": cert["code"], "nameJa": cert["name_ja"], "nameVi": cert["name_vi"]},
        "config": config,
    }


@router.get("/{code}/mock-exam/start")
async def start_mock_exam(code: str, _: str = Depends(require_vip_or_admin)):
    """Build a randomised paper sized to the real exam format.

    Deliberately excludes all answer fields so the correct answers cannot be
    read from the network response before the paper is submitted.
    """
    cert = await mock_exam_service.get_certificate_by_code(code)
    if not cert:
        raise HTTPException(status_code=404, detail="Certificate not found")

    config = await mock_exam_service.get_exam_config(cert["id"])
    if config["effectiveCount"] == 0:
        raise HTTPException(status_code=404, detail="No questions available")

    questions = await mock_exam_service.build_paper(cert["id"], config["effectiveCount"])

    return {
        "certificate": {"code": cert["code"], "nameJa": cert["name_ja"], "nameVi": cert["name_vi"]},
        "config": config,
        "questions": questions,
    }


@router.post("/{code}/mock-exam/submit")
async def submit_mock_exam(
    code: str,
    body: MockExamSubmission,
    user_id: str = Depends(require_vip_or_admin),
):
    """Grade a paper. IT Passport does not persist attempts or send emails."""
    cert = await mock_exam_service.get_certificate_by_code(code)
    if not cert:
        raise HTTPException(status_code=404, detail="Certificate not found")

    try:
        return await mock_exam_service.grade_attempt(
            user_id,
            cert["id"],
            [a.model_dump() for a in body.answers],
            body.durationSeconds,
            persist=code != 'itpp',
        )
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))


@router.get("/{code}/mock-exam/history")
async def get_mock_exam_history(code: str, user_id: str = Depends(require_vip_or_admin)):
    """Recent attempts for the signed-in user on this certificate."""
    cert = await mock_exam_service.get_certificate_by_code(code)
    if not cert:
        raise HTTPException(status_code=404, detail="Certificate not found")

    if code == 'itpp':
        return {'attempts':[]}
    attempts = await mock_exam_service.list_user_attempts(user_id, cert["id"])
    return {"attempts": attempts}
