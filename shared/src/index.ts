export interface WordEntry {
  word: string;
  ipa: string;
  audioData: string | null;
  translation: string;
}

export interface ProcessedResult {
  words: WordEntry[];
  sentenceTranslation: string;
}

export interface DictionaryWord {
  word: string;
  ipaPronunciation: string;
  audioData: string | null;
  meaningJa: string;
  meaningVi: string;
  meaningZh: string;
}

export interface User {
  id: string;
  email: string;
  createdAt: Date;
}

export interface SearchHistory {
  id: string;
  userId: string;
  inputText: string;
  targetLanguage: TargetLanguage;
  sentenceTranslation: string;
  words: WordEntry[];
  createdAt: Date;
}

export type TargetLanguage = 'ja' | 'vi' | 'zh' | 'en';
export type SourceLanguage = 'en' | 'ja' | 'vi' | 'zh';
