import { useState, useEffect } from 'react';
import { useParams, Link } from 'react-router-dom';
import { get } from '../api/client';
import { Spinner } from '../components/Spinner';

interface ExamQuestion {
  id: number;
  questionNo: number;
  questionJa: string;
}

interface ExamSession {
  year: string;
  round: string | null;
  questions: ExamQuestion[];
}

interface VocabItem {
  term: string;
  reading: string;
  meaning: string;
}

interface ExamAnswer {
  translationVi: string;
  answerLabel: string;
  explanationVi: string;
  vocab: VocabItem[];
}

export function CertificateExamPage() {
  const { category, code } = useParams<{ category: string; code: string }>();
  const [exams, setExams] = useState<ExamSession[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [activeSession, setActiveSession] = useState(0);
  const [answers, setAnswers] = useState<Record<number, ExamAnswer>>({});
  const [loadingAnswer, setLoadingAnswer] = useState<number | null>(null);

  useEffect(() => {
    if (!code) return;
    setLoading(true);
    setError(null);
    get<{ exams: ExamSession[] }>(`/certificates/${code}/exam`)
      .then((data) => setExams(data.exams))
      .catch(() => setError('Failed to load exam questions.'))
      .finally(() => setLoading(false));
  }, [code]);

  const handleShowAnswer = async (questionId: number) => {
    if (answers[questionId]) return;
    setLoadingAnswer(questionId);
    try {
      const data = await get<ExamAnswer>(`/certificates/exam-question/${questionId}/answer`);
      setAnswers((prev) => ({ ...prev, [questionId]: data }));
    } catch {
      /* ignore */
    } finally {
      setLoadingAnswer(null);
    }
  };

  if (loading) {
    return (
      <div className="reading-posts-page certificate-page">
        <p className="loading-text"><Spinner /> Loading...</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="reading-posts-page certificate-page">
        <div className="form-error">{error}</div>
      </div>
    );
  }

  const session = exams[activeSession];

  return (
    <div className="reading-posts-page certificate-page certificate-exam-page">
      <Link to={`/certificates/${category}/${code}`} className="btn-back">← Quay lại</Link>
      <h2>Bài tập / Giải đề</h2>

      <div className="vocab-category-tabs">
        {exams.map((s, idx) => (
          <button
            key={`${s.year}-${s.round}`}
            className={`vocab-category-tab ${activeSession === idx ? 'active' : ''}`}
            onClick={() => setActiveSession(idx)}
          >
            {s.year}{s.round ? ` — ${s.round}` : ''}
          </button>
        ))}
      </div>

      {session && (
        <div className="exam-question-list">
          {session.questions.map((q) => {
            const answer = answers[q.id];
            return (
              <div key={q.id} className="exam-question-card">
                <div className="exam-question-header">
                  <span className="exam-question-no">問{q.questionNo}</span>
                  <p className="exam-question-text">{q.questionJa}</p>
                </div>

                {!answer ? (
                  <button
                    className="btn-show-answer"
                    onClick={() => handleShowAnswer(q.id)}
                    disabled={loadingAnswer === q.id}
                  >
                    {loadingAnswer === q.id ? <><Spinner size={14} /> Đang tải...</> : 'Show answer'}
                  </button>
                ) : (
                  <div className="exam-answer-reveal">
                    {answer.translationVi && <p className="exam-translation">Dịch đề: {answer.translationVi}</p>}
                    <p className={`exam-answer-badge ${answer.answerLabel === '×' ? 'incorrect' : 'correct'}`}>
                      Đáp án: {answer.answerLabel}
                    </p>
                    <p className="exam-explanation">Giải thích: {answer.explanationVi}</p>
                    {answer.vocab.length > 0 && (
                      <table className="result-table exam-vocab-table">
                        <thead>
                          <tr>
                            <th>Từ/cụm từ</th>
                            <th>Cách đọc</th>
                            <th>Nghĩa</th>
                          </tr>
                        </thead>
                        <tbody>
                          {answer.vocab.map((v, idx) => (
                            <tr key={idx}>
                              <td>{v.term}</td>
                              <td>{v.reading}</td>
                              <td>{v.meaning}</td>
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    )}
                  </div>
                )}
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
}
