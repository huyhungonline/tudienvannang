import { Routes, Route } from 'react-router-dom';
import { AuthProvider } from './context/AuthContext';
import { Header } from './components/Header';
import { HomePage } from './pages/HomePage';
import { LoginPage } from './pages/LoginPage';
import { RegisterPage } from './pages/RegisterPage';
import { HistoryPage } from './pages/HistoryPage';
import { MacroNewsPage } from './pages/MacroNewsPage';
import { ReadingPostsPage } from './pages/ReadingPostsPage';

function App() {
  return (
    <AuthProvider>
      <div className="app">
        <Header />
        <main className="main-content">
          <Routes>
            <Route path="/" element={<HomePage />} />
            <Route path="/login" element={<LoginPage />} />
            <Route path="/register" element={<RegisterPage />} />
            <Route path="/history" element={<HistoryPage />} />
            <Route path="/my-page" element={<HistoryPage />} />
            <Route path="/macro-news" element={<MacroNewsPage />} />
            <Route path="/reading-posts" element={<ReadingPostsPage />} />
          </Routes>
        </main>
      </div>
    </AuthProvider>
  );
}

export default App;
