package controller;

import DAO.*;

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

@WebServlet("/doanhThu")
public class DoanhThuController extends BaseController {
//    private dao.DoanhThuDAO dao;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
        System.out.println("DoanhThuController: doGet");


        request.setAttribute("doanhThuTheoNgay", DoanhThuDAO.getDoanhThuTheoNgay());
        request.setAttribute("doanhThuTheoTuan", DoanhThuDAO.getDoanhThuTheoTuan());
        request.setAttribute("doanhThuTheoThang", DoanhThuDAO.getDoanhThuTheoThang());
        request.setAttribute("doanhThuTheoLoaiSan", DoanhThuDAO.getDoanhThuTheoLoaiSan());
        request.setAttribute("soLuongSanTheoGio", DoanhThuDAO.getSoLuongSanTheoGio());
        render(request, response, "doanhThu");
    }
}