<%@ page import="java.util.*, model.nguoiDung" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Đặt Sân Bóng Đá</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern-style.css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <style>
    .nav-dropdown {
      position: relative;
      display: inline-block;
    }

    .nav-dropdown-content {
      position: absolute;
      top: 100%;
      left: 0;
      background: white;
      min-width: 220px;
      border-radius: var(--border-radius);
      box-shadow: var(--shadow-lg);
      opacity: 0;
      visibility: hidden;
      transform: translateY(-10px);
      transition: var(--transition);
      z-index: 1000;
      border: 1px solid rgba(0, 0, 0, 0.1);
    }

    .nav-dropdown:hover .nav-dropdown-content {
      opacity: 1;
      visibility: visible;
      transform: translateY(0);
    }

    .nav-dropdown-content a {
      display: block;
      padding: 0.75rem 1rem;
      color: var(--primary-blue);
      text-decoration: none;
      transition: var(--transition);
      border-bottom: 1px solid #f1f5f9;
    }

    .nav-dropdown-content a:last-child {
      border-bottom: none;
    }

    .nav-dropdown-content a:hover {
      background: var(--light-blue);
      color: var(--dark-blue);
      padding-left: 1.5rem;
    }

    .nav-dropdown-content a i {
      margin-right: 0.5rem;
      color: var(--primary-yellow);
    }
  </style>
</head>
<body>
<%
  nguoiDung thongTinNguoiDung = (nguoiDung) session.getAttribute("nguoiDung");
%>

<header class="modern-header">
  <div class="container">
    <a href="<%=request.getContextPath()%>/trangChu" class="modern-logo">
      <i class="fas fa-futbol"></i>
      <span>Đặt Sân <span style="color: var(--primary-yellow);">365</span></span>
    </a>

    <nav class="modern-nav">
      <div class="nav-dropdown">
        <a href="#" style="display: flex; align-items: center; gap: 0.5rem;">
          <i class="fas fa-list"></i> Xem danh sách sân
          <i class="fas fa-chevron-down" style="font-size: 0.8rem;"></i>
        </a>
        <div class="nav-dropdown-content">
          <a href="<%= request.getContextPath() %>/sanBong/xemTinhTrangSan">
            <i class="fas fa-eye"></i> Xem tình trạng sân
          </a>
          <a href="<%= request.getContextPath() %>/sanBong/danhSachSanCoSanNhanVien">
            <i class="fas fa-check-circle"></i> Xem danh sách sân có sẵn
          </a>
        </div>
      </div>

      <a href="<%= request.getContextPath() %>/datSan/tatCaLichDat">
        <i class="fas fa-users"></i> Danh sách lịch đặt
      </a>

      <a href="<%= request.getContextPath() %>/nguoiDung/DanhsachKhachHang">
        <i class="fas fa-users"></i> Danh sách khách hàng
      </a>

      <a href="<%= request.getContextPath() %>/nguoiDung/DanhsachNhanVien">
        <i class="fas fa-user-tie"></i> Danh sách nhân viên
      </a>

<%--      <div class="nav-dropdown">--%>
<%--        <a href="#" style="display: flex; align-items: center; gap: 0.5rem;">--%>
<%--          <i class="fas fa-star"></i> Xem đánh giá--%>
<%--          <i class="fas fa-chevron-down" style="font-size: 0.8rem;"></i>--%>
<%--        </a>--%>
<%--        <div class="nav-dropdown-content">--%>
<%--          <a href="<%= request.getContextPath() %>/danhGia/khachHang">--%>
<%--            <i class="fas fa-user-check"></i> Đánh giá của khách hàng--%>
<%--          </a>--%>
<%--          <a href="<%= request.getContextPath() %>/danhGia/san">--%>
<%--            <i class="fas fa-futbol"></i> Đánh giá của từng sân--%>
<%--          </a>--%>
<%--        </div>--%>
<%--      </div>--%>

      <a href="<%= request.getContextPath() %>/doanhThu">
        <i class="fas fa-chart-line"></i> Xem doanh thu
      </a>
    </nav>

    <div class="modern-dropdown">
      <div style="display: flex; align-items: center; gap: 0.5rem; cursor: pointer; padding: 0.5rem 1rem; border-radius: var(--border-radius); transition: var(--transition);">
        <i class="fas fa-user-circle" style="font-size: 1.5rem;"></i>
        <span><%= thongTinNguoiDung.getTen() %></span>
        <i class="fas fa-chevron-down" style="font-size: 0.8rem;"></i>
      </div>

      <div class="dropdown-content">
        <a href="<%= request.getContextPath() %>/nguoiDung/thongTinCaNhan">
          <i class="fas fa-user"></i> Thông tin cá nhân
        </a>
        <a href="<%= request.getContextPath() %>/nguoiDung/dangXuat">
          <i class="fas fa-sign-out-alt"></i> Đăng xuất
        </a>
      </div>
    </div>
  </div>
</header>

</body>
</html>
