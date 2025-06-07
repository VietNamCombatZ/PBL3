package controller;

import model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import DAO.*;

import java.io.PrintWriter;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet("/danhGia/*")

public class DanhGiaController extends BaseController{
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo() == null ? "/" : req.getPathInfo();
        System.out.println("Path ở doGet: " + path);

        switch (path) {
            case "/taoDanhGia":
                render(req, resp, "taoDanhGia");
                break;

            case "/chinhSuaDanhGia":
                render(req, resp, "chinhSuaDanhGia");
                break;
            case "/xemDanhGiaCuaKhachHang":
                render(req, resp, "danhGiaCuaKhachHang");
                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo() == null ? "/" : req.getPathInfo();
        System.out.println("Path ở doPost: " + path);

        switch (path) {
            case "/taoDanhGia":
                taoDanhGia(req, resp);
                break;
            case "/chinhSuaDanhGia":
                    chinhSuaDanhGia(req, resp);
                    break;

            case "/xoaDanhGia":
                xoaDanhGia(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    private void taoDanhGia(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idDatSan = req.getParameter("idDatSan");
        String idSanBong = req.getParameter("idSanBong");
        String noiDung = req.getParameter("noiDung");
        mucDiem mucDiemValue = null;
        try {
            mucDiemValue = mucDiem.valueOf(req.getParameter("mucDiem"));
            // Tiếp tục xử lý
        } catch (IllegalArgumentException e) {
            // Xử lý khi giá trị không hợp lệ, ví dụ chuyển hướng hoặc hiển thị thông báo lỗi
            e.printStackTrace();
        }

        datSan ds = DatSanDAO.timDatSanTheoId(idDatSan);
        if (ds == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Đặt sân không tồn tại.");
            return;
        }

        danhGia dg = new danhGia();
        dg.setId(UUID.randomUUID().toString());
        dg.setIdKhachHang(ds.getIdKhachHang());
        dg.setIdDatSan(idDatSan);
        dg.setIdSanBong(idSanBong);
        dg.setNoiDung(noiDung);
        dg.setMucDiem(mucDiemValue);
        dg.setNgayTao(new Timestamp(System.currentTimeMillis()));
        dg.setNgayCapNhat(new Timestamp(System.currentTimeMillis()));

        boolean success = DanhGiaDAO.Tao(dg);
        if (success) {
            resp.sendRedirect(req.getContextPath() + "/datSan/lichDatCaNhan");
        } else {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể tạo đánh giá.");
        }
    }

    private void chinhSuaDanhGia(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idDanhGia = req.getParameter("idDanhGia");
        danhGia dg = DanhGiaDAO.timDanhGiaTheoId(idDanhGia);
        if (dg == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Đánh giá không tồn tại.");
            return;
        }

        String noiDung = req.getParameter("noiDung");
        mucDiem mucDiemValue = null;
        try {
            mucDiemValue = mucDiem.valueOf(req.getParameter("mucDiem"));
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Mức điểm không hợp lệ.");
            return;
        }

        dg.setNoiDung(noiDung);
        dg.setMucDiem(mucDiemValue);
        dg.setNgayCapNhat(new Timestamp(System.currentTimeMillis()));

        // Cập nhật đánh giá
        Map<String, Object> thongTinCapNhat = new HashMap<>();

        thongTinCapNhat.put("mucDiem", mucDiemValue.name());
        thongTinCapNhat.put("noiDung", noiDung);

        thongTinCapNhat.put("ngayCapNhat", new Timestamp(System.currentTimeMillis()));

        danhGia daCapNhat = DanhGiaDAO.capNhatThongTinDanhGia(idDanhGia, thongTinCapNhat);
        if (daCapNhat != null) {
//            resp.sendRedirect(req.getContextPath() + "/danhGia/chiTiet?id=" + idDanhGia);
            resp.sendRedirect(req.getContextPath() + "/datSan/lichDatCaNhan");
        } else {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể cập nhật đánh giá.");
        }
    }


    private void xoaDanhGia(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idDanhGia = req.getParameter("idDanhGia");
        danhGia dg = DanhGiaDAO.timDanhGiaTheoId(idDanhGia);
        if (dg == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Đánh giá không tồn tại.");
            return;
        }

        boolean success = DanhGiaDAO.xoaDanhGia(idDanhGia);
        if (success) {
            resp.sendRedirect(req.getContextPath() + "/datSan/lichDatCaNhan");
        } else {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể xóa đánh giá.");
        }
    }
}