import { useState, useMemo, useEffect } from 'react';

interface InputPanelProps {
  onSubmit: (text: string) => void;
  externalText?: string;
}

function countWords(text: string): number {
  const words = text.split(/[^a-zA-Z]+/).filter((w) => w.length > 0);
  const unique = new Set(words.map((w) => w.toLowerCase()));
  return unique.size;
}

export function InputPanel({ onSubmit, externalText }: InputPanelProps) {
  const [text, setText] = useState('');

  useEffect(() => {
    if (externalText !== undefined && externalText !== text) {
      setText(externalText);
    }
  }, [externalText]);

  const wordCount = useMemo(() => countWords(text), [text]);
  const isOverLimit = wordCount > 50;

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
        placeholder="Paste or type English text here..."
        rows={10}
      />
      <div className="input-footer">
        <span className={`word-count ${isOverLimit ? 'over-limit' : ''}`}>
          {wordCount}/50 từ
        </span>
        {isOverLimit && (
          <span className="word-limit-warning">
            Đoạn văn quá dài. Vui lòng nhập tối đa 50 từ.
          </span>
        )}
      </div>
      <button className="btn-split" onClick={handleSubmit} disabled={!text.trim() || isOverLimit}>
        Tách từ & Dịch nghĩa
      </button>
    </div>
  );
}
