import { beforeEach, expect, it, vi } from 'vitest';
import { cleanup, render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { get, del } from '../api/client';
import { ClassRegistrationsManagement } from './AdminPage';

vi.mock('../api/client', () => ({ get: vi.fn(), del: vi.fn(), post: vi.fn(), put: vi.fn(), uploadBookImage: vi.fn() }));
vi.mock('./ClassRegistrationPage', () => ({ CLASS_SCHEDULES: { 'sat-tue-20-22': 'Thứ 7 và thứ 3' } }));
const item = { id: 'class-1', course: 'it-passport', schedule: 'sat-tue-20-22', full_name: 'Test Student', email: 'student@example.com', phone: '09012345678', book_address: '', created_at: '2026-10-19T00:00:00Z' };
const data = { registrations: [item], total: 1, counts: [{ course: 'it-passport', schedule: item.schedule, count: 1 }] };
beforeEach(() => { cleanup(); vi.restoreAllMocks(); vi.resetAllMocks(); });

it('does not delete when the admin declines confirmation', async () => {
  vi.mocked(get).mockResolvedValue(data);
  const confirm = vi.spyOn(window, 'confirm').mockReturnValue(false);
  render(<ClassRegistrationsManagement />);
  await userEvent.click(await screen.findByRole('button', { name: 'Xóa' }));
  expect(confirm).toHaveBeenCalledWith(expect.stringContaining('Test Student (student@example.com)'));
  expect(del).not.toHaveBeenCalled();
  expect(screen.getByText('Test Student')).toBeInTheDocument();
});

it('deletes after confirmation and refreshes both list and counts', async () => {
  vi.mocked(get).mockResolvedValueOnce(data).mockResolvedValue({ registrations: [], total: 0, counts: [] });
  vi.mocked(del).mockResolvedValue({ message: 'Class registration deleted' });
  vi.spyOn(window, 'confirm').mockReturnValue(true);
  render(<ClassRegistrationsManagement />);
  await userEvent.click(await screen.findByRole('button', { name: 'Xóa' }));
  await screen.findByText('Chưa có đăng kí nào.');
  expect(del).toHaveBeenCalledWith('/classes/registrations/class-1');
  expect(screen.getByText('IT Passport: 0 người')).toBeInTheDocument();
});

it('preserves the registration if deletion fails', async () => {
  vi.mocked(get).mockResolvedValue(data);
  vi.mocked(del).mockRejectedValue(new Error('Network unavailable'));
  vi.spyOn(window, 'confirm').mockReturnValue(true);
  render(<ClassRegistrationsManagement />);
  await userEvent.click(await screen.findByRole('button', { name: 'Xóa' }));
  await screen.findByRole('alert');
  expect(screen.getByText('Test Student')).toBeInTheDocument();
  expect(screen.getByRole('button', { name: 'Xóa' })).toBeEnabled();
});

it('returns to the previous page when the last row is deleted', async () => {
  vi.mocked(get).mockResolvedValueOnce({ ...data, total: 51 })
    .mockResolvedValueOnce({ ...data, total: 51 })
    .mockResolvedValue({ ...data, total: 50 });
  vi.mocked(del).mockResolvedValue({ message: 'Class registration deleted' });
  vi.spyOn(window, 'confirm').mockReturnValue(true);
  render(<ClassRegistrationsManagement />);
  await userEvent.click(await screen.findByRole('button', { name: 'Sau →' }));
  await screen.findByText('2 / 2');
  await userEvent.click(screen.getByRole('button', { name: 'Xóa' }));
  await screen.findByText('Đăng kí lớp học (50)');
  expect(get).toHaveBeenLastCalledWith('/classes/registrations?limit=50&offset=0');
});
