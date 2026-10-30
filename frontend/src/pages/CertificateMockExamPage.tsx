import { useState, useEffect, useCallback, useRef } from 'react';
import { useParams, Link } from 'react-router-dom';
import { get, post } from '../api/client';
import { Spinner } from '../components/Spinner';
import { ExamPdfLinks, type ExamPdfReferences } from '../components/ExamPdfLinks';
import { CbtSession, type CbtQuestion } from '../components/CbtSession';

interface ExamConfig {
  configuredCount: number;
  effectiveCount: number;
  availableCount: number;
  durationMinutes: number;
  requiredAnswers: number | null;
  note: string | null;
  isShortOfPool: boolean;
}

type MockQuestion = CbtQuestion;

interface VocabItem {
  term: string;
  reading: string;
  meaning: string;
}

interface QuestionResult extends ExamPdfReferences {
  questionId: number;
  questionNo: number;
  questionJa: string;
  selectedLabel: string;
  correctLabel: string;
  isCorrect: boolean;
  translationVi: string;
  explanationVi: string;
  vocab: VocabItem[];
  options?: { id: string; label: string; vi: string }[];
}

interface GradeResult {
  attemptId: number | null;
  totalQuestions: number;
  correctCount: number;
  scorePercent: number;
  durationSeconds: number | null;
  results: QuestionResult[];
}

interface AttemptHistory {
  attemptId: number;
  totalQuestions: number;
  correctCount: number;
  scorePercent: number;
  durationSeconds: number | null;
  finishedAt: string;
}

type Phase = 'setup' | 'taking' | 'result';

function formatClock(seconds: number): string {
  const safe = Math.max(0, seconds);
  const m = Math.floor(safe / 60);
  const s = safe % 60;
  return `${m}:${String(s).padStart(2, '0')}`;
}

function formatDuration(seconds: number | null): string {
  if (seconds == null) return '—';
  return formatClock(seconds);
}

export function CertificateMockExamPage() {
  const { category, code } = useParams<{ category: string; code: string }>();

  const [phase, setPhase] = useState<Phase>('setup');
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const [config, setConfig] = useState<ExamConfig | null>(null);
  const [certName, setCertName] = useState('');
  const [history, setHistory] = useState<AttemptHistory[]>([]);

  const [questions, setQuestions] = useState<MockQuestion[]>([]);
  const [selections, setSelections] = useState<Record<number, string>>({});
  const [startedAt, setStartedAt] = useState(0);
  const [remaining, setRemaining] = useState(0);
  const [submitting, setSubmitting] = useState(false);

  const [result, setResult] = useState<GradeResult | null>(null);
  const [reviewFilter, setReviewFilter] = useState<'all' | 'wrong'>('wrong');

  // Guards against the timer firing submit twice, or submitting after
  // the learner has already pressed the button.
  const submittedRef = useRef(false);

  const loadInfo = useCallback(() => {
    if (!code) return;
    setLoading(true);
    setError(null);
    Promise.all([
      get<{ certificate: { nameJa: string }; config: ExamConfig }>(
        `/certificates/${code}/mock-exam/info`
      ),
      (code === 'itpp' ? Promise.resolve({ attempts: [] as AttemptHistory[] }) : get<{ attempts: AttemptHistory[] }>(`/certificates/${code}/mock-exam/history`)).catch(
        () => ({ attempts: [] as AttemptHistory[] })
      ),
    ])
      .then(([info, hist]) => {
        setConfig(info.config);
        setCertName(info.certificate.nameJa);
        setHistory(hist.attempts);
      })
      .catch(() => setError('Không tải được thông tin đề thi.'))
      .finally(() => setLoading(false));
  }, [code]);

  useEffect(loadInfo, [loadInfo]);

  const handleSubmit = useCallback(
    async (auto = false) => {
      if (!code || submittedRef.current) return;
      submittedRef.current = true;
      setSubmitting(true);
      setError(null);
      try {
        const data = await post<GradeResult>(`/certificates/${code}/mock-exam/submit`, {
          answers: questions.map((q) => ({
            questionId: q.id,
            selectedLabel: selections[q.id] ?? null,
          })),
          durationSeconds: Math.floor((Date.now() - startedAt) / 1000),
        });
        setResult(data);
        setPhase('result');
        setReviewFilter(data.correctCount === data.totalQuestions ? 'all' : 'wrong');
        if (auto) {
          setError('Đã hết thời gian — bài thi được nộp tự động.');
        }
        window.scrollTo({ top: 0, behavior: 'smooth' });
      } catch {
        setError('Không gửi được bài thi. Vui lòng thử lại.');
        submittedRef.current = false;
      } finally {
        setSubmitting(false);
      }
    },
    [code, questions, selections, startedAt]
  );

  // Countdown; auto-submits when it reaches zero.
  useEffect(() => {
    if (phase !== 'taking' || !config) return;
    const limit = config.durationMinutes * 60;
    const tick = () => {
      const left = limit - Math.floor((Date.now() - startedAt) / 1000);
      setRemaining(left);
      if (left <= 0) {
        handleSubmit(true);
      }
    };
    tick();
    const t = setInterval(tick, 1000);
    return () => clearInterval(t);
  }, [phase, config, startedAt, handleSubmit]);

  const handleStart = useCallback(async () => {
    if (!code) return;
    setError(null);
    setLoading(true);
    try {
      const data = await get<{ config: ExamConfig; questions: MockQuestion[] }>(
        `/certificates/${code}/mock-exam/start`
      );
      if (!data.questions.length) throw new Error("No questions");
      setConfig(data.config);
      setQuestions(data.questions);
      setSelections({});
      submittedRef.current = false;
      setStartedAt(Date.now());
      setRemaining(data.config.durationMinutes * 60);
      setPhase('taking');
      window.scrollTo({ top: 0 });
    } catch {
      setError('Không bắt đầu được bài thi.');
    } finally {
      setLoading(false);
    }
  }, [code]);

  if (loading && phase === 'setup') {
    return (
      <div className="reading-posts-page certificate-page">
        <p className="loading-text"><Spinner /> Loading...</p>
      </div>
    );
  }

  // ---------- SETUP ----------
  if (phase === 'setup') {
    return (
      <div className="reading-posts-page certificate-page mock-exam-page cbt-intro">
        <Link to={`/certificates/${category}/${code}`} className="btn-back">← Quay lại</Link>
        <span className="cbt-eyebrow">{code === 'itpp' ? 'IT PASSPORT · LUYỆN THI CBT' : 'LUYỆN THI CHỨNG CHỈ · CBT'}</span>
        <h2>Mô phỏng phòng thi</h2>
        {certName && <p className="certificate-subtitle">{certName}</p>}

        {error && <div className="form-error">{error}</div>}

        {config && (
          <div className="mock-setup-box">
            <div className="mock-format">
              <div className="mock-format-item">
                <span className="mock-format-value">{config.effectiveCount}</span>
                <span className="mock-format-label">câu hỏi</span>
              </div>
              <div className="mock-format-item">
                <span className="mock-format-value">{config.durationMinutes}</span>
                <span className="mock-format-label">phút</span>
              </div>
            </div>

            {config.requiredAnswers && (
              <p className="mock-format-note">
                Đề thi thật có {config.configuredCount} câu, thí sinh chỉ cần trả lời{' '}
                {config.requiredAnswers} câu.
              </p>
            )}

            {config.isShortOfPool && (
              <p className="mock-format-warning">
                Đề thi thật có {config.configuredCount} câu, nhưng kho hiện chỉ có{' '}
                {config.availableCount} câu nên bài thi thử sẽ gồm {config.effectiveCount} câu.
              </p>
            )}

            <button
              className="btn-submit mock-start-btn"
              onClick={handleStart}
              disabled={config.effectiveCount === 0}
            >
              Bắt đầu thi thử
            </button>
            {config.effectiveCount === 0 && (
              <p className="empty-state">Chứng chỉ này chưa có câu hỏi.</p>
            )}
          </div>
        )}

        <div className="mock-note">
          Mỗi lần một câu. Bạn có thể chuyển câu, đánh dấu xem lại và đổi đáp án trước khi nộp. Hết giờ, bài sẽ tự động được chấm.
        </div>

        {history.length > 0 && (
          <div className="mock-history">
            <h3>Lần thi trước</h3>
            <table className="result-table">
              <thead>
                <tr><th>Thời điểm</th><th>Điểm</th><th>Đúng</th><th>Thời gian</th></tr>
              </thead>
              <tbody>
                {history.map((h) => (
                  <tr key={h.attemptId}>
                    <td>{new Date(h.finishedAt).toLocaleString('vi-VN')}</td>
                    <td><strong>{h.scorePercent}%</strong></td>
                    <td>{h.correctCount}/{h.totalQuestions}</td>
                    <td>{formatDuration(h.durationSeconds)}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
    );
  }

  // One question at a time, with answers held only in this session.
  if (phase === 'taking') {
    return <CbtSession title={certName} questions={questions} selections={selections}
      remaining={remaining} submitting={submitting} error={error}
      onSelect={(id, label) => setSelections(previous => {
        const next = { ...previous };
        if (label === null) delete next[id]; else next[id] = label;
        return next;
      })}
      onSubmit={() => handleSubmit(false)} />;
  }

  // ---------- RESULT ----------
  const shown = result
    ? reviewFilter === 'wrong'
      ? result.results.filter((r) => !r.isCorrect)
      : result.results
    : [];

  return (
    <div className="reading-posts-page certificate-page mock-exam-page">
      <Link to={`/certificates/${category}/${code}`} className="btn-back">← Quay lại</Link>
      <h2>Kết quả thi thử</h2>

      {error && <div className="form-error">{error}</div>}

      {result && (
        <>
          <div className="mock-score-card">
            <div className="mock-score-main">{result.scorePercent}%</div>
            <div className="mock-score-detail">
              Đúng {result.correctCount}/{result.totalQuestions} câu
              <br />Thời gian làm bài: {formatDuration(result.durationSeconds)}
            </div>
          </div>

          <div className="mock-result-actions">
            <button
              className="btn-submit"
              onClick={() => {
                setResult(null);
                setError(null);
                setPhase('setup');
                loadInfo();
              }}
            >
              Thi lại
            </button>
            <div className="mock-review-tabs">
              <button
                className={`vocab-category-tab ${reviewFilter === 'wrong' ? 'active' : ''}`}
                onClick={() => setReviewFilter('wrong')}
              >
                Câu sai ({result.totalQuestions - result.correctCount})
              </button>
              <button
                className={`vocab-category-tab ${reviewFilter === 'all' ? 'active' : ''}`}
                onClick={() => setReviewFilter('all')}
              >
                Tất cả ({result.totalQuestions})
              </button>
            </div>
          </div>

          {shown.length === 0 ? (
            <p className="empty-state">Không có câu nào trong mục này.</p>
          ) : (
            <div className="exam-question-list">
              {shown.map((r) => (
                <div
                  key={r.questionId}
                  className={`exam-question-card mock-result-card ${r.isCorrect ? 'is-correct' : 'is-wrong'}`}
                >
                  <div className="exam-question-header">
                    <span className="exam-question-no">
                      {r.isCorrect ? '✅' : '❌'} 問{r.questionNo}
                    </span>
                    <p className="exam-question-text">{r.questionJa}</p>
                  </div>
                  <ExamPdfLinks assets={r.assets} passage={r.passage} />

                  <div className="mock-answer-row">
                    <span className="mock-answer-chip">
                      Bạn chọn: <strong>{r.selectedLabel || '(không trả lời)'}</strong>
                    </span>
                    <span className="mock-answer-chip correct">
                      Đáp án: <strong>{r.correctLabel}</strong>
                    </span>
                  </div>

                  <div className="exam-answer-reveal">
                    {r.translationVi && <p className="exam-translation">Dịch đề: {r.translationVi}</p>}
                    {r.options && <ul>{r.options.map((o) => <li key={o.id}>{o.label} {o.vi}</li>)}</ul>}
                    {r.passage?.text?.vi && <p className="exam-translation">{r.passage.text.vi}</p>}
                    {r.explanationVi && <p className="exam-explanation">Giải thích: {r.explanationVi}</p>}
                    {r.vocab.length > 0 && (
                      <table className="result-table exam-vocab-table">
                        <thead>
                          <tr><th>Từ/cụm từ</th><th>Cách đọc</th><th>Nghĩa</th></tr>
                        </thead>
                        <tbody>
                          {r.vocab.map((v, i) => (
                            <tr key={i}>
                              <td>{v.term}</td>
                              <td>{v.reading}</td>
                              <td>{v.meaning}</td>
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    )}
                  </div>
                </div>
              ))}
            </div>
          )}
        </>
      )}
    </div>
  );
}
