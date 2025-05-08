package controller;

import DAO.NguoiDungDAO;
import model.nguoiDung;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.vaiTro;

import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.UUID;


@WebServlet("/dangky")
public class DangKyController extends HttpServlet {
    private NguoiDungDAO dao;

    @Override
    public void init() {
        dao = new NguoiDungDAO();
    }



        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            request.setCharacterEncoding("UTF-8");

            String ten = request.getParameter("ten");
            String email = request.getParameter("email");
            String matkhau = request.getParameter("matkhau");
            String nhaplaimatkhau = request.getParameter("nhaplaimatkhau");
            String ngaysinhStr = request.getParameter("ngaysinh");

            // Kiểm tra mật khẩu khớp nhau
            if (!matkhau.equals(nhaplaimatkhau)) {
                request.setAttribute("error", "Mật khẩu không khớp");
                request.getRequestDispatcher("dangKy.jsp").forward(request, response);
                return;
            }

            // Chuyển String -> java.sql.Date
            java.sql.Date ngaySinh = null;
            try {
                ngaySinh = java.sql.Date.valueOf(ngaysinhStr); // format yyyy-MM-dd
            } catch (IllegalArgumentException e) {
                request.setAttribute("error", "Ngày sinh không hợp lệ");
                request.getRequestDispatcher("dangKy.jsp").forward(request, response);
                return;
            }

            // Tạo đối tượng người dùng
            nguoiDung user = new nguoiDung();
            user.setId(UUID.randomUUID().toString());
            user.setTen(ten);
            user.setEmail(email);
            user.setMatKhau(matkhau);
            user.setNgaySinh(ngaySinh);
            user.setVaiTroNguoiDung(vaiTro.KHACH_HANG); // mặc định

            boolean thanhCong = NguoiDungDAO.Tao(user);

            if (thanhCong) {
                response.sendRedirect("dangNhap.jsp");
            } else {
                request.setAttribute("error", "Đăng ký thất bại (có thể email đã tồn tại)");
                request.getRequestDispatcher("dangKy.jsp").forward(request, response);
            }
        }
    }

