package controller;

import DAO.NguoiDungDAO;

import model.nguoiDung;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.vaiTro;

import java.io.IOException;

import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet("/nguoiDung/*")
public class NguoiDungController  extends BaseController {
    private NguoiDungDAO dao;


    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getPathInfo() == null ? "/" : request.getPathInfo();
        System.out.println("Path ở doGet: " + path);
        switch (path) {
            case "/dangKy":
                render(request, response, "dangKy");
                break;
            case "/dangNhap":
//
                render(request, response, "dangNhap");
                break;
            case "/dangXuat":
                dangXuat(request, response);
            case "/DanhsachKhachHang":
                layDanhSachKhachHang(request, response);
                break;
            case  "/DanhsachNhanVien" :
                layDanhSachNhanVien(request, response);
                break;

            case "/thongTinCaNhan":
                layThongTinCaNhan(request, response);
                break;

            case "/chinhSuaThongTinCaNhan":
                hienThiChinhSuaThongTinCaNhan(request, response);
                break;
            case "/chinhSuaThongTinKhachHang":
                hienThiChinhSuaThongTinKhachHang(request, response);
                break;

            case "/chinhSuaThongTinNhanVien":
                hienThiChinhSuaThongTinNhanVien(request, response);
                break;

            case "/taoKhachHang":
                render(request, response, "taoKhachHang");
                break;

            case "/taoNhanVien":
                render(request, response, "taoNhanVien");
                break;
//            case "/capNhatThongTin":
//                capNhatThongTin(request, response);
//                break;

            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getPathInfo() == null ? "/" : request.getPathInfo();
        System.out.println("Path ở doPost: " + path);
        switch (path) {
            case "/dangKy":
                dangKy(request, response);
                break;
            case "/dangNhap":
                dangNhap(request, response);
                break;

            case "/chinhSuaThongTinCaNhan":
                luuChinhSuaThongTinCaNhan(request, response);
                break;
            case "/chinhSuaThongTinKhachHang":
                luuChinhSuaThongTinKhachHang(request, response);
                break;

            case "/chinhSuaThongTinNhanVien":
                luuChinhSuaThongTinNhanVien(request, response);
                break;

                case "/taoKhachHang":
                    taoKhachHang(request, response);
                    break;
            case "/taoNhanVien":
                taoNhanVien(request, response);
                break;

            case "/xoaKhachHang":
                xoaKhachHang(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    private void taoKhachHang(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String ten = req.getParameter("ten");
        String email = req.getParameter("email");
        String matkhau = req.getParameter("matkhau");
        String nhaplaimatkhau = req.getParameter("nhaplaimatkhau");
        String ngaysinhStr = req.getParameter("ngaysinh");

        nguoiDung nguoiDungDaTonTai = NguoiDungDAO.layNguoiDungTheoEmail(email);
        if (nguoiDungDaTonTai != null) {
            req.setAttribute("error", "Email đã tồn tại");
            render(req, resp, "taoKhachHang");
        }

        // Kiểm tra mật khẩu khớp nhau
        if (!matkhau.equals(nhaplaimatkhau)) {
            req.setAttribute("error", "Mật khẩu không khớp");
//            req.getRequestDispatcher("taoKhachHang.jsp").forward(req, resp);
            render(req, resp, "taoKhachHang");
            return;
        }

        // Chuyển String -> java.sql.Date
        java.sql.Date ngaySinh = null;
        try {
            ngaySinh = java.sql.Date.valueOf(ngaysinhStr); // format yyyy-MM-dd
        } catch (IllegalArgumentException e) {
            req.setAttribute("error", "Ngày sinh không hợp lệ");
//            req.getRequestDispatcher("taoKhachHang.jsp").forward(req, resp);
            render(req, resp, "taoKhachHang");
            return;

        }

        // Tạo đối tượng người dùng
        nguoiDung user = new nguoiDung();
        user.setId(UUID.randomUUID().toString()); //sinh id ngẫu nhiên
        user.setTen(ten);
        user.setEmail(email);
        user.setMatKhau(matkhau);
        user.setNgaySinh(ngaySinh);
        user.setVaiTroNguoiDung(vaiTro.KHACH_HANG); // mặc định

        boolean thanhCong = NguoiDungDAO.Tao(user);

        if (thanhCong) {
//            resp.sendRedirect("dangNhap.jsp");
//            render(req, resp, "dangNhap");
            resp.sendRedirect(req.getContextPath() + "/nguoiDung/DanhsachKhachHang");

        } else {
            req.setAttribute("error", "Đăng ký thất bại (vui lòng thử lại)");
            render(req, resp, "taoKhachHang");
//            req.getRequestDispatcher("dangKy.jsp").forward(req, resp);
        }
    }
    private void taoNhanVien(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String ten = req.getParameter("ten");
        String email = req.getParameter("email");
        String matkhau = req.getParameter("matKhau");
        String nhaplaimatkhau = req.getParameter("nhapLaiMatKhau");
        String ngaysinhStr = req.getParameter("ngaySinh");
        String vaiTroNguoiDung = req.getParameter("vaiTro");


        System.out.println("Tên: " + ten);
        System.out.println("Email: " + email);
        System.out.println("Mật khẩu: " + matkhau);
        System.out.println("Nhập lại mật khẩu: " + nhaplaimatkhau);
        System.out.println("Ngày sinh: " + ngaysinhStr);
        System.out.println("Vai trò người dùng: " + vaiTroNguoiDung);

        nguoiDung nguoiDungDaTonTai = NguoiDungDAO.layNguoiDungTheoEmail(email);
        if (nguoiDungDaTonTai != null) {
            System.out.print("Email đã tồn tại");
            req.setAttribute("error", "Email đã tồn tại");
            render(req, resp, "taoNhanVien");
        }

        // Kiểm tra mật khẩu khớp nhau
        if (!matkhau.equals(nhaplaimatkhau)) {
            System.out.print("Mật khẩu không khớp");
            req.setAttribute("error", "Mật khẩu không khớp");
//            req.getRequestDispatcher("taoNhanVien.jsp").forward(req, resp);
            render(req, resp, "taoNhanVien");
            return;
        }

        if (ten == null || ten.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                ngaysinhStr == null || ngaysinhStr.trim().isEmpty() ||
                vaiTroNguoiDung == null || vaiTroNguoiDung.trim().isEmpty()) {
            System.out.print("Vui lòng nhập đầy đủ thông tin bắt buộc");
            req.setAttribute("error", "Vui lòng nhập đầy đủ thông tin bắt buộc");
            render(req, resp, "taoNhanVien");
            return;
        }

        // Chuyển String -> java.sql.Date
        java.sql.Date ngaySinh = null;
        try {
            ngaySinh = java.sql.Date.valueOf(ngaysinhStr); // format yyyy-MM-dd
        } catch (IllegalArgumentException e) {
            System.out.print("Ngày sinh không hợp lệ");
            req.setAttribute("error", "Ngày sinh không hợp lệ");
//            req.getRequestDispatcher("taoNhanVien.jsp").forward(req, resp);
            render(req, resp, "taoNhanVien");
            return;

        }

        // Tạo đối tượng người dùng
        nguoiDung user = new nguoiDung();
        user.setId(UUID.randomUUID().toString()); //sinh id ngẫu nhiên
        user.setTen(ten);
        user.setEmail(email);
        user.setMatKhau(matkhau);
        user.setNgaySinh(ngaySinh);
        user.setVaiTroNguoiDung(vaiTro.valueOf(vaiTroNguoiDung));

        System.out.println("Vai trò người dùng: " + user.getVaiTroNguoiDung());

        boolean thanhCong = NguoiDungDAO.Tao(user);

        if (thanhCong) {
//            resp.sendRedirect("dangNhap.jsp");
//            render(req, resp, "dangNhap");
            resp.sendRedirect(req.getContextPath() + "/nguoiDung/DanhsachNhanVien");

        } else {
            req.setAttribute("error", "Đăng ký thất bại (vui lòng thử lại)");
            render(req, resp, "taoNhanVien");
//            req.getRequestDispatcher("dangKy.jsp").forward(req, resp);
        }
    }

    private void luuChinhSuaThongTinCaNhan(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        nguoiDung nd = (nguoiDung) req.getSession().getAttribute("nguoiDung");

        if (nd == null) {
            render(req, res, "dangNhap");
            return;
        }



        req.setCharacterEncoding("UTF-8");

        // Lấy dữ liệu từ form
        String ten = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String ngaySinhStr = req.getParameter("ngaySinh");

        // Validate cơ bản
        if (ten == null || ten.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                ngaySinhStr == null || ngaySinhStr.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ thông tin bắt buộc");
            render(req, res, "chinhSuaThongTinCaNhan");
            return;
        }

        // Chuyển đổi ngày sinh
        java.sql.Date ngaySinh = null;
        try {
            ngaySinh = java.sql.Date.valueOf(ngaySinhStr); // định dạng yyyy-MM-dd
        } catch (IllegalArgumentException e) {
            req.setAttribute("error", "Ngày sinh không hợp lệ");
            render(req, res, "chinhSuaThongTinCaNhan");
            return;
        }

        // Cập nhật thông tin
        nd.setTen(ten.trim());
        nd.setEmail(email.trim());
        nd.setNgaySinh(ngaySinh);

        // Nếu người dùng nhập mật khẩu mới thì cập nhật
        if (password != null && !password.trim().isEmpty()) {
            if (password.length() < 6) {
                req.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự");
                render(req, res, "chinhSuaThongTinCaNhan");
                return;
            }
            nd.setMatKhau(password.trim()); // Hoặc mã hóa nếu có
        }

        boolean thanhCong = NguoiDungDAO.capNhat(nd);

        if (thanhCong) {
            req.getSession().setAttribute("nguoiDung", nd);
            render(req, res, "thongTinNguoiDung");
        } else {
            req.setAttribute("error", "Cập nhật thông tin thất bại, vui lòng thử lại.");
            render(req, res, "chinhSuaThongTinCaNhan");
        }
    }

    private void luuChinhSuaThongTinKhachHang(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        nguoiDung nd = (nguoiDung) req.getSession().getAttribute("nguoiDung");

        if (nd == null) {
            render(req, res, "dangNhap");
            return;
        }
        String idKhachHang = req.getParameter("id");
        System.out.println("id khách hàng:" + idKhachHang);

        nguoiDung khachHang = NguoiDungDAO.layNguoiDungTheoId(idKhachHang);
        System.out.println("khachHang: " + khachHang);


        req.setCharacterEncoding("UTF-8");

        // Lấy dữ liệu từ form
        String ten = req.getParameter("name");

        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String ngaySinhStr = req.getParameter("ngaySinh");

        // Validate cơ bản
        if (ten == null || ten.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                ngaySinhStr == null || ngaySinhStr.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ thông tin bắt buộc");
            render(req, res, "chinhSuaThongTinKhachHang");
            return;
        }

        // Chuyển đổi ngày sinh
        java.sql.Date ngaySinh = null;
        try {
            ngaySinh = java.sql.Date.valueOf(ngaySinhStr); // định dạng yyyy-MM-dd
        } catch (IllegalArgumentException e) {
            req.setAttribute("error", "Ngày sinh không hợp lệ");
            render(req, res, "chinhSuaThongTinKhachHang");
            return;
        }

        // Cập nhật thông tin
        khachHang.setTen(ten.trim());
        khachHang.setEmail(email.trim());
        khachHang.setNgaySinh(ngaySinh);

        // Nếu người dùng nhập mật khẩu mới thì cập nhật
        if (password != null && !password.trim().isEmpty()) {
            if (password.length() < 6) {
                req.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự");
                render(req, res, "chinhSuaThongTinKhachHang");
                return;
            }
            khachHang.setMatKhau(password.trim()); // Hoặc mã hóa nếu có
        }

        System.out.println("== Thông tin gửi vào DAO ==");
        System.out.println("Email: " + khachHang.getEmail());
        System.out.println("Mật khẩu: " + khachHang.getMatKhau());
        System.out.println("Tên: " + khachHang.getTen());
        System.out.println("Ảnh đại diện: " + khachHang.getAnhDaiDien());
        System.out.println("Vai trò: " + (khachHang.getVaiTroNguoiDung() != null ? khachHang.getVaiTroNguoiDung().name() : "null"));
        System.out.println("Ngày sinh: " + khachHang.getNgaySinh());
        System.out.println("ID: " + khachHang.getId());
        boolean thanhCong = NguoiDungDAO.capNhat(khachHang);

        if (thanhCong) {
            req.getSession().setAttribute("nguoiDung", nd);
            layDanhSachKhachHang(req, res);
        } else {
            req.setAttribute("error", "Cập nhật thông tin thất bại, vui lòng thử lại.");
            res.sendRedirect(req.getContextPath()+"nguoiDung/DanhsachKhachHang");
        }
    }

    private void luuChinhSuaThongTinNhanVien(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        nguoiDung nd = (nguoiDung) req.getSession().getAttribute("nguoiDung");

        if (nd == null) {
            render(req, res, "dangNhap");
            return;
        }
        String idNhanVien = req.getParameter("id");
        System.out.println("id nhân viên:" + idNhanVien);

        nguoiDung nhanVien = NguoiDungDAO.layNguoiDungTheoId(idNhanVien);
        System.out.println("nhanVien: " + nhanVien);


        req.setCharacterEncoding("UTF-8");

        // Lấy dữ liệu từ form
        String ten = req.getParameter("name");

        String email = req.getParameter("email");
       String vaiTroNguoiDung = req.getParameter("vaiTro");
        String ngaySinhStr = req.getParameter("ngaySinh");

        // Validate cơ bản
        if (ten == null || ten.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                ngaySinhStr == null || ngaySinhStr.trim().isEmpty() ||
        vaiTroNguoiDung == null || vaiTroNguoiDung.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ thông tin bắt buộc");
            render(req, res, "chinhSuaThongTinNhanVien");
            return;
        }

        // Chuyển đổi ngày sinh
        java.sql.Date ngaySinh = null;
        try {
            ngaySinh = java.sql.Date.valueOf(ngaySinhStr); // định dạng yyyy-MM-dd
        } catch (IllegalArgumentException e) {
            req.setAttribute("error", "Ngày sinh không hợp lệ");
            render(req, res, "chinhSuaThongTinNhanVien");
            return;
        }

        // Cập nhật thông tin
        nhanVien.setTen(ten.trim());
        nhanVien.setEmail(email.trim());
        nhanVien.setVaiTroNguoiDung( vaiTro.valueOf(vaiTroNguoiDung));
        nhanVien.setNgaySinh(ngaySinh);

        // Nếu người dùng nhập mật khẩu mới thì cập nhật


        System.out.println("== Thông tin gửi vào DAO ==");
        System.out.println("Email: " + nhanVien.getEmail());
        System.out.println("Mật khẩu: " + nhanVien.getMatKhau());
        System.out.println("Tên: " + nhanVien.getTen());
        System.out.println("Ảnh đại diện: " + nhanVien.getAnhDaiDien());
        System.out.println("Vai trò: " + (nhanVien.getVaiTroNguoiDung() != null ? nhanVien.getVaiTroNguoiDung().name() : "null"));
        System.out.println("Ngày sinh: " + nhanVien.getNgaySinh());
        System.out.println("ID: " + nhanVien.getId());
        boolean thanhCong = NguoiDungDAO.capNhat(nhanVien);

        if (thanhCong) {
            req.getSession().setAttribute("nguoiDung", nd);
            layDanhSachNhanVien(req, res);
        } else {
            req.setAttribute("error", "Cập nhật thông tin thất bại, vui lòng thử lại.");
            res.sendRedirect(req.getContextPath()+"nguoiDung/DanhsachNhanVien");
        }
    }



    private void hienThiChinhSuaThongTinCaNhan(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        nguoiDung nd = (nguoiDung) req.getSession().getAttribute("nguoiDung");
        if (nd == null) {
            render(req, res, "dangNhap");
            return;
        }

        // Chuyển đối tượng người dùng vào request để hiển thị trong form
        req.setAttribute("nguoiDung", nd);
        render(req, res, "chinhSuaThongTinCaNhan");
    }

    private void hienThiChinhSuaThongTinKhachHang(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        nguoiDung nd = (nguoiDung) req.getSession().getAttribute("nguoiDung");
        if (nd == null) {
            render(req, res, "dangNhap");
            return;
        }
        String idKhachHang = req.getParameter("id");
        if (idKhachHang == null || idKhachHang.isEmpty()) {
            req.setAttribute("error", "ID khách hàng không hợp lệ");
            render(req, res, "danhSachKhachHang");
            return;
        }
        nguoiDung khachHang = NguoiDungDAO.layNguoiDungTheoId(idKhachHang);
        if (khachHang == null) {
            req.setAttribute("error", "Không tìm thấy khách hàng với ID: " + idKhachHang);
            render(req, res, "danhSachKhachHang");
            return;
        }

        // Chuyển đối tượng người dùng vào request để hiển thị trong form
        req.setAttribute("khachHang", khachHang);
        render(req, res, "chinhSuaThongTinKhachHang");
    }

    private void hienThiChinhSuaThongTinNhanVien(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        nguoiDung nd = (nguoiDung) req.getSession().getAttribute("nguoiDung");
        if (nd == null) {
            render(req, res, "dangNhap");
            return;
        }
        String idNhanVien = req.getParameter("id");
        if (idNhanVien == null || idNhanVien.isEmpty()) {
            req.setAttribute("error", "ID nhân viên không hợp lệ");
            render(req, res, "danhSachNhanVien");
            return;
        }
        nguoiDung nhanVien = NguoiDungDAO.layNguoiDungTheoId(idNhanVien);
        if (nhanVien == null) {
            req.setAttribute("error", "Không tìm thấy nhân viên với ID: " + idNhanVien);
            render(req, res, "danhSachNhanVien");
            return;
        }

        // Chuyển đối tượng người dùng vào request để hiển thị trong form
        req.setAttribute("nhanVien", nhanVien);
        render(req, res, "chinhSuaThongTinNhanVien");
    }


    private void layThongTinCaNhan(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        nguoiDung nd = (nguoiDung) req.getSession().getAttribute("nguoiDung");
        if (nd == null) {
            render(req, res, "dangNhap");
            return;
        }


        render(req, res, "thongTinNguoiDung");
    }


    private void dangKy(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String ten = request.getParameter("ten");
        String email = request.getParameter("email");
        String matkhau = request.getParameter("matkhau");
        String nhaplaimatkhau = request.getParameter("nhaplaimatkhau");
        String ngaysinhStr = request.getParameter("ngaysinh");

        nguoiDung nguoiDungDaTonTai = NguoiDungDAO.layNguoiDungTheoEmail(email);
        if (nguoiDungDaTonTai != null) {
            request.setAttribute("error", "Email đã tồn tại");
            render(request, response, "dangKy");
        }

        // Kiểm tra mật khẩu khớp nhau
        if (!matkhau.equals(nhaplaimatkhau)) {
            request.setAttribute("error", "Mật khẩu không khớp");
//            request.getRequestDispatcher("dangKy.jsp").forward(request, response);
            render(request, response, "dangKy");
            return;
        }

        // Chuyển String -> java.sql.Date
        java.sql.Date ngaySinh = null;
        try {
            ngaySinh = java.sql.Date.valueOf(ngaysinhStr); // format yyyy-MM-dd
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Ngày sinh không hợp lệ");
//            request.getRequestDispatcher("dangKy.jsp").forward(request, response);
            render(request, response, "dangKy");
            return;

        }

        // Tạo đối tượng người dùng
        nguoiDung user = new nguoiDung();
        user.setId(UUID.randomUUID().toString()); //sinh id ngẫu nhiên
        user.setTen(ten);
        user.setEmail(email);
        user.setMatKhau(matkhau);
        user.setNgaySinh(ngaySinh);
        user.setVaiTroNguoiDung(vaiTro.KHACH_HANG); // mặc định

        boolean thanhCong = NguoiDungDAO.Tao(user);

        if (thanhCong) {
//            response.sendRedirect("dangNhap.jsp");
            render(request, response, "dangNhap");

        } else {
            request.setAttribute("error", "Đăng ký thất bại (vui lòng thử lại)");
            render(request, response, "dangKy");
//            request.getRequestDispatcher("dangKy.jsp").forward(request, response);
        }
    }

    private void dangNhap(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String matKhau = request.getParameter("matKhau");

        System.out.println("Email: " + email);
        System.out.println("Mat Khau: " + matKhau);

        nguoiDung nd = NguoiDungDAO.layNguoiDungTheoEmail(email);




        if (nd != null && nd.getMatKhau().equals(matKhau)) {

            HttpSession session = request.getSession();
            session.setAttribute("nguoiDung", nd);
            System.out.println("Dang Nhap thanh cong");

            if(nd.getVaiTroNguoiDung().equals(vaiTro.QUAN_LY)  || nd.getVaiTroNguoiDung().equals(vaiTro.NHAN_VIEN) ){
                render(request, response, "index-nhanvien");
                return;
            }

            render(request, response, "index");
        } else {
            // Đăng nhập thất bại
            System.out.println("Dang Nhap that bai");
            request.setAttribute("thongBao", "Email hoặc mật khẩu không đúng!");
//            request.getRequestDispatcher("dangNhap.jsp").forward(request, response);
            render(request, response, "dangNhap");
        }

    }
    private void dangXuat(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        session.invalidate(); // Xóa phiên làm việc
        render(request, response, "index");



    }



    private void layDanhSachKhachHang(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        nguoiDung nd = (nguoiDung) request.getSession().getAttribute("nguoiDung");
        if (nd == null) {
            render(request, response, "dangNhap");
        }

        // Lấy danh sách khách hàng từ DAO
        List<nguoiDung> danhSachKhachHang = NguoiDungDAO.layNguoiDungTheoVaiTro(String.valueOf(vaiTro.KHACH_HANG));
        request.setAttribute("danhSachKhachHang", danhSachKhachHang);

        // Chuyển hướng đến trang danh sách khách hàng
//        request.getRequestDispatcher("/danhSachKhachHang.jsp").forward(request, response);
        render(request, response, "danhSachKhachHang");

}
    private void layDanhSachNhanVien(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        nguoiDung nd = (nguoiDung) request.getSession().getAttribute("nguoiDung");
        if (nd == null) {
            render(request, response, "dangNhap");
            return;
        }

        // Lấy danh sách khách hàng từ DAO
        List<nguoiDung> danhSachNhanVien = new ArrayList<>();
        danhSachNhanVien.addAll(Objects.requireNonNull(NguoiDungDAO.layNguoiDungTheoVaiTro(String.valueOf(vaiTro.NHAN_VIEN))));
        danhSachNhanVien.addAll(Objects.requireNonNull(NguoiDungDAO.layNguoiDungTheoVaiTro(String.valueOf(vaiTro.QUAN_LY))));
        request.setAttribute("danhSachNhanVien", danhSachNhanVien);

        // Chuyển hướng đến trang danh sách khách hàng
//        request.getRequestDispatcher("/danhSachNhanVien.jsp").forward(request, response);
        render(request, response, "danhSachNhanVien");

    }


    public void xoaKhachHang(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        nguoiDung nd = (nguoiDung) request.getSession().getAttribute("nguoiDung");
        if (nd == null) {
            render(request, response, "dangNhap");
            return;
        }

        String id = request.getParameter("id");
        System.out.println("ID người dùng cần xóa: " + id);
        if (id == null || id.isEmpty()) {
            request.setAttribute("error", "ID người dùng không hợp lệ");
            render(request, response, "danhSachKhachHang");
            return;
        }

        boolean thanhCong = NguoiDungDAO.xoa(id);
        System.out.println("Xóa khách hàng thành công: " + thanhCong);
        if (thanhCong) {
            request.setAttribute("thongBao", "Xóa khách hàng thành công");
        } else {
            request.setAttribute("error", "Xóa khách hàng thất bại");
        }
        System.out.println("Đang chuyển hướng đến danh sách khách hàng");
        layDanhSachKhachHang(request, response);


    }

}
