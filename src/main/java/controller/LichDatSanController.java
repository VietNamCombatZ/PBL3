//package controller;
//
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
//
//
//@WebServlet("*")
//public class LichDatSanController extends HttpServlet{
//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
//            throws ServletException, IOException {
//        String path = req.getPathInfo() == null ? "/" : req.getPathInfo();
//        System.out.println("Path: " + path);
//
//        switch (path) {
//            case "/lichDatCuaToi":
//                layLichDatCuaToi(req, resp);
//                break;
//            default:
//                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
//                break;
//        }
//
//    }
//
//
//
//    private void layLichDatCuaToi(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
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
//
//}
