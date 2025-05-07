package model;

import java.sql.Timestamp;

public class congViec {
    private int id;
    private int idNguoiDung;
    private loaiCongViec tenCongViec;
    private Timestamp thoiGianBatDau;
    private Timestamp thoiGianKetThuc;
    private boolean daHoanThanh;

    private Timestamp ngayTao;
    private Timestamp ngayCapNhat;

    // Constructors
    public congViec() {}
    public congViec(int idNguoiDung, loaiCongViec tenCongViec, Timestamp thoiGianBatDau, Timestamp thoiGianKetThuc, boolean daHoanThanh) {
        this.idNguoiDung = idNguoiDung;
        this.tenCongViec = tenCongViec;
        this.thoiGianBatDau = thoiGianBatDau;
        this.thoiGianKetThuc = thoiGianKetThuc;
        this.daHoanThanh = daHoanThanh;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getIdNguoiDung() { return idNguoiDung; }
    public void setIdNguoiDung(int idNguoiDung) { this.idNguoiDung = idNguoiDung; }

    public loaiCongViec getTenCongViec() { return tenCongViec; }
    public void setTenCongViec(loaiCongViec tenCongViec) { this.tenCongViec = tenCongViec; }

    public Timestamp getThoiGianBatDau() { return thoiGianBatDau; }
    public void setThoiGianBatDau(Timestamp thoiGianBatDau) { this.thoiGianBatDau = thoiGianBatDau; }

    public Timestamp getThoiGianKetThuc() { return thoiGianKetThuc; }
    public void setThoiGianKetThuc(Timestamp thoiGianKetThuc) { this.thoiGianKetThuc = thoiGianKetThuc; }

    public boolean isDaHoanThanh() { return daHoanThanh; }
    public void setDaHoanThanh(boolean daHoanThanh) { this.daHoanThanh = daHoanThanh; }

    public Timestamp getNgayTao() { return ngayTao; }
    public void setNgayTao(Timestamp ngayTao) { this.ngayTao = ngayTao; }

    public Timestamp getNgayCapNhat() { return ngayCapNhat; }
    public void setNgayCapNhat(Timestamp ngayCapNhat) { this.ngayCapNhat = ngayCapNhat; }



}
