"""Integration checks in a temporary PostgreSQL schema rolled back on exit.

Run from repo root with backend dependencies installed:
  python test/test_itpp_database.py
ITPP_TEST_DB_HOST defaults to 127.0.0.1 (Docker's published PostgreSQL port).
"""
import asyncio
import json
import os
from pathlib import Path
import sys
import unittest
import uuid
from unittest.mock import AsyncMock, patch

ROOT=Path(__file__).resolve().parents[1]
sys.path[:0]=[str(ROOT/'backend-python'),str(ROOT/'tool')]

import asyncpg
from fastapi import FastAPI
import httpx
from config import DATABASE_URL
import db
from import_itpp_questions import load_documents, import_documents, bootstrap_certificate_tables
from routes import certificates
from services import mock_exam_service as mock
from services import quiz_content_service as content


class ImportValidationTests(unittest.TestCase):
    def test_all_sources_valid(self):
        docs=load_documents(ROOT/'tool/structured')
        self.assertEqual(sum(len(d['questions']) for d in docs),1700)


class PostgreSQLIntegrationTests(unittest.IsolatedAsyncioTestCase):
    async def asyncSetUp(self):
        self.connection=await asyncpg.connect(DATABASE_URL,host=os.getenv('ITPP_TEST_DB_HOST','127.0.0.1'),timeout=10)
        self.transaction=self.connection.transaction()
        await self.transaction.start()
        schema='itpp_test_'+uuid.uuid4().hex
        await self.connection.execute(f'CREATE SCHEMA {schema}')
        await self.connection.execute(f'SET LOCAL search_path TO {schema}')
        baseline=(ROOT/'backend-python/migrations/016_certificates.sql').read_text(encoding='utf-8').split('\nINSERT INTO certificates')[0]
        await self.connection.execute(baseline)
        await self.connection.execute((ROOT/'backend-python/migrations/018_exam_answer_label.sql').read_text(encoding='utf-8'))
        await self.connection.execute("INSERT INTO certificates(code,category,name_ja) VALUES ('itpp','itpp','IT'),('other','test','Other')")

    async def asyncTearDown(self):
        await self.transaction.rollback()
        await self.connection.close()

    async def test_import_idempotency_api_and_stateless_grading(self):
        docs=load_documents(ROOT/'tool/structured')
        first=await import_documents(self.connection,docs,apply_migration=True)
        self.assertEqual(first['inserted'],1700)
        ids=await self.connection.fetch('SELECT source_key,id FROM certificate_exam_questions ORDER BY id')
        second=await import_documents(self.connection,docs,apply_migration=True)
        self.assertEqual(second['inserted'],0)
        self.assertEqual(second['updated'],1700)
        self.assertEqual(ids,await self.connection.fetch('SELECT source_key,id FROM certificate_exam_questions ORDER BY id'))
        self.assertEqual(await self.connection.fetchval('SELECT count(*) FROM certificate_exams'),17)
        self.assertEqual(await self.connection.fetchval('SELECT count(*) FROM certificate_passages'),8)
        # The deployment script replays seed files; a future deploy must not
        # delete the structured bank imported by this feature.
        await self.connection.execute((ROOT/'backend-python/migrations/019_certificate_itpp.sql').read_text(encoding='utf-8'))
        self.assertEqual(await self.connection.fetchval('SELECT count(*) FROM certificate_exam_questions WHERE source_key IS NOT NULL'),1700)
        cert=await self.connection.fetchval("SELECT id FROM certificates WHERE code='itpp'")
        # Keep an old seed question, but exclude it from the imported bank.
        await self.connection.execute('''INSERT INTO certificate_exam_questions
            (certificate_id,exam_year,question_no,question_ja,translation_vi,answer_label,explanation_vi,sort_order)
            VALUES ($1,'2026',1,'legacy','legacy','ア','legacy',1)''',cert)
        async def query(sql,*args):
            return [dict(r) for r in await self.connection.fetch(sql,*args)]
        async def query_one(sql,*args):
            row=await self.connection.fetchrow(sql,*args)
            return dict(row) if row else None
        app=FastAPI()
        app.include_router(certificates.router)
        app.dependency_overrides[certificates.require_vip_or_admin]=lambda:'test-user'
        with patch.object(db,'query',side_effect=query), patch.object(db,'query_one',side_effect=query_one), \
             patch.object(db,'execute',new_callable=AsyncMock) as writes, \
             patch.object(mock,'_send_result_email',new_callable=AsyncMock) as email:
            transport=httpx.ASGITransport(app=app)
            async with httpx.AsyncClient(transport=transport,base_url='http://test') as api:
                exams=(await api.get('/api/certificates/itpp/exams')).json()['exams']
                self.assertEqual(len(exams),17)
                topics=(await api.get('/api/certificates/itpp/topics')).json()['topics']
                self.assertEqual(sum(t['count'] for t in topics),1700)
                filtered=await api.get('/api/certificates/itpp/exam',params={'exam':'2016h28a','knowledge_group':topics[0]['topic']})
                self.assertEqual(filtered.status_code,200)
                rows=[q for e in filtered.json()['exams'] for q in e['questions']]
                self.assertTrue(rows)
                self.assertTrue(all(q['knowledgeGroup']==topics[0]['topic'] for q in rows))
                self.assertNotIn('answerLabel',json.dumps(rows))
                self.assertNotIn('explanationVi',json.dumps(rows))
                paper=await mock.build_paper(cert,100)
                self.assertEqual(len(paper),100)
                self.assertTrue(all(len(q['choices'])==4 for q in paper))
                self.assertNotIn('correctOptionId',json.dumps(paper))
                qid=ids[0]['id']
                label=await self.connection.fetchval('SELECT answer_label FROM certificate_exam_questions WHERE id=$1',qid)
                answer=await api.get(f'/api/certificates/exam-question/{qid}/answer')
                option_id=answer.json()['correctOptionId']
                graded=await api.post('/api/certificates/itpp/mock-exam/submit',json={'answers':[{'questionId':qid,'selectedLabel':option_id}],'durationSeconds':5})
                self.assertEqual(graded.status_code,200)
                self.assertEqual(graded.json()['correctCount'],1)
                self.assertIsNone(graded.json()['attemptId'])
                writes.assert_not_awaited()
                email.assert_not_awaited()
                for answers in ([{'questionId':qid,'selectedLabel':label}]*2,
                                [{'questionId':99999999,'selectedLabel':'A'}],
                                [{'questionId':qid,'selectedLabel':'Z'}]):
                    bad=await api.post('/api/certificates/itpp/mock-exam/submit',json={'answers':answers})
                    self.assertEqual(bad.status_code,400)
                other=await api.post('/api/certificates/other/mock-exam/submit',json={'answers':[{'questionId':qid,'selectedLabel':'A'}]})
                self.assertEqual(other.status_code,400)
                history=await api.get('/api/certificates/itpp/mock-exam/history')
                self.assertEqual(history.json(),{'attempts':[]})
                docs_response=await api.get('/api/certificates/documents/2016h28a_ip_qs.pdf')
                self.assertEqual(docs_response.status_code,200)
                self.assertEqual(docs_response.headers['content-type'],'application/pdf')
        print('Integration passed: rollback schema; 1700 imports; repeat import; API; grading without writes/email')

    async def test_bootstrap_older_database(self):
        schema='itpp_bootstrap_'+uuid.uuid4().hex
        await self.connection.execute(f'CREATE SCHEMA {schema}')
        await self.connection.execute(f'SET LOCAL search_path TO {schema}')
        await self.connection.execute('CREATE TABLE users (id SERIAL PRIMARY KEY)')
        await self.connection.execute('INSERT INTO users DEFAULT VALUES')
        await bootstrap_certificate_tables(self.connection)
        await bootstrap_certificate_tables(self.connection)
        self.assertFalse(await self.connection.fetchval('SELECT is_admin OR is_vip FROM users LIMIT 1'))
        report=await import_documents(self.connection,load_documents(ROOT/'tool/structured'),apply_migration=True)
        self.assertEqual(report['inserted'],1700)
        self.assertEqual(await self.connection.fetchval('SELECT question_count FROM certificate_exam_config'),100)


if __name__=='__main__':
    unittest.main()
