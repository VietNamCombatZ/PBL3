<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.text.SimpleDateFormat" %>
<%@ page import="model.*, model.sanBong, DAO.SanBongDAO" %>
<%@ page import="DAO.DanhGiaDAO" %>

<%
//  List<datSan> lichDat = (List<datSan>) request.getAttribute("lichDat");
  SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm");
//  nguoiDung khachHang = (nguoiDung) request.getAttribute("khachHang");

    List<datSan> lichDat = (List<datSan>) session.getAttribute("lichDat");
    nguoiDung khachHang = (nguoiDung) session.getAttribute("khachHang");
    System.out.println("thông tin khách hàng lần1 ở jsp: " + khachHang);
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
        <th class="border px-4 py-2">Thao tác</th>
    </tr>
    </thead>
    <tbody>
    <%
      for (datSan ds : lichDat) {
        sanBong sb = SanBongDAO.timSanTheoId(ds.getIdSanBong());
        if (sb == null) continue;

        boolean coTheHuy = ds.getTrangThai() == trangThaiDatSan.CHO_THANH_TOAN ||
                          ds.getTrangThai() == trangThaiDatSan.DA_HUY;
        boolean coTheThanhToan = ds.getTrangThai() == trangThaiDatSan.CHO_THANH_TOAN;
        danhGia dg = DanhGiaDAO.timDanhGiaTheoDatSan(ds.getId());
    %>
    <tr>
      <td class="border px-4 py-2"><%= sb.getTenSan() %></td>
      <td class="border px-4 py-2"><%= sdf.format(ds.getGioBatDau()) %></td>
      <td class="border px-4 py-2"><%= sdf.format(ds.getGioKetThuc()) %></td>
      <td class="border px-4 py-2"><%= ds.getSoTien() %> VNĐ</td>
      <td class="border px-4 py-2"><%= ds.getTrangThai().toString() %></td>
      <td class="border px-4 py-2">
        <div class="flex space-x-[15px]">

<%--          chỉnh sửa lại chỉ gồm nút Đã thanh Toán, chưa thanh toán, huỷ đặt, xem góp ý--%>
          <% if (dg != null) { // đã đánh giá
           // đã đánh giá

          %>
          <form action="<%= request.getContextPath() %>/danhGia/xemDanhGiaCuaKhachHang" method="get"  class="mt-2">
            <input type="hidden" name="idDatSan" value="<%= ds.getId() %>" />
            <button type="submit" class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded">
                Xem đánh giá
            </button>
          </form>

          <% } %>
        </div>
          <% if (coTheThanhToan) { %>
          <%--        <form action="<%= request.getContextPath() %>/datSan/chinhSuaDatSan" method="get" class="mt-2">--%>
          <%--          <input type="hidden" name="idDatSan" value="<%= ds.getId() %>" />--%>
          <%--          <button type="submit" class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded">--%>
          <%--            Chỉnh sửa lịch đặt--%>
          <%--          </button>--%>
          <%--        </form>--%>

          <form action="<%= request.getContextPath() %>/datSan/thanhToanSan" method="post" onsubmit="return confirm('Bạn có chắc chắn muốn xác nhận thanh toán lịch đặt này không?');" class="mt-2">
              <input type="hidden" name="idDatSan" value="<%= ds.getId() %>" />
              <button type="submit" class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded">
                  Xác nhận thanh toán
              </button>
          </form>
          <% } %>


        <% if (coTheHuy) { %>
<%--        <form action="<%= request.getContextPath() %>/datSan/chinhSuaDatSan" method="get" class="mt-2">--%>
<%--          <input type="hidden" name="idDatSan" value="<%= ds.getId() %>" />--%>
<%--          <button type="submit" class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded">--%>
<%--            Chỉnh sửa lịch đặt--%>
<%--          </button>--%>
<%--        </form>--%>

        <form action="<%= request.getContextPath() %>/datSan/huyDatSanKhachHang" method="post" onsubmit="return confirm('Bạn có chắc chắn muốn hủy lịch đặt này không?');" class="mt-2">
          <input type="hidden" name="idDatSan" value="<%= ds.getId() %>" />
          <button type="submit" class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded">
            Hủy đặt
          </button>
        </form>
        <% } %>
      </td>
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
