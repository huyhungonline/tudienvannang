"""Verify imported content and stateless grading against the actual database."""
import asyncio
import json
import os
from pathlib import Path
import sys
import urllib.request

ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'backend-python'))
import db
from services import mock_exam_service as mock
from services import quiz_content_service as content


async def main():
    try:
        cert=await mock.get_certificate_by_code('itpp')
        assert cert
        rows=await db.query('SELECT * FROM certificate_exam_questions WHERE certificate_id=$1 AND source_key IS NOT NULL',cert['id'])
        expected={q['id']:q for file in (ROOT/'tool/structured').glob('*_qs.json')
                  for q in json.loads(file.read_text(encoding='utf-8'))['questions']}
        assert len(rows)==len(expected)==1700
        for row in rows:
            source=expected[row['source_key']]
            assert row['question_ja']==source['question']['ja']
            assert row['translation_vi']==source['question']['vi']
            assert row['knowledge_group']==source['knowledge_group']
            assert content.decoded(row['options_json'],[])==source['options']
            assert content.answer_details(row)['correctOptionId']==source['correct_option_id']
        counts=await db.query_one('''SELECT
            (SELECT count(*) FROM certificate_exams WHERE certificate_id=$1) AS exams,
            (SELECT count(*) FROM certificate_passages p JOIN certificate_exams e ON e.id=p.exam_id
             WHERE e.certificate_id=$1) AS passages''',cert['id'])
        assert counts=={'exams':17,'passages':8}
        config=await mock.get_exam_config(cert['id'])
        eligible=await content.exam_questions(cert['id'])
        assert 100 <= len(eligible) < 1700
        assert all(not content.decoded(r['assets_json'],[]) and not content.decoded(r['passage_assets'],[]) for r in eligible)
        assert config['availableCount']==len(eligible) and config['effectiveCount']==100
        exists=await db.query_one("SELECT to_regclass('mock_exam_attempts') IS NOT NULL AS present")
        before=await db.query_one('SELECT count(*) AS count FROM mock_exam_attempts') if exists['present'] else None
        result=await mock.grade_attempt('verification',cert['id'],[
            {'questionId':r['id'],'selectedLabel':expected[r['source_key']]['correct_option_id']} for r in eligible[:3]
        ],10,persist=False)
        assert result['attemptId'] is None and result['correctCount']==3
        after=await db.query_one('SELECT count(*) AS count FROM mock_exam_attempts') if exists['present'] else None
        assert before==after
        # The live container must serve the rebuilt API and the PDF volume.
        api_url=os.getenv('ITPP_API_URL','http://127.0.0.1:4000').rstrip('/')
        frontend_url=os.getenv('ITPP_FRONTEND_URL','http://127.0.0.1:3000').rstrip('/')
        for url in (api_url+'/api/health',api_url+'/api/certificates/itpp',frontend_url+'/'):
            with urllib.request.urlopen(url,timeout=10) as response:
                assert response.status==200
        with urllib.request.urlopen(api_url+'/api/certificates/documents/2016h28a_ip_qs.pdf',timeout=10) as response:
            assert response.status==200 and response.read(5)==b'%PDF-'
        report_file=ROOT/'tool/structured/database_import_report.json'
        report=json.loads(report_file.read_text(encoding='utf-8'))
        report.update(verified=True,verified_questions=len(rows),verified_options=4*len(rows),available_text_questions=len(eligible),
                      stateless_grading_verified=True,live_backend_verified=True,live_pdf_verified=True)
        report_file.write_text(json.dumps(report,ensure_ascii=False,indent=2),encoding='utf-8')
        print(json.dumps(report,ensure_ascii=False))
    finally:
        await db.close_pool()


if __name__=='__main__':
    asyncio.run(main())
