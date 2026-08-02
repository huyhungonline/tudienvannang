import { useState, useCallback } from 'react';
import { playBase64Audio } from '../utils/audio';

interface AudioButtonProps {
  audioData: string | null;
}

export function AudioButton({ audioData }: AudioButtonProps) {
  const [isPlaying, setIsPlaying] = useState(false);

  const handlePlay = useCallback(() => {
    if (!audioData) return;

    setIsPlaying(true);
    playBase64Audio(audioData).finally(() => setIsPlaying(false));
  }, [audioData]);

  if (!audioData) {
    return (
      <button className="audio-btn disabled" disabled title="Audio not available for this word">
        🔇
      </button>
    );
  }

  return (
    <button
      className={`audio-btn ${isPlaying ? 'playing' : ''}`}
      onClick={handlePlay}
      disabled={isPlaying}
      aria-label="Play pronunciation"
    >
      {isPlaying ? '🔉' : '🔊'}
    </button>
  );
}
