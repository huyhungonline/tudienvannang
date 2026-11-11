import { useCallback, useEffect, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { get, ApiError } from '../api/client';
import { Spinner } from '../components/Spinner';

interface ExamAttempt {
  attemptId: number;
  totalQuestions: number;
  correctCount: number;
  scorePercent: number;
  durationSeconds: number | null;
  finishedAt: string;
  itppScore: { totalScore: number; maxScore: number; passed: boolean } | null;
  certificate: { code: string; category: string; nameJa: string; nameVi: string | null };
}

const PAGE_SIZE = 10;

function formatDuration(seconds: number | null): string {
  if (seconds == null) return '—';
  return `${Math.floor(seconds / 60)}:${String(seconds % 60).padStart(2, '0')}`;
}

export function ExamHistoryPage() {
  const navigate = useNavigate();
  const { isAuthenticated } = useAuth();
  const [attempts, setAttempts] = useState<ExamAttempt[]>([]);
  const [total, setTotal] = useState(0);
  const [page, setPage] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (!isAuthenticated) navigate('/login');
  }, [isAuthenticated, navigate]);

  const load = useCallback(async (pageNum: number) => {
    setLoading(true);
    setError(null);
    try {
      const data = await get<{ attempts: ExamAttempt[]; total: number }>(
        `/certificates/me/mock-exam-attempts?limit=${PAGE_SIZE}&offset=${pageNum * PAGE_SIZE}`
      );
      setAttempts(data.attempts);
      setTotal(data.total);
    } catch (err) {
      if (err instanceof ApiError && err.status === 401) navigate('/login');
      else setError('Không tải được lịch sử thi. Vui lòng thử lại.');
    } finally {
      setLoading(false);
    }
  }, [navigate]);

  useEffect(() => {
    if (isAuthenticated) load(page);
  }, [isAuthenticated, load, page]);

  if (!isAuthenticated) return null;

  const totalPages = Math.ceil(total / PAGE_SIZE);

  return (
    <div className="history-page">
      <Link to="/my-page" className="my-page-back">← My Page</Link>
      <h2>Lịch sử thi</h2>
      {error && <div className="form-error">{error}</div>}
      {loading ? (
        <p className="loading-text"><Spinner /> Loading...</p>
      ) : attempts.length === 0 ? (
        <p className="empty-history">Bạn chưa có lần thi thử nào.</p>
      ) : (
        <>
          <table className="result-table">
            <thead>
              <tr><th>Thời điểm</th><th>Chứng chỉ</th><th>Điểm</th><th>Đúng</th><th>Thời gian</th></tr>
            </thead>
            <tbody>
              {attempts.map((a) => (
                <tr key={a.attemptId}>
                  <td>{new Date(a.finishedAt).toLocaleString('vi-VN')}</td>
                  <td>
                    <Link to={`/certificates/${a.certificate.category}/${a.certificate.code}/mock-exam`}>
                      {a.certificate.nameVi || a.certificate.nameJa}
                    </Link>
                  </td>
                  <td>
                    {a.itppScore ? (
                      <>
                        <strong>{a.itppScore.totalScore}/{a.itppScore.maxScore}</strong>{' '}
                        {a.itppScore.passed ? 'ĐẠT' : 'CHƯA ĐẠT'}
                      </>
                    ) : (
                      <strong>{a.scorePercent}%</strong>
                    )}
                  </td>
                  <td>{a.correctCount}/{a.totalQuestions}</td>
                  <td>{formatDuration(a.durationSeconds)}</td>
                </tr>
              ))}
            </tbody>
          </table>
          {totalPages > 1 && (
            <div className="pagination">
              <button disabled={page === 0} onClick={() => setPage((p) => p - 1)}>← Trước</button>
              <span>{page + 1} / {totalPages}</span>
              <button disabled={page >= totalPages - 1} onClick={() => setPage((p) => p + 1)}>Sau →</button>
            </div>
          )}
        </>
      )}
    </div>
  );
}
