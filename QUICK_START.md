# Quick Start - Deploy Java Web App lên Render.com

## Đã làm xong:
✅ Health check endpoint `/health`  
✅ Database hỗ trợ environment variable (Supabase PostgreSQL)  
✅ Thêm PostgreSQL driver vào pom.xml  
✅ Dockerfile sẵn sàng  
✅ render.yaml configuration  

## Các bước tiếp theo:

### 1. Push code lên GitHub
```bash
git add .
git commit -m "Add health check and database config"
git push origin main
```

### 2. Tạo Supabase Database (5 phút)
- Truy cập: https://supabase.com
- Sign up / Login
- Create new project
- Chọn region: **Singapore** hoặc **Hong Kong**
- Wait ~2-3 phút
- Copy **Database Connection String** (dạng: `postgresql://postgres:xxx@aws-0-xxx.supabase.com:5432/postgres`)

### 3. Deploy lên Render (10 phút)
- Truy cập: https://render.com
- Login bằng GitHub
- **New +** → **Web Service**
- Connect repository
- Configure:
  - **Name**: prj301-youtube
  - **Region**: Singapore
  - **Branch**: main
  - **Build**: `mvn clean package -DskipTests`
  - **Start**: `java -jar target/PRJ301_YouTube-1.0-SNAPSHOT.war`
- **Environment Variables**:
  - `DATABASE_URL` = (paste connection string từ Supabase)
  - `SERVER_PORT` = `8080`
- **Create Web Service**
- Wait ~10 phút để deploy xong

### 4. Setup Anti-sleep (5 phút)
- Truy cập: https://uptimerobot.com
- Sign up (free)
- Add **New Monitor**:
  - URL: `https://prj301-youtube.onrender.com/health`
  - Interval: **5 minutes**
- Save

### 5. Test
- Truy cập: `https://prj301-youtube.onrender.com/health`
- Nếu thấy JSON response là OK!

## Chi tiết đầy đủ: Xem file DEPLOYMENT_GUIDE.md

## Vấn đề thường gặp:

| Vấn đề | Giải pháp |
|--------|-----------|
| Cold start (chậm 30s) | Đã fix bằng anti-sleep ping |
| Database connection error | Kiểm tra DATABASE_URL đúng không |
| Build failed | Kiểm tra Maven đã cài chưa |
| 404 Not Found | Kiểm tra URL và web.xml |

## Support:
- Render docs: https://render.com/docs
- Supabase docs: https://supabase.com/docs
- Maven: https://maven.apache.org/guides/getting-started/
