# **PBL3 - hướng dẫn làm việc với git**
1. Khởi tạo git để làm việc tạo thư mục dự án
- B1: Mở Intellj IDEA, mở thư mục dự án web jsp đã khỏi tạo
- B2: Mở terminal (Các biểu tượng ở góc dưới bên trái)
- B3: Trong Terminal, nhìn lên hàng chọn, bấm vào dấu "v", chọn "bash" (thao tác trên git sẽ dùng bash)
- B4: Nhập các lệnh sau:
  + git init (khởi tạo các file cài đặt để làm việc với git)
  + git add . (thêm tất cả các file vào git)
  + git commit -m <tin nhắn - gõ gì cũng được để người khác biết mình đã chỉnh sửa gì, nhớ đặt trong dấu "">
  + git remote add tên-gợi-nhớ-repo-github(tự chọn) link-repo(copy link repo đó trên github)
  + git push -u tên-gợi-nhớ-repo-github(tự chọn) nhánh chính (thường là main hoặc master)- vd: git push -u pbl3 main
* các lần sau push không cần gõ -u


2. Cách lấy dự án từ trên github về máy
- Làm tương tự phần 1 đến hết bước 3
- Nhập các lệnh sau:
  git checkout tên-nhánh-cần-cập-nhật
  git fetch tên-gợi-nhớ-repo-github     Ví dụ: git fetch pbl3
  git merge tên-nhánh-cần-cập-nhật
