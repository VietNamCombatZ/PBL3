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
        System.out.println("Path: " + path);
        switch (path) {
            case "/dangKy":
                render(request, response, "dangKy");
                break;
            case "/dangNhap":
//
                render(request, response, "dangNhap");
                break;
            case "/DanhsachKhachHang":
                layDanhSachKhachHang(request, response);
                break;
            case  "/DanhsachNhanVien" :
                layDanhSachNhanVien(request, response);
                break;

            case "/thongTinCaNhan":
                layThongTinCaNhan(request, response);
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
        System.out.println("Path: " + path);
        switch (path) {
            case "/dangKy":
                dangKy(request, response);
                break;
            case "/dangNhap":
                dangNhap(request, response);
                break;
//            case "/CapNhatThongTin":
//                CapNhatThongTin capNhat = new CapNhatThongTin();
//                capNhat.doPost(request, response);
//                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }
    private void layThongTinCaNhan(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        nguoiDung nd = (nguoiDung) req.getSession().getAttribute("nguoiDung");
        if (nd == null) {
            render(req, res, "dangNhap");
            return;
        }

//        req.getRequestDispatcher("/user.jsp").forward(req, res);
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

//    @WebServlet("/CapNhatThongTin")
//    public class CapNhatThongTin extends HttpServlet {
//        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//            nguoiDung nd = (nguoiDung) request.getSession().getAttribute("nguoiDung");
//            if (nd == null) {
//                response.sendRedirect("dangNhap.jsp");
//                return;
//            }
//
//            request.setCharacterEncoding("UTF-8");

//            nd.setTen(request.getParameter("ten"));
//            nd.setEmail(request.getParameter("email"));
//            nd.setAnhDaiDien(request.getParameter("anhDaiDien"));
//
//            try {
//                String ngaySinhStr = request.getParameter("ngaySinh");
//                if (ngaySinhStr != null && !ngaySinhStr.isEmpty()) {
//                    Date ngaySinh = new SimpleDateFormat("yyyy-MM-dd").parse(ngaySinhStr);
//                    nd.setNgaySinh(ngaySinh);
//                }
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//
//
//            NguoiDungDAO.capNhat(nd);
//            request.getSession().setAttribute("nguoiDung", nd); // cập nhật lại session
//            response.sendRedirect("user.jsp"); // quay lại trang cá nhân
//        }
//    }

    private void layDanhSachKhachHang(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        nguoiDung nd = (nguoiDung) request.getSession().getAttribute("nguoiDung");
        if (nd == null) {
            response.sendRedirect("dangNhap.jsp");
            return;
        }

        // Lấy danh sách khách hàng từ DAO
        List<nguoiDung> danhSachKhachHang = NguoiDungDAO.layNguoiDungTheoVaiTro(String.valueOf(vaiTro.KHACH_HANG));
        request.setAttribute("danhSachKhachHang", danhSachKhachHang);

        // Chuyển hướng đến trang danh sách khách hàng
        request.getRequestDispatcher("/danhSachKhachHang.jsp").forward(request, response);

}
    private void layDanhSachNhanVien(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        nguoiDung nd = (nguoiDung) request.getSession().getAttribute("nguoiDung");
        if (nd == null) {
            response.sendRedirect("dangNhap.jsp");
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




}
