package model;

import java.sql.Timestamp;

public class sanBong {
    private String id;
    private String tenSan;
    private trangThaiSan trangThai;
    private loaiSan kieuSan;


    private Timestamp ngayTao;
    private Timestamp ngayCapNhat;

    // Constructors
    public sanBong
    () {}

    public sanBong(String id, String tenSan, trangThaiSan trangThai, loaiSan kieuSan) {
        this.id = id;
        this.tenSan = tenSan;
        this.trangThai = trangThai;
        this.kieuSan = kieuSan;
    }

    // Getters & Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getTenSan() { return tenSan; }
    public void setTenSan(String tenSan) { this.tenSan = tenSan; }

    public trangThaiSan getTrangThai() { return trangThai; }
    public void setTrangThai(trangThaiSan trangThai) { this.trangThai = trangThai; }

    public loaiSan getKieuSan() { return kieuSan; }
    public void setKieuSan(loaiSan kieuSan) { this.kieuSan = kieuSan; }




    public Timestamp getNgayTao() { return ngayTao; }
    public void setNgayTao(Timestamp ngayTao) { this.ngayTao = ngayTao; }

    public Timestamp getNgayCapNhat() { return ngayCapNhat; }
    public void setNgayCapNhat(Timestamp ngayCapNhat) { this.ngayCapNhat = ngayCapNhat; }

}
