<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Truy cập bị từ chối - Modern</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern-style.css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <style>
    .access-denied-container {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      background: var(--gradient-accent);
      padding: 2rem;
    }

    .access-denied-card {
      background: white;
      border-radius: var(--border-radius);
      box-shadow: var(--shadow-lg);
      padding: 3rem;
      text-align: center;
      max-width: 500px;
      width: 100%;
      animation: slideUp 0.6s ease-out;
    }

    .access-denied-icon {
      width: 100px;
      height: 100px;
      border-radius: 50%;
      background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 2rem;
      color: white;
      font-size: 3rem;
      box-shadow: var(--shadow-md);
    }

    .access-denied-title {
      font-size: 2rem;
      font-weight: 700;
      color: var(--primary-blue);
      margin-bottom: 1rem;
    }

    .access-denied-message {
      color: #64748b;
      font-size: 1.1rem;
      line-height: 1.6;
      margin-bottom: 2rem;
    }

    .access-denied-details {
      background: #fef2f2;
      border: 2px solid #fecaca;
      border-radius: var(--border-radius);
      padding: 1rem;
      margin-bottom: 2rem;
      color: #dc2626;
      font-weight: 500;
    }

    .home-btn {
      background: var(--gradient-primary);
      color: white;
      padding: 1rem 2rem;
      border: none;
      border-radius: var(--border-radius);
      font-weight: 600;
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
      transition: var(--transition);
      box-shadow: var(--shadow-sm);
    }

    .home-btn:hover {
      transform: translateY(-2px);
      box-shadow: var(--shadow-md);
    }

    .support-link {
      display: block;
      margin-top: 1.5rem;
      color: var(--primary-blue);
      text-decoration: none;
      font-weight: 500;
      transition: var(--transition);
    }

    .support-link:hover {
      color: var(--secondary-blue);
    }

    @media (max-width: 768px) {
      .access-denied-container {
        padding: 1rem;
      }

      .access-denied-card {
        padding: 2rem;
      }

      .access-denied-title {
        font-size: 1.5rem;
      }

      .access-denied-icon {
        width: 80px;
        height: 80px;
        font-size: 2.5rem;
      }
    }
  </style>
</head>
<body>
<div class="access-denied-container">
  <div class="access-denied-card">
    <div class="access-denied-icon">
      <i class="fas fa-shield-alt"></i>
    </div>

    <h1 class="access-denied-title">Truy cập bị từ chối</h1>

    <p class="access-denied-message">
      Xin lỗi, bạn không có quyền truy cập vào trang này.

    </p>

    <div class="access-denied-details">
      <i class="fas fa-exclamation-triangle"></i>

    </div>

    <a href="<%=request.getContextPath()%>/trangChu" class="home-btn">
      <i class="fas fa-home"></i>
      Quay về trang chủ
    </a>

    <a href="<%=request.getContextPath()%>/trangChu" class="support-link">
      <i class="fas fa-envelope"></i>
      Liên hệ hỗ trợ nếu bạn cho rằng đây là lỗi
    </a>
  </div>
</div>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    // Add pulse animation to icon
    const icon = document.querySelector('.access-denied-icon');
    setInterval(() => {
      icon.style.transform = 'scale(1.05)';
      setTimeout(() => {
        icon.style.transform = 'scale(1)';
      }, 200);
    }, 2000);

    // Auto redirect after 10 seconds
    let countdown = 10;
    const homeBtn = document.querySelector('.home-btn');
    const originalText = homeBtn.innerHTML;

    const timer = setInterval(() => {
      countdown--;
      if (countdown > 0) {
        homeBtn.innerHTML = `<i class="fas fa-home"></i> Quay về trang chủ (${countdown}s)`;
      } else {
        homeBtn.innerHTML = originalText;
        window.location.href = '<%=request.getContextPath()%>/trangChu';
        clearInterval(timer);
      }
    }, 1000);

    // Stop countdown if user interacts
    homeBtn.addEventListener('click', () => {
      clearInterval(timer);
    });
  });
</script>
</body>
</html>
