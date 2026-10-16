import { useEffect, useState } from 'react';
import { get } from '../api/client';
import { Spinner } from '../components/Spinner';

interface WorkbookOrder {
  id: string;
  full_name: string;
  email: string;
  book_address: string;
  created_at: string;
}

const PAGE_SIZE = 50;

export function WorkbookOrdersManagement() {
  const [orders, setOrders] = useState<WorkbookOrder[]>([]);
  const [total, setTotal] = useState(0);
  const [page, setPage] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [reload, setReload] = useState(0);

  useEffect(() => {
    let disposed = false;
    setLoading(true);
    setError('');
    get<{ orders: WorkbookOrder[]; total: number }>(`/classes/workbook-orders?limit=${PAGE_SIZE}&offset=${page * PAGE_SIZE}`)
      .then(data => { if (!disposed) { setOrders(data.orders); setTotal(data.total); } })
      .catch(() => { if (!disposed) setError('Không thể tải danh sách đăng kí mua sách.'); })
      .finally(() => { if (!disposed) setLoading(false); });
    return () => { disposed = true; };
  }, [page, reload]);

  return <section>
    <h2>Danh sách đăng kí mua sách{!loading && !error ? ` (${total})` : ''}</h2>
    {loading ? <p role="status"><Spinner /> Đang tải...</p> : error ? <div role="alert">
      <p className="form-error">{error}</p>
      <button type="button" onClick={() => setReload(value => value + 1)}>Thử lại</button>
    </div> : <>
      {orders.length === 0 ? <p>Chưa có đăng kí mua sách nào.</p> :
        <div style={{ overflowX: 'auto' }}><table className="admin-table">
          <thead><tr><th>Họ tên</th><th>Email</th><th>Địa chỉ nhận sách ở Nhật</th><th>Ngày đăng kí</th></tr></thead>
          <tbody>{orders.map(order => <tr key={order.id}>
            <td>{order.full_name}</td>
            <td>{order.email}</td>
            <td style={{ whiteSpace: 'pre-wrap', overflowWrap: 'anywhere' }}>{order.book_address}</td>
            <td>{new Date(order.created_at).toLocaleString('vi-VN', { timeZone: 'Asia/Tokyo' })}</td>
          </tr>)}</tbody>
        </table></div>}
      {total > PAGE_SIZE && <div className="pagination">
        <button type="button" disabled={page === 0} onClick={() => setPage(value => value - 1)}>← Trước</button>
        <span>{page + 1} / {Math.ceil(total / PAGE_SIZE)}</span>
        <button type="button" disabled={(page + 1) * PAGE_SIZE >= total} onClick={() => setPage(value => value + 1)}>Sau →</button>
      </div>}
    </>}
  </section>;
}
