<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.loaiSan" %>
<%@ page import="model.trangThaiSan" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <title>Thêm sân bóng mới - Modern</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern-style.css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <style>
    .create-field-container {
      max-width: 700px;
      margin: 2rem auto;
      padding: 0 2rem;
    }

    .create-field-card {
      background: white;
      border-radius: var(--border-radius);
      box-shadow: var(--shadow-md);
      overflow: hidden;
      animation: slideUp 0.6s ease-out;
    }

    .create-field-header {
      background: var(--gradient-primary);
      color: white;
      padding: 2rem;
      text-align: center;
    }

    .field-icon {
      width: 80px;
      height: 80px;
      border-radius: 50%;
      background: var(--gradient-secondary);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 2rem;
      color: var(--dark-blue);
      margin: 0 auto 1rem;
      border: 4px solid white;
      box-shadow: var(--shadow-md);
    }

    .create-field-title {
      font-size: 1.8rem;
      font-weight: 700;
      margin-bottom: 0.5rem;
    }

    .create-field-subtitle {
      opacity: 0.9;
      font-size: 0.9rem;
    }

    .create-field-form {
      padding: 2rem;
    }

    .field-type-selector {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 1rem;
      margin-top: 0.5rem;
    }

    .field-type-option {
      position: relative;
    }

    .field-type-option input[type="radio"] {
      position: absolute;
      opacity: 0;
      width: 100%;
      height: 100%;
      margin: 0;
      cursor: pointer;
    }

    .field-type-label {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 0.75rem;
      padding: 1.5rem;
      border: 2px solid #e2e8f0;
      border-radius: var(--border-radius);
      background: #f8fafc;
      cursor: pointer;
      transition: var(--transition);
      text-align: center;
    }

    .field-type-option input[type="radio"]:checked + .field-type-label {
      border-color: var(--primary-blue);
      background: var(--light-blue);
      color: var(--primary-blue);
    }

    .field-type-icon {
      width: 60px;
      height: 60px;
      border-radius: 50%;
      background: var(--gradient-primary);
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      font-size: 1.5rem;
    }

    .field-type-option input[type="radio"]:checked + .field-type-label .field-type-icon {
      background: var(--gradient-secondary);
      color: var(--dark-blue);
    }

    .field-type-details h4 {
      margin: 0 0 0.25rem 0;
      font-size: 1.1rem;
      font-weight: 600;
    }

    .field-type-details p {
      margin: 0;
      font-size: 0.8rem;
      opacity: 0.7;
    }

    .status-selector {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 1rem;
      margin-top: 0.5rem;
    }

    .status-option {
      position: relative;
    }

    .status-option input[type="radio"] {
      position: absolute;
      opacity: 0;
      width: 100%;
      height: 100%;
      margin: 0;
      cursor: pointer;
    }

    .status-label {
      display: flex;
      align-items: center;
      gap: 0.75rem;
      padding: 1rem;
      border: 2px solid #e2e8f0;
      border-radius: var(--border-radius);
      background: #f8fafc;
      cursor: pointer;
      transition: var(--transition);
      font-weight: 500;
    }

    .status-option input[type="radio"]:checked + .status-label {
      border-color: var(--primary-blue);
      background: var(--light-blue);
      color: var(--primary-blue);
    }

    .status-icon {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      font-size: 1rem;
    }

    .status-active .status-icon {
      background: linear-gradient(135deg, #22c55e 0%, #16a34a 100%);
    }

    .status-maintenance .status-icon {
      background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
    }

    .status-option input[type="radio"]:checked + .status-label .status-icon {
      background: var(--gradient-secondary);
      color: var(--dark-blue);
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

    @media (max-width: 768px) {
      .create-field-container {
        padding: 0 1rem;
      }

      .field-type-selector,
      .status-selector {
        grid-template-columns: 1fr;
      }

      .create-field-form {
        padding: 1.5rem;
      }

      .create-field-header {
        padding: 1.5rem;
      }
    }
  </style>
</head>
<body>
<%@ include file="navbar-nhanvien.jsp" %>

<div class="create-field-container fade-in">
  <a href="<%= request.getContextPath() %>/sanBong/danhSachSan" class="back-link">
    <i class="fas fa-arrow-left"></i>
    Quay lại danh sách sân bóng
  </a>

  <div class="create-field-card">
    <div class="create-field-header">
      <div class="field-icon">
        <i class="fas fa-plus"></i>
      </div>
      <h1 class="create-field-title">Thêm sân bóng mới</h1>
      <p class="create-field-subtitle">Tạo sân bóng mới cho hệ thống quản lý</p>
    </div>

    <div class="create-field-form">
      <% String error = (String) request.getAttribute("error"); %>
      <% if (error != null && !error.isEmpty()) { %>
      <div class="modern-alert alert-error">
        <i class="fas fa-exclamation-triangle"></i>
        <%= error %>
      </div>
      <% } %>

      <form action="<%= request.getContextPath() %>/sanBong/taoSanBong" method="post" id="createFieldForm" novalidate>
        <div class="form-group">
          <label for="tenSan" class="form-label">
            <i class="fas fa-futbol"></i> Tên sân
          </label>
          <input type="text" id="tenSan" name="tenSan" class="form-input" placeholder="Nhập tên sân bóng" required />
          <div class="error-message" id="tenSanError">Vui lòng nhập tên sân hợp lệ</div>
        </div>

        <div class="form-group">
          <label class="form-label">
            <i class="fas fa-users"></i> Loại sân
          </label>
          <div class="field-type-selector">
            <%
              loaiSan[] danhSachLoaiSan = loaiSan.values();
              for (int i = 0; i < danhSachLoaiSan.length; i++) {
                loaiSan loai = danhSachLoaiSan[i];
                String checked = i == 0 ? "checked" : "";
            %>
            <div class="field-type-option">
              <input type="radio" id="<%= loai.name() %>" name="kieuSan" value="<%= loai.name() %>" <%= checked %>>
              <label for="<%= loai.name() %>" class="field-type-label">
                <div class="field-type-icon">
                  <i class="fas fa-futbol"></i>
                </div>
                <div class="field-type-details">
                  <h4><%= loai.name().replace("_", " ") %></h4>
                  <p><%= loai.name().equals("SAN_5") ? "Sân nhỏ, phù hợp cho nhóm bạn" : "Sân lớn, thi đấu chuyên nghiệp" %></p>
                </div>
              </label>
            </div>
            <%
              }
            %>
          </div>
        </div>

        <div class="form-group">
          <label class="form-label">
            <i class="fas fa-cog"></i> Trạng thái sân
          </label>
          <div class="status-selector">
            <%
              trangThaiSan[] danhSachTrangThai = trangThaiSan.values();
              for (int i = 0; i < danhSachTrangThai.length; i++) {
                trangThaiSan tts = danhSachTrangThai[i];
                String checked = i == 0 ? "checked" : "";
                String statusClass = tts.name().equals("HOAT_DONG") ? "status-active" : "status-maintenance";
                String iconClass = tts.name().equals("HOAT_DONG") ? "fa-check-circle" : "fa-tools";
            %>
            <div class="status-option">
              <input type="radio" id="<%= tts.name() %>" name="trangThai" value="<%= tts.name() %>" <%= checked %>>
              <label for="<%= tts.name() %>" class="status-label <%= statusClass %>">
                <div class="status-icon">
                  <i class="fas <%= iconClass %>"></i>
                </div>
                <div>
                  <h4><%= tts.name().replace("_", " ") %></h4>
                  <p><%= tts.name().equals("HOAT_DONG") ? "Sân đang hoạt động bình thường" : "Sân đang bảo trì, không thể đặt" %></p>
                </div>
              </label>
            </div>
            <%
              }
            %>
          </div>
        </div>

        <button type="submit" class="submit-btn">
          <i class="fas fa-plus-circle"></i>
          Thêm sân bóng
        </button>
      </form>
    </div>
  </div>
</div>


<!-- Footer -->
<%@include file="footer.jsp" %>




<script>
  document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('createFieldForm');
    const tenSanInput = document.getElementById('tenSan');

    // Add focus effects
    tenSanInput.addEventListener('focus', function() {
      this.style.borderColor = 'var(--primary-blue)';
      this.style.background = 'white';
    });

    tenSanInput.addEventListener('blur', function() {
      if (!this.value) {
        this.style.borderColor = '#e2e8f0';
        this.style.background = '#f8fafc';
      }
    });

    // Form validation
    form.addEventListener('submit', function(e) {
      const tenSan = document.getElementById('tenSan');
      const tenSanError = document.getElementById('tenSanError');

      if (tenSan.value.trim().length < 3) {
        tenSanError.style.display = 'block';
        tenSan.style.borderColor = '#ef4444';
        e.preventDefault();
        return;
      } else {
        tenSanError.style.display = 'none';
        tenSan.style.borderColor = '#22c55e';
      }

      // Add loading state
      const submitBtn = document.querySelector('.submit-btn');
      submitBtn.innerHTML = '<div class="loading"></div> Đang tạo...';
      submitBtn.disabled = true;
    });

    // Real-time validation
    tenSanInput.addEventListener('input', function() {
      const errorElement = document.getElementById('tenSanError');
      if (errorElement.style.display === 'block') {
        errorElement.style.display = 'none';
        this.style.borderColor = '#e2e8f0';
      }
    });

    // Animate form elements
    const formElements = document.querySelectorAll('.form-group');
    formElements.forEach((element, index) => {
      element.style.opacity = '0';
      element.style.transform = 'translateY(20px)';
      element.style.transition = 'all 0.6s ease-out';

      setTimeout(() => {
        element.style.opacity = '1';
        element.style.transform = 'translateY(0)';
      }, index * 150);
    });

    // Add hover effects to radio options
    const radioOptions = document.querySelectorAll('.field-type-option, .status-option');
    radioOptions.forEach(option => {
      const label = option.querySelector('label');

      option.addEventListener('mouseenter', function() {
        if (!this.querySelector('input').checked) {
          label.style.transform = 'translateY(-2px)';
          label.style.boxShadow = 'var(--shadow-sm)';
        }
      });

      option.addEventListener('mouseleave', function() {
        if (!this.querySelector('input').checked) {
          label.style.transform = 'translateY(0)';
          label.style.boxShadow = 'none';
        }
      });
    });
  });
</script>
</body>
</html>
