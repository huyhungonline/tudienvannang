import { useState, useEffect, type FormEvent } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { get, post, put, del } from '../api/client';

interface AdminUser {
  id: string;
  email: string;
  isAdmin: boolean;
  createdAt: string;
}

export function AdminPage() {
  const { isAuthenticated } = useAuth();
  const navigate = useNavigate();
  const [users, setUsers] = useState<AdminUser[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  // Create form
  const [showCreate, setShowCreate] = useState(false);
  const [newEmail, setNewEmail] = useState('');
  const [newPassword, setNewPassword] = useState('');
  const [newIsAdmin, setNewIsAdmin] = useState(false);

  // Edit form
  const [editingId, setEditingId] = useState<string | null>(null);
  const [editEmail, setEditEmail] = useState('');
  const [editPassword, setEditPassword] = useState('');
  const [editIsAdmin, setEditIsAdmin] = useState(false);

  useEffect(() => {
    if (!isAuthenticated) {
      navigate('/login');
      return;
    }
    fetchUsers();
  }, [isAuthenticated]);

  const fetchUsers = async () => {
    setLoading(true);
    setError(null);
    try {
      const data = await get<AdminUser[]>('/admin/users');
      setUsers(data);
    } catch (err: any) {
      if (err?.status === 403) {
        setError('Admin access required.');
      } else {
        setError('Failed to load users.');
      }
    } finally {
      setLoading(false);
    }
  };

  const handleCreate = async (e: FormEvent) => {
    e.preventDefault();
    setError(null);
    try {
      await post('/admin/users', { email: newEmail, password: newPassword, isAdmin: newIsAdmin });
      setNewEmail('');
      setNewPassword('');
      setNewIsAdmin(false);
      setShowCreate(false);
      fetchUsers();
    } catch (err: any) {
      setError(err?.message || 'Failed to create user.');
    }
  };

  const handleUpdate = async (e: FormEvent) => {
    e.preventDefault();
    if (!editingId) return;
    setError(null);
    const body: any = {};
    if (editEmail) body.email = editEmail;
    if (editPassword) body.password = editPassword;
    body.isAdmin = editIsAdmin;
    try {
      await put(`/admin/users/${editingId}`, body);
      setEditingId(null);
      fetchUsers();
    } catch (err: any) {
      setError(err?.message || 'Failed to update user.');
    }
  };

  const handleDelete = async (id: string) => {
    if (!confirm('Delete this user?')) return;
    setError(null);
    try {
      await del(`/admin/users/${id}`);
      fetchUsers();
    } catch (err: any) {
      setError(err?.message || 'Failed to delete user.');
    }
  };

  const startEdit = (u: AdminUser) => {
    setEditingId(u.id);
    setEditEmail(u.email);
    setEditPassword('');
    setEditIsAdmin(u.isAdmin);
  };

  if (loading) return <div className="admin-page"><p className="loading-text">Loading...</p></div>;
  if (error && users.length === 0) return <div className="admin-page"><p className="form-error">{error}</p></div>;

  return (
    <div className="admin-page">
      <div className="admin-header">
        <h2>User Management</h2>
        <button className="btn-submit" onClick={() => setShowCreate(!showCreate)}>
          {showCreate ? 'Cancel' : '+ Add User'}
        </button>
      </div>

      {error && <p className="form-error">{error}</p>}

      {showCreate && (
        <form className="admin-form" onSubmit={handleCreate}>
          <input type="email" placeholder="Email" value={newEmail} onChange={(e) => setNewEmail(e.target.value)} required />
          <input type="password" placeholder="Password" value={newPassword} onChange={(e) => setNewPassword(e.target.value)} required />
          <label className="admin-checkbox"><input type="checkbox" checked={newIsAdmin} onChange={(e) => setNewIsAdmin(e.target.checked)} /> Admin</label>
          <button type="submit" className="btn-submit">Create</button>
        </form>
      )}

      {editingId && (
        <form className="admin-form" onSubmit={handleUpdate}>
          <h3>Edit User</h3>
          <input type="email" placeholder="Email" value={editEmail} onChange={(e) => setEditEmail(e.target.value)} />
          <input type="password" placeholder="New password (leave empty to keep)" value={editPassword} onChange={(e) => setEditPassword(e.target.value)} />
          <label className="admin-checkbox"><input type="checkbox" checked={editIsAdmin} onChange={(e) => setEditIsAdmin(e.target.checked)} /> Admin</label>
          <div className="admin-form-actions">
            <button type="submit" className="btn-submit">Save</button>
            <button type="button" className="btn-back" onClick={() => setEditingId(null)}>Cancel</button>
          </div>
        </form>
      )}

      <table className="admin-table">
        <thead>
          <tr>
            <th>Email</th>
            <th>Admin</th>
            <th>Created</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          {users.map((u) => (
            <tr key={u.id}>
              <td>{u.email}</td>
              <td>{u.isAdmin ? '✅' : '—'}</td>
              <td>{new Date(u.createdAt).toLocaleDateString()}</td>
              <td>
                <button className="btn-edit" onClick={() => startEdit(u)}>Edit</button>
                <button className="btn-delete" onClick={() => handleDelete(u.id)}>Delete</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
