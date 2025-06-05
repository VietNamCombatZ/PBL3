<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.*, java.util.*" %>
<%@ page import="DAO.*, DAO.DanhGiaDAO" %>
<%@ page session="true" %>
<%
    String idDatSan = request.getParameter("idDatSan");
    datSan ds = DatSanDAO.timDatSanTheoId(idDatSan);
    danhGia danhGiaKhachHang = DanhGiaDAO.timDanhGiaTheoDatSan(idDatSan);


    if (ds == null || danhGiaKhachHang == null) {
        response.sendRedirect(request.getContextPath() + "/quanLy/danhSachDatSan");
        return;
    }
    nguoiDung kh = NguoiDungDAO.layNguoiDungTheoId(danhGiaKhachHang.getIdKhachHang());
    sanBong sb = SanBongDAO.timSanTheoId(ds.getIdSanBong());

%>

<!DOCTYPE html>
<html>
<head>
    <title>Đánh Giá Của Khách Hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss/dist/tailwind.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f3f4f6;
        }
        .review-box {
            background-color: #fff;
            max-width: 500px;
            margin: 30px auto;
            padding: 25px 30px;
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .label {
            margin-top: 15px;
            font-weight: bold;
            color: #444;
        }
        .value {
            margin-top: 5px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            background-color: #f9f9f9;
            font-size: 14px;
        }
    </style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<h2 class="text-center text-2xl font-bold mt-10">Đánh Giá Của Khách Hàng</h2>

<div class="review-box">
    <div class="label">Khách hàng:</div>
    <div class="value"><%= kh.getTen() %></div>

    <div class="label">Sân bóng:</div>
    <div class="value"><%= sb.getTenSan() %></div>

    <div class="label">Ngày đặt:</div>
    <div class="value"><%= ds.getGioBatDau() %></div>

    <div class="label">Mức đánh giá:</div>
    <div class="value"><%= danhGiaKhachHang.getMucDiem().name().replace("_", " ") %></div>

    <div class="label">Nội dung đánh giá:</div>
    <div class="value"><%= danhGiaKhachHang.getNoiDung() %></div>

    <div class="label">Ngày đánh giá:</div>
    <div class="value"><%= danhGiaKhachHang.getNgayTao() %></div>
</div>

</body>
</html>
