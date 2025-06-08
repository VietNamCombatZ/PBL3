<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Đăng nhập - Modern</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern-style.css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <style>
    .login-container {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      background: var(--gradient-accent);
      padding: 2rem;
    }

    .login-card {
      background: white;
      padding: 3rem;
      border-radius: var(--border-radius);
      box-shadow: var(--shadow-lg);
      width: 100%;
      max-width: 450px;
      animation: slideUp 0.6s ease-out;
    }

    .login-header {
      text-align: center;
      margin-bottom: 2rem;
    }

    .login-title {
      font-size: 2rem;
      font-weight: 700;
      color: var(--primary-blue);
      margin-bottom: 0.5rem;
    }

    .login-subtitle {
      color: #64748b;
      font-size: 0.9rem;
    }

    .form-group {
      margin-bottom: 1.5rem;
    }

    .form-input {
      width: 100%;
      padding: 1rem 1rem 1rem 3rem;
      border: 2px solid #e2e8f0;
      border-radius: var(--border-radius);
      font-size: 1rem;
      transition: var(--transition);
      background: #f8fafc;
      position: relative;
    }

    .input-group {
      position: relative;
    }

    .input-icon {
      position: absolute;
      left: 1rem;
      top: 50%;
      transform: translateY(-50%);
      color: #94a3b8;
      z-index: 1;
    }

    .form-input:focus {
      outline: none;
      border-color: var(--primary-blue);
      background: white;
      box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
    }

    .form-input:focus + .input-icon {
      color: var(--primary-blue);
    }

    .login-btn {
      width: 100%;
      padding: 1rem;
      background: var(--gradient-primary);
      color: white;
      border: none;
      border-radius: var(--border-radius);
      font-size: 1rem;
      font-weight: 600;
      cursor: pointer;
      transition: var(--transition);
      margin-bottom: 1.5rem;
    }

    .login-btn:hover {
      transform: translateY(-2px);
      box-shadow: var(--shadow-md);
    }

    .forgot-password {
      text-align: center;
      margin-bottom: 2rem;
    }

    .forgot-password a {
      color: var(--primary-blue);
      text-decoration: none;
      font-weight: 500;
      transition: var(--transition);
    }

    .forgot-password a:hover {
      color: var(--secondary-blue);
    }

    .social-login {
      border-top: 1px solid #e2e8f0;
      padding-top: 1.5rem;
    }

    .social-title {
      text-align: center;
      color: #64748b;
      margin-bottom: 1rem;
      font-size: 0.9rem;
    }

    .social-buttons {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 1rem;
    }

    .social-btn {
      padding: 0.75rem;
      border: 2px solid #e2e8f0;
      border-radius: var(--border-radius);
      background: white;
      color: #475569;
      font-weight: 500;
      cursor: pointer;
      transition: var(--transition);
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 0.5rem;
    }

    .social-btn.facebook {
      border-color: #1877f2;
      color: #1877f2;
    }

    .social-btn.facebook:hover {
      background: #1877f2;
      color: white;
    }

    .social-btn.google {
      border-color: #ea4335;
      color: #ea4335;
    }

    .social-btn.google:hover {
      background: #ea4335;
      color: white;
    }

    .error-message {
      background: #fef2f2;
      color: #dc2626;
      padding: 1rem;
      border-radius: var(--border-radius);
      border-left: 4px solid #ef4444;
      margin-bottom: 1.5rem;
      font-weight: 500;
    }
  </style>
</head>
<body>
<div class="login-container">
  <div class="login-card">
    <div class="login-header">
      <h2 class="login-title">Đăng nhập</h2>
      <p class="login-subtitle">Chào mừng bạn trở lại! Vui lòng đăng nhập vào tài khoản của bạn.</p>
    </div>

    <%-- Hiển thị thông báo lỗi nếu có --%>
    <% String thongBao = (String) request.getAttribute("thongBao");
      if(thongBao == null){
        thongBao = (String) session.getAttribute("thongBao");
      }%>
    <% if (thongBao != null) { %>
    <div class="error-message">
      <i class="fas fa-exclamation-triangle"></i> <%= thongBao %>
    </div>
    <% } %>

    <form action="dangNhap" method="post">
      <div class="form-group">
        <div class="input-group">
          <input type="email" name="email" class="form-input" placeholder="Email" required>
          <i class="fas fa-envelope input-icon"></i>
        </div>
      </div>

      <div class="form-group">
        <div class="input-group">
          <input type="password" name="matKhau" class="form-input" placeholder="Mật khẩu" required>
          <i class="fas fa-lock input-icon"></i>
        </div>
      </div>

      <button type="submit" class="login-btn">
        <i class="fas fa-sign-in-alt"></i> Đăng nhập
      </button>
    </form>

    <div class="forgot-password">
      <a href="#">
        <i class="fas fa-key"></i> Quên mật khẩu?
      </a>
    </div>

    <div class="social-login">
      <p class="social-title">Hoặc đăng nhập bằng</p>
      <div class="social-buttons">
        <button class="social-btn facebook">
          <i class="fab fa-facebook-f"></i> Facebook
        </button>
        <button class="social-btn google">
          <i class="fab fa-google"></i> Google
        </button>
      </div>
    </div>
  </div>
</div>

<script>
  // Add form validation and animations
  document.addEventListener('DOMContentLoaded', function() {
    const inputs = document.querySelectorAll('.form-input');

    inputs.forEach(input => {
      input.addEventListener('focus', function() {
        this.parentElement.classList.add('focused');
      });

      input.addEventListener('blur', function() {
        if (!this.value) {
          this.parentElement.classList.remove('focused');
        }
      });
    });

    // Add loading state to login button
    const loginForm = document.querySelector('form');
    const loginBtn = document.querySelector('.login-btn');

    loginForm.addEventListener('submit', function() {
      loginBtn.innerHTML = '<div class="loading"></div> Đang đăng nhập...';
      loginBtn.disabled = true;
    });
  });
</script>
</body>
</html>
