import { useState, useEffect, useCallback } from 'react';
import { useParams, Link } from 'react-router-dom';
import { get, post } from '../api/client';
import { Spinner } from '../components/Spinner';

interface ExamSessionInfo {
  year: string;
  round: string | null;
  questionCount: number;
}

interface MockQuestion {
  id: number;
  displayNo: number;
  questionNo: number;
  questionJa: string;
  isTrueFalse: boolean;
  choices: string[];
}

interface VocabItem {
  term: string;
  reading: string;
  meaning: string;
}

interface QuestionResult {
  questionId: number;
  questionNo: number;
  questionJa: string;
  selectedLabel: string;
  correctLabel: string;
  isCorrect: boolean;
  translationVi: string;
  explanationVi: string;
  vocab: VocabItem[];
}

interface GradeResult {
  attemptId: number;
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

const QUESTION_COUNT_OPTIONS = [10, 20, 30, 50];

function formatDuration(seconds: number | null): string {
  if (seconds == null) return '—';
  const m = Math.floor(seconds / 60);
  const s = seconds % 60;
  return `${m}:${String(s).padStart(2, '0')}`;
}

export function CertificateMockExamPage() {
  const { category, code } = useParams<{ category: string; code: string }>();

  const [phase, setPhase] = useState<Phase>('setup');
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  // Setup
  const [sessions, setSessions] = useState<ExamSessionInfo[]>([]);
  const [totalPool, setTotalPool] = useState(0);
  const [certName, setCertName] = useState('');
  const [selectedSession, setSelectedSession] = useState<string>('all');
  const [questionCount, setQuestionCount] = useState(20);
  const [history, setHistory] = useState<AttemptHistory[]>([]);

  // Taking
  const [questions, setQuestions] = useState<MockQuestion[]>([]);
  const [selections, setSelections] = useState<Record<number, string>>({});
  const [startedAt, setStartedAt] = useState<number>(0);
  const [elapsed, setElapsed] = useState(0);
  const [submitting, setSubmitting] = useState(false);

  // Result
  const [result, setResult] = useState<GradeResult | null>(null);
  const [reviewFilter, setReviewFilter] = useState<'all' | 'wrong'>('wrong');

  // Load available sessions and past attempts
  useEffect(() => {
    if (!code) return;
    setLoading(true);
    setError(null);
    Promise.all([
      get<{ certificate: { nameJa: string }; sessions: ExamSessionInfo[]; totalQuestions: number }>(
        `/certificates/${code}/mock-exam/sessions`
      ),
      get<{ attempts: AttemptHistory[] }>(`/certificates/${code}/mock-exam/history`).catch(
        () => ({ attempts: [] as AttemptHistory[] })
      ),
    ])
      .then(([info, hist]) => {
        setSessions(info.sessions);
        setTotalPool(info.totalQuestions);
        setCertName(info.certificate.nameJa);
        setHistory(hist.attempts);
      })
      .catch(() => setError('Không tải được dữ liệu đề thi.'))
      .finally(() => setLoading(false));
  }, [code]);

  // Timer while taking the exam
  useEffect(() => {
    if (phase !== 'taking') return;
    const t = setInterval(() => {
      setElapsed(Math.floor((Date.now() - startedAt) / 1000));
    }, 1000);
    return () => clearInterval(t);
  }, [phase, startedAt]);

  const handleStart = useCallback(async () => {
    if (!code) return;
    setError(null);
    setLoading(true);
    try {
      const params = new URLSearchParams({ limit: String(questionCount) });
      if (selectedSession !== 'all') {
        const s = sessions.find((x) => `${x.year}|${x.round ?? ''}` === selectedSession);
        if (s) {
          params.set('exam_year', s.year);
          if (s.round) params.set('exam_round', s.round);
        }
      }
      const data = await get<{ questions: MockQuestion[] }>(
        `/certificates/${code}/mock-exam/start?${params}`
      );
      setQuestions(data.questions);
      setSelections({});
      setStartedAt(Date.now());
      setElapsed(0);
      setPhase('taking');
    } catch {
      setError('Không bắt đầu được bài thi.');
    } finally {
      setLoading(false);
    }
  }, [code, questionCount, selectedSession, sessions]);

  const handleSubmit = useCallback(async () => {
    if (!code) return;
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
      window.scrollTo({ top: 0, behavior: 'smooth' });
    } catch {
      setError('Không gửi được bài thi. Vui lòng thử lại.');
    } finally {
      setSubmitting(false);
    }
  }, [code, questions, selections, startedAt]);

  const answeredCount = Object.keys(selections).length;

  if (loading && phase === 'setup') {
    return (
      <div className="reading-posts-page certificate-page">
        <p className="loading-text"><Spinner /> Loading...</p>
      </div>
    );
  }

  // ---------- SETUP ----------
  if (phase === 'setup') {
    const maxCount = Math.min(totalPool, 100);
    return (
      <div className="reading-posts-page certificate-page mock-exam-page">
        <Link to={`/certificates/${category}/${code}`} className="btn-back">← Quay lại</Link>
        <h2>Thi thử</h2>
        {certName && <p className="certificate-subtitle">{certName}</p>}

        {error && <div className="form-error">{error}</div>}

        <div className="mock-setup-box">
          <div className="mock-setup-field">
            <label htmlFor="mock-session">Phạm vi đề</label>
            <select
              id="mock-session"
              value={selectedSession}
              onChange={(e) => setSelectedSession(e.target.value)}
            >
              <option value="all">Trộn tất cả các năm ({totalPool} câu)</option>
              {sessions.map((s) => (
                <option key={`${s.year}|${s.round ?? ''}`} value={`${s.year}|${s.round ?? ''}`}>
                  {s.year}{s.round ? ` — ${s.round}` : ''} ({s.questionCount} câu)
                </option>
              ))}
            </select>
          </div>

          <div className="mock-setup-field">
            <label>Số câu hỏi</label>
            <div className="mock-count-options">
              {QUESTION_COUNT_OPTIONS.filter((n) => n <= maxCount || n === QUESTION_COUNT_OPTIONS[0]).map((n) => (
                <button
                  key={n}
                  type="button"
                  className={`mock-count-btn ${questionCount === n ? 'active' : ''}`}
                  onClick={() => setQuestionCount(n)}
                >
                  {n} câu
                </button>
              ))}
            </div>
          </div>

          <button className="btn-submit mock-start-btn" onClick={handleStart} disabled={totalPool === 0}>
            Bắt đầu thi thử
          </button>
          {totalPool === 0 && <p className="empty-state">Chứng chỉ này chưa có câu hỏi.</p>}
        </div>

        <div className="mock-note">
          Đề được trộn ngẫu nhiên. Câu đúng/sai chọn 〇 hoặc ×; câu nhiều đáp án chọn theo
          nhãn (ア/イ/ウ/エ hoặc 1/2/3/4) ghi trong đề. Sau khi nộp bài bạn sẽ thấy đáp án,
          bản dịch và giải thích từng câu.
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

  // ---------- TAKING ----------
  if (phase === 'taking') {
    return (
      <div className="reading-posts-page certificate-page mock-exam-page">
        <div className="mock-exam-bar">
          <span className="mock-progress">Đã trả lời {answeredCount}/{questions.length}</span>
          <span className="mock-timer">⏱ {formatDuration(elapsed)}</span>
        </div>

        {error && <div className="form-error">{error}</div>}

        <div className="exam-question-list">
          {questions.map((q) => (
            <div key={q.id} className="exam-question-card mock-question-card">
              <div className="exam-question-header">
                <span className="exam-question-no">Câu {q.displayNo}</span>
                <p className="exam-question-text">{q.questionJa}</p>
              </div>

              <div className={`mock-choices ${q.isTrueFalse ? 'truefalse' : ''}`}>
                {q.choices.map((c) => (
                  <button
                    key={c}
                    type="button"
                    className={`mock-choice-btn ${selections[q.id] === c ? 'selected' : ''}`}
                    onClick={() =>
                      setSelections((prev) => ({ ...prev, [q.id]: c }))
                    }
                  >
                    {c}
                  </button>
                ))}
                {selections[q.id] && (
                  <button
                    type="button"
                    className="mock-clear-btn"
                    onClick={() =>
                      setSelections((prev) => {
                        const next = { ...prev };
                        delete next[q.id];
                        return next;
                      })
                    }
                  >
                    Bỏ chọn
                  </button>
                )}
              </div>
            </div>
          ))}
        </div>

        <div className="mock-submit-bar">
          {answeredCount < questions.length && (
            <p className="mock-warning">
              Còn {questions.length - answeredCount} câu chưa trả lời (sẽ tính là sai).
            </p>
          )}
          <button className="btn-submit" onClick={handleSubmit} disabled={submitting}>
            {submitting ? <><Spinner size={14} /> Đang chấm...</> : 'Nộp bài'}
          </button>
        </div>
      </div>
    );
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

      {result && (
        <>
          <div className="mock-score-card">
            <div className="mock-score-main">{result.scorePercent}%</div>
            <div className="mock-score-detail">
              Đúng {result.correctCount}/{result.totalQuestions} câu
              <br />Thời gian: {formatDuration(result.durationSeconds)}
            </div>
          </div>

          <div className="mock-result-actions">
            <button className="btn-submit" onClick={() => setPhase('setup')}>Thi lại</button>
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
