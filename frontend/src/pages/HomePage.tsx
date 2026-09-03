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
    const esc = (s: string) => s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
    const rows = words.map((w) =>
      `<tr>
        <td style="border:1px solid #ddd;padding:6px 10px;font-size:13px;">${esc(w.word)}</td>
        <td style="border:1px solid #ddd;padding:6px 10px;font-size:13px;">${esc(w.ipa)}</td>
        <td style="border:1px solid #ddd;padding:6px 10px;font-size:13px;">${esc(w.translation)}</td>
      </tr>`
    ).join('');

    // Build content with inline styles (jsPDF.html reads inline styles reliably)
    const bodyHtml = `
<div style="font-family:'Noto Sans JP','Segoe UI',sans-serif;color:#333;padding:16px;width:720px;">
  <div style="text-align:center;font-size:20px;font-weight:700;color:#2563eb;margin-bottom:20px;">jaenglish.com</div>
  <p style="font-size:15px;font-weight:600;margin:12px 0 8px;">Vocabulary List</p>
  <table style="width:100%;border-collapse:collapse;margin-bottom:20px;">
    <thead>
      <tr>
        <th style="border:1px solid #ddd;padding:6px 10px;background:#2563eb;color:#fff;font-size:13px;text-align:left;">Word</th>
        <th style="border:1px solid #ddd;padding:6px 10px;background:#2563eb;color:#fff;font-size:13px;text-align:left;">IPA</th>
        <th style="border:1px solid #ddd;padding:6px 10px;background:#2563eb;color:#fff;font-size:13px;text-align:left;">Translation</th>
      </tr>
    </thead>
    <tbody>${rows}</tbody>
  </table>
  <p style="font-size:15px;font-weight:600;margin:12px 0 8px;">Original Text</p>
  <div style="background:#f9f9f9;padding:10px;border:1px solid #eee;white-space:pre-wrap;font-size:13px;line-height:1.6;">${esc(currentText)}</div>
  ${sentenceTranslation ? `<p style="font-size:15px;font-weight:600;margin:12px 0 8px;">Translation</p><div style="background:#f9f9f9;padding:10px;border:1px solid #eee;white-space:pre-wrap;font-size:13px;line-height:1.6;">${esc(sentenceTranslation)}</div>` : ''}
</div>`;

    // Render into a visible off-screen container (html2canvas fails on display:none / negative offsets sometimes)
    const container = document.createElement('div');
    container.style.position = 'fixed';
    container.style.top = '0';
    container.style.left = '0';
    container.style.zIndex = '-1';
    container.style.opacity = '0';
    container.style.background = '#fff';
    container.innerHTML = bodyHtml;
    document.body.appendChild(container);

    const pdf = new jsPDF({ unit: 'pt', format: 'a4', orientation: 'portrait' });
    pdf.html(container, {
      callback: (doc) => {
        doc.save(`vocabulary-${Date.now()}.pdf`);
        document.body.removeChild(container);
      },
      margin: [20, 20, 20, 20],
      autoPaging: 'text',
      html2canvas: { scale: 0.75, backgroundColor: '#ffffff' },
      width: 555,
      windowWidth: 720,
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
