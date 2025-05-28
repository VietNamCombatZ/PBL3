<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.text.SimpleDateFormat" %>
<%@ page import="model.datSan, model.sanBong, DAO.SanBongDAO" %>

<%
  List<datSan> lichDat = (List<datSan>) request.getAttribute("lichDat");
  SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm");
  nguoiDung khachHang = (nguoiDung) request.getAttribute("khachHang");
    if (khachHang == null) {
        throw new IllegalStateException("Không tìm thấy thông tin khách hàng trong phiên làm việc.");
    }
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Lịch đặt sân của tôi</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">

<%@include file="navbar-nhanvien.jsp" %>

<div class="max-w-4xl mx-auto bg-white p-6 rounded shadow">
  <h2 class="text-2xl font-bold mb-4">Lịch đặt sân của <%= khachHang.getTen() %></h2>

  <%
    if (lichDat == null || lichDat.isEmpty()) {
  %>
  <p>Không có lịch đặt nào.</p>
  <%
  } else {
  %>
  <table class="w-full border border-collapse">
    <thead>
    <tr class="bg-gray-200">
      <th class="border px-4 py-2">Tên sân</th>
      <th class="border px-4 py-2">Giờ bắt đầu</th>
      <th class="border px-4 py-2">Giờ kết thúc</th>
      <th class="border px-4 py-2">Số tiền</th>
      <th class="border px-4 py-2">Trạng thái</th>
    </tr>
    </thead>
    <tbody>
    <%
      for (datSan ds : lichDat) {
        sanBong sb = SanBongDAO.timSanTheoId(ds.getIdSanBong());
        if (sb == null) continue;
    %>
    <tr>
      <td class="border px-4 py-2"><%= sb.getTenSan() %></td>
      <td class="border px-4 py-2"><%= sdf.format(ds.getGioBatDau()) %></td>
      <td class="border px-4 py-2"><%= sdf.format(ds.getGioKetThuc()) %></td>
      <td class="border px-4 py-2"><%= ds.getSoTien() %> VNĐ</td>
      <td class="border px-4 py-2"><%= ds.getTrangThai().toString() %></td>
    </tr>
    <%
      }
    %>
    </tbody>
  </table>
  <%
    }
  %>
</div>
</body>
</html>
