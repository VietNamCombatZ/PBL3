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

<%--navbar--%>
<header class="bg-blue-900 text-white shadow-lg sticky top-0 z-50">
  <div class="container mx-auto flex justify-between items-center px-6 py-4">
    <div class="flex items-center space-x-2 text-2xl font-bold">
      <i class="fas fa-futbol text-yellow-400"></i>
      <span>Đặt Sân</span>
      <span class="text-yellow-400">365</span>
    </div>
    <nav class="hidden md:flex space-x-6 text-sm font-medium">
      <a href="#" class="hover:text-yellow-400">Xem danh sách sân</a>
      <a href="<%= request.getContextPath() %>/nguoiDung/DanhsachKhachHang" class="hover:text-yellow-400">
        Xem danh sách khách hàng
      </a>

      <a href="<%= request.getContextPath() %>/nguoiDung/DanhsachNhanVien" class="hover:text-yellow-400">
        Xem danh sách nhân viên
      </a>
      <a href="#" class="hover:text-yellow-400">Xem doanh thu</a>
    </nav>
    <div class="flex items-center space-x-4">
      <a href="user.jsp" class="hover:text-yellow-400 hidden md:flex items-center space-x-2">
        <i class="fas fa-user-circle text-lg"></i>
        <%
          nguoiDung thongTinNguoiDung = (nguoiDung) session.getAttribute("nguoiDung");

        %>
        <span><%= thongTinNguoiDung.getTen() %></span>
      </a>
<%--      <a href="#" class="bg-yellow-400 text-blue-900 px-4 py-2 rounded font-bold hover:bg-yellow-300 transition">Thông tin cá nhân</a>--%>
    </div>
  </div>
</header>

</body>
</html>
