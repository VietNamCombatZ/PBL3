<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.*, java.util.*" %>
<%@ page import="DAO.DatSanDAO, DAO.DanhGiaDAO" %>
<%@ page session="true" %>
<%
  String idDatSan = request.getParameter("idDatSan");
  datSan ds = DatSanDAO.timDatSanTheoId(idDatSan);
  danhGia danhGiaHienTai = DanhGiaDAO.timDanhGiaTheoDatSan(idDatSan);

  if (ds == null || danhGiaHienTai == null) {
    response.sendRedirect(request.getContextPath() + "/nguoiDung/lichDatCuaToi");
    return;
  }
%>

<!DOCTYPE html>
<html>
<head>
  <title>Chỉnh Sửa Đánh Giá - Modern</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern-style.css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <style>
    .edit-review-container {
      max-width: 600px;
      margin: 2rem auto;
      padding: 0 2rem;
    }

    .edit-review-card {
      background: white;
      border-radius: var(--border-radius);
      box-shadow: var(--shadow-md);
      overflow: hidden;
      animation: slideUp 0.6s ease-out;
    }

    .edit-review-header {
      background: var(--gradient-primary);
      color: white;
      padding: 2rem;
      text-align: center;
    }

    .edit-review-title {
      font-size: 1.8rem;
      font-weight: 700;
      margin-bottom: 0.5rem;
    }

    .edit-review-subtitle {
      opacity: 0.9;
      font-size: 0.9rem;
    }

    .edit-review-form {
      padding: 2rem;
    }

    .form-actions {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 1rem;
      margin-top: 2rem;
    }

    .btn-update {
      background: var(--gradient-secondary);
      color: var(--dark-blue);
      padding: 1rem;
      border: none;
      border-radius: var(--border-radius);
      font-weight: 600;
      cursor: pointer;
      transition: var(--transition);
      box-shadow: var(--shadow-sm);
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 0.5rem;
    }

    .btn-delete {
      background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
      color: white;
      padding: 1rem;
      border: none;
      border-radius: var(--border-radius);
      font-weight: 600;
      cursor: pointer;
      transition: var(--transition);
      box-shadow: var(--shadow-sm);
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 0.5rem;
    }

    .btn-update:hover,
    .btn-delete:hover {
      transform: translateY(-2px);
      box-shadow: var(--shadow-md);
    }

    .current-rating {
      background: var(--light-blue);
      padding: 1rem;
      border-radius: var(--border-radius);
      margin-bottom: 1.5rem;
      border-left: 4px solid var(--primary-blue);
    }

    .current-rating-label {
      font-size: 0.8rem;
      color: #64748b;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      font-weight: 600;
      margin-bottom: 0.5rem;
    }

    .current-rating-value {
      display: flex;
      align-items: center;
      gap: 0.5rem;
      color: var(--primary-blue);
      font-weight: 600;
    }

    @media (max-width: 768px) {
      .edit-review-container {
        padding: 0 1rem;
      }

      .form-actions {
        grid-template-columns: 1fr;
      }

      .edit-review-form {
        padding: 1.5rem;
      }

      .edit-review-header {
        padding: 1.5rem;
      }
    }
  </style>
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="edit-review-container fade-in">
  <a href="<%= request.getContextPath() %>/nguoiDung/lichDatCuaToi" class="back-link">
    <i class="fas fa-arrow-left"></i>
    Quay lại lịch đặt sân
  </a>

  <div class="edit-review-card">
    <div class="edit-review-header">
      <h1 class="edit-review-title">Chỉnh Sửa Đánh Giá</h1>
      <p class="edit-review-subtitle">Cập nhật đánh giá của bạn về sân bóng</p>
    </div>

    <div class="edit-review-form">
      <div class="current-rating">
        <div class="current-rating-label">Đánh giá hiện tại</div>
        <div class="current-rating-value">
          <div class="rating-stars" id="currentStars"></div>
          <span id="currentRatingText"></span>
        </div>
      </div>

      <form action="<%= request.getContextPath() %>/danhGia/chinhSuaDanhGia" method="post">
        <input type="hidden" name="idDatSan" value="<%= ds.getId() %>"/>
        <input type="hidden" name="idSanBong" value="<%= ds.getIdSanBong() %>"/>
        <input type="hidden" name="idDanhGia" value="<%= danhGiaHienTai.getId() %>"/>

        <div class="form-group">
          <label for="mucDiem" class="form-label">
            <i class="fas fa-star"></i> Chọn mức đánh giá mới
          </label>
          <select name="mucDiem" id="mucDiem" class="form-select" required>
            <%
              for (mucDiem md : mucDiem.values()) {
                String selected = (danhGiaHienTai.getMucDiem().equals(md)) ? "selected" : "";
            %>
            <option value="<%= md.name() %>" <%= selected %>><%= md.name().replace("_", " ") %></option>
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
          <textarea name="noiDung" id="noiDung" class="form-textarea" maxlength="200" required><%= danhGiaHienTai.getNoiDung() %></textarea>
          <div class="char-counter">
            <span id="charCount"><%= danhGiaHienTai.getNoiDung().length() %></span>/200 ký tự
          </div>
        </div>

        <div class="form-actions">
          <button type="submit" class="btn-update">
            <i class="fas fa-save"></i>
            Cập nhật đánh giá
          </button>

          <button type="submit" formaction="<%= request.getContextPath() %>/danhGia/xoaDanhGia" formmethod="post"
                  onclick="return confirm('Bạn có chắc chắn muốn xoá đánh giá này?');"
                  class="btn-delete">
            <i class="fas fa-trash"></i>
            Xoá đánh giá
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- Footer -->
<%@include file="footer.jsp" %>


<script>
  document.addEventListener('DOMContentLoaded', function() {
    const mucDiemSelect = document.getElementById('mucDiem');
    const noiDungTextarea = document.getElementById('noiDung');
    const charCount = document.getElementById('charCount');
    const ratingPreview = document.getElementById('ratingPreview');
    const ratingStars = document.getElementById('ratingStars');
    const ratingText = document.getElementById('ratingText');
    const currentStars = document.getElementById('currentStars');
    const currentRatingText = document.getElementById('currentRatingText');

    // Rating mapping
    const ratingMap = {
      'VERY_BAD': { stars: 1, text: 'Rất tệ', color: '#ef4444' },
      'BAD': { stars: 2, text: 'Tệ', color: '#f97316' },
      'AVERAGE': { stars: 3, text: 'Trung bình', color: '#eab308' },
      'GOOD': { stars: 4, text: 'Tốt', color: '#22c55e' },
      'EXCELLENT': { stars: 5, text: 'Xuất sắc', color: '#16a34a' }
    };

    // Display current rating
    const currentRating = '<%= danhGiaHienTai.getMucDiem().name() %>';
    if (ratingMap[currentRating]) {
      const rating = ratingMap[currentRating];
      let starsHtml = '';

      for (let i = 1; i <= 5; i++) {
        if (i <= rating.stars) {
          starsHtml += '<i class="fas fa-star"></i>';
        } else {
          starsHtml += '<i class="far fa-star"></i>';
        }
      }

      currentStars.innerHTML = starsHtml;
      currentStars.style.color = rating.color;
      currentRatingText.textContent = rating.text;
    }

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
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
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
        const submitBtn = e.target.querySelector('button[type="submit"]');
        if (submitBtn.classList.contains('btn-update')) {
          submitBtn.innerHTML = '<div class="loading"></div> Đang cập nhật...';
        } else {
          submitBtn.innerHTML = '<div class="loading"></div> Đang xoá...';
        }
        submitBtn.disabled = true;
      });
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
