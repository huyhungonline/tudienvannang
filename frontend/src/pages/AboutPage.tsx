import { useState } from 'react';

export function AboutPage() {
  const [lang, setLang] = useState<'en' | 'ja'>('en');

  return (
    <div className="about-page">
      <div className="about-lang-switcher">
        <button className={lang === 'en' ? 'active' : ''} onClick={() => setLang('en')}>English</button>
        <button className={lang === 'ja' ? 'active' : ''} onClick={() => setLang('ja')}>日本語</button>
      </div>

      {lang === 'en' ? (
        <div className="about-content">
          <h1>About This Website</h1>
          <p>
            English Word Splitter is a free language learning tool that helps you break down English sentences
            into individual words with IPA pronunciation, audio playback, and translations into multiple languages.
          </p>
          <h2>Features</h2>
          <ul>
            <li>Split English text into words with IPA transcription</li>
            <li>Listen to pronunciation for each word</li>
            <li>Translate words into Japanese, Vietnamese, Chinese, and Korean</li>
            <li>Full sentence translation</li>
            <li>Save your search history for review</li>
            <li>Reading posts to practice comprehension</li>
          </ul>
          <h2>How to Use</h2>
          <ol>
            <li>Enter or paste an English sentence in the input box</li>
            <li>Select your target translation language</li>
            <li>Click "Split & Translate" to see results</li>
            <li>Click the speaker icon to hear pronunciation</li>
            <li>Log in to save your word lists for later review</li>
          </ol>
        </div>
      ) : (
        <div className="about-content">
          <h1>このウェブサイトについて</h1>
          <p>
            English Word Splitterは、英語の文章を単語ごとに分割し、IPA発音記号、音声再生、
            多言語翻訳を提供する無料の語学学習ツールです。
          </p>
          <h2>機能</h2>
          <ul>
            <li>英文をIPA発音記号付きの単語に分割</li>
            <li>各単語の発音を聴く</li>
            <li>日本語、ベトナム語、中国語、韓国語への翻訳</li>
            <li>文全体の翻訳</li>
            <li>検索履歴を保存して復習</li>
            <li>読解練習用のリーディング記事</li>
          </ul>
          <h2>使い方</h2>
          <ol>
            <li>入力欄に英文を入力または貼り付ける</li>
            <li>翻訳先の言語を選択する</li>
            <li>「Split & Translate」をクリックして結果を表示</li>
            <li>スピーカーアイコンをクリックして発音を聴く</li>
            <li>ログインして単語リストを保存し、後で復習する</li>
          </ol>
        </div>
      )}
    </div>
  );
}
