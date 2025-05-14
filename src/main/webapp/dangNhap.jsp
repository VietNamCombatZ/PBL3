<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Đăng nhập</title>
  <link rel="stylesheet" href="./css/dangNhap.css">
  <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
</head>
<body>
<div class="login-container">
  <h2>Đăng nhập</h2>

  <%-- Hiển thị thông báo lỗi nếu có --%>
  <% String thongBao = (String) request.getAttribute("thongBao"); %>
  <% if (thongBao != null) { %>
  <p style="color: red;"><%= thongBao %></p>
  <% } %>

  <form action="dangnhap" method="post">
    <input type="email" name="email" placeholder="Email" required>
    <input type="password" name="matKhau" placeholder="Mật khẩu" required>
    <button type="submit">Đăng nhập</button>
  </form>

  <a href="#">Quên mật khẩu?</a>

  <div class="social-buttons">
    <button class="facebook">Facebook</button>
    <button class="google">Google</button>
  </div>
</div>
</body>
</html>