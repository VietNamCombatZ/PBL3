<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.*" %>
<%
    List<nguoiDung> danhSachNhanVien = (List<nguoiDung>) request.getAttribute("danhSachNhanVien");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách khách hàng</title>
    <link rel="stylesheet" href="css/danhSachNhanVien.css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet" />
</head>
<body>
<%--navbar nhan vien--%>
<%@include file="navbar-nhanvien.jsp" %>

<%--body--%>
<div class="container">
    <h1>Danh sách nhân viên</h1>
    <table>
        <thead>
        <tr>
            <th>Tên</th>
            <th>Email</th>
            <th>Ngày sinh</th>
            <th>Vai trò</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (nguoiDung nd : danhSachNhanVien) {
                if (nd.getVaiTroNguoiDung() == vaiTro.NHAN_VIEN || nd.getVaiTroNguoiDung() == vaiTro.QUAN_LY) {
        %>
        <tr>
            <td><%= nd.getTen() %></td>
            <td><%= nd.getEmail() %></td>
            <td><%= nd.getNgaySinh() %></td>
            <td><%= nd.getVaiTroNguoiDung().toString().replace("_", " ") %></td>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
