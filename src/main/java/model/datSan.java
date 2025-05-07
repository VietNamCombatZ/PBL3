package model;

import java.sql.Time;
import java.sql.Timestamp;
import java.sql.*;


public class datSan {
    private int id;
    private int idKhachHang;
    private int idSanBong;

    private int soTien;
    private trangThaiDatSan trangThai;

    private Time gioBatDau;
    private Time gioKetThuc;

    private Timestamp ngayTao;
    private Timestamp ngayCapNhat;


    public datSan(){};
    public datSan(int idKhachHang, int idSanBong, int soTien, trangThaiDatSan trangThai, Time gioBatDau, Time gioKetThuc) {
        this.idKhachHang = idKhachHang;
        this.idSanBong = idSanBong;
        this.soTien = soTien;
        this.trangThai = trangThai;
        this.gioBatDau = gioBatDau;
        this.gioKetThuc = gioKetThuc;
    }
    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getIdKhachHang() { return idKhachHang; }
    public void setIdKhachHang(int idKhachHang) { this.idKhachHang = idKhachHang; }

    public int getIdSanBong() { return idSanBong; }
    public void setIdSanBong(int idSanBong) { this.idSanBong = idSanBong; }

    public int getSoTien() { return soTien; }
    public void setSoTien(int soTien) { this.soTien = soTien; }

    public trangThaiDatSan getTrangThai() { return trangThai; }
    public void setTrangThai(trangThaiDatSan trangThai) { this.trangThai = trangThai; }

    public Time getGioBatDau() { return gioBatDau; }
    public void setGioBatDau(Time gioBatDau) { this.gioBatDau = gioBatDau; }

    public Time getGioKetThuc() { return gioKetThuc; }
    public void setGioKetThuc(Time gioKetThuc) { this.gioKetThuc = gioKetThuc; }

    public Timestamp getNgayTao() { return ngayTao; }
    public void setNgayTao(Timestamp ngayTao) { this.ngayTao = ngayTao; }

    public Timestamp getNgayCapNhat() { return ngayCapNhat; }
    public void setNgayCapNhat(Timestamp ngayCapNhat) { this.ngayCapNhat = ngayCapNhat; }
}
