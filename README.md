# PBL3 - Maven Web Application

## Giới thiệu

Đây là dự án Java Web sử dụng Maven, hỗ trợ phát triển và triển khai ứng dụng web với Jakarta Servlet, MySQL và các thư viện phổ biến như Gson.

## Cấu trúc thư mục

```
PBL3/
├── src/
│   ├── main/
│   │   ├── java/                   # Chứa mã nguồn Java
│   │   │    ├── controller/        # Xử lý các request, điều hướng luồng dữ liệu giữa view và model
│   │   │    ├── DAO/               # Thao tác dữ liệu với cơ sở dữ liệu (Data Access Object)
│   │   │    ├── filter/            # Bộ lọc request/response (ví dụ xác thực, phân quyền)
│   │   │    ├── model/             # Định nghĩa các lớp đối tượng (entity, POJO)
│   │   │    ├── util/              # Các tiện ích, hàm dùng chung
│   └── webapp/                     # Tài nguyên web phục vụ (JSP, HTML, CSS, JS)
│        ├── WEB-INF/               # Thư mục cấu hình web, không truy cập trực tiếp từ trình duyệt
│        │   └── web.xml            # File cấu hình ứng dụng web (Servlet, filter, listener, ...)
│        └── css/                   # Chứa các file CSS cho giao diện
├── .gitignore                      # Các file/thư mục loại trừ khi commit lên Git
├── pom.xml                         # File cấu hình và quản lý phụ thuộc Maven
├── football_management.sql         # File script SQL để khởi tạo cơ sở dữ liệu
└── README.md                       # Tài liệu hướng dẫn này
```



## Cách chạy dự án trên IntelliJ IDEA

1. **Clone dự án về máy:**
   ```sh
   git clone https://github.com/VietNamCombatZ/PBL3.git
   ```

2. **Mở dự án bằng IntelliJ IDEA:**
    - Chọn **Open** hoặc **Import Project** và trỏ tới thư mục chứa dự án (`PBL3`).
    - IntelliJ sẽ tự động nhận dạng là dự án Maven.

3. **Cấu hình JDK:**
    - Đảm bảo bạn đã cài đặt JDK 9 trở lên.
    - Vào File > Project Structure > Project và chọn Project SDK là JDK 9+.

4. **Tải dependencies Maven:**
    - Nhấn chuột phải vào dự án > **Maven** > **Reload Project** hoặc dùng biểu tượng refresh trong tab Maven.

5. **Cấu hình và chạy server:**
    - Dự án sử dụng Jakarta Servlet API, tương thích với Tomcat 10.1.x trở lên.
    - Có thể dùng Tomcat tích hợp trong IntelliJ:
        - Vào **Add Configuration** (góc phải trên cùng) > **Add New Configuration** > **Tomcat Server** > **Local**.
        - Trỏ tới thư mục cài đặt Tomcat.
        - Chọn **artifact** hoặc **war exploded** để deploy.
    - Nhấn **Run** hoặc **Debug** để chạy.

6. **Cấu hình database:**
    - Cập nhật kết nối tới MySQL trong file cấu hình (ví dụ: `src/main/resources/application.properties` hoặc trong code Java).
    - Chạy script SQL `pbl3.sql` để tạo cấu trúc cơ sở dữ liệu cần thiết.
    - Đảm bảo MySQL đang chạy và đã tạo database cần thiết.

7. **Truy cập ứng dụng:**
    - Sau khi chạy, mở trình duyệt và truy cập đường dẫn ví dụ: `http://localhost:8080/PBL3` (tùy cấu hình Tomcat).

## Thông tin thêm

- Các dependencies chính:
    - `jakarta.servlet-api` (Servlet)
    - `mysql-connector-java` (Kết nối MySQL)
    - `gson` (Xử lý JSON)
    - `junit` (Test)

Nếu gặp sự cố khi build hoặc chạy dự án, hãy kiểm tra lại file `pom.xml` và cấu hình môi trường (JDK, Tomcat, MySQL).

---