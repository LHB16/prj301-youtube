-- ============================================
-- SỬA BẢNG CATEGORIES - THÊM CỘT DESCRIPTION NẾU THIẾU
-- ============================================

-- Kiểm tra và thêm cột description nếu chưa tồn tại
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'categories' AND column_name = 'description'
    ) THEN
        ALTER TABLE Categories ADD COLUMN description TEXT;
        RAISE NOTICE 'Added description column to Categories';
    ELSE
        RAISE NOTICE 'Description column already exists';
    END IF;
END $$;

-- Thêm dữ liệu mẫu
INSERT INTO Categories (name, description) 
VALUES 
('Gaming', 'Video game reviews, walkthroughs, and gameplay'),
('Music', 'Music videos, covers, and performances'),
('Education', 'Educational content and tutorials'),
('Tech', 'Technology reviews and tutorials'),
('Lifestyle', 'Lifestyle vlogs and tips'),
('Comedy', 'Comedy sketches and funny videos'),
('Sports', 'Sports highlights and analysis'),
('Food', 'Cooking and food reviews')
ON CONFLICT (name) DO NOTHING;
