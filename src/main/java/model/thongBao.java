package model;

import java.sql.Timestamp;

public class thongBao {
    private String id;
    private String noiDung;
    private String idKhachHang;
    private boolean daXem;

    private Timestamp ngayTao;
    private Timestamp ngayCapNhat;

    // Constructors
    public thongBao() {}
    public thongBao(String noiDung, String idKhachHang, boolean daXem) {
        this.noiDung = noiDung;
        this.idKhachHang = idKhachHang;
        this.daXem = daXem;
    }

    // Getters & Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getNoiDung() { return noiDung; }
    public void setNoiDung(String noiDung) { this.noiDung = noiDung; }

    public String getIdKhachHang() { return idKhachHang; }
    public void setIdKhachHang(String idKhachHang) { this.idKhachHang = idKhachHang; }

    public boolean isDaXem() { return daXem; }
    public void setDaXem(boolean daXem) { this.daXem = daXem; }

    public Timestamp getNgayTao() { return ngayTao; }
    public void setNgayTao(Timestamp ngayTao) { this.ngayTao = ngayTao; }


    public Timestamp getNgayCapNhat() { return ngayCapNhat; }
    public void setNgayCapNhat(Timestamp ngayCapNhat) { this.ngayCapNhat = ngayCapNhat; }
}
