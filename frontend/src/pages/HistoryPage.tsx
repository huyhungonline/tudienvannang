import { useState, useEffect, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { get, del, ApiError } from '../api/client';

interface HistoryRecord {
  id: string;
  inputText: string;
  createdAt: string;
}

const PAGE_SIZE = 10;

export function HistoryPage() {
  const navigate = useNavigate();
  const { isAuthenticated } = useAuth();
  const [records, setRecords] = useState<HistoryRecord[]>([]);
  const [total, setTotal] = useState(0);
  const [page, setPage] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (!isAuthenticated) {
      navigate('/login');
    }
  }, [isAuthenticated, navigate]);

  const fetchHistory = useCallback(async (pageNum: number) => {
    setLoading(true);
    setError(null);
    try {
      const offset = pageNum * PAGE_SIZE;
      const result = await get<{ records: HistoryRecord[]; total: number }>(
        `/history?limit=${PAGE_SIZE}&offset=${offset}`
      );
      setRecords(result.records);
      setTotal(result.total);
    } catch (err) {
      if (err instanceof ApiError && err.status === 401) {
        navigate('/login');
      } else {
        setError('Failed to load history. Please try again.');
      }
    } finally {
      setLoading(false);
    }
  }, [navigate]);

  useEffect(() => {
    if (isAuthenticated) {
      fetchHistory(page);
    }
  }, [isAuthenticated, fetchHistory, page]);

  const handleSelectRecord = (record: HistoryRecord) => {
    navigate('/', { state: { text: record.inputText } });
  };

  const handleDelete = async (id: string) => {
    try {
      await del(`/history/${id}`);
      setRecords((prev) => prev.filter((r) => r.id !== id));
      setTotal((prev) => prev - 1);
    } catch (err) {
      if (err instanceof ApiError && err.status === 401) {
        navigate('/login');
      } else {
        setError('Failed to delete record.');
      }
    }
  };

  const totalPages = Math.ceil(total / PAGE_SIZE);

  if (!isAuthenticated) return null;

  if (loading) {
    return (
      <div className="history-page">
        <h2>My Page</h2>
        <p className="loading-text">Loading...</p>
      </div>
    );
  }

  return (
    <div className="history-page">
      <h2>My Page</h2>

      {error && <div className="form-error">{error}</div>}

      {records.length === 0 ? (
        <p className="empty-history">No saved texts yet.</p>
      ) : (
        <>
          <div className="history-list">
            {records.map((record) => (
              <div key={record.id} className="history-item">
                <div
                  className="history-item-content"
                  onClick={() => handleSelectRecord(record)}
                  role="button"
                  tabIndex={0}
                  onKeyDown={(e) => { if (e.key === 'Enter') handleSelectRecord(record); }}
                >
                  <p className="history-preview">
                    {record.inputText.length > 150 ? record.inputText.slice(0, 150) + '...' : record.inputText}
                  </p>
                  <div className="history-meta">
                    <span className="history-date">{new Date(record.createdAt).toLocaleDateString()}</span>
                  </div>
                </div>
                <button className="btn-delete" onClick={() => handleDelete(record.id)} aria-label="Delete record">✕</button>
              </div>
            ))}
          </div>

          {totalPages > 1 && (
            <div className="pagination">
              <button disabled={page === 0} onClick={() => setPage(p => p - 1)}>← Trước</button>
              <span>{page + 1} / {totalPages}</span>
              <button disabled={page >= totalPages - 1} onClick={() => setPage(p => p + 1)}>Sau →</button>
            </div>
          )}
        </>
      )}
    </div>
  );
}
