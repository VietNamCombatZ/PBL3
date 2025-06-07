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
        case "/taoSanBong":
            System.out.println("Vao tao san bong");
            render(req, resp, "taoSanBong");
            break;
        case "/danhSachSanCoSan":
            System.out.println("Vao danh sach san co san");
            render(req, resp, "danhSachSanCoSan");
            break;
        case "/danhSachSanCoSanNhanVien":
            System.out.println("Vao danh sach san co san");
            render(req, resp, "danhSachSanCoSan-nhanvien");
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

            case "/taoSanBong":
                System.out.println("Vao tao san bong");
                taoSanBong(req, resp);
                break;
            case "/danhSachSanCoSan":
                getAvailableFields(req, resp);
                break;
            case "/danhSachSanCoSanNhanVien":
                getAvailableFieldsNhanVien(req, resp);
                break;


            case "/chinhSuaThongTinSan":
                System.out.println("Vao chinh sua thong tin san");
                // Lấy danh sách sân bóng từ DAO
                luuChinhSuaThongTinSanBong(req, resp);
                break;

            case "/xoaSanBong":
                xoaSanBong(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }


    }

    private void taoSanBong (HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        nguoiDung nd = (nguoiDung) req.getSession().getAttribute("nguoiDung");

        if (nd == null) {
            render(req, resp, "dangNhap");
            return;
        }

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
            render(req, resp, "taoSanBong");
            return;
        }

        sanBong existingField = SanBongDAO.timSanTheoTenSan(tenSan.trim());
        if (existingField != null) {
            req.setAttribute("error", "Sân bóng với tên này đã tồn tại");
            render(req, resp, "taoSanBong");
            return;
        }


        // Tạo đối tượng sân bóng mới
        sanBong newField = new sanBong();
        newField.setId(UUID.randomUUID().toString()); // Tạo ID ngẫu nhiên
        newField.setTenSan(tenSan.trim());
        newField.setKieuSan(loaiSan.valueOf(kieuSan));
        newField.setTrangThai(trangThaiSan.valueOf(trangThai));
        newField.setNgayTao(new Timestamp(System.currentTimeMillis()));
        newField.setNgayCapNhat(new Timestamp(System.currentTimeMillis()));

        // Gọi DAO để lưu sân bóng mới
        boolean createdField = SanBongDAO.Tao(newField);

        if (createdField) {
            resp.sendRedirect(req.getContextPath()+"/sanBong/xemTinhTrangSan");
        } else {
            req.setAttribute("error", "Tạo sân bóng thất bại, vui lòng thử lại.");
            render(req, resp, "taoSanBong");
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
    private void getAvailableFieldsNhanVien(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
            render(req, resp, "danhSachSanCoSan-nhanvien");

        } catch (Exception e) {
            System.out.println("Đã xảy ra lỗi trong getAvailableFields:");
            e.printStackTrace();
            req.setAttribute("error", "Lỗi xử lý dữ liệu");
//            req.getRequestDispatcher("/danhSachSanCoSan.jsp").forward(req, resp);
            render(req, resp, "danhSachSanCoSan-nhanvien");
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

    private void xoaSanBong( HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        nguoiDung nd = (nguoiDung) req.getSession().getAttribute("nguoiDung");

        if (nd == null) {
            render(req, resp, "dangNhap");
            return;
        }

        String idSanBong = req.getParameter("id");
        System.out.println("ID sân bóng cần xóa: " + idSanBong);

        boolean xoaThanhCong = SanBongDAO.xoa(idSanBong);

        if (xoaThanhCong) {
            resp.sendRedirect(req.getContextPath()+"/sanBong/xemTinhTrangSan");
        } else {
            req.setAttribute("error", "Xóa sân bóng thất bại, vui lòng thử lại.");
            resp.sendRedirect(req.getContextPath()+"/sanBong/xemTinhTrangSan");
        }
    }

}



