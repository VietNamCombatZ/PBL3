<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.util.Map" %>
<html>
<head>
  <title>Thống kê doanh thu</title>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 20px;
      background-color: #f2f2f2;
    }

    h1 {
      text-align: center;
      color: #333;
    }

    h2 {
      margin-top: 40px;
      color: #444;
    }

    canvas {
      display: block;
      margin: 0 auto 40px auto;
      max-width: 800px;
      background-color: white;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      padding: 20px;
    }

    .chart-section {
      background-color: #ffffff;
      padding: 30px;
      border-radius: 15px;
      margin-bottom: 50px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    .container {
      width: 90%;
      max-width: 1000px;
      margin: 0 auto;
    }
  </style>
</head>
<body>

<%@include file="navbar-nhanvien.jsp" %>

<div class="container">
  <h1>Thống kê doanh thu</h1>
  <form action="<%= request.getContextPath() %>/doanhThu" method="post" style="margin-bottom: 40px; background-color: #fff; padding: 20px; border-radius: 10px;">
    <h2>Lọc theo thời gian</h2>

    <div style="margin-bottom: 15px;">
      <label>🔹 Từ ngày:</label>
      <input type="date" name="tuNgay" />
      <label>Đến ngày:</label>
      <input type="date" name="denNgay" />
    </div>

    <div style="margin-bottom: 15px;">
      <label>🔹 Từ tuần:</label>
      <input type="week" name="tuTuan" />
      <label>Đến tuần:</label>
      <input type="week" name="denTuan" />
    </div>

    <div style="margin-bottom: 15px;">
      <label>🔹 Từ tháng:</label>
      <input type="month" name="tuThang" />
      <label>Đến tháng:</label>
      <input type="month" name="denThang" />
    </div>

    <button type="submit" style="padding: 10px 20px; background-color: #007BFF; color: white; border: none; border-radius: 5px; cursor: pointer;">Lọc thống kê</button>
  </form>

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

  <div class="chart-section">
    <h2>1. Doanh thu theo ngày</h2>
    <canvas id="chartNgay"></canvas>
    <h2>Doanh thu sân theo ngày</h2>
    <canvas id="chartSanTheoNgay"></canvas>
    <h2>Số lượng sân được đặt theo giờ</h2>
    <canvas id="chartGioTheoNgay"></canvas>

  </div>

  <div class="chart-section">
    <h2>2. Doanh thu theo tuần</h2>
    <canvas id="chartTuan"></canvas>

    <h2>Doanh thu sân theo tuần</h2>
    <canvas id="chartSanTheoTuan"></canvas>

    <h2>Số lượng sân được đặt theo giờ</h2>
    <canvas id="chartGioTheoTuan"></canvas>
  </div>

  <div class="chart-section">
    <h2>3. Doanh thu theo tháng</h2>
    <canvas id="chartThang"></canvas>
    <h2>Doanh thu sân theo tháng</h2>
    <canvas id="chartSanTheoThang"></canvas>
    <h2>Số lượng sân được đặt theo giờ</h2>
    <canvas id="chartGioTheoThang"></canvas>
  </div>

          <div class="chart-section">
          <h2>4. Doanh thu theo loại sân</h2>
  <canvas id="chartLoaiSan"></canvas>
  </div>

  <div class="chart-section">
    <h2>5. Số lượng sân được đặt theo giờ</h2>
    <canvas id="chartGio"></canvas>
  </div>
  </div>

<%--footer--%>
<%@include file="footer.jsp" %>

  <script>
    <% if (doanhThuTheoNgay != null) { %>
    const chartNgay = new Chart(document.getElementById('chartNgay'), {
    type: 'bar',
    data: {
    labels: [<% for (String key : doanhThuTheoNgay.keySet()) { %>"<%= key %>",<% } %>],
    datasets: [{
    label: 'Doanh thu',
    data: [<% for (String key : doanhThuTheoNgay.keySet()) { %><%= doanhThuTheoNgay.get(key) %>,<% } %>],
    backgroundColor: 'rgba(255, 99, 132, 0.5)'
  }]
  }
  });

    const chartNgayLoaiSan = new Chart(document.getElementById('chartSanTheoNgay'), {
    type: 'pie',
    data: {
      labels: [<% for (String key : doanhThuNgayTheoLoaiSan.keySet()) { %>"<%= key %>",<% } %>],
      datasets: [{
        label: 'Doanh thu',
        data: [<% for (String key : doanhThuNgayTheoLoaiSan.keySet()) { %><%= doanhThuNgayTheoLoaiSan.get(key) %>,<% } %>],
        backgroundColor: ['#ff6384', '#36a2eb', '#ffcd56', '#4bc0c0']
      }]
    }
  });

    const chartGioTheoNgay = new Chart(document.getElementById('chartGioTheoNgay'), {
      type: 'bar',
      data: {
        labels: [<% for (String key : soLuongSanTheoGioTheoNgay.keySet()) { %>"<%= key %>",<% } %>],
        datasets: [{
          label: 'Số lượng đặt sân',
          data: [<% for (String key : soLuongSanTheoGioTheoNgay.keySet()) { %><%= soLuongSanTheoGioTheoNgay.get(key) %>,<% } %>],
          backgroundColor: 'rgba(75, 192, 192, 0.5)'
        }]
      }
    });
  <% } %>

    <% if (doanhThuTheoTuan != null) { %>
  const chartTuan = new Chart(document.getElementById('chartTuan'), {
    type: 'line',
    data: {
      labels: [<% for (String key : doanhThuTheoTuan.keySet()) { %>"<%= key %>",<% } %>],
      datasets: [{
        label: 'Doanh thu',
        data: [<% for (String key : doanhThuTheoTuan.keySet()) { %><%= doanhThuTheoTuan.get(key) %>,<% } %>],
        backgroundColor: 'rgba(54, 162, 235, 0.5)',
        borderColor: 'blue',
        borderWidth: 2,
        fill: false
      }]
    }
  });

    const chartTuanLoaiSan = new Chart(document.getElementById('chartSanTheoTuan'), {
      type: 'pie',
      data: {
        labels: [<% for (String key : doanhThuTuanTheoLoaiSan.keySet()) { %>"<%= key %>",<% } %>],
        datasets: [{
          label: 'Doanh thu',
          data: [<% for (String key : doanhThuTuanTheoLoaiSan.keySet()) { %><%= doanhThuTuanTheoLoaiSan.get(key) %>,<% } %>],
          backgroundColor: ['#ff6384', '#36a2eb', '#ffcd56', '#4bc0c0']
        }]
      }
    });


    const chartGioTheoTuan = new Chart(document.getElementById('chartGioTheoTuan'), {
      type: 'bar',
      data: {
        labels: [<% for (String key : soLuongSanTheoGioTheoTuan.keySet()) { %>"<%= key %>",<% } %>],
        datasets: [{
          label: 'Số lượng đặt sân',
          data: [<% for (String key : soLuongSanTheoGioTheoTuan.keySet()) { %><%= soLuongSanTheoGioTheoTuan.get(key) %>,<% } %>],
          backgroundColor: 'rgba(75, 192, 192, 0.5)'
        }]
      }
    });
    <% } %>

    <% if (doanhThuTheoThang != null) { %>
  const chartThang = new Chart(document.getElementById('chartThang'), {
    type: 'bar',
    data: {
      labels: [<% for (String key : doanhThuTheoThang.keySet()) { %>"<%= key %>",<% } %>],
      datasets: [{
        label: 'Doanh thu',
        data: [<% for (String key : doanhThuTheoThang.keySet()) { %><%= doanhThuTheoThang.get(key) %>,<% } %>],
        backgroundColor: 'rgba(255, 206, 86, 0.5)'
      }]
    }
  });

    const chartThangLoaiSan = new Chart(document.getElementById('chartSanTheoThang'), {
      type: 'pie',
      data: {
        labels: [<% for (String key : doanhThuThangTheoLoaiSan.keySet()) { %>"<%= key %>",<% } %>],
        datasets: [{
          label: 'Doanh thu',
          data: [<% for (String key : doanhThuThangTheoLoaiSan.keySet()) { %><%= doanhThuThangTheoLoaiSan.get(key) %>,<% } %>],
          backgroundColor: ['#ff6384', '#36a2eb', '#ffcd56', '#4bc0c0']
        }]
      }
    });


    const chartGioTheoThang = new Chart(document.getElementById('chartGioTheoThang'), {
      type: 'bar',
      data: {
        labels: [<% for (String key : soLuongSanTheoGioTheoThang.keySet()) { %>"<%= key %>",<% } %>],
        datasets: [{
          label: 'Số lượng đặt sân',
          data: [<% for (String key : soLuongSanTheoGioTheoThang.keySet()) { %><%= soLuongSanTheoGioTheoThang.get(key) %>,<% } %>],
          backgroundColor: 'rgba(75, 192, 192, 0.5)'
        }]
      }
    });
    <% } %>

  const chartLoaiSan = new Chart(document.getElementById('chartLoaiSan'), {
    type: 'pie',
    data: {
      labels: [<% for (String key : doanhThuTheoLoaiSan.keySet()) { %>"<%= key %>",<% } %>],
      datasets: [{
        label: 'Doanh thu',
        data: [<% for (String key : doanhThuTheoLoaiSan.keySet()) { %><%= doanhThuTheoLoaiSan.get(key) %>,<% } %>],
        backgroundColor: ['#ff6384', '#36a2eb', '#ffcd56', '#4bc0c0']
      }]
    }
  });

  const chartGio = new Chart(document.getElementById('chartGio'), {
    type: 'bar',
    data: {
      labels: [<% for (String key : soLuongSanTheoGio.keySet()) { %>"<%= key %>",<% } %>],
      datasets: [{
        label: 'Số lượng đặt sân',
        data: [<% for (String key : soLuongSanTheoGio.keySet()) { %><%= soLuongSanTheoGio.get(key) %>,<% } %>],
        backgroundColor: 'rgba(75, 192, 192, 0.5)'
      }]
    }
  });
</script>

</body>
</html>
