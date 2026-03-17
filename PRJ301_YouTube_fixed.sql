-- =============================================
-- Môn học: PRJ301 - Java Web Application Development
-- Chỉnh sửa cho PostgreSQL/Supabase - ĐÃ SỬA TÊN CỘT
-- =============================================

-- XÓA CÁC BẢNG NẾU TỒN TẠI (PostgreSQL)
DROP TABLE IF EXISTS Subscriptions CASCADE;
DROP TABLE IF EXISTS Comments CASCADE;
DROP TABLE IF EXISTS Videos CASCADE;
DROP TABLE IF EXISTS Categories CASCADE;
DROP TABLE IF EXISTS Users CASCADE;

-- 3. TẠO CÁC BẢNG (TABLES) - PostgreSQL
-- Bảng 1: Người dùng
CREATE TABLE Users (
    userID SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    fullName VARCHAR(100),
    email VARCHAR(100),
    role INT DEFAULT 0,
    status INT DEFAULT 1
);

-- Bảng 2: Danh mục
CREATE TABLE Categories (
    categoryID SERIAL PRIMARY KEY,
    categoryName VARCHAR(50) NOT NULL
);

-- Bảng 3: Video
CREATE TABLE Videos (
    videoID SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    uploadDate TIMESTAMP DEFAULT NOW(),
    status INT DEFAULT 1,
    userID INT REFERENCES Users(userID),
    categoryID INT REFERENCES Categories(categoryID)
);

-- Bảng 4: Bình luận - ĐÃ SỬA TÊN CỘT
CREATE TABLE Comments (
    commentID SERIAL PRIMARY KEY,
    content TEXT,
    commentDate TIMESTAMP DEFAULT NOW(),
    status INT DEFAULT 1,
    userID INT REFERENCES Users(userID),
    videoID INT REFERENCES Videos(videoID)
);

-- Bảng 5: Đăng ký kênh (Mối quan hệ n-n)
CREATE TABLE Subscriptions (
    subscriberID INT REFERENCES Users(userID),
    channelOwnerID INT REFERENCES Users(userID),
    PRIMARY KEY (subscriberID, channelOwnerID)
);

-- 4. CHÈN DỮ LIỆU MẪU (DUMMY DATA)

-- Thêm 6 Danh mục
INSERT INTO Categories (categoryName) VALUES 
('Game'), ('Am nhac'), ('Phim'), ('Tin tuc'), ('Giao duc'), ('The thao');

-- Thêm 7 Người dùng (Password mặc định: 123 hoặc 123456)
INSERT INTO Users (username, password, fullName, email, role, status) VALUES 
('binh_fpt', '202cb962ac59075b964b07152d234b70', 'Nguyen Binh', 'binh@fpt.edu.vn', 0, 1),
('thay_giao', '202cb962ac59075b964b07152d234b70', 'Giang vien PRJ', 'teacher@fpt.edu.vn', 0, 1),
('son_tung', '202cb962ac59075b964b07152d234b70', 'MTP Official', 'mtp@gmail.com', 0, 1),
('do_mixi', '202cb962ac59075b964b07152d234b70', 'Toc Truong', 'mixi@gmail.com', 0, 1),
('vtv_news', '202cb962ac59075b964b07152d234b70', 'VTV Digital', 'vtv@vtv.vn', 0, 1),
('fap_tv', '202cb962ac59075b964b07152d234b70', 'FAP TV', 'faptv@gmail.com', 0, 1),
('admin', 'e10adc3949ba59abbe56e057f20f883e', 'Admin System', 'admin@admin.prj', 1, 1);

-- Thêm 6 Video (Mỗi video thuộc một Category khác nhau)
INSERT INTO Videos (title, description, userID, categoryID) VALUES 
('LCS Summer 2026 Highlighs', 'Tran dau dinh cao', 4, 1),
('Chung ta cua tuong lai', 'MTP Official MV', 3, 2),
('Review Phim: Lat Mat 7', 'Tom tat phim hay', 6, 3),
('Tin nong 24h', 'Cap nhat tin tuc', 5, 4),
('Java Servlet can ban', 'Hoc PRJ301 cung FPTU', 2, 5),
('Highlight Ngoai Hang Anh', 'Bong da cuoi tuan', 1, 6);

-- Thêm 6 Bình luận (videoID tương ứng là 1, 2, 3...)
INSERT INTO Comments (content, userID, videoID) VALUES 
('Hay qua anh Do oi!', 1, 1),
('MV dinh cao that su', 4, 2),
('Phim nay hay, dang xem', 2, 3),
('Tin tuc rat ket thoi', 3, 4),
('Cam on thay vi bai giang', 1, 5),
('Tran dau qua kich tinh', 5, 6);

-- Thêm 6 Lượt đăng ký
INSERT INTO Subscriptions (subscriberID, channelOwnerID) VALUES 
(1, 3), (1, 4), (4, 3), (2, 5), (5, 6), (6, 2);
