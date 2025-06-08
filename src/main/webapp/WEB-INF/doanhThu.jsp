<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.util.Map" %>
<html>
<head>
  <title>Thống kê doanh thu - Modern</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern-style.css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <style>
    .revenue-container {
      max-width: 1400px;
      margin: 2rem auto;
      padding: 0 2rem;
    }

    .filter-card {
      background: white;
      border-radius: var(--border-radius);
      box-shadow: var(--shadow-sm);
      padding: 2rem;
      margin-bottom: 2rem;
      animation: slideUp 0.6s ease-out;
    }

    .filter-title {
      font-size: 1.5rem;
      font-weight: 700;
      color: var(--primary-blue);
      margin-bottom: 1.5rem;
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    .filter-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 1.5rem;
      margin-bottom: 2rem;
    }

    .filter-group {
      display: flex;
      flex-direction: column;
      gap: 0.5rem;
    }

    .filter-label {
      font-weight: 600;
      color: var(--primary-blue);
      font-size: 0.9rem;
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    .filter-row {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 1rem;
    }

    .filter-input {
      padding: 0.75rem;
      border: 2px solid #e2e8f0;
      border-radius: var(--border-radius);
      font-size: 0.9rem;
      transition: var(--transition);
      background: #f8fafc;
    }

    .filter-input:focus {
      outline: none;
      border-color: var(--primary-blue);
      background: white;
      box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
    }

    .filter-btn {
      background: var(--gradient-primary);
      color: white;
      padding: 1rem 2rem;
      border: none;
      border-radius: var(--border-radius);
      font-weight: 600;
      cursor: pointer;
      transition: var(--transition);
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 0.5rem;
      margin: 0 auto;
      box-shadow: var(--shadow-sm);
    }

    .filter-btn:hover {
      transform: translateY(-2px);
      box-shadow: var(--shadow-md);
    }

    .chart-section {
      background: white;
      border-radius: var(--border-radius);
      box-shadow: var(--shadow-sm);
      padding: 2rem;
      margin-bottom: 2rem;
      animation: fadeIn 0.8s ease-out;
    }

    .chart-header {
      display: flex;
      align-items: center;
      gap: 0.5rem;
      margin-bottom: 1.5rem;
      color: var(--primary-blue);
      font-weight: 700;
      font-size: 1.3rem;
    }

    .chart-container {
      position: relative;
      height: 400px;
      margin-bottom: 2rem;
    }

    .chart-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
      gap: 2rem;
    }

    .chart-item {
      background: #f8fafc;
      border-radius: var(--border-radius);
      padding: 1.5rem;
      border: 2px solid #e2e8f0;
      transition: var(--transition);
    }

    .chart-item:hover {
      border-color: var(--primary-yellow);
      box-shadow: var(--shadow-sm);
    }

    .chart-item-title {
      font-weight: 600;
      color: var(--primary-blue);
      margin-bottom: 1rem;
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    .chart-canvas {
      background: white;
      border-radius: var(--border-radius);
      padding: 1rem;
      box-shadow: var(--shadow-sm);
    }

    @media (max-width: 768px) {
      .revenue-container {
        padding: 0 1rem;
      }

      .filter-grid {
        grid-template-columns: 1fr;
      }

      .filter-row {
        grid-template-columns: 1fr;
      }

      .chart-grid {
        grid-template-columns: 1fr;
      }

      .chart-container {
        height: 300px;
      }
    }
  </style>
</head>
<body>

<%@include file="navbar-nhanvien.jsp" %>

<div class="revenue-container fade-in">
  <!-- Page Header -->
  <div class="page-header">
    <h1 class="page-title">THỐNG KÊ DOANH THU</h1>
    <p class="page-subtitle">Phân tích chi tiết doanh thu và hiệu suất kinh doanh</p>
  </div>

  <!-- Filter Section -->
  <div class="filter-card">
    <h2 class="filter-title">
      <i class="fas fa-filter"></i>
      Bộ lọc thời gian
    </h2>

    <form action="<%= request.getContextPath() %>/doanhThu" method="post">
      <div class="filter-grid">
        <div class="filter-group">
          <div class="filter-label">
            <i class="fas fa-calendar-day"></i>
            Lọc theo ngày
          </div>
          <div class="filter-row">
            <input type="date" name="tuNgay" class="filter-input" placeholder="Từ ngày" />
            <input type="date" name="denNgay" class="filter-input" placeholder="Đến ngày" />
          </div>
        </div>

        <div class="filter-group">
          <div class="filter-label">
            <i class="fas fa-calendar-week"></i>
            Lọc theo tuần
          </div>
          <div class="filter-row">
            <input type="week" name="tuTuan" class="filter-input" placeholder="Từ tuần" />
            <input type="week" name="denTuan" class="filter-input" placeholder="Đến tuần" />
          </div>
        </div>

        <div class="filter-group">
          <div class="filter-label">
            <i class="fas fa-calendar-alt"></i>
            Lọc theo tháng
          </div>
          <div class="filter-row">
            <input type="month" name="tuThang" class="filter-input" placeholder="Từ tháng" />
            <input type="month" name="denThang" class="filter-input" placeholder="Đến tháng" />
          </div>
        </div>
      </div>

      <button type="submit" class="filter-btn">
        <i class="fas fa-chart-line"></i>
        Lọc thống kê
      </button>
    </form>
  </div>

  <%
    Map<String, Integer> doanhThuTheoNgay = (Map<String, Integer>) request.getAttribute("doanhThuTheoNgay");
    Map<String, Integer> doanhThuNgayTheoLoaiSan = (Map<String, Integer>) request.getAttribute("doanhThuNgayTheoLoaiSan");
    Map<String, Integer> soLuongSanTheoGioTheoNgay = (Map<String, Integer>) request.getAttribute("soLuongSanTheoGioTheoNgay");

    Map<String, Integer> doanhThuTheoTuan = (Map<String, Integer>) request.getAttribute("doanhThuTheoTuan");
    Map<String, Integer> doanhThuTuanTheoLoaiSan = (Map<String, Integer>) request.getAttribute("doanhThuTuanTheoLoaiSan");
    Map<String, Integer> soLuongSanTheoGioTheoTuan = (Map<String, Integer>) request.getAttribute("soLuongSanTheoGioTheoTuan");

    Map<String, Integer> doanhThuTheoThang = (Map<String, Integer>) request.getAttribute("doanhThuTheoThang");
    Map<String, Integer> doanhThuThangTheoLoaiSan = (Map<String, Integer>) request.getAttribute("doanhThuThangTheoLoaiSan");
    Map<String, Integer> soLuongSanTheoGioTheoThang = (Map<String, Integer>) request.getAttribute("soLuongSanTheoGioTheoThang");

    Map<String, Integer> doanhThuTheoLoaiSan = (Map<String, Integer>) request.getAttribute("doanhThuTheoLoaiSan");
    Map<String, Integer> soLuongSanTheoGio = (Map<String, Integer>) request.getAttribute("soLuongSanTheoGio");
  %>

  <!-- Daily Revenue Section -->
  <div class="chart-section">
    <h2 class="chart-header">
      <i class="fas fa-calendar-day"></i>
      Thống kê theo ngày
    </h2>
    <div class="chart-grid">
      <div class="chart-item">
        <h3 class="chart-item-title">
          <i class="fas fa-chart-bar"></i>
          Doanh thu theo ngày
        </h3>
        <div class="chart-canvas">
          <canvas id="chartNgay"></canvas>
        </div>
      </div>

      <div class="chart-item">
        <h3 class="chart-item-title">
          <i class="fas fa-chart-pie"></i>
          Doanh thu theo loại sân
        </h3>
        <div class="chart-canvas">
          <canvas id="chartSanTheoNgay"></canvas>
        </div>
      </div>

      <div class="chart-item">
        <h3 class="chart-item-title">
          <i class="fas fa-clock"></i>
          Lượt đặt theo giờ
        </h3>
        <div class="chart-canvas">
          <canvas id="chartGioTheoNgay"></canvas>
        </div>
      </div>
    </div>
  </div>

  <!-- Weekly Revenue Section -->
  <div class="chart-section">
    <h2 class="chart-header">
      <i class="fas fa-calendar-week"></i>
      Thống kê theo tuần
    </h2>
    <div class="chart-grid">
      <div class="chart-item">
        <h3 class="chart-item-title">
          <i class="fas fa-chart-line"></i>
          Doanh thu theo tuần
        </h3>
        <div class="chart-canvas">
          <canvas id="chartTuan"></canvas>
        </div>
      </div>

      <div class="chart-item">
        <h3 class="chart-item-title">
          <i class="fas fa-chart-pie"></i>
          Doanh thu theo loại sân
        </h3>
        <div class="chart-canvas">
          <canvas id="chartSanTheoTuan"></canvas>
        </div>
      </div>

      <div class="chart-item">
        <h3 class="chart-item-title">
          <i class="fas fa-clock"></i>
          Lượt đặt theo giờ
        </h3>
        <div class="chart-canvas">
          <canvas id="chartGioTheoTuan"></canvas>
        </div>
      </div>
    </div>
  </div>

  <!-- Monthly Revenue Section -->
  <div class="chart-section">
    <h2 class="chart-header">
      <i class="fas fa-calendar-alt"></i>
      Thống kê theo tháng
    </h2>
    <div class="chart-grid">
      <div class="chart-item">
        <h3 class="chart-item-title">
          <i class="fas fa-chart-bar"></i>
          Doanh thu theo tháng
        </h3>
        <div class="chart-canvas">
          <canvas id="chartThang"></canvas>
        </div>
      </div>

      <div class="chart-item">
        <h3 class="chart-item-title">
          <i class="fas fa-chart-pie"></i>
          Doanh thu theo loại sân
        </h3>
        <div class="chart-canvas">
          <canvas id="chartSanTheoThang"></canvas>
        </div>
      </div>

      <div class="chart-item">
        <h3 class="chart-item-title">
          <i class="fas fa-clock"></i>
          Lượt đặt theo giờ
        </h3>
        <div class="chart-canvas">
          <canvas id="chartGioTheoThang"></canvas>
        </div>
      </div>
    </div>
  </div>

<%--  <!-- Overall Statistics -->--%>
<%--  <div class="chart-section">--%>
<%--    <h2 class="chart-header">--%>
<%--      <i class="fas fa-chart-area"></i>--%>
<%--      Thống kê tổng quan--%>
<%--    </h2>--%>
<%--    <div class="chart-grid">--%>
<%--      <div class="chart-item">--%>
<%--        <h3 class="chart-item-title">--%>
<%--          <i class="fas fa-futbol"></i>--%>
<%--          Doanh thu theo loại sân--%>
<%--        </h3>--%>
<%--        <div class="chart-canvas">--%>
<%--          <canvas id="chartLoaiSan"></canvas>--%>
<%--        </div>--%>
<%--      </div>--%>

<%--      <div class="chart-item">--%>
<%--        <h3 class="chart-item-title">--%>
<%--          <i class="fas fa-clock"></i>--%>
<%--          Lượt đặt theo giờ--%>
<%--        </h3>--%>
<%--        <div class="chart-canvas">--%>
<%--          <canvas id="chartGio"></canvas>--%>
<%--        </div>--%>
<%--      </div>--%>
<%--    </div>--%>
<%--  </div>--%>
<%--</div>--%>


<!-- Footer -->
<%@include file="footer.jsp" %>




<script>
  // Chart.js configuration
  Chart.defaults.font.family = 'Inter, sans-serif';
  Chart.defaults.color = '#64748b';

  const chartColors = {
    primary: '#3b82f6',
    secondary: '#fbbf24',
    success: '#22c55e',
    danger: '#ef4444',
    warning: '#f59e0b',
    info: '#06b6d4',
    gradient: {
      primary: 'linear-gradient(135deg, #3b82f6 0%, #1e40af 100%)',
      secondary: 'linear-gradient(135deg, #fbbf24 0%, #f59e0b 100%)'
    }
  };

  <% if (doanhThuTheoNgay != null) { %>
  const chartNgay = new Chart(document.getElementById('chartNgay'), {
    type: 'bar',
    data: {
      labels: [<% for (String key : doanhThuTheoNgay.keySet()) { %>"<%= key %>",<% } %>],
      datasets: [{
        label: 'Doanh thu (VNĐ)',
        data: [<% for (String key : doanhThuTheoNgay.keySet()) { %><%= doanhThuTheoNgay.get(key) %>,<% } %>],
        backgroundColor: chartColors.primary,
        borderRadius: 8,
        borderSkipped: false,
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          display: false
        }
      },
      scales: {
        y: {
          beginAtZero: true,
          grid: {
            color: '#f1f5f9'
          }
        },
        x: {
          grid: {
            display: false
          }
        }
      }
    }
  });

  const chartNgayLoaiSan = new Chart(document.getElementById('chartSanTheoNgay'), {
    type: 'doughnut',
    data: {
      labels: [<% for (String key : doanhThuNgayTheoLoaiSan.keySet()) { %>"<%= key %>",<% } %>],
      datasets: [{
        data: [<% for (String key : doanhThuNgayTheoLoaiSan.keySet()) { %><%= doanhThuNgayTheoLoaiSan.get(key) %>,<% } %>],
        backgroundColor: [chartColors.primary, chartColors.secondary, chartColors.success, chartColors.info],
        borderWidth: 0,
        cutout: '60%'
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          position: 'bottom',
          labels: {
            padding: 20,
            usePointStyle: true
          }
        }
      }
    }
  });

  const chartGioTheoNgay = new Chart(document.getElementById('chartGioTheoNgay'), {
    type: 'bar',
    data: {
      labels: [<% for (String key : soLuongSanTheoGioTheoNgay.keySet()) { %>"<%= key %>h",<% } %>],
      datasets: [{
        label: 'Số lượt đặt',
        data: [<% for (String key : soLuongSanTheoGioTheoNgay.keySet()) { %><%= soLuongSanTheoGioTheoNgay.get(key) %>,<% } %>],
        backgroundColor: chartColors.secondary,
        borderRadius: 8,
        borderSkipped: false,
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          display: false
        }
      },
      scales: {
        y: {
          beginAtZero: true,
          grid: {
            color: '#f1f5f9'
          }
        },
        x: {
          grid: {
            display: false
          }
        }
      }
    }
  });
  <% } %>

  <% if (doanhThuTheoTuan != null) { %>
  const chartTuan = new Chart(document.getElementById('chartTuan'), {
    type: 'line',
    data: {
      labels: [<% for (String key : doanhThuTheoTuan.keySet()) { %>"Tuần <%= key %>",<% } %>],
      datasets: [{
        label: 'Doanh thu (VNĐ)',
        data: [<% for (String key : doanhThuTheoTuan.keySet()) { %><%= doanhThuTheoTuan.get(key) %>,<% } %>],
        borderColor: chartColors.primary,
        backgroundColor: chartColors.primary + '20',
        borderWidth: 3,
        fill: true,
        tension: 0.4,
        pointBackgroundColor: chartColors.primary,
        pointBorderColor: '#fff',
        pointBorderWidth: 2,
        pointRadius: 6
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          display: false
        }
      },
      scales: {
        y: {
          beginAtZero: true,
          grid: {
            color: '#f1f5f9'
          }
        },
        x: {
          grid: {
            display: false
          }
        }
      }
    }
  });

  const chartTuanLoaiSan = new Chart(document.getElementById('chartSanTheoTuan'), {
    type: 'doughnut',
    data: {
      labels: [<% for (String key : doanhThuTuanTheoLoaiSan.keySet()) { %>"<%= key %>",<% } %>],
      datasets: [{
        data: [<% for (String key : doanhThuTuanTheoLoaiSan.keySet()) { %><%= doanhThuTuanTheoLoaiSan.get(key) %>,<% } %>],
        backgroundColor: [chartColors.primary, chartColors.secondary, chartColors.success, chartColors.info],
        borderWidth: 0,
        cutout: '60%'
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          position: 'bottom',
          labels: {
            padding: 20,
            usePointStyle: true
          }
        }
      }
    }
  });

  const chartGioTheoTuan = new Chart(document.getElementById('chartGioTheoTuan'), {
    type: 'bar',
    data: {
      labels: [<% for (String key : soLuongSanTheoGioTheoTuan.keySet()) { %>"<%= key %>h",<% } %>],
      datasets: [{
        label: 'Số lượt đặt',
        data: [<% for (String key : soLuongSanTheoGioTheoTuan.keySet()) { %><%= soLuongSanTheoGioTheoTuan.get(key) %>,<% } %>],
        backgroundColor: chartColors.secondary,
        borderRadius: 8,
        borderSkipped: false,
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          display: false
        }
      },
      scales: {
        y: {
          beginAtZero: true,
          grid: {
            color: '#f1f5f9'
          }
        },
        x: {
          grid: {
            display: false
          }
        }
      }
    }
  });
  <% } %>

  <% if (doanhThuTheoThang != null) { %>
  const chartThang = new Chart(document.getElementById('chartThang'), {
    type: 'bar',
    data: {
      labels: [<% for (String key : doanhThuTheoThang.keySet()) { %>"Tháng <%= key %>",<% } %>],
      datasets: [{
        label: 'Doanh thu (VNĐ)',
        data: [<% for (String key : doanhThuTheoThang.keySet()) { %><%= doanhThuTheoThang.get(key) %>,<% } %>],
        backgroundColor: chartColors.success,
        borderRadius: 8,
        borderSkipped: false,
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          display: false
        }
      },
      scales: {
        y: {
          beginAtZero: true,
          grid: {
            color: '#f1f5f9'
          }
        },
        x: {
          grid: {
            display: false
          }
        }
      }
    }
  });

  const chartThangLoaiSan = new Chart(document.getElementById('chartSanTheoThang'), {
    type: 'doughnut',
    data: {
      labels: [<% for (String key : doanhThuThangTheoLoaiSan.keySet()) { %>"<%= key %>",<% } %>],
      datasets: [{
        data: [<% for (String key : doanhThuThangTheoLoaiSan.keySet()) { %><%= doanhThuThangTheoLoaiSan.get(key) %>,<% } %>],
        backgroundColor: [chartColors.primary, chartColors.secondary, chartColors.success, chartColors.info],
        borderWidth: 0,
        cutout: '60%'
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          position: 'bottom',
          labels: {
            padding: 20,
            usePointStyle: true
          }
        }
      }
    }
  });

  const chartGioTheoThang = new Chart(document.getElementById('chartGioTheoThang'), {
    type: 'bar',
    data: {
      labels: [<% for (String key : soLuongSanTheoGioTheoThang.keySet()) { %>"<%= key %>h",<% } %>],
      datasets: [{
        label: 'Số lượt đặt',
        data: [<% for (String key : soLuongSanTheoGioTheoThang.keySet()) { %><%= soLuongSanTheoGioTheoThang.get(key) %>,<% } %>],
        backgroundColor: chartColors.secondary,
        borderRadius: 8,
        borderSkipped: false,
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          display: false
        }
      },
      scales: {
        y: {
          beginAtZero: true,
          grid: {
            color: '#f1f5f9'
          }
        },
        x: {
          grid: {
            display: false
          }
        }
      }
    }
  });
  <% } %>

  const chartLoaiSan = new Chart(document.getElementById('chartLoaiSan'), {
    type: 'doughnut',
    data: {
      labels: [<% for (String key : doanhThuTheoLoaiSan.keySet()) { %>"<%= key %>",<% } %>],
      datasets: [{
        data: [<% for (String key : doanhThuTheoLoaiSan.keySet()) { %><%= doanhThuTheoLoaiSan.get(key) %>,<% } %>],
        backgroundColor: [chartColors.primary, chartColors.secondary, chartColors.success, chartColors.info],
        borderWidth: 0,
        cutout: '60%'
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          position: 'bottom',
          labels: {
            padding: 20,
            usePointStyle: true
          }
        }
      }
    }
  });

  const chartGio = new Chart(document.getElementById('chartGio'), {
    type: 'bar',
    data: {
      labels: [<% for (String key : soLuongSanTheoGio.keySet()) { %>"<%= key %>h",<% } %>],
      datasets: [{
        label: 'Số lượt đặt',
        data: [<% for (String key : soLuongSanTheoGio.keySet()) { %><%= soLuongSanTheoGio.get(key) %>,<% } %>],
        backgroundColor: chartColors.secondary,
        borderRadius: 8,
        borderSkipped: false,
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          display: false
        }
      },
      scales: {
        y: {
          beginAtZero: true,
          grid: {
            color: '#f1f5f9'
          }
        },
        x: {
          grid: {
            display: false
          }
        }
      }
    }
  });

  // Add animation to chart sections
  document.addEventListener('DOMContentLoaded', function() {
    const chartSections = document.querySelectorAll('.chart-section');
    chartSections.forEach((section, index) => {
      section.style.opacity = '0';
      section.style.transform = 'translateY(30px)';
      section.style.transition = 'all 0.6s ease-out';

      setTimeout(() => {
        section.style.opacity = '1';
        section.style.transform = 'translateY(0)';
      }, index * 200);
    });

    // Add loading state to filter button
    const filterForm = document.querySelector('form');
    const filterBtn = document.querySelector('.filter-btn');

    filterForm.addEventListener('submit', function() {
      filterBtn.innerHTML = '<div class="loading"></div> Đang tải...';
      filterBtn.disabled = true;
    });
  });
</script>

</body>
</html>
