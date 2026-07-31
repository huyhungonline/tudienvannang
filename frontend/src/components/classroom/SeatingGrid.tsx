import SeatCell from './SeatCell';
import type { SeatData } from '../../types/classroom';

interface SeatingGridProps {
  seats: SeatData[];
  currentUserId: string | null;
  onSeatClick: (row: number, seat: number) => void;
}

export default function SeatingGrid({ seats, currentUserId, onSeatClick }: SeatingGridProps) {
  const seatMap = new Map<string, SeatData>();
  seats.forEach((s) => seatMap.set(`${s.row_number}-${s.seat_number}`, s));

  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 6, alignItems: 'center' }}>
      {Array.from({ length: 10 }, (_, rowIdx) => {
        const row = rowIdx + 1;
        return (
          <div key={row} style={{ display: 'flex', gap: 4, alignItems: 'center' }}>
            <span style={{ fontSize: 10, color: '#999', width: 20, textAlign: 'right' }}>
              {row}
            </span>
            {Array.from({ length: 10 }, (_, seatIdx) => {
              const seatNum = seatIdx + 1;
              const seatData = seatMap.get(`${row}-${seatNum}`) || null;
              const isCurrentUser = seatData?.user_id === currentUserId;
              return (
                <SeatCell
                  key={`${row}-${seatNum}`}
                  seat={seatData}
                  row={row}
                  seatNumber={seatNum}
                  isCurrentUser={isCurrentUser}
                  onClick={() => onSeatClick(row, seatNum)}
                />
              );
            })}
          </div>
        );
      })}
    </div>
  );
}
