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
import { jsPDF } from 'jspdf';
import autoTable from 'jspdf-autotable';

export function HomePage() {
  const { isAuthenticated } = useAuth();
  const location = useLocation();
  const navigate = useNavigate();
  const [words, setWords] = useState<WordEntry[]>([]);
  const [sentenceTranslation, setSentenceTranslation] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [targetLanguage, setTargetLanguage] = useState<TargetLanguage>('ja');
  const [sourceLanguage, setSourceLanguage] = useState<SourceLanguage>('en');
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
    const doc = new jsPDF();

    // Header - brand
    doc.setFontSize(16);
    doc.setTextColor(37, 99, 235);
    doc.text('jaenglish.com', 105, 15, { align: 'center' });

    // Vocabulary table
    doc.setFontSize(12);
    doc.setTextColor(0, 0, 0);
    doc.text('Vocabulary List', 14, 28);

    const tableData = words.map((w) => [w.word, w.ipa, w.translation]);
    autoTable(doc, {
      startY: 32,
      head: [['Word', 'IPA', 'Translation']],
      body: tableData,
      styles: { fontSize: 10 },
      headStyles: { fillColor: [37, 99, 235] },
    });

    // Original text section
    const finalY = (doc as any).lastAutoTable?.finalY || 50;
    doc.setFontSize(12);
    doc.text('Original Text', 14, finalY + 12);
    doc.setFontSize(10);
    const splitText = doc.splitTextToSize(currentText, 180);
    doc.text(splitText, 14, finalY + 20);

    // Sentence translation
    if (sentenceTranslation) {
      const textEndY = finalY + 20 + splitText.length * 5;
      doc.setFontSize(12);
      doc.text('Translation', 14, textEndY + 8);
      doc.setFontSize(10);
      const splitTranslation = doc.splitTextToSize(sentenceTranslation, 180);
      doc.text(splitTranslation, 14, textEndY + 16);
    }

    doc.save('vocabulary.pdf');
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
