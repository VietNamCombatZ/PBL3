package controller;

import DAO.NguoiDungDAO;

import model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import DAO.*;

import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

import static DAO.SanBongDAO.layDanhSachSanBong;

@WebServlet("/sanBong/*")
public class SanBongController extends BaseController{


protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    String path = req.getPathInfo() == null ? "/" : req.getPathInfo();
    System.out.println("trong doGet Path: " + path);

    switch (path) {
        case "/danhSachSanCoSan":
            System.out.println("Vao danh sach san co san");
            render(req, resp, "danhSachSanCoSan");
            break;
        case "/xemTinhTrangSan":
            System.out.println("Vao xem tinh trang san");
            // Lấy danh sách sân bóng từ DAO

            render(req, resp, "danhSachSanBong");
            break;

        case "/chinhSuaThongTinSan":
            System.out.println("Vao chinh sua thong tin san");
            // Lấy danh sách sân bóng từ DAO
            render(req, resp, "chinhSuaThongTinSanBong");
            break;
        default:
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            break;
    }
}

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo() == null ? "/" : req.getPathInfo();
        System.out.println("trong DoPost Path: " + path);

        switch (path) {
            case "/danhSachSanCoSan":
                getAvailableFields(req, resp);
                break;

//            case "/datSan/taoLichDat":
//                taoLichDat(req, resp);
//                break;
            case "/chinhSuaThongTinSan":
                System.out.println("Vao chinh sua thong tin san");
                // Lấy danh sách sân bóng từ DAO
                luuChinhSuaThongTinSanBong(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }


    }

    private void getAvailableFields(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String timestampStr = req.getParameter("timestamp");

            System.out.println("thoi gian: " + timestampStr);
            String timestampEndStr = req.getParameter("timestampEnd");

            Timestamp timestamp = Timestamp.valueOf(timestampStr);
            Timestamp timestampEnd = Timestamp.valueOf(timestampEndStr);

            List<sanBong> availableFields = SanBongDAO.LayDanhSachSanCoSan(timestamp, timestampEnd);

            System.out.println("Available fields: " + availableFields.size());

            // Gán dữ liệu vào request để JSP có thể hiển thị
            req.setAttribute("availableFields", availableFields);
            req.setAttribute("selectedTime", timestampStr);
            req.setAttribute("selectedTimeEnd", timestampEndStr);

            // Forward về lại trang JSP để hiển thị dữ liệu
//            req.getRequestDispatcher("/danhSachSanCoSan.jsp").forward(req, resp);
            render(req, resp, "danhSachSanCoSan");

        } catch (Exception e) {
            System.out.println("Đã xảy ra lỗi trong getAvailableFields:");
            e.printStackTrace();
            req.setAttribute("error", "Lỗi xử lý dữ liệu");
//            req.getRequestDispatcher("/danhSachSanCoSan.jsp").forward(req, resp);
            render(req, resp, "danhSachSanCoSan");
        }
    }
    private void luuChinhSuaThongTinSanBong(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        nguoiDung nd = (nguoiDung) req.getSession().getAttribute("nguoiDung");

        if (nd == null) {
            render(req, res, "dangNhap");
            return;
        }
        String idSanBong = req.getParameter("id");
        System.out.println("id sân bóng:" + idSanBong);

        sanBong sb = SanBongDAO.timSanTheoId(idSanBong);
        System.out.println("sanBong: " + sb);


        req.setCharacterEncoding("UTF-8");

        // Lấy dữ liệu từ form
        String tenSan = req.getParameter("tenSan");

        String kieuSan = req.getParameter("kieuSan");
        String trangThai = req.getParameter("trangThai");

        // Validate cơ bản
        if (tenSan == null || tenSan.trim().isEmpty() ||
                kieuSan == null || kieuSan.trim().isEmpty() ||
                trangThai == null || trangThai.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ thông tin bắt buộc");
            render(req, res, "chinhSuaThongTinSanBong");
            return;
        }



        // Cập nhật thông tin
//        sb.setTenSan(tenSan.trim());
//        sb.setKieuSan(loaiSan.valueOf(kieuSan));
//        sb.setTrangThai(trangThaiSan.valueOf(trangThai));



        System.out.println("== Thông tin gửi vào DAO ==");
        System.out.println("Tên sân: " + sb.getTenSan());
        System.out.println("Kiểu sân: " + sb.getKieuSan());
        System.out.println("Trạng thái: " + sb.getTrangThai());

        Map<String, Object> thongTinCapNhat = new HashMap<>();
        thongTinCapNhat.put("tenSan", tenSan);
        thongTinCapNhat.put("kieuSan", kieuSan);
        thongTinCapNhat.put("trangThai", trangThai);

        sanBong thanhCong = SanBongDAO.capNhatThongTinSan(idSanBong, thongTinCapNhat);

        if (thanhCong != null) {

            res.sendRedirect(req.getContextPath()+"/sanBong/xemTinhTrangSan");
        } else {
            req.setAttribute("error", "Cập nhật thông tin thất bại, vui lòng thử lại.");
            res.sendRedirect(req.getContextPath()+"/nguoiDung/DanhsachSanBong");
        }
    }

//

//    // đã chuyển qua datSanController
//    private void taoLichDat(HttpServletRequest req, HttpServletResponse resp) throws IOException {
//        try {
//            int idSanBong = Integer.parseInt(req.getParameter("idSanBong"));
//            String timestampStr = req.getParameter("timestamp");
//            System.out.println("thoi gian: " + timestampStr);
//
//            Timestamp timestamp = Timestamp.valueOf(timestampStr);
//            Date gioBatDauDatSan = new Date(timestamp.getTime());
//            Date gioKetThucDatSan = new Date(timestamp.getTime() + 60 * 60 * 1000); // Giả sử đặt sân trong 1 giờ
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
//            int thoiGianThue = (int) ((gioKetThucDatSan.getTime() - gioBatDauDatSan.getTime()) / (1000 * 60 * 60));
//            System.out.println("thoi gian thue: " + thoiGianThue);
//            int soTien = bg.getGiaTien1Gio() * thoiGianThue;
//
//            datSan ds = new datSan();
//            ds.setId(idLichDat);
//            ds.setIdKhachHang(nd.getId());
//            ds.setIdSanBong(String.valueOf(idSanBong));
//            ds.setSoTien(soTien);
//            ds.setTrangThai(trangThaiDatSan.CHO_THANH_TOAN);
//            ds.setGioBatDau(new java.sql.Date(gioBatDauDatSan.getTime()));
//            ds.setGioKetThuc(new java.sql.Date(gioKetThucDatSan.getTime()));
//            ds.setNgayTao(new Timestamp(System.currentTimeMillis()));
//            ds.setNgayCapNhat(new Timestamp(System.currentTimeMillis()));
//
//
//            // Gọi DAO thêm lịch đặt
//            DatSanDAO.Tao(ds);
//
//            // Redirect về trang danh sách lịch đặt
//            resp.sendRedirect(req.getContextPath() + "/lichDatCuaToi.jsp");
//        } catch (Exception e) {
//            e.printStackTrace();
//            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi đặt sân");
//        }
//    }
//
//
}



