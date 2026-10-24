const BASE_URL = import.meta.env.VITE_API_URL || '/api';

function getToken(): string | null {
  return localStorage.getItem('token');
}

/**
 * Paths where a 401/403 is a normal business answer (wrong password, failed
 * captcha) rather than an expired session. These must not trigger a redirect,
 * otherwise a user mistyping their password would be bounced away.
 */
const AUTH_EXEMPT_PATHS = [
  '/auth/login',
  '/auth/register',
  '/auth/change-password',
  '/auth/forgot-password',
  '/auth/reset-password',
];

function isAuthExempt(path: string): boolean {
  return AUTH_EXEMPT_PATHS.some((p) => path.startsWith(p));
}

/**
 * Clear the stored session and send the user to the login page.
 * Uses a full navigation so any stale in-memory state is discarded, and
 * guards against firing repeatedly when several requests fail at once.
 */
let redirectingToLogin = false;

function handleSessionExpired(): void {
  if (redirectingToLogin) return;
  redirectingToLogin = true;

  localStorage.removeItem('token');
  localStorage.removeItem('user');
  // Let the login page explain why the user ended up there.
  sessionStorage.setItem('sessionExpired', '1');

  if (!window.location.pathname.startsWith('/login')) {
    window.location.href = '/login';
  } else {
    redirectingToLogin = false;
  }
}

async function request<T>(method: string, path: string, body?: unknown): Promise<T> {
  const headers: Record<string, string> = {
    'Content-Type': 'application/json',
  };

  const token = getToken();
  if (token) {
    headers['Authorization'] = `Bearer ${token}`;
  }

  const response = await fetch(`${BASE_URL}${path}`, {
    method,
    headers,
    body: body ? JSON.stringify(body) : undefined,
  });

  if (!response.ok) {
    const error = await response.json().catch(() => ({ error: 'Request failed' }));
    const message = error.error || (typeof error.detail === 'string' ? error.detail : 'Request failed');

    if ((response.status === 401 || response.status === 403) && !isAuthExempt(path)) {
      handleSessionExpired();
    }

    throw new ApiError(response.status, message);
  }

  return response.json();
}

export class ApiError extends Error {
  constructor(public status: number, message: string) {
    super(message);
    this.name = 'ApiError';
  }
}

export function post<T>(path: string, body: unknown): Promise<T> {
  return request<T>('POST', path, body);
}

export function get<T>(path: string): Promise<T> {
  return request<T>('GET', path);
}

export function del<T>(path: string): Promise<T> {
  return request<T>('DELETE', path);
}

export function put<T>(path: string, body: unknown): Promise<T> {
  return request<T>('PUT', path, body);
}

// Classroom API
import type { ClassroomState } from '../types/classroom';

export function getClassroomState(): Promise<{ classroom: ClassroomState }> {
  return get('/classroom');
}

export function joinSeat(row_number: number, seat_number: number): Promise<{ message: string; row_number: number; seat_number: number }> {
  return post('/classroom/join', { row_number, seat_number });
}

export function leaveClassroom(): Promise<{ message: string }> {
  return post('/classroom/leave', {});
}

export function becomeTeacher(): Promise<{ message: string }> {
  return post('/classroom/teacher', {});
}

export function getSearchCount(): Promise<{ search_count: number }> {
  return get('/user/search-count');
}

export function speak(text: string, language: string): Promise<{ audioData: string }> {
  return post('/audio/speak', { text, language });
}

// File upload (multipart) - bypasses the JSON request() helper
export async function uploadBookImage(file: File): Promise<{ image_url: string }> {
  if (file.size > 5 * 1024 * 1024) {
    throw new ApiError(400, 'Ảnh bìa quá lớn. Vui lòng chọn ảnh tối đa 5 MB.');
  }
  const formData = new FormData();
  formData.append('file', file);

  const headers: Record<string, string> = {};
  const token = getToken();
  if (token) {
    headers['Authorization'] = `Bearer ${token}`;
  }

  const response = await fetch(`${BASE_URL}/books/upload-image`, {
    method: 'POST',
    headers,
    body: formData,
  });

  if (!response.ok) {
    const error = await response.json().catch(() => ({ detail: 'Upload failed' }));

    if (response.status === 401 || response.status === 403) {
      handleSessionExpired();
    }

    throw new ApiError(response.status, response.status === 413
      ? 'Ảnh bìa quá lớn. Vui lòng chọn ảnh tối đa 5 MB.'
      : error.detail || 'Upload ảnh thất bại. Vui lòng thử lại.');
  }

  return response.json();
}
