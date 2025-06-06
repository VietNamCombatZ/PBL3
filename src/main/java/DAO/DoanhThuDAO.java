package DAO;

import util.ketnoiCSDL;

import java.sql.*;
import java.util.LinkedHashMap;
import java.util.Map;

public class DoanhThuDAO {

    // 1. Doanh thu theo ngày
    public static Map<String, Integer> getDoanhThuTheoNgay() {
        Map<String, Integer> result = new LinkedHashMap<>();
        String sql = "SELECT DATE(ngayTao) AS ngay, SUM(soTien) AS tongTien " +
                "FROM datSan WHERE trangThai = 'DA_THANH_TOAN' " +
                "GROUP BY DATE(ngayTao) ORDER BY ngay";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                String ngay = rs.getString("ngay");
                int tong = rs.getInt("tongTien");
                result.put(ngay, tong);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    // 2. Doanh thu theo tuần
    public static Map<String, Integer> getDoanhThuTheoTuan() {
        Map<String, Integer> result = new LinkedHashMap<>();
        String sql = "SELECT YEAR(ngayTao) AS nam, WEEK(ngayTao) AS tuan, SUM(soTien) AS tongTien " +
                "FROM datSan WHERE trangThai = 'DA_THANH_TOAN' " +
                "GROUP BY nam, tuan ORDER BY nam, tuan";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                String key = "Tuần " + rs.getInt("tuan") + "/" + rs.getInt("nam");
                int tong = rs.getInt("tongTien");
                result.put(key, tong);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    // 3. Doanh thu theo tháng
    public static Map<String, Integer> getDoanhThuTheoThang() {
        Map<String, Integer> result = new LinkedHashMap<>();
        String sql = "SELECT YEAR(ngayTao) AS nam, MONTH(ngayTao) AS thang, SUM(soTien) AS tongTien " +
                "FROM datSan WHERE trangThai = 'DA_THANH_TOAN' " +
                "GROUP BY nam, thang ORDER BY nam, thang";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                String key = "Tháng " + rs.getInt("thang") + "/" + rs.getInt("nam");
                int tong = rs.getInt("tongTien");
                result.put(key, tong);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    // 4. Doanh thu theo loại sân (Sân 5, Sân 7)
    public static Map<String, Integer> getDoanhThuTheoLoaiSan() {
        Map<String, Integer> result = new LinkedHashMap<>();
        String sql = "SELECT s.kieuSan, SUM(d.soTien) AS tongTien " +
                "FROM datSan d JOIN sanBong s ON d.idSanBong = s.id " +
                "WHERE d.trangThai = 'DA_THANH_TOAN' " +
                "GROUP BY s.kieuSan";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                String loaiSan = rs.getString("kieuSan").replace("SAN_", "Sân ");
                int tong = rs.getInt("tongTien");
                result.put(loaiSan, tong);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    // 5. Thống kê số lượng sân được đặt theo giờ
    public static Map<String, Integer> getSoLuongSanTheoGio() {
        Map<String, Integer> result = new LinkedHashMap<>();
        for (int i = 0; i < 24; i++) {
            result.put(i + "h", 0); // khởi tạo đủ các giờ từ 0h đến 23h
        }

        String sql = "SELECT HOUR(gioBatDau) AS gio, COUNT(*) AS soLuong " +
                "FROM datSan WHERE trangThai = 'DA_THANH_TOAN' " +
                "GROUP BY gio ORDER BY gio";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                String gio = rs.getInt("gio") + "h";
                int soLuong = rs.getInt("soLuong");
                result.put(gio, soLuong);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
}
