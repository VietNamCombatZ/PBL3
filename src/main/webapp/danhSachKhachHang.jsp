<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.*" %>
<%
    List<nguoiDung> danhSach = (List<nguoiDung>) request.getAttribute("danhSachKhachHang");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách khách hàng</title>
    <link rel="stylesheet" href="css/danhSachKhachHang.css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet" />
</head>
<body>
<%--navbar nhan vien--%>
<%@include file="WEB-INF/navbar-nhanvien.jsp" %>

<%--body--%>
<div class="container">
    <h1>Danh sách khách hàng</h1>
    <table>
        <thead>
        <tr>
            <th>Tên</th>
            <th>Email</th>
            <th>Ngày sinh</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (nguoiDung nd : danhSach) {
                if (nd.getVaiTroNguoiDung() == vaiTro.KHACH_HANG) {
        %>
        <tr>
            <td><%= nd.getTen() %></td>
            <td><%= nd.getEmail() %></td>
            <td><%= nd.getNgaySinh() %></td>
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
