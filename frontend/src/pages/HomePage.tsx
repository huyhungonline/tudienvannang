import { useState, useCallback, useEffect } from 'react';
import { Link, useLocation, useNavigate } from 'react-router-dom';
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
import jsPDF from 'jspdf';

export function HomePage() {
  const { isAuthenticated } = useAuth();
  const location = useLocation();
  const navigate = useNavigate();
  const [words, setWords] = useState<WordEntry[]>([]);
  const [sentenceTranslation, setSentenceTranslation] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [targetLanguage, setTargetLanguage] = useState<TargetLanguage>('vi');
  const [sourceLanguage, setSourceLanguage] = useState<SourceLanguage>('ja');
  const [currentText, setCurrentText] = useState('');
  const [externalText, setExternalText] = useState<string | undefined>(undefined);
  const [saveMessage, setSaveMessage] = useState<string | null>(null);
  const [langWarning, setLangWarning] = useState<string | null>(null);

  // Handle navigation from My Page with pre-filled text
  useEffect(() => {
    const state = location.state as { text?: string } | null;
    if (state?.text) {
      setExternalText(state.text);
      setCurrentText(state.text);
      fetchWords(state.text, targetLanguage, sourceLanguage);
      window.history.replaceState({}, document.title);
      return;
    }
    // Handle query param ?text= from Reading page
    const params = new URLSearchParams(location.search);
    const textParam = params.get('text');
    if (textParam) {
      setExternalText(textParam);
      setCurrentText(textParam);
      fetchWords(textParam, targetLanguage, sourceLanguage);
      window.history.replaceState({}, document.title, '/');
    }
  }, [location.state, location.search]);

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
    if (sourceLanguage === targetLanguage) {
      setLangWarning('Source and target language cannot be the same.');
      return;
    }
    setLangWarning(null);
    fetchWords(text, targetLanguage, sourceLanguage);
  }, [fetchWords, targetLanguage, sourceLanguage]);

  const handleTargetLanguageChange = useCallback((language: TargetLanguage) => {
    setTargetLanguage(language);
    if (language === sourceLanguage) {
      setLangWarning('Source and target language cannot be the same.');
      return;
    }
    setLangWarning(null);
    if (currentText.trim() && sourceLanguage === 'en') {
      fetchWords(currentText, language, sourceLanguage);
    }
  }, [fetchWords, currentText, sourceLanguage]);

  const handleSourceLanguageChange = useCallback((language: SourceLanguage) => {
    setSourceLanguage(language);
    if (language === targetLanguage) {
      setLangWarning('Source and target language cannot be the same.');
      return;
    }
    setLangWarning(null);
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
        if (err.status === 401) {
          localStorage.removeItem('token');
          navigate('/login');
          return;
        }
        setError(err.message);
      }
    }
  };

  const handleSelectRecentSearch = (text: string) => {
    setExternalText(text);
    setCurrentText(text);
    fetchWords(text, targetLanguage, sourceLanguage);
  };

  const handleDownloadPdf = () => {
    const rows = words.map((w) =>
      `<tr><td>${w.word}</td><td>${w.ipa}</td><td>${w.translation}</td></tr>`
    ).join('');

    const html = `<!DOCTYPE html>
<html><head><meta charset="utf-8"><title>Vocabulary - jaenglish.com</title>
<style>
  body { font-family: 'Noto Sans JP', 'Segoe UI', sans-serif; padding: 2rem; color: #333; }
  .brand { text-align: center; font-size: 1.4rem; font-weight: 700; color: #2563eb; margin-bottom: 1.5rem; }
  table { width: 100%; border-collapse: collapse; margin-bottom: 1.5rem; }
  th, td { border: 1px solid #ddd; padding: 0.5rem 0.75rem; text-align: left; font-size: 0.9rem; }
  th { background: #2563eb; color: #fff; }
  .section-title { font-size: 1rem; font-weight: 600; margin: 1rem 0 0.5rem; }
  .text-block { background: #f9f9f9; padding: 0.75rem; border-radius: 4px; border: 1px solid #eee; white-space: pre-wrap; font-size: 0.9rem; line-height: 1.6; }
  @media print { body { padding: 0; } }
</style></head><body>
<div class="brand">jaenglish.com</div>
<p class="section-title">Vocabulary List</p>
<table><thead><tr><th>Word</th><th>IPA</th><th>Translation</th></tr></thead><tbody>${rows}</tbody></table>
<p class="section-title">Original Text</p>
<div class="text-block">${currentText}</div>
${sentenceTranslation ? `<p class="section-title">Translation</p><div class="text-block">${sentenceTranslation}</div>` : ''}
</body></html>`;

    // Render HTML into an off-screen container, then convert to PDF via jsPDF.html()
    const container = document.createElement('div');
    container.style.position = 'absolute';
    container.style.left = '-9999px';
    container.style.top = '0';
    container.style.width = '760px';
    container.innerHTML = html;
    document.body.appendChild(container);

    const pdf = new jsPDF({ unit: 'px', format: 'a4', orientation: 'portrait' });
    pdf.html(container, {
      callback: (doc) => {
        doc.save(`vocabulary-${Date.now()}.pdf`);
        document.body.removeChild(container);
      },
      margin: [20, 20, 20, 20],
      autoPaging: 'text',
      width: 555,
      windowWidth: 760,
    });
  };

  return (
    <div className="home-page">
      <div className="left-column">
        <div className="language-bar">
          <SourceLanguageSelector onLanguageChange={handleSourceLanguageChange} value={sourceLanguage} />
          <LanguageSelector onLanguageChange={handleTargetLanguageChange} />
        </div>
        {langWarning && <p className="lang-warning">{langWarning}</p>}
        <InputPanel onSubmit={handleSubmit} externalText={externalText} sourceLanguage={sourceLanguage} onAutoDetectLanguage={handleSourceLanguageChange} />
        <SentenceTranslation
          translation={sentenceTranslation}
          loading={loading}
          error={error}
          language={targetLanguage}
          onRetry={error ? handleRetry : undefined}
        />
        <RecentSearches onSelect={handleSelectRecentSearch} />
      </div>
      <div className="right-column">
        {words.length > 0 && (
          <div className="save-history-section">
            <button className="btn-download-pdf" onClick={handleDownloadPdf}>
              Download PDF
            </button>
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
          targetLanguage={targetLanguage}
          sourceLanguage={sourceLanguage}
        />
      </div>
    </div>
  );
}
