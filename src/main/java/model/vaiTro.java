package model;

public enum vaiTro {
    QUAN_LY,
    NHAN_VIEN,
    KHACH_HANG;

    public String toVietnamese() {
        switch (this) {
            case QUAN_LY: return "QUẢN LÝ";
            case NHAN_VIEN: return "NHÂN VIÊN";
            case KHACH_HANG: return "KHÁCH HÀNG";
            default: return "Không xác định";
        }
    }
}
