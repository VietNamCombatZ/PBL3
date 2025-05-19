<%@ page import="model.sanBong"  import="java.util.*"%><%--
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
<%
    String selectedTime = (String) request.getAttribute("selectedTime");
    String selectedHour = "";
    if (selectedTime != null && selectedTime.contains(" ")) {
        selectedHour = selectedTime.split(" ")[1].substring(0, 5); // ví dụ "06:00"
    }
%>
<%--navbar--%>
<%@include file="../navbar.jsp" %>
<%--body--%>

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

    <!-- Nút Tìm kiếm -->
    <div class="mb-4">

        <form id="booking-form" action="<%= request.getContextPath() %>/sanBong/danhSachSanCoSan" method="POST">
            <input type="hidden" name="timestamp" id="hidden-timestamp">
            <button id="search-button" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700">
                Tìm kiếm
            </button>
        </form>
    </div>


    <!-- Hiển thị danh sách sân chưa được đặt -->
    <div class="mb-4">
        <h3 class="text-lg font-semibold">Danh sách sân có sẵn:</h3>
        <ul id="available-fields" class="list-none p-0">
            <!-- Các sân sẽ được hiển thị ở đây sau khi chọn ngày và giờ -->
            <%
                List<sanBong> availableFields = (List<sanBong>) request.getAttribute("availableFields");
                if (availableFields != null) {
                    if (availableFields.isEmpty()) {
            %>
            <li>Không có sân nào khả dụng trong khoảng thời gian này.</li>
            <%
            } else {
                for (sanBong sb : availableFields) {
            %>
            <li class="border p-2 mb-2 flex justify-between items-center">
                <span><%= sb.getTenSan() %></span>
                <form action="datSan/taoLichDat" method="POST" style="margin: 0;">
                    <input type="hidden" name="idSanBong" value="<%= sb.getId() %>">
                    <input type="hidden" name="timestamp" class="hidden-timestamp-datSan" >
                    <button type="submit" class="bg-blue-600 text-white px-3 py-1 rounded hover:bg-blue-700">Đặt sân</button>
                </form>
            </li>
            <%
                        }
                    }
                }
            %>
        </ul>
    </div>
</div>


<script>


    $('#search-button').click(function() {


        // Gán giá trị timestamp vào input ẩn trong form
        $('#hidden-timestamp').val(getTimeStamp());
        $('.hidden-timestamp-datSan').val(getTimeStamp());

        // Gửi form
        event.preventDefault();
        $('#booking-form').submit();
    });

    $(document).on('submit', 'form[action="datSan/taoLichDat"]', function (e) {
        const timestamp = getTimeStamp();
        if (!timestamp) {
            e.preventDefault();
            return;
        }
        $(this).find('.hidden-timestamp-datSan').val(timestamp);
    });
    // Các khung giờ có sẵn cho phép đặt
    const availableHours = [6, 7, 8, 9, 15, 16, 17, 18, 19, 20];

    function getTimeStamp(){
        let selectedDate = $('#datepicker').val();
        let selectedHour = $('#select-hour').val();

        if (!selectedDate || !selectedHour) {
            alert("Vui lòng chọn ngày và giờ.");
            return;
        }

        // Tạo timestamp đầy đủ theo định dạng "YYYY-MM-DD HH:MM:00"
        const fullTimestamp = `${selectedDate} ${selectedHour}:00:00`;
        return fullTimestamp;

    }
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
        // hoursDropdown.change(function() {
        //     let selectedHour = $(this).val();
        //     loadAvailableFields(date, selectedHour);
        // });
    }

    // Hàm tải danh sách sân có sẵn cho giờ đã chọn
    <%--function loadAvailableFields(date, hour) {--%>
    <%--    const fullTimestamp = `${date} ${hour}:00:00`; // VD: 2025-05-08 15:00:00--%>

    <%--    console.log(`Timestamp chuẩn: ${fullTimestamp}`); // Kiểm tra timestamp chuẩn--%>
    <%--    $.ajax({--%>
    <%--        url: 'sanBong/getAvailableFields', // Backend Servlet hoặc Controller--%>
    <%--        type: 'POST',--%>
    <%--        data: { timestamp: fullTimestamp }, // gửi timestamp chuẩn--%>
    <%--        success: function(response) {--%>
    <%--            let fieldsList = $('#available-fields');--%>
    <%--            fieldsList.empty();--%>

    <%--            if (response.fields.length === 0) {--%>
    <%--                fieldsList.append('<li>Không có sân trống vào giờ này.</li>');--%>
    <%--            } else {--%>
    <%--                response.fields.forEach(field => {--%>
    <%--                    fieldsList.append(`--%>
    <%--                    <li class="border p-2 mb-2 flex justify-between items-center">--%>
    <%--                        <span>${field.name}</span>--%>
    <%--                        <button class="bg-blue-500 text-white px-4 py-1 rounded">Đặt sân</button>--%>
    <%--                    </li>--%>
    <%--                `);--%>
    <%--                });--%>
    <%--            }--%>
    <%--        }--%>
    <%--    });--%>
    <%--}--%>


//     load giờ đã chọn sau khi reload
    window.addEventListener('DOMContentLoaded', () => {
        const selectedTime = '<%= selectedTime != null ? selectedTime : "" %>';
        if (selectedTime) {
            // Parse từ dạng: "2025-05-23 06:00:00.0"
            const parts = selectedTime.split(" ");
            if (parts.length >= 2) {
                const dateStr = parts[0]; // "2025-05-23"
                const timeStr = parts[1].substring(0, 5); // "06:00"

                // Gán lại ngày
                const datepicker = document.getElementById("datepicker");
                if (datepicker) {
                    datepicker.value = dateStr;

                    // Gọi lại sự kiện change nếu bạn có logic load giờ khi đổi ngày
                    datepicker.dispatchEvent(new Event("change"));
                }

                // Gán lại giờ
                const selectHour = document.getElementById("select-hour");
                if (selectHour) {
                    for (let i = 0; i < selectHour.options.length; i++) {
                        if (selectHour.options[i].value === timeStr) {
                            selectHour.options[i].selected = true;
                            break;
                        }
                    }
                }
            }
        }
    });
</script>
</body>
</html>


