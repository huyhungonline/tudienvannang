import { useState, useRef, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

export function Header() {
  const { user, isAuthenticated, logout } = useAuth();
  const [dropdownOpen, setDropdownOpen] = useState(false);
  const dropdownRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    function handleClickOutside(e: MouseEvent) {
      if (dropdownRef.current && !dropdownRef.current.contains(e.target as Node)) {
        setDropdownOpen(false);
      }
    }
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  return (
    <header className="header">
      <div className="header-left">
        <Link to="/" className="header-title">技術文書検索</Link>
        <nav className="header-nav">
          <Link to="/">Thi chứng chỉ tại Nhật</Link>
          <Link to="/tra-cuu">Tra cứu</Link>
          <Link to="/books">Professional Books</Link>
          <Link to="/visa-points">Visa Points</Link>
          <Link to="/about">About</Link>
        </nav>
      </div>
      <div className="header-right">
        {isAuthenticated ? (
          <div className="avatar-wrapper" ref={dropdownRef}>
            <Link to="/my-page" className="header-mypage-link">My Page</Link>
            <div className="avatar-badge-wrapper">
              <button className="avatar-btn" onClick={() => setDropdownOpen(!dropdownOpen)}>
                {user?.email?.charAt(0).toUpperCase() || 'U'}
              </button>
              {user?.isVip && <span className="vip-badge">Pro</span>}
            </div>
            {dropdownOpen && (
              <div className="avatar-dropdown">
                <span className="dropdown-email">{user?.email}{user?.isVip && <span className="vip-badge-inline">Pro</span>}</span>
                <Link to="/admin" className="dropdown-item" onClick={() => setDropdownOpen(false)}>Admin</Link>
                <Link to="/reset-password" className="dropdown-item" onClick={() => setDropdownOpen(false)}>Reset Password</Link>
                <button className="dropdown-item dropdown-logout" onClick={() => { logout(); setDropdownOpen(false); }}>Logout</button>
              </div>
            )}
          </div>
        ) : (
          <>
            <Link to="/login">Login</Link>
            <Link to="/register">Register</Link>
          </>
        )}
      </div>
    </header>
  );
}
