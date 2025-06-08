<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.nguoiDung" %>
<%@ page session="true" %>
<%
  nguoiDung nd = (nguoiDung) session.getAttribute("nguoiDung");
  if (nd == null) {
    response.sendRedirect(request.getContextPath() + "/nguoiDung/dangNhap");
    return;
  }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Chỉnh sửa thông tin cá nhân - Modern</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern-style.css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <style>
    .edit-container {
      max-width: 600px;
      margin: 2rem auto;
      padding: 0 2rem;
    }

    .edit-card {
      background: white;
      border-radius: var(--border-radius);
      box-shadow: var(--shadow-md);
      overflow: hidden;
      animation: slideUp 0.6s ease-out;
    }

    .edit-header {
      background: var(--gradient-primary);
      color: white;
      padding: 2rem;
      text-align: center;
    }

    .edit-title {
      font-size: 1.8rem;
      font-weight: 700;
      margin-bottom: 0.5rem;
    }

    .edit-subtitle {
      opacity: 0.9;
      font-size: 0.9rem;
    }

    .edit-form {
      padding: 2rem;
    }

    .form-group {
      margin-bottom: 1.5rem;
    }

    .form-label {
      display: block;
      font-weight: 600;
      color: var(--primary-blue);
      margin-bottom: 0.5rem;
      font-size: 0.9rem;
    }

    .form-input {
      width: 100%;
      padding: 1rem;
      border: 2px solid #e2e8f0;
      border-radius: var(--border-radius);
      font-size: 1rem;
      transition: var(--transition);
      background: #f8fafc;
    }

    .form-input:focus {
      outline: none;
      border-color: var(--primary-blue);
      background: white;
      box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
    }

    .password-note {
      font-size: 0.8rem;
      color: #64748b;
      margin-top: 0.5rem;
      font-style: italic;
    }

    .submit-btn {
      width: 100%;
      padding: 1rem;
      background: var(--gradient-secondary);
      color: var(--dark-blue);
      border: none;
      border-radius: var(--border-radius);
      font-size: 1rem;
      font-weight: 600;
      cursor: pointer;
      transition: var(--transition);
      margin-top: 1rem;
      box-shadow: var(--shadow-sm);
    }

    .submit-btn:hover {
      transform: translateY(-2px);
      box-shadow: var(--shadow-md);
    }

    .error-message {
      background: #fef2f2;
      color: #dc2626;
      padding: 0.75rem;
      border-radius: var(--border-radius);
      border-left: 4px solid #ef4444;
      margin-bottom: 0.5rem;
      font-size: 0.875rem;
      display: none;
    }

    .success-message {
      background: #f0fdf4;
      color: #166534;
      padding: 1rem;
      border-radius: var(--border-radius);
      border-left: 4px solid #22c55e;
      margin-bottom: 1.5rem;
      font-weight: 500;
    }

    .back-link {
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
      color: var(--primary-blue);
      text-decoration: none;
      font-weight: 500;
      margin-bottom: 2rem;
      transition: var(--transition);
    }

    .back-link:hover {
      color: var(--secondary-blue);
      transform: translateX(-5px);
    }

    @media (max-width: 768px) {
      .edit-container {
        padding: 0 1rem;
      }

      .edit-form {
        padding: 1.5rem;
      }

      .edit-header {
        padding: 1.5rem;
      }
    }
  </style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="edit-container fade-in">
  <a href="<%= request.getContextPath() %>/nguoiDung/thongTinCaNhan" class="back-link">
    <i class="fas fa-arrow-left"></i>
    Quay lại thông tin cá nhân
  </a>

  <div class="edit-card">
    <div class="edit-header">
      <h1 class="edit-title">Chỉnh sửa thông tin cá nhân</h1>
      <p class="edit-subtitle">Cập nhật thông tin tài khoản của bạn</p>
    </div>

    <form id="editForm" action="<%= request.getContextPath() %>/nguoiDung/chinhSuaThongTinCaNhan" method="post" class="edit-form" novalidate>
      <div class="form-group">
        <label for="name" class="form-label">
          <i class="fas fa-user"></i> Họ và tên
        </label>
        <input type="text" id="name" name="name" class="form-input" placeholder="Nhập họ và tên"
               value="<%= nd.getTen() != null ? nd.getTen() : "" %>" required />
        <div class="error-message" id="nameError">Vui lòng nhập họ và tên hợp lệ</div>
      </div>

      <div class="form-group">
        <label for="email" class="form-label">
          <i class="fas fa-envelope"></i> Email
        </label>
        <input type="email" id="email" name="email" class="form-input" placeholder="Nhập địa chỉ email"
               value="<%= nd.getEmail() != null ? nd.getEmail() : "" %>" required />
        <div class="error-message" id="emailError">Vui lòng nhập email hợp lệ</div>
      </div>

      <div class="form-group">
        <label for="ngaySinh" class="form-label">
          <i class="fas fa-calendar"></i> Ngày sinh
        </label>
        <input type="date" id="ngaySinh" name="ngaySinh" class="form-input"
               value="<%= nd.getNgaySinh() != null ? nd.getNgaySinh().toString() : "" %>" required />
        <div class="error-message" id="ngaySinhError">Vui lòng chọn ngày sinh hợp lệ</div>
      </div>

      <div class="form-group">
        <label for="password" class="form-label">
          <i class="fas fa-lock"></i> Mật khẩu mới
        </label>
        <input type="password" id="password" name="password" class="form-input" placeholder="Nhập mật khẩu mới" />
        <div class="password-note">Để trống nếu không muốn thay đổi mật khẩu</div>
        <div class="error-message" id="passwordError">Mật khẩu phải có ít nhất 6 ký tự</div>
      </div>

      <button type="submit" class="submit-btn">
        <i class="fas fa-save"></i> Lưu thay đổi
      </button>
    </form>
  </div>
</div>

<%--footer--%>
<footer class="modern-footer">
  <div class="container">
    <div class="footer-grid">
      <div class="footer-section">
        <h3>Giới thiệu</h3>
        <p>Hệ thống quản lý sân bóng giúp người chơi dễ dàng tìm kiếm, đặt lịch và theo dõi tình trạng sân nhanh chóng, chính xác.</p>
      </div>
      <div class="footer-section">
        <h3>Thông tin liên hệ</h3>
        <p><i class="fas fa-envelope"></i> support@sanbongpro.vn</p>
        <p><i class="fas fa-map-marker-alt"></i> 123 Đường Bóng Đá, Quận Thể Thao, TP. Việt Nam</p>
        <p><i class="fas fa-phone"></i> 0123 456 789</p>
      </div>
      <div class="footer-section">
        <h3>Kết nối với chúng tôi</h3>
        <div style="display: flex; gap: 1rem; margin-top: 1rem;">
          <a href="#" style="font-size: 1.5rem; color: var(--primary-yellow);"><i class="fab fa-facebook"></i></a>
          <a href="#" style="font-size: 1.5rem; color: var(--primary-yellow);"><i class="fas fa-envelope"></i></a>
          <a href="#" style="font-size: 1.5rem; color: var(--primary-yellow);"><i class="fab fa-tiktok"></i></a>
        </div>
      </div>
    </div>
    <div class="footer-bottom">
      <p>© 2025 SanBongPro.vn - All rights reserved.</p>
    </div>
  </div>
</footer>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('editForm');
    const inputs = document.querySelectorAll('.form-input');

    // Add focus effects
    inputs.forEach(input => {
      input.addEventListener('focus', function() {
        this.style.borderColor = 'var(--primary-blue)';
        this.style.background = 'white';
      });

      input.addEventListener('blur', function() {
        if (!this.value) {
          this.style.borderColor = '#e2e8f0';
          this.style.background = '#f8fafc';
        }
      });
    });

    // Form validation
    form.addEventListener('submit', function(e) {
      let isValid = true;

      // Validate name
      const name = document.getElementById('name');
      const nameError = document.getElementById('nameError');
      if (name.value.trim().length < 2) {
        nameError.style.display = 'block';
        name.style.borderColor = '#ef4444';
        isValid = false;
      } else {
        nameError.style.display = 'none';
        name.style.borderColor = '#22c55e';
      }

      // Validate email
      const email = document.getElementById('email');
      const emailError = document.getElementById('emailError');
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      if (!emailRegex.test(email.value)) {
        emailError.style.display = 'block';
        email.style.borderColor = '#ef4444';
        isValid = false;
      } else {
        emailError.style.display = 'none';
        email.style.borderColor = '#22c55e';
      }

      // Validate password (if provided)
      const password = document.getElementById('password');
      const passwordError = document.getElementById('passwordError');
      if (password.value && password.value.length < 6) {
        passwordError.style.display = 'block';
        password.style.borderColor = '#ef4444';
        isValid = false;
      } else {
        passwordError.style.display = 'none';
        if (password.value) password.style.borderColor = '#22c55e';
      }

      // Validate birth date
      const ngaySinh = document.getElementById('ngaySinh');
      const ngaySinhError = document.getElementById('ngaySinhError');
      if (!ngaySinh.value) {
        ngaySinhError.style.display = 'block';
        ngaySinh.style.borderColor = '#ef4444';
        isValid = false;
      } else {
        ngaySinhError.style.display = 'none';
        ngaySinh.style.borderColor = '#22c55e';
      }

      if (!isValid) {
        e.preventDefault();
      } else {
        // Add loading state
        const submitBtn = document.querySelector('.submit-btn');
        submitBtn.innerHTML = '<div class="loading"></div> Đang lưu...';
        submitBtn.disabled = true;
      }
    });

    // Real-time validation
    inputs.forEach(input => {
      input.addEventListener('input', function() {
        const errorElement = document.getElementById(this.id + 'Error');
        if (errorElement && errorElement.style.display === 'block') {
          errorElement.style.display = 'none';
          this.style.borderColor = '#e2e8f0';
        }
      });
    });
  });
</script>
</body>
</html>
