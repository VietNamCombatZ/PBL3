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
<body class="bg-gray-100">
<%
    String selectedTime = (String) request.getAttribute("selectedTime");
    String selectedHour = "";
    String selectedDate = "";
    if (selectedTime != null && selectedTime.contains(" ")) {
        selectedDate = selectedTime.split(" ")[0];
        selectedHour = selectedTime.split(" ")[1].substring(0, 5); // ví dụ "06:00"
    }
%>
<%--navbar--%>
<%@include file="navbar.jsp" %>
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
        <select id="select-hour-start" class="w-full px-3 py-2 border rounded">
            <!-- Các giờ sẽ được load sau khi chọn ngày -->

        </select>
    </div>

    <!-- Chọn giờ kết thúc -->
    <div class="mb-4">
        <label class="block text-gray-700">Chọn giờ kết thúc:</label>
        <select id="selected-hour-end" class="w-full px-3 py-2 border rounded">
            <!-- Các giờ kết thúc sẽ được cập nhật theo giờ bắt đầu -->
        </select>
    </div>


    <!-- Nút Tìm kiếm -->
    <div class="mb-4">

        <form id="booking-form" action="<%= request.getContextPath() %>/sanBong/danhSachSanCoSan" method="POST">
            <input type="hidden" name="timestamp" id="hidden-timestamp">
            <input type="hidden" name="timestampEnd" id="hidden-timestamp-end">
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
                <form action="<%=request.getContextPath()%>/datSan/taoLichDat" method="POST" style="margin: 0;">
                    <input type="hidden" name="idSanBong" value="<%= sb.getId() %>">
                    <input type="hidden" name="timestamp" class="hidden-timestamp-datSan" >
                    <input type="hidden" name="timestampEnd" class="hidden-timestamp-ketThuc">
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
        // Lấy giá trị ngày đã chọn

        let endHour = $('#selected-hour-end').val();
        if (!endHour) {
            alert("Vui lòng chọn giờ kết thúc hợp lệ.");
            return;
        }



        // Gán giá trị timestamp vào input ẩn trong form
        $('#hidden-timestamp').val(getTimeStamp());
        $('#hidden-timestamp-end').val(getEndTimeStamp());
        $('.hidden-timestamp-datSan').val(getTimeStamp());
        $('.hidden-timestamp-ketThuc').val(getEndTimeStamp());

        // Gửi form
        event.preventDefault();
        $('#booking-form').submit();
    });

    $(document).on('submit', 'form[action="<%=request.getContextPath()%>/datSan/taoLichDat"]', function (e) {
        const timestampStart = getTimeStamp();
        if (!timestampStart) {
            e.preventDefault();
            return;
        }
        $(this).find('.hidden-timestamp-datSan').val(timestampStart);

        const timestampEnd = getEndTimeStamp();
        if (!timestampEnd) {
            e.preventDefault();
            return;
        }
        $(this).find('.hidden-timestamp-ketThuc').val(timestampEnd);
    });
    // Các khung giờ có sẵn cho phép đặt
    const availableStartHour = [6, 7, 8, 9, 15, 16, 17, 18, 19, 20];
    const availableEndHour = [7, 8, 9, 10, 16, 17, 18, 19, 20, 21];

    function getTimeStamp(){
        let selectedDate = $('#datepicker').val();
        let selectedHour = $('#select-hour-start').val();

        if (!selectedDate || !selectedHour) {
            alert("Vui lòng chọn ngày và giờ.");
            return;
        }

        // Tạo timestamp đầy đủ theo định dạng "YYYY-MM-DD HH:MM:00"
        const fullTimestamp = `${selectedDate} ${selectedHour}:00:00`;
        return fullTimestamp;

    }
    //

    function getEndTimeStamp() {
        let selectedDate = $('#datepicker').val();
        let endHour = $('#selected-hour-end').val();
        if (!selectedDate || !endHour) {
            alert("Vui lòng chọn ngày và giờ kết thúc.");
            return null;
        }
        return `${selectedDate} ${endHour}:00:00`;
    }

    // Kiểm tra ngày và lấy các giờ hợp lệ
    function getValidStartHour(currentHour, selectedDate) {
        const today = new Date();
        const targetDate = new Date(selectedDate);

        // Nếu ngày chọn là ngày hôm nay, chỉ cho phép chọn các khung giờ sau giờ hiện tại
        if (targetDate.toDateString() === today.toDateString()) {
            return availableStartHour.filter(hour => hour > currentHour);
        }

        // Nếu là ngày trong tương lai, cho phép chọn tất cả các khung giờ
        return availableStartHour;
    }

    function getValidEndHour(currentHour, selectedDate) {
        const today = new Date();
        const targetDate = new Date(selectedDate);

        // Nếu ngày chọn là ngày hôm nay, chỉ cho phép chọn các khung giờ sau giờ hiện tại
        if (targetDate.toDateString() === today.toDateString()) {
            return availableEndHour.filter(hour => hour > currentHour);
        }

        // Nếu là ngày trong tương lai, cho phép chọn tất cả các khung giờ
        return availableEndHour;
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
    function loadAvailableHours(date, selectedHour = null) {
        const currentDate = new Date();
        const currentHour = currentDate.getHours();

        const validHours = getValidStartHour(currentHour, date);
        let hoursDropdown = $('#select-hour-start');
        hoursDropdown.empty();

        validHours.forEach(hour => {
            const isSelected = selectedHour && hour == parseInt(selectedHour.split(":")[0]);
            hoursDropdown.append(`<option value="${hour}" ${isSelected ? "selected" : ""}>${hour}:00</option>`);
        });

        // Gọi cập nhật giờ kết thúc sau khi chọn giờ bắt đầu
        setTimeout(() => updateEndHours(), 0);
    }



    $(document).ready(function () {
        const selectedDate = '<%= selectedDate %>';
        const selectedHour = '<%= selectedHour %>';

        if (selectedDate) {
            $('#datepicker').val(selectedDate); // Gán lại ngày đã chọn
            loadAvailableHours(selectedDate, selectedHour);
            // Gọi lại load giờ

            // Đợi dropdown load xong rồi mới chọn giờ
            setTimeout(() => {
                $('#select-hour-start').val(parseInt(selectedHour.split(":")[0]));
            }, 100); // delay 100ms là đủ để dropdown load
        }
    });


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
                const selectHour = document.getElementById("select-hour-start");
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

    // Cập nhật dropdown giờ kết thúc khi chọn giờ bắt đầu
    $('#select-hour-start').on('change', function () {
        updateEndHours();
    });

    function updateEndHours() {
        const startHour = parseInt($('#select-hour-start').val());
        const selectedDate = $('#datepicker').val();
        const validHours = getValidEndHour(new Date().getHours(), selectedDate);

        let endDropdown = $('#selected-hour-end');
        endDropdown.empty();

        // Chỉ thêm các giờ > giờ bắt đầu
        validHours.forEach(hour => {
            if (hour > startHour) {
                endDropdown.append(`<option value="${hour}">${hour}:00</option>`);
            }
        });

        if (endDropdown.children().length === 0) {
            endDropdown.append('<option disabled selected>Không có giờ kết thúc hợp lệ</option>');
        }
    }

</script>
</body>
</html>


