package model;
import java.sql.Timestamp;

public class nguoiDung
{
    private int id;
    private String ten;
    private String email;
    private String matKhau;
    private String anhDaiDien;
    private boolean kichHoat;
    private Timestamp ngayTao;
    private Timestamp ngayCapNhat;



    // Constructors
    public nguoiDung
    () {}

    public nguoiDung
            (String ten, String email, String matKhau, String anhDaiDien, boolean kichHoat) {
        this.ten = ten;
        this.email = email;
        this.matKhau = matKhau;
        this.anhDaiDien = anhDaiDien;
        this.kichHoat = kichHoat;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTen() { return ten; }
    public void setTen(String ten) { this.ten = ten; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getMatKhau() { return matKhau; }
    public void setMatKhau(String matKhau) { this.matKhau = matKhau; }

    public String getAnhDaiDien() { return anhDaiDien; }
    public void setAnhDaiDien(String anhDaiDien) { this.anhDaiDien = anhDaiDien; }

    public boolean isKichHoat() { return kichHoat; }
    public void setKichHoat(boolean kichHoat) { this.kichHoat = kichHoat; }

    public Timestamp getNgayTao() { return ngayTao; }
    public void setNgayTao(Timestamp ngayTao) { this.ngayTao = ngayTao; }

    public Timestamp getNgayCapNhat() { return ngayCapNhat; }
    public void setNgayCapNhat(Timestamp ngayCapNhat) { this.ngayCapNhat = ngayCapNhat; }

}
