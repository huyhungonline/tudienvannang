import { useState, useCallback } from 'react';
import { speak } from '../api/client';
import { playBase64Audio } from '../utils/audio';

interface SpeakButtonProps {
  text: string;
  language: string;
}

type Status = 'idle' | 'loading' | 'playing';

export function SpeakButton({ text, language }: SpeakButtonProps) {
  const [status, setStatus] = useState<Status>('idle');

  const handleClick = useCallback(async () => {
    if (!text.trim() || status !== 'idle') return;

    setStatus('loading');
    try {
      const { audioData } = await speak(text, language);
      setStatus('playing');
      await playBase64Audio(audioData);
    } catch {
      // Playback/generation failed - button just resets to idle below.
    } finally {
      setStatus('idle');
    }
  }, [text, language, status]);

  return (
    <button
      className={`speak-btn ${status}`}
      onClick={handleClick}
      disabled={!text.trim() || status !== 'idle'}
      aria-label="Read aloud"
      title="Read aloud"
    >
      {status === 'loading' ? '⏳' : status === 'playing' ? '🔉' : '🔊'}
    </button>
  );
}
