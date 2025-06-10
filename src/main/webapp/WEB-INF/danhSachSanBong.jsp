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
    <style>
        .sort-icon {
            display: inline-block;
            margin-left: 0.25rem;
            transition: transform 0.2s ease;
        }
        .sort-active {
            color: var(--primary-yellow);
        }
        .sort-header {
            cursor: pointer;
            user-select: none;
            transition: var(--transition);
        }
        .sort-header:hover {
            color: var(--primary-blue);
        }
        .sort-header:hover .sort-icon {
            color: var(--primary-yellow);
        }
    </style>
</head>
<body class="modern-bg">

<%@include file="navbar-nhanvien.jsp" %>

<div class="page-header">
    <div class="container">
        <h1 class="page-title">
            <i class="fas fa-futbol" style="margin-right: 1rem;"></i>
            Quản lý sân bóng
        </h1>
        <p class="page-subtitle">Quản lý và theo dõi tất cả sân bóng trong hệ thống</p>
    </div>
</div>

<div class="container" style="max-width: 1200px; margin: 0 auto; padding: 0 2rem;">
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

    <div class="stats-grid fade-in">
        <div class="stats-card">
            <div class="stats-number"><%= totalFields %></div>
            <div class="stats-label">Tổng số sân</div>
            <i class="fas fa-futbol" style="position: absolute; top: 1rem; right: 1rem; font-size: 2rem; color: var(--light-blue);"></i>
        </div>

        <div class="stats-card">
            <div class="stats-number" style="color: #22c55e;"><%= activeFields %></div>
            <div class="stats-label">Đang hoạt động</div>
            <i class="fas fa-check-circle" style="position: absolute; top: 1rem; right: 1rem; font-size: 2rem; color: #dcfce7;"></i>
        </div>

        <div class="stats-card">
            <div class="stats-number" style="color: var(--secondary-yellow);"><%= maintenanceFields %></div>
            <div class="stats-label">Đang bảo trì</div>
            <i class="fas fa-tools" style="position: absolute; top: 1rem; right: 1rem; font-size: 2rem; color: var(--light-yellow);"></i>
        </div>

        <div class="stats-card">
            <div class="stats-number"><%= field5 %>/<%= field7 %></div>
            <div class="stats-label">Sân 5/Sân 7</div>
            <i class="fas fa-layer-group" style="position: absolute; top: 1rem; right: 1rem; font-size: 2rem; color: var(--light-blue);"></i>
        </div>
    </div>

    <!-- Action Bar -->
    <div class="modern-search slide-up">
        <div style="display: flex; flex-wrap: wrap; align-items: center; justify-content: space-between; gap: 1rem;">
            <div style="display: flex; align-items: center; gap: 1rem;">
                <h2 style="font-size: 1.25rem; font-weight: 600; color: var(--primary-blue);">
                    <i class="fas fa-list" style="margin-right: 0.5rem;"></i>Danh sách sân bóng
                </h2>

                <!-- Error Message -->
                <% String error = (String) request.getAttribute("error");
                    if(error == null){
                        error = (String) session.getAttribute("error");
                    }%>
                <% if (error != null) { %>
                <div class="modern-alert alert-error">
                    <i class="fas fa-exclamation-triangle" style="margin-right: 0.5rem;"></i>
                    <%= error %>
                </div>
                <% } %>
            </div>

            <!-- Sort Controls -->
            <div class="modern-dropdown">
                <button class="btn-modern btn-outline" style="padding: 0.5rem 1rem; font-size: 0.875rem;">
                    <i class="fas fa-sort" style="margin-right: 0.5rem;"></i>Sắp xếp
                </button>
                <div class="dropdown-content" style="min-width: 220px;">
                    <div style="padding: 0.75rem 1rem; border-bottom: 1px solid rgba(0, 0, 0, 0.1); font-weight: 600; color: var(--primary-blue);">
                        <i class="fas fa-filter" style="margin-right: 0.5rem;"></i>Sắp xếp theo
                    </div>
                    <a href="#" class="sort-option" data-sort="name" data-order="asc">
                        <i class="fas fa-sort-alpha-down" style="margin-right: 0.5rem;"></i>Tên sân (A-Z)
                    </a>
                    <a href="#" class="sort-option" data-sort="name" data-order="desc">
                        <i class="fas fa-sort-alpha-up" style="margin-right: 0.5rem;"></i>Tên sân (Z-A)
                    </a>
                    <a href="#" class="sort-option" data-sort="type" data-order="asc">
                        <i class="fas fa-sort-numeric-down" style="margin-right: 0.5rem;"></i>Loại sân (5-7)
                    </a>
                    <a href="#" class="sort-option" data-sort="type" data-order="desc">
                        <i class="fas fa-sort-numeric-up" style="margin-right: 0.5rem;"></i>Loại sân (7-5)
                    </a>
                    <a href="#" class="sort-option" data-sort="status" data-order="asc">
                        <i class="fas fa-sort" style="margin-right: 0.5rem;"></i>Trạng thái (Hoạt động - Bảo trì)
                    </a>
                    <a href="#" class="sort-option" data-sort="status" data-order="desc">
                        <i class="fas fa-sort" style="margin-right: 0.5rem;"></i>Trạng thái (Bảo trì - Hoạt động)
                    </a>
                </div>
            </div>
            <%
                nguoiDung nd = (nguoiDung) session.getAttribute("nguoiDung");
                if (nd != null && nd.getVaiTroNguoiDung() == vaiTro.QUAN_LY) {
            %>


            <a href="<%= request.getContextPath() %>/sanBong/taoSanBong" class="btn-modern btn-secondary">
                <i class="fas fa-plus"></i>Thêm sân bóng
            </a>
            <%}%>
        </div>
    </div>

    <!-- Fields Table -->
    <div class="modern-table-container slide-up">
        <%
            if (danhSachSan == null || danhSachSan.isEmpty()) {
        %>
        <div style="text-align: center; padding: 3rem;">
            <div style="width: 6rem; height: 6rem; background: var(--light-blue); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem;">
                <i class="fas fa-futbol" style="color: var(--primary-blue); font-size: 2rem;"></i>
            </div>
            <h3 style="font-size: 1.125rem; font-weight: 600; color: var(--primary-blue); margin-bottom: 0.5rem;">Chưa có sân bóng nào</h3>
            <p style="color: #64748b; margin-bottom: 1rem;">Hãy thêm sân bóng đầu tiên để bắt đầu</p>
            <%

                if (nd != null && nd.getVaiTroNguoiDung() == vaiTro.QUAN_LY) {
            %>
            <a href="<%= request.getContextPath() %>/sanBong/taoSanBong" class="btn-modern btn-primary">
                <i class="fas fa-plus"></i>Thêm sân bóng
            </a>
            <%
                }
            %>

        </div>
        <%
        } else {
        %>
        <table class="modern-table">
            <thead>
            <tr>
                <th class="sort-header" data-sort="name">
                    <div style="display: flex; align-items: center;">
                        <i class="fas fa-futbol" style="margin-right: 0.5rem;"></i>Tên sân
                        <span class="sort-icon"><i class="fas fa-sort"></i></span>
                    </div>
                </th>
                <th class="sort-header" data-sort="type">
                    <div style="display: flex; align-items: center;">
                        <i class="fas fa-layer-group" style="margin-right: 0.5rem;"></i>Loại sân
                        <span class="sort-icon"><i class="fas fa-sort"></i></span>
                    </div>
                </th>
                <th class="sort-header" data-sort="status">
                    <div style="display: flex; align-items: center;">
                        <i class="fas fa-toggle-on" style="margin-right: 0.5rem;"></i>Trạng thái
                        <span class="sort-icon"><i class="fas fa-sort"></i></span>
                    </div>
                </th>
                <%

                    if (nd != null && nd.getVaiTroNguoiDung() == vaiTro.QUAN_LY) {
                %>
                <th style="text-align: center;">
                    <i class="fas fa-cogs" style="margin-right: 0.5rem;"></i>Hành động
                </th>
                <%}%>
            </tr>
            </thead>
            <tbody id="fieldTableBody">
            <%
                for (sanBong san : danhSachSan) {
                    String statusClass = "";
                    String statusIcon = "";
                    String typeIcon = "";
                    String typeColor = "";
                    String statusText = "";
                    String typeText = "";

                    if (san.getTrangThai() == trangThaiSan.HOAT_DONG) {
                        statusClass = "alert-success";
                        statusIcon = "fas fa-check-circle";
                        statusText = "HOẠT ĐỘNG";
                    } else {
                        statusClass = "alert-warning";
                        statusIcon = "fas fa-tools";
                        statusText = "BẢO TRÌ";
                    }

                    if (san.getKieuSan() == loaiSan.SAN_5) {
                        typeIcon = "fas fa-users";
                        typeColor = "color: var(--primary-blue);";
                        typeText = "SÂN 5";
                    } else {
                        typeIcon = "fas fa-user-friends";
                        typeColor = "color: var(--secondary-yellow);";
                        typeText = "SÂN 7";
                    }
            %>
            <tr data-name="<%= san.getTenSan() %>"
                data-type="<%= san.getKieuSan() == loaiSan.SAN_5 ? "5" : "7" %>"
                data-status="<%= san.getTrangThai() == trangThaiSan.HOAT_DONG ? "1" : "0" %>">
                <td>
                    <div style="display: flex; align-items: center; gap: 0.75rem;">
                        <div style="width: 2.5rem; height: 2.5rem; background: var(--light-blue); border-radius: var(--border-radius); display: flex; align-items: center; justify-content: center;">
                            <i class="fas fa-futbol" style="color: var(--primary-blue);"></i>
                        </div>
                        <div>
                            <div style="font-weight: 600; color: var(--primary-blue);"><%= san.getTenSan() %></div>
                            <div style="font-size: 0.875rem; color: #64748b;">ID: <%= san.getId() %></div>
                        </div>
                    </div>
                </td>
                <td>
                    <div style="display: flex; align-items: center; gap: 0.5rem;">
                        <i class="<%= typeIcon %>" style="<%= typeColor %>"></i>
                        <span style="font-weight: 500; color: #374151;"><%= typeText %></span>
                    </div>
                </td>
                <td>
                    <div class="modern-alert <%= statusClass %>" style="display: inline-flex; align-items: center; padding: 0.5rem 0.75rem; margin: 0; font-size: 0.875rem;">
                        <i class="<%= statusIcon %>" style="margin-right: 0.25rem;"></i>
                        <%= statusText %>
                    </div>
                </td>

                <%
                    if (nd != null && nd.getVaiTroNguoiDung() == vaiTro.QUAN_LY) {
                %>
                <td>
                    <div style="display: flex; align-items: center; justify-content: center; gap: 0.5rem;">
                        <a href="<%= request.getContextPath() %>/sanBong/chinhSuaThongTinSan?id=<%= san.getId() %>"
                           class="btn-modern btn-outline"
                           style="padding: 0.5rem 1rem; font-size: 0.875rem;"
                           title="Chỉnh sửa">
                            <i class="fas fa-edit"></i>
                            Sửa
                        </a>
                        <form action="<%= request.getContextPath() %>/sanBong/xoaSanBong" method="POST" style="margin: 0;">
                            <input type="hidden" name="idSanBong" value="<%= san.getId() %>">
                            <button type="submit"
                                    class="btn-modern"
                                    style="padding: 0.5rem 1rem; font-size: 0.875rem; background: #ef4444; color: white; border: 2px solid #ef4444;"
                                    title="Xóa"
                                    onclick="return confirm('Bạn có chắc chắn muốn xoá sân bóng này không?');">
                                <i class="fas fa-trash"></i>
                                Xoá
                            </button>
                        </form>
                    </div>
                </td>
                <%}%>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
        <%
            }
        %>
    </div>

    <!-- Sort Status Indicator -->
    <div id="sortStatus" class="modern-alert alert-info" style="display: none; margin-top: 1rem;">
        <i class="fas fa-info-circle" style="margin-right: 0.5rem;"></i>
        <span id="sortStatusText">Đang sắp xếp theo tên sân (A-Z)</span>
    </div>
</div>

<!-- Footer -->
<%@include file="footer.jsp" %>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Add loading states to action buttons
        const deleteButtons = document.querySelectorAll('button[style*="background: #ef4444"]');

        deleteButtons.forEach(button => {
            button.addEventListener('click', function(e) {
                if (confirm('Bạn có chắc chắn muốn xoá sân bóng này không?')) {
                    const originalText = this.innerHTML;
                    this.innerHTML = '<div class="loading"></div>';
                    this.disabled = true;
                    this.style.opacity = '0.7';

                    // Re-enable after 3 seconds (in case of error)
                    setTimeout(() => {
                        this.innerHTML = originalText;
                        this.disabled = false;
                        this.style.opacity = '1';
                    }, 3000);
                } else {
                    e.preventDefault();
                }
            });
        });

        // Add hover effects to edit buttons
        const editButtons = document.querySelectorAll('.btn-outline');
        editButtons.forEach(button => {
            button.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-2px)';
                this.style.boxShadow = 'var(--shadow-md)';
            });

            button.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
                this.style.boxShadow = 'var(--shadow-sm)';
            });
        });

        // Auto-hide error messages
        const errorMessages = document.querySelectorAll('.alert-error');
        errorMessages.forEach(message => {
            setTimeout(() => {
                message.style.opacity = '0';
                message.style.transform = 'translateY(-10px)';
                setTimeout(() => {
                    message.remove();
                }, 300);
            }, 5000);
        });

        // Add fade-in animation to table rows
        const tableRows = document.querySelectorAll('tbody tr');
        tableRows.forEach((row, index) => {
            row.style.opacity = '0';
            row.style.transform = 'translateY(20px)';
            setTimeout(() => {
                row.style.transition = 'all 0.3s ease';
                row.style.opacity = '1';
                row.style.transform = 'translateY(0)';
            }, index * 100);
        });

        // Sorting functionality
        let currentSort = {
            column: null,
            order: null
        };

        // Sort options from dropdown
        const sortOptions = document.querySelectorAll('.sort-option');
        sortOptions.forEach(option => {
            option.addEventListener('click', function(e) {
                e.preventDefault();
                const sortBy = this.getAttribute('data-sort');
                const sortOrder = this.getAttribute('data-order');

                sortTable(sortBy, sortOrder);

                // Update active sort in dropdown
                sortOptions.forEach(opt => opt.classList.remove('sort-active'));
                this.classList.add('sort-active');

                // Update sort status indicator
                updateSortStatus(sortBy, sortOrder);
            });
        });

        // Sort headers
        const sortHeaders = document.querySelectorAll('.sort-header');
        sortHeaders.forEach(header => {
            header.addEventListener('click', function() {
                const sortBy = this.getAttribute('data-sort');
                let sortOrder = 'asc';

                // Toggle sort order if clicking the same column
                if (currentSort.column === sortBy) {
                    sortOrder = currentSort.order === 'asc' ? 'desc' : 'asc';
                }

                sortTable(sortBy, sortOrder);

                // Update sort icons
                sortHeaders.forEach(h => {
                    const icon = h.querySelector('.sort-icon');
                    if (h === this) {
                        icon.innerHTML = sortOrder === 'asc'
                            ? '<i class="fas fa-sort-up sort-active"></i>'
                            : '<i class="fas fa-sort-down sort-active"></i>';
                    } else {
                        icon.innerHTML = '<i class="fas fa-sort"></i>';
                    }
                });

                // Update sort status indicator
                updateSortStatus(sortBy, sortOrder);
            });
        });

        function sortTable(sortBy, sortOrder) {
            const tbody = document.getElementById('fieldTableBody');
            const rows = Array.from(tbody.querySelectorAll('tr'));

            // Store current sort state
            currentSort.column = sortBy;
            currentSort.order = sortOrder;

            // Sort the rows
            rows.sort((a, b) => {
                let valueA, valueB;

                switch(sortBy) {
                    case 'name':
                        valueA = a.getAttribute('data-name').toLowerCase();
                        valueB = b.getAttribute('data-name').toLowerCase();
                        break;
                    case 'type':
                        valueA = parseInt(a.getAttribute('data-type'));
                        valueB = parseInt(b.getAttribute('data-type'));
                        break;
                    case 'status':
                        valueA = parseInt(a.getAttribute('data-status'));
                        valueB = parseInt(b.getAttribute('data-status'));
                        break;
                    default:
                        return 0;
                }

                // Compare values
                if (typeof valueA === 'string') {
                    return sortOrder === 'asc'
                        ? valueA.localeCompare(valueB)
                        : valueB.localeCompare(valueA);
                } else {
                    return sortOrder === 'asc'
                        ? valueA - valueB
                        : valueB - valueA;
                }
            });

            // Reorder the DOM
            rows.forEach(row => {
                row.style.opacity = '0';
                row.style.transform = 'translateY(10px)';
                tbody.appendChild(row);
            });

            // Animate rows back in
            setTimeout(() => {
                rows.forEach((row, index) => {
                    setTimeout(() => {
                        row.style.transition = 'all 0.3s ease';
                        row.style.opacity = '1';
                        row.style.transform = 'translateY(0)';
                    }, index * 50);
                });
            }, 50);
        }

        function updateSortStatus(sortBy, sortOrder) {
            const statusElement = document.getElementById('sortStatus');
            const statusTextElement = document.getElementById('sortStatusText');
            let statusText = 'Đang sắp xếp theo ';

            switch(sortBy) {
                case 'name':
                    statusText += 'tên sân ';
                    statusText += sortOrder === 'asc' ? '(A-Z)' : '(Z-A)';
                    break;
                case 'type':
                    statusText += 'loại sân ';
                    statusText += sortOrder === 'asc' ? '(5-7)' : '(7-5)';
                    break;
                case 'status':
                    statusText += 'trạng thái ';
                    statusText += sortOrder === 'asc' ? '(Hoạt động - Bảo trì)' : '(Bảo trì - Hoạt động)';
                    break;
            }

            statusTextElement.textContent = statusText;

            // Show status with animation
            statusElement.style.display = 'flex';
            statusElement.style.opacity = '0';
            statusElement.style.transform = 'translateY(-10px)';

            setTimeout(() => {
                statusElement.style.transition = 'all 0.3s ease';
                statusElement.style.opacity = '1';
                statusElement.style.transform = 'translateY(0)';

                // Hide after 3 seconds
                setTimeout(() => {
                    statusElement.style.opacity = '0';
                    statusElement.style.transform = 'translateY(-10px)';
                    setTimeout(() => {
                        statusElement.style.display = 'none';
                    }, 300);
                }, 3000);
            }, 50);
        }
    });
</script>

</body>
</html>
