//package controller;
//import DAO.NguoiDungDAO;
//
//import model.*;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.*;
//import java.io.IOException;
//import DAO.*;
//
//import java.io.PrintWriter;
//import java.sql.Timestamp;
//import java.text.SimpleDateFormat;
//import java.util.*;
//@WebServlet("/lichDatCuaToi")
//public class LichDatCuaToiController extends HttpServlet {
//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
//            throws ServletException, IOException {
//        nguoiDung nd = (nguoiDung) req.getSession().getAttribute("nguoiDung");
//        if (nd == null) {
//            resp.sendRedirect("dangNhap.jsp");
//            return;
//        }
//
//        List<datSan> lichDat = DatSanDAO.timDanhSachDatSanTheoNguoiDung(nd.getId());
//        req.setAttribute("lichDat", lichDat);
//
//        req.getRequestDispatcher("/lichDatCuaToi.jsp").forward(req, resp);
//    }
//}
//
