-- Tạo database mới tên là PRJ301_YouTube trên Supabase
-- Chạy lệnh này trong Supabase SQL Editor

-- Tạo database (PostgreSQL không cho CREATE DATABASE trong SQL Editor)
-- Bạn cần chạy lệnh này qua psql hoặc Supabase dashboard

-- Cách 1: Qua Supabase Dashboard
-- 1. Truy cập: https://supabase.com/dashboard
-- 2. Project → **SQL Editor**
-- 3. Chạy lệnh sau:

-- Tạo database mới
-- CREATE DATABASE PRJ301_YouTube;

-- Cách 2: Qua psql (nếu có cài đặt)
-- psql -h aws-0-xxx.supabase.com -U postgres -d postgres -c "CREATE DATABASE PRJ301_YouTube;"

-- Sau khi tạo xong, chạy file PRJ301_YouTube.sql để tạo bảng và dữ liệu
