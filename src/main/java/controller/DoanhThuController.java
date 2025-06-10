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


//        request.setAttribute("doanhThuTheoNgay", DoanhThuDAO.getDoanhThuTheoNgay());
//        request.setAttribute("doanhThuTheoTuan", DoanhThuDAO.getDoanhThuTheoTuan());
//        request.setAttribute("doanhThuTheoThang", DoanhThuDAO.getDoanhThuTheoThang());
//        request.setAttribute("doanhThuTheoLoaiSan", DoanhThuDAO.getDoanhThuTheoLoaiSan());
//        request.setAttribute("soLuongSanTheoGio", DoanhThuDAO.getSoLuongSanTheoGio());
        request.setAttribute("doanhThuTheoNgay", new LinkedHashMap<String, Integer>());
        request.setAttribute("doanhThuNgayTheoLoaiSan", new LinkedHashMap<String, Integer>());
        request.setAttribute("soLuongSanTheoGioTheoNgay", new LinkedHashMap<String, Integer>());



        request.setAttribute("doanhThuTheoTuan", new LinkedHashMap<String, Integer>());
        request.setAttribute("doanhThuTuanTheoLoaiSan", new LinkedHashMap<String, Integer>());
        request.setAttribute("soLuongSanTheoGioTheoTuan", new LinkedHashMap<String, Integer>());


        request.setAttribute("doanhThuTheoThang", new LinkedHashMap<String, Integer>());
        request.setAttribute("doanhThuThangTheoLoaiSan", new LinkedHashMap<String, Integer>());
        request.setAttribute("soLuongSanTheoGioTheoThang", new LinkedHashMap<String, Integer>());


        request.setAttribute("doanhThuTheoLoaiSan", new LinkedHashMap<String, Integer>());
        request.setAttribute("soLuongSanTheoGio", new LinkedHashMap<String, Integer>());

        render(request, response, "doanhThu");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("DoanhThuController: doPost");

        String tuNgay = request.getParameter("tuNgay");
        String denNgay = request.getParameter("denNgay");


        String tuTuan = request.getParameter("tuTuan");
        String denTuan = request.getParameter("denTuan");



        String tuThang = request.getParameter("tuThang");
        String denThang = request.getParameter("denThang");

        System.out.println("DoanhThuController: doPost - tuNgay: " + tuNgay + ", denNgay: " + denNgay);
        System.out.println("DoanhThuController: doPost - tuTuan: " + tuTuan + ", denTuan: " + denTuan);
        System.out.println("DoanhThuController: doPost - tuThang: " + tuThang + ", denThang: " + denThang);

        // Lọc doanh thu theo điều kiện được chọn
        Map<String, Integer> doanhThuNgay = new LinkedHashMap<String, Integer>();
        Map<String, Integer> doanhThuNgayTheoLoaiSan = new LinkedHashMap<String, Integer>();
        Map<String, Integer> soLuongSanTheoGioTheoNgay = new LinkedHashMap<String, Integer>();

        Map<String, Integer> doanhThuTuan = new LinkedHashMap<String, Integer>();
        Map<String, Integer> doanhThuTuanTheoLoaiSan = new LinkedHashMap<String, Integer>();
        Map<String, Integer> soLuongSanTheoGioTheoTuan = new LinkedHashMap<String, Integer>();

        Map<String, Integer> doanhThuThang = new LinkedHashMap<String, Integer>();
        Map<String, Integer> doanhThuThangTheoLoaiSan = new LinkedHashMap<String, Integer>();
        Map<String, Integer> soLuongSanTheoGioTheoThang = new LinkedHashMap<String, Integer>();

        if (tuNgay != null && denNgay != null && !tuNgay.isEmpty() && !denNgay.isEmpty()) {
            doanhThuNgay = DoanhThuDAO.getDoanhThuTheoNgay(tuNgay, denNgay);
            doanhThuNgayTheoLoaiSan = DoanhThuDAO.getDoanhThuTheoLoaiSanTheoNgay(tuNgay, denNgay);
            soLuongSanTheoGioTheoNgay = DoanhThuDAO.getSoLuongSanTheoGioTheoNgay(tuNgay, denNgay);
        } else {
            doanhThuNgay = DoanhThuDAO.getDoanhThuTheoNgay();
        }

        if (tuTuan != null && denTuan != null && !tuTuan.isEmpty() && !denTuan.isEmpty()) {
            int tuTuanInt = Integer.parseInt(tuTuan.split("-W")[1]);
            int denTuanInt = Integer.parseInt(denTuan.split("-W")[1]);
            doanhThuTuan = DoanhThuDAO.getDoanhThuTheoTuan(tuTuanInt, denTuanInt);
            doanhThuTuanTheoLoaiSan = DoanhThuDAO.getDoanhThuTheoLoaiSanTheoTuan(tuTuanInt, denTuanInt);
            soLuongSanTheoGioTheoTuan = DoanhThuDAO.getSoLuongSanTheoGioTheoTuan(tuTuanInt, denTuanInt);
        } else {
            doanhThuTuan = DoanhThuDAO.getDoanhThuTheoTuan();
        }

        if (tuThang != null && denThang != null && !tuThang.isEmpty() && !denThang.isEmpty()) {
            int tuNam = Integer.parseInt(tuThang.split("-")[0]);
            int tuThangInt = Integer.parseInt(tuThang.split("-")[1]);

            int denNam = Integer.parseInt(denThang.split("-")[0]);
            int denThangInt = Integer.parseInt(denThang.split("-")[1]);

            doanhThuThang = DoanhThuDAO.getDoanhThuTheoThang(tuNam, tuThangInt, denNam, denThangInt);
            doanhThuThangTheoLoaiSan = DoanhThuDAO.getDoanhThuTheoLoaiSanTheoThang(tuNam, tuThangInt, denNam, denThangInt);
            soLuongSanTheoGioTheoThang = DoanhThuDAO.getSoLuongSanTheoGioTheoThang(tuNam, tuThangInt, denNam, denThangInt);



        } else {
            doanhThuThang = DoanhThuDAO.getDoanhThuTheoThang();
        }

        // Gán các dữ liệu vào request
        request.setAttribute("doanhThuTheoNgay", doanhThuNgay);
        request.setAttribute("doanhThuNgayTheoLoaiSan", doanhThuNgayTheoLoaiSan);
        request.setAttribute("soLuongSanTheoGioTheoNgay", soLuongSanTheoGioTheoNgay);

        request.setAttribute("doanhThuTheoTuan", doanhThuTuan);
        request.setAttribute("doanhThuTuanTheoLoaiSan", doanhThuTuanTheoLoaiSan);
        request.setAttribute("soLuongSanTheoGioTheoTuan", soLuongSanTheoGioTheoTuan);


        request.setAttribute("doanhThuTheoThang", doanhThuThang);
        request.setAttribute("doanhThuThangTheoLoaiSan", doanhThuThangTheoLoaiSan);
        request.setAttribute("soLuongSanTheoGioTheoThang", soLuongSanTheoGioTheoThang);


        request.setAttribute("doanhThuTheoLoaiSan", DoanhThuDAO.getDoanhThuTheoLoaiSan());
        request.setAttribute("soLuongSanTheoGio", DoanhThuDAO.getSoLuongSanTheoGio());

        render(request, response, "doanhThu");
    }
}