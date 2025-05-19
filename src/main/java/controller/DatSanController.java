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

@WebServlet("/datSan/*")

public class DatSanController extends BaseController{
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo() == null ? "/" : req.getPathInfo();
        System.out.println("Path: " + path);

        switch (path) {
            case "/taoLichDat":
                taoLichDat(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }


    }

    private void taoLichDat(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {

            int idSanBong = Integer.parseInt(req.getParameter("idSanBong"));
            Timestamp timestamp = Timestamp.valueOf(req.getParameter("timestamp"));
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
            int soTien = bg.getGiaTien1Gio() * (int) ((timestamp.getTime() - gioBatDau.getTime()) / (1000 * 60 * 60));

            datSan ds = new datSan();
            ds.setId(idLichDat);
            ds.setIdKhachHang(nd.getId());
            ds.setIdSanBong(String.valueOf(idSanBong));
            ds.setSoTien(soTien);
            ds.setTrangThai(trangThaiDatSan.CHO_THANH_TOAN);
            ds.setGioBatDau(new java.sql.Date(gioBatDau.getTime()));
            ds.setGioKetThuc(new java.sql.Date(gioKetThuc.getTime()));
            ds.setNgayTao(new Timestamp(System.currentTimeMillis()));
            ds.setNgayCapNhat(new Timestamp(System.currentTimeMillis()));


            // Gọi DAO thêm lịch đặt
            DatSanDAO.Tao(ds);

            // Redirect về trang danh sách lịch đặt
            resp.sendRedirect(req.getContextPath() + "/lichDatCuaToi");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi đặt sân");
        }
    }
}
