package DAO;

import model.nguoiDung;
import util.ketnoiCSDL;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NguoiDungDAO {

    public void Tao(nguoiDung nd) {
        String sql = "INSERT INTO nguoi_dung (ten, email, mat_khau, anh_dai_dien, kich_hoat, ngay_tao, ngay_cap_nhat) " +
                "VALUES (?, ?, ?, ?, ?, NOW(), NOW())";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, nd.getTen());
            stmt.setString(2, nd.getEmail());
            stmt.setString(3, nd.getMatKhau());
            stmt.setString(4, nd.getAnhDaiDien());
            stmt.setBoolean(5, nd.isKichHoat());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public nguoiDung timBangEmail(String email) {
        String sql = "SELECT * FROM nguoi_dung WHERE email = ?";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                nguoiDung nd = new nguoiDung();
                nd.setId(rs.getInt("id"));
                nd.setTen(rs.getString("ten"));
                nd.setEmail(rs.getString("email"));
                nd.setMatKhau(rs.getString("mat_khau"));
                nd.setAnhDaiDien(rs.getString("anh_dai_dien"));
                nd.setKichHoat(rs.getBoolean("kich_hoat"));
                nd.setNgayTao(rs.getTimestamp("ngay_tao"));
                nd.setNgayCapNhat(rs.getTimestamp("ngay_cap_nhat"));
                return nd;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public nguoiDung dangNhap(String email, String matKhau) {
        String sql = "SELECT * FROM nguoi_dung WHERE email = ? AND mat_khau = ?";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, matKhau);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                nguoiDung nd = new nguoiDung();
                nd.setId(rs.getInt("id"));
                nd.setTen(rs.getString("ten"));
                nd.setEmail(rs.getString("email"));
                nd.setMatKhau(rs.getString("mat_khau"));
                nd.setAnhDaiDien(rs.getString("anh_dai_dien"));
                nd.setKichHoat(rs.getBoolean("kich_hoat"));
                nd.setNgayTao(rs.getTimestamp("ngay_tao"));
                nd.setNgayCapNhat(rs.getTimestamp("ngay_cap_nhat"));
                return nd;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public boolean capNhat(nguoiDung nd) {
        String sql = "UPDATE nguoi_dung SET ten = ?, email = ?, mat_khau = ?, anh_dai_dien = ?, kich_hoat = ?, ngay_cap_nhat = CURRENT_TIMESTAMP WHERE id = ?";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, nd.getTen());
            stmt.setString(2, nd.getEmail());
            stmt.setString(3, nd.getMatKhau());
            stmt.setString(4, nd.getAnhDaiDien());
            stmt.setBoolean(5, nd.isKichHoat());
            stmt.setInt(6, nd.getId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean xoa(int id) {
        String sql = "DELETE FROM nguoi_dung WHERE id = ?";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean register(nguoiDung nd) {
        String sql = "INSERT INTO nguoi_dung (ten, email, mat_khau, anh_dai_dien, kich_hoat, ngay_tao, ngay_cap_nhat) " +
                "VALUES (?, ?, ?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, nd.getTen());
            stmt.setString(2, nd.getEmail());
            stmt.setString(3, nd.getMatKhau());
            stmt.setString(4, nd.getAnhDaiDien());
            stmt.setBoolean(5, nd.isKichHoat());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


}
