# Hướng dẫn Deploy lên Render.com

## Bước 1: Chuẩn bị

1. Đảm bảo bạn đã có tài khoản:
   - GitHub: https://github.com
   - Render: https://render.com (đăng nhập bằng GitHub)

2. Commit và push code lên GitHub

## Bước 2: Tạo Database trên Supabase (Free)

1. Truy cập: https://supabase.com
2. Sign up / Login
3. Create new project
4. Chọn region gần nhất (Singapore/Hong Kong cho Asia)
5. Wait for project to be ready (~2-3 phút)
6. Copy **Database Connection String** (dạng: `postgresql://postgres:xxx@aws-0-xxx.supabase.com:5432/postgres`)

## Bước 3: Deploy Backend lên Render.com

1. Trong Render dashboard, click **New +** → **Web Service**
2. Connect GitHub repository
3. Configure:
   - **Name**: prj301-youtube (hoặc tên bạn muốn)
   - **Region**: Singapore/Hong Kong
   - **Branch**: main
   - **Root Directory**: (để trống nếu code ở root)
   - **Build Command**: `mvn clean package -DskipTests`
   - **Start Command**: `java -jar target/PRJ301_YouTube-1.0-SNAPSHOT.war` (hoặc dùng Docker)

4. **Environment Variables**:
   - `DATABASE_URL` = Connection string từ Supabase (bước 2)
   - `SERVER_PORT` = `8080`

5. Click **Create Web Service**
6. Wait for deployment (~5-10 phút)

## Bước 4: Setup Anti-sleep (Ping mỗi 5 phút)

### Cách 1: Google Apps Script (Free)

1. Truy cập: https://script.google.com
2. Create new project
3. Paste code từ file `google_apps_script.txt`
4. Thay `YOUR_RENDER_APP` bằng URL backend của bạn (ví dụ: `https://prj301-youtube.onrender.com`)
5. Save project
6. Click **Triggers** (icon đồng hồ)
7. **Add Trigger**:
   - Function: `keepServerAlive`
   - Event source: **Time-driven**
   - Event type: **Hour timer**
   - Interval: **Every 5 minutes**
8. Save

### Cách 2: UptimeRobot (Free)

1. Truy cập: https://uptimerobot.com
2. Sign up (free)
3. Add New Monitor:
   - Monitor Type: **HTTP (default)**
   - URL: `https://YOUR_RENDER_APP.onrender.com/health`
   - Interval: **5 minutes**
4. Save

## Bước 5: Test

1. Truy cập URL backend của bạn: `https://prj301-youtube.onrender.com/health`
2. Nếu thấy JSON response: `{"status":"ok",...}` là thành công
3. Kiểm tra logs trên Render để đảm bảo không có lỗi

## Lưu ý quan trọng:

- Render free tier sẽ sleep sau 15 phút không có request
- Anti-sleep (ping mỗi 5 phút) giúp server luôn "sống"
- Database trên Supabase free tier có giới hạn nhưng đủ cho project học tập
- Nếu cần SSL, Render tự động cung cấp HTTPS

## Troubleshooting:

- **Cold start**: Ping `/health` endpoint để thức tỉnh server
- **Connection error**: Kiểm tra DATABASE_URL có đúng không
- **Build failed**: Kiểm tra Maven build command và dependencies
