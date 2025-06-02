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
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f3f4f6;
      margin: 0;
      padding: 0;
    }

    h2 {
      text-align: center;
      color: #333;
      margin-top: 40px;
    }

    form {
      background-color: #fff;
      max-width: 500px;
      margin: 30px auto;
      padding: 25px 30px;
      border: 1px solid #ddd;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    label {
      display: block;
      margin-top: 15px;
      font-weight: bold;
      color: #444;
    }

    select, textarea, button {
      width: 100%;
      padding: 10px;
      margin-top: 8px;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 14px;
      box-sizing: border-box;
    }

    textarea {
      height: 120px;
      resize: none;
    }

    button {
      background-color: #007BFF;
      color: white;
      font-weight: bold;
      cursor: pointer;
      transition: background-color 0.3s ease;
      margin-top: 20px;
    }

    button:hover {
      background-color: #0056b3;
    }

    @media (max-width: 600px) {
      form {
        margin: 20px;
        padding: 20px;
      }
    }
  </style>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss/dist/tailwind.min.css" rel="stylesheet">
</head>
<body>
<%@ include file="navbar.jsp" %>


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
