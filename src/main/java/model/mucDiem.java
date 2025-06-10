package model;

public enum mucDiem {
    RAT_TICH_CUC,
    TICH_CUC,
    TRUNG_BINH,
    TIEU_CUC,
    RAT_TIEU_CUC;

    public String toVietnamese() {
        switch (this) {
            case RAT_TICH_CUC: return "RẤT TÍCH CỰC";
            case TICH_CUC: return "TÍCH CỰC";
            case TRUNG_BINH: return "TRUNG BÌNH";
            case TIEU_CUC: return "TIÊU CỰC";
            case RAT_TIEU_CUC: return "RẤT TIÊU CỰC";
            default: return "Không xác định";
        }
    }


}
