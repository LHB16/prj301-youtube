-- Tạo bảng Users (nếu chưa tồn tại)
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

-- Xóa dữ liệu cũ (nếu có)
TRUNCATE TABLE Users RESTART IDENTITY CASCADE;

-- Thêm dữ liệu mẫu

-- Admin (role = 1)
INSERT INTO Users (username, password, fullName, email, role, status) 
VALUES ('admin', '21232f297a57a5a743894a0e4a801fc3', 'Administrator', 'admin@example.com', 1, 1);

-- User thường (role = 0)
INSERT INTO Users (username, password, fullName, email, role, status) 
VALUES ('user1', 'ee11cbb19052e40b07aac0ca060c23ee', 'User One', 'user1@example.com', 0, 1);

INSERT INTO Users (username, password, fullName, email, role, status) 
VALUES ('user2', 'ee11cbb19052e40b07aac0ca060c23ee', 'User Two', 'user2@example.com', 0, 1);

-- Ghi chú:
-- Password MD5 của 'admin' là: 21232f297a57a5a743894a0e4a801fc3
-- Password MD5 của '123' là: ee11cbb19052e40b07aac0ca060c23ee
