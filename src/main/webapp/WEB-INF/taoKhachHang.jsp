
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tạo người dùng</title>
    <link rel="stylesheet" href="../css/dangKy.css">
</head>
<body>

<%@ include file="navbar-nhanvien.jsp" %>
<div class="overlay">
    <div class="register-form">
        <% String thongBao = (String) request.getAttribute("thongBao");
            if(thongBao == null){
                thongBao = (String) session.getAttribute("thongBao");
            }%>
        <% if (thongBao != null) { %>
        <p style="color: red;"><%= thongBao %></p>
        <% } %>
        <h2>Tạo người dùng</h2>
        <form action="<%= request.getContextPath()%>/nguoiDung/taoKhachHang" method="post">
            <input type="text" name="ten" placeholder="Tên *" required>
            <input type="email" name="email" placeholder="Email *" required>
            <input type="password" name="matkhau" placeholder="Mật khẩu *" required>
            <input type="password" name="nhaplaimatkhau" placeholder="Nhập lại mật khẩu *" required>
            <input type="date" name="ngaysinh" required>
            <button type="submit">Tạo người dùng</button>
        </form>
    </div>
</div>

<%--footer--%>
<%@include file="footer.jsp" %>
</body>
</html>