IF DB_ID(N'MyCafe') IS NOT NULL
BEGIN
  ALTER DATABASE MyCafe SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE MyCafe;
END;
GO

create database MyCafe;
GO

use MyCafe
GO

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

INSERT INTO LOAIDOUONG
  (tenLoai, hinhAnh, trangThai, moTa)
VALUES
  (N'Cà phê', N'cafe.jpg', 1, N'Các món cà phê truyền thống và hiện đại'),
  (N'Trà', N'tra.jpg', 1, N'Trà nóng, trà trái cây và trà thảo mộc'),
  (N'Trà sữa', N'tra-sua.jpg', 1, N'Các món trà sữa nhiều hương vị'),
  (N'Sinh tố', N'sinh-to.jpg', 1, N'Sinh tố trái cây tươi'),
  (N'Nước ép', N'nuoc-ep.jpg', 1, N'Nước ép trái cây nguyên chất'),
  (N'Soda', N'soda.jpg', 1, N'Đồ uống soda mát lạnh');

INSERT INTO DOUONG
  (moTa, trangThai, hinhAnh, donGia, tenDoUong, maLoai)
VALUES
  (N'Cà phê Robusta pha phin, đậm vị, phục vụ đá', 1, N'ca-phe-den-da.jpg', 25000.00, N'Cà phê đen đá', 1),
  (N'Cà phê sữa đá truyền thống Việt Nam', 1, N'ca-phe-sua-da.jpg', 29000.00, N'Cà phê sữa đá', 1),
  (N'Sữa nhiều hơn cà phê, vị béo nhẹ', 1, N'bac-xiu.jpg', 30000.00, N'Bạc xỉu', 1),
  (N'Cà phê pha cùng kem muối đặc trưng', 1, N'ca-phe-muoi.jpg', 35000.00, N'Cà phê muối', 1),
  (N'Espresso với sữa đánh bọt mịn', 1, N'cappuccino.jpg', 45000.00, N'Cappuccino', 1),
  (N'Cà phê sữa phong cách Ý', 1, N'latte.jpg', 45000.00, N'Latte', 1),
  (N'Một shot cà phê cô đặc', 1, N'espresso.jpg', 38000.00, N'Espresso', 1),
  (N'Espresso pha loãng với nước nóng', 1, N'americano.jpg', 40000.00, N'Americano', 1),
  (N'Cà phê kết hợp socola và sữa', 1, N'mocha.jpg', 48000.00, N'Mocha', 1),
  (N'Cà phê ủ lạnh, vị dịu', 1, N'cold-brew.jpg', 45000.00, N'Cold Brew', 1),
  (N'Cà phê xay với cốt dừa béo ngậy', 1, N'ca-phe-cot-dua.jpg', 45000.00, N'Cà phê cốt dừa', 1),
  (N'Cà phê phủ lớp kem trứng', 1, N'ca-phe-trung.jpg', 45000.00, N'Cà phê trứng', 1),

  (N'Trà trái cây thơm mùi sả', 1, N'tra-dao-cam-sa.jpg', 38000.00, N'Trà đào cam sả', 2),
  (N'Trà trái cây vị vải thanh nhẹ', 1, N'tra-vai.jpg', 35000.00, N'Trà vải', 2),
  (N'Trà chanh tươi mát', 1, N'tra-chanh.jpg', 25000.00, N'Trà chanh', 2),
  (N'Trà tắc pha mật ong', 1, N'tra-tac-mat-ong.jpg', 28000.00, N'Trà tắc mật ong', 2),
  (N'Trà thơm vị sen và kem sữa', 1, N'tra-sen-vang.jpg', 42000.00, N'Trà sen vàng', 2),
  (N'Trà nhài thanh hương', 1, N'tra-nhai.jpg', 30000.00, N'Trà nhài', 2),
  (N'Trà gừng ấm bụng', 1, N'tra-gung-mat-ong.jpg', 32000.00, N'Trà gừng', 2),
  (N'Ô long kết hợp dưa lưới', 1, N'tra-o-long-dua-luoi.jpg', 39000.00, N'Trà ô long dưa lưới', 2),

  (N'Trà sữa truyền thống với trân châu đen', 1, N'tra-sua-tran-chau.jpg', 35000.00, N'Trà sữa trân châu', 3),
  (N'Trà sữa vị matcha Nhật', 1, N'tra-sua-matcha.jpg', 42000.00, N'Trà sữa matcha', 3),
  (N'Trà sữa vị socola', 1, N'tra-sua-socola.jpg', 42000.00, N'Trà sữa socola', 3),
  (N'Trà sữa vị caramel ngọt dịu', 1, N'tra-sua-caramel.jpg', 42000.00, N'Trà sữa caramel', 3),
  (N'Trà sữa khoai môn thơm bùi', 1, N'tra-sua-khoai-mon.jpg', 40000.00, N'Trà sữa khoai môn', 3),
  (N'Trà sữa nền ô long', 1, N'tra-sua-o-long.jpg', 39000.00, N'Trà sữa ô long', 3),
  (N'Trà sữa kiểu Thái', 1, N'tra-sua-thai-xanh.jpg', 40000.00, N'Trà sữa thái xanh', 3),
  (N'Trà sữa vị cổ điển', 1, N'tra-sua-truyen-thong.jpg', 34000.00, N'Trà sữa truyền thống', 3),

  (N'Sinh tố bơ sánh mịn', 1, N'sinh-to-bo.jpg', 45000.00, N'Sinh tố bơ', 4),
  (N'Sinh tố xoài chín ngọt', 1, N'sinh-to-xoai.jpg', 42000.00, N'Sinh tố xoài', 4),
  (N'Sinh tố dâu tươi', 1, N'sinh-to-dau.jpg', 45000.00, N'Sinh tố dâu', 4),
  (N'Sinh tố chuối giàu năng lượng', 1, N'sinh-to-chuoi.jpg', 38000.00, N'Sinh tố chuối', 4),
  (N'Sinh tố mãng cầu vị đặc trưng', 1, N'sinh-to-mang-cau.jpg', 48000.00, N'Sinh tố mãng cầu', 4),
  (N'Sinh tố dừa béo nhẹ', 1, N'sinh-to-dua.jpg', 42000.00, N'Sinh tố dừa', 4),
  (N'Sinh tố việt quất chua ngọt', 1, N'sinh-to-viet-quat.jpg', 49000.00, N'Sinh tố việt quất', 4),
  (N'Sinh tố mít thơm đậm', 1, N'sinh-to-mit.jpg', 43000.00, N'Sinh tố mít', 4),
  (N'Nước ép cam tươi', 1, N'nuoc-ep-cam.jpg', 39000.00, N'Nước ép cam', 5),
  (N'Nước ép ổi giàu vitamin C', 1, N'nuoc-ep-oi.jpg', 39000.00, N'Nước ép ổi', 5),
  (N'Nước ép dứa chua ngọt', 1, N'nuoc-ep-dua.jpg', 38000.00, N'Nước ép dứa', 5),
  (N'Nước ép táo thanh mát', 1, N'nuoc-ep-tao.jpg', 42000.00, N'Nước ép táo', 5),
  (N'Nước ép cà rốt tươi', 1, N'nuoc-ep-ca-rot.jpg', 38000.00, N'Nước ép cà rốt', 5),
  (N'Nước ép chanh leo đậm vị', 1, N'nuoc-ep-chanh-leo.jpg', 40000.00, N'Nước ép chanh leo', 5),
  (N'Nước ép lựu nguyên chất', 1, N'nuoc-ep-luu.jpg', 49000.00, N'Nước ép lựu', 5),
  (N'Nước ép dưa hấu mát lạnh', 1, N'nuoc-ep-dua-hau.jpg', 36000.00, N'Nước ép dưa hấu', 5),

  (N'Soda chanh tươi giải khát', 1, N'soda-chanh.jpg', 30000.00, N'Soda chanh', 6),
  (N'Soda vị việt quất', 1, N'soda-viet-quat.jpg', 35000.00, N'Soda việt quất', 6),
  (N'Soda dâu tươi', 1, N'soda-dau.jpg', 35000.00, N'Soda dâu', 6),
  (N'Soda chanh dây chua ngọt', 1, N'soda-chanh-day.jpg', 36000.00, N'Soda chanh dây', 6),
  (N'Soda đào thơm nhẹ', 1, N'soda-dao.jpg', 35000.00, N'Soda đào', 6),
  (N'Soda kiwi tươi mát', 1, N'soda-kiwi.jpg', 36000.00, N'Soda kiwi', 6),
  (N'Soda bạc hà the mát', 1, N'soda-bac-ha.jpg', 30000.00, N'Soda bạc hà', 6),
  (N'Soda mix nhiều loại trái cây', 1, N'soda-trai-cay.jpg', 38000.00, N'Soda trái cây tổng hợp', 6);

INSERT INTO NHANVIEN
  (email, hoTen, trangThai, sdt, vaiTro, matKhau)
VALUES
  (N'admin@polycoffee.vn', N'Nguyen Van Admin', 1, '0900000001', N'admin', N'123456'),
  (N'employee@polycoffee.vn', N'Tran Thi Employee', 1, '0900000002', N'employee', N'123456'),
  (N'guest@polycoffee.vn', N'Le Van Guest', 1, '0900000003', N'guest', N'123456');

INSERT INTO KHACHHANG
  (ngayDangKi, diaChi, email, sdt, hoTen)
VALUES
  ('2026-03-20', N'Quận 1, TP.HCM', N'kh1@gmail.com', '0911111111', N'Nguyen A'),
  ('2026-03-20', N'Quận 3, TP.HCM', N'kh2@gmail.com', '0922222222', N'Tran B'),
  ('2026-03-20', N'Thủ Đức, TP.HCM', N'kh3@gmail.com', '0933333333', N'Le C');

INSERT INTO HOADON
  (ngayTao, tongTien, trangThai, MaNV, MaKH)
VALUES
  (SYSDATETIME(), 54000.00, N'Paid', 1, 1),
  (SYSDATETIME(), 76000.00, N'Paid', 2, 2),
  ('2026-03-01T08:15:00', 0.00, N'Paid', 1, 1),
  ('2026-03-03T10:05:00', 0.00, N'Paid', 2, 2),
  ('2026-03-07T14:20:00', 0.00, N'Pending', 1, 3),
  ('2026-03-12T09:45:00', 0.00, N'Paid', 2, 1),
  ('2026-03-18T16:10:00', 0.00, N'Paid', 1, 2),
  ('2026-03-22T11:30:00', 0.00, N'Cancelled', 2, 3),
  ('2026-03-27T18:05:00', 0.00, N'Paid', 1, 1),
  ('2026-04-01T07:50:00', 0.00, N'Paid', 2, 2),
  ('2026-04-05T15:40:00', 0.00, N'Pending', 1, 3),
  ('2026-04-08T20:25:00', 0.00, N'Paid', 2, 1);

INSERT INTO CHITIETHOADON
  (donGia, soLuong, MaHD, MaDoUong)
VALUES
  (29000.00, 1, 1, 2),
  (25000.00, 1, 1, 1),
  (29000.00, 1, 2, 2),
  (25000.00, 1, 2, 1),
  (38000.00, 2, 2, 15),
  (25000.00, 2, 3, 1),
  (39000.00, 1, 3, 37),
  (45000.00, 1, 4, 5),
  (35000.00, 1, 4, 14),
  (40000.00, 1, 5, 26),
  (30000.00, 1, 5, 43),
  (48000.00, 1, 6, 33),
  (36000.00, 1, 6, 41),
  (45000.00, 1, 7, 29),
  (38000.00, 1, 7, 40),
  (34000.00, 2, 8, 28),
  (25000.00, 1, 8, 15),
  (39000.00, 1, 9, 13),
  (36000.00, 1, 9, 52),
  (49000.00, 1, 10, 35),
  (42000.00, 1, 10, 23),
  (45000.00, 1, 11, 11),
  (35000.00, 1, 11, 50),
  (42000.00, 1, 12, 31),
  (38000.00, 1, 12, 51);

UPDATE hd
SET hd.tongTien = cthd.tongTien
FROM HOADON hd
JOIN (
  SELECT MaHD, SUM(donGia * soLuong) AS tongTien
  FROM CHITIETHOADON
  GROUP BY MaHD
) cthd ON cthd.MaHD = hd.MaHD;

SELECT *
FROM HOADON;
SELECT *
FROM CHITIETHOADON;