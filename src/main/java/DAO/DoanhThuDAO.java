package DAO;

import util.ketnoiCSDL;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.YearMonth;
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

    public static Map<String, Integer> getDoanhThuTheoNgay(String tuNgay, String denNgay) {
        Map<String, Integer> doanhThu = new LinkedHashMap<>();
        String sql = "SELECT DATE(ngayTao) AS ngay, SUM(soTien) AS tong " +
                "FROM datSan " +
                "WHERE DATE(ngayTao) BETWEEN ? AND ? AND trangThai = 'DA_THANH_TOAN' " +
                "GROUP BY DATE(ngayTao) ORDER BY ngay";

        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, tuNgay);
            ps.setString(2, denNgay);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String ngay = rs.getString("ngay");
                int tong = rs.getInt("tong");
                doanhThu.put(ngay, tong);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return doanhThu;
    }

    public static Map<String, Integer> getDoanhThuTheoLoaiSanTheoNgay(String tuNgay, String denNgay) {
        Map<String, Integer> result = new LinkedHashMap<>();
        String sql = "SELECT s.kieuSan, SUM(d.soTien) AS tongTien " +
                "FROM datSan d JOIN sanBong s ON d.idSanBong = s.id " +
                "WHERE DATE(d.ngayTao) BETWEEN ? AND ? AND d.trangThai = 'DA_THANH_TOAN' " +
                "GROUP BY s.kieuSan";

        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, tuNgay);
            stmt.setString(2, denNgay);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String loaiSan = rs.getString("kieuSan").replace("SAN_", "Sân ");
                    int tong = rs.getInt("tongTien");
                    result.put(loaiSan, tong);
                }
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


    public static Map<String, Integer> getDoanhThuTheoTuan(int tuTuan, int denTuan) {
        Map<String, Integer> doanhThu = new LinkedHashMap<>();
        String sql = "SELECT WEEK(ngayTao, 1) AS tuan, SUM(soTien) AS tong " +
                "FROM datSan " +
                "WHERE WEEK(ngayTao, 1) BETWEEN ? AND ? AND trangThai = 'DA_THANH_TOAN' " +
                "GROUP BY tuan ORDER BY tuan";

        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, tuTuan);
            ps.setInt(2, denTuan);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int tuan = rs.getInt("tuan");
                int tong = rs.getInt("tong");
                doanhThu.put("Tuần " + tuan, tong);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return doanhThu;
    }

    public static Map<String, Integer> getDoanhThuTheoLoaiSanTheoTuan(int tuTuan, int denTuan) {
        Map<String, Integer> result = new LinkedHashMap<>();

        String sql = "SELECT s.kieuSan, SUM(d.soTien) AS tongTien " +
                "FROM datSan d JOIN sanBong s ON d.idSanBong = s.id " +
                "WHERE WEEK(d.ngayTao, 1) BETWEEN ? AND ? " +
                "AND d.trangThai = 'DA_THANH_TOAN' " +
                "GROUP BY s.kieuSan";

        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, tuTuan);
            stmt.setInt(2, denTuan);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String loaiSan = rs.getString("kieuSan").replace("SAN_", "Sân ");
                    int tong = rs.getInt("tongTien");
                    result.put(loaiSan, tong);
                }
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

    public static Map<String, Integer> getDoanhThuTheoThang(int tuNam, int tuThang, int denNam, int denThang) {
        Map<String, Integer> doanhThu = new LinkedHashMap<>();

        try (Connection conn = ketnoiCSDL.getConnection()) {

            // Tạo thời điểm bắt đầu và kết thúc
            LocalDate startDate = LocalDate.of(tuNam, tuThang, 1);
            LocalDate endDate = LocalDate.of(denNam, denThang, 1).withDayOfMonth(
                    YearMonth.of(denNam, denThang).lengthOfMonth()
            );

            Timestamp startTimestamp = Timestamp.valueOf(startDate.atStartOfDay());
            Timestamp endTimestamp = Timestamp.valueOf(endDate.atTime(LocalTime.MAX)); // 23:59:59.999999999

            String sql = "SELECT YEAR(ngayTao) AS nam, MONTH(ngayTao) AS thang, SUM(soTien) AS tong " +
                    "FROM datSan " +
                    "WHERE ngayTao BETWEEN ? AND ? AND trangThai = 'DA_THANH_TOAN' " +
                    "GROUP BY nam, thang ORDER BY nam, thang";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setTimestamp(1, startTimestamp);
            ps.setTimestamp(2, endTimestamp);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int nam = rs.getInt("nam");
                int thang = rs.getInt("thang");
                int tong = rs.getInt("tong");
                doanhThu.put("Tháng " + thang + "/" + nam, tong);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return doanhThu;
    }


    public static Map<String, Integer> getDoanhThuTheoLoaiSanTheoThang(int tuNam, int tuThang, int denNam, int denThang) {
        Map<String, Integer> result = new LinkedHashMap<>();

        // Tạo thời điểm bắt đầu và kết thúc
        LocalDate startDate = LocalDate.of(tuNam, tuThang, 1);
        LocalDate endDate = LocalDate.of(denNam, denThang, 1)
                .withDayOfMonth(YearMonth.of(denNam, denThang).lengthOfMonth());

        Timestamp startTimestamp = Timestamp.valueOf(startDate.atStartOfDay());
        Timestamp endTimestamp = Timestamp.valueOf(endDate.atTime(LocalTime.MAX)); // 23:59:59.999999999

        String sql = "SELECT s.kieuSan, YEAR(d.ngayTao) AS nam, MONTH(d.ngayTao) AS thang, SUM(d.soTien) AS tongTien " +
                "FROM datSan d JOIN sanBong s ON d.idSanBong = s.id " +
                "WHERE d.ngayTao BETWEEN ? AND ? AND d.trangThai = 'DA_THANH_TOAN' " +
                "GROUP BY s.kieuSan, YEAR(d.ngayTao), MONTH(d.ngayTao)";

        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setTimestamp(1, startTimestamp);
            stmt.setTimestamp(2, endTimestamp);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String loaiSan = rs.getString("kieuSan").replace("SAN_", "Sân ");
                    int tong = rs.getInt("tongTien");
                    result.put(loaiSan, result.getOrDefault(loaiSan, 0) + tong);
                }
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
