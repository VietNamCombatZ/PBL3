<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Đăng ký - Modern</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern-style.css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <style>
    .register-container {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      background: var(--gradient-accent);
      padding: 2rem;
    }

    .register-card {
      background: white;
      padding: 3rem;
      border-radius: var(--border-radius);
      box-shadow: var(--shadow-lg);
      width: 100%;
      max-width: 500px;
      animation: slideUp 0.6s ease-out;
    }

    .register-header {
      text-align: center;
      margin-bottom: 2rem;
    }

    .register-title {
      font-size: 2rem;
      font-weight: 700;
      color: var(--primary-blue);
      margin-bottom: 0.5rem;
    }

    .register-subtitle {
      color: #64748b;
      font-size: 0.9rem;
    }

    .form-row {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 1rem;
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

    .register-btn {
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
      margin-top: 1rem;
    }

    .register-btn:hover {
      transform: translateY(-2px);
      box-shadow: var(--shadow-md);
    }

    .login-link {
      text-align: center;
      margin-top: 2rem;
      padding-top: 1.5rem;
      border-top: 1px solid #e2e8f0;
    }

    .login-link a {
      color: var(--primary-blue);
      text-decoration: none;
      font-weight: 500;
      transition: var(--transition);
    }

    .login-link a:hover {
      color: var(--secondary-blue);
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

    @media (max-width: 768px) {
      .form-row {
        grid-template-columns: 1fr;
      }

      .register-card {
        padding: 2rem;
        margin: 1rem;
      }
    }
  </style>
</head>
<body>
<div class="register-container">
  <div class="register-card">
    <div class="register-header">
      <h2 class="register-title">Đăng ký</h2>
      <p class="register-subtitle">Tạo tài khoản mới để bắt đầu đặt sân bóng</p>
    </div>

    <% String thongBao = (String) request.getAttribute("thongBao");
      if(thongBao == null){
        thongBao = (String) session.getAttribute("thongBao");
      }%>
    <% if (thongBao != null) { %>
    <div class="error-message">
      <i class="fas fa-exclamation-triangle"></i> <%= thongBao %>
    </div>
    <% } %>

    <form action="<%= request.getContextPath()%>/nguoiDung/dangky" method="post">
      <div class="form-group">
        <div class="input-group">
          <input type="text" name="ten" class="form-input" placeholder="Họ và tên *" required>
          <i class="fas fa-user input-icon"></i>
        </div>
      </div>

      <div class="form-group">
        <div class="input-group">
          <input type="email" name="email" class="form-input" placeholder="Email *" required>
          <i class="fas fa-envelope input-icon"></i>
        </div>
      </div>

      <div class="form-row">
        <div class="form-group">
          <div class="input-group">
            <input type="password" name="matkhau" class="form-input" placeholder="Mật khẩu *" required>
            <i class="fas fa-lock input-icon"></i>
          </div>
        </div>

        <div class="form-group">
          <div class="input-group">
            <input type="password" name="nhaplaimatkhau" class="form-input" placeholder="Nhập lại mật khẩu *" required>
            <i class="fas fa-lock input-icon"></i>
          </div>
        </div>
      </div>

      <div class="form-group">
        <div class="input-group">
          <input type="date" name="ngaysinh" class="form-input" required>
          <i class="fas fa-calendar input-icon"></i>
        </div>
      </div>

      <button type="submit" class="register-btn">
        <i class="fas fa-user-plus"></i> Đăng ký
      </button>
    </form>

    <div class="login-link">
      <p>Đã có tài khoản? <a href="<%= request.getContextPath()%>/nguoiDung/dangNhap">Đăng nhập ngay</a></p>
    </div>
  </div>
</div>

<script>
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

    // Password validation
    const password = document.querySelector('input[name="matkhau"]');
    const confirmPassword = document.querySelector('input[name="nhaplaimatkhau"]');

    confirmPassword.addEventListener('input', function() {
      if (this.value !== password.value) {
        this.setCustomValidity('Mật khẩu không khớp');
      } else {
        this.setCustomValidity('');
      }
    });

    // Add loading state to register button
    const registerForm = document.querySelector('form');
    const registerBtn = document.querySelector('.register-btn');

    registerForm.addEventListener('submit', function() {
      registerBtn.innerHTML = '<div class="loading"></div> Đang đăng ký...';
      registerBtn.disabled = true;
    });
  });
</script>
</body>
</html>
