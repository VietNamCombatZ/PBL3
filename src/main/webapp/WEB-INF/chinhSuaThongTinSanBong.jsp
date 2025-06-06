<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.sanBong" %>
<%@ page import="model.trangThaiSan" %>
<%@ page import="model.loaiSan" %>
<%@ page import="DAO.SanBongDAO" %>
<%@ page session="true" %>
<%

  String idSanBong = request.getParameter("id");
  System.out.println("ID Sân Bóng: " + idSanBong);
  sanBong san = SanBongDAO.timSanTheoId(idSanBong);
  if (san == null) {
    response.sendRedirect(request.getContextPath() + "/sanBong/danhSachSan");
    return;
  }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Chỉnh sửa thông tin sân bóng</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/chinhSuaThongTinCaNhan.css" />
</head>
<body>
<div class="container">
  <h1>Chỉnh sửa thông tin sân bóng</h1>
  <%-- Hiển thị thông báo lỗi nếu có --%>
  <% String thongBao = (String) request.getAttribute("thongBao");
    if(thongBao == null){
      thongBao = (String) session.getAttribute("thongBao");
    }%>
  <% if (thongBao != null) { %>
  <p style="color: red;"><%= thongBao %></p>
  <% } %>
  <form id="editForm"
        action="<%= request.getContextPath() %>/sanBong/chinhSuaThongTinSan?id=<%= san.getId() %>"
        method="post" novalidate>
    <label for="tenSan">Tên sân</label>
    <input type="text" id="tenSan" name="tenSan" placeholder="Nhập tên sân"
           value="<%= san.getTenSan() != null ? san.getTenSan() : "" %>" required />
    <div class="error" id="tenSanError"></div>

    <label for="kieuSan">Kiểu sân</label>
    <select id="kieuSan" name="kieuSan" required>
      <option value="SAN_5" <%= san.getKieuSan() == loaiSan.SAN_5 ? "selected" : "" %>>Sân 5</option>
      <option value="SAN_7" <%= san.getKieuSan() == loaiSan.SAN_7 ? "selected" : "" %>>Sân 7</option>
    </select>
    <div class="error" id="kieuSanError"></div>

    <label for="trangThai">Trạng thái</label>
    <select id="trangThai" name="trangThai" required>
      <option value="HOAT_DONG" <%= san.getTrangThai() == trangThaiSan.HOAT_DONG ? "selected" : "" %>>Hoạt động</option>
      <option value="BAO_TRI" <%= san.getTrangThai() == trangThaiSan.BAO_TRI ? "selected" : "" %>>Bảo trì</option>
    </select>
    <div class="error" id="trangThaiError"></div>

    <button type="submit">Lưu thay đổi</button>
  </form>
</div>
</body>
</html>
