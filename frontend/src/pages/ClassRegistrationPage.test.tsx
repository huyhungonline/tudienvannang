import { cleanup, render, screen, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { MemoryRouter, Route, Routes } from 'react-router-dom';
import { afterEach, expect, test, vi } from 'vitest';
import { ClassRegistrationFormPage } from './ClassRegistrationPage';
import { ApiError, post } from '../api/client';

vi.mock('../api/client', async importOriginal => ({
  ...await importOriginal<typeof import('../api/client')>(), post: vi.fn(),
}));

afterEach(() => { cleanup(); vi.resetAllMocks(); });

async function fillForm() {
  const user = userEvent.setup();
  render(<MemoryRouter initialEntries={['/dang-ki-lop-hoc/it-passport']}>
    <Routes>
      <Route path="/dang-ki-lop-hoc/:course" element={<ClassRegistrationFormPage />} />
      <Route path="/dang-ki-in-sach-bai-tap" element={<h1>Trang in sách</h1>} />
    </Routes>
  </MemoryRouter>);
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
