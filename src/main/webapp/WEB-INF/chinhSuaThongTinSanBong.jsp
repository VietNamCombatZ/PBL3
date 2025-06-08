<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.sanBong" %>
<%@ page import="model.trangThaiSan" %>
<%@ page import="model.loaiSan" %>
<%@ page import="DAO.SanBongDAO" %>
<%@ page session="true" %>
<%
  String idSanBong = request.getParameter("id");
  sanBong san = SanBongDAO.timSanTheoId(idSanBong);
  if (san == null) {
    response.sendRedirect(request.getContextPath() + "/sanBong/danhSachSan");
    return;
  }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Chỉnh sửa thông tin sân bóng</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern-style.css" />
</head>
<body class="modern-bg">

<%@ include file="navbar-nhanvien.jsp" %>

<div class="container mx-auto px-4 py-8 max-w-4xl">
  <!-- Header Section -->
  <div class="text-center mb-8">
    <div class="inline-flex items-center justify-center w-16 h-16 bg-gradient-to-r from-green-500 to-green-600 rounded-full mb-4">
      <i class="fas fa-futbol text-white text-2xl"></i>
    </div>
    <h1 class="text-3xl font-bold text-gray-800 mb-2">Chỉnh sửa thông tin sân bóng</h1>
    <p class="text-gray-600">Cập nhật thông tin chi tiết cho sân bóng</p>
  </div>

  <!-- Current Field Info -->
  <div class="modern-card mb-8">
    <div class="flex items-center space-x-4 mb-6">
      <div class="w-16 h-16 bg-gradient-to-r from-green-500 to-blue-600 rounded-full flex items-center justify-center">
        <i class="fas fa-futbol text-white text-xl"></i>
      </div>
      <div>
        <h3 class="text-xl font-semibold text-gray-800">Thông tin hiện tại</h3>
        <p class="text-gray-600"><%= san.getTenSan() %> - <%= san.getKieuSan().name().replace("_", " ") %></p>
      </div>
      <div class="ml-auto">
        <%
          String statusClass = "";
          String statusIcon = "";
          if (san.getTrangThai() == trangThaiSan.HOAT_DONG) {
            statusClass = "bg-green-100 text-green-800";
            statusIcon = "fas fa-check-circle";
          } else {
            statusClass = "bg-yellow-100 text-yellow-800";
            statusIcon = "fas fa-tools";
          }
        %>
        <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium <%= statusClass %>">
          <i class="<%= statusIcon %> mr-1"></i>
          <%= san.getTrangThai() %>
        </span>
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

    <form id="editForm"
          action="<%= request.getContextPath() %>/sanBong/chinhSuaThongTinSan?id=<%= san.getId() %>"
          method="post" novalidate>

      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <!-- Tên sân -->
        <div class="form-group md:col-span-2">
          <label for="tenSan" class="form-label">
            <i class="fas fa-futbol mr-2"></i>Tên sân bóng
          </label>
          <input type="text" id="tenSan" name="tenSan"
                 class="form-input"
                 placeholder="Nhập tên sân bóng"
                 value="<%= san.getTenSan() != null ? san.getTenSan() : "" %>"
                 required />
          <div class="error-message" id="tenSanError"></div>
        </div>

        <!-- Kiểu sân -->
        <div class="form-group">
          <label for="kieuSan" class="form-label">
            <i class="fas fa-layer-group mr-2"></i>Loại sân
          </label>
          <select id="kieuSan" name="kieuSan" class="form-input" required>
            <option value="">Chọn loại sân</option>
            <option value="SAN_5" <%= san.getKieuSan() == loaiSan.SAN_5 ? "selected" : "" %>>
              Sân 5 người
            </option>
            <option value="SAN_7" <%= san.getKieuSan() == loaiSan.SAN_7 ? "selected" : "" %>>
              Sân 7 người
            </option>
          </select>
          <div class="error-message" id="kieuSanError"></div>
        </div>

        <!-- Trạng thái -->
        <div class="form-group">
          <label for="trangThai" class="form-label">
            <i class="fas fa-toggle-on mr-2"></i>Trạng thái
          </label>
          <select id="trangThai" name="trangThai" class="form-input" required>
            <option value="">Chọn trạng thái</option>
            <option value="HOAT_DONG" <%= san.getTrangThai() == trangThaiSan.HOAT_DONG ? "selected" : "" %>>
              Hoạt động
            </option>
            <option value="BAO_TRI" <%= san.getTrangThai() == trangThaiSan.BAO_TRI ? "selected" : "" %>>
              Bảo trì
            </option>
          </select>
          <div class="error-message" id="trangThaiError"></div>
        </div>
      </div>

      <!-- Field Type Info -->
      <div class="mt-6 p-4 bg-blue-50 rounded-lg" id="fieldTypeInfo">
        <div class="flex items-start space-x-3">
          <i class="fas fa-info-circle text-blue-500 mt-1"></i>
          <div>
            <h4 class="font-semibold text-blue-800 mb-1">Thông tin loại sân</h4>
            <p class="text-blue-700 text-sm" id="fieldTypeText">Chọn loại sân để xem thông tin chi tiết</p>
          </div>
        </div>
      </div>

      <!-- Status Info -->
      <div class="mt-4 p-4 bg-green-50 rounded-lg" id="statusInfo">
        <div class="flex items-start space-x-3">
          <i class="fas fa-info-circle text-green-500 mt-1"></i>
          <div>
            <h4 class="font-semibold text-green-800 mb-1">Thông tin trạng thái</h4>
            <p class="text-green-700 text-sm" id="statusText">Chọn trạng thái để xem mô tả</p>
          </div>
        </div>
      </div>

      <!-- Action Buttons -->
      <div class="flex flex-col sm:flex-row gap-4 mt-8">
        <button type="submit" class="btn-primary flex-1">
          <i class="fas fa-save mr-2"></i>
          Lưu thay đổi
        </button>
        <a href="<%= request.getContextPath() %>/sanBong/danhSachSan"
           class="btn-secondary flex-1 text-center">
          <i class="fas fa-arrow-left mr-2"></i>
          Quay lại danh sách
        </a>
      </div>
    </form>
  </div>
</div>

<%@include file="footer.jsp" %>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('editForm');
    const kieuSanSelect = document.getElementById('kieuSan');
    const trangThaiSelect = document.getElementById('trangThai');
    const fieldTypeText = document.getElementById('fieldTypeText');
    const statusText = document.getElementById('statusText');

    // Field type descriptions
    const fieldTypeDescriptions = {
      'SAN_5': 'Sân bóng đá 5 người với kích thước nhỏ gọn, phù hợp cho các trận đấu nhanh và kỹ thuật cao.',
      'SAN_7': 'Sân bóng đá 7 người với kích thước trung bình, cân bằng giữa tốc độ và chiến thuật.'
    };

    // Status descriptions
    const statusDescriptions = {
      'HOAT_DONG': 'Sân đang hoạt động bình thường và có thể được đặt bởi khách hàng.',
      'BAO_TRI': 'Sân đang trong quá trình bảo trì, không thể đặt lịch trong thời gian này.'
    };

    // Update field type description
    function updateFieldTypeDescription() {
      const selectedType = kieuSanSelect.value;
      if (selectedType && fieldTypeDescriptions[selectedType]) {
        fieldTypeText.textContent = fieldTypeDescriptions[selectedType];
      } else {
        fieldTypeText.textContent = 'Chọn loại sân để xem thông tin chi tiết';
      }
    }

    // Update status description
    function updateStatusDescription() {
      const selectedStatus = trangThaiSelect.value;
      if (selectedStatus && statusDescriptions[selectedStatus]) {
        statusText.textContent = statusDescriptions[selectedStatus];
      } else {
        statusText.textContent = 'Chọn trạng thái để xem mô tả';
      }
    }

    kieuSanSelect.addEventListener('change', updateFieldTypeDescription);
    trangThaiSelect.addEventListener('change', updateStatusDescription);

    // Initial calls
    updateFieldTypeDescription();
    updateStatusDescription();

    // Form validation
    const validators = {
      tenSan: {
        element: document.getElementById('tenSan'),
        error: document.getElementById('tenSanError'),
        validate: function(value) {
          if (!value.trim()) return 'Vui lòng nhập tên sân bóng';
          if (value.trim().length < 3) return 'Tên sân phải có ít nhất 3 ký tự';
          if (value.trim().length > 50) return 'Tên sân không được quá 50 ký tự';
          return '';
        }
      },
      kieuSan: {
        element: document.getElementById('kieuSan'),
        error: document.getElementById('kieuSanError'),
        validate: function(value) {
          if (!value) return 'Vui lòng chọn loại sân';
          return '';
        }
      },
      trangThai: {
        element: document.getElementById('trangThai'),
        error: document.getElementById('trangThaiError'),
        validate: function(value) {
          if (!value) return 'Vui lòng chọn trạng thái';
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
