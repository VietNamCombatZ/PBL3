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

  <%
    Map<String, Integer> doanhThuTheoNgay = (Map<String, Integer>) request.getAttribute("doanhThuTheoNgay");
    Map<String, Integer> doanhThuTheoTuan = (Map<String, Integer>) request.getAttribute("doanhThuTheoTuan");
    Map<String, Integer> doanhThuTheoThang = (Map<String, Integer>) request.getAttribute("doanhThuTheoThang");
    Map<String, Integer> doanhThuTheoLoaiSan = (Map<String, Integer>) request.getAttribute("doanhThuTheoLoaiSan");
    Map<String, Integer> soLuongSanTheoGio = (Map<String, Integer>) request.getAttribute("soLuongSanTheoGio");
  %>

  <div class="chart-section">
    <h2>1. Doanh thu theo ngày</h2>
    <canvas id="chartNgay"></canvas>
  </div>

  <div class="chart-section">
    <h2>2. Doanh thu theo tuần</h2>
    <canvas id="chartTuan"></canvas>
  </div>

  <div class="chart-section">
    <h2>3. Doanh thu theo tháng</h2>
    <canvas id="chartThang"></canvas>
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

<script>
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
