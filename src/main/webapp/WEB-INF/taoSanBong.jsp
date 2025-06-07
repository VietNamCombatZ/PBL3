<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.loaiSan" %>
<%@ page import="model.trangThaiSan" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <title>Thêm sân bóng mới</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/chinhSuaThongTinCaNhan.css" />
</head>
<body>
<%@ include file="navbar-nhanvien.jsp" %>
<div class="container">
  <h1>Thêm sân bóng mới</h1>
  <% String error = (String) request.getAttribute("error"); %>
  <% if (error != null && !error.isEmpty()) { %>
  <div class="error" style="color: red; margin-bottom: 10px;"><%= error %></div>
  <% } %>
  <form action="<%= request.getContextPath() %>/sanBong/taoSanBong" method="post" novalidate>

    <label for="tenSan">Tên sân</label>
    <input type="text" id="tenSan" name="tenSan" placeholder="Nhập tên sân" required />

    <label for="kieuSan">Kiểu sân</label>
    <select id="kieuSan" name="kieuSan" required>
      <%

        loaiSan[] danhSachLoaiSan =  loaiSan.values();
        for (loaiSan loai : danhSachLoaiSan) {
      %>
      <option value="<%= loai.name() %>"><%= loai.name().replace("_", " ") %></option>
      <%
        }
      %>
    </select>

    <label for="trangThai">Trạng thái</label>
    <select id="trangThai" name="trangThai" required>
      <%
        trangThaiSan[] danhSachTrangThai = trangThaiSan.values();
        for (trangThaiSan tts : danhSachTrangThai) {
      %>
      <option value="<%= tts.name() %>"><%= tts.name().replace("_", " ") %></option>
      <%
        }
      %>
    </select>

    <button type="submit">Thêm sân</button>
  </form>
</div>

<%--footer--%>
<%@include file="footer.jsp" %>
</body>
</html>
