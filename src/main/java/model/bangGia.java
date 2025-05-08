package model;

import java.sql.Timestamp;
import java.sql.Time;

public class bangGia {
    private String id;
    private Time gioBatDau;
    private Time gioKetThuc;
    private int giaTien;


    private Timestamp ngayTao;
    private Timestamp ngayCapNhat;

    // Constructors
    public bangGia
    () {}

    public bangGia
            (Time gioBatDau, Time gioKetThuc, int giaTien) {
        this.gioBatDau = gioBatDau;
        this.gioKetThuc = gioKetThuc;
        this.giaTien = giaTien;
    }

    // Getters & Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public Time getTen() { return gioBatDau; }
    public void setTen(Time gioBatDau) { this.gioBatDau = gioBatDau; }

    public Time getEmail() { return gioKetThuc; }
    public void setEmail(Time gioKetThuc) { this.gioKetThuc = gioKetThuc; }

    public int getGiaTien() { return giaTien; }
    public void setGiaTien(int giaTien) { this.giaTien = giaTien; }


    public Timestamp getNgayTao() { return ngayTao; }
    public void setNgayTao(Timestamp ngayTao) { this.ngayTao = ngayTao; }

    public Timestamp getNgayCapNhat() { return ngayCapNhat; }
    public void setNgayCapNhat(Timestamp ngayCapNhat) { this.ngayCapNhat = ngayCapNhat; }

}
