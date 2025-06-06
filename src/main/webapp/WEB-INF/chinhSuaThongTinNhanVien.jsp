<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.nguoiDung" %>
<%@ page import="model.*" %>
<%@ page session="true" %>
<%
  nguoiDung nd = (nguoiDung) session.getAttribute("nguoiDung");
  if (nd == null) {
    response.sendRedirect(request.getContextPath() + "/nguoiDung/dangNhap");
    return;
  }

  nguoiDung nhanVien = (nguoiDung) request.getAttribute("nhanVien");
  if (nhanVien == null) {
    response.sendRedirect(request.getContextPath() + "/nguoiDung/DanhsachKhachHang");
    return;
  }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Chỉnh sửa thông tin nhân viên</title>
  <link rel="stylesheet" href="../css/chinhSuaThongTinCaNhan.css" />
</head>
<body>
<div class="container">
  <h1>Chỉnh sửa thông tin nhân viên</h1>
  <form id="editForm" action="<%= request.getContextPath() %>/nguoiDung/chinhSuaThongTinNhanVien?id=<%= nhanVien.getId() %>" method="post" novalidate>
    <label for="name">Tên</label>
    <input type="text" id="name" name="name" placeholder="Nhập tên"
           value="<%= nhanVien.getTen() != null ? nhanVien.getTen() : "" %>" required />
    <div class="error" id="nameError"></div>

    <label for="email">Email</label>
    <input type="email" id="email" name="email" placeholder="Nhập email"
           value="<%= nhanVien.getEmail() != null ? nhanVien.getEmail() : "" %>" required />
    <div class="error" id="emailError"></div>

    <label for="ngaySinh">Ngày sinh</label>
    <input type="date" id="ngaySinh" name="ngaySinh"
           value="<%= nhanVien.getNgaySinh() != null ? nhanVien.getNgaySinh().toString() : "" %>" required />
    <div class="error" id="ngaySinhError"></div>

    <label for="vaiTro">Kiểu sân</label>
    <select id="vaiTro" name="vaiTro" required>
      <option value="NHAN_VIEN" <%= nhanVien.getVaiTroNguoiDung() == vaiTro.NHAN_VIEN ? "selected" : "" %>>Nhân viên</option>
      <option value="QUAN_LY" <%= nhanVien.getVaiTroNguoiDung() == vaiTro.QUAN_LY ? "selected" : "" %>>Quản lý</option>
    </select>
    <div class="error" id="vaiTroError"></div>



    <button type="submit">Lưu thay đổi</button>
  </form>
</div>


