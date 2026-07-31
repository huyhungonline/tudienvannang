import Avatar from './Avatar';
import type { SeatData } from '../../types/classroom';

interface SeatCellProps {
  seat: SeatData | null;
  row: number;
  seatNumber: number;
  isCurrentUser: boolean;
  onClick: () => void;
}

export default function SeatCell({ seat, isCurrentUser, onClick }: SeatCellProps) {
  const isOccupied = seat !== null;

  return (
    <div
      onClick={!isOccupied ? onClick : undefined}
      style={{
        width: 48,
        height: 56,
        border: isCurrentUser
          ? '2px solid #3498db'
          : isOccupied
          ? '1px solid #bbb'
          : '1px dashed #ccc',
        borderRadius: 4,
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent: 'center',
        cursor: isOccupied ? 'default' : 'pointer',
        backgroundColor: isCurrentUser
          ? '#ebf5fb'
          : isOccupied
          ? '#f9f9f9'
          : '#fff',
        transition: 'all 0.15s',
        gap: 2,
      }}
      title={isOccupied ? seat.email : 'Ghế trống - Click để ngồi'}
    >
      {isOccupied ? (
        <>
          <Avatar
            email={seat.email}
            userId={seat.user_id}
            searchCount={seat.search_count}
            size={28}
          />
          <span style={{ fontSize: 8, color: '#666', maxWidth: 44, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap', textAlign: 'center' }}>
            {seat.email.split('@')[0]}
          </span>
        </>
      ) : (
        <span style={{ fontSize: 18, color: '#ddd' }}>○</span>
      )}
    </div>
  );
}
