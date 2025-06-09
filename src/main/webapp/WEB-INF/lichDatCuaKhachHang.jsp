<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.text.SimpleDateFormat" %>
<%@ page import="model.*, model.sanBong, DAO.SanBongDAO" %>
<%@ page import="DAO.DanhGiaDAO" %>

<%
    List<datSan> lichDat = (List<datSan>) request.getAttribute("lichDat");
    nguoiDung khachHang = (nguoiDung) request.getAttribute("khachHang");
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm");

    if (khachHang == null) {
        throw new IllegalStateException("Không tìm thấy thông tin khách hàng trong phiên làm việc.");
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lịch đặt sân của khách hàng</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="../css/modern-style.css" />
    <style>
        .filter-controls {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            align-items: center;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .filter-group label {
            font-size: 0.875rem;
            font-weight: 600;
            color: var(--primary-blue);
        }

        .filter-select {
            padding: 0.5rem 1rem;
            border: 2px solid #e2e8f0;
            border-radius: var(--border-radius);
            background: white;
            font-size: 0.875rem;
            transition: var(--transition);
        }

        .filter-select:focus {
            outline: none;
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        .sort-header {
            cursor: pointer;
            user-select: none;
            transition: var(--transition);
        }

        .sort-header:hover {
            color: var(--primary-yellow);
        }

        .sort-icon {
            margin-left: 0.25rem;
            transition: transform 0.2s ease;
        }

        .sort-active {
            color: var(--primary-yellow);
        }

        .btn-action {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: var(--border-radius);
            cursor: pointer;
            transition: var(--transition);
            font-size: 0.875rem;
            font-weight: 500;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
            margin-bottom: 0.25rem;
        }

        .btn-view {
            background: var(--gradient-primary);
            color: white;
        }

        .btn-success {
            background: linear-gradient(135deg, #22c55e 0%, #16a34a 100%);
            color: white;
        }

        .btn-danger {
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            color: white;
        }

        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-sm);
        }

        @media (max-width: 768px) {
            .filter-controls {
                flex-direction: column;
                align-items: stretch;
            }
        }
    </style>
</head>
<body class="modern-bg">

<%@include file="navbar-nhanvien.jsp" %>

<div class="page-header">
    <div class="container">
        <h1 class="page-title">
            <i class="fas fa-calendar-alt" style="margin-right: 1rem;"></i>
            Lịch đặt sân của <%= khachHang.getTen() %>
        </h1>
        <p class="page-subtitle">Quản lý và theo dõi tất cả lịch đặt sân của khách hàng</p>
    </div>
</div>

<div class="container" style="max-width: 1200px; margin: 0 auto; padding: 0 2rem;">
    <!-- Customer Info Card -->
    <div class="modern-card fade-in" style="margin-bottom: 2rem;">
        <div style="display: flex; align-items: center; gap: 1rem;">
            <div style="width: 4rem; height: 4rem; background: var(--gradient-primary); border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                <i class="fas fa-user" style="color: white; font-size: 1.5rem;"></i>
            </div>
            <div style="flex: 1;">
                <h3 style="font-size: 1.25rem; font-weight: 600; color: var(--primary-blue); margin-bottom: 0.25rem;"><%= khachHang.getTen() %></h3>
                <p style="color: #64748b;"><%= khachHang.getEmail() %></p>
            </div>
            <div class="modern-alert alert-success" style="margin: 0; padding: 0.5rem 1rem;">
                <i class="fas fa-check-circle" style="margin-right: 0.25rem;"></i>
                Khách hàng
            </div>
        </div>
    </div>

    <!-- Filter and Sort Controls -->
    <div class="modern-search slide-up">
        <div style="display: flex; flex-wrap: wrap; justify-content: space-between; align-items: center; gap: 1rem;">
            <h2 style="font-size: 1.25rem; font-weight: 600; color: var(--primary-blue);">
                <i class="fas fa-list" style="margin-right: 0.5rem;"></i>
                Danh sách lịch đặt (<span id="totalBookings"><%= lichDat != null ? lichDat.size() : 0 %></span>)
            </h2>

            <div class="filter-controls">
                <div class="filter-group">
                    <label>Trạng thái</label>
                    <select id="statusFilter" class="filter-select">
                        <option value="">Tất cả trạng thái</option>
                        <option value="CHO_THANH_TOAN">Chờ thanh toán</option>
                        <option value="DA_THANH_TOAN">Đã thanh toán</option>
                        <option value="DA_HUY">Đã hủy</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label>Loại sân</label>
                    <select id="fieldTypeFilter" class="filter-select">
                        <option value="">Tất cả loại sân</option>
                        <option value="SAN_5">Sân 5</option>
                        <option value="SAN_7">Sân 7</option>
                    </select>
                </div>

                <div class="modern-dropdown">
                    <button class="btn-modern btn-outline" style="padding: 0.5rem 1rem; font-size: 0.875rem;">
                        <i class="fas fa-sort" style="margin-right: 0.5rem;"></i>Sắp xếp
                    </button>
                    <div class="dropdown-content" style="min-width: 220px;">
                        <div style="padding: 0.75rem 1rem; border-bottom: 1px solid rgba(0, 0, 0, 0.1); font-weight: 600; color: var(--primary-blue);">
                            <i class="fas fa-filter" style="margin-right: 0.5rem;"></i>Sắp xếp theo
                        </div>
                        <a href="#" class="sort-option" data-sort="time" data-order="desc">
                            <i class="fas fa-clock" style="margin-right: 0.5rem;"></i>Thời gian (Mới nhất)
                        </a>
                        <a href="#" class="sort-option" data-sort="time" data-order="asc">
                            <i class="fas fa-clock" style="margin-right: 0.5rem;"></i>Thời gian (Cũ nhất)
                        </a>
                        <a href="#" class="sort-option" data-sort="field" data-order="asc">
                            <i class="fas fa-sort-alpha-down" style="margin-right: 0.5rem;"></i>Tên sân (A-Z)
                        </a>
                        <a href="#" class="sort-option" data-sort="field" data-order="desc">
                            <i class="fas fa-sort-alpha-up" style="margin-right: 0.5rem;"></i>Tên sân (Z-A)
                        </a>
                        <a href="#" class="sort-option" data-sort="amount" data-order="desc">
                            <i class="fas fa-sort-amount-down" style="margin-right: 0.5rem;"></i>Số tiền (Cao - Thấp)
                        </a>
                        <a href="#" class="sort-option" data-sort="amount" data-order="asc">
                            <i class="fas fa-sort-amount-up" style="margin-right: 0.5rem;"></i>Số tiền (Thấp - Cao)
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bookings Table -->
    <div class="modern-table-container slide-up">
        <%
            if (lichDat == null || lichDat.isEmpty()) {
        %>
        <div style="text-align: center; padding: 3rem;">
            <div style="width: 6rem; height: 6rem; background: var(--light-blue); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem;">
                <i class="fas fa-calendar-times" style="color: var(--primary-blue); font-size: 2rem;"></i>
            </div>
            <h3 style="font-size: 1.125rem; font-weight: 600; color: var(--primary-blue); margin-bottom: 0.5rem;">Chưa có lịch đặt nào</h3>
            <p style="color: #64748b;">Khách hàng chưa đặt sân nào trong hệ thống</p>
        </div>
        <%
        } else {
        %>
        <table class="modern-table">
            <thead>
            <tr>
                <th class="sort-header" data-sort="field">
                    <div style="display: flex; align-items: center;">
                        <i class="fas fa-futbol" style="margin-right: 0.5rem;"></i>Sân bóng
                        <span class="sort-icon"><i class="fas fa-sort"></i></span>
                    </div>
                </th>
                <th class="sort-header" data-sort="time">
                    <div style="display: flex; align-items: center;">
                        <i class="fas fa-clock" style="margin-right: 0.5rem;"></i>Thời gian
                        <span class="sort-icon"><i class="fas fa-sort"></i></span>
                    </div>
                </th>
                <th class="sort-header" data-sort="amount">
                    <div style="display: flex; align-items: center;">
                        <i class="fas fa-money-bill" style="margin-right: 0.5rem;"></i>Số tiền
                        <span class="sort-icon"><i class="fas fa-sort"></i></span>
                    </div>
                </th>
                <th><i class="fas fa-info-circle" style="margin-right: 0.5rem;"></i>Trạng thái</th>
                <th style="text-align: center;"><i class="fas fa-cogs" style="margin-right: 0.5rem;"></i>Thao tác</th>
            </tr>
            </thead>
            <tbody id="bookingTableBody">
            <%
                for (datSan ds : lichDat) {
                    sanBong sb = SanBongDAO.timSanTheoId(ds.getIdSanBong());
                    if (sb == null) continue;

                    boolean coTheHuy = ds.getTrangThai() == trangThaiDatSan.CHO_THANH_TOAN ;
                    boolean coTheThanhToan = ds.getTrangThai() == trangThaiDatSan.CHO_THANH_TOAN;
                    danhGia dg = DanhGiaDAO.timDanhGiaTheoDatSan(ds.getId());

                    String statusClass = "";
                    String statusIcon = "";
                    switch(ds.getTrangThai()) {
                        case CHO_THANH_TOAN:
                            statusClass = "alert-warning";
                            statusIcon = "fas fa-clock";
                            break;
                        case DA_THANH_TOAN:
                            statusClass = "alert-success";
                            statusIcon = "fas fa-check-circle";
                            break;
                        case DA_HUY:
                            statusClass = "alert-error";
                            statusIcon = "fas fa-times-circle";
                            break;
                        default:
                            statusClass = "alert-info";
                            statusIcon = "fas fa-question-circle";
                    }
            %>
            <tr data-field-name="<%= sb.getTenSan() %>"
                data-field-type="<%= sb.getKieuSan() %>"
                data-status="<%= ds.getTrangThai() %>"
                data-start-time="<%= ds.getGioBatDau().getTime() %>"
                data-amount="<%= ds.getSoTien() %>">
                <td>
                    <div style="display: flex; align-items: center; gap: 0.75rem;">
                        <div style="width: 2.5rem; height: 2.5rem; background: var(--light-blue); border-radius: var(--border-radius); display: flex; align-items: center; justify-content: center;">
                            <i class="fas fa-futbol" style="color: var(--primary-blue);"></i>
                        </div>
                        <div>
                            <div style="font-weight: 600; color: var(--primary-blue);"><%= sb.getTenSan() %></div>
                            <div style="font-size: 0.875rem; color: #64748b;"><%= sb.getKieuSan().name().replace("_", " ") %></div>
                        </div>
                    </div>
                </td>
                <td>
                    <div style="font-size: 0.875rem;">
                        <div style="font-weight: 600; color: #374151; margin-bottom: 0.25rem;">
                            <i class="fas fa-play" style="color: #22c55e; margin-right: 0.25rem;"></i>
                            <%= sdf.format(ds.getGioBatDau()) %>
                        </div>
                        <div style="color: #64748b;">
                            <i class="fas fa-stop" style="color: #ef4444; margin-right: 0.25rem;"></i>
                            <%= sdf.format(ds.getGioKetThuc()) %>
                        </div>
                    </div>
                </td>
                <td>
                    <div style="font-weight: 600; color: var(--primary-blue);">
                        <%= String.format("%,d", ds.getSoTien()) %> VNĐ
                    </div>
                </td>
                <td>
                    <div class="modern-alert <%= statusClass %>" style="display: inline-flex; align-items: center; padding: 0.5rem 0.75rem; margin: 0; font-size: 0.875rem;">
                        <i class="<%= statusIcon %>" style="margin-right: 0.25rem;"></i>
                        <%= ds.getTrangThai().toString() %>
                    </div>
                </td>
                <td>
                    <div style="display: flex; flex-direction: column; gap: 0.5rem; align-items: center;">
                        <% if (dg != null) { %>
                        <form action="<%= request.getContextPath() %>/danhGia/xemDanhGiaCuaKhachHang" method="get" style="margin: 0;">
                            <input type="hidden" name="idDatSan" value="<%= ds.getId() %>" />
                            <button type="submit" class="btn-action btn-view">
                                <i class="fas fa-star"></i>
                                Xem đánh giá
                            </button>
                        </form>
                        <% } %>

                        <% if (coTheThanhToan) { %>
                        <form action="<%= request.getContextPath() %>/datSan/thanhToanSan" method="post"
                              onsubmit="return confirm('Bạn có chắc chắn muốn xác nhận thanh toán lịch đặt này không?');" style="margin: 0;">
                            <input type="hidden" name="idDatSan" value="<%= ds.getId() %>" />
                            <button type="submit" class="btn-action btn-success">
                                <i class="fas fa-credit-card"></i>
                                Xác nhận thanh toán
                            </button>
                        </form>
                        <% } %>

                        <% if (coTheHuy) { %>
                        <form action="<%= request.getContextPath() %>/datSan/huyDatSanKhachHang" method="post"
                              onsubmit="return confirm('Bạn có chắc chắn muốn hủy lịch đặt này không?');" style="margin: 0;">
                            <input type="hidden" name="idDatSan" value="<%= ds.getId() %>" />
                            <button type="submit" class="btn-action btn-danger">
                                <i class="fas fa-times"></i>
                                Hủy đặt
                            </button>
                        </form>
                        <% } %>
                    </div>
                </td>
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

    <!-- Filter Status Indicator -->
    <div id="filterStatus" class="modern-alert alert-info" style="display: none; margin-top: 1rem;">
        <i class="fas fa-filter" style="margin-right: 0.5rem;"></i>
        <span id="filterStatusText">Đang hiển thị tất cả lịch đặt</span>
    </div>
</div>

<%@include file="footer.jsp" %>

<script>
    document.addEventListener('DOMContentLoaded', function() {
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

        // Add hover effects to action buttons
        const actionButtons = document.querySelectorAll('.btn-action');
        actionButtons.forEach(btn => {
            btn.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-2px) scale(1.05)';
            });

            btn.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0) scale(1)';
            });
        });

        // Filtering functionality
        const statusFilter = document.getElementById('statusFilter');
        const fieldTypeFilter = document.getElementById('fieldTypeFilter');
        const totalBookingsSpan = document.getElementById('totalBookings');
        const filterStatus = document.getElementById('filterStatus');
        const filterStatusText = document.getElementById('filterStatusText');

        function applyFilters() {
            const statusValue = statusFilter.value;
            const fieldTypeValue = fieldTypeFilter.value;
            const rows = document.querySelectorAll('#bookingTableBody tr');
            let visibleCount = 0;

            rows.forEach(row => {
                const rowStatus = row.getAttribute('data-status');
                const rowFieldType = row.getAttribute('data-field-type');

                const statusMatch = !statusValue || rowStatus === statusValue;
                const fieldTypeMatch = !fieldTypeValue || rowFieldType === fieldTypeValue;

                if (statusMatch && fieldTypeMatch) {
                    row.style.display = '';
                    visibleCount++;
                } else {
                    row.style.display = 'none';
                }
            });

            totalBookingsSpan.textContent = visibleCount;
            updateFilterStatus(statusValue, fieldTypeValue, visibleCount);
        }

        function updateFilterStatus(status, fieldType, count) {
            let statusText = `Đang hiển thị ${count} lịch đặt`;

            if (status || fieldType) {
                statusText += ' (Đã lọc: ';
                const filters = [];
                if (status) filters.push(`Trạng thái: ${status.replace('_', ' ')}`);
                if (fieldType) filters.push(`Loại sân: ${fieldType.replace('_', ' ')}`);
                statusText += filters.join(', ') + ')';
            }

            filterStatusText.textContent = statusText;

            // Show status with animation
            filterStatus.style.display = 'flex';
            filterStatus.style.opacity = '0';
            filterStatus.style.transform = 'translateY(-10px)';

            setTimeout(() => {
                filterStatus.style.transition = 'all 0.3s ease';
                filterStatus.style.opacity = '1';
                filterStatus.style.transform = 'translateY(0)';

                // Hide after 3 seconds if no filters applied
                if (!status && !fieldType) {
                    setTimeout(() => {
                        filterStatus.style.opacity = '0';
                        filterStatus.style.transform = 'translateY(-10px)';
                        setTimeout(() => {
                            filterStatus.style.display = 'none';
                        }, 300);
                    }, 3000);
                }
            }, 50);
        }

        statusFilter.addEventListener('change', applyFilters);
        fieldTypeFilter.addEventListener('change', applyFilters);

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
            });
        });

        function sortTable(sortBy, sortOrder) {
            const tbody = document.getElementById('bookingTableBody');
            const rows = Array.from(tbody.querySelectorAll('tr'));

            // Store current sort state
            currentSort.column = sortBy;
            currentSort.order = sortOrder;

            // Sort the rows
            rows.sort((a, b) => {
                let valueA, valueB;

                switch(sortBy) {
                    case 'field':
                        valueA = a.getAttribute('data-field-name').toLowerCase();
                        valueB = b.getAttribute('data-field-name').toLowerCase();
                        break;
                    case 'time':
                        valueA = parseInt(a.getAttribute('data-start-time'));
                        valueB = parseInt(b.getAttribute('data-start-time'));
                        break;
                    case 'amount':
                        valueA = parseInt(a.getAttribute('data-amount'));
                        valueB = parseInt(b.getAttribute('data-amount'));
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

        // Add fade-in animation to table rows
        const rows = document.querySelectorAll('tbody tr');
        rows.forEach((row, index) => {
            row.style.opacity = '0';
            row.style.transform = 'translateY(20px)';
            setTimeout(() => {
                row.style.transition = 'all 0.3s ease';
                row.style.opacity = '1';
                row.style.transform = 'translateY(0)';
            }, index * 100);
        });
    });
</script>

</body>
</html>
