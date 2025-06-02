<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.*" %>
<%@ page import="DAO.SanBongDAO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<html>
<head>
  <title>Chỉnh sửa lịch đặt sân</title>
</head>
<body>
<%--navbar--%>
<%@include file="navbar.jsp" %>

<%--body--%>

<%
  String error = (String) request.getAttribute("error");
  if (error != null && !error.isEmpty()) {
%>
<p style="color: red;"><%= error %></p>
<%
  }
  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");


  datSan ds = (datSan) request.getAttribute("lichDat");
  if (ds == null) {


      response.sendRedirect(request.getContextPath() + "/nguoiDung/lichDatCuaToi");
      return;

  }
  String gioBatDau = sdf.format(ds.getGioBatDau());
  String gioKetThuc = sdf.format(ds.getGioKetThuc());

  System.out.println("GioBatDau ở trang chinhSuaLichDatCuaToi: " + gioBatDau);
  System.out.println("GioKetThuc ở trang chinhSuaLichDatCuaToi: " + gioKetThuc);



  sanBong sb = SanBongDAO.timSanTheoId(ds.getIdSanBong());
  if(sb == null) {
    response.sendRedirect(request.getContextPath() + "/nguoiDung/lichDatCuaToi");
    return;
  }
  //lấy thông tin sân bóng từ ID trong lịch đặt
  List<sanBong> sanBongCungKieu = (List<sanBong>) request.getAttribute("sanBongCungKieu");

  if (ds == null) {
%>
<p style="color:red;">Không tìm thấy thông tin lịch đặt.</p>
<%
} else {
%>

<form action="<%= request.getContextPath() %>/datSan/capNhatLichDatCuaToi" method="post">
  <input type="hidden" name="idDatSan" value="<%= ds.getId() %>"/>

  <p><strong>Loại sân:</strong> <%= sb.getKieuSan().toString() %></p>

  <label for="idSanBong">Chọn sân (cùng loại):</label>
  <select name="idSanBong" id="idSanBong" required>
    <%
      if (sanBongCungKieu != null) {
        for (sanBong field : sanBongCungKieu) {
          boolean selected = field.getId().equals(sb.getId());
    %>
    <option value="<%= field.getId() %>" <%= selected ? "selected" : "" %>>
      <%= field.getTenSan() %>
    </option>
    <%
        }
      }
    %>
  </select>
  <br/><br/>

  <label for="startTime">Thời gian bắt đầu:</label>
  <input type="datetime-local" name="startTime" id="startTime"
         value="<%= gioBatDau %>" required>
  <br/><br/>

  <label for="endTime">Thời gian kết thúc:</label>
  <input type="datetime-local" name="endTime" id="endTime"
         value="<%= gioKetThuc %>" required>
  <br/><br/>

  <button type="submit">Cập nhật</button>
  <a href="<%= request.getContextPath() %>/datSan/lichDatCaNhan">Hủy</a>
</form>

<%
  }
%>

</body>
</html>
