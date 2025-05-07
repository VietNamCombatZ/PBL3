package model;

public enum mucDiem {
    RAT_TIEU_CUC(1),
    TIEU_CUC(2),
    TRUNG_BINH(3),
    TICH_CUC(4),
    RAT_TICH_CUC(5);

    private final int value;

    mucDiem(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }
}
