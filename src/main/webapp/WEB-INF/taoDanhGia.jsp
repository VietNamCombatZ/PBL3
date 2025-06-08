<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.mucDiem" %>
<%@ page import="java.util.*, model.datSan, java.text.SimpleDateFormat" %>
<%@ page import="model.sanBong" %>
<%@ page import="DAO.SanBongDAO" %>
<%@ page import="model.nguoiDung" %>
<%@ page import="DAO.DatSanDAO" %>
<%@ page import="model.datSan" %>
<%@ page import="model.trangThaiDatSan" %>
<%@ page import="model.*" %>
<%@ page import="controller.BaseController" %>
<%@ page session="true" %>
<%
  String idDatSan = request.getParameter("idDatSan");
  datSan ds = DatSanDAO.timDatSanTheoId(idDatSan);
  if (ds == null) {
    response.sendRedirect(request.getContextPath() + "/nguoiDung/lichDatCuaToi");
    return;
  }
%>
<!DOCTYPE html>
<html>
<head>
  <title>Đánh Giá Sân - Modern</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern-style.css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <style>
    .review-container {
      max-width: 600px;
      margin: 2rem auto;
      padding: 0 2rem;
    }

    .review-card {
      background: white;
      border-radius: var(--border-radius);
      box-shadow: var(--shadow-md);
      overflow: hidden;
      animation: slideUp 0.6s ease-out;
    }

    .review-header {
      background: var(--gradient-primary);
      color: white;
      padding: 2rem;
      text-align: center;
    }

    .review-title {
      font-size: 1.8rem;
      font-weight: 700;
      margin-bottom: 0.5rem;
    }

    .review-subtitle {
      opacity: 0.9;
      font-size: 0.9rem;
    }

    .review-form {
      padding: 2rem;
    }

    .form-group {
      margin-bottom: 1.5rem;
    }

    .form-label {
      display: block;
      font-weight: 600;
      color: var(--primary-blue);
      margin-bottom: 0.5rem;
      font-size: 0.9rem;
    }

    .form-select {
      width: 100%;
      padding: 1rem;
      border: 2px solid #e2e8f0;
      border-radius: var(--border-radius);
      font-size: 1rem;
      transition: var(--transition);
      background: #f8fafc;
    }

    .form-textarea {
      width: 100%;
      padding: 1rem;
      border: 2px solid #e2e8f0;
      border-radius: var(--border-radius);
      font-size: 1rem;
      transition: var(--transition);
      background: #f8fafc;
      resize: vertical;
      min-height: 120px;
      font-family: inherit;
    }

    .form-select:focus,
    .form-textarea:focus {
      outline: none;
      border-color: var(--primary-blue);
      background: white;
      box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
    }

    .submit-btn {
      width: 100%;
      padding: 1rem;
      background: var(--gradient-secondary);
      color: var(--dark-blue);
      border: none;
      border-radius: var(--border-radius);
      font-size: 1rem;
      font-weight: 600;
      cursor: pointer;
      transition: var(--transition);
      margin-top: 1rem;
      box-shadow: var(--shadow-sm);
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 0.5rem;
    }

    .submit-btn:hover {
      transform: translateY(-2px);
      box-shadow: var(--shadow-md);
    }

    .rating-preview {
      display: flex;
      align-items: center;
      gap: 0.5rem;
      margin-top: 0.5rem;
      padding: 0.75rem;
      background: var(--light-yellow);
      border-radius: var(--border-radius);
      border-left: 4px solid var(--primary-yellow);
    }

    .rating-stars {
      color: var(--primary-yellow);
      font-size: 1.2rem;
    }

    .rating-text {
      color: var(--dark-blue);
      font-weight: 600;
      font-size: 0.9rem;
    }

    .char-counter {
      text-align: right;
      font-size: 0.8rem;
      color: #64748b;
      margin-top: 0.5rem;
    }

    .back-link {
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
      color: var(--primary-blue);
      text-decoration: none;
      font-weight: 500;
      margin-bottom: 2rem;
      transition: var(--transition);
    }

    .back-link:hover {
      color: var(--secondary-blue);
      transform: translateX(-5px);
    }

    @media (max-width: 768px) {
      .review-container {
        padding: 0 1rem;
      }

      .review-form {
        padding: 1.5rem;
      }

      .review-header {
        padding: 1.5rem;
      }
    }
  </style>
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="review-container fade-in">
  <a href="<%= request.getContextPath() %>/nguoiDung/lichDatCuaToi" class="back-link">
    <i class="fas fa-arrow-left"></i>
    Quay lại lịch đặt sân
  </a>

  <div class="review-card">
    <div class="review-header">
      <h1 class="review-title">Đánh Giá Sân Bóng</h1>
      <p class="review-subtitle">Chia sẻ trải nghiệm của bạn để giúp cộng đồng</p>
    </div>

    <form action="<%= request.getContextPath() %>/danhGia/taoDanhGia" method="post" class="review-form">
      <input type="hidden" name="idDatSan" value="<%= idDatSan %>"/>
      <input type="hidden" name="idSanBong" value="<%= ds.getIdSanBong() %>"/>

      <div class="form-group">
        <label for="mucDiem" class="form-label">
          <i class="fas fa-star"></i> Chọn mức đánh giá
        </label>
        <select name="mucDiem" id="mucDiem" class="form-select" required>
          <option value="">Chọn mức đánh giá</option>
          <%
            for (mucDiem md : mucDiem.values()) {
          %>
          <option value="<%= md.name() %>"><%= md.name().replace("_", " ") %></option>
          <%
            }
          %>
        </select>
        <div class="rating-preview" id="ratingPreview" style="display: none;">
          <div class="rating-stars" id="ratingStars"></div>
          <div class="rating-text" id="ratingText"></div>
        </div>
      </div>

      <div class="form-group">
        <label for="noiDung" class="form-label">
          <i class="fas fa-comment"></i> Nội dung đánh giá
        </label>
        <textarea name="noiDung" id="noiDung" class="form-textarea" maxlength="200" required
                  placeholder="Chia sẻ trải nghiệm của bạn về sân bóng này..."></textarea>
        <div class="char-counter">
          <span id="charCount">0</span>/200 ký tự
        </div>
      </div>

      <button type="submit" class="submit-btn">
        <i class="fas fa-paper-plane"></i>
        Gửi đánh giá
      </button>
    </form>
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
    const mucDiemSelect = document.getElementById('mucDiem');
    const noiDungTextarea = document.getElementById('noiDung');
    const charCount = document.getElementById('charCount');
    const ratingPreview = document.getElementById('ratingPreview');
    const ratingStars = document.getElementById('ratingStars');
    const ratingText = document.getElementById('ratingText');

    // Rating mapping
    const ratingMap = {
      'VERY_BAD': { stars: 1, text: 'Rất tệ', color: '#ef4444' },
      'BAD': { stars: 2, text: 'Tệ', color: '#f97316' },
      'AVERAGE': { stars: 3, text: 'Trung bình', color: '#eab308' },
      'GOOD': { stars: 4, text: 'Tốt', color: '#22c55e' },
      'EXCELLENT': { stars: 5, text: 'Xuất sắc', color: '#16a34a' }
    };

    // Update rating preview
    mucDiemSelect.addEventListener('change', function() {
      const selectedRating = this.value;
      if (selectedRating && ratingMap[selectedRating]) {
        const rating = ratingMap[selectedRating];
        let starsHtml = '';

        for (let i = 1; i <= 5; i++) {
          if (i <= rating.stars) {
            starsHtml += '<i class="fas fa-star"></i>';
          } else {
            starsHtml += '<i class="far fa-star"></i>';
          }
        }

        ratingStars.innerHTML = starsHtml;
        ratingStars.style.color = rating.color;
        ratingText.textContent = rating.text;
        ratingPreview.style.display = 'flex';
      } else {
        ratingPreview.style.display = 'none';
      }
    });

    // Character counter
    noiDungTextarea.addEventListener('input', function() {
      const currentLength = this.value.length;
      charCount.textContent = currentLength;

      if (currentLength > 180) {
        charCount.style.color = '#ef4444';
      } else if (currentLength > 150) {
        charCount.style.color = '#f97316';
      } else {
        charCount.style.color = '#64748b';
      }
    });

    // Form validation
    const form = document.querySelector('form');
    form.addEventListener('submit', function(e) {
      const rating = mucDiemSelect.value;
      const content = noiDungTextarea.value.trim();

      if (!rating) {
        alert('Vui lòng chọn mức đánh giá');
        e.preventDefault();
        return;
      }

      if (content.length < 10) {
        alert('Nội dung đánh giá phải có ít nhất 10 ký tự');
        e.preventDefault();
        return;
      }

      // Add loading state
      const submitBtn = document.querySelector('.submit-btn');
      submitBtn.innerHTML = '<div class="loading"></div> Đang gửi...';
      submitBtn.disabled = true;
    });

    // Add focus effects
    const inputs = document.querySelectorAll('.form-select, .form-textarea');
    inputs.forEach(input => {
      input.addEventListener('focus', function() {
        this.style.borderColor = 'var(--primary-blue)';
        this.style.background = 'white';
      });

      input.addEventListener('blur', function() {
        if (!this.value) {
          this.style.borderColor = '#e2e8f0';
          this.style.background = '#f8fafc';
        }
      });
    });
  });
</script>
</body>
</html>
