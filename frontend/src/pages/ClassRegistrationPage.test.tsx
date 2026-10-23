import { cleanup, render, screen, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { MemoryRouter, Route, Routes } from 'react-router-dom';
import { afterEach, beforeEach, expect, test, vi } from 'vitest';
import { ClassRegistrationFormPage } from './ClassRegistrationPage';
import { ApiError, get, post } from '../api/client';

vi.mock('../api/client', async importOriginal => ({
  ...await importOriginal<typeof import('../api/client')>(), get: vi.fn(), post: vi.fn(),
}));

// Classes are loaded from the API, so every test needs the list stubbed.
const SESSIONS = [
  { code: 'sat-tue-20-22', name: 'Lớp tháng 11 — Thứ 7 và thứ 3', firstLessonDate: '2026-11-03', capacity: 110, taken: 5, isFull: false },
  { code: 'sun-thu-20-22', name: 'Lớp tháng 11 — Chủ nhật và thứ 5', firstLessonDate: '2026-11-01', capacity: 110, taken: 110, isFull: true },
];

beforeEach(() => { vi.mocked(get).mockResolvedValue({ sessions: SESSIONS }); });
afterEach(() => { cleanup(); vi.resetAllMocks(); });

async function fillForm() {
  const user = userEvent.setup();
  render(<MemoryRouter initialEntries={['/dang-ki-lop-hoc/it-passport']}>
    <Routes>
      <Route path="/dang-ki-lop-hoc/:course" element={<ClassRegistrationFormPage />} />
      <Route path="/dang-ki-in-sach-bai-tap" element={<h1>Trang in sách</h1>} />
    </Routes>
  </MemoryRouter>);
  // Wait for the class list to arrive before selecting.
  await screen.findByRole('option', { name: /Lớp tháng 11 — Thứ 7/ });
  await user.selectOptions(screen.getByLabelText('Chọn lớp'), 'sat-tue-20-22');
  await user.type(screen.getByLabelText('Họ tên'), 'Test User');
  await user.type(screen.getByLabelText('Email'), 'test@example.com');
  await user.type(screen.getByLabelText('Số điện thoại'), '0901234567');
  return user;
}

test('workbook button saves class before navigating', async () => {
  let finish!: (value: unknown) => void;
  vi.mocked(post).mockReturnValue(new Promise(resolve => { finish = resolve; }));
  const user = await fillForm();
  await user.click(screen.getByRole('button', { name: 'Đăng kí in sách bài tập' }));
  expect(post).toHaveBeenCalledWith('/classes/registrations', expect.objectContaining({
    email: 'test@example.com', schedule: 'sat-tue-20-22', full_name: 'Test User',
  }));
  expect(screen.queryByText('Trang in sách')).not.toBeInTheDocument();
  finish({});
  expect(await screen.findByText('Trang in sách')).toBeInTheDocument();
});

test('full class keeps user on class form', async () => {
  vi.mocked(post).mockRejectedValue(new ApiError(409, 'Lớp đã đầy, vui lòng chọn khung giờ khác'));
  const user = await fillForm();
  await user.click(screen.getByRole('button', { name: 'Đăng kí in sách bài tập' }));
  expect(await screen.findByRole('alert')).toHaveTextContent('Lớp đã đầy');
  expect(screen.queryByText('Trang in sách')).not.toBeInTheDocument();
  expect(screen.getByLabelText('Email')).toHaveValue('test@example.com');
});

test('normal signup saves without opening workbook page', async () => {
  vi.mocked(post).mockResolvedValue({});
  const user = await fillForm();
  await user.click(screen.getByRole('button', { name: 'Đăng kí lớp học' }));
  await waitFor(() => expect(screen.getByRole('status')).toHaveTextContent('Đã nhận đăng kí'));
  expect(screen.queryByText('Trang in sách')).not.toBeInTheDocument();
});

test('only active classes from the API are offered', async () => {
  render(<MemoryRouter initialEntries={['/dang-ki-lop-hoc/it-passport']}>
    <Routes><Route path="/dang-ki-lop-hoc/:course" element={<ClassRegistrationFormPage />} /></Routes>
  </MemoryRouter>);
  await screen.findByRole('option', { name: /Lớp tháng 11 — Thứ 7/ });
  expect(get).toHaveBeenCalledWith('/classes/sessions?course=it-passport');
  // A class the admin deactivated is absent from the API response entirely.
  expect(screen.queryByRole('option', { name: /tháng 12/ })).not.toBeInTheDocument();
});

test('a full class cannot be selected', async () => {
  render(<MemoryRouter initialEntries={['/dang-ki-lop-hoc/it-passport']}>
    <Routes><Route path="/dang-ki-lop-hoc/:course" element={<ClassRegistrationFormPage />} /></Routes>
  </MemoryRouter>);
  const fullOption = await screen.findByRole('option', { name: /Chủ nhật và thứ 5 \(đã đầy\)/ });
  expect(fullOption).toBeDisabled();
});

test('shows a notice when no class is open', async () => {
  vi.mocked(get).mockResolvedValue({ sessions: [] });
  render(<MemoryRouter initialEntries={['/dang-ki-lop-hoc/it-passport']}>
    <Routes><Route path="/dang-ki-lop-hoc/:course" element={<ClassRegistrationFormPage />} /></Routes>
  </MemoryRouter>);
  expect(await screen.findByRole('option', { name: /chưa có lớp nào mở đăng kí/ })).toBeInTheDocument();
  expect(screen.getByLabelText('Chọn lớp')).toBeDisabled();
});
