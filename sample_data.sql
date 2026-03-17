-- ============================================
-- DỮ LIỆU MẪU CHO PRJ301 YOUTUBE
-- Cấu trúc giống với PRJ301_YouTube.sql (SQL Server)
-- ============================================

-- 1. Tạo bảng Users (nếu chưa tồn tại)
CREATE TABLE IF NOT EXISTS Users (
    userID SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    fullName VARCHAR(100),
    email VARCHAR(100),
    role INT DEFAULT 0,
    status INT DEFAULT 1
);

ALTER TABLE Users DISABLE ROW LEVEL SECURITY;

-- Xóa dữ liệu cũ
TRUNCATE TABLE Users RESTART IDENTITY CASCADE;

-- Thêm dữ liệu mẫu (giống PRJ301_YouTube.sql)
-- Password MD5: 123=202cb962ac59075b964b07152d234b70, admin=123456=e10adc3949ba59abbe56e057f20f883e
INSERT INTO Users (username, password, fullName, email, role, status) 
VALUES 
('binh_fpt', '202cb962ac59075b964b07152d234b70', 'Nguyen Binh', 'binh@fpt.edu.vn', 0, 1),
('thay_giao', '202cb962ac59075b964b07152d234b70', 'Giang vien PRJ', 'teacher@fpt.edu.vn', 0, 1),
('son_tung', '202cb962ac59075b964b07152d234b70', 'MTP Official', 'mtp@gmail.com', 0, 1),
('do_mixi', '202cb962ac59075b964b07152d234b70', 'Toc Truong', 'mixi@gmail.com', 0, 1),
('vtv_news', '202cb962ac59075b964b07152d234b70', 'VTV Digital', 'vtv@vtv.vn', 0, 1),
('fap_tv', '202cb962ac59075b964b07152d234b70', 'FAP TV', 'faptv@gmail.com', 0, 1),
('admin', 'e10adc3949ba59abbe56e057f20f883e', 'Admin System', 'admin@admin.prj', 1, 1);

-- ============================================

-- 2. Tạo bảng Categories (dùng 'name' thay vì 'categoryName')
CREATE TABLE IF NOT EXISTS Categories (
    categoryID SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

ALTER TABLE Categories DISABLE ROW LEVEL SECURITY;

TRUNCATE TABLE Categories RESTART IDENTITY CASCADE;

-- Thêm 6 Danh mục (dùng cột 'name')
INSERT INTO Categories (name) 
VALUES 
('Game'), ('Am nhac'), ('Phim'), ('Tin tuc'), ('Giao duc'), ('The thao');

-- ============================================

-- 3. Tạo bảng Videos
CREATE TABLE IF NOT EXISTS Videos (
    videoID SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    uploadDate TIMESTAMP DEFAULT NOW(),
    status INT DEFAULT 1,
    userID INT REFERENCES Users(userID),
    categoryID INT REFERENCES Categories(categoryID)
);

ALTER TABLE Videos DISABLE ROW LEVEL SECURITY;

TRUNCATE TABLE Videos RESTART IDENTITY CASCADE;

-- Thêm 6 Video
INSERT INTO Videos (title, description, userID, categoryID) 
VALUES 
('LCS Summer 2026 Highlighs', 'Tran dau dinh cao', 4, 1),
('Chung ta cua tuong lai', 'MTP Official MV', 3, 2),
('Review Phim: Lat Mat 7', 'Tom tat phim hay', 6, 3),
('Tin nong 24h', 'Cap nhat tin tuc', 5, 4),
('Java Servlet can ban', 'Hoc PRJ301 cung FPTU', 2, 5),
('Highlight Ngoai Hang Anh', 'Bong da cuoi tuan', 1, 6);

-- ============================================

-- 4. Tạo bảng Comments
CREATE TABLE IF NOT EXISTS Comments (
    commentID SERIAL PRIMARY KEY,
    content TEXT,
    commentDate TIMESTAMP DEFAULT NOW(),
    status INT DEFAULT 1,
    userID INT REFERENCES Users(userID),
    videoID INT REFERENCES Videos(videoID)
);

ALTER TABLE Comments DISABLE ROW LEVEL SECURITY;

TRUNCATE TABLE Comments RESTART IDENTITY CASCADE;

-- Thêm 6 Bình luận
INSERT INTO Comments (content, userID, videoID) 
VALUES 
('Hay qua anh Do oi!', 1, 1),
('MV dinh cao that su', 4, 2),
('Phim nay hay, dang xem', 2, 3),
('Tin tuc rat ket thoi', 3, 4),
('Cam on thay vi bai giang', 1, 5),
('Tran dau qua kich tinh', 5, 6);

-- ============================================

-- 5. Tạo bảng Subscriptions
CREATE TABLE IF NOT EXISTS Subscriptions (
    subscriberID INT REFERENCES Users(userID),
    channelOwnerID INT REFERENCES Users(userID),
    PRIMARY KEY (subscriberID, channelOwnerID)
);

ALTER TABLE Subscriptions DISABLE ROW LEVEL SECURITY;

TRUNCATE TABLE Subscriptions RESTART IDENTITY CASCADE;

-- Thêm 6 Lượt đăng ký
INSERT INTO Subscriptions (subscriberID, channelOwnerID) 
VALUES 
(1, 3), (1, 4), (4, 3), (2, 5), (5, 6), (6, 2);

-- ============================================
-- DỮ LIỆU MẪU ĐÃ ĐƯỢC THÊM
-- ============================================
