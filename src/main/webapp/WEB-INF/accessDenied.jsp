<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Truy cập bị từ chối</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #fefefe;
      text-align: center;
      padding-top: 80px;
    }
    .container {
      border: 2px solid #e74c3c;
      display: inline-block;
      padding: 30px;
      border-radius: 10px;
      background-color: #fff5f5;
    }
    h1 {
      color: #e74c3c;
    }
    a {
      display: inline-block;
      margin-top: 20px;
      text-decoration: none;
      background-color: #3498db;
      color: white;
      padding: 10px 20px;
      border-radius: 6px;
    }
  </style>
</head>
<body>
<div class="container">
  <h1>⛔ Truy cập bị từ chối</h1>
  <p>Bạn không có quyền truy cập vào trang này.</p>
  <p>Chỉ nhân viên hoặc quản lý mới được phép truy cập.</p>
  <a href="<%=request.getContextPath()%>/trangChu">Quay về trang chủ</a>
</div>
</body>
</html>
