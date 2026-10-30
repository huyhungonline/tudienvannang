"""Structured quiz content with legacy response fields for existing clients."""
import json
from pathlib import PurePosixPath
import re

import db

# Prefer the imported bank when present; retain older rows without serving
# duplicate questions from the old IT Passport seed.
BANK_SCOPE = """(q.source_key IS NOT NULL OR NOT EXISTS (
    SELECT 1 FROM certificate_exam_questions imported
    WHERE imported.certificate_id=q.certificate_id AND imported.source_key IS NOT NULL))"""
CONTENT_COLUMNS = """q.*, p.source_key AS passage_key, p.text_ja AS passage_ja,
    p.text_vi AS passage_vi, p.assets_json AS passage_assets"""
PASSAGE_JOIN = "LEFT JOIN certificate_passages p ON p.id=q.passage_id"


def decoded(value, default):
    return json.loads(value) if isinstance(value,str) else (default if value is None else value)


def assets(value):
    result=[]
    for item in decoded(value,[]):
        filename=PurePosixPath(item.get('path','')).name
        if re.fullmatch(r'\d{4}[a-z0-9_]+_ip_qs\.pdf',filename):
            result.append(dict(type='pdf_page',url=f'/api/certificates/documents/{filename}',
                               pages=item.get('pages',[])))
    return result


def public_question(row, include_translation=False):
    options=decoded(row.get('options_json'),[])
    passage=None
    if row.get('passage_key'):
        passage=dict(id=row['passage_key'],text={'ja':row['passage_ja']},
                     assets=assets(row.get('passage_assets')))
        if include_translation:
            passage['text']['vi']=row['passage_vi']
    body=row['question_ja']
    if options:
        body+='\n'+'\n'.join(f"{o['id']} ({o['label']}) {o['ja']}" for o in options)
    if passage:
        body=passage['text']['ja']+'\n\n'+body
    result=dict(id=row['id'],sourceKey=row.get('source_key'),questionNo=row['question_no'],
                questionJa=body,question={'ja':row['question_ja']},
                options=[{k:o[k] for k in (('id','label','ja','vi') if include_translation else ('id','label','ja'))}
                         for o in options],
                knowledgeGroup=row.get('knowledge_group'),assets=assets(row.get('assets_json')),
                passage=passage,reviewStatus=row.get('review_status'))
    if include_translation:
        result['question']['vi']=row['translation_vi']
    return result


def answer_details(row):
    options=decoded(row.get('options_json'),[])
    correct=next((o['id'] for o in options if o['label']==row['answer_label']),None)
    return dict(translationVi=row['translation_vi'],answerLabel=row['answer_label'],
                correctOptionId=correct,explanationVi=row['explanation_vi'],
                vocab=decoded(row.get('vocab_json'),[]),options=options,
                reviewNotes=decoded(row.get('review_notes_json'),[]))


async def exam_questions(certificate_id, exam=None, topic=None):
    return await db.query(f'''SELECT {CONTENT_COLUMNS} FROM certificate_exam_questions q
        {PASSAGE_JOIN} LEFT JOIN certificate_exams e ON e.id=q.exam_id
        WHERE q.certificate_id=$1 AND {BANK_SCOPE}
        AND ($2::text IS NULL OR e.source_key=$2)
        AND ($3::text IS NULL OR q.knowledge_group=$3)
        ORDER BY q.exam_year,q.exam_round,q.question_no''',certificate_id,exam,topic)
