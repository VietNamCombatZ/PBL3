<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.nguoiDung" %>
<%@ page session="true" %>
<%
  nguoiDung nd = (nguoiDung) session.getAttribute("nguoiDung");
  if (nd == null) {
    response.sendRedirect(request.getContextPath() + "/nguoiDung/dangNhap");
    return;
  }

  nguoiDung khachHang = (nguoiDung) request.getAttribute("khachHang");
    if (khachHang == null) {
      response.sendRedirect(request.getContextPath() + "/nguoiDung/DanhsachKhachHang");
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

<%@ include file="navbar-nhanvien.jsp" %>
<div class="container">
  <h1>Chỉnh sửa thông tin cá nhân</h1>
  <form id="editForm" action="<%= request.getContextPath() %>/nguoiDung/chinhSuaThongTinKhachHang?id=<%= khachHang.getId() %>" method="post" novalidate>
    <label for="name">Tên</label>
    <input type="text" id="name" name="name" placeholder="Nhập tên"
           value="<%= khachHang.getTen() != null ? khachHang.getTen() : "" %>" required />
    <div class="error" id="nameError"></div>

    <label for="email">Email</label>
    <input type="email" id="email" name="email" placeholder="Nhập email"
           value="<%= khachHang.getEmail() != null ? khachHang.getEmail() : "" %>" required />
    <div class="error" id="emailError"></div>

    <label for="ngaySinh">Ngày sinh</label>
    <input type="date" id="ngaySinh" name="ngaySinh"
           value="<%= khachHang.getNgaySinh() != null ? khachHang.getNgaySinh().toString() : "" %>" required />
    <div class="error" id="ngaySinhError"></div>

    <label for="password">Mật khẩu</label>
    <input type="password" id="password" name="password" placeholder="Nhập mật khẩu mới" />
    <div class="note">Để trống nếu không muốn thay đổi mật khẩu</div>
    <div class="error" id="passwordError"></div>

    <button type="submit">Lưu thay đổi</button>
  </form>
</div>

<%--footer--%>
<%@include file="footer.jsp" %>
</body>
</html>
