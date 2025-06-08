<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.nguoiDung" %>
<%@ page import="model.*" %>
<%@ page session="true" %>
<%
  nguoiDung nd = (nguoiDung) session.getAttribute("nguoiDung");
  if (nd == null) {
    response.sendRedirect(request.getContextPath() + "/nguoiDung/dangNhap");
    return;
  }

  nguoiDung nhanVien = (nguoiDung) request.getAttribute("nhanVien");
  if (nhanVien == null) {
    response.sendRedirect(request.getContextPath() + "/nguoiDung/DanhsachKhachHang");
    return;
  }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Chỉnh sửa thông tin nhân viên</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="../css/modern-style.css" />
</head>
<body class="modern-bg">

<%@ include file="navbar-nhanvien.jsp" %>

<div class="container mx-auto px-4 py-8 max-w-4xl">
  <!-- Header Section -->
  <div class="text-center mb-8">
    <div class="inline-flex items-center justify-center w-16 h-16 bg-gradient-to-r from-blue-500 to-blue-600 rounded-full mb-4">
      <i class="fas fa-user-edit text-white text-2xl"></i>
    </div>
    <h1 class="text-3xl font-bold text-gray-800 mb-2">Chỉnh sửa thông tin nhân viên</h1>
    <p class="text-gray-600">Cập nhật thông tin chi tiết cho nhân viên</p>
  </div>

  <!-- Current Info Card -->
  <div class="modern-card mb-8">
    <div class="flex items-center space-x-4 mb-6">
      <div class="w-16 h-16 bg-gradient-to-r from-blue-500 to-purple-600 rounded-full flex items-center justify-center">
        <i class="fas fa-user text-white text-xl"></i>
      </div>
      <div>
        <h3 class="text-xl font-semibold text-gray-800">Thông tin hiện tại</h3>
        <p class="text-gray-600"><%= nhanVien.getTen() %> - <%= nhanVien.getVaiTroNguoiDung() %></p>
      </div>
    </div>
  </div>

  <!-- Edit Form -->
  <div class="modern-card">
    <% String thongBao = (String) request.getAttribute("thongBao");
      if(thongBao == null){
        thongBao = (String) session.getAttribute("thongBao");
      }%>
    <% if (thongBao != null) { %>
    <div class="bg-red-50 border-l-4 border-red-400 p-4 mb-6">
      <div class="flex">
        <i class="fas fa-exclamation-triangle text-red-400 mr-3 mt-1"></i>
        <p class="text-red-700"><%= thongBao %></p>
      </div>
    </div>
    <% } %>

    <form id="editForm" action="<%= request.getContextPath() %>/nguoiDung/chinhSuaThongTinNhanVien?id=<%= nhanVien.getId() %>" method="post" novalidate>
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <!-- Tên -->
        <div class="form-group">
          <label for="name" class="form-label">
            <i class="fas fa-user mr-2"></i>Họ và tên
          </label>
          <input type="text" id="name" name="name"
                 class="form-input"
                 placeholder="Nhập họ và tên đầy đủ"
                 value="<%= nhanVien.getTen() != null ? nhanVien.getTen() : "" %>"
                 required />
          <div class="error-message" id="nameError"></div>
        </div>

        <!-- Email -->
        <div class="form-group">
          <label for="email" class="form-label">
            <i class="fas fa-envelope mr-2"></i>Email
          </label>
          <input type="email" id="email" name="email"
                 class="form-input"
                 placeholder="example@company.com"
                 value="<%= nhanVien.getEmail() != null ? nhanVien.getEmail() : "" %>"
                 required />
          <div class="error-message" id="emailError"></div>
        </div>

        <!-- Ngày sinh -->
        <div class="form-group">
          <label for="ngaySinh" class="form-label">
            <i class="fas fa-calendar mr-2"></i>Ngày sinh
          </label>
          <input type="date" id="ngaySinh" name="ngaySinh"
                 class="form-input"
                 value="<%= nhanVien.getNgaySinh() != null ? nhanVien.getNgaySinh().toString() : "" %>"
                 required />
          <div class="error-message" id="ngaySinhError"></div>
        </div>

        <!-- Vai trò -->
        <div class="form-group">
          <label for="vaiTro" class="form-label">
            <i class="fas fa-user-tag mr-2"></i>Vai trò
          </label>
          <select id="vaiTro" name="vaiTro" class="form-input" required>
            <option value="">Chọn vai trò</option>
            <option value="NHAN_VIEN" <%= nhanVien.getVaiTroNguoiDung() == vaiTro.NHAN_VIEN ? "selected" : "" %>>
              Nhân viên
            </option>
            <option value="QUAN_LY" <%= nhanVien.getVaiTroNguoiDung() == vaiTro.QUAN_LY ? "selected" : "" %>>
              Quản lý
            </option>
          </select>
          <div class="error-message" id="vaiTroError"></div>
        </div>
      </div>

      <!-- Role Description -->
      <div class="mt-6 p-4 bg-blue-50 rounded-lg" id="roleDescription">
        <div class="flex items-start space-x-3">
          <i class="fas fa-info-circle text-blue-500 mt-1"></i>
          <div>
            <h4 class="font-semibold text-blue-800 mb-1">Mô tả vai trò</h4>
            <p class="text-blue-700 text-sm" id="roleDescText">Chọn vai trò để xem mô tả chi tiết</p>
          </div>
        </div>
      </div>

      <!-- Action Buttons -->
      <div class="flex flex-col sm:flex-row gap-4 mt-8">
        <button type="submit" class="btn-primary flex-1">
          <i class="fas fa-save mr-2"></i>
          Lưu thay đổi
        </button>
        <a href="<%= request.getContextPath() %>/nguoiDung/DanhsachNhanVien"
           class="btn-secondary flex-1 text-center">
          <i class="fas fa-arrow-left mr-2"></i>
          Quay lại
        </a>
      </div>
    </form>
  </div>
</div>


<!-- Footer -->
<%@include file="footer.jsp" %>




<script>
  document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('editForm');
    const vaiTroSelect = document.getElementById('vaiTro');
    const roleDescText = document.getElementById('roleDescText');

    // Role descriptions
    const roleDescriptions = {
      'NHAN_VIEN': 'Nhân viên có quyền quản lý khách hàng, xem danh sách sân, xử lý đặt sân và xem đánh giá.',
      'QUAN_LY': 'Quản lý có đầy đủ quyền hạn: quản lý nhân viên, khách hàng, sân bóng, xem doanh thu và tất cả chức năng hệ thống.'
    };

    // Update role description
    function updateRoleDescription() {
      const selectedRole = vaiTroSelect.value;
      if (selectedRole && roleDescriptions[selectedRole]) {
        roleDescText.textContent = roleDescriptions[selectedRole];
      } else {
        roleDescText.textContent = 'Chọn vai trò để xem mô tả chi tiết';
      }
    }

    vaiTroSelect.addEventListener('change', updateRoleDescription);
    updateRoleDescription(); // Initial call

    // Form validation
    const validators = {
      name: {
        element: document.getElementById('name'),
        error: document.getElementById('nameError'),
        validate: function(value) {
          if (!value.trim()) return 'Vui lòng nhập họ và tên';
          if (value.trim().length < 2) return 'Họ và tên phải có ít nhất 2 ký tự';
          if (!/^[a-zA-ZÀ-ỹ\s]+$/.test(value.trim())) return 'Họ và tên chỉ được chứa chữ cái và khoảng trắng';
          return '';
        }
      },
      email: {
        element: document.getElementById('email'),
        error: document.getElementById('emailError'),
        validate: function(value) {
          if (!value.trim()) return 'Vui lòng nhập email';
          const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
          if (!emailRegex.test(value)) return 'Email không hợp lệ';
          return '';
        }
      },
      ngaySinh: {
        element: document.getElementById('ngaySinh'),
        error: document.getElementById('ngaySinhError'),
        validate: function(value) {
          if (!value) return 'Vui lòng chọn ngày sinh';
          const birthDate = new Date(value);
          const today = new Date();
          const age = today.getFullYear() - birthDate.getFullYear();
          if (age < 18) return 'Nhân viên phải từ 18 tuổi trở lên';
          if (age > 65) return 'Tuổi không hợp lệ';
          return '';
        }
      },
      vaiTro: {
        element: document.getElementById('vaiTro'),
        error: document.getElementById('vaiTroError'),
        validate: function(value) {
          if (!value) return 'Vui lòng chọn vai trò';
          return '';
        }
      }
    };

    // Real-time validation
    Object.keys(validators).forEach(field => {
      const validator = validators[field];
      validator.element.addEventListener('input', function() {
        validateField(field);
      });
      validator.element.addEventListener('blur', function() {
        validateField(field);
      });
    });

    function validateField(field) {
      const validator = validators[field];
      const value = validator.element.value;
      const error = validator.validate(value);

      validator.error.textContent = error;

      if (error) {
        validator.element.classList.add('border-red-500');
        validator.element.classList.remove('border-green-500');
      } else {
        validator.element.classList.remove('border-red-500');
        validator.element.classList.add('border-green-500');
      }

      return !error;
    }

    // Form submission
    form.addEventListener('submit', function(e) {
      let isValid = true;

      Object.keys(validators).forEach(field => {
        if (!validateField(field)) {
          isValid = false;
        }
      });

      if (!isValid) {
        e.preventDefault();

        // Show error notification
        const errorDiv = document.createElement('div');
        errorDiv.className = 'fixed top-4 right-4 bg-red-500 text-white px-6 py-3 rounded-lg shadow-lg z-50';
        errorDiv.innerHTML = '<i class="fas fa-exclamation-triangle mr-2"></i>Vui lòng kiểm tra lại thông tin';
        document.body.appendChild(errorDiv);

        setTimeout(() => {
          errorDiv.remove();
        }, 3000);
      } else {
        // Show loading state
        const submitBtn = form.querySelector('button[type="submit"]');
        const originalText = submitBtn.innerHTML;
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>Đang lưu...';
        submitBtn.disabled = true;

        // Re-enable after 3 seconds (in case of error)
        setTimeout(() => {
          submitBtn.innerHTML = originalText;
          submitBtn.disabled = false;
        }, 3000);
      }
    });
  });
</script>

</body>
</html>
