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
        <Link to="/" className="header-title">English Word Splitter</Link>
        <nav className="header-nav">
          <Link to="/">Home</Link>
          <Link to="/reading-posts">Reading</Link>
          <Link to="/classroom">Lớp Học</Link>
          <Link to="/visa-points">Visa Points</Link>
          <Link to="/news-subscribe">News Subscribe</Link>
          <Link to="/about">About</Link>
        </nav>
      </div>
      <div className="header-right">
        {isAuthenticated ? (
          <div className="avatar-wrapper" ref={dropdownRef}>
            <Link to="/my-page" className="header-mypage-link">My Page</Link>
            <button className="avatar-btn" onClick={() => setDropdownOpen(!dropdownOpen)}>
              {user?.email?.charAt(0).toUpperCase() || 'U'}
            </button>
            {dropdownOpen && (
              <div className="avatar-dropdown">
                <span className="dropdown-email">{user?.email}</span>
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
