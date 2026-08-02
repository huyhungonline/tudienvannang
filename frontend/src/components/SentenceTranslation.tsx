import { SpeakButton } from './SpeakButton';

interface SentenceTranslationProps {
  translation: string;
  loading: boolean;
  error: string | null;
  language: string;
  onRetry?: () => void;
}

export function SentenceTranslation({ translation, loading, error, language, onRetry }: SentenceTranslationProps) {
  if (loading) {
    return (
      <div className="sentence-translation loading">
        <p>Translating...</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="sentence-translation error">
        <p className="error-message">{error}</p>
        {onRetry && (
          <button className="btn-retry" onClick={onRetry}>
            Retry
          </button>
        )}
      </div>
    );
  }

  if (!translation) {
    return null;
  }

  return (
    <div className="sentence-translation">
      <div className="translation-row">
        <p className="translation-text">{translation}</p>
        <SpeakButton text={translation} language={language} />
      </div>
    </div>
  );
}
