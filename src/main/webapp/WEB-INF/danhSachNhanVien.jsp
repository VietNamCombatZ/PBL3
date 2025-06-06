<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.*" %>
<%
    List<nguoiDung> danhSachNhanVien = (List<nguoiDung>) request.getAttribute("danhSachNhanVien");
    if(danhSachNhanVien == null) {
        danhSachNhanVien = new ArrayList<>();
    }
    nguoiDung nd = (nguoiDung) session.getAttribute("nguoiDung");
    String vaiTroNguoiDung = nd.getVaiTroNguoiDung().toString();
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách nhân viên</title>
<%--    <link rel="stylesheet" href="css/danhSachNhanVien.css" />--%>
<%--    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet" />--%>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
</head>
<body>
<%--navbar nhan vien--%>
<%@include file="navbar-nhanvien.jsp" %>




<div class="container mx-auto px-6 py-8">
    <!-- Page Title -->
    <h1 class="page-title">DANH SÁCH NHÂN VIÊN</h1>

    <!-- Stats Cards -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
        <div class="stats-card">
            <div class="text-3xl font-bold"><%= danhSachNhanVien.size() %></div>
            <div class="text-sm opacity-90">Tổng nhân viên</div>
        </div>


    </div>

    <!-- Search and Filter Section -->
    <div class="search-container">
        <div class="flex flex-col md:flex-row gap-4 items-center justify-between">
            <div class="flex flex-col md:flex-row gap-4 flex-1">
                <div class="flex-1">
                    <input type="text" placeholder="Tìm kiếm theo tên, email, số điện thoại..."
                           class="search-input w-full" id="searchInput">
                </div>

            </div>
            <button class="add-employee-btn" onclick="addEmployee()">
                <i class="fas fa-plus mr-2"></i>
                Thêm nhân viên mới
            </button>
        </div>
    </div>

    <!-- Employee Table -->
    <div class="table-container">
        <div class="table-inner">
            <table class="w-full">
                <thead class="table-header">
                <tr>
                    <th class="px-6 py-4 text-left">
                        <i class="fas fa-user mr-2"></i>Thông tin nhân viên
                    </th>
                    <th class="px-6 py-4 text-left">
                        <i class="fas fa-building mr-2"></i>Vai trò
                    </th>
                    <th class="px-6 py-4 text-left">
                        <i class="fas fa-phone mr-2"></i>Liên hệ
                    </th>

                    <%
                        if(nd != null && nd.getVaiTroNguoiDung() == vaiTro.QUAN_LY ) {
                    %>
                    <th class="px-6 py-4 text-center">
                        <i class="fas fa-cogs mr-2"></i>Thao tác
                    </th>
                    <% } %>
                </tr>
                </thead>
                <tbody id="employeeTableBody">
                <% for (nguoiDung nv : danhSachNhanVien) { %>
                <tr class="...">
                    <td class="px-6 py-4">
                        <div class="employee-info">
                            <div class="employee-name"><%= nv.getTen() %></div>
                            <div class="employee-id"><%= nv.getId() %></div>
                        </div>
                    </td>
                    <td class="px-6 py-4">
                        <div class="font-semibold text-gray-800"><%= nv.getVaiTroNguoiDung() %></div>
                    </td>
                    <td class="px-6 py-4">
                        <div class="text-gray-800"><%= nv.getEmail() %></div>
                    </td>
                    <td class="px-6 py-4">
                        <div class="flex space-x-2 justify-center">
                            <%
                                if(nd != null && nd.getVaiTroNguoiDung() == vaiTro.QUAN_LY ) {
                                    %>
                            <button class="btn-action btn-view" onclick="viewEmployee('<%= nv.getId() %>')" title="Xem chi tiết">
                                <i class="fas fa-eye"></i>
                            </button>
                            <button class="btn-action btn-edit" onclick="editEmployee('<%= nv.getId() %>')" title="Chỉnh sửa">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="btn-action btn-delete" onclick="deleteEmployee('<%= nv.getId() %>')" title="Xóa">
                                <i class="fas fa-trash"></i>
                            </button>
                            <% } %>
                        </div>
                    </td>
                </tr>
                <% } %>

                </tbody>
            </table>
        </div>
    </div>


</div>

<script>
    document.getElementById("searchInput").addEventListener("input", function () {
        const keyword = this.value.toLowerCase().trim();
        const rows = document.querySelectorAll("#employeeTableBody tr");

        rows.forEach(row => {
            const name = row.querySelector(".employee-name")?.textContent.toLowerCase() || "";
            const vaiTro = row.querySelector("td:nth-child(2)")?.textContent.toLowerCase() || "";
            const email = row.querySelector("td:nth-child(3)")?.textContent.toLowerCase() || "";


            const matched = name.includes(keyword)  || vaiTro.includes(keyword) || email.includes(keyword);

            row.style.display = matched ? "" : "none";
        });
    });
</script>


</body>
</html>
