package model;

import java.sql.Timestamp;
import java.sql.Time;

public class bangGia {
    private String id;
    private Time gioBatDau;
    private Time gioKetThuc;
    private int giaTien1Gio;


    private Timestamp ngayTao;
    private Timestamp ngayCapNhat;

    // Constructors
    public bangGia
    () {}

    public bangGia
            (Time gioBatDau, Time gioKetThuc, int giaTien1Gio) {
        this.gioBatDau = gioBatDau;
        this.gioKetThuc = gioKetThuc;
        this.giaTien1Gio = giaTien1Gio;
    }

    // Getters & Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public Time getGioBatDau() { return gioBatDau; }
    public void setGioBatDau(Time gioBatDau) { this.gioBatDau = gioBatDau; }

    public Time getGioKetThuc() { return gioKetThuc; }
    public void setGioKetThuc(Time gioKetThuc) { this.gioKetThuc = gioKetThuc; }

    public int getGiaTien1Gio() { return giaTien1Gio; }
    public void setGiaTien1Gio(int giaTien1Gio) { this.giaTien1Gio = giaTien1Gio; }


    public Timestamp getNgayTao() { return ngayTao; }
    public void setNgayTao(Timestamp ngayTao) { this.ngayTao = ngayTao; }

    public Timestamp getNgayCapNhat() { return ngayCapNhat; }
    public void setNgayCapNhat(Timestamp ngayCapNhat) { this.ngayCapNhat = ngayCapNhat; }

}
