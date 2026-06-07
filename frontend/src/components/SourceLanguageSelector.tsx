import { useState, useEffect } from 'react';
import type { SourceLanguage } from 'shared';

interface SourceLanguageSelectorProps {
  onLanguageChange: (language: SourceLanguage) => void;
}

const SOURCE_OPTIONS: { value: SourceLanguage; label: string }[] = [
  { value: 'en', label: 'English' },
  { value: 'ja', label: 'Japanese' },
  { value: 'vi', label: 'Vietnamese' },
  { value: 'zh', label: 'Chinese' },
];

const STORAGE_KEY = 'selectedSourceLanguage';

function getInitialLanguage(): SourceLanguage {
  const stored = sessionStorage.getItem(STORAGE_KEY);
  if (stored === 'en' || stored === 'ja' || stored === 'vi' || stored === 'zh') {
    return stored;
  }
  return 'en';
}

export function SourceLanguageSelector({ onLanguageChange }: SourceLanguageSelectorProps) {
  const [language, setLanguage] = useState<SourceLanguage>(getInitialLanguage);

  useEffect(() => {
    onLanguageChange(language);
  }, [language, onLanguageChange]);

  const handleChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
    const value = e.target.value as SourceLanguage;
    setLanguage(value);
    sessionStorage.setItem(STORAGE_KEY, value);
  };

  return (
    <div className="language-selector">
      <label htmlFor="source-language-select">Source Language:</label>
      <select id="source-language-select" value={language} onChange={handleChange}>
        {SOURCE_OPTIONS.map((opt) => (
          <option key={opt.value} value={opt.value}>
            {opt.label}
          </option>
        ))}
      </select>
    </div>
  );
}
