<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.nguoiDung" %>
<%@ page session="true" %>
<%
  nguoiDung nd = (nguoiDung) session.getAttribute("nguoiDung");
  if (nd == null) {
    response.sendRedirect(request.getContextPath() + "/nguoiDung/dangNhap");
    return;
  }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Chỉnh sửa thông tin cá nhân</title>
  <link rel="stylesheet" href="../css/chinhSuaThongTinCaNhan.css" />
</head>
<body>
<div class="container">
  <h1>Chỉnh sửa thông tin cá nhân</h1>
  <form id="editForm" action="<%= request.getContextPath() %>/nguoiDung/chinhSuaThongTinCaNhan" method="post" novalidate>
    <label for="name">Tên</label>
    <input type="text" id="name" name="name" placeholder="Nhập tên"
           value="<%= nd.getTen() != null ? nd.getTen() : "" %>" required />
    <div class="error" id="nameError"></div>

    <label for="email">Email</label>
    <input type="email" id="email" name="email" placeholder="Nhập email"
           value="<%= nd.getEmail() != null ? nd.getEmail() : "" %>" required />
    <div class="error" id="emailError"></div>

    <label for="ngaySinh">Ngày sinh</label>
    <input type="date" id="ngaySinh" name="ngaySinh"
           value="<%= nd.getNgaySinh() != null ? nd.getNgaySinh().toString() : "" %>" required />
    <div class="error" id="ngaySinhError"></div>

    <label for="password">Mật khẩu</label>
    <input type="password" id="password" name="password" placeholder="Nhập mật khẩu mới" />
    <div class="note">Để trống nếu không muốn thay đổi mật khẩu</div>
    <div class="error" id="passwordError"></div>

    <button type="submit">Lưu thay đổi</button>
  </form>
</div>

<script>
  (function(){
    const form = document.getElementById('editForm');
    const nameInput = document.getElementById('name');
    const emailInput = document.getElementById('email');
    const passwordInput = document.getElementById('password');

    const nameError = document.getElementById('nameError');
    const emailError = document.getElementById('emailError');
    const passwordError = document.getElementById('passwordError');

    function validateEmail(email) {
      const re = /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
      return re.test(email);
    }

    form.addEventListener('submit', function(e) {
      nameError.textContent = '';
      emailError.textContent = '';
      passwordError.textContent = '';

      let valid = true;

      if (!nameInput.value.trim()) {
        nameError.textContent = 'Vui lòng nhập tên.';
        valid = false;
      }

      if (!emailInput.value.trim()) {
        emailError.textContent = 'Vui lòng nhập email.';
        valid = false;
      } else if (!validateEmail(emailInput.value.trim())) {
        emailError.textContent = 'Email không hợp lệ.';
        valid = false;
      }

      if (passwordInput.value && passwordInput.value.length < 6) {
        passwordError.textContent = 'Mật khẩu phải có ít nhất 6 ký tự.';
        valid = false;
      }

      if
