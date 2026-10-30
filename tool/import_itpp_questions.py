"""Validate and upsert quiz JSON into the application's PostgreSQL database.

--dry-run never connects or writes. --apply-migration applies migration 041 in
the same transaction as the import. Database credentials are loaded from .env.
"""
import argparse
import asyncio
import json
import os
import re
from pathlib import Path
from urllib.parse import urlsplit, urlunsplit

ROOT = Path(__file__).resolve().parents[1]
LABELS = 'アイウエ'
GROUPS = {'企業と法務', '経営戦略', 'システム戦略', '開発技術',
          'プロジェクトマネジメント', 'サービスマネジメント', '基礎理論',
          'コンピュータシステム', '技術要素'}


def require(condition, message):
    if not condition:
        raise ValueError(message)


def load_documents(directory):
    documents = []
    ids = set()
    for file in sorted(directory.glob('*_qs.json')):
        doc = json.loads(file.read_text(encoding='utf-8'))
        require(doc.get('schema_version') == 2, f'{file.name}: expected schema v2')
        require(re.fullmatch(r'\d{4}[a-z0-9]+', doc['exam']), 'Invalid exam code')
        require(doc['source_pdf'] == doc['exam']+'_ip_qs.pdf', 'Invalid PDF name')
        pids = set()
        for p in doc['passages']:
            require(p['id'] not in pids and all(p['text'][k].strip() for k in ('ja','vi')), 'Invalid passage')
            pids.add(p['id'])
        require([q['question_no'] for q in doc['questions']] == list(range(1,101)), 'Expected questions 1–100')
        for q in doc['questions']:
            require(q['id'] == f"{doc['exam']}-{q['question_no']:03d}" and q['id'] not in ids, 'Duplicate/invalid question ID')
            ids.add(q['id'])
            require(q['exam'] == doc['exam'], 'Wrong exam')
            require(q['knowledge_group'] in GROUPS, 'Invalid knowledge group')
            require(all(isinstance(q['question'][k],str) and q['question'][k].strip() for k in ('ja','vi')), 'Empty question')
            require(len(q['options']) == 4, 'Expected four choices')
            for i, o in enumerate(q['options']):
                require(o['id'] == 'ABCD'[i] and o['label'] == LABELS[i], 'Wrong option order')
                require(all(isinstance(o[k],str) and o[k].strip() for k in ('ja','vi')), 'Empty option')
            require(q['correct_option_id'] in 'ABCD' and len(q['correct_option_id']) == 1, 'Invalid answer')
            require(q['explanation_vi'].strip(), 'Empty explanation')
            require(q['passage_id'] is None or q['passage_id'] in pids, 'Missing passage')
        documents.append(doc)
    require(len(documents) == 17, 'Expected 17 exam files')
    require(len({d['exam'] for d in documents}) == 17, 'Duplicate exam')
    return documents


def dump(value):
    return json.dumps(value, ensure_ascii=False)


async def import_documents(connection, documents, apply_migration=False):
    async with connection.transaction():
        # Serialize concurrent runs of this importer.
        await connection.execute("SELECT pg_advisory_xact_lock(184170041)")
        if apply_migration:
            await connection.execute((ROOT/'backend-python/migrations/041_structured_certificate_exams.sql').read_text(encoding='utf-8'))
        cert = await connection.fetchval("SELECT id FROM certificates WHERE code='itpp'")
        require(cert is not None, 'IT Passport certificate not found; run existing migrations first')
        before = {r['source_key'] for r in await connection.fetch(
            'SELECT source_key FROM certificate_exam_questions WHERE certificate_id=$1 AND source_key IS NOT NULL', cert)}
        for doc in documents:
            exam = await connection.fetchval('''INSERT INTO certificate_exams
                (certificate_id,source_key,exam_year,exam_round,source_pdf,answer_pdf,metadata_json)
                VALUES ($1,$2,$3,$4,$5,$6,$7::jsonb)
                ON CONFLICT (certificate_id,source_key) DO UPDATE SET
                exam_year=EXCLUDED.exam_year,exam_round=EXCLUDED.exam_round,
                source_pdf=EXCLUDED.source_pdf,answer_pdf=EXCLUDED.answer_pdf,metadata_json=EXCLUDED.metadata_json
                RETURNING id''', cert, doc['exam'], doc['exam'][:4], doc['exam'][4:],
                doc['source_pdf'], doc['answer_pdf'], dump({'schema_version':2,'model':doc.get('model')}))
            passages = {}
            for p in doc['passages']:
                passages[p['id']] = await connection.fetchval('''INSERT INTO certificate_passages
                    (exam_id,source_key,text_ja,text_vi,assets_json,review_status)
                    VALUES ($1,$2,$3,$4,$5::jsonb,$6)
                    ON CONFLICT (exam_id,source_key) DO UPDATE SET text_ja=EXCLUDED.text_ja,
                    text_vi=EXCLUDED.text_vi,assets_json=EXCLUDED.assets_json,review_status=EXCLUDED.review_status
                    RETURNING id''', exam,p['id'],p['text']['ja'],p['text']['vi'],dump(p['assets']),p['review_status'])
            for q in doc['questions']:
                await connection.execute('''INSERT INTO certificate_exam_questions
                    (certificate_id,source_key,exam_id,passage_id,exam_year,exam_round,question_no,
                     question_ja,translation_vi,answer_label,answer_correct,explanation_vi,
                     sort_order,options_json,knowledge_group,assets_json,source_json,review_notes_json,review_status)
                    VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,NULL,$11,$12,$13::jsonb,$14,$15::jsonb,$16::jsonb,$17::jsonb,$18)
                    ON CONFLICT (certificate_id,source_key) DO UPDATE SET
                    exam_id=EXCLUDED.exam_id,passage_id=EXCLUDED.passage_id,
                    exam_year=EXCLUDED.exam_year,exam_round=EXCLUDED.exam_round,question_no=EXCLUDED.question_no,
                    question_ja=EXCLUDED.question_ja,translation_vi=EXCLUDED.translation_vi,
                    answer_label=EXCLUDED.answer_label,answer_correct=NULL,explanation_vi=EXCLUDED.explanation_vi,
                    sort_order=EXCLUDED.sort_order,options_json=EXCLUDED.options_json,
                    knowledge_group=EXCLUDED.knowledge_group,assets_json=EXCLUDED.assets_json,
                    source_json=EXCLUDED.source_json,review_notes_json=EXCLUDED.review_notes_json,review_status=EXCLUDED.review_status''',
                    cert,q['id'],exam,passages.get(q['passage_id']),doc['exam'][:4],doc['exam'][4:],q['question_no'],
                    q['question']['ja'],q['question']['vi'],LABELS['ABCD'.index(q['correct_option_id'])],
                    q['explanation_vi'],int(doc['exam'][:4])*10000+documents.index(doc)*100+q['question_no'],
                    dump(q['options']),q['knowledge_group'],dump(q['assets']),dump(q['source']),
                    dump(q.get('review_notes',[])),q['review_status'])
        expected = {q['id']:q for d in documents for q in d['questions']}
        stored = await connection.fetch('''SELECT source_key,answer_label,options_json FROM certificate_exam_questions
            WHERE certificate_id=$1 AND source_key=ANY($2::text[])''',cert,list(expected))
        require(len(stored) == 1700, 'Post-import count mismatch')
        for row in stored:
            q = expected[row['source_key']]
            require(row['answer_label'] == LABELS['ABCD'.index(q['correct_option_id'])], 'Answer mismatch')
            require(json.loads(row['options_json']) == q['options'], 'Options mismatch')
        return dict(exams=17,passages=sum(len(d['passages']) for d in documents),questions=len(stored),
                    inserted=len(set(expected)-before),updated=len(set(expected)&before),options=6800)


async def bootstrap_certificate_tables(connection):
    """Initialize only certificate prerequisites on older local databases."""
    baseline=(ROOT/'backend-python/migrations/016_certificates.sql').read_text(encoding='utf-8').split('\nINSERT INTO certificates')[0]
    await connection.execute(baseline)
    await connection.execute((ROOT/'backend-python/migrations/018_exam_answer_label.sql').read_text(encoding='utf-8'))
    await connection.execute('ALTER TABLE certificates ADD COLUMN IF NOT EXISTS related_occupations TEXT')
    await connection.execute("""INSERT INTO certificates(code,category,name_ja,name_vi)
        VALUES ('itpp','itpp','ITパスポート試験','Kỳ thi IT Passport') ON CONFLICT (code) DO NOTHING""")
    config_sql=(ROOT/'backend-python/migrations/037_certificate_exam_config.sql').read_text(encoding='utf-8')
    await connection.execute(config_sql.split('-- Seed from')[0])
    await connection.execute('''INSERT INTO certificate_exam_config(certificate_id,question_count,duration_minutes)
        SELECT id,100,120 FROM certificates WHERE code='itpp'
        ON CONFLICT (certificate_id) DO NOTHING''')
    if await connection.fetchval("SELECT to_regclass('users') IS NOT NULL"):
        # Add the authorization fields required by the existing certificate API,
        # without granting admin/VIP rights to any account.
        await connection.execute('''ALTER TABLE users
            ADD COLUMN IF NOT EXISTS is_admin BOOLEAN NOT NULL DEFAULT FALSE,
            ADD COLUMN IF NOT EXISTS is_vip BOOLEAN NOT NULL DEFAULT FALSE''')


async def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--dir',type=Path,default=ROOT/'tool/structured')
    parser.add_argument('--dry-run',action='store_true')
    parser.add_argument('--apply-migration',action='store_true')
    parser.add_argument('--db-host',help='Override container hostname when importing through a published port')
    parser.add_argument('--bootstrap-base',action='store_true',help='Initialize certificate tables on an older database; no legacy seed content is loaded')
    args=parser.parse_args()
    docs=load_documents(args.dir)
    if args.dry_run:
        print(dump(dict(valid=True,exams=len(docs),questions=1700,options=6800,
                        passages=sum(len(d['passages']) for d in docs),database_writes=False)))
        return
    import asyncpg
    from dotenv import load_dotenv
    load_dotenv(ROOT/'.env')
    require(bool(os.getenv('DATABASE_URL')), 'DATABASE_URL must be configured')
    dsn=os.environ['DATABASE_URL']
    if args.db_host:
        parsed=urlsplit(dsn)
        credentials=parsed.netloc.rpartition('@')[0]
        host=args.db_host
        if ':' in host:
            host='['+host+']'
        netloc=(credentials+'@' if credentials else '')+host+(':'+str(parsed.port) if parsed.port else '')
        dsn=urlunsplit(parsed._replace(netloc=netloc))
    connection=await asyncpg.connect(dsn,timeout=15)
    try:
        async with connection.transaction():
            if args.bootstrap_base:
                await bootstrap_certificate_tables(connection)
            report=await import_documents(connection,docs,args.apply_migration)
        print(dump(report))
        (ROOT/'tool/structured/database_import_report.json').write_text(dump(report)+'\n',encoding='utf-8')
    finally:
        await connection.close()


if __name__ == '__main__':
    asyncio.run(main())
