import type { WordEntry, TargetLanguage, SourceLanguage } from 'shared';
import { WordEntryRow } from './WordEntryRow';

interface ResultPanelProps {
  words: WordEntry[];
  loading: boolean;
  targetLanguage?: TargetLanguage;
  sourceLanguage?: SourceLanguage;
}

const LANGUAGE_HEADERS: Record<string, string> = {
  ja: 'Japanese',
  vi: 'Vietnamese',
  zh: 'Chinese',
  en: 'English',
};

const READING_HEADERS: Record<string, string> = {
  ja: 'Romaji',
  zh: 'Pinyin',
  vi: 'Reading',
};

export function ResultPanel({ words, loading, targetLanguage, sourceLanguage = 'en' }: ResultPanelProps) {
  const isReverse = sourceLanguage !== 'en';

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
        <p>No words found</p>
      </div>
    );
  }

  if (isReverse) {
    return (
      <div className="result-panel">
        <table className="result-table">
          <thead>
            <tr>
              <th>Word</th>
              <th>{READING_HEADERS[sourceLanguage] || 'Reading'}</th>
              <th>{targetLanguage ? LANGUAGE_HEADERS[targetLanguage] || 'Translation' : 'English'}</th>
            </tr>
          </thead>
          <tbody>
            {words.map((entry, idx) => (
              <tr key={`${entry.word}-${idx}`}>
                <td className="word-cell">{entry.word}</td>
                <td className="reading-cell">{entry.ipa || '-'}</td>
                <td className="translation-cell">{entry.translation || '-'}</td>
              </tr>
            ))}
          </tbody>
        </table>
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
            <th>{targetLanguage ? LANGUAGE_HEADERS[targetLanguage] : 'Translation'}</th>
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
