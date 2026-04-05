create database MyCafe;

use MyCafe

CREATE TABLE LOAIDOUONG
(
  maLoai INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  tenLoai NVARCHAR(100) NOT NULL,
  hinhAnh NVARCHAR(255) NOT NULL,
  trangThai BIT NOT NULL DEFAULT 1,
  moTa NVARCHAR(500) NOT NULL
);

CREATE TABLE DOUONG
(
  MaDoUong INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  moTa NVARCHAR(500) NOT NULL,
  trangThai BIT NOT NULL DEFAULT 1,
  hinhAnh NVARCHAR(255) NOT NULL,
  donGia DECIMAL(18,2) NOT NULL,
  tenDoUong NVARCHAR(150) NOT NULL,
  maLoai INT NOT NULL,
  CONSTRAINT FK_DOUONG_LOAIDOUONG
    FOREIGN KEY (maLoai) REFERENCES LOAIDOUONG(maLoai)
);

CREATE TABLE NHANVIEN
(
  MaNV INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  email NVARCHAR(100) NOT NULL,
  hoTen NVARCHAR(100) NOT NULL,
  trangThai BIT NOT NULL DEFAULT 1,
  sdt VARCHAR(10) NOT NULL,
  vaiTro NVARCHAR(50) NOT NULL,
  matKhau NVARCHAR(255) NOT NULL
);

CREATE TABLE KHACHHANG
(
  MaKH INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  ngayDangKi DATE NOT NULL,
  diaChi NVARCHAR(255) NOT NULL,
  email NVARCHAR(100) NOT NULL,
  sdt VARCHAR(10) NOT NULL,
  hoTen NVARCHAR(100) NOT NULL
);

CREATE TABLE HOADON
(
  MaHD INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  ngayTao DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
  tongTien DECIMAL(18,2) NOT NULL DEFAULT 0,
  trangThai NVARCHAR(50) NOT NULL,
  MaNV INT NOT NULL,
  MaKH INT NOT NULL,
  CONSTRAINT FK_HOADON_NHANVIEN
    FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV),
  CONSTRAINT FK_HOADON_KHACHHANG
    FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH)
);

CREATE TABLE CHITIETHOADON
(
  MaCTHD INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  donGia DECIMAL(18,2) NOT NULL,
  soLuong INT NOT NULL CHECK (soLuong > 0),
  MaHD INT NOT NULL,
  MaDoUong INT NOT NULL,
  CONSTRAINT FK_CTHD_HOADON
    FOREIGN KEY (MaHD) REFERENCES HOADON(MaHD),
  CONSTRAINT FK_CTHD_DOUONG
    FOREIGN KEY (MaDoUong) REFERENCES DOUONG(MaDoUong)
);

INSERT INTO LOAIDOUONG (tenLoai, hinhAnh, trangThai, moTa) VALUES
(N'Cà phê', N'cafe.jpg', 1, N'Các món cà phê truy?n th?ng và hi?n d?i'),
(N'Trà', N'tra.jpg', 1, N'Trà nóng, trà trái cây và trà th?o m?c'),
(N'Trà s?a', N'tra-sua.jpg', 1, N'Các món trà s?a nhi?u huong v?'),
(N'Sinh t?', N'sinh-to.jpg', 1, N'Sinh t? trái cây tuoi'),
(N'Nu?c ép', N'nuoc-ep.jpg', 1, N'Nu?c ép trái cây nguyên ch?t'),
(N'Soda', N'soda.jpg', 1, N'Ð? u?ng soda mát l?nh');

INSERT INTO DOUONG (moTa, trangThai, hinhAnh, donGia, tenDoUong, maLoai) VALUES
(N'Cà phê Robusta pha phin, d?m v?, ph?c v? dá', 1, N'ca-phe-den-da\.jpg', 25000.00, N'Cà phê den dá', 1),
(N'Cà phê s?a dá truy?n th?ng Vi?t Nam', 1, N'ca-phe-sua-da\.jpg', 29000.00, N'Cà phê s?a dá', 1),
(N'S?a nhi?u hon cà phê, v? béo nh?', 1, N'bac-xiu\.jpg', 30000.00, N'B?c x?u', 1),
(N'Cà phê pha cùng kem mu?i d?c trung', 1, N'ca-phe-muoi\.jpg', 35000.00, N'Cà phê mu?i', 1),
(N'Espresso v?i s?a dánh b?t m?n', 1, N'cappuccino\.jpg', 45000.00, N'Cappuccino', 1),
(N'Cà phê s?a phong cách Ý', 1, N'latte\.jpg', 45000.00, N'Latte', 1),
(N'M?t shot cà phê cô d?c', 1, N'espresso\.jpg', 38000.00, N'Espresso', 1),
(N'Espresso pha loãng v?i nu?c nóng', 1, N'americano\.jpg', 40000.00, N'Americano', 1),
(N'Cà phê k?t h?p socola và s?a', 1, N'mocha\.jpg', 48000.00, N'Mocha', 1),
(N'Cà phê ? l?nh, v? d?u', 1, N'cold-brew\.jpg', 45000.00, N'Cold Brew', 1),
(N'Cà phê xay v?i c?t d?a béo ng?y', 1, N'ca-phe-cot-dua\.jpg', 45000.00, N'Cà phê c?t d?a', 1),
(N'Cà phê ph? l?p kem tr?ng', 1, N'ca-phe-trung\.jpg', 45000.00, N'Cà phê tr?ng', 1),

(N'Trà trái cây thom mùi s?', 1, N'tra-dao-cam-sa\.jpg', 38000.00, N'Trà dào cam s?', 2),
(N'Trà trái cây v? v?i thanh nh?', 1, N'tra-vai\.jpg', 35000.00, N'Trà v?i', 2),
(N'Trà chanh tuoi mát', 1, N'tra-chanh\.jpg', 25000.00, N'Trà chanh', 2),
(N'Trà t?c pha m?t ong', 1, N'tra-tac-mat-ong\.jpg', 28000.00, N'Trà t?c m?t ong', 2),
(N'Trà thom v? sen và kem s?a', 1, N'tra-sen-vang\.jpg', 42000.00, N'Trà sen vàng', 2),
(N'Trà nhài thanh huong', 1, N'tra-nhai\.jpg', 30000.00, N'Trà nhài', 2),
(N'Trà g?ng ?m b?ng', 1, N'tra-gung-mat-ong\.jpg', 32000.00, N'Trà g?ng m?t ong', 2),
(N'Ô long k?t h?p dua lu?i', 1, N'tra-o-long-dua-luoi\.jpg', 39000.00, N'Trà ô long dua lu?i', 2),

(N'Trà s?a truy?n th?ng v?i trân châu den', 1, N'tra-sua-tran-chau\.jpg', 35000.00, N'Trà s?a trân châu', 3),
(N'Trà s?a v? matcha Nh?t', 1, N'tra-sua-matcha\.jpg', 42000.00, N'Trà s?a matcha', 3),
(N'Trà s?a v? socola', 1, N'tra-sua-socola\.jpg', 42000.00, N'Trà s?a socola', 3),
(N'Trà s?a v? caramel ng?t d?u', 1, N'tra-sua-caramel\.jpg', 42000.00, N'Trà s?a caramel', 3),
(N'Trà s?a khoai môn thom bùi', 1, N'tra-sua-khoai-mon\.jpg', 40000.00, N'Trà s?a khoai môn', 3),
(N'Trà s?a n?n ô long', 1, N'tra-sua-o-long\.jpg', 39000.00, N'Trà s?a ô long', 3),
(N'Trà s?a ki?u Thái', 1, N'tra-sua-thai-xanh\.jpg', 40000.00, N'Trà s?a thái xanh', 3),
(N'Trà s?a v? c? di?n', 1, N'tra-sua-truyen-thong\.jpg', 34000.00, N'Trà s?a truy?n th?ng', 3),

(N'Sinh t? bo sánh m?n', 1, N'sinh-to-bo\.jpg', 45000.00, N'Sinh t? bo', 4),
(N'Sinh t? xoài chín ng?t', 1, N'sinh-to-xoai\.jpg', 42000.00, N'Sinh t? xoài', 4),
(N'Sinh t? dâu tuoi', 1, N'sinh-to-dau\.jpg', 45000.00, N'Sinh t? dâu', 4),
(N'Sinh t? chu?i giàu nang lu?ng', 1, N'sinh-to-chuoi\.jpg', 38000.00, N'Sinh t? chu?i', 4),
(N'Sinh t? mãng c?u v? d?c trung', 1, N'sinh-to-mang-cau\.jpg', 48000.00, N'Sinh t? mãng c?u', 4),
(N'Sinh t? d?a béo nh?', 1, N'sinh-to-dua\.jpg', 42000.00, N'Sinh t? d?a', 4),
(N'Sinh t? vi?t qu?t chua ng?t', 1, N'sinh-to-viet-quat\.jpg', 49000.00, N'Sinh t? vi?t qu?t', 4),
(N'Sinh t? mít thom d?m', 1, N'sinh-to-mit\.jpg', 43000.00, N'Sinh t? mít', 4),

(N'Nu?c ép cam tuoi', 1, N'nuoc-ep-cam\.jpg', 39000.00, N'Nu?c ép cam', 5),
(N'Nu?c ép ?i giàu vitamin C', 1, N'nuoc-ep-oi\.jpg', 39000.00, N'Nu?c ép ?i', 5),
(N'Nu?c ép d?a chua ng?t', 1, N'nuoc-ep-dua\.jpg', 38000.00, N'Nu?c ép d?a', 5),
(N'Nu?c ép táo thanh mát', 1, N'nuoc-ep-tao\.jpg', 42000.00, N'Nu?c ép táo', 5),
(N'Nu?c ép cà r?t tuoi', 1, N'nuoc-ep-ca-rot\.jpg', 38000.00, N'Nu?c ép cà r?t', 5),
(N'Nu?c ép chanh leo d?m v?', 1, N'nuoc-ep-chanh-leo\.jpg', 40000.00, N'Nu?c ép chanh leo', 5),
(N'Nu?c ép l?u nguyên ch?t', 1, N'nuoc-ep-luu\.jpg', 49000.00, N'Nu?c ép l?u', 5),
(N'Nu?c ép dua h?u mát l?nh', 1, N'nuoc-ep-dua-hau\.jpg', 36000.00, N'Nu?c ép dua h?u', 5),

(N'Soda chanh tuoi gi?i khát', 1, N'soda-chanh\.jpg', 30000.00, N'Soda chanh', 6),
(N'Soda v? vi?t qu?t', 1, N'soda-viet-quat\.jpg', 35000.00, N'Soda vi?t qu?t', 6),
(N'Soda dâu tuoi', 1, N'soda-dau.jpg', 35000.00, N'Soda dâu', 6),
(N'Soda chanh dây chua ng?t', 1, N'soda-chanh-day.jpg', 36000.00, N'Soda chanh dây', 6),
(N'Soda dào thom nh?', 1, N'soda-dao.jpg', 35000.00, N'Soda dào', 6),
(N'Soda kiwi tuoi mát', 1, N'soda-kiwi.jpg', 36000.00, N'Soda kiwi', 6),
(N'Soda b?c hà the mát', 1, N'soda-bac-ha.jpg', 30000.00, N'Soda b?c hà', 6),
(N'Soda mix nhi?u lo?i trái cây', 1, N'soda-trai-cay.jpg', 38000.00, N'Soda trái cây t?ng h?p', 6);

INSERT INTO NHANVIEN (email, hoTen, trangThai, sdt, vaiTro, matKhau) VALUES
(N'admin@polycoffee.vn', N'Nguyen Van Admin', 1, '0900000001', N'admin', N'123456'),
(N'employee@polycoffee.vn', N'Tran Thi Employee', 1, '0900000002', N'employee', N'123456'),
(N'guest@polycoffee.vn', N'Le Van Guest', 1, '0900000003', N'guest', N'123456');

INSERT INTO KHACHHANG (ngayDangKi, diaChi, email, sdt, hoTen) VALUES
('2026-03-20', N'Qu?n 1, TP.HCM', N'kh1@gmail.com', '0911111111', N'Nguyen A'),
('2026-03-20', N'Qu?n 3, TP.HCM', N'kh2@gmail.com', '0922222222', N'Tran B'),
('2026-03-20', N'Th? Ð?c, TP.HCM', N'kh3@gmail.com', '0933333333', N'Le C');

INSERT INTO HOADON (ngayTao, tongTien, trangThai, MaNV, MaKH) VALUES
(SYSDATETIME(), 54000.00, N'Paid', 1, 1),
(SYSDATETIME(), 76000.00, N'Paid', 2, 2);

INSERT INTO CHITIETHOADON (donGia, soLuong, MaHD, MaDoUong) VALUES
(29000.00, 1, 2, 2),
(25000.00, 1, 2, 1),
(38000.00, 2, 2, 15);

SELECT * FROM HOADON;
SELECT * FROM CHITIETHOADON;