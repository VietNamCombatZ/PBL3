package DAO;
import model.*;

import util.ketnoiCSDL;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
public class CongViecDAO {
    public static boolean Tao(congViec cv) {
        String sql = "INSERT INTO bangGia (id, idNguoiDung, tenCongViec,thoiGianBatDau, thoiGianKetThuc,  ngayTao, ngayCapNhat) " +
                "VALUES (?, ?, ?, ?,?, NOW(), NOW())";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, cv.getId());
            stmt.setString(2, cv.getIdNguoiDung());
            stmt.setString(3, cv.getTenCongViec().name());
            stmt.setTimestamp(4, new java.sql.Timestamp(cv.getThoiGianBatDau().getTime()));
            stmt.setTimestamp(5, new java.sql.Timestamp(cv.getThoiGianKetThuc().getTime()));


            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static congViec timCongViecTheoId(String id){
        String sql = "SELECT * FROM congViec WHERE id = ?";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                congViec cv = new congViec();
                cv.setId(rs.getString("id"));
                cv.setIdNguoiDung(rs.getString("idNguoiDung"));
                cv.setTenCongViec(loaiCongViec.valueOf(rs.getString("tenCongViec")));
                cv.setThoiGianBatDau(rs.getTimestamp("thoiGianBatDau"));
                cv.setThoiGianKetThuc(rs.getTimestamp("thoiGianKetThuc"));
                return cv;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public static List<congViec> timDanhSachCongViecTheoNguoiDung(String idNguoiDung){
        String sql = "SELECT * FROM congViec WHERE idNguoiDung = ?";
        List<congViec> dsCongViec = new ArrayList<>();

        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, idNguoiDung);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                congViec cv = new congViec();
                cv.setId(rs.getString("id"));
                cv.setIdNguoiDung(rs.getString("idNguoiDung"));
                cv.setTenCongViec(loaiCongViec.valueOf(rs.getString("tenCongViec")));
                cv.setThoiGianBatDau(rs.getTimestamp("thoiGianBatDau"));
                cv.setThoiGianKetThuc(rs.getTimestamp("thoiGianKetThuc"));
                dsCongViec.add(cv);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dsCongViec;
    }

    public static List<congViec> timdanhSachCongViecChuaHoanThanh(String idNguoiDung){
        String sql = "SELECT * FROM congViec WHERE idNguoiDung = ? AND trangThai = false";
        List<congViec> dsCongViec = new ArrayList<>();

        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, idNguoiDung);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                congViec cv = new congViec();
                cv.setId(rs.getString("id"));
                cv.setIdNguoiDung(rs.getString("idNguoiDung"));
                cv.setTenCongViec(loaiCongViec.valueOf(rs.getString("tenCongViec")));
                cv.setThoiGianBatDau(rs.getTimestamp("thoiGianBatDau"));
                cv.setThoiGianKetThuc(rs.getTimestamp("thoiGianKetThuc"));
                dsCongViec.add(cv);
            }
            return dsCongViec;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

    }

    public static congViec capNhatThongTinCongViec(String id, Map<String, Object> fieldsToUpdate){
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
            return timCongViecTheoId(id);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }



    }

    public static boolean xoaCongViec(String id) {
        String sql = "DELETE FROM congViec WHERE id = ?";
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
