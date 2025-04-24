<%--
  Created by IntelliJ IDEA.
  User: hatsaphonethilavong
  Date: 17/4/2025 AD
  Time: 14:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
        }

        .overlay {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .register-form {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
            padding: 30px 25px;
            width: 300px;
        }

        .register-form h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .register-form form {
            display: flex;
            flex-direction: column;
        }

        .register-form input {
            padding: 10px;
            margin-bottom: 15px;
            border: 2px solid #100f0f;
            border-radius: 4px;
        }

        .register-form button {
            background-color: rgb(39, 39, 187);
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .register-form button:hover {
            background-color: rgb(39, 39, 187);
        }

        .register-form .terms,
        .register-form .login-link {
            font-size: 12px;
            text-align: center;
            margin-top: 10px;
        }

        .register-form a {
            color: rgb(39, 39, 187);
            text-decoration: none;
        }

        .register-form a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="overlay">
    <div class="register-form">
        <h2>Đăng ký</h2>
        <form>
            <input type="email" placeholder="Email *" required>
            <input type="password" placeholder="Mật khẩu *" required>
            <input type="password" placeholder="Nhập lại mật khẩu *" required>
            <input type="tel" placeholder="Số điện thoại *" required>
            <input type="text" placeholder="Họ & tên *" required>
            <button type="submit">Đăng ký</button>
        </form>
    </div>
</div>
</body>
</html>>