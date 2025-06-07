<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.nguoiDung, java.text.SimpleDateFormat" %>
<%@ page session="true" %>
<%
    nguoiDung nd = (nguoiDung) session.getAttribute("nguoiDung");
    if (nd == null) {
        response.sendRedirect(request.getContextPath() + "/nguoiDung/dangNhap");
        return;
    }
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thông Tin Cá Nhân</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
<%@ include file="navbar.jsp" %>

<div class="p-6 max-w-2xl mx-auto mt-4 bg-white shadow-md rounded-lg">
    <h2 class="text-2xl font-bold text-blue-700 mb-6">Thông Tin Cá Nhân</h2>

    <div class="space-y-4 text-gray-800">
        <div>
            <label class="block font-semibold">Họ tên:</label>
            <div class="pl-2"><%= nd.getTen() %></div>
        </div>

        <div>
            <label class="block font-semibold">Email:</label>
            <div class="pl-2"><%= nd.getEmail() %></div>
        </div>

        <div>
            <label class="block font-semibold">Ngày sinh:</label>
            <div class="pl-2"><%= nd.getNgaySinh() != null ? sdf.format(nd.getNgaySinh()) : "Chưa cập nhật" %></div>
        </div>

        <div>
            <label class="block font-semibold">Vai trò:</label>
            <div class="pl-2"><%= nd.getVaiTroNguoiDung().toString().replace("_", " ") %></div>
        </div>
    </div>

    <div class="mt-6 text-right">
        <form action="<%= request.getContextPath() + "/nguoiDung/chinhSuaThongTinCaNhan" %>" method="get">
            <input type="hidden" name="idNguoiDung" value="<%= nd.getId() %>"/>
            <button type="submit"
                    class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 transition">
                Chỉnh sửa
            </button>
        </form>
    </div>
</div>

<%--footer--%>
<%@include file="footer.jsp" %>

</body>
</html>
