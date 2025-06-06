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
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.*;

@WebServlet("/datSan/*")

public class DatSanController extends BaseController{
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo() == null ? "/" : req.getPathInfo();
        System.out.println("Path ở doGet: " + path);

        switch (path) {

            case"/tatCaLichDat":
                render(req, resp, "danhSachTatCaLichDat");
                break;
            case "/lichDatCaNhan":
                render(req, resp, "lichDatCuaToi");
                break;
            case "/lichDatKhachHang":
//                render(req, resp, "lichDatCuaKhachHang");
                layLichDatCuaKhachHang(req, resp);
                break;
            case "/chinhSuaDatSan":
                chinhSuaLichDatCaNhan(req, resp);
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
            case "/taoLichDat":
                taoLichDat(req, resp);
                break;
            case "/taoLichDatNhanVien":
                taoLichDatNhanVien(req, resp);
                break;

            case "/lichDatKhachHang":
                    layLichDatCuaKhachHang(req, resp);
                    break;
            case "/capNhatLichDatCuaToi":
                capNhatLichDatCuaToi(req, resp);
                break;

            case "/thanhToanSan":
                xacNhanThanhToan(req, resp);
                break;

case "/huyDatSan":
    khachHangHuyDatSan(req,resp);
    break;
            case "/huyDatSanKhachHang":
                nhanVienHuyDatSanKhachHang(req, resp);
                break;


            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }


    }



private void taoLichDat(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    try {
        String idSanBong = req.getParameter("idSanBong");
        String timestampStartStr = req.getParameter("timestamp");
        String timestampEndStr = req.getParameter("timestampEnd");

        System.out.println("timestampStartStr: " + timestampStartStr);
        System.out.println("timestampEndStr: " + timestampEndStr);

        if (timestampStartStr == null || timestampEndStr == null ||
                timestampStartStr.isEmpty() || timestampEndStr.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu thông tin thời gian đặt sân");
            return;
        }

        Timestamp timestampStart = Timestamp.valueOf(timestampStartStr);
        Timestamp timestampEnd = Timestamp.valueOf(timestampEndStr);

        nguoiDung nd = (nguoiDung) req.getSession().getAttribute("nguoiDung");
        if (nd == null) {
            req.getSession().setAttribute("thongBao", "Bạn cần đăng nhập để đặt sân");
            resp.sendRedirect(req.getContextPath() + "/nguoiDung/dangNhap");
            return;
        }

        // Giờ nghỉ
        LocalTime nghiBatDau = LocalTime.of(10, 0);
        LocalTime nghiKetThuc = LocalTime.of(15, 0);

        LocalDateTime startDateTime = timestampStart.toLocalDateTime();
        LocalDateTime endDateTime = timestampEnd.toLocalDateTime();

        List<LocalDateTime[]> cacKhoangHopLe = new ArrayList<>();

        // Trường hợp hoàn toàn trước giờ nghỉ
        if (endDateTime.toLocalTime().isBefore(nghiBatDau) || endDateTime.toLocalTime().equals(nghiBatDau)) {
            cacKhoangHopLe.add(new LocalDateTime[]{startDateTime, endDateTime});
        }
        // Trường hợp hoàn toàn sau giờ nghỉ
        else if (startDateTime.toLocalTime().isAfter(nghiKetThuc) || startDateTime.toLocalTime().equals(nghiKetThuc)) {
            cacKhoangHopLe.add(new LocalDateTime[]{startDateTime, endDateTime});
        }
        // Trường hợp chồng vào giờ nghỉ
        else {
            if (startDateTime.toLocalTime().isBefore(nghiBatDau)) {
                LocalDateTime end1 = LocalDateTime.of(startDateTime.toLocalDate(), nghiBatDau);
                cacKhoangHopLe.add(new LocalDateTime[]{startDateTime, end1});
            }
            if (endDateTime.toLocalTime().isAfter(nghiKetThuc)) {
                LocalDateTime start2 = LocalDateTime.of(endDateTime.toLocalDate(), nghiKetThuc);
                cacKhoangHopLe.add(new LocalDateTime[]{start2, endDateTime});
            }
        }

        boolean coTaoDuocLich = false;

        for (LocalDateTime[] khoang : cacKhoangHopLe) {
            LocalDateTime gioBD = khoang[0];
            LocalDateTime gioKT = khoang[1];

            if (gioBD.isBefore(gioKT)) {
                Timestamp gioBD_ts = Timestamp.valueOf(gioBD);
                Timestamp gioKT_ts = Timestamp.valueOf(gioKT);

                sanBong sb = SanBongDAO.timSanTheoId(idSanBong);
               if( sb == null) {
                continue;
            }

                bangGia bg = BangGiaDAO.timGiaTheoGio(gioBD_ts, sb.getKieuSan());
                if (bg == null) continue;

                int soGio = (int) Duration.between(gioBD, gioKT).toHours();
                int soTien = bg.getGiaTien1Gio() * soGio;

                datSan ds = new datSan();
                ds.setId(UUID.randomUUID().toString());
                ds.setIdKhachHang(nd.getId());
                ds.setIdSanBong(String.valueOf(idSanBong));
                ds.setSoTien(soTien);
                ds.setTrangThai(trangThaiDatSan.CHO_THANH_TOAN);
                ds.setGioBatDau(new java.sql.Date(gioBD_ts.getTime()));
                ds.setGioKetThuc(new java.sql.Date(gioKT_ts.getTime()));
                ds.setNgayTao(new Timestamp(System.currentTimeMillis()));
                ds.setNgayCapNhat(new Timestamp(System.currentTimeMillis()));

                DatSanDAO.Tao(ds);
                coTaoDuocLich = true;
                System.out.println("Đã tạo lịch đặt hợp lệ: " + ds);
            }
        }

        if (!coTaoDuocLich) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Không có khoảng thời gian hợp lệ để đặt sân.");
            return;
        }

        render(req, resp, "lichDatCuaToi");
    } catch (Exception e) {
        e.printStackTrace();
        resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi đặt sân");
    }
}

    private void taoLichDatNhanVien(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String idSanBong = req.getParameter("idSanBong");
            String timestampStartStr = req.getParameter("timestamp");
            String timestampEndStr = req.getParameter("timestampEnd");

            System.out.println("timestampStartStr: " + timestampStartStr);
            System.out.println("timestampEndStr: " + timestampEndStr);

            if (timestampStartStr == null || timestampEndStr == null ||
                    timestampStartStr.isEmpty() || timestampEndStr.isEmpty()) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu thông tin thời gian đặt sân");
                return;
            }

            Timestamp timestampStart = Timestamp.valueOf(timestampStartStr);
            Timestamp timestampEnd = Timestamp.valueOf(timestampEndStr);

            nguoiDung nd = (nguoiDung) req.getSession().getAttribute("nguoiDung");
            if (nd == null) {
                req.getSession().setAttribute("thongBao", "Bạn cần đăng nhập để đặt sân");
                resp.sendRedirect(req.getContextPath() + "/nguoiDung/dangNhap");
                return;
            }

            // Giờ nghỉ
            LocalTime nghiBatDau = LocalTime.of(10, 0);
            LocalTime nghiKetThuc = LocalTime.of(15, 0);

            LocalDateTime startDateTime = timestampStart.toLocalDateTime();
            LocalDateTime endDateTime = timestampEnd.toLocalDateTime();

            List<LocalDateTime[]> cacKhoangHopLe = new ArrayList<>();

            // Trường hợp hoàn toàn trước giờ nghỉ
            if (endDateTime.toLocalTime().isBefore(nghiBatDau) || endDateTime.toLocalTime().equals(nghiBatDau)) {
                cacKhoangHopLe.add(new LocalDateTime[]{startDateTime, endDateTime});
            }
            // Trường hợp hoàn toàn sau giờ nghỉ
            else if (startDateTime.toLocalTime().isAfter(nghiKetThuc) || startDateTime.toLocalTime().equals(nghiKetThuc)) {
                cacKhoangHopLe.add(new LocalDateTime[]{startDateTime, endDateTime});
            }
            // Trường hợp chồng vào giờ nghỉ
            else {
                if (startDateTime.toLocalTime().isBefore(nghiBatDau)) {
                    LocalDateTime end1 = LocalDateTime.of(startDateTime.toLocalDate(), nghiBatDau);
                    cacKhoangHopLe.add(new LocalDateTime[]{startDateTime, end1});
                }
                if (endDateTime.toLocalTime().isAfter(nghiKetThuc)) {
                    LocalDateTime start2 = LocalDateTime.of(endDateTime.toLocalDate(), nghiKetThuc);
                    cacKhoangHopLe.add(new LocalDateTime[]{start2, endDateTime});
                }
            }

            boolean coTaoDuocLich = false;

            for (LocalDateTime[] khoang : cacKhoangHopLe) {
                LocalDateTime gioBD = khoang[0];
                LocalDateTime gioKT = khoang[1];

                if (gioBD.isBefore(gioKT)) {
                    Timestamp gioBD_ts = Timestamp.valueOf(gioBD);
                    Timestamp gioKT_ts = Timestamp.valueOf(gioKT);

                    sanBong sb = SanBongDAO.timSanTheoId(idSanBong);
                    if( sb == null) {
                        continue;
                    }

                    bangGia bg = BangGiaDAO.timGiaTheoGio(gioBD_ts, sb.getKieuSan());
                    if (bg == null) continue;

                    int soGio = (int) Duration.between(gioBD, gioKT).toHours();
                    int soTien = bg.getGiaTien1Gio() * soGio;

                    datSan ds = new datSan();
                    ds.setId(UUID.randomUUID().toString());
                    ds.setIdKhachHang(nd.getId());
                    ds.setIdSanBong(String.valueOf(idSanBong));
                    ds.setSoTien(soTien);
                    ds.setTrangThai(trangThaiDatSan.DA_THANH_TOAN);
                    ds.setGioBatDau(new java.sql.Date(gioBD_ts.getTime()));
                    ds.setGioKetThuc(new java.sql.Date(gioKT_ts.getTime()));
                    ds.setNgayTao(new Timestamp(System.currentTimeMillis()));
                    ds.setNgayCapNhat(new Timestamp(System.currentTimeMillis()));

                    DatSanDAO.Tao(ds);
                    coTaoDuocLich = true;
                    System.out.println("Đã tạo lịch đặt hợp lệ: " + ds);
                }
            }

            if (!coTaoDuocLich) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Không có khoảng thời gian hợp lệ để đặt sân.");
                return;
            }

            render(req, resp, "danhSachTatCaLichDat");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi đặt sân");
        }
    }

    private void capNhatLichDatCuaToi(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String idDatSan = req.getParameter("idDatSan");
            String idSanBong = req.getParameter("idSanBong");
            String timestampStartStr = req.getParameter("timestampStart");
            String timestampEndStr = req.getParameter("timestampEnd");
            System.out.println("idDatSan ở capNhatLichDatCuaToi: " + idDatSan);
            System.out.println("idSanBong ở capNhatLichDatCuaToi: " + idSanBong);
            System.out.println("timestampStartStr ở capNhatLichDatCuaToi: " + timestampStartStr);
            System.out.println("timestampEndStr ở capNhatLichDatCuaToi: " + timestampEndStr);

            if (idDatSan == null || idSanBong == null || timestampStartStr == null || timestampEndStr == null ||
                    idDatSan.isEmpty() || idSanBong.isEmpty() || timestampStartStr.isEmpty() || timestampEndStr.isEmpty()) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu thông tin cập nhật lịch đặt sân.");
                return;
            }

//            Timestamp timestampStart = Timestamp.valueOf(timestampStartStr.replace("T", " ") + ":00");
//            Timestamp timestampEnd = Timestamp.valueOf(timestampEndStr.replace("T", " ") + ":00");

            Timestamp timestampStart = Timestamp.valueOf(timestampStartStr);
            Timestamp timestampEnd = Timestamp.valueOf(timestampEndStr);

            System.out.println("timestampStart: " + timestampStart);
            System.out.println("timestampEnd: " + timestampEnd);



            nguoiDung nd = (nguoiDung) req.getSession().getAttribute("nguoiDung");
            if (nd == null) {
                req.getSession().setAttribute("thongBao", "Bạn cần đăng nhập để cập nhật lịch đặt sân");
                resp.sendRedirect(req.getContextPath() + "/nguoiDung/dangNhap");
                return;
            }

            // Kiểm tra giờ nghỉ
            LocalTime nghiBatDau = LocalTime.of(10, 0);
            LocalTime nghiKetThuc = LocalTime.of(15, 0);

            LocalDateTime startDateTime = timestampStart.toLocalDateTime();
            LocalDateTime endDateTime = timestampEnd.toLocalDateTime();

            List<LocalDateTime[]> cacKhoangHopLe = new ArrayList<>();

            if (endDateTime.toLocalTime().isBefore(nghiBatDau) || endDateTime.toLocalTime().equals(nghiBatDau)) {
                cacKhoangHopLe.add(new LocalDateTime[]{startDateTime, endDateTime});
            } else if (startDateTime.toLocalTime().isAfter(nghiKetThuc) || startDateTime.toLocalTime().equals(nghiKetThuc)) {
                cacKhoangHopLe.add(new LocalDateTime[]{startDateTime, endDateTime});
            } else {
                if (startDateTime.toLocalTime().isBefore(nghiBatDau)) {
                    LocalDateTime end1 = LocalDateTime.of(startDateTime.toLocalDate(), nghiBatDau);
                    cacKhoangHopLe.add(new LocalDateTime[]{startDateTime, end1});
                }
                if (endDateTime.toLocalTime().isAfter(nghiKetThuc)) {
                    LocalDateTime start2 = LocalDateTime.of(endDateTime.toLocalDate(), nghiKetThuc);
                    cacKhoangHopLe.add(new LocalDateTime[]{start2, endDateTime});
                }
            }

            boolean coCapNhat = false;

            for (LocalDateTime[] khoang : cacKhoangHopLe) {
                LocalDateTime gioBD = khoang[0];
                LocalDateTime gioKT = khoang[1];

                if (gioBD.isBefore(gioKT)) {
                    Timestamp gioBD_ts = Timestamp.valueOf(gioBD);
                    Timestamp gioKT_ts = Timestamp.valueOf(gioKT);

                    sanBong sb = SanBongDAO.timSanTheoId(idSanBong);
                    if (sb == null) continue;

                    bangGia bg = BangGiaDAO.timGiaTheoGio(gioBD_ts, sb.getKieuSan());
                    if (bg == null) continue;

                    int soGio = (int) Duration.between(gioBD, gioKT).toHours();
                    int soTien = bg.getGiaTien1Gio() * soGio;

                    datSan dsCu = DatSanDAO.timDatSanTheoId(idDatSan);
                    if (dsCu == null || !dsCu.getIdKhachHang().equals(nd.getId())) {
                        resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy lịch đặt của bạn.");
                        return;
                    }

//                    dsCu.setIdSanBong(idSanBong);
//                    dsCu.setSoTien(soTien);
//                    dsCu.setGioBatDau(new java.sql.Date(gioBD_ts.getTime()));
//                    dsCu.setGioKetThuc(new java.sql.Date(gioKT_ts.getTime()));
//                    dsCu.setNgayCapNhat(new Timestamp(System.currentTimeMillis()));

                    // Cập nhật thông tin đặt sân
                    Map<String, Object> thongTinCapNhat = new HashMap<>();
                    thongTinCapNhat.put("idSanBong", idSanBong);
                    thongTinCapNhat.put("gioBatDau", timestampStart);
                    thongTinCapNhat.put("gioKetThuc", timestampEnd);
                    thongTinCapNhat.put("soTien", soTien);
                    thongTinCapNhat.put("ngayCapNhat", new Timestamp(System.currentTimeMillis()));

                    datSan daCapNhat = DatSanDAO.capNhatThongTinDatSan(idDatSan, thongTinCapNhat);

                    if (daCapNhat != null) {
                        req.setAttribute("thongBao", "Cập nhật lịch đặt thành công.");
                        coCapNhat = true;
//                        render(req, resp, "lichDatCuaToi");
                        resp.sendRedirect(req.getContextPath() + "/datSan/lichDatCaNhan");

                    } else {
                        resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Cập nhật thất bại.");
                    }

                }
            }

            if (!coCapNhat) {
                req.setAttribute("error", "Không có khoảng thời gian hợp lệ để cập nhật.");
                req.getRequestDispatcher("/nguoiDung/chinhSuaLichDat.jsp").forward(req, resp);
                return;
            }

//            resp.sendRedirect(req.getContextPath() + "/nguoiDung/lichDatCuaToi");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi cập nhật lịch đặt.");
        }
    }


private void layLichDatCuaKhachHang(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
    HttpSession session = req.getSession();

    String idKhachHang = req.getParameter("id");

    if (idKhachHang == null || idKhachHang.isEmpty()) {
        resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu ID khách hàng");
        return;
    }

    // Tìm danh sách đặt sân của khách hàng đó
    List<datSan> lichDat = DatSanDAO.timDanhSachDatSanTheoNguoiDung(idKhachHang);
    nguoiDung khachHang = NguoiDungDAO.layNguoiDungTheoId(idKhachHang);
    System.out.println("thông tin khách hàng lần1: " + khachHang);

    // Gửi sang JSP
    req.setAttribute("lichDat", lichDat);
//    req.setAttribute("idKhachHang", idKhachHang); // optional nếu cần
    req.setAttribute("khachHang", khachHang);
    session.setAttribute("lichDat", lichDat);
    session.setAttribute("khachHang", khachHang); // Lưu thông tin khách hàng vào session

    System.out.println("thông tin khách hàng lần2: " + khachHang);
    render(req, resp, "lichDatCuaKhachHang");
}

private void chinhSuaLichDatCaNhan(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
    String idDatSan = req.getParameter("idDatSan");

    datSan datSan = DatSanDAO.timDatSanTheoId(idDatSan);
    if (datSan == null) {
        req.setAttribute("error", "Không tìm thấy lịch đặt.");
        req.getRequestDispatcher("/loi.jsp").forward(req, resp);
        return;
    }

    sanBong sb = SanBongDAO.timSanTheoId(datSan.getIdSanBong());
    if (sb == null) {
        req.setAttribute("error", "Không tìm thấy sân.");
        req.getRequestDispatcher("/loi.jsp").forward(req, resp);
        return;
    }

    List<sanBong> sanBongCungKieu = SanBongDAO.timDanhSachSanTheoKieuSan(sb.getKieuSan());

    req.setAttribute("lichDat", datSan);
    req.setAttribute("sanBong", sb);
    req.setAttribute("sanBongCungKieu", sanBongCungKieu);
    render(req, resp, "chinhSuaLichDatCuaToi");

}


private void xacNhanThanhToan(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
    String idDatSan = req.getParameter("idDatSan");

    if (idDatSan == null || idDatSan.isEmpty()) {
        req.setAttribute("error", "ID đặt sân không hợp lệ");
        render(req, resp, "lichDatCuaKhachHang");
        return;
    }

    datSan ds = DatSanDAO.timDatSanTheoId(idDatSan);
    if (ds == null) {
        req.setAttribute("error", "Không tìm thấy đặt sân");
        render(req, resp, "lichDatCuaKhachHang");
        return;
    }

    String idKhachHang = ds.getIdKhachHang();
    nguoiDung khachHang = NguoiDungDAO.layNguoiDungTheoId(idKhachHang);


    // Cập nhật trạng thái đặt sân thành ĐÃ THANH TOÁN
    Map<String, Object> updates = new HashMap<>();
    updates.put("trangThai", trangThaiDatSan.DA_THANH_TOAN.name());

    datSan daCapNhat = DatSanDAO.capNhatThongTinDatSan(idDatSan, updates);
    List<datSan> lichDat = DatSanDAO.timDanhSachDatSanTheoNguoiDung(idKhachHang);


    if (daCapNhat != null) {
        req.setAttribute("thongBao", "Thanh toán thành công");
        req.setAttribute("lichDat", lichDat);
        req.setAttribute("khachHang", khachHang);
        render(req, resp, "lichDatCuaKhachHang");
    } else {
        req.setAttribute("error", "Lỗi không thể thanh toán");
        req.setAttribute("lichDat", lichDat);
        req.setAttribute("khachHang", khachHang);
        render(req, resp, "lichDatCuaKhachHang");
    }
}


private void khachHangHuyDatSan(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
    // Lấy ID đặt sân từ request
    String idDatSan = req.getParameter("idDatSan");
    String loiDatSan = null;

    if (idDatSan == null || idDatSan.isEmpty()) {
//        resp.sendRedirect(req.getContextPath() + "/lichDatCuaToi.jsp?error=invalid_id");
        req.setAttribute("loiDatSan", "ID đặt sân không hợp lệ");
        render(req, resp, "lichDatCuaToi");
        return;
    }

    // Tìm thông tin đặt sân theo ID
    datSan ds = DatSanDAO.timDatSanTheoId(idDatSan);
    if (ds == null) {
//        resp.sendRedirect(req.getContextPath() + "/lichDatCuaToi.jsp?error=not_found");
        req.setAttribute("loiDatSan", "Không tìm thấy sân");
        render(req, resp, "lichDatCuaToi");
        return;
    }

    // Kiểm tra thời gian hiện tại và giờ bắt đầu
    Date now = new Date();
    long millisecondsToStart = ds.getGioBatDau().getTime() - now.getTime();
    long hoursToStart = millisecondsToStart / (1000 * 60 * 60);

    if (hoursToStart <= 3) {
//        resp.sendRedirect(req.getContextPath() + "/lichDatCuaToi.jsp?error=too_late_to_cancel");
        req.setAttribute("loiDatSan", "Quá thời gian huỷ sân");
        render(req, resp, "lichDatCuaToi");
        return;
    }

    // Cập nhật trạng thái đặt sân thành ĐÃ HỦY
    Map<String, Object> updates = new HashMap<>();
    updates.put("trangThai", trangThaiDatSan.DA_HUY.name());

    datSan daCapNhat = DatSanDAO.capNhatThongTinDatSan(idDatSan, updates);

    if (daCapNhat != null) {
//        resp.sendRedirect(req.getContextPath() + "/lichDatCuaToi.jsp?success=cancelled");

        render(req, resp, "lichDatCuaToi");
    } else {
//        resp.sendRedirect(req.getContextPath() + "/lichDatCuaToi.jsp?error=cancel_failed");
        req.setAttribute("loiDatSan", "lỗi không thể huỷ sân");
        render(req, resp, "lichDatCuaToi");
    }
}

    private void nhanVienHuyDatSanKhachHang(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        // Lấy ID đặt sân từ request
        String idDatSan = req.getParameter("idDatSan");
        String loiDatSan = null;

        if (idDatSan == null || idDatSan.isEmpty()) {
//        resp.sendRedirect(req.getContextPath() + "/lichDatCuaToi.jsp?error=invalid_id");
            req.setAttribute("loiDatSan", "ID đặt sân không hợp lệ");
            render(req, resp, "lichDatCuaKhachHang");
            return;
        }

        // Tìm thông tin đặt sân theo ID
        datSan ds = DatSanDAO.timDatSanTheoId(idDatSan);
        if (ds == null) {
//        resp.sendRedirect(req.getContextPath() + "/lichDatCuaToi.jsp?error=not_found");
            req.setAttribute("loiDatSan", "Không tìm thấy sân");
            render(req, resp, "lichDatCuaKhachHang");
            return;
        }
        boolean daThanhToan = ds.getTrangThai() == trangThaiDatSan.DA_THANH_TOAN;

        // Kiểm tra thời gian hiện tại và giờ bắt đầu
        Date now = new Date();
        long millisecondsToStart = ds.getGioBatDau().getTime() - now.getTime();
        long hoursToStart = millisecondsToStart / (1000 * 60 * 60);


//        if (hoursToStart <= 3) {
////        resp.sendRedirect(req.getContextPath() + "/lichDatCuaToi.jsp?error=too_late_to_cancel");
//            req.setAttribute("loiDatSan", "Quá thời gian huỷ sân");
//            render(req, resp, "lichDatCuaKhachHang");
//            return;
//        }

        if(daThanhToan) {
//            req.setAttribute("loiDatSan", "Không thể huỷ sân đã thanh toán trong vòng 3 giờ trước giờ bắt đầu");
            req.setAttribute("loiDatSan", "Không thể huỷ sân đã thanh toán");
            render(req, resp, "lichDatCuaKhachHang");
            return;
        }


        // Cập nhật trạng thái đặt sân thành ĐÃ HỦY
        Map<String, Object> updates = new HashMap<>();
        updates.put("trangThai", trangThaiDatSan.DA_HUY.name());

        datSan daCapNhat = DatSanDAO.capNhatThongTinDatSan(idDatSan, updates);

        if (daCapNhat != null) {
//        resp.sendRedirect(req.getContextPath() + "/lichDatCuaToi.jsp?success=cancelled");

            render(req, resp, "lichDatCuaKhachHang");
        } else {
//        resp.sendRedirect(req.getContextPath() + "/lichDatCuaToi.jsp?error=cancel_failed");
            req.setAttribute("loiDatSan", "lỗi không thể huỷ sân");
            render(req, resp, "lichDatCuaKhachHang");
        }
    }
}
