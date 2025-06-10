package model;

public enum trangThaiDatSan {
    CHO_THANH_TOAN,
    DA_THANH_TOAN,
    DA_HUY;;

    public String toVietnamese() {
        switch (this) {
            case CHO_THANH_TOAN: return "CHỜ THANH TOÁN";
            case DA_THANH_TOAN: return "ĐÃ THANH TOÁN";
            case DA_HUY: return "ĐÃ HỦY";
            default: return "Không xác định";
        }
    }
}
