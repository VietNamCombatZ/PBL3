<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.*, java.util.*" %>
<%@ page import="DAO.*, DAO.DanhGiaDAO" %>
<%@ page session="true" %>
<%
    String idDatSan = request.getParameter("idDatSan");
    datSan ds = DatSanDAO.timDatSanTheoId(idDatSan);
    danhGia danhGiaKhachHang = DanhGiaDAO.timDanhGiaTheoDatSan(idDatSan);

    if (ds == null || danhGiaKhachHang == null) {
        response.sendRedirect(request.getContextPath() + "/quanLy/danhSachDatSan");
        return;
    }
    nguoiDung kh = NguoiDungDAO.layNguoiDungTheoId(danhGiaKhachHang.getIdKhachHang());
    sanBong sb = SanBongDAO.timSanTheoId(ds.getIdSanBong());
%>

<!DOCTYPE html>
<html>
<head>
    <title>Đánh Giá Của Khách Hàng</title>
    <link rel="stylesheet" href="modern-style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
</head>
<body>

<%@ include file="navbar-nhanvien.jsp" %>

<div class="page-header">
    <div class="container">
        <h1 class="page-title">Đánh Giá Của Khách Hàng</h1>
        <p class="page-subtitle">Chi tiết đánh giá và phản hồi từ khách hàng</p>
    </div>
</div>

<div class="container" style="max-width: 800px; margin: 0 auto; padding: 0 2rem;">
    <div class="modern-card fade-in">
        <div class="modern-card-header">
            <h2 class="modern-card-title">
                <i class="fas fa-star" style="color: var(--primary-yellow); margin-right: 0.5rem;"></i>
                Thông tin đánh giá
            </h2>
        </div>

        <div class="modern-form-group">
            <label class="modern-form label">Khách hàng:</label>
            <div class="modern-form input" style="background: #f8fafc; border: 2px solid #e2e8f0; font-weight: 600;">
                <i class="fas fa-user" style="margin-right: 0.5rem; color: var(--primary-blue);"></i>
                <%= kh.getTen() %>
            </div>
        </div>

        <div class="modern-form-group">
            <label class="modern-form label">Sân bóng:</label>
            <div class="modern-form input" style="background: #f8fafc; border: 2px solid #e2e8f0; font-weight: 600;">
                <i class="fas fa-futbol" style="margin-right: 0.5rem; color: var(--primary-blue);"></i>
                <%= sb.getTenSan() %>
            </div>
        </div>

        <div class="modern-form-group">
            <label class="modern-form label">Ngày đặt:</label>
            <div class="modern-form input" style="background: #f8fafc; border: 2px solid #e2e8f0;">
                <i class="fas fa-calendar" style="margin-right: 0.5rem; color: var(--primary-blue);"></i>
                <%= ds.getGioBatDau() %>
            </div>
        </div>

        <div class="modern-form-group">
            <label class="modern-form label">Mức đánh giá:</label>
            <div class="modern-form input" style="background: var(--light-yellow); border: 2px solid var(--primary-yellow); font-weight: 600;">
                <i class="fas fa-star" style="margin-right: 0.5rem; color: var(--secondary-yellow);"></i>
                <%= danhGiaKhachHang.getMucDiem().name().replace("_", " ") %>
            </div>
        </div>

        <div class="modern-form-group">
            <label class="modern-form label">Nội dung đánh giá:</label>
            <div class="modern-form textarea" style="background: #f8fafc; border: 2px solid #e2e8f0; min-height: 100px; padding: 1rem;">
                <i class="fas fa-comment" style="margin-right: 0.5rem; color: var(--primary-blue);"></i>
                <%= danhGiaKhachHang.getNoiDung() %>
            </div>
        </div>

        <div class="modern-form-group">
            <label class="modern-form label">Ngày đánh giá:</label>
            <div class="modern-form input" style="background: #f8fafc; border: 2px solid #e2e8f0;">
                <i class="fas fa-clock" style="margin-right: 0.5rem; color: var(--primary-blue);"></i>
                <%= danhGiaKhachHang.getNgayTao() %>
            </div>
        </div>
    </div>
</div>

<%--footer--%>
<%@include file="footer.jsp" %>

</body>
</html>
