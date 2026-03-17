-- Kiểm tra tên cột thực tế của bảng Categories
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'categories' 
ORDER BY ordinal_position;
