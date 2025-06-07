
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Tạo nhân viên</title>
<%--  <link rel="stylesheet" href="../css/dangKy.css">--%>
  <link rel="stylesheet" href="../css/chinhSuaThongTinCaNhan.css" />
</head>
<body>
<%@ include file="navbar-nhanvien.jsp" %>
  <div class="container">

    <h2>Tạo nhân viên</h2>
    <% String thongBao = (String) request.getAttribute("error");
      if(thongBao == null){
        thongBao = (String) session.getAttribute("error");
      }%>
    <% if (thongBao != null) { %>
    <p style="color: red;"><%= thongBao %></p>
    <% } %>
    <form action="<%= request.getContextPath()%>/nguoiDung/taoNhanVien" method="post">
<%--      tên--%>
      <label for="ten">Tên</label>
      <input type="text" id="ten" name="ten" placeholder="Nhập tên"
              required />
      <div class="error" id="nameError"></div>

<%--      email--%>
      <label for="email">Email</label>
      <input type="text" id="email" name="email" placeholder="Nhập email"
             required />
      <div class="error" id="emailError"></div>

<%--  mật khẩu--%>
      <label for="matKhau">Mật khẩu</label>
      <input type="text" id="matKhau" name="matKhau" placeholder="Nhập mật khẩu"
             required />
      <div class="error" id="matKhauError"></div>

<%--  nhập lại mật khẩu--%>
      <label for="nhapLaiMatKhau">Nhập lại mật khẩu</label>
      <input type="text" id="nhapLaiMatKhau" name="nhapLaiMatKhau" placeholder="Nhập lại mật khẩu"
             required />
      <div class="error" id="nhapLaiMatKhauError"></div>
<%--      <input type="password" name="nhaplaimatkhau" placeholder="Nhập lại mật khẩu *" required>--%>

<%--  ngày sinh--%>
      <label for="ngaySinh">Ngày sinh</label>
      <input type="date" id="ngaySinh" name="ngaySinh"
              required />
      <div class="error" id="ngaySinhError"></div>

<%--  vai trò--%>
      <label for="vaiTro">Vai trò</label>
      <select id="vaiTro" name="vaiTro" required>
        <option value="NHAN_VIEN" >Nhân viên</option>
        <option value="QUAN_LY" >Quản lý</option>
      </select>
      <div class="error" id="vaiTroError"></div>
      <button type="submit">Tạo nhân viên</button>
    </form>
  </div>

  <%--footer--%>
  <%@include file="footer.jsp" %>

</body>
</html>>