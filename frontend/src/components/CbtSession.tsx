import { useEffect, useRef, useState } from 'react';
import type { ExamPdfReferences } from './ExamPdfLinks';
import './CbtSession.css';

export interface CbtQuestion extends ExamPdfReferences {
  id: number;
  displayNo: number;
  questionNo: number;
  questionJa: string;
  question?: { ja: string };
  options?: { id: string; label: string; ja: string }[];
  isTrueFalse: boolean;
  choices: string[];
}

interface Props {
  title: string;
  questions: CbtQuestion[];
  selections: Record<number, string>;
  remaining: number;
  submitting: boolean;
  error: string | null;
  onSelect: (id: number, label: string | null) => void;
  onSubmit: () => void;
}

function clock(value: number) {
  const seconds = Math.max(0, value);
  return `${Math.floor(seconds / 3600).toString().padStart(2, '0')}:${Math.floor(seconds % 3600 / 60).toString().padStart(2, '0')}:${(seconds % 60).toString().padStart(2, '0')}`;
}

export function CbtSession({ title, questions, selections, remaining, submitting, error, onSelect, onSubmit }: Props) {
  const [active, setActive] = useState(0);
  const [flags, setFlags] = useState<Set<number>>(new Set());
  const [filter, setFilter] = useState<'all' | 'blank' | 'flagged'>('all');
  const [confirm, setConfirm] = useState(false);
  const [showPdf, setShowPdf] = useState(false);
  const [fontSize, setFontSize] = useState(19);
  const [showPassage, setShowPassage] = useState(true);
  const [pdfIndex, setPdfIndex] = useState(0);
  const [showGrid, setShowGrid] = useState(false);
  const heading = useRef<HTMLHeadingElement>(null);
  const submitButton = useRef<HTMLButtonElement>(null);
  const cancelButton = useRef<HTMLButtonElement>(null);
  const q = questions[active];
  const answered = questions.filter(item => !!selections[item.id]).length;
  const blank = questions.length - answered;
  const pdfs = [...(q.assets ?? []), ...(q.passage?.assets ?? [])].flatMap(asset => asset.pages.map(page => ({ url: asset.url, page })));
  const selectedPdf = pdfs[Math.min(pdfIndex, Math.max(pdfs.length - 1, 0))];

  useEffect(() => {
    setShowPdf(false);
    setPdfIndex(0);
    heading.current?.focus();
  }, [active]);
  useEffect(() => {
    if (confirm) cancelButton.current?.focus();
  }, [confirm]);
  useEffect(() => {
    if (!confirm) return;
    const previous = document.body.style.overflow;
    document.body.style.overflow = 'hidden';
    return () => { document.body.style.overflow = previous; };
  }, [confirm]);
  useEffect(() => {
    const warn = (event: BeforeUnloadEvent) => { event.preventDefault(); event.returnValue = ''; };
    window.addEventListener('beforeunload', warn);
    return () => window.removeEventListener('beforeunload', warn);
  }, []);
  const go = (index: number) => { setActive(index); setShowGrid(false); };
  const toggleFlag = () => setFlags(previous => {
    const next = new Set(previous);
    if (next.has(q.id)) next.delete(q.id); else next.add(q.id);
    return next;
  });
  const visible = questions.map((item, index) => ({ item, index })).filter(({ item }) =>
    filter === 'all' || (filter === 'blank' ? !selections[item.id] : flags.has(item.id)));

  return <div className="cbt-session">
    <header className="cbt-header">
      <div className="cbt-brand"><span className="cbt-logo" aria-hidden="true">IT</span><div><span className="cbt-eyebrow">PHÒNG THI THỬ · CBT</span><strong>{title || 'Thi thử chứng chỉ'}</strong></div></div>
      <div className={`cbt-clock ${remaining <= 300 ? 'is-low' : ''}`} role="timer" aria-label="Thời gian còn lại"><span>Thời gian còn lại</span><strong>{clock(remaining)}</strong></div>
      <button className="cbt-end" ref={submitButton} onClick={() => setConfirm(true)} disabled={submitting}>Nộp bài <span aria-hidden="true">↗</span></button>
    </header>

    <div className="cbt-layout">
      <main className="cbt-workspace">
        <div className="cbt-question-toolbar"><span>Câu <strong>{active + 1}</strong><span className="cbt-muted"> / {questions.length}</span></span><div className="cbt-text-controls"><span>Cỡ chữ</span><button aria-label="Giảm cỡ chữ" disabled={fontSize <= 17} onClick={() => setFontSize(size => size - 1)}>A−</button><button aria-label="Tăng cỡ chữ" disabled={fontSize >= 24} onClick={() => setFontSize(size => size + 1)}>A+</button></div></div>
        {error && <div className="cbt-error" role="alert">{error}</div>}
        <article className="cbt-paper" style={{ '--cbt-font-size': `${fontSize}px` } as React.CSSProperties}>
          <div className="cbt-paper-heading"><h1 ref={heading} tabIndex={-1}>問 {active + 1}</h1><button className={`cbt-flag ${flags.has(q.id) ? 'is-flagged' : ''}`} aria-pressed={flags.has(q.id)} onClick={toggleFlag}><span aria-hidden="true">⚑</span> {flags.has(q.id) ? 'Đã đánh dấu xem lại' : 'Đánh dấu xem lại'}</button></div>
          {q.passage?.text?.ja && <section className="cbt-passage"><button onClick={() => setShowPassage(value => !value)} aria-expanded={showPassage}>Bài đọc dùng chung <span>{showPassage ? '−' : '+'}</span></button>{showPassage && <p lang="ja">{q.passage.text.ja}</p>}</section>}
          <p className="cbt-stem" lang="ja">{q.question?.ja || q.questionJa}</p>
          {pdfs.length > 0 && <div className="cbt-source"><button className="cbt-source-toggle" onClick={() => setShowPdf(value => !value)} aria-expanded={showPdf}><span aria-hidden="true">▧</span> {showPdf ? 'Ẩn đề gốc' : 'Xem hình / bảng trong đề gốc'} <span aria-hidden="true">{showPdf ? '−' : '+'}</span></button>{showPdf && selectedPdf && <div className="cbt-pdf"><div className="cbt-pdf-toolbar"><label>Trang <select aria-label="Trang PDF" value={Math.min(pdfIndex, pdfs.length - 1)} onChange={event => setPdfIndex(Number(event.target.value))}>{pdfs.map((pdf, index) => <option key={`${pdf.url}-${pdf.page}-${index}`} value={index}>{pdf.page}</option>)}</select></label><a href={`${selectedPdf.url}#page=${selectedPdf.page}`} target="_blank" rel="noreferrer">Mở riêng ↗</a></div><iframe title={`Đề gốc trang ${selectedPdf.page}`} src={`${selectedPdf.url}#page=${selectedPdf.page}&view=FitH&toolbar=0`} /></div>}</div>}
          <fieldset className="cbt-options" disabled={submitting}><legend>Chọn một đáp án</legend>{q.options?.length ? q.options.map(option => <label key={option.id} className={`cbt-option ${selections[q.id] === option.label ? 'is-selected' : ''}`}><input type="radio" name={`answer-${q.id}`} checked={selections[q.id] === option.label} onChange={() => onSelect(q.id, option.label)} /><span className="cbt-option-label" aria-hidden="true">{option.label}</span><span lang="ja">{option.ja}</span></label>) : q.choices.map(choice => <label key={choice} className={`cbt-option ${selections[q.id] === choice ? 'is-selected' : ''}`}><input type="radio" name={`answer-${q.id}`} checked={selections[q.id] === choice} onChange={() => onSelect(q.id, choice)} /><span className="cbt-option-label">{choice}</span><span>{q.isTrueFalse ? (choice === '○' ? 'Đúng' : 'Sai') : `Chọn ${choice}`}</span></label>)}</fieldset>
          <div className="cbt-selection-status"><span>{selections[q.id] ? `Đã chọn: ${selections[q.id]}` : 'Chưa chọn đáp án'}</span>{selections[q.id] && <button onClick={() => onSelect(q.id, null)}>Xóa lựa chọn</button>}</div>
        </article>
        <footer className="cbt-navigation"><button disabled={active === 0} onClick={() => go(active - 1)}>← Câu trước</button><span>{active + 1} / {questions.length}</span>{active < questions.length - 1 ? <button className="cbt-next" onClick={() => go(active + 1)}>Câu tiếp →</button> : <button className="cbt-next" onClick={() => { setShowGrid(true); setFilter('blank'); }}>Kiểm tra bài →</button>}</footer>
      </main>

      <aside className={`cbt-sidebar ${showGrid ? 'is-open' : ''}`} aria-label="Điều hướng câu hỏi"><div className="cbt-sidebar-title"><h2>Danh sách câu hỏi</h2><button className="cbt-grid-close" onClick={() => setShowGrid(false)} aria-label="Đóng danh sách câu hỏi">×</button></div><div className="cbt-completion"><strong>{answered}<small> / {questions.length} câu đã trả lời</small></strong><progress value={answered} max={questions.length} aria-label="Tiến độ làm bài" /></div><div className="cbt-grid-filters" aria-label="Lọc câu hỏi">{(['all', 'blank', 'flagged'] as const).map(value => <button key={value} aria-pressed={filter === value} onClick={() => setFilter(value)}>{value === 'all' ? 'Tất cả' : value === 'blank' ? `Chưa làm (${blank})` : `Xem lại (${flags.size})`}</button>)}</div><div className="cbt-question-grid">{visible.map(({ item, index }) => <button key={item.id} aria-label={`Câu ${index + 1}${selections[item.id] ? ', đã trả lời' : ', chưa trả lời'}${flags.has(item.id) ? ', đánh dấu xem lại' : ''}`} aria-current={index === active ? 'step' : undefined} className={`${selections[item.id] ? 'is-answered' : ''} ${flags.has(item.id) ? 'is-flagged' : ''}`} onClick={() => go(index)}>{index + 1}{flags.has(item.id) && <i aria-hidden="true" />}</button>)}</div>{visible.length === 0 && <p className="cbt-grid-empty">Không có câu hỏi trong mục này.</p>}<div className="cbt-legend"><span><i className="answered" />Đã trả lời</span><span><i />Chưa trả lời</span><span><i className="flagged" />Đánh dấu</span></div><p className="cbt-session-note">Bạn có thể đổi đáp án đến khi nộp bài.</p></aside>
    </div>
    <button className="cbt-grid-mobile" onClick={() => setShowGrid(value => !value)}>Danh sách câu · {answered}/{questions.length}</button>
    {confirm && <div className="cbt-dialog-backdrop" onClick={() => { if (!submitting) { setConfirm(false); submitButton.current?.focus(); } }}><section className="cbt-dialog" role="dialog" aria-modal="true" aria-labelledby="cbt-submit-title" onClick={event => event.stopPropagation()} onKeyDown={event => { if (event.key === 'Escape' && !submitting) { setConfirm(false); submitButton.current?.focus(); } if (event.key === 'Tab') { const buttons = Array.from(event.currentTarget.querySelectorAll<HTMLButtonElement>('button:not(:disabled)')); if (!buttons.length) { event.preventDefault(); return; } const target = event.shiftKey ? buttons[0] : buttons[buttons.length - 1]; if (document.activeElement === target) { event.preventDefault(); (event.shiftKey ? buttons[buttons.length - 1] : buttons[0]).focus(); } } }}><span className="cbt-eyebrow">KẾT THÚC BÀI THI</span><h2 id="cbt-submit-title">Bạn đã sẵn sàng nộp bài?</h2><p>Sau khi nộp, bạn sẽ xem được đáp án và giải thích.</p><div className="cbt-submit-summary"><div><strong>{answered}</strong><span>Đã trả lời</span></div><div><strong>{blank}</strong><span>Chưa trả lời</span></div><div><strong>{flags.size}</strong><span>Đánh dấu xem lại</span></div></div>{blank > 0 && <p className="cbt-submit-warning">Còn {blank} câu chưa trả lời. Các câu này sẽ được tính là sai.</p>}{error && <p role="alert" className="cbt-error">{error}</p>}<div className="cbt-dialog-actions"><button ref={cancelButton} disabled={submitting} onClick={() => { setConfirm(false); submitButton.current?.focus(); }}>Tiếp tục làm bài</button><button className="cbt-next" disabled={submitting} onClick={onSubmit}>{submitting ? 'Đang chấm bài…' : 'Xác nhận nộp bài'}</button></div></section></div>}
  </div>;
}
