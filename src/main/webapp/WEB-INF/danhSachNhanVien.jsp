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
    <link rel="stylesheet" href="modern-style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
</head>
<body>
<%--navbar nhan vien--%>
<%@include file="navbar-nhanvien.jsp" %>

<div class="page-header">
    <div class="container">
        <h1 class="page-title">DANH SÁCH NHÂN VIÊN</h1>
        <p class="page-subtitle">Quản lý thông tin nhân viên trong hệ thống</p>
    </div>
</div>

<div class="container" style="max-width: 1200px; margin: 0 auto; padding: 0 2rem;">
    <!-- Stats Cards -->
    <div class="stats-grid fade-in">
        <div class="stats-card">
            <div class="stats-number"><%= danhSachNhanVien.size() %></div>
            <div class="stats-label">Tổng nhân viên</div>
        </div>
    </div>

    <!-- Search and Filter Section -->
    <div class="modern-search slide-up">
        <div style="display: flex; flex-wrap: wrap; gap: 1rem; align-items: center; justify-content: space-between;">
            <div style="flex: 1; min-width: 300px;">
                <input type="text" placeholder="Tìm kiếm theo tên, email, số điện thoại..."
                       class="search-input" id="searchInput">
            </div>
            <a href="<%= request.getContextPath()%>/nguoiDung/taoNhanVien" class="btn-modern btn-secondary">
                <i class="fas fa-plus"></i>Thêm nhân viên mới
            </a>
        </div>
    </div>

    <!-- Employee Table -->
    <div class="modern-table-container slide-up">
        <table class="modern-table">
            <thead>
            <tr>
                <th>
                    <i class="fas fa-user" style="margin-right: 0.5rem;"></i>Thông tin nhân viên
                </th>
                <th>
                    <i class="fas fa-building" style="margin-right: 0.5rem;"></i>Vai trò
                </th>
                <th>
                    <i class="fas fa-phone" style="margin-right: 0.5rem;"></i>Liên hệ
                </th>
                <%
                    if(nd != null && nd.getVaiTroNguoiDung() == vaiTro.QUAN_LY ) {
                %>
                <th style="text-align: center;">
                    <i class="fas fa-cogs" style="margin-right: 0.5rem;"></i>Thao tác
                </th>
                <% } %>
            </tr>
            </thead>
            <tbody id="employeeTableBody">
            <% for (nguoiDung nv : danhSachNhanVien) { %>
            <tr>
                <td>
                    <div class="employee-info">
                        <div class="employee-name" style="font-weight: 600; color: var(--primary-blue);"><%= nv.getTen() %></div>
                    </div>
                </td>
                <td>
                    <div style="font-weight: 600; color: #374151;"><%= nv.getVaiTroNguoiDung() %></div>
                </td>
                <td>
                    <div style="color: #374151;"><%= nv.getEmail() %></div>
                </td>
                <td>
                    <div style="display: flex; gap: 0.5rem; justify-content: center;">
                        <%
                            if(nd != null && (nd.getVaiTroNguoiDung() == vaiTro.QUAN_LY ) ) {
                        %>
                        <a href="<%= request.getContextPath() %>/nguoiDung/chinhSuaThongTinNhanVien?id=<%= nv.getId() %>"
                           class="btn-modern btn-outline" style="padding: 0.5rem 1rem; font-size: 0.8rem;" title="Chỉnh sửa người dùng">
                            <i class="fas fa-eye"></i>
                        </a>

                        <form action="<%=request.getContextPath()%>/nguoiDung/xoaNhanVien?id=<%= nv.getId() %>" method="POST" style="margin: 0;">
                            <button onclick="return confirm('Bạn có chắc chắn muốn xoá nhân viên này không?');"
                                    type="submit"
                                    class="btn-modern"
                                    style="padding: 0.5rem 1rem; font-size: 0.8rem; background: #ef4444; color: white;">
                                <i class="fas fa-trash"></i>
                            </button>
                        </form>
                        <%
                            }
                        %>
                    </div>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

<%--footer--%>
<%@include file="footer.jsp" %>

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
