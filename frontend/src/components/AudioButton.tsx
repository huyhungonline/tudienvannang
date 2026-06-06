import { useState, useCallback } from 'react';

interface AudioButtonProps {
  audioData: string | null;
}

export function AudioButton({ audioData }: AudioButtonProps) {
  const [isPlaying, setIsPlaying] = useState(false);

  const handlePlay = useCallback(() => {
    if (!audioData) return;

    setIsPlaying(true);

    const byteCharacters = atob(audioData);
    const byteNumbers = new Array(byteCharacters.length);
    for (let i = 0; i < byteCharacters.length; i++) {
      byteNumbers[i] = byteCharacters.charCodeAt(i);
    }
    const byteArray = new Uint8Array(byteNumbers);
    const blob = new Blob([byteArray], { type: 'audio/mpeg' });
    const url = URL.createObjectURL(blob);

    const audio = new Audio(url);
    audio.onended = () => {
      setIsPlaying(false);
      URL.revokeObjectURL(url);
    };
    audio.onerror = () => {
      setIsPlaying(false);
      URL.revokeObjectURL(url);
    };
    audio.play();
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
