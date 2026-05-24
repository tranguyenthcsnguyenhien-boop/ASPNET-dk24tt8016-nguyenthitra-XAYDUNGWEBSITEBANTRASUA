CREATE DATABASE WebBanTraSua;
GO
USE WebBanTraSua;
GO

-- 1. Bảng Người dùng (Quản lý Admin và Khách hàng)
CREATE TABLE tblUser (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    FullName NVARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Role VARCHAR(20) DEFAULT 'Customer' -- Các quyền: 'Admin', 'Customer'
);

-- 2. Bảng Loại Sản Phẩm (Danh mục trà sữa)
CREATE TABLE tblLoaiSP (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    TenLoai NVARCHAR(100) NOT NULL,
    ThuTu INT DEFAULT 0
);

-- 3. Bảng Sản Phẩm
CREATE TABLE tblSanPham (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    MaLoai INT FOREIGN KEY REFERENCES tblLoaiSP(ID),
    TenSP NVARCHAR(200) NOT NULL,
    Gia DECIMAL(18,0) NOT NULL,
    HinhAnh VARCHAR(255),
    MoTa NVARCHAR(MAX),
    TrangThai BIT DEFAULT 1 -- 1: Đang bán, 0: Hết hàng
);

-- 4. Bảng Giỏ Hàng (Lưu giỏ hàng theo UserID)
CREATE TABLE tblGioHang (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT FOREIGN KEY REFERENCES tblUser(ID),
    SanPhamID INT FOREIGN KEY REFERENCES tblSanPham(ID),
    SoLuong INT NOT NULL
);

-- 5. Bảng Đơn Hàng (Lưu thông tin mua hàng)
CREATE TABLE tblDonHang (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT FOREIGN KEY REFERENCES tblUser(ID),
    NgayDat DATETIME DEFAULT GETDATE(),
    TongTien DECIMAL(18,0) NOT NULL,
    TrangThai NVARCHAR(50) DEFAULT N'Chờ Xử Lý', -- 'Chờ Xử Lý', 'Đang Giao', 'Hoàn Thành', 'Hủy'
    DiaChiGiao NVARCHAR(255) NOT NULL
);

-- 5. Bảng Chi Tiết Đơn Hàng
CREATE TABLE tblChiTietDonHang (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    DonHangID INT FOREIGN KEY REFERENCES tblDonHang(ID),
    SanPhamID INT FOREIGN KEY REFERENCES tblSanPham(ID),
    SoLuong INT NOT NULL,
    DonGia DECIMAL(18,0) NOT NULL
);
GO

-- ==============================================
-- CHÈN DỮ LIỆU MẪU ĐỂ TEST
-- ==============================================

-- Thêm tài khoản mẫu
INSERT INTO tblUser (Username, Password, FullName, Role) 
VALUES ('admin', '123456', N'Quản Trị Viên', 'Admin');
INSERT INTO tblUser (Username, Password, FullName, Role) 
VALUES ('khachhang', '123456', N'Khách Hàng Trà', 'Customer');

-- Thêm Loại SP mẫu
INSERT INTO tblLoaiSP (TenLoai, ThuTu) VALUES (N'Trà Sữa Truyền Thống', 1);
INSERT INTO tblLoaiSP (TenLoai, ThuTu) VALUES (N'Trà Trái Cây', 2);
INSERT INTO tblLoaiSP (TenLoai, ThuTu) VALUES (N'Trà Phô Mai Macchiato', 3);

-- Thêm Sản Phẩm mẫu
INSERT INTO tblSanPham (MaLoai, TenSP, Gia, HinhAnh, TrangThai) 
VALUES (1, N'Trà Sữa Trân Châu Đen', 35000, 'trasuatranchau.jpg', 1);

INSERT INTO tblSanPham (MaLoai, TenSP, Gia, HinhAnh, TrangThai) 
VALUES (1, N'Trà Sữa Nướng', 40000, 'trasuanuong.jpg', 1);

INSERT INTO tblSanPham (MaLoai, TenSP, Gia, HinhAnh, TrangThai) 
VALUES (2, N'Trà Đào Cam Sả', 45000, 'tradao.jpg', 1);

INSERT INTO tblSanPham (MaLoai, TenSP, Gia, HinhAnh, TrangThai) 
VALUES (3, N'Hồng Trà Macchiato', 50000, 'hongtramacchiato.jpg', 1);
GO
