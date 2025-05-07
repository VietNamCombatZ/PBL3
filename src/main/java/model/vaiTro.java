package model;

public enum vaiTro {

    QUAN_LY(1),
    NHAN_VIEN(2),
    KHACH_HANG(3);

    private final int value;

    vaiTro(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }
}
