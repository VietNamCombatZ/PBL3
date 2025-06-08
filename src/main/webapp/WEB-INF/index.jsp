<%@ page import="model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Đặt Sân Bóng Đá - Modern</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern-style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        .hero-section {
            background: linear-gradient(135deg, rgba(30, 64, 175, 0.9) 0%, rgba(59, 130, 246, 0.1) 100%),
            /*url('https://images.unsplash.com/photo-1509021436665-8f07dbf5bf1d?auto=format&fit=crop&w=1600&q=80');*/
            url('https://datsan247.com/images/22.jpg');
            background-size: cover;
            background-position: center;
            min-height: 80vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: white;
            position: relative;
        }

        .hero-content {
            max-width: 800px;
            padding: 2rem;
            animation: fadeIn 1s ease-out;
        }

        .hero-title {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            text-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            line-height: 1.2;
        }

        .hero-subtitle {
            font-size: 1.25rem;
            margin-bottom: 2rem;
            opacity: 0.9;
            font-weight: 300;
        }

        .search-form {
            background: white;
            padding: 2rem;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-lg);
            display: grid;
            grid-template-columns: 1fr 2fr 1fr;
            gap: 1rem;
            margin-top: 2rem;
            max-width: 900px;
        }

        .feature-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            padding: 4rem 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .feature-card {
            background: white;
            padding: 2.5rem;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-sm);
            text-align: center;
            transition: var(--transition);
            border-top: 4px solid var(--primary-yellow);
        }

        .feature-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-lg);
        }

        .feature-icon {
            font-size: 3rem;
            color: var(--primary-yellow);
            margin-bottom: 1.5rem;
            display: block;
        }

        .feature-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--primary-blue);
            margin-bottom: 1rem;
        }

        .feature-description {
            color: #64748b;
            line-height: 1.6;
        }

        .stats-section {
            background: var(--gradient-accent);
            color: white;
            padding: 4rem 2rem;
            text-align: center;
        }

        .stats-container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .stats-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 3rem;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .testimonial-section {
            padding: 4rem 2rem;
            background: #f8fafc;
        }

        .testimonial-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .testimonial-card {
            background: white;
            padding: 2rem;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-sm);
            position: relative;
            transition: var(--transition);
        }

        .testimonial-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-md);
        }

        .testimonial-card::before {
            content: '"';
            font-size: 4rem;
            color: var(--primary-yellow);
            position: absolute;
            top: -1rem;
            left: 1rem;
            font-family: serif;
        }

        .testimonial-text {
            font-style: italic;
            margin-bottom: 1rem;
            color: #475569;
            line-height: 1.6;
        }

        .testimonial-author {
            font-weight: 600;
            color: var(--primary-blue);
        }

        @media (max-width: 768px) {
            .hero-title {
                font-size: 2.5rem;
            }

            .search-form {
                grid-template-columns: 1fr;
                padding: 1.5rem;
            }

            .feature-grid {
                grid-template-columns: 1fr;
                padding: 2rem 1rem;
            }
        }
    </style>
</head>
<body>
<%
    nguoiDung nd = (nguoiDung) session.getAttribute("nguoiDung");
    vaiTro vaiTroNguoiDung = (nd != null) ? nd.getVaiTroNguoiDung() : null;
%>

<!-- Navbar -->
<%
    if (vaiTroNguoiDung != null && (vaiTroNguoiDung == vaiTro.NHAN_VIEN || vaiTroNguoiDung == vaiTro.QUAN_LY)) {
%>
<%@include file="navbar-nhanvien.jsp" %>
<%
} else {
%>
<%@include file="navbar.jsp" %>
<%
    }
%>

<!-- Hero Section -->
<section class="hero-section">
    <div class="hero-content fade-in">
        <h1 class="hero-title">HỆ THỐNG HỖ TRỢ TÌM KIẾM SÂN BÓNG NHANH</h1>
        <p class="hero-subtitle">Dữ liệu được cập nhật thường xuyên giúp bạn tìm sân nhanh và chính xác hơn.</p>

        <!-- Search Form -->
        <div class="search-form slide-up">
            <select class="modern-form-control">
                <option>Loại sân</option>
                <option>5 người</option>
                <option>7 người</option>
                <option>11 người</option>
            </select>
            <input type="text" placeholder="Nhập tên sân..." class="modern-form-control" />
            <a class="btn-modern btn-secondary" href="<%=request.getContextPath()%>/sanBong/danhSachSanCoSan">
                <i class="fas fa-search"></i> Tìm kiếm
            </a>
        </div>
    </div>
</section>

<!-- Features Section -->
<section style="background: white;">
    <div style="text-align: center; padding: 4rem 2rem 2rem;">
        <h2 style="font-size: 2.5rem; font-weight: 700; color: var(--primary-blue); margin-bottom: 1rem;">
            Chức năng nổi bật
        </h2>
        <p style="color: #64748b; font-size: 1.1rem; max-width: 600px; margin: 0 auto;">
            Khám phá những tính năng tuyệt vời giúp bạn đặt sân dễ dàng và tiện lợi
        </p>
    </div>

    <div class="feature-grid">
        <div class="feature-card">
            <i class="fas fa-search-location feature-icon"></i>
            <h3 class="feature-title">Tìm kiếm sân bóng</h3>
            <p class="feature-description">Tra cứu nhanh chóng các sân bóng theo khu vực, loại sân và thời gian trống.</p>
        </div>
        <div class="feature-card">
            <i class="fas fa-calendar-check feature-icon"></i>
            <h3 class="feature-title">Đặt lịch online</h3>
            <p class="feature-description">Lên lịch thi đấu dễ dàng và đặt sân chỉ với vài cú click.</p>
        </div>
    </div>
</section>

<!-- Stats Section -->
<section class="stats-section">
    <div class="stats-container">
        <h2 class="stats-title">Tại sao chọn chúng tôi?</h2>
        <div class="stats-grid">
            <div class="stats-card" style="background: rgba(255, 255, 255, 0.1); border: 1px solid rgba(255, 255, 255, 0.2);">
                <i class="fas fa-futbol" style="font-size: 3rem; color: var(--primary-yellow); margin-bottom: 1rem;"></i>
                <div class="stats-number" style="color: white;">20+</div>
                <div class="stats-label" style="color: rgba(255, 255, 255, 0.8);">Sân bóng hiện đại</div>
                <p style="color: rgba(255, 255, 255, 0.7); margin-top: 1rem; font-size: 0.9rem;">
                    Hệ thống liên kết với nhiều sân chất lượng cao, mặt cỏ nhân tạo chuẩn thi đấu.
                </p>
            </div>
            <div class="stats-card" style="background: rgba(255, 255, 255, 0.1); border: 1px solid rgba(255, 255, 255, 0.2);">
                <i class="fas fa-users" style="font-size: 3rem; color: var(--primary-yellow); margin-bottom: 1rem;"></i>
                <div class="stats-number" style="color: white;">10.000+</div>
                <div class="stats-label" style="color: rgba(255, 255, 255, 0.8);">Lượt đặt sân</div>
                <p style="color: rgba(255, 255, 255, 0.7); margin-top: 1rem; font-size: 0.9rem;">
                    Được tin tưởng và sử dụng bởi đông đảo cộng đồng thể thao.
                </p>
            </div>
            <div class="stats-card" style="background: rgba(255, 255, 255, 0.1); border: 1px solid rgba(255, 255, 255, 0.2);">
                <i class="fas fa-clock" style="font-size: 3rem; color: var(--primary-yellow); margin-bottom: 1rem;"></i>
                <div class="stats-number" style="color: white;">24/7</div>
                <div class="stats-label" style="color: rgba(255, 255, 255, 0.8);">Sẵn sàng phục vụ</div>
                <p style="color: rgba(255, 255, 255, 0.7); margin-top: 1rem; font-size: 0.9rem;">
                    Bạn có thể đặt sân bất kỳ lúc nào, kể cả buổi tối hoặc cuối tuần.
                </p>
            </div>
        </div>
    </div>
</section>

<!-- Testimonials Section -->
<section class="testimonial-section">
    <div style="text-align: center; margin-bottom: 3rem;">
        <h2 style="font-size: 2.5rem; font-weight: 700; color: var(--primary-blue); margin-bottom: 1rem;">
            Khách hàng nói gì?
        </h2>
        <p style="color: #64748b; font-size: 1.1rem;">
            Những phản hồi tích cực từ cộng đồng người chơi bóng đá
        </p>
    </div>

    <div class="testimonial-grid">
        <div class="testimonial-card">
            <p class="testimonial-text">"Giao diện dễ dùng, đặt sân cực nhanh và tiện lợi!"</p>
            <p class="testimonial-author">– Huyền Trang, Hà Nội</p>
        </div>
        <div class="testimonial-card">
            <p class="testimonial-text">"Không còn phải gọi điện từng sân để hỏi lịch nữa. Tuyệt vời!"</p>
            <p class="testimonial-author">– Minh Đức, Đà Nẵng</p>
        </div>
        <div class="testimonial-card">
            <p class="testimonial-text">"Sân được review rõ ràng, đặt sân xong nhận xác nhận liền tay."</p>
            <p class="testimonial-author">– Phương Anh, TP.HCM</p>
        </div>
    </div>
</section>

<!-- Footer -->
<%@include file="footer.jsp" %>

<script>
    // Add smooth scrolling and animations
    document.addEventListener('DOMContentLoaded', function() {
        // Animate elements on scroll
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

        // Observe all cards and sections
        document.querySelectorAll('.feature-card, .stats-card, .testimonial-card').forEach(el => {
            el.style.opacity = '0';
            el.style.transform = 'translateY(30px)';
            el.style.transition = 'all 0.6s ease-out';
            observer.observe(el);
        });
    });
</script>

</body>
</html>
