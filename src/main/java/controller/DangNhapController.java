package controller;

import DAO.NguoiDungDAO;
import model.nguoiDung;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/dangnhap")
public class DangNhapController extends HttpServlet {
    private NguoiDungDAO dao;

    @Override
    public void init() {
        dao = new NguoiDungDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String matKhau = request.getParameter("matKhau");

        System.out.println("Email: " + email);
        System.out.println("Mat Khau: " + matKhau);

        nguoiDung nd = dao.layNguoiDungTheoEmail(email);

        if (nd != null && nd.getMatKhau().equals(matKhau)) {
            // Đăng nhập thành công
            HttpSession session = request.getSession();
            session.setAttribute("nguoiDung", nd);
            System.out.println("Dang Nhap thanh cong");

            response.sendRedirect("index.jsp");
        } else {
            // Đăng nhập thất bại
            System.out.println("Dang Nhap that bai");
            request.setAttribute("thongBao", "Email hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("dangNhap.jsp").forward(request, response);
        }
    }
}
