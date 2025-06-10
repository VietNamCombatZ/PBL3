package model;

public enum loaiSan {
    SAN_5,
    SAN_7;

    public String toVietnamese() {
        switch (this) {
            case SAN_5: return "SÂN 5";
            case SAN_7: return "SÂN 7";
            default: return "Không xác định";
        }
    }
}
