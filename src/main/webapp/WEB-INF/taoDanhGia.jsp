<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.mucDiem" %>
<%
  String idSanBong = request.getParameter("idSanBong"); // truyền từ danh sách sân đã đặt
%>
<!DOCTYPE html>
<html>
<head>
  <title>Đánh Giá Sân</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      padding: 20px;
    }
    form {
      max-width: 500px;
      margin: auto;
      padding: 20px;
      border: 1px solid #ccc;
      border-radius: 8px;
    }
    textarea {
      width: 100%;
      height: 100px;
      resize: none;
    }
    select, textarea, button {
      margin-top: 10px;
      display: block;
      width: 100%;
    }
  </style>
</head>
<body>

<h2>Đánh giá sân</h2>

<form action="${pageContext.request.contextPath}/danhGia/luuDanhGia" method="post">
  <!-- ID sân bóng cần đánh giá (ẩn) -->
  <input type="hidden" name="idSanBong" value="<%= idSanBong %>"/>

  <label for="mucDiem">Chọn mức đánh giá:</label>
  <select name="mucDiem" id="mucDiem" required>
    <%
      for (mucDiem md : mucDiem.values()) {
    %>
    <option value="<%= md.name() %>"><%= md.name().replace("_", " ") %></option>
    <%
      }
    %>
  </select>

  <label for="noiDung">Nội dung đánh giá (tối đa 200 ký tự):</label>
  <textarea name="noiDung" id="noiDung" maxlength="200" required placeholder="Nhập cảm nhận của bạn..."></textarea>

  <button type="submit">Gửi đánh giá</button>
</form>

</body>
</html>
