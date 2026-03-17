-- Kiểm tra cấu trúc bảng Categories
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'categories';

-- Kiểm tra cấu trúc bảng Videos
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'videos';
