export interface ClassroomUser {
  id: string;
  email: string;
  search_count: number;
}

export interface SeatData {
  row_number: number;
  seat_number: number;
  user_id: string;
  email: string;
  search_count: number;
}

export interface ClassroomState {
  id: number;
  name: string;
  teacher: ClassroomUser | null;
  seats: SeatData[];
  total_students: number;
}
