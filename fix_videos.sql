-- ============================================
-- SỬA BẢNG VIDEOS - THÊM CỘT THIẾU NẾU CẦN
-- ============================================

-- Kiểm tra và thêm cột thumbnailURL nếu chưa tồn tại
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'videos' AND column_name = 'thumbnailURL'
    ) THEN
        ALTER TABLE Videos ADD COLUMN thumbnailURL VARCHAR(1000);
        RAISE NOTICE 'Added thumbnailURL column to Videos';
    ELSE
        RAISE NOTICE 'thumbnailURL column already exists';
    END IF;
END $$;

-- Thêm dữ liệu mẫu
INSERT INTO Videos (title, description, videoURL, thumbnailURL, views, likes, userID, categoryID) 
VALUES 
('Top 10 Game Moments 2024', 'Best gaming moments of the year', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerEscapes.jpg', 1523, 120, 2, 1),
('Learn Java in 30 Minutes', 'Quick Java tutorial for beginners', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg', 890, 85, 3, 3),
('Best Tech Gadgets 2024', 'Top tech gadgets you need to buy', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerFun.jpg', 2341, 198, 2, 4),
('Cooking Pasta Like a Pro', 'Learn to cook perfect pasta', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerJoyrides.jpg', 567, 45, 3, 8),
('Funny Cat Compilation', 'Hilarious cat moments', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/Sintel.jpg', 3456, 290, 1, 6),
('Football Highlights', 'Best goals and plays', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/TearsOfSteel.jpg', 1234, 98, 2, 7),
('Piano Lesson for Beginners', 'Learn piano basics', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg', 789, 67, 3, 2),
('Gaming Setup Tour', 'My gaming setup breakdown', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4', 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg', 2100, 175, 2, 1)
ON CONFLICT DO NOTHING;
