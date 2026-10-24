import { describe, it, expect, beforeEach, vi, afterEach } from 'vitest';

/**
 * These tests cover the centralised 401/403 handling in the API client:
 * an expired session must clear credentials and redirect to /login, while a
 * failed login attempt must NOT redirect (otherwise a user who mistypes their
 * password gets bounced away from the form).
 */

const originalLocation = window.location;

function stubLocation(pathname: string) {
  const assigned: { href: string } = { href: '' };
  Object.defineProperty(window, 'location', {
    configurable: true,
    value: {
      ...originalLocation,
      pathname,
      get href() {
        return assigned.href;
      },
      set href(v: string) {
        assigned.href = v;
      },
    },
  });
  return assigned;
}

function mockResponse(status: number, body: unknown) {
  return {
    ok: status >= 200 && status < 300,
    status,
    json: async () => body,
  } as Response;
}

describe('API client auth handling', () => {
  beforeEach(() => {
    vi.resetModules();
    localStorage.clear();
    sessionStorage.clear();
  });

  afterEach(() => {
    Object.defineProperty(window, 'location', {
      configurable: true,
      value: originalLocation,
    });
    vi.unstubAllGlobals();
  });

  it('redirects to /login and clears the session on 401', async () => {
    const loc = stubLocation('/admin');
    localStorage.setItem('token', 'expired-token');
    localStorage.setItem('user', '{"email":"a@b.c"}');

    vi.stubGlobal('fetch', vi.fn(async () => mockResponse(401, { detail: 'Invalid or expired token' })));

    const { get, ApiError } = await import('./client');

    await expect(get('/admin/users')).rejects.toBeInstanceOf(ApiError);

    expect(localStorage.getItem('token')).toBeNull();
    expect(localStorage.getItem('user')).toBeNull();
    expect(sessionStorage.getItem('sessionExpired')).toBe('1');
    expect(loc.href).toBe('/login');
  });

  it('redirects on 403 as well (non-admin or revoked access)', async () => {
    const loc = stubLocation('/admin');
    localStorage.setItem('token', 'some-token');

    vi.stubGlobal('fetch', vi.fn(async () => mockResponse(403, { detail: 'Admin access required' })));

    const { get } = await import('./client');
    await expect(get('/admin/users')).rejects.toThrow();

    expect(loc.href).toBe('/login');
  });

  it('does NOT redirect when login itself returns 401 (wrong password)', async () => {
    const loc = stubLocation('/login');

    vi.stubGlobal('fetch', vi.fn(async () => mockResponse(401, { detail: 'Invalid credentials' })));

    const { post, ApiError } = await import('./client');

    await expect(
      post('/auth/login', { email: 'a@b.c', password: 'wrong', captchaToken: 't' })
    ).rejects.toBeInstanceOf(ApiError);

    expect(loc.href).toBe('');
    expect(sessionStorage.getItem('sessionExpired')).toBeNull();
  });

  it('does NOT redirect when change-password returns 401 (wrong current password)', async () => {
    const loc = stubLocation('/reset-password');
    localStorage.setItem('token', 'valid-token');

    vi.stubGlobal('fetch', vi.fn(async () => mockResponse(401, { detail: 'Current password is incorrect' })));

    const { post } = await import('./client');
    await expect(post('/auth/change-password', {})).rejects.toThrow();

    expect(loc.href).toBe('');
    // The session must survive a wrong-password attempt.
    expect(localStorage.getItem('token')).toBe('valid-token');
  });

  it('redirects only once when several requests fail at the same time', async () => {
    const loc = stubLocation('/admin');
    localStorage.setItem('token', 'expired');

    vi.stubGlobal('fetch', vi.fn(async () => mockResponse(401, { detail: 'expired' })));

    const { get } = await import('./client');

    await Promise.allSettled([
      get('/admin/users'),
      get('/admin/questions'),
      get('/classes/registrations'),
    ]);

    expect(loc.href).toBe('/login');
  });

  it('leaves non-auth errors alone', async () => {
    const loc = stubLocation('/admin');
    localStorage.setItem('token', 'valid-token');

    vi.stubGlobal('fetch', vi.fn(async () => mockResponse(500, { detail: 'Internal server error' })));

    const { get } = await import('./client');
    await expect(get('/admin/users')).rejects.toThrow();

    expect(loc.href).toBe('');
    expect(localStorage.getItem('token')).toBe('valid-token');
  });
});

it('rejects oversized cover images before sending a request', async () => {
  const fetchMock = vi.fn();
  vi.stubGlobal('fetch', fetchMock);
  const { uploadBookImage } = await import('./client');
  const file = new File([new Uint8Array(5 * 1024 * 1024 + 1)], 'cover.png', { type: 'image/png' });
  await expect(uploadBookImage(file)).rejects.toThrow('tối đa 5 MB');
  expect(fetchMock).not.toHaveBeenCalled();
});

it('explains proxy upload limits even when the response is HTML', async () => {
  vi.stubGlobal('fetch', vi.fn(async () => ({ ok: false, status: 413, json: async () => { throw new Error('HTML response'); } })));
  const { uploadBookImage } = await import('./client');
  await expect(uploadBookImage(new File(['image'], 'cover.png'))).rejects.toThrow('tối đa 5 MB');
});
