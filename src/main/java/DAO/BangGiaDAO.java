package DAO;

import model.*;
import util.ketnoiCSDL;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.*;
import java.util.*;

public class BangGiaDAO {
    public static boolean Tao(bangGia bg) {
        String sql = "INSERT INTO bangGia (id, gioBatDau, gioKetThuc, giaTien1Gio, kieuSan, ngayTao, ngayCapNhat) " +
                "VALUES (?, ?, ?, ?, ?,NOW(), NOW())";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, bg.getId());
            stmt.setTime(2, bg.getGioBatDau());
            stmt.setTime(3, bg.getGioKetThuc());
            stmt.setInt(4, bg.getGiaTien1Gio());
            stmt.setString(5, bg.getKieuSan().name());


            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static bangGia timBangGiaTheoId(String id) {
        String sql = "SELECT * FROM bangGia WHERE id = ?";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                bangGia bg = new bangGia();
                bg.setId(rs.getString("id"));
                bg.setGioBatDau(rs.getTime("gioBatDau"));
                bg.setGioKetThuc(rs.getTime("gioKetThuc"));
                bg.setGiaTien1Gio(rs.getInt("giaTien1Gio"));
                bg.setKieuSan(loaiSan.valueOf(rs.getString("kieuSan")));
                return bg;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        return null;
    }

    public static bangGia timGiaTheoGio(Timestamp gioBatDau, loaiSan kieuSan) {
        String sql = "SELECT * FROM bangGia WHERE gioBatDau <= ? AND gioKetThuc > ? and kieuSan = ?";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setTimestamp(1, gioBatDau);
            stmt.setTimestamp(2, gioBatDau);
            stmt.setString(3, kieuSan.name());
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                bangGia bg = new bangGia();
                bg.setId(rs.getString("id"));
                bg.setGioBatDau(rs.getTime("gioBatDau"));
                bg.setGioKetThuc(rs.getTime("gioKetThuc"));
                bg.setGiaTien1Gio(rs.getInt("giaTien1Gio"));
                bg.setKieuSan(loaiSan.valueOf(rs.getString("kieuSan")));
                return bg;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        return null;
    }

    public static List<bangGia> timDanhSachBangGia() {
        String sql = "SELECT * FROM bangGia";
        List<bangGia> dsBangGia = new ArrayList<>();

        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                bangGia bg = new bangGia();
                bg.setId(rs.getString("id"));
                bg.setGioBatDau(rs.getTime("gioBatDau"));
                bg.setGioKetThuc(rs.getTime("gioKetThuc"));
                bg.setGiaTien1Gio(rs.getInt("giaTien1Gio"));
                bg.setKieuSan(loaiSan.valueOf(rs.getString("kieuSan")));
                dsBangGia.add(bg);
            }
            return dsBangGia;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

    }

    public static bangGia capNhatThongTinBangGia(String id, Map<String, Object> fieldsToUpdate) {
        if (fieldsToUpdate == null || fieldsToUpdate.isEmpty()) return null;

        StringBuilder sql = new StringBuilder("UPDATE bangGia SET ");
        List<Object> values = new ArrayList<>();

        for (Map.Entry<String, Object> entry : fieldsToUpdate.entrySet()) {
            sql.append(entry.getKey()).append(" = ?, ");
            values.add(entry.getValue());
        }
        sql.setLength(sql.length() - 2); // Remove the last comma and space
        sql.append(" WHERE id = ?");

        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < values.size(); i++) {
                stmt.setObject(i + 1, values.get(i));
            }
            stmt.setString(values.size() + 1, id);
            stmt.executeUpdate();
            return timBangGiaTheoId(id);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static boolean xoaBangGia(String id) {
        String sql = "DELETE FROM bangGia WHERE id = ?";
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
