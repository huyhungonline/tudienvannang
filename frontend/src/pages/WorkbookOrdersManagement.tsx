import { useEffect, useState } from 'react';
import { get, put, del } from '../api/client';
import { Spinner } from '../components/Spinner';

interface WorkbookOrder {
  id: string;
  full_name: string;
  email: string;
  book_address: string;
  created_at: string;
  paid_at: string | null;
  shipped_at: string | null;
}

const PAGE_SIZE = 50;

export function WorkbookOrdersManagement() {
  const [orders, setOrders] = useState<WorkbookOrder[]>([]);
  const [total, setTotal] = useState(0);
  const [page, setPage] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [reload, setReload] = useState(0);
  const [savingId, setSavingId] = useState<string | null>(null);
  const [paymentError, setPaymentError] = useState('');
  const [deletingId, setDeletingId] = useState<string | null>(null);
  const [deleteError, setDeleteError] = useState('');
  const [shippingError, setShippingError] = useState('');

  async function toggleShipping(order: WorkbookOrder) {
    if (savingId || deletingId) return;
    setSavingId(order.id);
    setShippingError('');
    try {
      const updated = await put<{ id: string; shipped_at: string | null }>(
        `/classes/workbook-orders/${order.id}/shipping`, { shipped: !order.shipped_at },
      );
      setOrders(current => current.map(item => item.id === updated.id ? { ...item, shipped_at: updated.shipped_at } : item));
    } catch {
      setShippingError('Không thể cập nhật trạng thái gửi sách. Vui lòng thử lại.');
    } finally {
      setSavingId(null);
    }
  }

  async function deleteOrder(order: WorkbookOrder) {
    if (savingId || deletingId) return;
    if (!window.confirm(`Xóa đăng kí mua sách của ${order.full_name} (${order.email})? Thao tác này không thể hoàn tác.`)) return;
    setDeletingId(order.id);
    setDeleteError('');
    try {
      await del(`/classes/workbook-orders/${order.id}`);
      if (orders.length === 1 && page > 0) setPage(value => value - 1);
      else setReload(value => value + 1);
    } catch {
      setDeleteError('Không thể xóa đăng kí mua sách. Vui lòng thử lại.');
    } finally {
      setDeletingId(null);
    }
  }

  async function togglePayment(order: WorkbookOrder) {
    if (savingId || deletingId) return;
    setSavingId(order.id);
    setPaymentError('');
    try {
      const updated = await put<{ id: string; paid_at: string | null }>(
        `/classes/workbook-orders/${order.id}/payment`, { paid: !order.paid_at },
      );
      setOrders(current => current.map(item => item.id === updated.id ? { ...item, paid_at: updated.paid_at } : item));
    } catch {
      setPaymentError('Không thể cập nhật trạng thái thanh toán. Vui lòng thử lại.');
    } finally {
      setSavingId(null);
    }
  }

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
    {paymentError && <p className="form-error" role="alert">{paymentError}</p>}
    {deleteError && <p className="form-error" role="alert">{deleteError}</p>}
    {shippingError && <p className="form-error" role="alert">{shippingError}</p>}
    {loading ? <p role="status"><Spinner /> Đang tải...</p> : error ? <div role="alert">
      <p className="form-error">{error}</p>
      <button type="button" onClick={() => setReload(value => value + 1)}>Thử lại</button>
    </div> : <>
      {orders.length === 0 ? <p>Chưa có đăng kí mua sách nào.</p> :
        <div style={{ overflowX: 'auto' }}><table className="admin-table">
          <thead><tr><th>Họ tên</th><th>Email</th><th>Địa chỉ nhận sách ở Nhật</th><th>Ngày đăng kí</th><th>Thanh toán</th><th>Gửi sách</th><th>Thao tác</th></tr></thead>
          <tbody>{orders.map(order => <tr key={order.id}>
            <td>{order.full_name}</td>
            <td>{order.email}</td>
            <td style={{ whiteSpace: 'pre-wrap', overflowWrap: 'anywhere' }}>{order.book_address}</td>
            <td>{new Date(order.created_at).toLocaleString('vi-VN', { timeZone: 'Asia/Tokyo' })}</td>
            <td>
              <div style={{ color: order.paid_at ? '#15803d' : undefined }}>
                {order.paid_at ? 'Đã thanh toán' : 'Chưa thanh toán'}
              </div>
              {order.paid_at && <small>{new Date(order.paid_at).toLocaleString('vi-VN', { timeZone: 'Asia/Tokyo' })}</small>}
              <div><button type="button" disabled={savingId !== null || deletingId !== null} onClick={() => togglePayment(order)}>
                {savingId === order.id ? 'Đang lưu...' : order.paid_at ? 'Bỏ đánh dấu' : 'Đánh dấu đã thanh toán'}
              </button></div>
            </td>
            <td>
              <div style={{ color: order.shipped_at ? '#15803d' : undefined }}>
                {order.shipped_at ? 'Đã gửi sách' : 'Chưa gửi sách'}
              </div>
              {order.shipped_at && <small>{new Date(order.shipped_at).toLocaleString('vi-VN', { timeZone: 'Asia/Tokyo' })}</small>}
              <div><button type="button" disabled={savingId !== null || deletingId !== null} onClick={() => toggleShipping(order)}>
                {savingId === order.id ? 'Đang lưu...' : order.shipped_at ? 'Bỏ đánh dấu đã gửi sách' : 'Đã gửi'}
              </button></div>
            </td>
            <td><button type="button" disabled={savingId !== null || deletingId !== null} onClick={() => deleteOrder(order)}>
              {deletingId === order.id ? 'Đang xóa...' : 'Xóa'}
            </button></td>
          </tr>)}</tbody>
        </table></div>}
      {total > PAGE_SIZE && <div className="pagination">
        <button type="button" disabled={page === 0 || savingId !== null || deletingId !== null} onClick={() => setPage(value => value - 1)}>← Trước</button>
        <span>{page + 1} / {Math.ceil(total / PAGE_SIZE)}</span>
        <button type="button" disabled={(page + 1) * PAGE_SIZE >= total || savingId !== null || deletingId !== null} onClick={() => setPage(value => value + 1)}>Sau →</button>
      </div>}
    </>}
  </section>;
}
