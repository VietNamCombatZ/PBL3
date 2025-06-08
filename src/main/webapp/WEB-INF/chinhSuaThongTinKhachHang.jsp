<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.nguoiDung" %>
<%@ page session="true" %>
<%
  nguoiDung nd = (nguoiDung) session.getAttribute("nguoiDung");
  if (nd == null) {
    response.sendRedirect(request.getContextPath() + "/nguoiDung/dangNhap");
    return;
  }

  nguoiDung khachHang = (nguoiDung) request.getAttribute("khachHang");
  if (khachHang == null) {
    response.sendRedirect(request.getContextPath() + "/nguoiDung/DanhsachKhachHang");
    return;
  }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Chỉnh sửa thông tin khách hàng - Modern</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern-style.css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <style>
    .edit-customer-container {
      max-width: 700px;
      margin: 2rem auto;
      padding: 0 2rem;
    }

    .edit-customer-card {
      background: white;
      border-radius: var(--border-radius);
      box-shadow: var(--shadow-md);
      overflow: hidden;
      animation: slideUp 0.6s ease-out;
    }

    .edit-customer-header {
      background: var(--gradient-primary);
      color: white;
      padding: 2rem;
      text-align: center;
      position: relative;
    }

    .customer-avatar {
      width: 80px;
      height: 80px;
      border-radius: 50%;
      background: var(--gradient-secondary);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 2rem;
      font-weight: 700;
      color: var(--dark-blue);
      margin: 0 auto 1rem;
      border: 4px solid white;
      box-shadow: var(--shadow-md);
    }

    .edit-customer-title {
      font-size: 1.8rem;
      font-weight: 700;
      margin-bottom: 0.5rem;
    }

    .edit-customer-subtitle {
      opacity: 0.9;
      font-size: 0.9rem;
    }

    .edit-customer-form {
      padding: 2rem;
    }

    .form-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 1.5rem;
      margin-bottom: 1.5rem;
    }

    .form-group-full {
      grid-column: 1 / -1;
    }

    .password-note {
      background: var(--light-yellow);
      border-left: 4px solid var(--primary-yellow);
      padding: 1rem;
      border-radius: var(--border-radius);
      margin-top: 0.5rem;
      font-size: 0.875rem;
      color: var(--dark-blue);
    }

    .password-note i {
      color: var(--primary-yellow);
      margin-right: 0.5rem;
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
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 0.5rem;
    }

    .submit-btn:hover {
      transform: translateY(-2px);
      box-shadow: var(--shadow-md);
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

    .customer-info-card {
      background: var(--light-blue);
      border-radius: var(--border-radius);
      padding: 1rem;
      margin-bottom: 2rem;
      border-left: 4px solid var(--primary-blue);
    }

    .customer-info-title {
      font-weight: 600;
      color: var(--primary-blue);
      margin-bottom: 0.5rem;
      font-size: 0.9rem;
    }

    .customer-info-details {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 1rem;
      font-size: 0.875rem;
      color: #64748b;
    }

    @media (max-width: 768px) {
      .edit-customer-container {
        padding: 0 1rem;
      }

      .form-grid {
        grid-template-columns: 1fr;
      }

      .edit-customer-form {
        padding: 1.5rem;
      }

      .edit-customer-header {
        padding: 1.5rem;
      }

      .customer-info-details {
        grid-template-columns: 1fr;
      }
    }
  </style>
</head>
<body>

<%@ include file="navbar-nhanvien.jsp" %>

<div class="edit-customer-container fade-in">
  <a href="<%= request.getContextPath() %>/nguoiDung/DanhsachKhachHang" class="back-link">
    <i class="fas fa-arrow-left"></i>
    Quay lại danh sách khách hàng
  </a>

  <div class="edit-customer-card">
    <div class="edit-customer-header">
      <div class="customer-avatar">
        <%= khachHang.getTen().substring(0, 1).toUpperCase() %>
      </div>
      <h1 class="edit-customer-title">Chỉnh sửa thông tin khách hàng</h1>
      <p class="edit-customer-subtitle">Cập nhật thông tin tài khoản khách hàng</p>
    </div>

    <div class="edit-customer-form">
      <div class="customer-info-card">
        <div class="customer-info-title">
          <i class="fas fa-info-circle"></i>
          Thông tin hiện tại
        </div>
        <div class="customer-info-details">
          <div>
            <strong>ID:</strong> <%= khachHang.getId() %>
          </div>
          <div>
            <strong>Ngày tạo:</strong> <%= khachHang.getNgayTao() %>
          </div>
          <div>
            <strong>Vai trò:</strong> <%= khachHang.getVaiTroNguoiDung().toString().replace("_", " ") %>
          </div>
        </div>
      </div>

      <form id="editForm" action="<%= request.getContextPath() %>/nguoiDung/chinhSuaThongTinKhachHang?id=<%= khachHang.getId() %>" method="post" novalidate>
        <div class="form-grid">
          <div class="form-group">
            <label for="name" class="form-label">
              <i class="fas fa-user"></i> Họ và tên
            </label>
            <input type="text" id="name" name="name" class="form-input" placeholder="Nhập họ và tên"
                   value="<%= khachHang.getTen() != null ? khachHang.getTen() : "" %>" required />
            <div class="error-message" id="nameError">Vui lòng nhập họ và tên hợp lệ</div>
          </div>

          <div class="form-group">
            <label for="email" class="form-label">
              <i class="fas fa-envelope"></i> Email
            </label>
            <input type="email" id="email" name="email" class="form-input" placeholder="Nhập địa chỉ email"
                   value="<%= khachHang.getEmail() != null ? khachHang.getEmail() : "" %>" required />
            <div class="error-message" id="emailError">Vui lòng nhập email hợp lệ</div>
          </div>
        </div>

        <div class="form-group">
          <label for="ngaySinh" class="form-label">
            <i class="fas fa-calendar"></i> Ngày sinh
          </label>
          <input type="date" id="ngaySinh" name="ngaySinh" class="form-input"
                 value="<%= khachHang.getNgaySinh() != null ? khachHang.getNgaySinh().toString() : "" %>" required />
          <div class="error-message" id="ngaySinhError">Vui lòng chọn ngày sinh hợp lệ</div>
        </div>

        <div class="form-group">
          <label for="password" class="form-label">
            <i class="fas fa-lock"></i> Mật khẩu mới
          </label>
          <input type="password" id="password" name="password" class="form-input" placeholder="Nhập mật khẩu mới" />
          <div class="password-note">
            <i class="fas fa-info-circle"></i>
            Để trống nếu không muốn thay đổi mật khẩu của khách hàng
          </div>
          <div class="error-message" id="passwordError">Mật khẩu phải có ít nhất 6 ký tự</div>
        </div>

        <button type="submit" class="submit-btn">
          <i class="fas fa-save"></i>
          Lưu thay đổi
        </button>
      </form>
    </div>
  </div>
</div>


<!-- Footer -->
<%@include file="footer.jsp" %>



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

    // Animate form elements
    const formElements = document.querySelectorAll('.form-group, .customer-info-card');
    formElements.forEach((element, index) => {
      element.style.opacity = '0';
      element.style.transform = 'translateY(20px)';
      element.style.transition = 'all 0.6s ease-out';

      setTimeout(() => {
        element.style.opacity = '1';
        element.style.transform = 'translateY(0)';
      }, index * 100);
    });
  });
</script>
</body>
</html>
