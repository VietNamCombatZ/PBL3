package model;

import java.sql.Time;
import java.sql.Timestamp;
import java.sql.*;


public class datSan {
    private String id;
    private String idKhachHang;
    private String idSanBong;

    private int soTien;
    private trangThaiDatSan trangThai;

    private Date gioBatDau;
    private Date gioKetThuc;

    private Timestamp ngayTao;
    private Timestamp ngayCapNhat;


    public datSan(){};
    public datSan(String idKhachHang, String idSanBong, int soTien, trangThaiDatSan trangThai, Date gioBatDau, Date gioKetThuc) {
        this.idKhachHang = idKhachHang;
        this.idSanBong = idSanBong;
        this.soTien = soTien;
        this.trangThai = trangThai;
        this.gioBatDau = gioBatDau;
        this.gioKetThuc = gioKetThuc;
    }
    // Getters & Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getIdKhachHang() { return idKhachHang; }
    public void setIdKhachHang(String idKhachHang) { this.idKhachHang = idKhachHang; }

    public String getIdSanBong() { return idSanBong; }
    public void setIdSanBong(String idSanBong) { this.idSanBong = idSanBong; }

    public int getSoTien() { return soTien; }
    public void setSoTien(int soTien) { this.soTien = soTien; }

    public trangThaiDatSan getTrangThai() { return trangThai; }
    public void setTrangThai(trangThaiDatSan trangThai) { this.trangThai = trangThai; }

    public Date getGioBatDau() { return gioBatDau; }
    public void setGioBatDau(Date gioBatDau) { this.gioBatDau = gioBatDau; }

    public Date getGioKetThuc() { return gioKetThuc; }
    public void setGioKetThuc(Date gioKetThuc) { this.gioKetThuc = gioKetThuc; }

    public Timestamp getNgayTao() { return ngayTao; }
    public void setNgayTao(Timestamp ngayTao) { this.ngayTao = ngayTao; }

    public Timestamp getNgayCapNhat() { return ngayCapNhat; }
    public void setNgayCapNhat(Timestamp ngayCapNhat) { this.ngayCapNhat = ngayCapNhat; }
}
