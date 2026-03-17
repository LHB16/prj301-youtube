-- Đổi tên cột commentDate trong bảng Comments
-- Chạy lệnh này trong Supabase SQL Editor

-- Đổi tên cột
ALTER TABLE Comments RENAME COLUMN commentdate TO commentDate;

-- Đổi tên cột commentID
ALTER TABLE Comments RENAME COLUMN commentid TO commentID;

-- Đổi tên cột content (giữ nguyên)
