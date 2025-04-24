package DAO;

import model.nguoiDung;
import util.ketnoiCSDL;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NguoiDungDAO {

    public void insert(nguoiDung nd) {
        String sql = "INSERT INTO nguoi_dung (ten, email, mat_khau, anh_dai_dien, kich_hoat, ngay_tao, ngay_cap_nhat) " +
                "VALUES (?, ?, ?, ?, ?, NOW(), NOW())";
        try (Connection conn = DBUtil.getConnection();
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

    public nguoiDung findByEmail(String email) {
        String sql = "SELECT * FROM nguoi_dung WHERE email = ?";
        try (Connection conn = DBUtil.getConnection();
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

    // Có thể thêm các method khác như update, delete, getAll...
}
