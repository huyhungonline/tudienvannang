interface SentenceTranslationProps {
  translation: string;
  loading: boolean;
  error: string | null;
  onRetry?: () => void;
}

export function SentenceTranslation({ translation, loading, error, onRetry }: SentenceTranslationProps) {
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
      <p className="translation-text">{translation}</p>
    </div>
  );
}
