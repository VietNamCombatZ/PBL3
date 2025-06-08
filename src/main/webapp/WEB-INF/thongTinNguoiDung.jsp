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
    <title>Thông Tin Cá Nhân - Modern</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern-style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        .profile-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        .profile-card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-md);
            overflow: hidden;
            animation: slideUp 0.6s ease-out;
        }

        .profile-header {
            background: var(--gradient-primary);
            color: white;
            padding: 2rem;
            text-align: center;
            position: relative;
        }

        .profile-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: var(--gradient-secondary);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--dark-blue);
            margin: 0 auto 1rem;
            border: 4px solid white;
            box-shadow: var(--shadow-md);
        }

        .profile-name {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .profile-role {
            background: rgba(255, 255, 255, 0.2);
            padding: 0.5rem 1rem;
            border-radius: 20px;
            display: inline-block;
            font-size: 0.9rem;
            font-weight: 500;
        }

        .profile-body {
            padding: 2rem;
        }

        .info-grid {
            display: grid;
            gap: 1.5rem;
        }

        .info-item {
            display: flex;
            align-items: center;
            padding: 1rem;
            background: #f8fafc;
            border-radius: var(--border-radius);
            border-left: 4px solid var(--primary-yellow);
            transition: var(--transition);
        }

        .info-item:hover {
            background: var(--light-blue);
            transform: translateX(5px);
        }

        .info-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--gradient-primary);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            margin-right: 1rem;
            font-size: 1.1rem;
        }

        .info-content {
            flex: 1;
        }

        .info-label {
            font-size: 0.8rem;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 600;
            margin-bottom: 0.25rem;
        }

        .info-value {
            font-size: 1rem;
            color: var(--primary-blue);
            font-weight: 600;
        }

        .edit-button {
            background: var(--gradient-secondary);
            color: var(--dark-blue);
            padding: 1rem 2rem;
            border: none;
            border-radius: var(--border-radius);
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin: 2rem auto 0;
            text-decoration: none;
            box-shadow: var(--shadow-sm);
        }

        .edit-button:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .stats-mini {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 1rem;
            margin-top: 2rem;
        }

        .stat-mini {
            background: white;
            padding: 1rem;
            border-radius: var(--border-radius);
            text-align: center;
            border: 2px solid var(--light-blue);
        }

        .stat-mini-number {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-blue);
        }

        .stat-mini-label {
            font-size: 0.8rem;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        @media (max-width: 768px) {
            .profile-container {
                padding: 0 1rem;
            }

            .profile-header {
                padding: 1.5rem;
            }

            .profile-body {
                padding: 1.5rem;
            }

            .info-item {
                flex-direction: column;
                text-align: center;
            }

            .info-icon {
                margin-right: 0;
                margin-bottom: 0.5rem;
            }
        }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="profile-container fade-in">
    <div class="profile-card">
        <div class="profile-header">
            <div class="profile-avatar">
                <%= nd.getTen().substring(0, 1).toUpperCase() %>
            </div>
            <h1 class="profile-name"><%= nd.getTen() %></h1>
            <span class="profile-role">
                <i class="fas fa-user-tag"></i>
                <%= nd.getVaiTroNguoiDung().toString().replace("_", " ") %>
            </span>
        </div>

        <div class="profile-body">
            <div class="info-grid">
                <div class="info-item">
                    <div class="info-icon">
                        <i class="fas fa-user"></i>
                    </div>
                    <div class="info-content">
                        <div class="info-label">Họ tên</div>
                        <div class="info-value"><%= nd.getTen() %></div>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon">
                        <i class="fas fa-envelope"></i>
                    </div>
                    <div class="info-content">
                        <div class="info-label">Email</div>
                        <div class="info-value"><%= nd.getEmail() %></div>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon">
                        <i class="fas fa-birthday-cake"></i>
                    </div>
                    <div class="info-content">
                        <div class="info-label">Ngày sinh</div>
                        <div class="info-value">
                            <%= nd.getNgaySinh() != null ? sdf.format(nd.getNgaySinh()) : "Chưa cập nhật" %>
                        </div>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon">
                        <i class="fas fa-id-badge"></i>
                    </div>
                    <div class="info-content">
                        <div class="info-label">ID người dùng</div>
                        <div class="info-value"><%= nd.getId() %></div>
                    </div>
                </div>
            </div>

            <div class="stats-mini">
                <div class="stat-mini">
                    <div class="stat-mini-number">5</div>
                    <div class="stat-mini-label">Sân đã đặt</div>
                </div>
                <div class="stat-mini">
                    <div class="stat-mini-number">4.8</div>
                    <div class="stat-mini-label">Đánh giá TB</div>
                </div>
                <div class="stat-mini">
                    <div class="stat-mini-number">2</div>
                    <div class="stat-mini-label">Năm thành viên</div>
                </div>
            </div>

            <form action="<%= request.getContextPath() + "/nguoiDung/chinhSuaThongTinCaNhan" %>" method="get">
                <input type="hidden" name="idNguoiDung" value="<%= nd.getId() %>"/>
                <button type="submit" class="edit-button">
                    <i class="fas fa-edit"></i>
                    Chỉnh sửa thông tin
                </button>
            </form>
        </div>
    </div>
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
        // Animate info items
        const infoItems = document.querySelectorAll('.info-item');
        infoItems.forEach((item, index) => {
            item.style.opacity = '0';
            item.style.transform = 'translateX(-30px)';
            item.style.transition = 'all 0.6s ease-out';

            setTimeout(() => {
                item.style.opacity = '1';
                item.style.transform = 'translateX(0)';
            }, index * 150);
        });

        // Animate stats
        const statNumbers = document.querySelectorAll('.stat-mini-number');
        statNumbers.forEach(stat => {
            const finalValue = stat.textContent;
            stat.textContent = '0';

            setTimeout(() => {
                let current = 0;
                const increment = finalValue / 20;
                const timer = setInterval(() => {
                    current += increment;
                    if (current >= finalValue) {
                        stat.textContent = finalValue;
                        clearInterval(timer);
                    } else {
                        stat.textContent = Math.floor(current);
                    }
                }, 50);
            }, 1000);
        });
    });
</script>

</body>
</html>
