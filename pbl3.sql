CREATE DATABASE IF NOT EXISTS quan_ly_san_bong;
use quan_ly_san_bong;
-- Tạo bảng 
CREATE TABLE nguoiDung (
    id CHAR(36) PRIMARY KEY,
    ten VARCHAR(100),
    email VARCHAR(100),
    matKhau VARCHAR(255),
    anhDaiDien VARCHAR(255),
    ngaySinh DATETIME,
    vaiTroNguoiDung ENUM('KHACH_HANG', 'NHAN_VIEN', 'QUAN_LY') NOT NULL,    
    ngayTao timestamp,
    ngayCapNhat timestamp
    
);

CREATE TABLE sanBong (
    id CHAR(36) PRIMARY KEY,
    tenSan VARCHAR(100),
    trangThai ENUM('HOAT_DONG', 'BAO_TRI') NOT NULL, 
    moTa text,
    kieuSan ENUM('SAN_5', 'SAN_7') NOT NULL,  
    ngayTao timestamp,
    ngayCapNhat timestamp
);

CREATE TABLE bangGia (
    id CHAR(36) PRIMARY KEY,
    gioBatDau time,
    gioKetThuc time,
    giaTien1Gio int,
    kieuSan ENUM('SAN_5', 'SAN_7') NOT NULL,  
    ngayTao timestamp,
    ngayCapNhat timestamp
);

CREATE TABLE danhGia (
    id CHAR(36) PRIMARY KEY,
   idKhachHang CHAR(36),
   idSanBong CHAR(36),
   idDatSan CHAR(36),
    noiDung text,
    mucDiem ENUM('RAT_TICH_CUC', 'TICH_CUC','TRUNG_BINH','TIEU_CUC','RAT_TIEU_CUC') NOT NULL,  
    ngayTao timestamp,
    ngayCapNhat timestamp
);


CREATE TABLE datSan (
    id CHAR(36) PRIMARY KEY,
   idKhachHang CHAR(36),
   idSanBong CHAR(36),
   soTien int,
    
    trangThai ENUM('CHO_THANH_TOAN', 'DA_THANH_TOAN','TDA_HUY') NOT NULL,  
    gioBatDau datetime,
   gioKetThuc datetime,
    ngayTao timestamp,
    ngayCapNhat timestamp
);


--  Thiết lập các khoá ngoại
-- bảng datSan 
ALTER TABLE datSan
ADD CONSTRAINT fk_datSan_khachHang
FOREIGN KEY (idKhachHang) REFERENCES nguoiDung(id);

ALTER TABLE datSan
ADD CONSTRAINT fk_datSan_sanBong
FOREIGN KEY (idSanBong) REFERENCES sanBong(id);

-- bảng danhGia
ALTER TABLE danhGia
ADD CONSTRAINT fk_danhGia_khachHang
FOREIGN KEY (idKhachHang) REFERENCES nguoiDung(id);

ALTER TABLE danhGia
ADD CONSTRAINT fk_danhGia_sanBong
FOREIGN KEY (idSanBong) REFERENCES sanBong(id);

ALTER TABLE danhGia
ADD CONSTRAINT fk_danhGia_datSan
FOREIGN KEY (idDatSan) REFERENCES datSan(id);

-- thêm dữ liệu mẫu 
INSERT INTO nguoiDung (id, ten, email, matKhau, anhDaiDien, ngaySinh, vaiTroNguoiDung, ngayTao, ngayCapNhat) VALUES
('f1111111-aaaa-bbbb-cccc-111111111111', 'Nguyen Van A', 'a@gmail.com', 'matkhau1', 'a.jpg', '2000-01-01', 'KHACH_HANG', NOW(), NOW()),
('f2222222-bbbb-cccc-dddd-222222222222', 'Tran Thi B', 'b@gmail.com', 'matkhau2', 'b.jpg', '1999-05-15', 'NHAN_VIEN', NOW(), NOW()),
('f3333333-cccc-dddd-eeee-333333333333', 'Le Van C', 'c@gmail.com', 'matkhau3', 'c.jpg', '1988-09-20', 'QUAN_LY', NOW(), NOW());

INSERT INTO sanBong (id, tenSan, trangThai, moTa, kieuSan, ngayTao, ngayCapNhat) VALUES
('s1111111-aaaa-bbbb-cccc-111111111111', 'Sân 5A', 'HOAT_DONG', 'Sân 5 người có mái che', 'SAN_5', NOW(), NOW()),
('s2222222-bbbb-cccc-dddd-222222222222', 'Sân 5B', 'BAO_TRI', 'Sân đang bảo trì', 'SAN_5', NOW(), NOW()),
('s3333333-cccc-dddd-eeee-333333333333', 'Sân 7A', 'HOAT_DONG', 'Sân 7 người có đèn chiếu sáng', 'SAN_7', NOW(), NOW());

INSERT INTO bangGia (id, gioBatDau, gioKetThuc, giaTien1Gio, kieuSan, ngayTao, ngayCapNhat) VALUES
('g1111111-aaaa-bbbb-cccc-111111111111', '06:00:00', '10:00:00', 100000, 'SAN_5', NOW(), NOW()),
('g2222222-bbbb-cccc-dddd-222222222222', '15:00:00', '21:00:00', 150000, 'SAN_5', NOW(), NOW()),
('g3333333-cccc-dddd-eeee-333333333333', '06:00:00', '10:00:00', 150000, 'SAN_7', NOW(), NOW()),
('g4444444-dddd-eeee-ffff-444444444444', '15:00:00', '21:00:00', 200000, 'SAN_5', NOW(), NOW());

INSERT INTO datSan (id, idKhachHang, idSanBong, soTien, trangThai, gioBatDau, gioKetThuc, ngayTao, ngayCapNhat) VALUES
('d1111111-aaaa-bbbb-cccc-111111111111', 'f1111111-aaaa-bbbb-cccc-111111111111', 's1111111-aaaa-bbbb-cccc-111111111111', 200000, 'DA_THANH_TOAN', '2025-06-09 06:00:00', '2025-06-09 08:00:00', NOW(), NOW()),
('d2222222-bbbb-cccc-dddd-222222222222', 'f1111111-aaaa-bbbb-cccc-111111111111', 's3333333-cccc-dddd-eeee-333333333333', 300000, 'CHO_THANH_TOAN', '2025-06-09 15:00:00', '2025-06-09 17:00:00', NOW(), NOW()),
('d3333333-cccc-dddd-eeee-333333333333', 'f1111111-aaaa-bbbb-cccc-111111111111', 's2222222-bbbb-cccc-dddd-222222222222', 150000, 'TDA_HUY', '2025-06-10 07:00:00', '2025-06-10 08:00:00', NOW(), NOW());

INSERT INTO danhGia (id, idKhachHang, idSanBong, idDatSan, noiDung, mucDiem, ngayTao, ngayCapNhat) VALUES
('r1111111-aaaa-bbbb-cccc-111111111111', 'f1111111-aaaa-bbbb-cccc-111111111111', 's1111111-aaaa-bbbb-cccc-111111111111', 'd1111111-aaaa-bbbb-cccc-111111111111', 'Sân tốt, phục vụ nhanh.', 'RAT_TICH_CUC', NOW(), NOW()),
('r2222222-bbbb-cccc-dddd-222222222222', 'f1111111-aaaa-bbbb-cccc-111111111111', 's3333333-cccc-dddd-eeee-333333333333', 'd2222222-bbbb-cccc-dddd-222222222222', 'Sân ổn nhưng hơi trơn.', 'TRUNG_BINH', NOW(), NOW()),
('r3333333-cccc-dddd-eeee-333333333333', 'f1111111-aaaa-bbbb-cccc-111111111111', 's2222222-bbbb-cccc-dddd-222222222222', 'd3333333-cccc-dddd-eeee-333333333333', 'Hủy đặt sân nhưng không được hỗ trợ.', 'RAT_TIEU_CUC', NOW(), NOW());





