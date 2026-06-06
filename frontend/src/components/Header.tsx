import { Link } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

export function Header() {
  const { user, isAuthenticated, logout } = useAuth();

  return (
    <header className="header">
      <div className="header-left">
        <Link to="/" className="header-title">English Word Splitter</Link>
        <nav className="header-nav">
          <Link to="/">Home</Link>
          <Link to="/macro-news">Macro News</Link>
          {isAuthenticated && <Link to="/history">History</Link>}
        </nav>
      </div>
      <div className="header-right">
        {isAuthenticated ? (
          <>
            <span className="header-email">{user?.email}</span>
            <button className="btn-logout" onClick={logout}>Logout</button>
          </>
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
