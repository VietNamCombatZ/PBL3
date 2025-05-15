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
public class NguoiDungController  extends HttpServlet {
    private NguoiDungDAO dao;


    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getPathInfo() == null ? "/" : request.getPathInfo();
        System.out.println("Path: " + path);
        switch (path) {
            case "/DanhsachKhachHang":
                layDanhSachKhachHang(request, response);
                break;
            case  "/DanhsachNhanVien" :
                layDanhSachNhanVien(request, response);
                break;
//            case "/capNhatThongTin":
//                capNhatThongTin(request, response);
//                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    @WebServlet("/CapNhatThongTin")
    public class CapNhatThongTin extends HttpServlet {
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            nguoiDung nd = (nguoiDung) request.getSession().getAttribute("nguoiDung");
            if (nd == null) {
                response.sendRedirect("dangNhap.jsp");
                return;
            }

            request.setCharacterEncoding("UTF-8");

            nd.setTen(request.getParameter("ten"));
            nd.setEmail(request.getParameter("email"));
            nd.setAnhDaiDien(request.getParameter("anhDaiDien"));

            try {
                String ngaySinhStr = request.getParameter("ngaySinh");
                if (ngaySinhStr != null && !ngaySinhStr.isEmpty()) {
                    Date ngaySinh = new SimpleDateFormat("yyyy-MM-dd").parse(ngaySinhStr);
                    nd.setNgaySinh(ngaySinh);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }


            NguoiDungDAO.capNhat(nd);
            request.getSession().setAttribute("nguoiDung", nd); // cập nhật lại session
            response.sendRedirect("user.jsp"); // quay lại trang cá nhân
        }
    }

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
        request.getRequestDispatcher("/danhSachNhanVien.jsp").forward(request, response);

    }




}
