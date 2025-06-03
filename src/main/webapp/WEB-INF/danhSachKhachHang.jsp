<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.*" %>
<%
//    List<nguoiDung> danhSach = (List<nguoiDung>) request.getAttribute("danhSachKhachHang");
    List<nguoiDung> danhSachKhachHang = (List<nguoiDung>) request.getAttribute("danhSachKhachHang");
    if(danhSachKhachHang == null) {
        danhSachKhachHang = new ArrayList<>();
    }
    nguoiDung nd = (nguoiDung) session.getAttribute("nguoiDung");
    String vaiTroNguoiDung = nd.getVaiTroNguoiDung().toString();
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách khách hàng</title>
<%--    <link rel="stylesheet" href="../css/danhSachKhachHang.css" />--%>
<%--    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet" />--%>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
</head>
<body>
<%--navbar nhan vien--%>
<%@include file="navbar-nhanvien.jsp" %>

<%--body--%>
<%--<div class="container">--%>
<%--    <h1>Danh sách khách hàng</h1>--%>
<%--    <table>--%>
<%--        <thead>--%>
<%--        <tr>--%>
<%--            <th>Tên</th>--%>
<%--            <th>Email</th>--%>
<%--            <th>Ngày sinh</th>--%>
<%--        </tr>--%>
<%--        </thead>--%>
<%--        <tbody>--%>
<%--        <%--%>
<%--            for (nguoiDung nd : danhSach) {--%>
<%--                if (nd.getVaiTroNguoiDung() == vaiTro.KHACH_HANG) {--%>
<%--        %>--%>
<%--        <tr>--%>
<%--            <td><%= nd.getTen() %></td>--%>
<%--            <td><%= nd.getEmail() %></td>--%>
<%--            <td><%= nd.getNgaySinh() %></td>--%>
<%--        </tr>--%>
<%--        <%--%>
<%--                }--%>
<%--            }--%>
<%--        %>--%>
<%--        </tbody>--%>
<%--    </table>--%>
<%--</div>--%>

<div class="container mx-auto px-6 py-8">
    <!-- Page Title -->
    <h1 class="page-title">DANH SÁCH KHÁCH HÀNG</h1>

    <!-- Stats Cards -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
        <div class="stats-card">
            <div class="text-3xl font-bold"><%= danhSachKhachHang.size() %></div>
            <div class="text-sm opacity-90">Tổng khách hàng</div>
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
<%--            <button class="add-employee-btn" onclick="addEmployee()">--%>
<%--                <i class="fas fa-plus mr-2"></i>--%>
<%--                Thêm khách hàng mới--%>
<%--            </button>--%>

            <a href="<%= request.getContextPath()%>/nguoiDung/taoKhachHang" ><i class="fas fa-plus mr-2"></i>Thêm khách hàng mới</a>
        </div>
    </div>

    <!-- Employee Table -->
    <div class="table-container">
        <div class="table-inner">
            <table class="w-full">
                <thead class="table-header">
                <tr>
                    <th class="px-6 py-4 text-left">
                        <i class="fas fa-user mr-2"></i>Thông tin khách hàng
                    </th>
                    <th class="px-6 py-4 text-left">
                        <i class="fas fa-building mr-2"></i>Ngày tham gia
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
                <% for (nguoiDung kh : danhSachKhachHang) { %>
                <tr class="...">
                    <td class="px-6 py-4">
                        <div class="employee-info">
                            <div class="employee-name"><%= kh.getTen() %></div>
<%--                            <div class="employee-id"><%= kh.getId() %></div>--%>
                        </div>
                    </td>
                    <td class="px-6 py-4">
                        <div class="font-semibold text-gray-800"><%= kh.getNgayTao() %></div>
                    </td>
                    <td class="px-6 py-4">
                        <div class="text-gray-800"><%= kh.getEmail() %></div>
                    </td>
                    <td class="px-6 py-4">
                        <div class="flex space-x-2 justify-center">
                            <%
                                if(nd != null && (nd.getVaiTroNguoiDung() == vaiTro.QUAN_LY || nd.getVaiTroNguoiDung() == vaiTro.NHAN_VIEN) ) {
                            %>
                            <a href="<%= request.getContextPath() %>/datSan/lichDatKhachHang?id=<%= kh.getId() %>"
                               class="btn-action btn-view" title="Xem lịch sử đặt sân">
                                <i class="fas fa-eye"></i>
                            </a>

                            <a href="<%= request.getContextPath() %>/nguoiDung/chinhSuaThongTinKhachHang?id=<%= kh.getId() %>"
                               class="btn-action btn-edit" title="Chỉnh sửa">
                                <i class="fas fa-edit"></i>
                            </a>

                            <a href="<%= request.getContextPath() %>/nguoiDung/xoaKhachHang?id=<%= kh.getId() %>"
                               class="btn-action btn-delete"
                               onclick="return confirm('Bạn có chắc chắn muốn xoá khách hàng này không?');"
                               title="Xóa">
                                <i class="fas fa-trash"></i>
                            </a>
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


</div>
</body>
</html>
