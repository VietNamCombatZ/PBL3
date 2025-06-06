package model;

public class ThongKeDTO {
    private String nhan; // ngày / tuần / tháng / loại sân / giờ
    private long tongDoanhThu;
    private int soLuotDat; // chỉ dùng cho thống kê theo giờ

    public ThongKeDTO(String nhan, long tongDoanhThu) {
        this.nhan = nhan;
        this.tongDoanhThu = tongDoanhThu;
    }

    public ThongKeDTO(String nhan, long tongDoanhThu, int soLuotDat) {
        this.nhan = nhan;
        this.tongDoanhThu = tongDoanhThu;
        this.soLuotDat = soLuotDat;

    }

    public String getNhan() { return nhan; }
    public long getTongDoanhThu() { return tongDoanhThu; }
    public int getSoLuotDat() { return soLuotDat; }
}
