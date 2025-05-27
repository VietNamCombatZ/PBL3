
<%@ page import="model.nguoiDung" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<header class="bg-blue-900 text-white shadow-lg sticky top-0 z-50">
  <div class="container mx-auto flex justify-between items-center px-6 py-4">
    <div class="flex items-center space-x-2 text-2xl font-bold">
      <i class="fas fa-futbol text-yellow-400"></i>
      <span>Đặt Sân</span>
      <span class="text-yellow-400">365</span>
    </div>
    <nav class="hidden md:flex space-x-6 text-sm font-medium">
      <a href="#home" class="hover:text-yellow-400">Trang chủ</a>
      <a href="<%=request.getContextPath()%>/sanBong/danhSachSanCoSan"  class="hover:text-yellow-400">Danh sách sân bãi</a>
      <%
        nguoiDung thongTinNguoiDung = (nguoiDung) session.getAttribute("nguoiDung");
        if (thongTinNguoiDung != null) {
      %>
      <a href="<%=request.getContextPath()%>/datSan/lichDatCaNhan" class="hover:text-yellow-400">Danh sách sân đã đặt</a>

      <%
        }
      %>
      <a href="#" class="hover:text-yellow-400">Giới thiệu</a>
      <a href="#" class="hover:text-yellow-400">Chính sách</a>
      <a href="#" class="hover:text-yellow-400">Dành cho chủ sân</a>
      <a href="#" class="hover:text-yellow-400">Liên hệ</a>
    </nav>
    <div class="flex items-center space-x-4">
      <%

        if (thongTinNguoiDung == null) {
      %>
      <a href="<%=request.getContextPath()%>/nguoiDung/dangKy" class="hover:text-yellow-400 hidden md:block">Đăng ký</a>
      <a href="<%=request.getContextPath()%>/nguoiDung/dangNhap" class="hover:text-yellow-400 hidden md:block">Đăng nhập</a>
      <%
      } else {
      %>
      <a href="<%=request.getContextPath()%>nguoiDung/thongTinCaNhan" class="hover:text-yellow-400 hidden md:flex items-center space-x-2">
        <i class="fas fa-user-circle text-lg"></i>
        <span><%= thongTinNguoiDung.getTen() %></span>
      </a>
      <%
        }
      %>
      <a href="#" class="bg-yellow-400 text-blue-900 px-4 py-2 rounded font-bold hover:bg-yellow-300 transition">Đặt Lịch Ngay</a>
    </div>
  </div>
</header>

</body>
</html>
