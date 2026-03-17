-- ============================================
-- DỮ LIỆU MẪU CHO PRJ301 YOUTUBE
-- ============================================

-- 1. Tạo bảng Users (nếu chưa tồn tại)
CREATE TABLE IF NOT EXISTS Users (
    userID SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    fullName VARCHAR(255),
    email VARCHAR(255) NOT NULL UNIQUE,
    role INT DEFAULT 0,
    status INT DEFAULT 1,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Tắt RLS
ALTER TABLE Users DISABLE ROW LEVEL SECURITY;

-- Xóa dữ liệu cũ
TRUNCATE TABLE Users RESTART IDENTITY CASCADE;

-- Thêm tài khoản mẫu
-- Password MD5: admin=21232f297a57a5a743894a0e4a801fc3, 123=ee11cbb19052e40b07aac0ca060c23ee
INSERT INTO Users (username, password, fullName, email, role, status) 
VALUES 
('admin', '21232f297a57a5a743894a0e4a801fc3', 'Administrator', 'admin@example.com', 1, 1),
('user1', 'ee11cbb19052e40b07aac0ca060c23ee', 'User One', 'user1@example.com', 0, 1),
('user2', 'ee11cbb19052e40b07aac0ca060c23ee', 'User Two', 'user2@example.com', 0, 1);

-- ============================================

-- 2. Tạo bảng Categories
CREATE TABLE IF NOT EXISTS Categories (
    categoryID SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

ALTER TABLE Categories DISABLE ROW LEVEL SECURITY;

TRUNCATE TABLE Categories RESTART IDENTITY CASCADE;

-- Thêm danh mục mẫu
INSERT INTO Categories (name, description) 
VALUES 
('Gaming', 'Video game reviews, walkthroughs, and gameplay'),
('Music', 'Music videos, covers, and performances'),
('Education', 'Educational content and tutorials'),
('Tech', 'Technology reviews and tutorials'),
('Lifestyle', 'Lifestyle vlogs and tips'),
('Comedy', 'Comedy sketches and funny videos'),
('Sports', 'Sports highlights and analysis'),
('Food', 'Cooking and food reviews');

-- ============================================

-- 3. Tạo bảng Videos
CREATE TABLE IF NOT EXISTS Videos (
    videoID SERIAL PRIMARY KEY,
    title VARCHAR(500) NOT NULL,
    description TEXT,
    videoURL VARCHAR(1000) NOT NULL,
    thumbnailURL VARCHAR(1000),
    views INT DEFAULT 0,
    likes INT DEFAULT 0,
    userID INT REFERENCES Users(userID),
    categoryID INT REFERENCES Categories(categoryID),
    created_at TIMESTAMP DEFAULT NOW()
);

ALTER TABLE Videos DISABLE ROW LEVEL SECURITY;

TRUNCATE TABLE Videos RESTART IDENTITY CASCADE;

-- Thêm video mẫu (thay YOUR_BUCKET_URL bằng URL bucket của bạn)
INSERT INTO Videos (title, description, videoURL, thumbnailURL, views, likes, userID, categoryID) 
VALUES 
('Top 10 Game Moments 2024', 'Best gaming moments of the year', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerEscapes.jpg', 1523, 120, 2, 1),
('Learn Java in 30 Minutes', 'Quick Java tutorial for beginners', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg', 890, 85, 3, 3),
('Best Tech Gadgets 2024', 'Top tech gadgets you need to buy', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerFun.jpg', 2341, 198, 2, 4),
('Cooking Pasta Like a Pro', 'Learn to cook perfect pasta', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerJoyrides.jpg', 567, 45, 3, 8),
('Funny Cat Compilation', 'Hilarious cat moments', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/Sintel.jpg', 3456, 290, 1, 6),
('Football Highlights', 'Best goals and plays', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/TearsOfSteel.jpg', 1234, 98, 2, 7),
('Piano Lesson for Beginners', 'Learn piano basics', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg', 789, 67, 3, 2),
('Gaming Setup Tour', 'My gaming setup breakdown', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg', 2100, 175, 2, 1);

-- ============================================

-- 4. Tạo bảng Comments
CREATE TABLE IF NOT EXISTS Comments (
    commentID SERIAL PRIMARY KEY,
    content TEXT NOT NULL,
    userID INT REFERENCES Users(userID),
    videoID INT REFERENCES Videos(videoID),
    created_at TIMESTAMP DEFAULT NOW()
);

ALTER TABLE Comments DISABLE ROW LEVEL SECURITY;

TRUNCATE TABLE Comments RESTART IDENTITY CASCADE;

INSERT INTO Comments (content, userID, videoID) 
VALUES 
('Great video! Very helpful.', 2, 2),
('I loved this!', 3, 1),
('Can you make more tutorials?', 3, 2),
('Best compilation ever!', 1, 5),
('Nice setup!', 2, 8);

-- ============================================

-- 5. Tạo bảng Subscriptions
CREATE TABLE IF NOT EXISTS Subscriptions (
    subscriptionID SERIAL PRIMARY KEY,
    subscriberID INT REFERENCES Users(userID),
    channelID INT REFERENCES Users(userID),
    created_at TIMESTAMP DEFAULT NOW()
);

ALTER TABLE Subscriptions DISABLE ROW LEVEL SECURITY;

TRUNCATE TABLE Subscriptions RESTART IDENTITY CASCADE;

INSERT INTO Subscriptions (subscriberID, channelID) 
VALUES 
(2, 3),
(3, 2),
(1, 2);

-- ============================================
-- DỮ LIỆU MẪU ĐÃ ĐƯỢC THÊM
-- ============================================
