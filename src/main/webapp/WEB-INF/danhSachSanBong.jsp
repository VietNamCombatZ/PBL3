<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%@ page import="DAO.*" %>

<html>
<head>
    <title>Danh sách sân bóng</title>
    <style>
        table {
            border-collapse: collapse;
            width: 80%;
            margin: 10px auto;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        a.button {
            padding: 6px 12px;
            background-color: #2196F3;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
        a.button:hover {
            background-color: #0b7dda;
        }
        .hoat-dong {
            background-color: #c8e6c9;
            color: #2e7d32;
            font-weight: bold;
        }
        .bao-tri {
            background-color: #fff9c4;
            color: #f57f17;
            font-weight: bold;
        }
        .header-container {
            width: 80%;
            margin: 20px auto 10px auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header-container h2 {
            margin: 0;
        }
    </style>
</head>
<body>
<%@include file="navbar-nhanvien.jsp" %>

<div class="header-container">
    <h2>Danh sách sân bóng</h2>
    <a class="button" href="<%= request.getContextPath() %>/sanBong/taoSanBong">+ Thêm sân bóng</a>
</div>

<table>
    <thead>
    <tr>
        <th>Tên sân</th>
        <th>Trạng thái</th>
        <th>Loại sân</th>
        <th>Hành động</th>
    </tr>
    </thead>
    <tbody>
    <%
        List<sanBong> danhSachSan = SanBongDAO.layDanhSachSanBong();
        if (danhSachSan != null) {
            for (sanBong san : danhSachSan) {
                String trangThaiClass = "";
                if (san.getTrangThai() == trangThaiSan.HOAT_DONG) {
                    trangThaiClass = "hoat-dong";
                } else if (san.getTrangThai() == trangThaiSan.BAO_TRI) {
                    trangThaiClass = "bao-tri";
                }
    %>
    <tr>
        <td><%= san.getTenSan() %></td>
        <td class="<%= trangThaiClass %>"><%= san.getTrangThai() %></td>
        <td><%= san.getKieuSan() %></td>
        <td>
            <a class="btn-edit button"
               href="<%= request.getContextPath() %>/sanBong/chinhSuaThongTinSan?id=<%= san.getId() %>">
                Chỉnh sửa
            </a>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="4">Không có sân bóng nào.</td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>
</body>
</html>
