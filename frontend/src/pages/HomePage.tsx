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
import autoTable from 'jspdf-autotable';

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
    const doc = new jsPDF({ unit: 'pt', format: 'a4', orientation: 'portrait' });

    // Title
    doc.setFontSize(18);
    doc.setTextColor(37, 99, 235);
    doc.text('jaenglish.com', doc.internal.pageSize.getWidth() / 2, 40, { align: 'center' });

    // Vocabulary table
    doc.setFontSize(12);
    doc.setTextColor(51, 51, 51);
    doc.text('Vocabulary List', 40, 70);

    autoTable(doc, {
      startY: 80,
      head: [['Word', 'IPA', 'Translation']],
      body: words.map((w) => [w.word, w.ipa, w.translation]),
      headStyles: { fillColor: [37, 99, 235], textColor: 255 },
      styles: { fontSize: 10, cellPadding: 5 },
      margin: { left: 40, right: 40 },
    });

    // Original text + translation below the table
    // @ts-ignore - lastAutoTable is added by the plugin
    let y = (doc as any).lastAutoTable.finalY + 24;
    const pageHeight = doc.internal.pageSize.getHeight();
    const pageWidth = doc.internal.pageSize.getWidth();
    const maxWidth = pageWidth - 80;

    const addBlock = (title: string, content: string) => {
      if (!content) return;
      if (y > pageHeight - 60) { doc.addPage(); y = 40; }
      doc.setFontSize(12);
      doc.setTextColor(51, 51, 51);
      doc.text(title, 40, y);
      y += 16;
      doc.setFontSize(10);
      const lines = doc.splitTextToSize(content, maxWidth);
      for (const line of lines) {
        if (y > pageHeight - 40) { doc.addPage(); y = 40; }
        doc.text(line, 40, y);
        y += 14;
      }
      y += 12;
    };

    addBlock('Original Text', currentText);
    addBlock('Translation', sentenceTranslation);

    doc.save(`vocabulary-${Date.now()}.pdf`);
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
