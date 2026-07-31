const BASE_URL = import.meta.env.VITE_API_URL || '/api';

function getToken(): string | null {
  return localStorage.getItem('token');
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
    throw new ApiError(response.status, error.error || 'Request failed');
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
