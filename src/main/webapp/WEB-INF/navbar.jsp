<%@ page import="model.nguoiDung" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Modern Navbar</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern-style.css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
<header class="modern-header">
  <div class="container">
    <a href="<%=request.getContextPath()%>/trangChu" class="modern-logo">
      <i class="fas fa-futbol"></i>
      <span>Đặt Sân <span style="color: var(--primary-yellow);">365</span></span>
    </a>

    <nav class="modern-nav">
      <a href="<%=request.getContextPath()%>/trangChu">
        <i class="fas fa-home"></i> Trang chủ
      </a>
      <a href="<%=request.getContextPath()%>/sanBong/danhSachSanCoSan">
        <i class="fas fa-list"></i> Danh sách sân
      </a>

      <%
        nguoiDung thongTinNguoiDung = (nguoiDung) session.getAttribute("nguoiDung");
        if (thongTinNguoiDung != null) {
      %>
      <a href="<%=request.getContextPath()%>/datSan/lichDatCaNhan">
        <i class="fas fa-calendar-check"></i> Lịch đặt sân
      </a>
      <%
        }
      %>

      <a href="<%=request.getContextPath()%>/trangChu">
        <i class="fas fa-info-circle"></i> Giới thiệu
      </a>
      <a href="<%=request.getContextPath()%>/trangChu">
        <i class="fas fa-phone"></i> Liên hệ
      </a>
    </nav>

    <div class="modern-nav">
      <%
        if (thongTinNguoiDung == null) {
      %>
      <a href="<%=request.getContextPath()%>/nguoiDung/dangKy" class="btn-modern btn-outline">
        <i class="fas fa-user-plus"></i> Đăng ký
      </a>
      <a href="<%=request.getContextPath()%>/nguoiDung/dangNhap" class="btn-modern btn-secondary">
        <i class="fas fa-sign-in-alt"></i> Đăng nhập
      </a>
      <%
      } else {
      %>
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
      <%
        }
      %>

      <a href="<%=request.getContextPath()%>/sanBong/danhSachSanCoSan" class="btn-modern btn-secondary">
        <i class="fas fa-calendar-plus"></i> Đặt Lịch Ngay
      </a>
    </div>
  </div>
</header>
</body>
</html>
