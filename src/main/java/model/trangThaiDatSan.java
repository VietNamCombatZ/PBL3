package model;

public enum trangThaiDatSan {
    CHO_THANH_TOAN(1),
    DA_THANH_TOAN(2),
    DA_HUY(3);

    private final int value;

    trangThaiDatSan(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }
}
