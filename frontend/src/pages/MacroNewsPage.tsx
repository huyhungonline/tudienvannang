import { useState, useEffect } from 'react';
import { get, post } from '../api/client';

interface MacroNewsItem {
  id: string;
  category: string;
  title: string;
  content: string;
  updated_at: string;
}

interface HistoryResponse {
  dates: string[];
  items: MacroNewsItem[];
}

const CATEGORY_LABELS: Record<string, string> = {
  gold: '🥇 Gold',
  silver: '🥈 Silver',
  oil: '🛢️ Oil (Crude)',
  us_treasury: '🏦 US Treasury',
  central_banks: '🏛️ Central Banks',
};

const CATEGORY_ORDER = ['gold', 'silver', 'oil', 'us_treasury', 'central_banks'];

export function MacroNewsPage() {
  const [news, setNews] = useState<MacroNewsItem[]>([]);
  const [historyDates, setHistoryDates] = useState<string[]>([]);
  const [selectedDate, setSelectedDate] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Load latest news on mount
  useEffect(() => {
    fetchLatestNews();
    fetchHistoryDates();
  }, []);

  const fetchLatestNews = async () => {
    try {
      setError(null);
      setLoading(true);
      const data = await get<{ news: MacroNewsItem[] }>('/macro-news');
      setNews(data.news || []);
      setSelectedDate(null);
    } catch (err) {
      setError('Failed to load macro news.');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const fetchHistoryDates = async () => {
    try {
      const data = await get<HistoryResponse>('/macro-news/history?days=20');
      setHistoryDates(data.dates || []);
    } catch (err) {
      console.error('Failed to load history dates:', err);
    }
  };

  const fetchNewsByDate = async (date: string) => {
    try {
      setError(null);
      setLoading(true);
      setSelectedDate(date);
      const data = await get<{ news: MacroNewsItem[] }>(`/macro-news/by-date/${date}`);
      setNews(data.news || []);
    } catch (err) {
      setError(`Failed to load news for ${date}.`);
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const handleRefresh = async () => {
    setRefreshing(true);
    setError(null);
    try {
      const data = await post<{ news: MacroNewsItem[]; message: string }>('/macro-news/refresh', {});
      setNews(data.news || []);
      setSelectedDate(null);
      await fetchHistoryDates();
    } catch (err) {
      setError('Failed to refresh macro news.');
      console.error(err);
    } finally {
      setRefreshing(false);
    }
  };

  const formatDate = (dateStr: string) => {
    try {
      return new Date(dateStr).toLocaleString();
    } catch {
      return dateStr;
    }
  };

  const formatDateShort = (dateStr: string) => {
    try {
      const d = new Date(dateStr + 'T00:00:00');
      return d.toLocaleDateString('vi-VN', { day: '2-digit', month: '2-digit', year: 'numeric' });
    } catch {
      return dateStr;
    }
  };

  const sortedNews = CATEGORY_ORDER
    .map((cat) => news.find((item) => item.category === cat))
    .filter((item): item is MacroNewsItem => item !== undefined);

  return (
    <div className="macro-news-page">
      <div className="macro-news-sidebar">
        <h3>Lịch sử nhận định</h3>
        <button
          className="sidebar-item sidebar-latest"
          onClick={fetchLatestNews}
          data-active={selectedDate === null ? 'true' : 'false'}
        >
          📌 Mới nhất
        </button>
        {historyDates.map((date) => (
          <button
            key={date}
            className="sidebar-item"
            onClick={() => fetchNewsByDate(date)}
            data-active={selectedDate === date ? 'true' : 'false'}
          >
            {formatDateShort(date)}
          </button>
        ))}
      </div>

      <div className="macro-news-content">
        <div className="macro-news-header">
          <h1>Macro News {selectedDate ? `(${formatDateShort(selectedDate)})` : ''}</h1>
          <button
            className="btn-refresh"
            onClick={handleRefresh}
            disabled={refreshing}
          >
            {refreshing ? 'Refreshing...' : '🔄 Refresh All'}
          </button>
        </div>

        {error && <div className="macro-news-error">{error}</div>}

        {loading ? (
          <div className="macro-news-loading">Loading macro news...</div>
        ) : sortedNews.length === 0 && !error ? (
          <div className="macro-news-empty">
            <p>No macro news available. Click "Refresh All" to generate analysis.</p>
          </div>
        ) : (
          <div className="macro-news-grid">
            {sortedNews.map((item) => (
              <div key={item.id || item.category} className="macro-news-card">
                <div className="macro-news-card-header">
                  <h2>{CATEGORY_LABELS[item.category] || item.title}</h2>
                  <span className="macro-news-updated">
                    Last updated: {formatDate(item.updated_at)}
                  </span>
                </div>
                <div className="macro-news-card-content">
                  {item.content.split('\n').map((paragraph, idx) =>
                    paragraph.trim() ? <p key={idx}>{paragraph}</p> : null
                  )}
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
