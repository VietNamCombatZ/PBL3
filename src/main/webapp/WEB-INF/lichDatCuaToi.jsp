<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    String loiDatSan = (String) request.getAttribute("loiDatSan");
//    List<datSan> lichDat = (List<datSan>) request.getAttribute("lichDat");
    nguoiDung thongTinNguoiDungDatSan = (nguoiDung) session.getAttribute("nguoiDung");
    if (thongTinNguoiDungDatSan == null) {
        // Nếu người dùng chưa đăng nhập, chuyển hướng về trang đăng nhập
        response.sendRedirect(request.getContextPath() + "/nguoiDung/dangNhap");

        return;
    }
    List<datSan> lichDat = DatSanDAO.timDanhSachDatSanTheoNguoiDung(thongTinNguoiDungDatSan.getId());
    System.out.println("lichDat: " + lichDat);


    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lịch đặt sân của tôi</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">

<%--navbar--%>
<%@include file="navbar.jsp" %>

<%--body--%>
<div class="max-w-4xl mx-auto bg-white p-6 rounded shadow">
    <h2 class="text-2xl font-bold mb-4">Lịch đặt sân của tôi</h2>

    <%
        if (lichDat == null || lichDat.isEmpty()) {
    %>
    <p>Không có lịch đặt nào.</p>
    <%
    } else {

    %>
    <% if (loiDatSan != null) { %>
    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
        <strong>Lỗi:</strong> <%= loiDatSan %>
    </div>
    <% } %>
    <table class="w-full border border-collapse">
        <thead>
        <tr class="bg-gray-200">
<%--            <th class="border px-4 py-2">ID đặt</th>--%>
            <th class="border px-4 py-2">Tên sân</th>
            <th class="border px-4 py-2">Giờ bắt đầu</th>
            <th class="border px-4 py-2">Giờ kết thúc</th>
            <th class="border px-4 py-2">Số tiền</th>
            <th class="border px-4 py-2">Trạng thái</th>
            <th class="border px-4 py-2">Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <%
            Date now = new Date();
            for (datSan ds : lichDat) {
                String idSan = ds.getIdSanBong();
                sanBong sb = SanBongDAO.timSanTheoId(idSan);
                if (sb == null) {
                    continue; // Nếu không tìm thấy sân, bỏ qua
                }


                Date gioBatDau = ds.getGioBatDau();
                Date gioKetThuc = ds.getGioKetThuc();

                long millisToStart = gioBatDau.getTime() - now.getTime();
                boolean coTheHuy = millisToStart > 3 * 60 * 60 * 1000 && ds.getTrangThai() != trangThaiDatSan.DA_HUY; // > 3 giờ trước giờ bắt đầu và sân chưa huỷ
                boolean coTheDanhGia = now.after(gioKetThuc); // đã kết thúc
        %>
        <tr>
<%--            <td class="border px-4 py-2"><%= ds.getId() %></td>--%>
            <td class="border px-4 py-2"><%= sb.getTenSan() %></td>
            <td class="border px-4 py-2"><%= sdf.format(gioBatDau) %></td>
            <td class="border px-4 py-2"><%= sdf.format(gioKetThuc) %></td>
            <td class="border px-4 py-2"><%= ds.getSoTien() %> VNĐ</td>
            <td class="border px-4 py-2"><%= ds.getTrangThai().toString() %></td>

            <td class="border px-4 py-2">
                <div class="flex space-x-[15px]">
                    <% if (coTheDanhGia) { %>
                    <form action="<%= request.getContextPath() %>/danhGia/taoDanhGia" method="get">
                        <input type="hidden" name="idDatSan" value="<%= ds.getId() %>" />
                        <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white px-3 py-1 rounded">
                            Đánh giá
                        </button>
                    </form>

                    <form action="<%= request.getContextPath() %>/danhGia/chinhSua" method="get">
                        <input type="hidden" name="idDatSan" value="<%= ds.getId() %>" />
                        <button type="submit" class="bg-yellow-500 hover:bg-yellow-600 text-white px-3 py-1 rounded">
                            Chỉnh sửa
                        </button>
                    </form>
                    <% } %>
                </div>

                <% if (coTheHuy) { %>
                <form action="<%= request.getContextPath() %>/datSan/chinhSuaDatSan" method="get" onsubmit="return confirm('Bạn có chắc chắn muốn hủy lịch đặt này không?');" class="mt-2">
                    <input type="hidden" name="idDatSan" value="<%= ds.getId() %>" />
                    <button type="submit" class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded">
                        Chỉnh sửa lịch đặt
                    </button>
                </form>

                <form action="<%= request.getContextPath() %>/datSan/huyDatSan" method="post" onsubmit="return confirm('Bạn có chắc chắn muốn hủy lịch đặt này không?');" class="mt-2">
                    <input type="hidden" name="idDatSan" value="<%= ds.getId() %>" />
                    <button type="submit" class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded">
                        Hủy đặt
                    </button>
                </form>
                <% } %>
            </td>

        </tr>
        <%
            }
        %>
        </tbody>

    </table>
    <%
        }
    %>
</div>
</body>
</html>
