import { useState, useEffect } from 'react';
import { get } from '../api/client';

interface RecentSearch {
  id: string;
  inputText: string;
  targetLanguage: string;
  createdAt: string;
}

interface RecentSearchesProps {
  onSelect: (text: string) => void;
}

export function RecentSearches({ onSelect }: RecentSearchesProps) {
  const [searches, setSearches] = useState<RecentSearch[]>([]);
  const [total, setTotal] = useState(0);

  useEffect(() => {
    get<{ records: RecentSearch[]; total: number }>('/history/recent-public')
      .then((data) => { setSearches(data.records); setTotal(data.total); })
      .catch(() => {});
  }, []);

  if (searches.length === 0) return null;

  return (
    <div className="recent-searches">
      <h3 className="recent-searches-title">Recent Searches</h3>
      <p className="recent-searches-count">{total} total searches</p>
      <ul className="recent-searches-list">
        {searches.map((s) => (
          <li key={s.id} className="recent-search-item">
            <span className="recent-search-text">{s.inputText}</span>
            <button
              className="btn-use-text"
              onClick={() => onSelect(s.inputText)}
              title="Dịch đoạn này"
            >
              Translate
            </button>
          </li>
        ))}
      </ul>
    </div>
  );
}
