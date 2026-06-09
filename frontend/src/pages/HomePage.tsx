import { useState, useCallback, useEffect } from 'react';
import { Link, useLocation } from 'react-router-dom';
import type { WordEntry, TargetLanguage, SourceLanguage, ProcessedResult } from 'shared';
import { InputPanel } from '../components/InputPanel';
import { LanguageSelector } from '../components/LanguageSelector';
import { SourceLanguageSelector } from '../components/SourceLanguageSelector';
import { ResultPanel } from '../components/ResultPanel';
import { SentenceTranslation } from '../components/SentenceTranslation';
import { RecentSearches } from '../components/RecentSearches';
import { useAuth } from '../context/AuthContext';
import { post } from '../api/client';
import { ApiError } from '../api/client';

export function HomePage() {
  const { isAuthenticated } = useAuth();
  const location = useLocation();
  const [words, setWords] = useState<WordEntry[]>([]);
  const [sentenceTranslation, setSentenceTranslation] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [targetLanguage, setTargetLanguage] = useState<TargetLanguage>('ja');
  const [sourceLanguage, setSourceLanguage] = useState<SourceLanguage>('en');
  const [currentText, setCurrentText] = useState('');
  const [externalText, setExternalText] = useState<string | undefined>(undefined);
  const [saveMessage, setSaveMessage] = useState<string | null>(null);

  // Handle navigation from My Page with pre-filled text
  useEffect(() => {
    const state = location.state as { text?: string } | null;
    if (state?.text) {
      setExternalText(state.text);
      setCurrentText(state.text);
      fetchWords(state.text, targetLanguage, sourceLanguage);
      // Clear state so refresh doesn't re-trigger
      window.history.replaceState({}, document.title);
    }
  }, [location.state]);

  const fetchWords = useCallback(async (text: string, target: TargetLanguage, source: SourceLanguage) => {
    if (!text.trim()) {
      setWords([]);
      setSentenceTranslation('');
      setError(null);
      return;
    }

    setLoading(true);
    setError(null);
    setSaveMessage(null);

    try {
      const result = await post<ProcessedResult>('/words/split', {
        text,
        targetLanguage: target,
        sourceLanguage: source,
      });
      setWords(result.words);
      setSentenceTranslation(result.sentenceTranslation);
    } catch (err) {
      if (err instanceof ApiError) {
        setError(err.message);
      } else {
        setError('Translation service is unavailable. Please try again later.');
      }
      setWords([]);
      setSentenceTranslation('');
    } finally {
      setLoading(false);
    }
  }, []);

  const handleSubmit = useCallback((text: string) => {
    setCurrentText(text);
    fetchWords(text, targetLanguage, sourceLanguage);
  }, [fetchWords, targetLanguage, sourceLanguage]);

  const handleTargetLanguageChange = useCallback((language: TargetLanguage) => {
    setTargetLanguage(language);
    if (currentText.trim() && sourceLanguage === 'en') {
      fetchWords(currentText, language, sourceLanguage);
    }
  }, [fetchWords, currentText, sourceLanguage]);

  const handleSourceLanguageChange = useCallback((language: SourceLanguage) => {
    setSourceLanguage(language);
    if (currentText.trim()) {
      fetchWords(currentText, targetLanguage, language);
    }
  }, [fetchWords, currentText, targetLanguage]);

  const handleRetry = () => {
    if (currentText.trim()) {
      fetchWords(currentText, targetLanguage, sourceLanguage);
    }
  };

  const handleSaveToHistory = async () => {
    setSaveMessage(null);
    try {
      await post('/history', {
        inputText: currentText,
        words,
        targetLanguage,
        sentenceTranslation,
      });
      setSaveMessage('Saved to history successfully!');
      setTimeout(() => setSaveMessage(null), 3000);
    } catch (err) {
      if (err instanceof ApiError) {
        setError(err.message);
      }
    }
  };

  const handleSelectRecentSearch = (text: string) => {
    setExternalText(text);
    setCurrentText(text);
    fetchWords(text, targetLanguage, sourceLanguage);
  };

  return (
    <div className="home-page">
      <div className="left-column">
        <div className="language-bar">
          <SourceLanguageSelector onLanguageChange={handleSourceLanguageChange} />
          <LanguageSelector onLanguageChange={handleTargetLanguageChange} />
        </div>
        <InputPanel onSubmit={handleSubmit} externalText={externalText} />
        <SentenceTranslation
          translation={sentenceTranslation}
          loading={loading}
          error={error}
          onRetry={error ? handleRetry : undefined}
        />
        <RecentSearches onSelect={handleSelectRecentSearch} />
      </div>
      <div className="right-column">
        {words.length > 0 && (
          <div className="save-history-section">
            {isAuthenticated ? (
              <>
                <button className="btn-save-history" onClick={handleSaveToHistory}>
                  Save
                </button>
                {saveMessage && <span className="save-success">{saveMessage}</span>}
              </>
            ) : (
              <p className="login-prompt">
                <Link to="/login">Log in</Link> or <Link to="/register">register</Link> to save.
              </p>
            )}
          </div>
        )}
        <ResultPanel
          words={words}
          loading={loading}
          targetLanguage={sourceLanguage === 'en' ? targetLanguage : undefined}
          sourceLanguage={sourceLanguage}
        />
      </div>
    </div>
  );
}
