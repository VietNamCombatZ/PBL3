package DAO;

import model.*;

import util.ketnoiCSDL;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class DanhGiaDAO {
    public static boolean Tao(danhGia dg) {
        String sql = "INSERT INTO danhGia (id, idKhachHang, idDatSan, idSanBong, noiDung, mucDiem,  ngayTao, ngayCapNhat) " +
                "VALUES (?, ?, ?, ?,?,?, NOW(), NOW())";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, dg.getId());
            stmt.setString(2, dg.getIdKhachHang());
            stmt.setString(3, dg.getIdDatSan());
            stmt.setString(4, dg.getIdSanBong());
            stmt.setString(5, dg.getNoiDung());
            stmt.setString(6, dg.getMucDiem().name());



            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static danhGia timDanhGiaTheoId(String id){
        String sql = "SELECT * FROM danhGia WHERE id = ?";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                danhGia dg = new danhGia();
                dg.setId(rs.getString("id"));
                dg.setIdKhachHang(rs.getString("idKhachHang"));
                dg.setIdDatSan(rs.getString("idDatSan"));
                dg.setIdSanBong(rs.getString("idSanBong"));
                dg.setNoiDung(rs.getString("noiDung"));
                dg.setMucDiem(mucDiem.valueOf(rs.getString("mucDiem")));
                return dg;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        return null;
    }

    public static List<danhGia> timTatCaDanhGia(){
        String sql = "SELECT * FROM danhGia";
        List<danhGia> dsDanhGia = new ArrayList<>();

        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                danhGia dg = new danhGia();
                dg.setId(rs.getString("id"));
                dg.setIdKhachHang(rs.getString("idKhachHang"));
                dg.setIdDatSan(rs.getString("idDatSan"));
                dg.setIdSanBong(rs.getString("idSanBong"));
                dg.setNoiDung(rs.getString("noiDung"));
                dg.setMucDiem(mucDiem.valueOf(rs.getString("mucDiem")));
                dsDanhGia.add(dg);
            }
            return dsDanhGia;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

    }

    public static List<danhGia> timDanhGiaTheoKhachHang(String idKhachHang){
        String sql = "SELECT * FROM danhGia WHERE idKhachHang = ?";
        List<danhGia> dsDanhGia = new ArrayList<>();

        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, idKhachHang);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                danhGia dg = new danhGia();
                dg.setId(rs.getString("id"));
                dg.setIdKhachHang(rs.getString("idKhachHang"));
                dg.setIdDatSan(rs.getString("idDatSan"));
                dg.setNoiDung(rs.getString("noiDung"));
                dg.setMucDiem(mucDiem.valueOf(rs.getString("mucDiem")));
                dsDanhGia.add(dg);
            }
            return dsDanhGia;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static List<danhGia> timDanhGiaTheoSanBong(String idSanBong){
        String sql = "SELECT * FROM danhGia WHERE idSanBong = ?";
        List<danhGia> dsDanhGia = new ArrayList<>();

        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, idSanBong);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                danhGia dg = new danhGia();
                dg.setId(rs.getString("id"));
                dg.setIdKhachHang(rs.getString("idKhachHang"));
                dg.setIdSanBong(rs.getString("idSanBong"));
                dg.setNoiDung(rs.getString("noiDung"));
                dg.setMucDiem(mucDiem.valueOf(rs.getString("mucDiem")));
                dsDanhGia.add(dg);
            }
            return dsDanhGia;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public danhGia timDanhGiaTheoDatSan(String idDatSan) {
        String sql = "SELECT * FROM danhGia WHERE idDatSan = ?";
        try (Connection conn = ketnoiCSDL.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, idDatSan);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                danhGia dg = new danhGia();
                dg.setId(rs.getString("id"));
                dg.setIdKhachHang(rs.getString("idKhachHang"));
                dg.setIdDatSan(rs.getString("idDatSan"));
                dg.setIdSanBong(rs.getString("idSanBong"));
                dg.setNoiDung(rs.getString("noiDung"));
                dg.setMucDiem(mucDiem.valueOf(rs.getString("mucDiem")));
                return dg;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        return null;
    }
}
