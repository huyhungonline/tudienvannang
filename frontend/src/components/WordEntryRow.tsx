import type { WordEntry } from 'shared';
import { AudioButton } from './AudioButton';

interface WordEntryRowProps {
  entry: WordEntry;
}

export function WordEntryRow({ entry }: WordEntryRowProps) {
  return (
    <tr className="word-entry-row">
      <td className="word-cell">{entry.word}</td>
      <td className="ipa-cell">{entry.ipa}</td>
      <td className="audio-cell">
        <AudioButton audioData={entry.audioData} />
      </td>
      <td className="translation-cell">{entry.translation}</td>
    </tr>
  );
}
