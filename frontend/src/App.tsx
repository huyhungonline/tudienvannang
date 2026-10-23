import { Routes, Route } from 'react-router-dom';
import { AuthProvider } from './context/AuthContext';
import { Header } from './components/Header';
import { HomePage } from './pages/HomePage';
import { BooksPage } from './pages/BooksPage';
import { LoginPage } from './pages/LoginPage';
import { RegisterPage } from './pages/RegisterPage';
import { HistoryPage } from './pages/HistoryPage';
import { ReadingPostsPage } from './pages/ReadingPostsPage';
import { ResetPasswordPage } from './pages/ResetPasswordPage';
import { AboutPage } from './pages/AboutPage';
import { ForgotPasswordPage } from './pages/ForgotPasswordPage';
import { VisaPointsPage } from './pages/VisaPointsPage';
import { AdminPage } from './pages/AdminPage';
import { NewsSubscribePage } from './pages/NewsSubscribePage';
import ClassroomPage from './pages/ClassroomPage';
import { CertificateFieldsMenuPage } from './pages/CertificateFieldsMenuPage';
import { CertificateListPage } from './pages/CertificateListPage';
import { CertificateDetailPage } from './pages/CertificateDetailPage';
import { CertificateVocabularyPage } from './pages/CertificateVocabularyPage';
import { CertificateExamPage } from './pages/CertificateExamPage';
import { CertificateMockExamPage } from './pages/CertificateMockExamPage';
import { RequireVipOrAdmin } from './components/RequireVipOrAdmin';
import { ClassRegistrationPage, ClassRegistrationFormPage } from './pages/ClassRegistrationPage';
import { WorkbookPaymentPage } from './pages/WorkbookPaymentPage';

function App() {
  return (
    <AuthProvider>
      <div className="app">
        <Header />
        <main className="main-content">
          <Routes>
            <Route path="/" element={<BooksPage />} />
            <Route path="/tra-cuu" element={<HomePage />} />
            <Route path="/dang-ki-lop-hoc" element={<ClassRegistrationPage />} />
            <Route path="/dang-ki-in-sach-bai-tap" element={<WorkbookPaymentPage />} />
            <Route path="/dang-ki-lop-hoc/:course" element={<ClassRegistrationFormPage />} />
            <Route path="/books" element={<BooksPage />} />
            <Route path="/login" element={<LoginPage />} />
            <Route path="/register" element={<RegisterPage />} />
            <Route path="/history" element={<HistoryPage />} />
            <Route path="/my-page" element={<HistoryPage />} />
            <Route path="/reading-posts" element={<ReadingPostsPage />} />
            <Route path="/reset-password" element={<ResetPasswordPage />} />
            <Route path="/forgot-password" element={<ForgotPasswordPage />} />
            <Route path="/about" element={<AboutPage />} />
            <Route path="/visa-points" element={<VisaPointsPage />} />
            <Route path="/admin" element={<AdminPage />} />
            <Route path="/news-subscribe" element={<NewsSubscribePage />} />
            <Route path="/classroom" element={<ClassroomPage />} />
            <Route path="/certificates" element={<CertificateFieldsMenuPage />} />
            <Route path="/certificates/:category" element={<CertificateListPage />} />
            <Route path="/certificates/:category/:code" element={<CertificateDetailPage />} />
            <Route path="/certificates/:category/:code/vocabulary" element={<CertificateVocabularyPage />} />
            <Route path="/certificates/:category/:code/exam" element={<RequireVipOrAdmin><CertificateExamPage /></RequireVipOrAdmin>} />
            <Route path="/certificates/:category/:code/mock-exam" element={<RequireVipOrAdmin featureName="thi thử chứng chỉ"><CertificateMockExamPage /></RequireVipOrAdmin>} />
          </Routes>
        </main>
      </div>
    </AuthProvider>
  );
}

export default App;
