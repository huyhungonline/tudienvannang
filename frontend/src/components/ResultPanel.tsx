import type { WordEntry, TargetLanguage } from 'shared';
import { WordEntryRow } from './WordEntryRow';

interface ResultPanelProps {
  words: WordEntry[];
  loading: boolean;
  targetLanguage: TargetLanguage;
}

const LANGUAGE_HEADERS: Record<TargetLanguage, string> = {
  ja: '日本語',
  vi: 'Tiếng Việt',
  zh: '中文',
};

export function ResultPanel({ words, loading, targetLanguage }: ResultPanelProps) {
  if (loading) {
    return (
      <div className="result-panel loading">
        <div className="spinner" aria-label="Loading">Loading...</div>
      </div>
    );
  }

  if (words.length === 0) {
    return (
      <div className="result-panel empty">
        <p>No English words found</p>
      </div>
    );
  }

  return (
    <div className="result-panel">
      <table className="result-table">
        <thead>
          <tr>
            <th>Word</th>
            <th>IPA</th>
            <th>Audio</th>
            <th>{LANGUAGE_HEADERS[targetLanguage]}</th>
          </tr>
        </thead>
        <tbody>
          {words.map((entry) => (
            <WordEntryRow key={entry.word} entry={entry} />
          ))}
        </tbody>
      </table>
    </div>
  );
}
