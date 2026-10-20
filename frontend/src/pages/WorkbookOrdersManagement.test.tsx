import { beforeEach, expect, it, vi } from 'vitest';
import { cleanup, render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { get, put, del } from '../api/client';
import { WorkbookOrdersManagement } from './WorkbookOrdersManagement';

vi.mock('../api/client', () => ({ get: vi.fn(), put: vi.fn(), del: vi.fn() }));
const order = { id: 'order-1', full_name: 'Test User', email: 'user@example.com', book_address: 'Tokyo', created_at: '2026-10-17T00:00:00Z', paid_at: null };
beforeEach(() => { cleanup(); vi.restoreAllMocks(); vi.resetAllMocks(); });

it('marks paid and allows correcting the mark', async () => {
  vi.mocked(get).mockResolvedValue({ orders: [order], total: 1 });
  vi.mocked(put).mockResolvedValueOnce({ id: order.id, paid_at: '2026-10-17T01:00:00Z' })
    .mockResolvedValueOnce({ id: order.id, paid_at: null });
  render(<WorkbookOrdersManagement />);
  await userEvent.click(await screen.findByRole('button', { name: 'Đánh dấu đã thanh toán' }));
  await screen.findByText('Đã thanh toán');
  expect(put).toHaveBeenLastCalledWith('/classes/workbook-orders/order-1/payment', { paid: true });
  await userEvent.click(screen.getByRole('button', { name: 'Bỏ đánh dấu' }));
  await screen.findByText('Chưa thanh toán');
  expect(put).toHaveBeenLastCalledWith('/classes/workbook-orders/order-1/payment', { paid: false });
});

it('preserves unpaid status and shows an error if saving fails', async () => {
  vi.mocked(get).mockResolvedValue({ orders: [order], total: 1 });
  vi.mocked(put).mockRejectedValue(new Error('Network unavailable'));
  render(<WorkbookOrdersManagement />);
  await userEvent.click(await screen.findByRole('button', { name: 'Đánh dấu đã thanh toán' }));
  await screen.findByRole('alert');
  expect(screen.getByText('Chưa thanh toán')).toBeInTheDocument();
  expect(screen.getByRole('button', { name: 'Đánh dấu đã thanh toán' })).toBeEnabled();
});

it('cancels deletion when confirmation is declined', async () => {
  vi.mocked(get).mockResolvedValue({ orders: [order], total: 1 });
  const confirm = vi.spyOn(window, 'confirm').mockReturnValue(false);
  render(<WorkbookOrdersManagement />);
  await userEvent.click(await screen.findByRole('button', { name: 'Xóa' }));
  expect(confirm).toHaveBeenCalledWith(expect.stringContaining('Test User (user@example.com)'));
  expect(del).not.toHaveBeenCalled();
  expect(screen.getByText('Test User')).toBeInTheDocument();
});

it('deletes only after confirmation and refreshes the list', async () => {
  vi.mocked(get).mockResolvedValueOnce({ orders: [order], total: 1 }).mockResolvedValue({ orders: [], total: 0 });
  vi.mocked(del).mockResolvedValue({ message: 'Workbook order deleted' });
  vi.spyOn(window, 'confirm').mockReturnValue(true);
  render(<WorkbookOrdersManagement />);
  await userEvent.click(await screen.findByRole('button', { name: 'Xóa' }));
  await screen.findByText('Chưa có đăng kí mua sách nào.');
  expect(del).toHaveBeenCalledTimes(1);
  expect(del).toHaveBeenCalledWith('/classes/workbook-orders/order-1');
});

it('keeps the order when deletion fails', async () => {
  vi.mocked(get).mockResolvedValue({ orders: [order], total: 1 });
  vi.mocked(del).mockRejectedValue(new Error('Network unavailable'));
  vi.spyOn(window, 'confirm').mockReturnValue(true);
  render(<WorkbookOrdersManagement />);
  await userEvent.click(await screen.findByRole('button', { name: 'Xóa' }));
  await screen.findByText('Không thể xóa đăng kí mua sách. Vui lòng thử lại.');
  expect(screen.getByText('Test User')).toBeInTheDocument();
  expect(screen.getByRole('button', { name: 'Xóa' })).toBeEnabled();
});

it('returns to the preceding page after deleting its last order', async () => {
  vi.mocked(get).mockResolvedValueOnce({ orders: [order], total: 51 })
    .mockResolvedValueOnce({ orders: [{ ...order, id: 'last-order' }], total: 51 })
    .mockResolvedValue({ orders: [order], total: 50 });
  vi.mocked(del).mockResolvedValue({ message: 'Workbook order deleted' });
  vi.spyOn(window, 'confirm').mockReturnValue(true);
  render(<WorkbookOrdersManagement />);
  await userEvent.click(await screen.findByRole('button', { name: 'Sau →' }));
  await screen.findByText('2 / 2');
  await userEvent.click(screen.getByRole('button', { name: 'Xóa' }));
  await screen.findByText('Danh sách đăng kí mua sách (50)');
  expect(get).toHaveBeenLastCalledWith('/classes/workbook-orders?limit=50&offset=0');
});
