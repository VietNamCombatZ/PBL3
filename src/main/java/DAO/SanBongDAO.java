package DAO;
import model.*;
import model.nguoiDung;
import util.ketnoiCSDL;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class SanBongDAO {

    public static boolean Tao(sanBong sb) {
        String sql = "INSERT INTO sanBong(id, tenSan, trangThai,  kieuSan, ngayTao, ngayCapNhat) " +
                "VALUES (?, ?, ?, ?, NOW(), NOW())";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, sb.getId());
            stmt.setString(2, sb.getTenSan());
            stmt.setString(3, sb.getTrangThai().name());
            stmt.setString(4, sb.getKieuSan().name());

            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static List<sanBong> layDanhSachSanBong(){
        List<sanBong> danhSachSan = new ArrayList<>();

        try (Connection conn = ketnoiCSDL.getConnection()) {
//            String sql = "select * from sanBong where id not in (select idSanBong from datSan where ? >= gioBatDau  and ? < gioKetThuc ) AND trangThai != 'BAO_TRI'";

            //lấy các sân có trạng thái sân khác bảo trì, và giờ đặt sân không trùng với giờ đặt sân đã có
//            String sql ="select * from sanBong where id not in (select idSanBong from datSan where (gioBatDau <= ? and ? <= gioKetThuc)or(gioBatDau <= ? and ? <= gioKetThuc)) and trangThai != 'BAO_TRI' ";
            String sql = "SELECT * FROM sanBong";



            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    sanBong san = new sanBong();
                    san.setId(rs.getString("id"));
                    san.setTenSan(rs.getString("tenSan"));
                    san.setTrangThai(trangThaiSan.valueOf(rs.getString("trangThai")));
                    san.setKieuSan(loaiSan.valueOf(rs.getString("kieuSan")));
                    san.setNgayTao(rs.getTimestamp("ngayTao"));
                    san.setNgayCapNhat(rs.getTimestamp("ngayCapNhat"));

                    danhSachSan.add(san);
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi SQL: " + e.getMessage());
            e.printStackTrace();
        }

        return danhSachSan;
    }

    public static List<sanBong> LayDanhSachSanCoSan(Timestamp timestampStart, Timestamp timestampEnd) {
        List<sanBong> danhSachSan = new ArrayList<>();

        try (Connection conn = ketnoiCSDL.getConnection()) {
//            String sql = "select * from sanBong where id not in (select idSanBong from datSan where ? >= gioBatDau  and ? < gioKetThuc ) AND trangThai != 'BAO_TRI'";

            //lấy các sân có trạng thái sân khác bảo trì, và giờ đặt sân không trùng với giờ đặt sân đã có
//            String sql ="select * from sanBong where id not in (select idSanBong from datSan where (gioBatDau <= ? and ? <= gioKetThuc)or(gioBatDau <= ? and ? <= gioKetThuc)) and trangThai != 'BAO_TRI' ";
            String sql = "SELECT * FROM sanBong WHERE id NOT IN (" +
                    "SELECT idSanBong FROM datSan " +
                    "WHERE gioKetThuc > ? AND gioBatDau < ? and trangThai != 'DA_HUY'" +
                    ") AND trangThai != 'BAO_TRI'";



            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setTimestamp(1, timestampStart);

                stmt.setTimestamp(2, timestampEnd);
                System.out.println("Thực thi truy vấn với timestampStart: " + timestampStart.toString());
                System.out.println("Thực thi truy vấn với timestampEnd: " + timestampEnd.toString());

                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    sanBong san = new sanBong();
                    san.setId(rs.getString("id"));
                    san.setTenSan(rs.getString("tenSan"));
                    san.setTrangThai(trangThaiSan.valueOf(rs.getString("trangThai")));
                    san.setKieuSan(loaiSan.valueOf(rs.getString("kieuSan")));
                    san.setNgayTao(rs.getTimestamp("ngayTao"));
                    san.setNgayCapNhat(rs.getTimestamp("ngayCapNhat"));

                    danhSachSan.add(san);
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi SQL: " + e.getMessage());
            e.printStackTrace();
        }

        return danhSachSan;
    }
    public static sanBong timSanTheoTenSan(String tenSan) {
        String sql = "SELECT * FROM sanBong WHERE tenSan = ?";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, tenSan);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                sanBong sb = new sanBong();
                sb.setTenSan(rs.getString("tenSan"));
                sb.setId(rs.getString("id"));
                sb.setTrangThai(trangThaiSan.valueOf(rs.getString("trangThai")));
                sb.setKieuSan(loaiSan.valueOf(rs.getString("kieuSan")));
                return sb;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static sanBong timSanTheoId(String id) {
        String sql = "SELECT * FROM sanBong WHERE id = ?";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                sanBong sb = new sanBong();
                sb.setId(rs.getString("id"));
                sb.setTenSan(rs.getString("tenSan"));
                sb.setTrangThai(trangThaiSan.valueOf(rs.getString("trangThai")));
                sb.setKieuSan(loaiSan.valueOf(rs.getString("kieuSan")));
                return sb;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static List<sanBong> timDanhSachSanTheoKieuSan(loaiSan kieuSan) {
        String sql = "SELECT * FROM sanBong WHERE kieuSan = ?";
        List<sanBong> danhSachSan = new ArrayList<>();
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, kieuSan.name());
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                sanBong sb = new sanBong();
                sb.setId(rs.getString("id"));
                sb.setTenSan(rs.getString("tenSan"));
                sb.setTrangThai(trangThaiSan.valueOf(rs.getString("trangThai")));
                sb.setKieuSan(loaiSan.valueOf(rs.getString("kieuSan")));
                danhSachSan.add(sb);
            }
            return danhSachSan;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static sanBong capNhatThongTinSan(String id, Map<String, Object> thongTinCapNhat){
        if (thongTinCapNhat == null || thongTinCapNhat.isEmpty()) return null;

        StringBuilder sql = new StringBuilder("UPDATE sanBong SET ");
        List<Object> values = new ArrayList<>();



        for (String column : thongTinCapNhat.keySet()) {
            sql.append(column).append(" = ?, ");
            values.add(thongTinCapNhat.get(column));
        }

        // Remove the last comma and space, and add the WHERE clause
        sql.setLength(sql.length() - 2);
        sql.append(" WHERE id = ?");
        values.add(id);

        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < values.size(); i++) {
                stmt.setObject(i + 1, values.get(i));
            }
            int rows = stmt.executeUpdate();
            if (rows > 0) {
                return timSanTheoId(id);
            } else {
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null; }
    }

    public static boolean xoa(String id) {
        String sql = "DELETE FROM sanBong WHERE id = ?";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
