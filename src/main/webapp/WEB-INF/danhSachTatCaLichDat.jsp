<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.text.SimpleDateFormat" %>
<%@ page import="model.*, model.sanBong, DAO.SanBongDAO, DAO.DanhGiaDAO" %>
<%@ page import="DAO.*" %>

<%
  SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm");
  List<datSan> lichDat = DatSanDAO.timDanhSachDatSan();
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Danh sách tất cả lịch đặt sân</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">

<%@include file="navbar-nhanvien.jsp" %>

<div class="max-w-6xl mx-auto bg-white p-6 rounded shadow">
  <h2 class="text-2xl font-bold mb-4">Danh sách tất cả lịch đặt sân</h2>

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
      <th class="border px-4 py-2">Khách hàng</th>
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
        nguoiDung kh = NguoiDungDAO.layNguoiDungTheoId(ds.getIdKhachHang()); // Phải gán ở servlet
        sanBong sb = SanBongDAO.timSanTheoId(ds.getIdSanBong());
        if (kh == null || sb == null) continue;

        boolean coTheHuy = ds.getTrangThai() == trangThaiDatSan.CHO_THANH_TOAN || ds.getTrangThai() == trangThaiDatSan.DA_HUY;
        boolean coTheThanhToan = ds.getTrangThai() == trangThaiDatSan.CHO_THANH_TOAN;
        danhGia dg = DanhGiaDAO.timDanhGiaTheoDatSan(ds.getId());
    %>
    <tr>
      <td class="border px-4 py-2"><%= kh.getTen() %></td>
      <td class="border px-4 py-2"><%= sb.getTenSan() %></td>
      <td class="border px-4 py-2"><%= sdf.format(ds.getGioBatDau()) %></td>
      <td class="border px-4 py-2"><%= sdf.format(ds.getGioKetThuc()) %></td>
      <td class="border px-4 py-2"><%= ds.getSoTien() %> VNĐ</td>
      <td class="border px-4 py-2"><%= ds.getTrangThai().toString() %></td>
      <td class="border px-4 py-2">
        <div class="flex flex-col space-y-2">
          <% if (dg != null) { %>
          <form action="<%= request.getContextPath() %>/danhGia/xemDanhGiaCuaKhachHang" method="get">
            <input type="hidden" name="idDatSan" value="<%= ds.getId() %>" />
            <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white px-3 py-1 rounded">
              Xem đánh giá
            </button>
          </form>
          <% } %>

          <% if (coTheThanhToan) { %>
          <form action="<%= request.getContextPath() %>/datSan/thanhToanSan" method="post" onsubmit="return confirm('Xác nhận thanh toán lịch đặt này?');">
            <input type="hidden" name="idDatSan" value="<%= ds.getId() %>" />
            <button type="submit" class="bg-green-500 hover:bg-green-600 text-white px-3 py-1 rounded">
              Xác nhận thanh toán
            </button>
          </form>
          <% } %>

          <% if (coTheHuy) { %>
          <form action="<%= request.getContextPath() %>/datSan/huyDatSanNhanVien" method="post" onsubmit="return confirm('Bạn có chắc muốn hủy lịch đặt này không?');">
            <input type="hidden" name="idDatSan" value="<%= ds.getId() %>" />
            <button type="submit" class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded">
              Hủy đặt
            </button>
          </form>
          <% } %>
        </div>
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


<%--footer--%>
<%@include file="footer.jsp" %>

</body>
</html>
