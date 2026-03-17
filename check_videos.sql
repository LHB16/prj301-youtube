-- Kiểm tra tên cột thực tế của bảng Videos
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'videos' 
ORDER BY ordinal_position;
