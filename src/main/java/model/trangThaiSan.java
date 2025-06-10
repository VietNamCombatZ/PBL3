package model;

public enum trangThaiSan {
    HOAT_DONG,
    BAO_TRI;


    String toVietnamese() {
        switch (this) {
            case HOAT_DONG: return "HOẠT ĐỘNG";
            case BAO_TRI: return "BẢO TRÌ";
            default: return "Không xác định";
        }
    }
}
