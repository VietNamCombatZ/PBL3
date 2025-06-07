<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.*, java.util.*" %>
<%@ page import="DAO.DatSanDAO, DAO.DanhGiaDAO" %>
<%@ page session="true" %>
<%
  String idDatSan = request.getParameter("idDatSan");
  datSan ds = DatSanDAO.timDatSanTheoId(idDatSan);
  danhGia danhGiaHienTai = DanhGiaDAO.timDanhGiaTheoDatSan(idDatSan);

  if (ds == null || danhGiaHienTai == null) {
    response.sendRedirect(request.getContextPath() + "/nguoiDung/lichDatCuaToi");
    return;
  }
%>

<!DOCTYPE html>
<html>
<head>
  <title>Chỉnh Sửa Đánh Giá</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss/dist/tailwind.min.css" rel="stylesheet">
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f3f4f6;
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
      margin-top: 20px;
      transition: background-color 0.3s ease;
    }
    button:hover {
      background-color: #0056b3;
    }
  </style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<h2 class="text-center text-2xl font-bold mt-10">Chỉnh Sửa Đánh Giá</h2>

<form action="<%= request.getContextPath() %>/danhGia/chinhSuaDanhGia" method="post">
  <!-- Hidden fields -->
  <input type="hidden" name="idDatSan" value="<%= ds.getId() %>"/>
  <input type="hidden" name="idSanBong" value="<%= ds.getIdSanBong() %>"/>
  <input type="hidden" name="idDanhGia" value="<%= danhGiaHienTai.getId() %>"/>

  <label for="mucDiem">Chọn mức đánh giá:</label>
  <select name="mucDiem" id="mucDiem" required>
    <%
      for (mucDiem md : mucDiem.values()) {
        String selected = (danhGiaHienTai.getMucDiem().equals(md)) ? "selected" : "";
    %>
    <option value="<%= md.name() %>" <%= selected %>><%= md.name().replace("_", " ") %></option>
    <%
      }
    %>
  </select>

  <label for="noiDung">Nội dung đánh giá:</label>
  <textarea name="noiDung" id="noiDung" maxlength="200" required><%= danhGiaHienTai.getNoiDung() %></textarea>

  <button type="submit">Cập nhật đánh giá</button>

  <!-- Nút xoá đánh giá -->
  <button type="submit" formaction="<%= request.getContextPath() %>/danhGia/xoaDanhGia" formmethod="post"
          onclick="return confirm('Bạn có chắc chắn muốn xoá đánh giá này?');"
          style="background-color: #dc3545; margin-top: 10px;">
    Xoá đánh giá
  </button>
</form>

<%--footer--%>
<%@include file="footer.jsp" %>

</body>
</html>
