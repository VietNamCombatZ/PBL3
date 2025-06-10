package model;

public enum loaiCongViec {
    BAO_TRI_SAN,
    THU_NGAN,
    VE_SINH;

    public String toVietnamese() {
        switch (this) {
            case BAO_TRI_SAN: return "BẢO TRÌ SÂN";
            case THU_NGAN: return "THU NGÂN";
            case VE_SINH: return "VỆ SINH";
            default: return "Không xác định";
        }
    }
}
