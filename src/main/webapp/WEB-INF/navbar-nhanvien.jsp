<%--
  Created by IntelliJ IDEA.
  User: huynguyenduc
  Date: 15/5/25
  Time: 08:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.*, model.nguoiDung" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Đặt Sân Bóng Đá</title>
  <script src="https://cdn.tailwindcss.com"></script>
<%--  <link rel="stylesheet" href="styles.css" />--%>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet" />
  <style>
    html {
      scroll-behavior: smooth;
    }
  </style>
<%--  <link rel="stylesheet" href="css/navbar-nhanvien.css">--%>

</head>
<body>
<%
  nguoiDung thongTinNguoiDung = (nguoiDung) session.getAttribute("nguoiDung");

%>

<%--navbar--%>
<header class="bg-blue-900 text-white shadow-lg sticky top-0 z-50">
  <div class="container mx-auto flex justify-between items-center px-6 py-4">
    <div class="flex items-center space-x-2 text-2xl font-bold">
      <i class="fas fa-futbol text-yellow-400"></i>
      <span>Đặt Sân</span>
      <span class="text-yellow-400">365</span>
    </div>
    <nav class="hidden md:flex space-x-6 text-sm font-medium">
      <div class="relative group">
        <a href="#" class="hover:text-yellow-400">Xem danh sách sân</a>
        <div class="absolute hidden group-hover:block top-full left-0 bg-white shadow-lg rounded z-50">
          <a href="<%= request.getContextPath() %>/sanBong/xemTinhTrangSan" class="block px-4 py-2 hover:bg-yellow-100 text-black">Xem tình trạng sân</a>
          <a href="<%= request.getContextPath() %>/sanBong/danhSachSanCoSan" class="block px-4 py-2 hover:bg-yellow-100 text-black">Xem danh sách sân có sẵn</a>
        </div>
      </div>
      <a href="<%= request.getContextPath() %>/nguoiDung/DanhsachKhachHang" class="hover:text-yellow-400">
        Xem danh sách khách hàng
      </a>

      <a href="<%= request.getContextPath() %>/nguoiDung/DanhsachNhanVien" class="hover:text-yellow-400">
        Xem danh sách nhân viên
      </a>
      <div class="relative group">
        <a href="#" class="hover:text-yellow-400">Xem góp ý</a>
        <div class="absolute hidden group-hover:block top-full left-0 bg-white shadow-lg rounded z-50">
          <a href="<%= request.getContextPath() %>/gopY/khachHang" class="block px-4 py-2 hover:bg-yellow-100 text-black">Góp ý của khách hàng</a>
          <a href="<%= request.getContextPath() %>/gopY/san" class="block px-4 py-2 hover:bg-yellow-100 text-black">Góp ý của từng sân</a>
        </div>
      </div>

      <a href="#" class="hover:text-yellow-400">Xem doanh thu</a>
    </nav>


    <div class="relative group hidden md:block">
      <!-- Trigger -->
      <div class="flex items-center space-x-2 cursor-pointer hover:text-yellow-400">
        <i class="fas fa-user-circle text-lg"></i>
        <span><%= thongTinNguoiDung.getTen() %></span>
      </div>

      <!-- Dropdown -->
      <div class="absolute right-0 top-full w-48 bg-white rounded-md shadow-lg opacity-0 group-hover:opacity-100 invisible group-hover:visible transition duration-200 z-50">
        <a href="<%= request.getContextPath() %>/nguoiDung/thongTinCaNhan"
           class="block px-4 py-2 text-gray-700 hover:bg-gray-100">Thông tin cá nhân</a>
        <a href="<%= request.getContextPath() %>/nguoiDung/dangXuat"
           class="block px-4 py-2 text-gray-700 hover:bg-gray-100">Đăng xuất</a>
      </div>
    </div>
<%--      <a href="#" class="bg-yellow-400 text-blue-900 px-4 py-2 rounded font-bold hover:bg-yellow-300 transition">Thông tin cá nhân</a>--%>
    </div>
  </div>
</header>

</body>
</html>
