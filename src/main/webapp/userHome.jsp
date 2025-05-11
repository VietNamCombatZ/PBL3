<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Đặt Sân Bóng Đá</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="styles.css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet" />
    <style>
        html {
            scroll-behavior: smooth;
        }
    </style>
</head>
<body class="bg-gray-100 font-sans">

<!-- Navbar -->
<header class="bg-blue-900 text-white shadow-lg sticky top-0 z-50">
    <div class="container mx-auto flex justify-between items-center px-6 py-4">
        <div class="flex items-center space-x-2 text-2xl font-bold">
            <i class="fas fa-futbol text-yellow-400"></i>
            <span>Đặt Sân</span>
            <span class="text-yellow-400">365</span>
        </div>
        <nav class="hidden md:flex space-x-6 text-sm font-medium">
            <a href="#home" class="hover:text-yellow-400">Trang chủ</a>
            <a href="#" class="hover:text-yellow-400">Danh sách sân bãi</a>
            <a href="#" class="hover:text-yellow-400">Giới thiệu</a>
            <a href="#" class="hover:text-yellow-400">Chính sách</a>
            <a href="#" class="hover:text-yellow-400">Dành cho chủ sân</a>
            <a href="#" class="hover:text-yellow-400">Liên hệ</a>
        </nav>
        <!-- Sau khi đăng nhập -->
        <div class="flex items-center space-x-4 text-sm">
            <span>👋 Chào, <strong>Nguyễn Văn A</strong></span>
            <a href="#" class="hover:text-yellow-400">Lịch sử đặt sân</a>
            <a href="#" class="hover:text-yellow-400">Thông tin cá nhân</a>
        </div>
    </div>
</header>

<!-- Banner -->
<section id="home" class="relative bg-cover bg-center h-[500px]" style="background-image: url('https://images.unsplash.com/photo-1509021436665-8f07dbf5bf1d?auto=format&fit=crop&w=1600&q=80');">
    <div class="absolute inset-0 bg-black bg-opacity-50 flex flex-col justify-center items-center text-center px-4">
        <h1 class="text-white text-4xl md:text-5xl font-bold mb-4">HỆ THỐNG HỖ TRỢ TÌM KIẾM SÂN BÓNG NHANH</h1>
        <p class="text-gray-200 mb-6 max-w-xl">Dữ liệu được cập nhật thường xuyên giúp bạn tìm sân nhanh và chính xác hơn.</p>

        <!-- Form tìm kiếm -->
        <div class="bg-white rounded-lg shadow-lg w-full max-w-3xl p-4 grid grid-cols-1 md:grid-cols-4 gap-4">
            <select class="border border-gray-300 rounded px-3 py-2 text-sm">
                <option>Loại sân</option>
                <option>5 người</option>
                <option>7 người</option>
                <option>11 người</option>
            </select>
            <input type="text" placeholder="Nhập tên sân hoặc địa chỉ..." class="border border-gray-300 rounded px-3 py-2 text-sm col-span-2" />
            <button class="bg-yellow-400 text-blue-900 font-bold px-4 py-2 rounded hover:bg-yellow-500 transition">
                <i class="fas fa-search mr-2"></i>Tìm kiếm
            </button>
        </div>

        <!-- Nút Đặt sân ngay -->
        <div class="mt-6">
            <a href="#" class="bg-green-500 text-white font-bold px-6 py-3 rounded-lg hover:bg-green-600 transition text-lg">
                <i class="fas fa-calendar-check mr-2"></i>Đặt sân ngay
            </a>
        </div>
    </div>
</section>

</body>
</html>
