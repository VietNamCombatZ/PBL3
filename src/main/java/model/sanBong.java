package model;

import java.sql.Timestamp;

public class sanBong {
    private String id;
    private String tenSan;
    private trangThaiSan trangThai;
    private String moTa;

    private Timestamp ngayTao;
    private Timestamp ngayCapNhat;

    // Constructors
    public sanBong
    () {}

    public sanBong
            (String tenSan, trangThaiSan trangThai, String moTa) {
        this.tenSan = tenSan;
        this.trangThai = trangThai;
        this.moTa = moTa;
    }

    // Getters & Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getTen() { return tenSan; }
    public void setTen(String tenSan) { this.tenSan = tenSan; }

    public trangThaiSan getEmail() { return trangThai; }
    public void setEmail(trangThaiSan trangThai) { this.trangThai = trangThai; }

    public String getMatKhau() { return moTa; }
    public void setMatKhau(String moTa) { this.moTa = moTa; }


    public Timestamp getNgayTao() { return ngayTao; }
    public void setNgayTao(Timestamp ngayTao) { this.ngayTao = ngayTao; }

    public Timestamp getNgayCapNhat() { return ngayCapNhat; }
    public void setNgayCapNhat(Timestamp ngayCapNhat) { this.ngayCapNhat = ngayCapNhat; }

}
