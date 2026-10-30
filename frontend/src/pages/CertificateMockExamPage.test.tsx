import { act, cleanup, render, screen, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { MemoryRouter, Route, Routes } from 'react-router-dom';
import { afterEach, beforeEach, expect, test, vi } from 'vitest';
import { get, post } from '../api/client';
import { CertificateMockExamPage } from './CertificateMockExamPage';

vi.mock('../api/client', () => ({ get: vi.fn(), post: vi.fn() }));
const config = { configuredCount: 2, effectiveCount: 2, availableCount: 1700, durationMinutes: 120, requiredAnswers: null, isShortOfPool: false };
const questions = [1, 2].map(n => ({ id: n, displayNo: n, questionNo: n, questionJa: 'Legacy combined body', question: { ja: `問題${n} 本文` }, choices: ['ア', 'イ', 'ウ', 'エ'], isTrueFalse: false,
  options: ['ア', 'イ', 'ウ', 'エ'].map((label, i) => ({ id: 'ABCD'[i], label, ja: `選択肢 ${n}-${i + 1}` })) }));
beforeEach(() => {
  vi.spyOn(window, 'scrollTo').mockImplementation(() => {});
  vi.mocked(get).mockImplementation(async path => path.endsWith('/info') ? { certificate: { nameJa: 'ITパスポート試験' }, config } : { config, questions });
  vi.mocked(post).mockResolvedValue({ attemptId: null, totalQuestions: 2, correctCount: 1, scorePercent: 50, durationSeconds: 10, results: [] });
});
afterEach(() => { cleanup(); vi.useRealTimers(); vi.restoreAllMocks(); vi.resetAllMocks(); });

function mount() { render(<MemoryRouter initialEntries={['/certificates/itpp/itpp/mock-exam']}><Routes><Route path="/certificates/:category/:code/mock-exam" element={<CertificateMockExamPage />} /></Routes></MemoryRouter>); }

test('one-question CBT keeps answers and flags across navigation; submits only after confirmation', async () => {
  const user = userEvent.setup(); mount();
  await user.click(await screen.findByRole('button', { name: 'Bắt đầu thi thử' }));
  expect(await screen.findByText('問題1 本文')).toBeInTheDocument();
  expect(screen.queryByText('問題2 本文')).not.toBeInTheDocument();
  expect(screen.queryByText('Legacy combined body')).not.toBeInTheDocument();
  await user.click(screen.getByRole('radio', { name: /選択肢 1-2/ }));
  await user.click(screen.getByRole('button', { name: /Đánh dấu xem lại/ }));
  await user.click(screen.getByRole('button', { name: /Câu tiếp/ }));
  expect(screen.getByText('問題2 本文')).toBeInTheDocument();
  await user.click(screen.getByRole('button', { name: /Câu trước/ }));
  expect(screen.getByRole('radio', { name: /選択肢 1-2/ })).toBeChecked();
  expect(screen.getByRole('button', { name: /Đã đánh dấu xem lại/ })).toHaveAttribute('aria-pressed', 'true');
  await user.click(screen.getByRole('button', { name: 'Xem lại (1)' }));
  expect(screen.queryByRole('button', { name: /^Câu 2,/ })).not.toBeInTheDocument();
  await user.click(screen.getByRole('button', { name: /Nộp bài/ }));
  expect(screen.getByRole('dialog')).toBeInTheDocument();
  expect(screen.getByText(/Còn 1 câu chưa trả lời/)).toBeInTheDocument();
  expect(post).not.toHaveBeenCalled();
  await user.keyboard('{Escape}'); expect(screen.queryByRole('dialog')).not.toBeInTheDocument();
  await user.click(screen.getByRole('button', { name: /Nộp bài/ }));
  await user.click(screen.getByRole('button', { name: 'Xác nhận nộp bài' }));
  await waitFor(() => expect(post).toHaveBeenCalledTimes(1));
  expect(post).toHaveBeenCalledWith('/certificates/itpp/mock-exam/submit', expect.objectContaining({ answers: [{ questionId: 1, selectedLabel: 'イ' }, { questionId: 2, selectedLabel: null }] }));
  expect(screen.queryByRole('timer')).not.toBeInTheDocument();
  expect(get).not.toHaveBeenCalledWith(expect.stringContaining('/history'));
});

test('empty or failed paper stays on setup with an actionable error', async () => {
  const user = userEvent.setup();
  vi.mocked(get).mockImplementation(async path => path.endsWith('/info') ? { certificate: { nameJa: 'IT' }, config } : { config, questions: [] });
  mount(); await user.click(await screen.findByRole('button', { name: 'Bắt đầu thi thử' }));
  expect(await screen.findByText('Không bắt đầu được bài thi.')).toBeInTheDocument();
  expect(screen.queryByRole('timer')).not.toBeInTheDocument();
});

test('deadline submits once automatically without requiring the confirmation dialog', async () => {
  mount();
  await screen.findByRole('button', { name: 'Bắt đầu thi thử' });
  vi.useFakeTimers();
  await act(async () => { screen.getByRole('button', { name: 'Bắt đầu thi thử' }).click(); });
  await act(async () => { await vi.advanceTimersByTimeAsync(120 * 60 * 1000); });
  expect(post).toHaveBeenCalledTimes(1);
  expect(screen.queryByRole('dialog')).not.toBeInTheDocument();
});
