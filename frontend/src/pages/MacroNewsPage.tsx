import { useState, useEffect, useCallback } from 'react';
import { get } from '../api/client';

interface MacroNewsItem {
  id: string;
  category: string;
  title: string;
  content: string;
  language?: string;
  updated_at: string;
}

interface HistoryResponse {
  dates: string[];
  items: MacroNewsItem[];
}

type NewsLanguage = 'en' | 'ja';

const CATEGORY_LABELS: Record<string, string> = {
  gold: '🥇 Gold',
  silver: '🥈 Silver',
  oil: '🛢️ Oil (Crude)',
  us_treasury: '🏦 US Treasury',
  central_banks: '🏛️ Central Banks',
};

const CATEGORY_LABELS_JA: Record<string, string> = {
  gold: '🥇 金（ゴールド）',
  silver: '🥈 銀（シルバー）',
  oil: '🛢️ 原油',
  us_treasury: '🏦 米国債',
  central_banks: '🏛️ 中央銀行',
};

const CATEGORY_ORDER = ['gold', 'silver', 'oil', 'us_treasury', 'central_banks'];

export function MacroNewsPage() {
  const [news, setNews] = useState<MacroNewsItem[]>([]);
  const [historyDates, setHistoryDates] = useState<string[]>([]);
  const [selectedDate, setSelectedDate] = useState<string | null>(null);
  const [language, setLanguage] = useState<NewsLanguage>('en');
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const fetchLatestNews = useCallback(async (lang: NewsLanguage) => {
    try {
      setError(null);
      setLoading(true);
      const data = await get<{ news: MacroNewsItem[] }>(`/macro-news?language=${lang}`);
      setNews(data.news || []);
      setSelectedDate(null);
    } catch (err) {
      setError('Failed to load macro news.');
      console.error(err);
    } finally {
      setLoading(false);
    }
  }, []);

  const fetchHistoryDates = useCallback(async (lang: NewsLanguage) => {
    try {
      const data = await get<HistoryResponse>(`/macro-news/history?days=20&language=${lang}`);
      setHistoryDates(data.dates || []);
    } catch (err) {
      console.error('Failed to load history dates:', err);
    }
  }, []);

  useEffect(() => {
    fetchLatestNews(language);
    fetchHistoryDates(language);
  }, [language, fetchLatestNews, fetchHistoryDates]);

  const fetchNewsByDate = async (date: string) => {
    try {
      setError(null);
      setLoading(true);
      setSelectedDate(date);
      const data = await get<{ news: MacroNewsItem[] }>(`/macro-news/by-date/${date}?language=${language}`);
      setNews(data.news || []);
    } catch (err) {
      setError(`Failed to load news for ${date}.`);
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const handleLanguageChange = (lang: NewsLanguage) => {
    setLanguage(lang);
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

  const labels = language === 'ja' ? CATEGORY_LABELS_JA : CATEGORY_LABELS;

  const sortedNews = CATEGORY_ORDER
    .map((cat) => news.find((item) => item.category === cat))
    .filter((item): item is MacroNewsItem => item !== undefined);

  return (
    <div className="macro-news-page">
      <div className="macro-news-sidebar">
        <h3>{language === 'ja' ? '履歴' : 'Lịch sử nhận định'}</h3>
        <button
          className="sidebar-item sidebar-latest"
          onClick={() => fetchLatestNews(language)}
          data-active={selectedDate === null ? 'true' : 'false'}
        >
          📌 {language === 'ja' ? '最新' : 'Mới nhất'}
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
          <select
            className="macro-news-lang-select"
            value={language}
            onChange={(e) => handleLanguageChange(e.target.value as NewsLanguage)}
          >
            <option value="en">English</option>
            <option value="ja">日本語</option>
          </select>
        </div>

        {error && <div className="macro-news-error">{error}</div>}

        {loading ? (
          <div className="macro-news-loading">Loading macro news...</div>
        ) : sortedNews.length === 0 && !error ? (
          <div className="macro-news-empty">
            <p>No macro news available. Click "Refresh" to generate analysis.</p>
          </div>
        ) : (
          <div className="macro-news-grid">
            {sortedNews.map((item) => (
              <div key={item.id || item.category} className="macro-news-card">
                <div className="macro-news-card-header">
                  <h2>{labels[item.category] || item.title}</h2>
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
