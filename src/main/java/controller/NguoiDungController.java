package controller;

import DAO.NguoiDungDAO;

import model.nguoiDung;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import java.text.SimpleDateFormat;
import java.util.Date;

public class NguoiDungController {
    private NguoiDungDAO dao;

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



}
