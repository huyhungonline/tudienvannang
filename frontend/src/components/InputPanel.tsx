import { useState, useMemo, useEffect } from 'react';
import type { SourceLanguage } from 'shared';

interface InputPanelProps {
  onSubmit: (text: string) => void;
  externalText?: string;
  sourceLanguage?: SourceLanguage;
  onAutoDetectLanguage?: (lang: SourceLanguage) => void;
}

function countWords(text: string): number {
  const words = text.split(/[^a-zA-Z]+/).filter((w) => w.length > 0);
  const unique = new Set(words.map((w) => w.toLowerCase()));
  return unique.size;
}

function hasJapanese(text: string): boolean {
  return /[\u3040-\u309F\u30A0-\u30FF\u4E00-\u9FFF]/.test(text);
}

function hasVietnamese(text: string): boolean {
  return /[àáảãạăắằẳẵặâấầẩẫậèéẻẽẹêếềểễệìíỉĩịòóỏõọôốồổỗộơớờởỡợùúủũụưứừửữựỳýỷỹỵđ]/i.test(text);
}

function detectLanguage(text: string): SourceLanguage | null {
  if (hasJapanese(text)) return 'ja';
  if (hasVietnamese(text)) return 'vi';
  if (/^[a-zA-Z0-9\s\.,;:!?'"()\-\[\]{}\/\\@#$%^&*+=<>~`]+$/.test(text)) return 'en';
  return null;
}

export function InputPanel({ onSubmit, externalText, sourceLanguage = 'en', onAutoDetectLanguage }: InputPanelProps) {
  const [text, setText] = useState('');

  useEffect(() => {
    if (externalText !== undefined && externalText !== text) {
      setText(externalText);
    }
  }, [externalText]);

  // Auto-detect language when text changes
  useEffect(() => {
    if (!text.trim() || !onAutoDetectLanguage) return;
    const detected = detectLanguage(text);
    if (detected && detected !== sourceLanguage) {
      onAutoDetectLanguage(detected);
    }
  }, [text]);

  const wordCount = useMemo(() => countWords(text), [text]);
  const isOverLimit = sourceLanguage === 'en' && wordCount > 50;

  const mismatchWarning = useMemo(() => {
    if (!text.trim()) return null;
    const isJP = hasJapanese(text);
    const isVN = hasVietnamese(text);
    const isEnOnly = /^[a-zA-Z0-9\s\.,;:!?'"()\-\[\]{}\/\\@#$%^&*+=<>~`]+$/.test(text);

    if (sourceLanguage === 'en') {
      if (isJP) return 'Text contains Japanese. Please select Source Language = Japanese.';
      if (isVN) return 'Text contains Vietnamese. Please select Source Language = Vietnamese.';
    }
    if (sourceLanguage === 'ja') {
      if (!isJP && text.length > 3) return 'Text does not appear to be Japanese. Please check Source Language.';
    }
    if (sourceLanguage === 'vi') {
      if (isJP) return 'Text contains Japanese. Please select Source Language = Japanese.';
      if (!isVN && isEnOnly && text.length > 3) return 'Text appears to be English. Please select Source Language = English.';
    }
    return null;
  }, [text, sourceLanguage]);

  const handleSubmit = () => {
    if (!isOverLimit) {
      onSubmit(text);
    }
  };

  return (
    <div className="input-panel">
      <textarea
        className="input-textarea"
        value={text}
        onChange={(e) => setText(e.target.value)}
        placeholder={sourceLanguage === 'en' ? 'Paste or type English text here...' : 'Enter text to translate...'}
        rows={10}
      />
      <div className="input-footer">
        {sourceLanguage === 'en' && (
          <span className={`word-count ${isOverLimit ? 'over-limit' : ''}`}>
            {wordCount}/50 words
          </span>
        )}
        {isOverLimit && (
          <span className="word-limit-warning">
            Text is too long. Please enter a maximum of 50 words.
          </span>
        )}
        {mismatchWarning && (
          <span className="word-limit-warning">{mismatchWarning}</span>
        )}
      </div>
      <button className="btn-split" onClick={handleSubmit} disabled={!text.trim() || isOverLimit}>
        Analyze & Translate
      </button>
    </div>
  );
}
