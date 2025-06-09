<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%@ page import="DAO.*" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách sân bóng</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="../css/modern-style.css" />
</head>
<body class="modern-bg">

<%@include file="navbar-nhanvien.jsp" %>

<div class="container mx-auto px-4 py-8">
    <!-- Header Section -->
    <div class="text-center mb-8">
        <div class="inline-flex items-center justify-center w-16 h-16 bg-gradient-to-r from-green-500 to-green-600 rounded-full mb-4">
            <i class="fas fa-futbol text-white text-2xl"></i>
        </div>
        <h1 class="text-3xl font-bold text-gray-800 mb-2">Quản lý sân bóng</h1>
        <p class="text-gray-600">Quản lý và theo dõi tất cả sân bóng trong hệ thống</p>
    </div>

    <!-- Stats Cards -->
    <%
        List<sanBong> danhSachSan = SanBongDAO.layDanhSachSanBong();
        int totalFields = danhSachSan != null ? danhSachSan.size() : 0;
        int activeFields = 0;
        int maintenanceFields = 0;
        int field5 = 0;
        int field7 = 0;

        if (danhSachSan != null) {
            for (sanBong san : danhSachSan) {
                if (san.getTrangThai() == trangThaiSan.HOAT_DONG) activeFields++;
                else maintenanceFields++;

                if (san.getKieuSan() == loaiSan.SAN_5) field5++;
                else field7++;
            }
        }
    %>

    <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
        <div class="stats-card">
            <div class="flex items-center justify-between">
                <div>
                    <div class="text-3xl font-bold text-gray-800"><%= totalFields %></div>
                    <div class="text-sm text-gray-600">Tổng số sân</div>
                </div>
                <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center">
                    <i class="fas fa-futbol text-blue-600 text-xl"></i>
                </div>
            </div>
        </div>

        <div class="stats-card">
            <div class="flex items-center justify-between">
                <div>
                    <div class="text-3xl font-bold text-green-600"><%= activeFields %></div>
                    <div class="text-sm text-gray-600">Đang hoạt động</div>
                </div>
                <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center">
                    <i class="fas fa-check-circle text-green-600 text-xl"></i>
                </div>
            </div>
        </div>

        <div class="stats-card">
            <div class="flex items-center justify-between">
                <div>
                    <div class="text-3xl font-bold text-yellow-600"><%= maintenanceFields %></div>
                    <div class="text-sm text-gray-600">Đang bảo trì</div>
                </div>
                <div class="w-12 h-12 bg-yellow-100 rounded-lg flex items-center justify-center">
                    <i class="fas fa-tools text-yellow-600 text-xl"></i>
                </div>
            </div>
        </div>

        <div class="stats-card">
            <div class="flex items-center justify-between">
                <div>
                    <div class="text-lg font-bold text-gray-800"><%= field5 %>/<%= field7 %></div>
                    <div class="text-sm text-gray-600">Sân 5/Sân 7</div>
                </div>
                <div class="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center">
                    <i class="fas fa-layer-group text-purple-600 text-xl"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Action Bar -->
    <div class="modern-card mb-6">
        <div class="flex flex-col sm:flex-row items-center justify-between gap-4">
            <div class="flex items-center space-x-4">
                <h2 class="text-xl font-semibold text-gray-800">
                    <i class="fas fa-list mr-2"></i>Danh sách sân bóng
                </h2>

                <!-- Error Message -->
                <% String error = (String) request.getAttribute("error");
                    if(error == null){
                        error = (String) session.getAttribute("error");
                    }%>
                <% if (error != null) { %>
                <div class="bg-red-50 border-l-4 border-red-400 p-3 rounded">
                    <p class="text-red-700 text-sm"><%= error %></p>
                </div>
                <% } %>
            </div>

            <a href="<%= request.getContextPath() %>/sanBong/taoSanBong" class="btn-primary">
                <i class="fas fa-plus mr-2"></i>Thêm sân bóng
            </a>
        </div>
    </div>

    <!-- Fields Table -->
    <div class="modern-card">
        <%
            if (danhSachSan == null || danhSachSan.isEmpty()) {
        %>
        <div class="text-center py-12">
            <div class="w-24 h-24 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <i class="fas fa-futbol text-gray-400 text-3xl"></i>
            </div>
            <h3 class="text-lg font-medium text-gray-800 mb-2">Chưa có sân bóng nào</h3>
            <p class="text-gray-600 mb-4">Hãy thêm sân bóng đầu tiên để bắt đầu</p>
            <a href="<%= request.getContextPath() %>/sanBong/taoSanBong" class="btn-primary">
                <i class="fas fa-plus mr-2"></i>Thêm sân bóng
            </a>
        </div>
        <%
        } else {
        %>
        <div class="overflow-x-auto">
            <table class="w-full">
                <thead>
                <tr class="border-b border-gray-200">
                    <th class="text-left py-4 px-4 font-semibold text-gray-700">
                        <i class="fas fa-futbol mr-2"></i>Tên sân
                    </th>
                    <th class="text-left py-4 px-4 font-semibold text-gray-700">
                        <i class="fas fa-layer-group mr-2"></i>Loại sân
                    </th>
                    <th class="text-left py-4 px-4 font-semibold text-gray-700">
                        <i class="fas fa-toggle-on mr-2"></i>Trạng thái
                    </th>
                    <th class="text-center py-4 px-4 font-semibold text-gray-700">
                        <i class="fas fa-cogs mr-2"></i>Hành động
                    </th>
                </tr>
                </thead>
                <tbody>
                <%
                    for (sanBong san : danhSachSan) {
                        String statusClass = "";
                        String statusIcon = "";
                        String typeIcon = "";
                        String typeColor = "";

                        if (san.getTrangThai() == trangThaiSan.HOAT_DONG) {
                            statusClass = "bg-green-100 text-green-800";
                            statusIcon = "fas fa-check-circle";
                        } else {
                            statusClass = "bg-yellow-100 text-yellow-800";
                            statusIcon = "fas fa-tools";
                        }

                        if (san.getKieuSan() == loaiSan.SAN_5) {
                            typeIcon = "fas fa-users";
                            typeColor = "text-blue-600";
                        } else {
                            typeIcon = "fas fa-user-friends";
                            typeColor = "text-purple-600";
                        }
                %>
                <tr class="border-b border-gray-100 hover:bg-gray-50 transition-colors">
                    <td class="py-4 px-4">
                        <div class="flex items-center space-x-3">
                            <div class="w-10 h-10 bg-green-100 rounded-lg flex items-center justify-center">
                                <i class="fas fa-futbol text-green-600"></i>
                            </div>
                            <div>
                                <div class="font-medium text-gray-800"><%= san.getTenSan() %></div>
                                <div class="text-sm text-gray-600">ID: <%= san.getId() %></div>
                            </div>
                        </div>
                    </td>
                    <td class="py-4 px-4">
                        <div class="flex items-center space-x-2">
                            <i class="<%= typeIcon %> <%= typeColor %>"></i>
                            <span class="font-medium text-gray-800"><%= san.getKieuSan().name().replace("_", " ") %></span>
                        </div>
                    </td>
                    <td class="py-4 px-4">
            <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium <%= statusClass %>">
              <i class="<%= statusIcon %> mr-1"></i>
              <%= san.getTrangThai() %>
            </span>
                    </td>
                    <td class="py-4 px-4">
                        <div class="flex items-center justify-center space-x-2">
                            <a href="<%= request.getContextPath() %>/sanBong/chinhSuaThongTinSan?id=<%= san.getId() %>"
                               class="btn-action btn-edit" title="Chỉnh sửa">
                                <i class="fas fa-edit"></i> Sửa
                            </a>
                            <form action="<%= request.getContextPath() %>/sanBong/xoaSanBong" method="POST" style="display:inline;">
                                <input type="hidden" name="idSanBong" value="<%= san.getId() %>">
                                <button type="submit" class="btn-action btn-delete" title="Xóa"
                                        onclick="return confirm('Bạn có chắc chắn muốn xoá sân bóng này không?');">
                                    <i class="fas fa-trash"></i> Xoá
                                </button>
                            </form>
                        </div>
                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
        <%
            }
        %>
    </div>
</div>


<!-- Footer -->
<%@include file="footer.jsp" %>




<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Add loading states to action buttons
        const deleteButtons = document.querySelectorAll('.btn-delete');

        deleteButtons.forEach(button => {
            button.addEventListener('click', function(e) {
                if (confirm('Bạn có chắc chắn muốn xoá sân bóng này không?')) {
                    const originalText = this.innerHTML;
                    this.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
                    this.disabled = true;

                    // Re-enable after 3 seconds (in case of error)
                    setTimeout(() => {
                        this.innerHTML = originalText;
                        this.disabled = false;
                    }, 3000);
                } else {
                    e.preventDefault();
                }
            });
        });

        // Add hover effects to table rows
        const tableRows = document.querySelectorAll('tbody tr');
        tableRows.forEach(row => {
            row.addEventListener('mouseenter', function() {
                this.style.transform = 'translateX(4px)';
            });

            row.addEventListener('mouseleave', function() {
                this.style.transform = 'translateX(0)';
            });
        });

        // Auto-hide error messages
        const errorMessages = document.querySelectorAll('.bg-red-50');
        errorMessages.forEach(message => {
            setTimeout(() => {
                message.style.opacity = '0';
                setTimeout(() => {
                    message.remove();
                }, 300);
            }, 5000);
        });
    });
</script>

</body>
</html>
