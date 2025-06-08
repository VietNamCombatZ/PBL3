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
        }
    </style>
</head>
<body>

<%@include file="navbar.jsp" %>

<div class="booking-container fade-in">
    <!-- Page Header -->
    <div class="page-header">
        <h1 class="page-title">LỊCH ĐẶT SÂN CỦA TÔI</h1>
        <p class="page-subtitle">Quản lý và theo dõi các lịch đặt sân của bạn</p>
    </div>

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

    <div class="modern-table-container slide-up">
        <table class="modern-table">
            <thead>
            <tr>
                <th><i class="fas fa-futbol"></i> Tên sân</th>
                <th><i class="fas fa-clock"></i> Giờ bắt đầu</th>
                <th><i class="fas fa-clock"></i> Giờ kết thúc</th>
                <th><i class="fas fa-money-bill"></i> Số tiền</th>
                <th><i class="fas fa-info-circle"></i> Trạng thái</th>
                <th><i class="fas fa-cogs"></i> Thao tác</th>
            </tr>
            </thead>
            <tbody>
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
            <tr>
                <td>
                    <div style="display: flex; align-items: center; gap: 0.5rem;">
                        <div style="width: 40px; height: 40px; border-radius: 50%; background: var(--gradient-primary); display: flex; align-items: center; justify-content: center; color: white;">
                            <i class="fas fa-futbol"></i>
                        </div>
                        <strong><%= sb.getTenSan() %></strong>
                    </div>
                </td>
                <td><%= sdf.format(gioBatDau) %></td>
                <td><%= sdf.format(gioKetThuc) %></td>
                <td>
                    <strong style="color: var(--primary-blue);"><%= ds.getSoTien() %> VNĐ</strong>
                </td>
                <td>
                    <span class="status-badge <%= statusClass %>">
                        <%= ds.getTrangThai().toString() %>
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
    <%
        }
    %>
</div>

<%--footer--%>
<footer class="modern-footer">
    <div class="container">
        <div class="footer-grid">
            <div class="footer-section">
                <h3>Giới thiệu</h3>
                <p>Hệ thống quản lý sân bóng giúp người chơi dễ dàng tìm kiếm, đặt lịch và theo dõi tình trạng sân nhanh chóng, chính xác.</p>
            </div>
            <div class="footer-section">
                <h3>Thông tin liên hệ</h3>
                <p><i class="fas fa-envelope"></i> support@sanbongpro.vn</p>
                <p><i class="fas fa-map-marker-alt"></i> 123 Đường Bóng Đá, Quận Thể Thao, TP. Việt Nam</p>
                <p><i class="fas fa-phone"></i> 0123 456 789</p>
            </div>
            <div class="footer-section">
                <h3>Kết nối với chúng tôi</h3>
                <div style="display: flex; gap: 1rem; margin-top: 1rem;">
                    <a href="#" style="font-size: 1.5rem; color: var(--primary-yellow);"><i class="fab fa-facebook"></i></a>
                    <a href="#" style="font-size: 1.5rem; color: var(--primary-yellow);"><i class="fas fa-envelope"></i></a>
                    <a href="#" style="font-size: 1.5rem; color: var(--primary-yellow);"><i class="fab fa-tiktok"></i></a>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p>© 2025 SanBongPro.vn - All rights reserved.</p>
        </div>
    </div>
</footer>

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
    });
</script>
</body>
</html>
