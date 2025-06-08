<%@ page import="model.sanBong"  import="java.util.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt Sân - Modern</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern-style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <style>
        .booking-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        .booking-card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-md);
            padding: 2rem;
            margin-bottom: 2rem;
            animation: slideUp 0.6s ease-out;
        }

        .booking-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .booking-title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-blue);
            margin-bottom: 0.5rem;
        }

        .booking-subtitle {
            color: #64748b;
            font-size: 1rem;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .form-group {
            position: relative;
        }

        .form-label {
            display: block;
            font-weight: 600;
            color: var(--primary-blue);
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }

        .form-control {
            width: 100%;
            padding: 1rem;
            border: 2px solid #e2e8f0;
            border-radius: var(--border-radius);
            font-size: 1rem;
            transition: var(--transition);
            background: #f8fafc;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-blue);
            background: white;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        .search-btn {
            background: var(--gradient-primary);
            color: white;
            padding: 1rem 2rem;
            border: none;
            border-radius: var(--border-radius);
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin: 0 auto;
            box-shadow: var(--shadow-sm);
        }

        .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .fields-section {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-sm);
            padding: 2rem;
            animation: fadeIn 0.8s ease-out;
        }

        .fields-header {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 1.5rem;
            color: var(--primary-blue);
            font-weight: 600;
            font-size: 1.1rem;
        }

        .fields-list {
            display: grid;
            gap: 1rem;
        }

        .field-item {
            background: #f8fafc;
            border: 2px solid #e2e8f0;
            border-radius: var(--border-radius);
            padding: 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: var(--transition);
        }

        .field-item:hover {
            border-color: var(--primary-yellow);
            background: var(--light-yellow);
            transform: translateY(-2px);
            box-shadow: var(--shadow-sm);
        }

        .field-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .field-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: var(--gradient-primary);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
        }

        .field-details h4 {
            margin: 0 0 0.25rem 0;
            color: var(--primary-blue);
            font-weight: 600;
            font-size: 1.1rem;
        }

        .field-details p {
            margin: 0;
            color: #64748b;
            font-size: 0.9rem;
        }

        .book-btn {
            background: var(--gradient-secondary);
            color: var(--dark-blue);
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: var(--border-radius);
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            box-shadow: var(--shadow-sm);
        }

        .book-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .no-fields {
            text-align: center;
            padding: 3rem;
            color: #64748b;
        }

        .no-fields i {
            font-size: 3rem;
            color: var(--primary-yellow);
            margin-bottom: 1rem;
        }

        @media (max-width: 768px) {
            .booking-container {
                padding: 0 1rem;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .field-item {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }

            .field-info {
                flex-direction: column;
                text-align: center;
            }
        }
    </style>
</head>
<body>
<%
    String selectedTime = (String) request.getAttribute("selectedTime");
    String selectedTimeEnd = (String) request.getAttribute("selectedTimeEnd");
    String selectedHour = "";
    String selectedDate = "";
    String selectedEndHour="";
    if (selectedTime != null && selectedTime.contains(" ")) {
        selectedDate = selectedTime.split(" ")[0];
        selectedHour = selectedTime.split(" ")[1].substring(0, 5);
    }
    if (selectedTimeEnd != null && selectedTimeEnd.contains(" ")) {
        selectedEndHour = selectedTimeEnd.split(" ")[1].substring(0, 5);
    }
%>

<%@include file="navbar.jsp" %>

<div class="booking-container fade-in">
    <div class="booking-card">
        <div class="booking-header">
            <h2 class="booking-title">Đặt Sân Bóng</h2>
            <p class="booking-subtitle">Tìm kiếm và đặt sân bóng phù hợp với thời gian của bạn</p>
        </div>

        <div class="form-grid">
            <div class="form-group">
                <label class="form-label">
                    <i class="fas fa-calendar"></i> Chọn ngày
                </label>
                <input type="text" id="datepicker" class="form-control" placeholder="Chọn ngày đặt sân" />
            </div>

            <div class="form-group">
                <label class="form-label">
                    <i class="fas fa-clock"></i> Giờ bắt đầu
                </label>
                <select id="select-hour-start" class="form-control">
                    <option value="">Chọn giờ bắt đầu</option>
                </select>
            </div>

            <div class="form-group">
                <label class="form-label">
                    <i class="fas fa-clock"></i> Giờ kết thúc
                </label>
                <select id="selected-hour-end" class="form-control">
                    <option value="">Chọn giờ kết thúc</option>
                </select>
            </div>
        </div>

        <form id="booking-form" action="<%= request.getContextPath() %>/sanBong/danhSachSanCoSan" method="POST">
            <input type="hidden" name="timestamp" id="hidden-timestamp">
            <input type="hidden" name="timestampEnd" id="hidden-timestamp-end">
            <button type="button" id="search-button" class="search-btn">
                <i class="fas fa-search"></i>
                Tìm kiếm sân
            </button>
        </form>
    </div>

    <div class="fields-section">
        <div class="fields-header">
            <i class="fas fa-futbol"></i>
            Danh sách sân có sẵn
        </div>

        <div class="fields-list" id="available-fields">
            <%
                List<sanBong> availableFields = (List<sanBong>) request.getAttribute("availableFields");
                if (availableFields != null) {
                    if (availableFields.isEmpty()) {
            %>
            <div class="no-fields">
                <i class="fas fa-search"></i>
                <h3>Không có sân nào khả dụng</h3>
                <p>Vui lòng thử chọn thời gian khác hoặc liên hệ với chúng tôi để được hỗ trợ.</p>
            </div>
            <%
            } else {
                for (sanBong sb : availableFields) {
            %>
            <div class="field-item">
                <div class="field-info">
                    <div class="field-icon">
                        <i class="fas fa-futbol"></i>
                    </div>
                    <div class="field-details">
                        <h4><%= sb.getTenSan() %></h4>
                        <p><i class="fas fa-users"></i> Kiểu sân: <%= sb.getKieuSan().name().replace("_", " ") %></p>
                    </div>
                </div>
                <form action="<%=request.getContextPath()%>/datSan/taoLichDat" method="POST" style="margin: 0;">
                    <input type="hidden" name="idSanBong" value="<%= sb.getId() %>">
                    <input type="hidden" name="timestamp" class="hidden-timestamp-datSan" >
                    <input type="hidden" name="timestampEnd" class="hidden-timestamp-ketThuc">
                    <button type="submit" class="book-btn">
                        <i class="fas fa-calendar-plus"></i>
                        Đặt sân
                    </button>
                </form>
            </div>
            <%
                    }
                }
            } else {
            %>
            <div class="no-fields">
                <i class="fas fa-info-circle"></i>
                <h3>Chọn thời gian để xem sân</h3>
                <p>Vui lòng chọn ngày và giờ để tìm kiếm các sân bóng có sẵn.</p>
            </div>
            <%
                }
            %>
        </div>
    </div>
</div>

<%--footer--%>
<footer class="modern-footer">
    <div class="container">
        <div class="footer-grid">
            <div class="footer-section">
                <h3>Giới thiệu</h3>
                <p>Hệ thống quản lý sân bóng giúp người chơi dễ dàng tìm kiếm, đặt lịch và theo dõi tình trạng sân nhanh chóng, chính xác.</p>
            </div>
            <div class="footer-section">
                <h3>Thông tin liên hệ</h3>
                <p><i class="fas fa-envelope"></i> support@sanbongpro.vn</p>
                <p><i class="fas fa-map-marker-alt"></i> 123 Đường Bóng Đá, Quận Thể Thao, TP. Việt Nam</p>
                <p><i class="fas fa-phone"></i> 0123 456 789</p>
            </div>
            <div class="footer-section">
                <h3>Kết nối với chúng tôi</h3>
                <div style="display: flex; gap: 1rem; margin-top: 1rem;">
                    <a href="#" style="font-size: 1.5rem; color: var(--primary-yellow);"><i class="fab fa-facebook"></i></a>
                    <a href="#" style="font-size: 1.5rem; color: var(--primary-yellow);"><i class="fas fa-envelope"></i></a>
                    <a href="#" style="font-size: 1.5rem; color: var(--primary-yellow);"><i class="fab fa-tiktok"></i></a>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p>© 2025 SanBongPro.vn - All rights reserved.</p>
        </div>
    </div>
</footer>

<script>
    $('#search-button').click(function() {
        let endHour = $('#selected-hour-end').val();
        if (!endHour) {
            alert("Vui lòng chọn giờ kết thúc hợp lệ.");
            return;
        }

        $('#hidden-timestamp').val(getTimeStamp());
        $('#hidden-timestamp-end').val(getEndTimeStamp());

        $('.hidden-timestamp-datSan').val(getTimeStamp());
        $('.hidden-timestamp-ketThuc').val(getEndTimeStamp());

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

    const availableStartHour = [6, 7, 8, 9, 15, 16, 17, 18, 19, 20];
    const availableEndHour = [7, 8, 9, 10, 16, 17, 18, 19, 20, 21];

    function getTimeStamp(){
        let selectedDate = $('#datepicker').val();
        let selectedHour = $('#select-hour-start').val();

        if (!selectedDate || !selectedHour) {
            alert("Vui lòng chọn ngày và giờ.");
            return;
        }

        const fullTimestamp = `${selectedDate} ${selectedHour}:00:00`;
        return fullTimestamp;
    }

    function getEndTimeStamp() {
        let selectedDate = $('#datepicker').val();
        let endHour = $('#selected-hour-end').val();
        if (!selectedDate || !endHour) {
            alert("Vui lòng chọn ngày và giờ kết thúc.");
            return null;
        }
        return `${selectedDate} ${endHour}:00:00`;
    }

    function getValidStartHour(currentHour, selectedDate) {
        const today = new Date();
        const targetDate = new Date(selectedDate);

        if (targetDate.toDateString() === today.toDateString()) {
            return availableStartHour.filter(hour => hour > currentHour);
        }

        return availableStartHour;
    }

    function getValidEndHour(currentHour, selectedDate) {
        const today = new Date();
        const targetDate = new Date(selectedDate);

        if (targetDate.toDateString() === today.toDateString()) {
            return availableEndHour.filter(hour => hour > currentHour);
        }

        return availableEndHour;
    }

    flatpickr("#datepicker", {
        dateFormat: "Y-m-d",
        minDate: "today",
        onChange: function(selectedDates, dateStr, instance) {
            loadAvailableHours(dateStr);
        }
    });

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

        setTimeout(() => updateEndHours(), 0);
    }

    $(document).ready(function () {
        const selectedDate = '<%= selectedDate %>';
        const selectedHour = '<%= selectedHour %>';
        const selectedEndHour = '<%= selectedEndHour %>';

        if (selectedDate) {
            $('#datepicker').val(selectedDate);
            loadAvailableHours(selectedDate, selectedHour);

            setTimeout(() => {
                $('#select-hour-start').val(parseInt(selectedHour.split(":")[0]));
            }, 100);
        }

        if (selectedEndHour) {
            setTimeout(() => {
                $('#selected-hour-end').val(parseInt(selectedEndHour.split(":")[0]));
            }, 200);
        }
    });

    window.addEventListener('DOMContentLoaded', () => {
        const selectedTime = '<%= selectedTime != null ? selectedTime : "" %>';
        if (selectedTime) {
            const parts = selectedTime.split(" ");
            if (parts.length >= 2) {
                const dateStr = parts[0];
                const timeStr = parts[1].substring(0, 5);

                const datepicker = document.getElementById("datepicker");
                if (datepicker) {
                    datepicker.value = dateStr;
                    datepicker.dispatchEvent(new Event("change"));
                }

                const selectHourStart = document.getElementById("select-hour-start");
                if (selectHourStart) {
                    for (let i = 0; i < selectHourStart.options.length; i++) {
                        if (selectHourStart.options[i].value === timeStr) {
                            selectHourStart.options[i].selected = true;
                            break;
                        }
                    }
                }

                updateEndHours();
            }
        }
    });

    $('#select-hour-start').on('change', function () {
        updateEndHours();
    });

    function updateEndHours() {
        const startHour = parseInt($('#select-hour-start').val());
        const selectedDate = $('#datepicker').val();
        const validHours = getValidEndHour(new Date().getHours(), selectedDate);

        let endDropdown = $('#selected-hour-end');
        endDropdown.empty();

        validHours.forEach(hour => {
            if (hour > startHour) {
                endDropdown.append(`<option value="${hour}">${hour}:00</option>`);
            }
        });

        if (endDropdown.children().length === 0) {
            endDropdown.append('<option disabled selected>Không có giờ kết thúc hợp lệ</option>');
        }
    }

    // Add animation to field items
    document.addEventListener('DOMContentLoaded', function() {
        const fieldItems = document.querySelectorAll('.field-item');
        fieldItems.forEach((item, index) => {
            item.style.opacity = '0';
            item.style.transform = 'translateY(20px)';
            item.style.transition = 'all 0.6s ease-out';

            setTimeout(() => {
                item.style.opacity = '1';
                item.style.transform = 'translateY(0)';
            }, index * 100);
        });
    });
</script>
</body>
</html>
