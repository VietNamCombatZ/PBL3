<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.text.SimpleDateFormat" %>
<%@ page import="model.*, model.sanBong, DAO.SanBongDAO, DAO.DanhGiaDAO" %>
<%@ page import="DAO.*" %>

<%
  SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm");
  List<datSan> lichDat = DatSanDAO.timDanhSachDatSan();
%>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Danh sách tất cả lịch đặt sân</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="../css/modern-style.css" />
</head>
<body class="modern-bg">

<%@include file="navbar-nhanvien.jsp" %>

<div class="container mx-auto px-4 py-8">
  <!-- Header Section -->
  <div class="text-center mb-8">
    <div class="inline-flex items-center justify-center w-16 h-16 bg-gradient-to-r from-purple-500 to-purple-600 rounded-full mb-4">
      <i class="fas fa-calendar-check text-white text-2xl"></i>
    </div>
    <h1 class="text-3xl font-bold text-gray-800 mb-2">Quản lý tất cả lịch đặt sân</h1>
    <p class="text-gray-600">Theo dõi và quản lý toàn bộ lịch đặt sân trong hệ thống</p>
  </div>

  <!-- Stats Cards -->
  <%
    int totalBookings = lichDat != null ? lichDat.size() : 0;
    int pendingPayment = 0;
    int paid = 0;
    int cancelled = 0;
    long totalRevenue = 0;

    if (lichDat != null) {
      for (datSan ds : lichDat) {
        switch(ds.getTrangThai()) {
          case CHO_THANH_TOAN:
            pendingPayment++;
            break;
          case DA_THANH_TOAN:
            paid++;
            totalRevenue += ds.getSoTien();
            break;
          case DA_HUY:
            cancelled++;
            break;
        }
      }
    }
  %>

  <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
    <div class="stats-card">
      <div class="flex items-center justify-between">
        <div>
          <div class="text-3xl font-bold text-gray-800"><%= totalBookings %></div>
          <div class="text-sm text-gray-600">Tổng lịch đặt</div>
        </div>
        <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center">
          <i class="fas fa-calendar-alt text-blue-600 text-xl"></i>
        </div>
      </div>
    </div>

    <div class="stats-card">
      <div class="flex items-center justify-between">
        <div>
          <div class="text-3xl font-bold text-yellow-600"><%= pendingPayment %></div>
          <div class="text-sm text-gray-600">Chờ thanh toán</div>
        </div>
        <div class="w-12 h-12 bg-yellow-100 rounded-lg flex items-center justify-center">
          <i class="fas fa-clock text-yellow-600 text-xl"></i>
        </div>
      </div>
    </div>

    <div class="stats-card">
      <div class="flex items-center justify-between">
        <div>
          <div class="text-3xl font-bold text-green-600"><%= paid %></div>
          <div class="text-sm text-gray-600">Đã thanh toán</div>
        </div>
        <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center">
          <i class="fas fa-check-circle text-green-600 text-xl"></i>
        </div>
      </div>
    </div>

    <div class="stats-card">
      <div class="flex items-center justify-between">
        <div>
          <div class="text-lg font-bold text-purple-600"><%= String.format("%,d", totalRevenue) %></div>
          <div class="text-sm text-gray-600">Tổng doanh thu (VNĐ)</div>
        </div>
        <div class="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center">
          <i class="fas fa-money-bill text-purple-600 text-xl"></i>
        </div>
      </div>
    </div>
  </div>

  <!-- Bookings Table -->
  <div class="modern-card">
    <div class="flex items-center justify-between mb-6">
      <h2 class="text-xl font-semibold text-gray-800">
        <i class="fas fa-list mr-2"></i>Danh sách lịch đặt
      </h2>
      <div class="flex items-center space-x-4">
        <!-- Filter buttons could go here -->
        <div class="text-sm text-gray-600">
          Hiển thị: <span class="font-semibold"><%= totalBookings %></span> lịch đặt
        </div>
      </div>
    </div>

    <%
      if (lichDat == null || lichDat.isEmpty()) {
    %>
    <div class="text-center py-12">
      <div class="w-24 h-24 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
        <i class="fas fa-calendar-times text-gray-400 text-3xl"></i>
      </div>
      <h3 class="text-lg font-medium text-gray-800 mb-2">Chưa có lịch đặt nào</h3>
      <p class="text-gray-600">Hệ thống chưa có lịch đặt sân nào được tạo</p>
    </div>
    <%
    } else {
    %>
    <div class="overflow-x-auto">
      <table class="w-full">
        <thead>
        <tr class="border-b border-gray-200">
          <th class="text-left py-4 px-4 font-semibold text-gray-700">
            <i class="fas fa-user mr-2"></i>Khách hàng
          </th>
          <th class="text-left py-4 px-4 font-semibold text-gray-700">
            <i class="fas fa-futbol mr-2"></i>Sân bóng
          </th>
          <th class="text-left py-4 px-4 font-semibold text-gray-700">
            <i class="fas fa-clock mr-2"></i>Thời gian
          </th>
          <th class="text-left py-4 px-4 font-semibold text-gray-700">
            <i class="fas fa-money-bill mr-2"></i>Số tiền
          </th>
          <th class="text-left py-4 px-4 font-semibold text-gray-700">
            <i class="fas fa-info-circle mr-2"></i>Trạng thái
          </th>
          <th class="text-center py-4 px-4 font-semibold text-gray-700">
            <i class="fas fa-cogs mr-2"></i>Thao tác
          </th>
        </tr>
        </thead>
        <tbody>
        <%
          for (datSan ds : lichDat) {
            nguoiDung kh = NguoiDungDAO.layNguoiDungTheoId(ds.getIdKhachHang());
            sanBong sb = SanBongDAO.timSanTheoId(ds.getIdSanBong());
            if (kh == null || sb == null) continue;

            boolean coTheHuy = ds.getTrangThai() == trangThaiDatSan.CHO_THANH_TOAN || ds.getTrangThai() == trangThaiDatSan.DA_HUY;
            boolean coTheThanhToan = ds.getTrangThai() == trangThaiDatSan.CHO_THANH_TOAN;
            danhGia dg = DanhGiaDAO.timDanhGiaTheoDatSan(ds.getId());

            String statusClass = "";
            String statusIcon = "";
            switch(ds.getTrangThai()) {
              case CHO_THANH_TOAN:
                statusClass = "bg-yellow-100 text-yellow-800";
                statusIcon = "fas fa-clock";
                break;
              case DA_THANH_TOAN:
                statusClass = "bg-green-100 text-green-800";
                statusIcon = "fas fa-check-circle";
                break;
              case DA_HUY:
                statusClass = "bg-red-100 text-red-800";
                statusIcon = "fas fa-times-circle";
                break;
              default:
                statusClass = "bg-gray-100 text-gray-800";
                statusIcon = "fas fa-question-circle";
            }
        %>
        <tr class="border-b border-gray-100 hover:bg-gray-50 transition-colors">
          <td class="py-4 px-4">
            <div class="flex items-center space-x-3">
              <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center">
                <i class="fas fa-user text-blue-600"></i>
              </div>
              <div>
                <div class="font-medium text-gray-800"><%= kh.getTen() %></div>
                <div class="text-sm text-gray-600"><%= kh.getEmail() %></div>
              </div>
            </div>
          </td>
          <td class="py-4 px-4">
            <div class="flex items-center space-x-3">
              <div class="w-10 h-10 bg-green-100 rounded-lg flex items-center justify-center">
                <i class="fas fa-futbol text-green-600"></i>
              </div>
              <div>
                <div class="font-medium text-gray-800"><%= sb.getTenSan() %></div>
                <div class="text-sm text-gray-600"><%= sb.getKieuSan().name().replace("_", " ") %></div>
              </div>
            </div>
          </td>
          <td class="py-4 px-4">
            <div class="text-sm">
              <div class="font-medium text-gray-800">
                <i class="fas fa-play text-green-500 mr-1"></i>
                <%= sdf.format(ds.getGioBatDau()) %>
              </div>
              <div class="text-gray-600">
                <i class="fas fa-stop text-red-500 mr-1"></i>
                <%= sdf.format(ds.getGioKetThuc()) %>
              </div>
            </div>
          </td>
          <td class="py-4 px-4">
            <div class="font-semibold text-gray-800">
              <%= String.format("%,d", ds.getSoTien()) %> VNĐ
            </div>
          </td>
          <td class="py-4 px-4">
            <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium <%= statusClass %>">
              <i class="<%= statusIcon %> mr-1"></i>
              <%= ds.getTrangThai().toString() %>
            </span>
          </td>
          <td class="py-4 px-4">
            <div class="flex flex-col space-y-2">
              <% if (dg != null) { %>
              <form action="<%= request.getContextPath() %>/danhGia/xemDanhGiaCuaKhachHang" method="get">
                <input type="hidden" name="idDatSan" value="<%= ds.getId() %>" />
                <button type="submit" class="btn-action btn-view w-full">
                  <i class="fas fa-star mr-1"></i>
                  Xem đánh giá
                </button>
              </form>
              <% } %>

              <% if (coTheThanhToan) { %>
              <form action="<%= request.getContextPath() %>/datSan/thanhToanSan" method="post"
                    onsubmit="return confirm('Xác nhận thanh toán lịch đặt này?');">
                <input type="hidden" name="idDatSan" value="<%= ds.getId() %>" />
                <button type="submit" class="btn-action btn-success w-full">
                  <i class="fas fa-credit-card mr-1"></i>
                  Xác nhận thanh toán
                </button>
              </form>
              <% } %>

              <% if (coTheHuy) { %>
              <form action="<%= request.getContextPath() %>/datSan/huyDatSanNhanVien" method="post"
                    onsubmit="return confirm('Bạn có chắc muốn hủy lịch đặt này không?');">
                <input type="hidden" name="idDatSan" value="<%= ds.getId() %>" />
                <button type="submit" class="btn-action btn-danger w-full">
                  <i class="fas fa-times mr-1"></i>
                  Hủy đặt
                </button>
              </form>
              <% } %>
            </div>
          </td>
        </tr>
        <%
          }
        %>
        </tbody>
      </table>
    </div>
    <%
      }
    %>
  </div>
</div>

<%@include file="footer.jsp" %>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    // Add loading states to action buttons
    const actionButtons = document.querySelectorAll('.btn-action');

    actionButtons.forEach(button => {
      button.addEventListener('click', function() {
        if (this.type === 'submit') {
          const originalText = this.innerHTML;
          this.innerHTML = '<i class="fas fa-spinner fa-spin mr-1"></i>Đang xử lý...';
          this.disabled = true;

          // Re-enable after 3 seconds (in case of error)
          setTimeout(() => {
            this.innerHTML = originalText;
            this.disabled = false;
          }, 3000);
        }
      });
    });

    // Add hover effects to table rows
    const tableRows = document.querySelectorAll('tbody tr');
    tableRows.forEach(row => {
      row.addEventListener('mouseenter', function() {
        this.style.transform = 'translateX(4px)';
      });

      row.addEventListener('mouseleave', function() {
        this.style.transform = 'translateX(0)';
      });
    });

    // Add search functionality
    const searchInput = document.createElement('input');
    searchInput.type = 'text';
    searchInput.placeholder = 'Tìm kiếm theo tên khách hàng hoặc sân...';
    searchInput.className = 'form-input mb-4';

    const tableContainer = document.querySelector('.modern-card .overflow-x-auto');
    if (tableContainer) {
      tableContainer.parentNode.insertBefore(searchInput, tableContainer);

      searchInput.addEventListener('input', function() {
        const searchTerm = this.value.toLowerCase();
        const rows = document.querySelectorAll('tbody tr');

        rows.forEach(row => {
          const customerName = row.querySelector('td:first-child .font-medium').textContent.toLowerCase();
          const fieldName = row.querySelector('td:nth-child(2) .font-medium').textContent.toLowerCase();

          if (customerName.includes(searchTerm) || fieldName.includes(searchTerm)) {
            row.style.display = '';
          } else {
            row.style.display = 'none';
          }
        });
      });
    }
  });
</script>

</body>
</html>
