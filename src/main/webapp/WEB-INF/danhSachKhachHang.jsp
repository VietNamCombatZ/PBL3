<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.*" %>
<%
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
    <title>Danh sách khách hàng - Modern</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern-style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        .page-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }

        .action-buttons {
            display: flex;
            gap: 0.5rem;
            justify-content: center;
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

        .btn-view {
            background: var(--gradient-primary);
            color: white;
        }

        .btn-view:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-sm);
        }

        .btn-delete {
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            color: white;
        }

        .btn-delete:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-sm);
        }

        .add-customer-btn {
            background: var(--gradient-secondary);
            color: var(--dark-blue);
            padding: 1rem 1.5rem;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: var(--transition);
            box-shadow: var(--shadow-sm);
        }

        .add-customer-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .search-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            gap: 1rem;
        }

        .customer-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--gradient-primary);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            margin-right: 1rem;
        }

        .customer-info {
            display: flex;
            align-items: center;
        }

        .customer-details h4 {
            margin: 0;
            color: var(--primary-blue);
            font-weight: 600;
        }

        .customer-details p {
            margin: 0;
            color: #64748b;
            font-size: 0.875rem;
        }

        @media (max-width: 768px) {
            .search-section {
                flex-direction: column;
                align-items: stretch;
            }

            .action-buttons {
                flex-direction: column;
            }

            .customer-info {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.5rem;
            }
        }
    </style>
</head>
<body>
<%--navbar nhan vien--%>
<%@include file="navbar-nhanvien.jsp" %>

<div class="page-container fade-in">
    <!-- Page Header -->
    <div class="page-header">
        <h1 class="page-title">DANH SÁCH KHÁCH HÀNG</h1>
        <p class="page-subtitle">Quản lý thông tin khách hàng một cách hiệu quả</p>
    </div>

    <!-- Stats Cards -->
    <div class="stats-grid">
        <div class="stats-card">
            <div class="stats-number"><%= danhSachKhachHang.size() %></div>
            <div class="stats-label">Tổng khách hàng</div>
        </div>
        <div class="stats-card">
            <div class="stats-number">
                <%= danhSachKhachHang.stream().mapToInt(kh -> 1).sum() %>
            </div>
            <div class="stats-label">Khách hàng hoạt động</div>
        </div>
        <div class="stats-card">
            <div class="stats-number">95%</div>
            <div class="stats-label">Độ hài lòng</div>
        </div>
        <div class="stats-card">
            <div class="stats-number">4.8/5</div>
            <div class="stats-label">Đánh giá trung bình</div>
        </div>
    </div>

    <!-- Search and Actions -->
    <div class="modern-search">
        <div class="search-section">
            <div style="flex: 1;">
                <input type="text" placeholder="Tìm kiếm theo tên, email..."
                       class="search-input" id="searchInput">
            </div>
            <a href="<%= request.getContextPath()%>/nguoiDung/taoKhachHang" class="add-customer-btn">
                <i class="fas fa-plus"></i>Thêm khách hàng mới
            </a>
        </div>
    </div>

    <!-- Customer Table -->
    <div class="modern-table-container slide-up">
        <table class="modern-table">
            <thead>
            <tr>
                <th>
                    <i class="fas fa-user mr-2"></i>Thông tin khách hàng
                </th>
                <th>
                    <i class="fas fa-calendar mr-2"></i>Ngày tham gia
                </th>
                <th>
                    <i class="fas fa-envelope mr-2"></i>Liên hệ
                </th>
<%--                <%--%>
<%--                    if(nd != null && nd.getVaiTroNguoiDung() == vaiTro.QUAN_LY ) {--%>
<%--                %>--%>
                <th style="text-align: center;">
                    <i class="fas fa-cogs mr-2"></i>Thao tác
                </th>
<%--                <% } %>--%>
            </tr>
            </thead>
            <tbody id="guestTableBody">
            <% for (nguoiDung kh : danhSachKhachHang) { %>
            <tr>
                <td>
                    <div class="customer-info">
                        <div class="customer-avatar">
                            <%= kh.getTen().substring(0, 1).toUpperCase() %>
                        </div>
                        <div class="customer-details">
                            <h4><%= kh.getTen() %></h4>
<%--                            <p>ID: <%= kh.getId() %></p>--%>
                        </div>
                    </div>
                </td>
                <td>
                    <div style="font-weight: 600; color: var(--primary-blue);">
                        <%= kh.getNgayTao() %>
                    </div>
                </td>
                <td>
                    <div style="color: #475569;">
                        <i class="fas fa-envelope" style="color: var(--primary-yellow); margin-right: 0.5rem;"></i>
                        <%= kh.getEmail() %>
                    </div>
                </td>
<%--                <%--%>
<%--                    if(nd != null && nd.getVaiTroNguoiDung() == vaiTro.QUAN_LY ) {--%>
<%--                %>--%>
                <td>
                    <div class="action-buttons">
                        <a href="<%= request.getContextPath() %>/datSan/lichDatKhachHang?id=<%= kh.getId() %>"
                           class="btn-action btn-view" title="Xem lịch sử đặt sân">
                            <i class="fas fa-history"></i> Lịch sử đặt sân
                        </a>

                        <a href="<%= request.getContextPath() %>/nguoiDung/chinhSuaThongTinKhachHang?id=<%= kh.getId() %>"
                           class="btn-action btn-view" title="Chỉnh sửa thông tin">
                            <i class="fas fa-edit"></i> Sửa
                        </a>

                        <form action="<%=request.getContextPath()%>/nguoiDung/xoaKhachHang?id=<%= kh.getId() %>"
                              method="POST" style="margin: 0; display: inline;">
                            <button onclick="return confirm('Bạn có chắc chắn muốn xoá khách hàng này không?');"
                                    type="submit" class="btn-action btn-delete" title="Xoá khách hàng">
                                <i class="fas fa-trash"></i> Xoá
                            </button>
                        </form>
                    </div>
                </td>
<%--                <%--%>
<%--                    }--%>
<%--                %>--%>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>


<!-- Footer -->
<%@include file="footer.jsp" %>




<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Search functionality
        document.getElementById("searchInput").addEventListener("input", function () {
            const keyword = this.value.toLowerCase().trim();
            const rows = document.querySelectorAll("#guestTableBody tr");

            rows.forEach(row => {
                const name = row.querySelector(".customer-details h4")?.textContent.toLowerCase() || "";
                const email = row.querySelector("td:nth-child(3)")?.textContent.toLowerCase() || "";

                const matched = name.includes(keyword) || email.includes(keyword);
                row.style.display = matched ? "" : "none";
            });
        });

        // Add animation to table rows
        const rows = document.querySelectorAll("#guestTableBody tr");
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

        // Animate stats cards
        const statsCards = document.querySelectorAll('.stats-card');
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver(function(entries) {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, observerOptions);

        statsCards.forEach(card => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(30px)';
            card.style.transition = 'all 0.6s ease-out';
            observer.observe(card);
        });
    });
</script>
</body>
</html>
