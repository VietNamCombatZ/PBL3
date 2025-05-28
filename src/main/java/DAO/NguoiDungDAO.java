package DAO;

import model.*;
import util.ketnoiCSDL;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NguoiDungDAO {

    public static boolean Tao(nguoiDung nd) {
        String sql = "INSERT INTO nguoiDung (id, email, matKhau, ten, anhDaiDien, vaiTroNguoiDung, ngaySinh, ngayTao, ngayCapNhat) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, nd.getId());
            stmt.setString(2, nd.getEmail());
            stmt.setString(3, nd.getMatKhau());
            stmt.setString(4, nd.getTen());
            stmt.setString(5, nd.getAnhDaiDien());
            stmt.setString(6, nd.getVaiTroNguoiDung().name());
            stmt.setDate(7, new java.sql.Date(nd.getNgaySinh().getTime()));

            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

//    public nguoiDung timBangEmail(String email) {
//        String sql = "SELECT * FROM nguoiDung WHERE email = ?";
//        try (Connection conn = ketnoiCSDL.getConnection();
//             PreparedStatement stmt = conn.prepareStatement(sql)) {
//            stmt.setString(1, email);
//            ResultSet rs = stmt.executeQuery();
//            if (rs.next()) {
//                nguoiDung nd = new nguoiDung();
//                nd.setId(rs.getString("id"));
//                nd.setTen(rs.getString("ten"));
//                nd.setEmail(rs.getString("email"));
//                nd.setMatKhau(rs.getString("matKhau"));
//                nd.setAnhDaiDien(rs.getString("anhDaiDien"));
//                nd.setNgaySinh(new java.sql.Date(rs.getDate("ngaySinh").getTime()));
//                nd.setNgayTao(rs.getTimestamp("ngayTao"));
//                nd.setNgayCapNhat(rs.getTimestamp("ngayCapNhat"));
//                return nd;
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return null;
//    }

    public nguoiDung dangNhap(String email, String matKhau) {
        String sql = "SELECT * FROM nguoiDung WHERE email = ? AND mat_khau = ?";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, matKhau);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                nguoiDung nd = new nguoiDung();
                nd.setId(rs.getString("id"));
                nd.setTen(rs.getString("ten"));
                nd.setEmail(rs.getString("email"));
                nd.setMatKhau(rs.getString("matKhau"));
                nd.setAnhDaiDien(rs.getString("anhDaiDien"));
                nd.setNgaySinh(new java.sql.Date(rs.getDate("ngaySinh").getTime()));
                nd.setVaiTroNguoiDung(vaiTro.valueOf(rs.getString("vaiTroNguoiDung")));

                nd.setNgayTao(rs.getTimestamp("ngayTao"));
                nd.setNgayCapNhat(rs.getTimestamp("ngayCapNhat"));
                return nd;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public static boolean capNhat(nguoiDung nd) {
        String sql = "UPDATE nguoiDung SET  email = ?, matKhau = ?,ten = ?, anh_dai_dien = ?, vaiTroNguoiDung = ?,ngaySinh=?, ngay_cap_nhat = CURRENT_TIMESTAMP WHERE id = ?";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, nd.getEmail());
            stmt.setString(2, nd.getMatKhau());
            stmt.setString(3, nd.getTen());
            stmt.setString(4, nd.getAnhDaiDien());
            stmt.setString(5, nd.getVaiTroNguoiDung().name());
            stmt.setDate(6, new java.sql.Date(nd.getNgaySinh().getTime()));

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean xoa(String id) {
        String sql = "DELETE FROM nguoiDung WHERE id = ?";
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

    public boolean dangKy(nguoiDung nd) {
        String sql = "INSERT INTO nguoiDung (ten, email, mat_khau, anh_dai_dien, kich_hoat, ngay_tao, ngay_cap_nhat) " +
                "VALUES (?, ?, ?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, nd.getTen());
            stmt.setString(2, nd.getEmail());
            stmt.setString(3, nd.getMatKhau());
            stmt.setString(4, nd.getAnhDaiDien());


            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean kiemTraDangKy(nguoiDung nd) {
        String sql = "SELECT * FROM nguoiDung WHERE email = ?";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, nd.getEmail());
            ResultSet rs = stmt.executeQuery();
            return rs.next(); // Nếu có kết quả thì email đã tồn tại
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public static nguoiDung layNguoiDungTheoId(String id) {
        String sql = "SELECT * FROM nguoiDung WHERE id = ?";
        try {
            Connection conn = ketnoiCSDL.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
//            Statement statement = conn.createStatement();
            System.out.println("Đang kết nối DB...");
            stmt.setString(1, id);
//            sql.setString(1, id);
            System.out.println("stmt: " + stmt);
            ResultSet rs = stmt.executeQuery();
            System.out.println("rs : " + rs);
            if (rs.next()) {
                nguoiDung nd = new nguoiDung();
                nd.setId(rs.getString("id"));
                nd.setTen(rs.getString("ten"));
                nd.setEmail(rs.getString("email"));
                nd.setMatKhau(rs.getString("matKhau"));
                nd.setAnhDaiDien(rs.getString("anhDaiDien"));
                nd.setNgaySinh(rs.getDate("ngaySinh"));
                nd.setVaiTroNguoiDung(vaiTro.valueOf(rs.getString("vaiTroNguoiDung")));

                nd.setNgayTao(rs.getTimestamp("ngayTao"));
                nd.setNgayCapNhat(rs.getTimestamp("ngayCapNhat"));
                return nd;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static nguoiDung layNguoiDungTheoEmail(String email) {
        String sql = "SELECT * FROM nguoiDung WHERE email = ?";
        try {
            Connection conn = ketnoiCSDL.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
//            Statement statement = conn.createStatement();
            System.out.println("Đang kết nối DB...");
            stmt.setString(1, email);
//            sql.setString(1, email);
            System.out.println("stmt: " + stmt);
            ResultSet rs = stmt.executeQuery();
            System.out.println("rs : " + rs);
            if (rs.next()) {
                nguoiDung nd = new nguoiDung();
                nd.setId(rs.getString("id"));
                nd.setTen(rs.getString("ten"));
                nd.setEmail(rs.getString("email"));
                nd.setMatKhau(rs.getString("matKhau"));
                nd.setAnhDaiDien(rs.getString("anhDaiDien"));
                nd.setNgaySinh(rs.getDate("ngaySinh"));
                nd.setVaiTroNguoiDung(vaiTro.valueOf(rs.getString("vaiTroNguoiDung")));

                nd.setNgayTao(rs.getTimestamp("ngayTao"));
                nd.setNgayCapNhat(rs.getTimestamp("ngayCapNhat"));
                return nd;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public static List<nguoiDung> layNguoiDungTheoVaiTro(String vaiTro) {
        String sql = "SELECT * FROM nguoiDung WHERE vaiTroNguoiDung = ?";
        List<nguoiDung> danhSachNguoiDung = new ArrayList<>();

        try {
            Connection conn = ketnoiCSDL.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
//            Statement statement = conn.createStatement();
            System.out.println("Đang kết nối DB...");
            stmt.setString(1, vaiTro);
//            sql.setString(1, email);
            System.out.println("stmt: " + stmt);
            ResultSet rs = stmt.executeQuery();
            System.out.println("rs : " + rs);
            while (rs.next()) {
                nguoiDung nd = new nguoiDung();
                nd.setId(rs.getString("id"));
                nd.setTen(rs.getString("ten"));
                nd.setEmail(rs.getString("email"));
                nd.setMatKhau(rs.getString("matKhau"));
                nd.setAnhDaiDien(rs.getString("anhDaiDien"));
                nd.setNgaySinh(rs.getDate("ngaySinh"));
                nd.setVaiTroNguoiDung(model.vaiTro.valueOf(rs.getString("vaiTroNguoiDung")));
                nd.setNgayTao(rs.getTimestamp("ngayTao"));
                nd.setNgayCapNhat(rs.getTimestamp("ngayCapNhat"));
                danhSachNguoiDung.add(nd);
            }
            return danhSachNguoiDung;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean kiemTraDangNhap(String email, String password) {
//        String sql = "SELECT * FROM nguoiDung WHERE email = ? AND mat_khau = ?";
//        try (Connection conn = ketnoiCSDL.getConnection();
//             PreparedStatement stmt = conn.prepareStatement(sql)) {
//            stmt.setString(1, nd.getEmail());
//            stmt.setString(2, nd.getMatKhau());
//            ResultSet rs = stmt.executeQuery();
//            return rs.next();// Nếu có kết quả thì đăng nhập thành công
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return false;
//        }

        nguoiDung nd = layNguoiDungTheoEmail(email);
        if(nd != null && nd.getMatKhau().equals(password)) {
            return true; // Đăng nhập thành công
        } else {
            return false; // Đăng nhập thất bại

        }
    }


}
