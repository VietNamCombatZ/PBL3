package DAO;


import model.*;

import util.ketnoiCSDL;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


public class DatSanDAO {
    public static boolean Tao(datSan ds) {
        String sql = "INSERT INTO datSan(id, idKhachHang, idSanBong, soTien, trangThai, gioBatDau, gioKetThuc, ngayTao, ngayCapNhat) " +
                "VALUES (?, ?, ?, ?,?, ?,?, NOW(), NOW())";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, ds.getId());
            stmt.setString(2, ds.getIdKhachHang());
            stmt.setString(3, ds.getIdSanBong());
            stmt.setInt(4, ds.getSoTien());
            stmt.setString(5, ds.getTrangThai().name());
            stmt.setTimestamp(6, new java.sql.Timestamp(ds.getGioBatDau().getTime()));
            stmt.setTimestamp(7, new java.sql.Timestamp(ds.getGioKetThuc().getTime()));

            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static datSan timDatSanTheoId(String id){
        String sql = "SELECT * FROM datSan WHERE id = ?";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                datSan ds = new datSan();
                ds.setId(rs.getString("id"));
                ds.setIdKhachHang(rs.getString("idKhachHang"));
                ds.setIdSanBong(rs.getString("idSanBong"));
                ds.setSoTien(rs.getInt("soTien"));
                ds.setTrangThai(trangThaiDatSan.valueOf(rs.getString("trangThai")));
                ds.setGioBatDau(new java.sql.Date(rs.getTimestamp("gioBatDau").getTime()));
                ds.setGioKetThuc(new java.sql.Date(rs.getTimestamp("gioKetThuc").getTime()));
                return ds;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static List<datSan> timDanhSachDatSanTheoNguoiDung(String idKhachHang){
        String sql = "SELECT * FROM datSan WHERE idKhachHang = ?";
        List<datSan> danhSachDatSan = new ArrayList<>();
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, idKhachHang);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                datSan ds = new datSan();
                ds.setId(rs.getString("id"));
                ds.setIdKhachHang(rs.getString("idKhachHang"));
                ds.setIdSanBong(rs.getString("idSanBong"));
                ds.setSoTien(rs.getInt("soTien"));
                ds.setTrangThai(trangThaiDatSan.valueOf(rs.getString("trangThai")));
                ds.setGioBatDau(new java.sql.Date(rs.getTimestamp("gioBatDau").getTime()));
                ds.setGioKetThuc(new java.sql.Date(rs.getTimestamp("gioKetThuc").getTime()));
                danhSachDatSan.add(ds);
            }
            return danhSachDatSan;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

    }


    public static List<datSan> timDanhSachDatSanTheoThoiGian(Date gioBatDau, Date gioKetThuc ){
        String sql = "SELECT * FROM datSan WHERE gioBatDau >= ? AND gioKetThuc <= ?";
        List<datSan> danhSachDatSan = new ArrayList<>();
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDate(1, gioBatDau);
            stmt.setDate(2, gioKetThuc);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                datSan ds = new datSan();
                ds.setId(rs.getString("id"));
                ds.setIdKhachHang(rs.getString("idKhachHang"));
                ds.setIdSanBong(rs.getString("idSanBong"));
                ds.setSoTien(rs.getInt("soTien"));
                ds.setTrangThai(trangThaiDatSan.valueOf(rs.getString("trangThai")));
                ds.setGioBatDau(new java.sql.Date(rs.getTimestamp("gioBatDau").getTime()));
                ds.setGioKetThuc(new java.sql.Date(rs.getTimestamp("gioKetThuc").getTime()));
                danhSachDatSan.add(ds);
            }
            return danhSachDatSan;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static datSan capNhatThongTinDatSan(String id, Map<String, Object> thongTinCapNhat){
        if (thongTinCapNhat == null || thongTinCapNhat.isEmpty()) return null;

        StringBuilder sql = new StringBuilder("UPDATE cars SET ");
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
                return timDatSanTheoId(id);
            } else {
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null; }
    }

    public static boolean xoaTheoId(String id) {
        String sql = "DELETE FROM datSan WHERE id = ?";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, id);
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
