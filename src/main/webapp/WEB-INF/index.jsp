<%@ page import="model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Đặt Sân Bóng Đá</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="../css/index.css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet" />
    <style>
        html {
            scroll-behavior: smooth;
        }
    </style>
</head>
<body class="bg-gray-100 font-sans">
<%
    nguoiDung nd = (nguoiDung) session.getAttribute("nguoiDung");
    vaiTro vaiTroNguoiDung = (nd != null) ? nd.getVaiTroNguoiDung() : null;

%>

<!-- Navbar -->
<%
    if(vaiTroNguoiDung == vaiTro.NHAN_VIEN || vaiTroNguoiDung == vaiTro.QUAN_LY) {

%>
<%@include file="navbar-nhanvien.jsp" %>

<%
    } else {
%>
<%@include file="navbar.jsp" %>
<%
    }
%>
<!-- Banner -->
<section id="home"  class="relative bg-cover bg-center h-[500px]" style="background-image: url('https://images.unsplash.com/photo-1509021436665-8f07dbf5bf1d?auto=format&fit=crop&w=1600&q=80');">
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
            <button class="bg-yellow-400 text-blue-900 font-bold px-4 py-2 rounded hover:bg-yellow-500 transition"><i class="fas fa-search mr-2"></i>Tìm kiếm</button>
        </div>
    </div>
</section>

<!-- Giới thiệu chức năng -->
<section class="py-16 bg-white text-center">
    <h2 class="text-3xl font-bold text-gray-800 mb-6">Chức năng nổi bật</h2>
    <div class="grid grid-cols-1 md:grid-cols-2 gap-8 max-w-5xl mx-auto px-6">
        <div>
            <i class="fas fa-search-location text-4xl text-yellow-500 mb-4"></i>
            <h3 class="text-xl font-semibold">Tìm kiếm sân bóng</h3>
            <p class="text-gray-600 mt-2">Tra cứu nhanh chóng các sân bóng theo khu vực, loại sân và thời gian trống.</p>
        </div>
        <div>
            <i class="fas fa-calendar-check text-4xl text-yellow-500 mb-4"></i>
            <h3 class="text-xl font-semibold">Đặt lịch online</h3>
            <p class="text-gray-600 mt-2">Lên lịch thi đấu dễ dàng và đặt sân chỉ với vài cú click.</p>
        </div>
    </div>
</section>

<!-- Đặc điểm nổi bật -->
<section class="bg-yellow-100 py-16 text-center">
    <h2 class="text-3xl font-bold text-gray-800 mb-8">Tại sao chọn chúng tôi?</h2>
    <div class="grid grid-cols-1 md:grid-cols-3 gap-8 max-w-6xl mx-auto px-6">
        <div>
            <i class="fas fa-futbol text-4xl text-green-600 mb-4"></i>
            <h3 class="text-xl font-semibold">20+ sân bóng hiện đại</h3>
            <p class="text-gray-700">Hệ thống liên kết với nhiều sân chất lượng cao, mặt cỏ nhân tạo chuẩn thi đấu.</p>
        </div>
        <div>
            <i class="fas fa-users text-4xl text-blue-600 mb-4"></i>
            <h3 class="text-xl font-semibold">Hơn 10.000 lượt đặt sân</h3>
            <p class="text-gray-700">Được tin tưởng và sử dụng bởi đông đảo cộng đồng thể thao.</p>
        </div>
        <div>
            <i class="fas fa-clock text-4xl text-purple-600 mb-4"></i>
            <h3 class="text-xl font-semibold">Sẵn sàng 24/7</h3>
            <p class="text-gray-700">Bạn có thể đặt sân bất kỳ lúc nào, kể cả buổi tối hoặc cuối tuần.</p>
        </div>
    </div>
</section>

<!-- Đánh giá khách hàng -->
<section class="py-16 bg-white text-center">
    <h2 class="text-3xl font-bold text-gray-800 mb-8">Khách hàng nói gì?</h2>
    <div class="grid grid-cols-1 md:grid-cols-3 gap-8 max-w-6xl mx-auto px-6">
        <div class="bg-gray-100 p-6 rounded shadow">
            <p class="italic">"Giao diện dễ dùng, đặt sân cực nhanh và tiện lợi!"</p>
            <p class="mt-4 font-semibold text-gray-700">– Huyền Trang, Hà Nội</p>
        </div>
        <div class="bg-gray-100 p-6 rounded shadow">
            <p class="italic">"Không còn phải gọi điện từng sân để hỏi lịch nữa. Tuyệt vời!"</p>
            <p class="mt-4 font-semibold text-gray-700">– Minh Đức, Đà Nẵng</p>
        </div>
        <div class="bg-gray-100 p-6 rounded shadow">
            <p class="italic">"Sân được review rõ ràng, đặt sân xong nhận xác nhận liền tay."</p>
            <p class="mt-4 font-semibold text-gray-700">– Phương Anh, TP.HCM</p>
        </div>
    </div>
</section>

<!-- Footer -->

<%@include file="footer.jsp" %>
<%--<footer class="bg-gray-800 text-white py-10 mt-10">--%>
<%--    <div class="max-w-6xl mx-auto grid grid-cols-1 md:grid-cols-3 gap-8 px-6">--%>
<%--        <!-- Giới thiệu -->--%>
<%--        <div>--%>
<%--            <h3 class="text-lg font-semibold mb-3">Giới thiệu</h3>--%>
<%--            <p class="text-gray-300">Hệ thống quản lý sân bóng giúp người chơi dễ dàng tìm kiếm, đặt lịch và theo dõi tình trạng sân nhanh chóng, chính xác.</p>--%>
<%--        </div>--%>
<%--        <!-- Thông tin liên hệ -->--%>
<%--        <div>--%>
<%--            <h3 class="text-lg font-semibold mb-3">Thông tin</h3>--%>
<%--            <p class="text-gray-300"><i class="fas fa-envelope mr-2"></i>support@sanbongpro.vn</p>--%>
<%--            <p class="text-gray-300"><i class="fas fa-map-marker-alt mr-2"></i>123 Đường Bóng Đá, Quận Thể Thao, TP. Việt Nam</p>--%>
<%--            <p class="text-gray-300"><i class="fas fa-phone mr-2"></i>0123 456 789</p>--%>
<%--        </div>--%>
<%--        <!-- Mạng xã hội -->--%>
<%--        <div>--%>
<%--            <h3 class="text-lg font-semibold mb-3">Kết nối với chúng tôi</h3>--%>
<%--            <div class="flex space-x-4 mt-2">--%>
<%--                <a href="#" class="text-white text-2xl hover:text-blue-400"><i class="fab fa-facebook"></i></a>--%>
<%--                <a href="#" class="text-white text-2xl hover:text-red-500"><i class="fas fa-envelope"></i></a>--%>
<%--                <a href="#" class="text-white text-2xl hover:text-pink-500"><i class="fab fa-tiktok"></i></a>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--    <p class="text-center text-gray-400 mt-8 text-sm">© 2025 SanBongPro.vn - All rights reserved.</p>--%>
<%--</footer>--%>

</body>
</html>
