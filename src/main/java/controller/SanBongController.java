package controller;

import DAO.NguoiDungDAO;

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

@WebServlet("/sanBong/*")
public class SanBongController extends BaseController{


protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    String path = req.getPathInfo() == null ? "/" : req.getPathInfo();
    System.out.println("trong doGet Path: " + path);

    switch (path) {
        case "/danhSachSanCoSan":
            System.out.println("Vao danh sach san co san");
            render(req, resp, "danhSachSanCoSan");
            break;
    }
}

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo() == null ? "/" : req.getPathInfo();
        System.out.println("trong DoPost Path: " + path);

        switch (path) {
            case "/danhSachSanCoSan":
                getAvailableFields(req, resp);
                break;

            case "/datSan/taoLichDat":
                taoLichDat(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }


    }

    private void getAvailableFields(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String timestampStr = req.getParameter("timestamp");
            System.out.println("thoi gian: " + timestampStr);

            Timestamp timestamp = Timestamp.valueOf(timestampStr);

            List<sanBong> availableFields = SanBongDAO.LayDanhSachSanCoSan(timestamp);

            System.out.println("Available fields: " + availableFields.size());

            // Gán dữ liệu vào request để JSP có thể hiển thị
            req.setAttribute("availableFields", availableFields);
            req.setAttribute("selectedTime", timestampStr);

            // Forward về lại trang JSP để hiển thị dữ liệu
//            req.getRequestDispatcher("/danhSachSanCoSan.jsp").forward(req, resp);
            render(req, resp, "danhSachSanCoSan");

        } catch (Exception e) {
            System.out.println("Đã xảy ra lỗi trong getAvailableFields:");
            e.printStackTrace();
            req.setAttribute("error", "Lỗi xử lý dữ liệu");
//            req.getRequestDispatcher("/danhSachSanCoSan.jsp").forward(req, resp);
            render(req, resp, "danhSachSanCoSan");
        }
    }

    private void taoLichDat(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int idSanBong = Integer.parseInt(req.getParameter("idSanBong"));
            String timestampStr = req.getParameter("timestamp");
            System.out.println("thoi gian: " + timestampStr);

            Timestamp timestamp = Timestamp.valueOf(timestampStr);
            Date gioBatDauDatSan = new Date(timestamp.getTime());
            Date gioKetThucDatSan = new Date(timestamp.getTime() + 60 * 60 * 1000); // Giả sử đặt sân trong 1 giờ
            // Lấy user từ session hoặc request
            nguoiDung nd = (nguoiDung) req.getSession().getAttribute("nguoiDung");

            String idLichDat = UUID.randomUUID().toString();

            bangGia bg = BangGiaDAO.timGiaTheoGio(timestamp);
            if (bg == null) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Không tìm thấy bảng giá cho thời gian này");
                return;
            }
            Date gioBatDau = bg.getGioBatDau();
            Date gioKetThuc = bg.getGioKetThuc();
            int thoiGianThue = (int) ((gioKetThucDatSan.getTime() - gioBatDauDatSan.getTime()) / (1000 * 60 * 60));
            System.out.println("thoi gian thue: " + thoiGianThue);
            int soTien = bg.getGiaTien1Gio() * thoiGianThue;

            datSan ds = new datSan();
            ds.setId(idLichDat);
            ds.setIdKhachHang(nd.getId());
            ds.setIdSanBong(String.valueOf(idSanBong));
            ds.setSoTien(soTien);
            ds.setTrangThai(trangThaiDatSan.CHO_THANH_TOAN);
            ds.setGioBatDau(new java.sql.Date(gioBatDauDatSan.getTime()));
            ds.setGioKetThuc(new java.sql.Date(gioKetThucDatSan.getTime()));
            ds.setNgayTao(new Timestamp(System.currentTimeMillis()));
            ds.setNgayCapNhat(new Timestamp(System.currentTimeMillis()));


            // Gọi DAO thêm lịch đặt
            DatSanDAO.Tao(ds);

            // Redirect về trang danh sách lịch đặt
            resp.sendRedirect(req.getContextPath() + "/lichDatCuaToi.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi đặt sân");
        }
    }


}



