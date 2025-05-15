package model;

import java.sql.Timestamp;

public class danhGia {
    private String id;
    private String idKhachHang;
    private String idSanBong;

    private String noiDung;
    private mucDiem mucDiem;

    private Timestamp ngayTao;
    private Timestamp ngayCapNhat;

    // Constructors
    public danhGia() {}

    public danhGia(String idKhachHang, String idSanBong , String noiDung, mucDiem mucDiem) {
        this.idKhachHang = idKhachHang;
        this.idSanBong = idSanBong;
        this.noiDung = noiDung;
        this.mucDiem = mucDiem;
    }

    // Getters & Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getIdKhachHang() { return idKhachHang; }
    public void setIdKhachHang(String idKhachHang) { this.idKhachHang = idKhachHang; }

    public String getIdSanBong() { return idSanBong; }
    public void setIdSanBong(String idSanBong) { this.idSanBong = idSanBong; }


    public String getNoiDung() { return noiDung; }
    public void setNoiDung(String noiDung) { this.noiDung = noiDung; }

    public mucDiem getMucDiem() { return mucDiem; }
    public void setMucDiem(mucDiem mucDiem) { this.mucDiem = mucDiem; }


    public Timestamp getNgayTao() { return ngayTao; }
    public void setNgayTao(Timestamp ngayTao) { this.ngayTao = ngayTao; }

    public Timestamp getNgayCapNhat() { return ngayCapNhat; }
    public void setNgayCapNhat(Timestamp ngayCapNhat) { this.ngayCapNhat = ngayCapNhat; }


}
