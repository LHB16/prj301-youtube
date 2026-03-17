-- =============================================
-- Môn học: PRJ301 - Java Web Application Development
-- =============================================

-- 1. XÓA DATABASE CŨ (NẾU CÓ) ĐỂ LÀM MỚI
USE master;
GO
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'PRJ301_YouTube')
BEGIN
    ALTER DATABASE PRJ301_YouTube SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE PRJ301_YouTube;
END
GO

-- 2. TẠO DATABASE MỚI
CREATE DATABASE PRJ301_YouTube;
GO
USE PRJ301_YouTube;
GO

-- 3. TẠO CÁC BẢNG (TABLES)
-- Bảng 1: Người dùng
CREATE TABLE Users (
    userID INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    fullName NVARCHAR(100),
    email VARCHAR(100),
    role INT DEFAULT 0,
    status INT DEFAULT 1
);

-- Bảng 2: Danh mục (Thay thế cho việc tạo nhiều bảng nhỏ) 
CREATE TABLE Categories (
    categoryID INT PRIMARY KEY IDENTITY(1,1),
    categoryName NVARCHAR(50) NOT NULL
);

-- Bảng 3: Video
CREATE TABLE Videos (
    videoID INT PRIMARY KEY IDENTITY(1,1),
    title NVARCHAR(200) NOT NULL,
    description NVARCHAR(MAX),
    uploadDate DATETIME DEFAULT GETDATE(),
    status INT DEFAULT 1,
    userID INT FOREIGN KEY REFERENCES Users(userID),
    categoryID INT FOREIGN KEY REFERENCES Categories(categoryID)
);

-- Bảng 4: Bình luận
CREATE TABLE Comments (
    commentID INT PRIMARY KEY IDENTITY(1,1),
    content NVARCHAR(MAX),
    commentDate DATETIME DEFAULT GETDATE(),
    status INT DEFAULT 1,
    userID INT FOREIGN KEY REFERENCES Users(userID),
    videoID INT FOREIGN KEY REFERENCES Videos(videoID)
);

-- Bảng 5: Đăng ký kênh (Mối quan hệ n-n)
CREATE TABLE Subscriptions (
    subscriberID INT FOREIGN KEY REFERENCES Users(userID),
    channelOwnerID INT FOREIGN KEY REFERENCES Users(userID),
    PRIMARY KEY (subscriberID, channelOwnerID)
);
GO

-- 4. CHÈN DỮ LIỆU MẪU (DUMMY DATA)

-- Thêm 6 Danh mục
INSERT INTO Categories (categoryName) VALUES 
(N'Game'), (N'Âm nhạc'), (N'Phim'), (N'Tin tức'), (N'Giáo dục'), (N'Thể thao');

-- Thêm 7 Người dùng (Password mặc định: 123 hoặc 123456)
INSERT INTO Users (username, password, fullName, email, role, status) VALUES 
('binh_fpt', '202cb962ac59075b964b07152d234b70', N'Nguyễn Bình', 'binh@fpt.edu.vn', 0, 1),
('thay_giao', '202cb962ac59075b964b07152d234b70', N'Giảng viên PRJ', 'teacher@fpt.edu.vn', 0, 1),
('son_tung', '202cb962ac59075b964b07152d234b70', N'MTP Official', 'mtp@gmail.com', 0, 1),
('do_mixi', '202cb962ac59075b964b07152d234b70', N'Tộc Trưởng', 'mixi@gmail.com', 0, 1),
('vtv_news', '202cb962ac59075b964b07152d234b70', N'VTV Digital', 'vtv@vtv.vn', 0, 1),
('fap_tv', '202cb962ac59075b964b07152d234b70', N'FAP TV', 'faptv@gmail.com', 0, 1),
('admin', 'e10adc3949ba59abbe56e057f20f883e', N'Admin System', 'admin@admin.prj', 1, 1);

-- Thêm 6 Video (Mỗi video thuộc một Category khác nhau - videoID sẽ tự động tăng dạng int)
INSERT INTO Videos (title, description, userID, categoryID) VALUES 
(N'LCS Summer 2026 Highlighs', N'Trận đấu đỉnh cao', 4, 1),
(N'Chúng ta của tương lai', N'MTP Official MV', 3, 2),
(N'Review Phim: Lật Mặt 7', N'Tóm tắt phim hay', 6, 3),
(N'Tin nóng 24h', N'Cập nhật tin tức', 5, 4),
(N'Java Servlet căn bản', N'Học PRJ301 cùng FPTU', 2, 5),
(N'Highlight Ngoại Hạng Anh', N'Bóng đá cuối tuần', 1, 6);

-- Thêm 6 Bình luận (videoID tương ứng là 1, 2, 3...)
INSERT INTO Comments (content, userID, videoID) VALUES 
(N'Hay quá anh Độ ơi!', 1, 1),
(N'MV đỉnh cao thật sự', 4, 2),
(N'Phim này hay, đáng xem', 2, 3),
(N'Tin tức rất kịp thời', 3, 4),
(N'Cảm ơn thầy vì bài giảng', 1, 5),
(N'Trận đấu quá kịch tính', 5, 6);

-- Thêm 6 Lượt đăng ký
INSERT INTO Subscriptions (subscriberID, channelOwnerID) VALUES 
(1, 3), (1, 4), (4, 3), (2, 5), (5, 6), (6, 2);
GO
