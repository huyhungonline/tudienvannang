import { useState, useEffect } from 'react';
import type { TargetLanguage } from 'shared';

interface LanguageSelectorProps {
  onLanguageChange: (language: TargetLanguage) => void;
}

const LANGUAGE_OPTIONS: { value: TargetLanguage; label: string }[] = [
  { value: 'ja', label: 'Japanese' },
  { value: 'vi', label: 'Vietnamese' },
];

const STORAGE_KEY = 'selectedLanguage';

function getInitialLanguage(): TargetLanguage {
  const stored = sessionStorage.getItem(STORAGE_KEY);
  if (stored === 'ja' || stored === 'vi' || stored === 'zh') {
    return stored;
  }
  return 'vi';
}

export function LanguageSelector({ onLanguageChange }: LanguageSelectorProps) {
  const [language, setLanguage] = useState<TargetLanguage>(getInitialLanguage);

  useEffect(() => {
    onLanguageChange(language);
  }, [language, onLanguageChange]);

  const handleChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
    const value = e.target.value as TargetLanguage;
    setLanguage(value);
    sessionStorage.setItem(STORAGE_KEY, value);
  };

  return (
    <div className="language-selector">
      <label htmlFor="language-select">Target Language:</label>
      <select id="language-select" value={language} onChange={handleChange}>
        {LANGUAGE_OPTIONS.map((opt) => (
          <option key={opt.value} value={opt.value}>
            {opt.label}
          </option>
        ))}
      </select>
    </div>
  );
}
