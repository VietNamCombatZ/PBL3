package model;
import java.sql.Timestamp;
import java.util.List;
import java.util.Date;

public class nguoiDung
{
    private String id;
    private String ten;
    private String email;
    private String matKhau;
    private String anhDaiDien;
    private Date ngaySinh;

    private vaiTro vaiTroNguoiDung;
    private Timestamp ngayTao;
    private Timestamp ngayCapNhat;

    private List<danhGia> danhSachDanhGia;

    // Constructors
    public nguoiDung
    () {}

    public nguoiDung
            (String ten, String email, String matKhau, String anhDaiDien, Date ngaySinh, vaiTro vaiTroNguoiDung) {
        this.ten = ten;
        this.email = email;
        this.matKhau = matKhau;
        this.anhDaiDien = anhDaiDien;
        this.ngaySinh = ngaySinh;
        this.vaiTroNguoiDung = vaiTroNguoiDung;

    }

    // Getters & Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getTen() { return ten; }
    public void setTen(String ten) { this.ten = ten; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getMatKhau() { return matKhau; }
    public void setMatKhau(String matKhau) { this.matKhau = matKhau; }

    public String getAnhDaiDien() { return anhDaiDien; }
    public void setAnhDaiDien(String anhDaiDien) { this.anhDaiDien = anhDaiDien; }

    public Date getNgaySinh() { return ngaySinh; }
    public void setNgaySinh(Date ngaySinh) { this.ngaySinh = ngaySinh; }

    public vaiTro getVaiTroNguoiDung() { return vaiTroNguoiDung; }
    public void setVaiTroNguoiDung(vaiTro vaiTroNguoiDung) { this.vaiTroNguoiDung = vaiTroNguoiDung; }


    public Timestamp getNgayTao() { return ngayTao; }
    public void setNgayTao(Timestamp ngayTao) { this.ngayTao = ngayTao; }

    public Timestamp getNgayCapNhat() { return ngayCapNhat; }
    public void setNgayCapNhat(Timestamp ngayCapNhat) { this.ngayCapNhat = ngayCapNhat; }

}
