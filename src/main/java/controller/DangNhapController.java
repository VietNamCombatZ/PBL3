package controller;

import DAO.NguoiDungDAO;
import model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import static model.vaiTro.*;

@WebServlet("/dangnhap")
public class DangNhapController extends BaseController {
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

            HttpSession session = request.getSession();
            session.setAttribute("nguoiDung", nd);
            System.out.println("Dang Nhap thanh cong");

            if(nd.getVaiTroNguoiDung().equals(vaiTro.QUAN_LY)  || nd.getVaiTroNguoiDung().equals(vaiTro.NHAN_VIEN) ){
                response.sendRedirect("index-nhanvien.jsp");
                return;
            }

            response.sendRedirect("index.jsp");
        } else {
            // Đăng nhập thất bại
            System.out.println("Dang Nhap that bai");
            request.setAttribute("thongBao", "Email hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("dangNhap.jsp").forward(request, response);
        }
    }
}
