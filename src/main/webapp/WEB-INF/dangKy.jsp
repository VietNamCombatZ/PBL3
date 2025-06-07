<%--
  Created by IntelliJ IDEA.
  User: hatsaphonethilavong
  Date: 17/4/2025 AD
  Time: 14:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đăng ký</title>
  <link rel="stylesheet" href="../css/dangKy.css">
</head>
<body>
<div class="overlay">
  <div class="register-form">
    <h2>Đăng ký</h2>
    <%-- Hiển thị thông báo lỗi nếu có --%>
    <% String thongBao = (String) request.getAttribute("thongBao");
      if(thongBao == null){
        thongBao = (String) session.getAttribute("thongBao");
      }%>
    <% if (thongBao != null) { %>
    <p style="color: red;"><%= thongBao %></p>
    <% } %>
    <form action="<%= request.getContextPath()%>/nguoiDung/dangky" method="post">
      <input type="text" name="ten" placeholder="Tên *" required>
      <input type="email" name="email" placeholder="Email *" required>
      <input type="password" name="matkhau" placeholder="Mật khẩu *" required>
      <input type="password" name="nhaplaimatkhau" placeholder="Nhập lại mật khẩu *" required>
      <input type="date" name="ngaysinh" required>
      <button type="submit">Đăng ký</button>
    </form>
  </div>
</div>
</body>
</html>