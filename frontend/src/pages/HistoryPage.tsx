import { useState, useEffect, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { get, del, ApiError } from '../api/client';
import type { WordEntry, TargetLanguage } from 'shared';

interface HistoryRecord {
  id: string;
  inputText: string;
  targetLanguage: TargetLanguage;
  sentenceTranslation: string;
  wordCount: number;
  createdAt: string;
}

interface HistoryDetail {
  id: string;
  inputText: string;
  targetLanguage: TargetLanguage;
  sentenceTranslation: string;
  words: WordEntry[];
  createdAt: string;
}

const LANGUAGE_LABELS: Record<TargetLanguage, string> = {
  ja: 'Japanese',
  vi: 'Vietnamese',
  zh: 'Chinese',
};

export function HistoryPage() {
  const navigate = useNavigate();
  const { isAuthenticated } = useAuth();
  const [records, setRecords] = useState<HistoryRecord[]>([]);
  const [selectedRecord, setSelectedRecord] = useState<HistoryDetail | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (!isAuthenticated) {
      navigate('/login');
    }
  }, [isAuthenticated, navigate]);

  const fetchHistory = useCallback(async () => {
    setLoading(true);
    setError(null);
    try {
      const result = await get<{ records: HistoryRecord[] }>('/history');
      setRecords(result.records);
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
      fetchHistory();
    }
  }, [isAuthenticated, fetchHistory]);

  const handleSelectRecord = async (id: string) => {
    try {
      const result = await get<{ record: HistoryDetail }>(`/history/${id}`);
      setSelectedRecord(result.record);
    } catch (err) {
      if (err instanceof ApiError && err.status === 401) {
        navigate('/login');
      } else {
        setError('Failed to load record details.');
      }
    }
  };

  const handleDelete = async (id: string) => {
    try {
      await del(`/history/${id}`);
      setRecords((prev) => prev.filter((r) => r.id !== id));
      if (selectedRecord?.id === id) {
        setSelectedRecord(null);
      }
    } catch (err) {
      if (err instanceof ApiError && err.status === 401) {
        navigate('/login');
      } else {
        setError('Failed to delete record.');
      }
    }
  };

  const handleBack = () => {
    setSelectedRecord(null);
  };

  if (!isAuthenticated) {
    return null;
  }

  if (loading) {
    return (
      <div className="history-page">
        <h2>Search History</h2>
        <p className="loading-text">Loading history...</p>
      </div>
    );
  }

  if (selectedRecord) {
    return (
      <div className="history-page">
        <div className="history-detail-header">
          <button className="btn-back" onClick={handleBack}>← Back to list</button>
          <h2>Search Detail</h2>
        </div>

        <div className="history-detail">
          <div className="detail-meta">
            <span className="detail-language">{LANGUAGE_LABELS[selectedRecord.targetLanguage]}</span>
            <span className="detail-date">
              {new Date(selectedRecord.createdAt).toLocaleDateString()}
            </span>
          </div>

          <div className="detail-section">
            <h3>Input Text</h3>
            <p className="detail-input-text">{selectedRecord.inputText}</p>
          </div>

          {selectedRecord.sentenceTranslation && (
            <div className="detail-section">
              <h3>Sentence Translation</h3>
              <p className="detail-translation">{selectedRecord.sentenceTranslation}</p>
            </div>
          )}

          <div className="detail-section">
            <h3>Words ({selectedRecord.words.length})</h3>
            <table className="result-table">
              <thead>
                <tr>
                  <th>Word</th>
                  <th>IPA</th>
                  <th>Translation</th>
                </tr>
              </thead>
              <tbody>
                {selectedRecord.words.map((entry, idx) => (
                  <tr key={idx}>
                    <td className="word-cell">{entry.word}</td>
                    <td className="ipa-cell">{entry.ipa || 'N/A'}</td>
                    <td>{entry.translation || 'N/A'}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="history-page">
      <h2>Search History</h2>

      {error && <div className="form-error">{error}</div>}

      {records.length === 0 ? (
        <p className="empty-history">No search history yet.</p>
      ) : (
        <div className="history-list">
          {records.map((record) => (
            <div key={record.id} className="history-item">
              <div
                className="history-item-content"
                onClick={() => handleSelectRecord(record.id)}
                role="button"
                tabIndex={0}
                onKeyDown={(e) => {
                  if (e.key === 'Enter') handleSelectRecord(record.id);
                }}
              >
                <p className="history-preview">
                  {record.inputText.length > 100
                    ? record.inputText.slice(0, 100) + '...'
                    : record.inputText}
                </p>
                <div className="history-meta">
                  <span className="history-word-count">{record.wordCount} words</span>
                  <span className="history-language">{LANGUAGE_LABELS[record.targetLanguage]}</span>
                  <span className="history-date">
                    {new Date(record.createdAt).toLocaleDateString()}
                  </span>
                </div>
              </div>
              <button
                className="btn-delete"
                onClick={() => handleDelete(record.id)}
                aria-label="Delete record"
              >
                ✕
              </button>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
