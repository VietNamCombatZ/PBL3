<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.datSan, java.text.SimpleDateFormat" %>
<%@ page import="model.sanBong" %>
<%@ page import="DAO.SanBongDAO" %>
<%@ page import="model.nguoiDung" %>
<%@ page import="DAO.DatSanDAO" %>
<%@ page session="true" %>

<%
//    List<datSan> lichDat = (List<datSan>) request.getAttribute("lichDat");
    nguoiDung thongTinNguoiDungDatSan = (nguoiDung) session.getAttribute("nguoiDung");
    if (thongTinNguoiDungDatSan == null) {
        response.sendRedirect("dangNhap.jsp");
        return;
    }
    List<datSan> lichDat = DatSanDAO.timDanhSachDatSanTheoNguoiDung(thongTinNguoiDungDatSan.getId());


    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lịch đặt sân của tôi</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 p-6">

<%--navbar--%>
<%@include file="navbar.jsp" %>

<%--body--%>
<div class="max-w-4xl mx-auto bg-white p-6 rounded shadow">
    <h2 class="text-2xl font-bold mb-4">Lịch đặt sân của tôi</h2>

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
                String idSan = ds.getIdSanBong();
                sanBong sb = SanBongDAO.timSanTheoId(idSan);
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
