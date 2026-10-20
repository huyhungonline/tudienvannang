import { beforeEach, describe, expect, it, vi } from 'vitest';
import { cleanup, render, screen, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { ApiError, get, post } from '../api/client';
import { EmailContactsManagement } from './EmailContactsManagement';

vi.mock('../api/client', async importOriginal => {
  const original = await importOriginal<typeof import('../api/client')>();
  return { ...original, get: vi.fn(), post: vi.fn() };
});

describe('EmailContactsManagement', () => {
  beforeEach(() => {
    cleanup();
    vi.resetAllMocks();
  });

  it('saves an email and reloads the persisted list below the form', async () => {
    const contact = { id: 1, email: 'user@example.com', created_at: '2026-10-15T00:00:00Z' };
    vi.mocked(get).mockResolvedValueOnce({ contacts: [], total: 0 })
      .mockResolvedValue({ contacts: [contact], total: 1 });
    vi.mocked(post).mockResolvedValue(contact);
    render(<EmailContactsManagement />);
    await screen.findByText('Chưa có email nào.');
    await userEvent.type(screen.getByLabelText('Email'), 'user@example.com');
    await userEvent.click(screen.getByRole('button', { name: 'Lưu email' }));
    await screen.findByRole('listitem');
    expect(post).toHaveBeenCalledWith('/admin/email-contacts', { email: 'user@example.com' });
    expect(screen.getByRole('listitem').textContent).toBe('user@example.com');
    expect((screen.getByLabelText('Email') as HTMLInputElement).value).toBe('');
  });

  it('retains the entered address and explains duplicate emails', async () => {
    vi.mocked(get).mockResolvedValue({ contacts: [], total: 0 });
    vi.mocked(post).mockRejectedValue(new ApiError(409, 'Email already saved'));
    render(<EmailContactsManagement />);
    await userEvent.type(screen.getByLabelText('Email'), 'user@example.com');
    await userEvent.click(screen.getByRole('button', { name: 'Lưu email' }));
    await screen.findByText('Email này đã có trong danh sách.');
    expect((screen.getByLabelText('Email') as HTMLInputElement).value).toBe('user@example.com');
  });

  it('loads subsequent pages from the API', async () => {
    vi.mocked(get).mockResolvedValue({ contacts: [{ id: 1, email: 'user@example.com', created_at: '' }], total: 51 });
    render(<EmailContactsManagement />);
    await screen.findByRole('listitem');
    await userEvent.click(screen.getByRole('button', { name: 'Trang sau' }));
    await waitFor(() => expect(get).toHaveBeenLastCalledWith('/admin/email-contacts?limit=50&offset=50'));
  });
});
