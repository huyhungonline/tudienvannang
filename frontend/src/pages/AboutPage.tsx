import { useState } from 'react';

export function AboutPage() {
  const [lang, setLang] = useState<'vi' | 'en' | 'ja'>('vi');

  return (
    <div className="about-page">
      <div className="about-lang-switcher">
        <button className={lang === 'vi' ? 'active' : ''} onClick={() => setLang('vi')}>Tiếng Việt</button>
        <button className={lang === 'en' ? 'active' : ''} onClick={() => setLang('en')}>English</button>
        <button className={lang === 'ja' ? 'active' : ''} onClick={() => setLang('ja')}>日本語</button>
      </div>

      {lang === 'vi' && (
        <div className="about-content">
          <h1>Giới thiệu về trang web</h1>
          <p>
            Đây là công cụ học ngôn ngữ miễn phí giúp bạn tách câu thành từng từ kèm phiên âm IPA,
            phát âm, và dịch sang nhiều ngôn ngữ.
          </p>
          <h2>Tính năng</h2>
          <ul>
            <li>Tách văn bản tiếng Anh thành từng từ kèm phiên âm IPA</li>
            <li>Nghe phát âm từng từ</li>
            <li>Dịch từ sang tiếng Nhật, tiếng Việt, tiếng Trung</li>
            <li>Dịch toàn bộ câu</li>
            <li>Lưu lịch sử tra cứu để xem lại</li>
            <li>Bài đọc luyện kỹ năng đọc hiểu</li>
          </ul>
          <h2>Cách sử dụng</h2>
          <ol>
            <li>Nhập hoặc dán câu vào ô nhập liệu</li>
            <li>Chọn ngôn ngữ đích muốn dịch</li>
            <li>Bấm "Split &amp; Translate" để xem kết quả</li>
            <li>Bấm biểu tượng loa để nghe phát âm</li>
            <li>Đăng nhập để lưu danh sách từ vựng và xem lại sau</li>
          </ol>
          <h2>📘 Thi chứng chỉ tại Nhật</h2>
          <p>
            Tính năng giúp bạn luyện thi các chứng chỉ nghề bằng tiếng Nhật (cơ khí, điện, IT và viễn thông...),
            gồm từ vựng chuyên ngành theo chủ đề và bộ đề thi thử kèm đáp án, bản dịch và giải thích chi tiết.
          </p>
          <ol>
            <li>Vào mục "Thi chứng chỉ tại Nhật" trên thanh menu</li>
            <li>Chọn lĩnh vực (cơ khí, điện, xây dựng, thực phẩm, IT và viễn thông...)</li>
            <li>Chọn chứng chỉ muốn luyện</li>
            <li>Chọn "Từ vựng chuyên ngành" để học từ theo chủ đề, hoặc "Giải đề các năm" để luyện đề thi</li>
            <li>Ở phần đề thi, đọc câu hỏi tiếng Nhật rồi bấm "Show answer" để xem đáp án, bản dịch và giải thích</li>
          </ol>
          <p className="about-note">Lưu ý: tính năng này dành riêng cho tài khoản Pro hoặc Admin.</p>
          <h2>⭐ Quyền lợi tài khoản Pro</h2>
          <ul>
            <li>Tra từ và lưu từ vựng không giới hạn</li>
            <li>Được sử dụng các chức năng phục vụ cho việc luyện thi chứng chỉ chuyên ngành</li>
            <li>Giảm giá 10% khi mua sách</li>
          </ul>
        </div>
      )}

      {lang === 'en' && (
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
          <h2>📘 Certificate Exam Practice</h2>
          <p>
            A feature that helps you prepare for professional certification exams in Japanese (mechanical,
            electrical, IT and Telecommunications...), including topic-based vocabulary and practice exams with answers,
            translations, and detailed explanations.
          </p>
          <ol>
            <li>Open "Thi chứng chỉ tại Nhật" from the navigation menu</li>
            <li>Choose a field (mechanical, electrical, construction, food, IT and Telecommunications...)</li>
            <li>Choose the certificate you want to practice</li>
            <li>Choose "Vocabulary" to study terms by topic, or "Exercises" to practice exam questions</li>
            <li>In the exercises, read the Japanese question then click "Show answer" to reveal the answer, translation, and explanation</li>
          </ol>
          <p className="about-note">Note: this feature is only available to Pro or Admin accounts.</p>
          <h2>⭐ Pro Benefits</h2>
          <ul>
            <li>Unlimited word lookups and vocabulary saving</li>
            <li>Access to professional certificate exam practice features</li>
            <li>10% discount when purchasing books</li>
          </ul>
        </div>
      )}

      {lang === 'ja' && (
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
          <h2>📘 専門資格試験対策</h2>
          <p>
            機械系、電気系、IT・通信系など、日本語で行われる技能検定・資格試験の対策機能です。
            分野別の専門用語と、解答・和訳・詳しい解説付きの模擬問題が利用できます。
          </p>
          <ol>
            <li>メニューの「Thi chứng chỉ tại Nhật（専門資格試験対策）」を開く</li>
            <li>分野（機械系、電気系、建築系、食品系、IT・通信系など）を選ぶ</li>
            <li>対策したい資格を選ぶ</li>
            <li>「専門用語（Từ vựng chuyên ngành）」でテーマ別単語を学ぶか、「問題（Giải đề các năm）」で模擬問題を解く</li>
            <li>問題画面では日本語の設問を読み、「Show answer」を押すと解答・和訳・解説が表示される</li>
          </ol>
          <p className="about-note">注意：この機能はProアカウントまたは管理者アカウント限定です。</p>
          <h2>⭐ Pro会員特典</h2>
          <ul>
            <li>単語検索と単語帳保存が無制限</li>
            <li>専門資格試験対策機能が利用可能</li>
            <li>書籍購入時10%割引</li>
          </ul>
        </div>
      )}
    </div>
  );
}
