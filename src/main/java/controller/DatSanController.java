package controller;

import model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import DAO.*;

import java.io.PrintWriter;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet("/datSan/*")

public class DatSanController extends BaseController{
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo() == null ? "/" : req.getPathInfo();
        System.out.println("Path: " + path);

        switch (path) {
//            case "/taoLichDat":
//                render(req, resp, "taoLichDat");
//                break;
            case "/lichDatCaNhan":
                render(req, resp, "lichDatCuaToi");
                break;
            case "/lichDatKhachHang":
//                render(req, resp, "lichDatCuaKhachHang");
                layLichDatCuaKhachHang(req, resp);
                break;

            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo() == null ? "/" : req.getPathInfo();
        System.out.println("Path: " + path);

        switch (path) {
            case "/taoLichDat":
                taoLichDat(req, resp);
                break;

            case "/lichDatKhachHang":
                    layLichDatCuaKhachHang(req, resp);
                    break;

case "/huyDatSan":
    khachHangHuyDatSan(req,resp);
    break;


            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }


    }

//    private void taoLichDat(HttpServletRequest req, HttpServletResponse resp) throws IOException {
//        try {
//
//            int idSanBong = Integer.parseInt(req.getParameter("idSanBong"));
//            System.out.println("timestamp tại taoLichDat trong DatSanController: " + req.getParameter("timestamp"));
//            Timestamp timestamp = Timestamp.valueOf(req.getParameter("timestamp"));
//            // Lấy user từ session hoặc request
//            nguoiDung nd = (nguoiDung) req.getSession().getAttribute("nguoiDung");
//
//            String idLichDat = UUID.randomUUID().toString();
//
//            bangGia bg = BangGiaDAO.timGiaTheoGio(timestamp);
//            if (bg == null) {
//                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Không tìm thấy bảng giá cho thời gian này");
//                return;
//            }
//            Date gioBatDau = bg.getGioBatDau();
//            Date gioKetThuc = bg.getGioKetThuc();
//            int soTien = bg.getGiaTien1Gio() * (int) ((timestamp.getTime() - gioBatDau.getTime()) / (1000 * 60 * 60));
//
//            datSan ds = new datSan();
//            ds.setId(idLichDat);
//            ds.setIdKhachHang(nd.getId());
//            ds.setIdSanBong(String.valueOf(idSanBong));
//            ds.setSoTien(soTien);
//            ds.setTrangThai(trangThaiDatSan.CHO_THANH_TOAN);
//            ds.setGioBatDau(new java.sql.Date(gioBatDau.getTime()));
//            ds.setGioKetThuc(new java.sql.Date(gioKetThuc.getTime()));
//            ds.setNgayTao(new Timestamp(System.currentTimeMillis()));
//            ds.setNgayCapNhat(new Timestamp(System.currentTimeMillis()));
//
//
//            // Gọi DAO thêm lịch đặt
//            DatSanDAO.Tao(ds);
//            System.out.println("Lịch đặt đã được tạo ở DatSanController: " + ds);
//
//            // Redirect về trang danh sách lịch đặt
////            resp.sendRedirect(req.getContextPath() + "/lichDatCuaToi");
//            render(req, resp, "lichDatCuaToi");
//        } catch (Exception e) {
//            e.printStackTrace();
//            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi đặt sân");
//        }
//    }
private void taoLichDat(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    try {
        int idSanBong = Integer.parseInt(req.getParameter("idSanBong"));
        String timestampStartStr = req.getParameter("timestamp");
        if (timestampStartStr == null || timestampStartStr.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu thông tin thời gian đặt sân");
            return;
        }
        String timestampEndStr = req.getParameter("timestampEnd");
        if (timestampEndStr == null || timestampEndStr.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu thông tin thời gian kết thúc đặt sân");
            return;
        }

        System.out.println("thoi gian: " + timestampStartStr);

        Timestamp timestampStart = Timestamp.valueOf(timestampStartStr);
        Timestamp timestampEnd = Timestamp.valueOf(timestampEndStr);
        Date gioBatDauDatSan = new Date(timestampStart.getTime());
        Date gioKetThucDatSan = new Date(timestampEnd.getTime());
        // Lấy user từ session hoặc request
        nguoiDung nd = (nguoiDung) req.getSession().getAttribute("nguoiDung");
        if (nd == null) {
            req.getSession().setAttribute("thongBao", "Bạn cần đăng nhập để đặt sân");
//            render(req, resp, "/dangNhap");
            resp.sendRedirect(req.getContextPath() + "/nguoiDung/dangNhap");

            return;
        }

        String idLichDat = UUID.randomUUID().toString();

        bangGia bg = BangGiaDAO.timGiaTheoGio(timestampStart);
        if (bg == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Không tìm thấy bảng giá cho thời gian này");
            return;
        }
        Date gioBatDau = bg.getGioBatDau();
        Date gioKetThuc = bg.getGioKetThuc();
        int thoiGianThue = (int) ((gioKetThucDatSan.getTime() - gioBatDauDatSan.getTime()) / (1000 * 60 * 60));
        System.out.println("thoi gian thue: " + thoiGianThue);
        int soTien = bg.getGiaTien1Gio() * thoiGianThue;

        datSan ds = new datSan();
        ds.setId(idLichDat);
        ds.setIdKhachHang(nd.getId());
        ds.setIdSanBong(String.valueOf(idSanBong));
        ds.setSoTien(soTien);
        ds.setTrangThai(trangThaiDatSan.CHO_THANH_TOAN);
        ds.setGioBatDau(new java.sql.Date(gioBatDauDatSan.getTime()));
        ds.setGioKetThuc(new java.sql.Date(gioKetThucDatSan.getTime()));
        ds.setNgayTao(new Timestamp(System.currentTimeMillis()));
        ds.setNgayCapNhat(new Timestamp(System.currentTimeMillis()));


        // Gọi DAO thêm lịch đặt
        DatSanDAO.Tao(ds);
        System.out.println("Lịch đặt đã được tạo ở DatSanController: " + ds);

        // Redirect về trang danh sách lịch đặt
//        resp.sendRedirect(req.getContextPath() + "/lichDatCuaToi.jsp");
        render(req, resp, "lichDatCuaToi");
    } catch (Exception e) {
        e.printStackTrace();
        resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi đặt sân");
    }
}
private void layLichDatCuaKhachHang(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
    String idKhachHang = req.getParameter("id");

    if (idKhachHang == null || idKhachHang.isEmpty()) {
        resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu ID khách hàng");
        return;
    }

    // Tìm danh sách đặt sân của khách hàng đó
    List<datSan> lichDat = DatSanDAO.timDanhSachDatSanTheoNguoiDung(idKhachHang);
    nguoiDung khachHang = NguoiDungDAO.layNguoiDungTheoId(idKhachHang);

    // Gửi sang JSP
    req.setAttribute("lichDat", lichDat);
//    req.setAttribute("idKhachHang", idKhachHang); // optional nếu cần
    req.setAttribute("khachHang", khachHang);
    render(req, resp, "lichDatCuaKhachHang");
}
private void khachHangHuyDatSan(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
    // Lấy ID đặt sân từ request
    String idDatSan = req.getParameter("id");
    String loiDatSan = null;

    if (idDatSan == null || idDatSan.isEmpty()) {
//        resp.sendRedirect(req.getContextPath() + "/lichDatCuaToi.jsp?error=invalid_id");
        req.setAttribute("loiDatSan", "ID đặt sân không hợp lệ");
        render(req, resp, "lichDatCuaToi");
        return;
    }

    // Tìm thông tin đặt sân theo ID
    datSan ds = DatSanDAO.timDatSanTheoId(idDatSan);
    if (ds == null) {
//        resp.sendRedirect(req.getContextPath() + "/lichDatCuaToi.jsp?error=not_found");
        req.setAttribute("loiDatSan", "Không tìm thấy sân");
        render(req, resp, "lichDatCuaToi");
        return;
    }

    // Kiểm tra thời gian hiện tại và giờ bắt đầu
    Date now = new Date();
    long millisecondsToStart = ds.getGioBatDau().getTime() - now.getTime();
    long hoursToStart = millisecondsToStart / (1000 * 60 * 60);

    if (hoursToStart <= 3) {
//        resp.sendRedirect(req.getContextPath() + "/lichDatCuaToi.jsp?error=too_late_to_cancel");
        req.setAttribute("loiDatSan", "Quá thời gian huỷ sân");
        render(req, resp, "lichDatCuaToi");
        return;
    }

    // Cập nhật trạng thái đặt sân thành ĐÃ HỦY
    Map<String, Object> updates = new HashMap<>();
    updates.put("trangThai", trangThaiDatSan.DA_HUY.name());

    datSan daCapNhat = DatSanDAO.capNhatThongTinDatSan(idDatSan, updates);

    if (daCapNhat != null) {
//        resp.sendRedirect(req.getContextPath() + "/lichDatCuaToi.jsp?success=cancelled");

        render(req, resp, "lichDatCuaToi");
    } else {
//        resp.sendRedirect(req.getContextPath() + "/lichDatCuaToi.jsp?error=cancel_failed");
        req.setAttribute("loiDatSan", "lỗi không thể huỷ sân");
        render(req, resp, "lichDatCuaToi");
    }
}
}
