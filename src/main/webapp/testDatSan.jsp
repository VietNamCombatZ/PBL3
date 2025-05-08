<%--
  Created by IntelliJ IDEA.
  User: huynguyenduc
  Date: 8/5/25
  Time: 14:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt Sân</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
</head>
<body class="bg-gray-100 p-6">

<div class="max-w-4xl mx-auto bg-white shadow-md p-6 rounded-lg">
    <h2 class="text-2xl font-bold mb-4">Đặt Sân</h2>

    <!-- Chọn ngày -->
    <div class="mb-4">
        <label class="block text-gray-700">Chọn ngày:</label>
        <input type="text" id="datepicker" class="w-full px-3 py-2 border rounded" />
    </div>

    <!-- Chọn giờ -->
    <div class="mb-4">
        <label class="block text-gray-700">Chọn giờ:</label>
        <select id="select-hour" class="w-full px-3 py-2 border rounded">
            <!-- Các giờ sẽ được load sau khi chọn ngày -->
        </select>
    </div>

    <!-- Hiển thị danh sách sân chưa được đặt -->
    <div class="mb-4">
        <h3 class="text-lg font-semibold">Danh sách sân có sẵn:</h3>
        <ul id="available-fields" class="list-none p-0">
            <!-- Các sân sẽ được hiển thị ở đây sau khi chọn ngày và giờ -->
        </ul>
    </div>
</div>

<script>
    // Các khung giờ có sẵn cho phép đặt
    const availableHours = [6, 7, 8, 9, 15, 16, 17, 18, 19, 20];

    // Kiểm tra ngày và lấy các giờ hợp lệ
    function getValidHours(currentHour, selectedDate) {
        const today = new Date();
        const targetDate = new Date(selectedDate);

        // Nếu ngày chọn là ngày hôm nay, chỉ cho phép chọn các khung giờ sau giờ hiện tại
        if (targetDate.toDateString() === today.toDateString()) {
            return availableHours.filter(hour => hour > currentHour);
        }

        // Nếu là ngày trong tương lai, cho phép chọn tất cả các khung giờ
        return availableHours;
    }

    // Khởi tạo Flatpickr cho input chọn ngày
    flatpickr("#datepicker", {
        dateFormat: "Y-m-d", // Định dạng ngày là YYYY-MM-DD
        minDate: "today", // Chỉ cho phép chọn ngày hôm nay hoặc tương lai
        onChange: function(selectedDates, dateStr, instance) {
            // Khi người dùng chọn ngày, gọi hàm để tải các giờ có sẵn
            loadAvailableHours(dateStr);
        }
    });

    // Hàm tải các giờ có sẵn
    function loadAvailableHours(date) {
        const currentDate = new Date();
        const currentHour = currentDate.getHours();

        // Lấy các giờ hợp lệ dựa trên ngày và giờ hiện tại
        const validHours = getValidHours(currentHour, date);

        // Cập nhật dropdown với các giờ hợp lệ
        let hoursDropdown = $('#select-hour');
        hoursDropdown.empty();

        validHours.forEach(hour => {
            hoursDropdown.append(`<option value="${hour}">${hour}:00</option>`);
        });

        // Gọi hàm để hiển thị các sân có sẵn khi chọn giờ
        hoursDropdown.change(function() {
            let selectedHour = $(this).val();
            loadAvailableFields(date, selectedHour);
        });
    }

    // Hàm tải danh sách sân có sẵn cho giờ đã chọn
    function loadAvailableFields(date, hour) {
        $.ajax({
            url: 'getAvailableFields', // Đổi thành URL của bạn
            type: 'GET',
            data: { date: date, hour: hour },
            success: function(response) {
                let fieldsList = $('#available-fields');
                fieldsList.empty();

                // Giả sử 'response' chứa các sân chưa được đặt
                if (response.fields.length === 0) {
                    fieldsList.append('<li>Không có sân trống vào giờ này.</li>');
                } else {
                    response.fields.forEach(field => {
                        fieldsList.append(`<li>${field.name}</li>`);
                    });
                }
            }
        });
    }
</script>
</body>
</html>


