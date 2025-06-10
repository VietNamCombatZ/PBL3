<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.datSan, java.text.SimpleDateFormat" %>
<%@ page import="model.sanBong" %>
<%@ page import="DAO.*" %>
<%@ page import="model.nguoiDung" %>
<%@ page import="DAO.DatSanDAO" %>
<%@ page import="model.datSan" %>
<%@ page import="model.trangThaiDatSan" %>
<%@ page import="model.*" %>
<%@ page import="controller.BaseController" %>
<%@ page session="true" %>

<%
    String loiDatSan = (String) request.getAttribute("loiDatSan");
    nguoiDung thongTinNguoiDungDatSan = (nguoiDung) session.getAttribute("nguoiDung");
    if (thongTinNguoiDungDatSan == null) {
        response.sendRedirect(request.getContextPath() + "/nguoiDung/dangNhap");
        return;
    }
    List<datSan> lichDat = DatSanDAO.timDanhSachDatSanTheoNguoiDung(thongTinNguoiDungDatSan.getId());
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lịch đặt sân của tôi - Modern</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern-style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        .booking-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        .status-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-pending {
            background: var(--light-yellow);
            color: #92400e;
        }

        .status-confirmed {
            background: #dcfce7;
            color: #166534;
        }

        .status-cancelled {
            background: #fef2f2;
            color: #dc2626;
        }

        .action-buttons {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
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
        }

        .btn-review {
            background: var(--gradient-primary);
            color: white;
        }

        .btn-edit {
            background: var(--gradient-secondary);
            color: var(--dark-blue);
        }

        .btn-cancel {
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            color: white;
        }

        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-sm);
        }

        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-sm);
        }

        .empty-state i {
            font-size: 4rem;
            color: var(--primary-yellow);
            margin-bottom: 1rem;
        }

        .empty-state h3 {
            color: var(--primary-blue);
            margin-bottom: 1rem;
        }

        .empty-state p {
            color: #64748b;
            margin-bottom: 2rem;
        }

        .book-now-btn {
            background: var(--gradient-secondary);
            color: var(--dark-blue);
            padding: 1rem 2rem;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: var(--transition);
            box-shadow: var(--shadow-sm);
        }

        .book-now-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

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

        @media (max-width: 768px) {
            .booking-container {
                padding: 0 1rem;
            }

            .action-buttons {
                flex-direction: column;
            }

            .modern-table {
                font-size: 0.875rem;
            }

            .modern-table th,
            .modern-table td {
                padding: 0.75rem 0.5rem;
            }

            .filter-controls {
                flex-direction: column;
                align-items: stretch;
            }
        }
    </style>
</head>
<body>

<%@include file="navbar.jsp" %>

<div class="page-header">
    <div class="container">
        <h1 class="page-title">LỊCH ĐẶT SÂN CỦA TÔI</h1>
        <p class="page-subtitle">Quản lý và theo dõi các lịch đặt sân của bạn</p>
    </div>
</div>

<div class="booking-container fade-in">
    <%
        if (lichDat == null || lichDat.isEmpty()) {
    %>
    <div class="empty-state slide-up">
        <i class="fas fa-calendar-times"></i>
        <h3>Chưa có lịch đặt nào</h3>
        <p>Bạn chưa đặt sân nào. Hãy bắt đầu đặt sân để tận hưởng trải nghiệm bóng đá tuyệt vời!</p>
        <a href="<%= request.getContextPath() %>/sanBong/danhSachSanCoSan" class="book-now-btn">
            <i class="fas fa-calendar-plus"></i>
            Đặt sân ngay
        </a>
    </div>
    <%
    } else {
    %>

    <% if (loiDatSan != null) { %>
    <div class="modern-alert alert-error">
        <i class="fas fa-exclamation-triangle"></i>
        <strong>Lỗi:</strong> <%= loiDatSan %>
    </div>
    <% } %>

    <!-- Filter and Sort Controls -->
    <div class="modern-search slide-up">
        <div style="display: flex; flex-wrap: wrap; justify-content: space-between; align-items: center; gap: 1rem;">
            <h2 style="font-size: 1.25rem; font-weight: 600; color: var(--primary-blue);">
                <i class="fas fa-list" style="margin-right: 0.5rem;"></i>
                Danh sách lịch đặt (<span id="totalBookings"><%= lichDat.size() %></span>)
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

    <div class="modern-table-container slide-up">
        <table class="modern-table">
            <thead>
            <tr>
                <th class="sort-header" data-sort="field">
                    <div style="display: flex; align-items: center;">
                        <i class="fas fa-futbol" style="margin-right: 0.5rem;"></i>Tên sân
                        <span class="sort-icon"><i class="fas fa-sort"></i></span>
                    </div>
                </th>
                <th class="sort-header" data-sort="time">
                    <div style="display: flex; align-items: center;">
                        <i class="fas fa-clock" style="margin-right: 0.5rem;"></i>Giờ bắt đầu
                        <span class="sort-icon"><i class="fas fa-sort"></i></span>
                    </div>
                </th>
                <th><i class="fas fa-clock" style="margin-right: 0.5rem;"></i>Giờ kết thúc</th>
                <th class="sort-header" data-sort="amount">
                    <div style="display: flex; align-items: center;">
                        <i class="fas fa-money-bill" style="margin-right: 0.5rem;"></i>Số tiền
                        <span class="sort-icon"><i class="fas fa-sort"></i></span>
                    </div>
                </th>
                <th><i class="fas fa-info-circle" style="margin-right: 0.5rem;"></i>Trạng thái</th>
                <th><i class="fas fa-cogs" style="margin-right: 0.5rem;"></i>Thao tác</th>
            </tr>
            </thead>
            <tbody id="bookingTableBody">
            <%
                Date now = new Date();
                for (datSan ds : lichDat) {
                    String idDatSan = ds.getId();
                    String idSan = ds.getIdSanBong();
                    sanBong sb = SanBongDAO.timSanTheoId(idSan);
                    if (sb == null) {
                        continue;
                    }
                    danhGia dg = DanhGiaDAO.timDanhGiaTheoDatSan(idDatSan);

                    Date gioBatDau = ds.getGioBatDau();
                    Date gioKetThuc = ds.getGioKetThuc();

                    long millisToStart = gioBatDau.getTime() - now.getTime();
                    boolean coTheHuy = millisToStart > 3 * 60 * 60 * 1000 && ds.getTrangThai() != trangThaiDatSan.DA_HUY;
                    boolean coTheDanhGia = now.after(gioKetThuc);

                    String statusClass = "";
                    switch (ds.getTrangThai()) {
                        case CHO_THANH_TOAN:
                            statusClass = "status-pending";
                            break;
                        case DA_THANH_TOAN:
                            statusClass = "status-confirmed";
                            break;
                        case DA_HUY:
                            statusClass = "status-cancelled";
                            break;
                    }
            %>
            <tr data-field-name="<%= sb.getTenSan() %>"
                data-field-type="<%= sb.getKieuSan() %>"
                data-status="<%= ds.getTrangThai() %>"
                data-start-time="<%= gioBatDau.getTime() %>"
                data-amount="<%= ds.getSoTien() %>">
                <td>
                    <div style="display: flex; align-items: center; gap: 0.5rem;">
                        <div style="width: 40px; height: 40px; border-radius: 50%; background: var(--gradient-primary); display: flex; align-items: center; justify-content: center; color: white;">
                            <i class="fas fa-futbol"></i>
                        </div>
                        <div>
                            <strong><%= sb.getTenSan() %></strong>
                            <div style="font-size: 0.875rem; color: #64748b;"><%= sb.getKieuSan().toVietnamese() %></div>
                        </div>
                    </div>
                </td>
                <td><%= sdf.format(gioBatDau) %></td>
                <td><%= sdf.format(gioKetThuc) %></td>
                <td>
                    <strong style="color: var(--primary-blue);"><%= String.format("%,d", ds.getSoTien()) %> VNĐ</strong>
                </td>
                <td>
                    <span class="status-badge <%= statusClass %>">
                        <%= ds.getTrangThai().toVietnamese() %>
                    </span>
                </td>
                <td>
                    <div class="action-buttons">
                        <% if (coTheDanhGia) {
                            if (dg == null) {
                        %>
                        <form action="<%= request.getContextPath() %>/danhGia/taoDanhGia" method="get" style="margin: 0;">
                            <input type="hidden" name="idDatSan" value="<%= ds.getId() %>" />
                            <button type="submit" class="btn-action btn-review">
                                <i class="fas fa-star"></i> Đánh giá
                            </button>
                        </form>
                        <% } else { %>
                        <form action="<%= request.getContextPath() %>/danhGia/chinhSuaDanhGia" method="get" style="margin: 0;">
                            <input type="hidden" name="idDatSan" value="<%= ds.getId() %>" />
                            <button type="submit" class="btn-action btn-edit">
                                <i class="fas fa-edit"></i> Sửa đánh giá
                            </button>
                        </form>
                        <% }} %>

                        <% if (coTheHuy) { %>
                        <form action="<%= request.getContextPath() %>/datSan/chinhSuaDatSan" method="get" style="margin: 0;">
                            <input type="hidden" name="idDatSan" value="<%= ds.getId() %>" />
                            <button type="submit" class="btn-action btn-edit">
                                <i class="fas fa-edit"></i> Chỉnh sửa
                            </button>
                        </form>

                        <form action="<%= request.getContextPath() %>/datSan/huyDatSan" method="post"
                              onsubmit="return confirm('Bạn có chắc chắn muốn hủy lịch đặt này không?');" style="margin: 0;">
                            <input type="hidden" name="idDatSan" value="<%= ds.getId() %>" />
                            <button type="submit" class="btn-action btn-cancel">
                                <i class="fas fa-times"></i> Hủy đặt
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
    </div>

    <!-- Filter Status Indicator -->
    <div id="filterStatus" class="modern-alert alert-info" style="display: none; margin-top: 1rem;">
        <i class="fas fa-filter" style="margin-right: 0.5rem;"></i>
        <span id="filterStatusText">Đang hiển thị tất cả lịch đặt</span>
    </div>
    <%
        }
    %>
</div>

<!-- Footer -->
<%@include file="footer.jsp" %>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Animate table rows
        const rows = document.querySelectorAll('tbody tr');
        rows.forEach((row, index) => {
            row.style.opacity = '0';
            row.style.transform = 'translateY(20px)';
            row.style.transition = 'all 0.6s ease-out';

            setTimeout(() => {
                row.style.opacity = '1';
                row.style.transform = 'translateY(0)';
            }, index * 100);
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
    });
</script>
</body>
</html>
