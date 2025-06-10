<%@ page import="model.sanBong"  import="java.util.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đặt Sân - Nhân Viên</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="../css/modern-style.css" />
</head>
<body class="modern-bg">

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

<%@include file="navbar-nhanvien.jsp" %>

<div class="container mx-auto px-4 py-8">
  <!-- Header Section -->
  <div class="text-center mb-8">
    <div class="inline-flex items-center justify-center w-16 h-16 bg-gradient-to-r from-blue-500 to-blue-600 rounded-full mb-4">
      <i class="fas fa-calendar-plus text-white text-2xl"></i>
    </div>
    <h1 class="text-3xl font-bold text-gray-800 mb-2">Đặt sân cho khách hàng</h1>
    <p class="text-gray-600">Tìm kiếm và đặt sân bóng có sẵn theo thời gian</p>
  </div>

  <!-- Search Form -->
  <div class="modern-card mb-8">
    <h2 class="text-xl font-semibold text-gray-800 mb-6">
      <i class="fas fa-search mr-2"></i>Tìm kiếm sân có sẵn
    </h2>

    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
      <!-- Chọn ngày -->
      <div class="form-group">
        <label class="form-label">
          <i class="fas fa-calendar mr-2"></i>Chọn ngày
        </label>
        <input type="text" id="datepicker" class="form-input" placeholder="Chọn ngày đặt sân" />
      </div>

      <!-- Chọn giờ bắt đầu -->
      <div class="form-group">
        <label class="form-label">
          <i class="fas fa-clock mr-2"></i>Giờ bắt đầu
        </label>
        <select id="select-hour-start" class="form-input">
          <option value="">Chọn giờ bắt đầu</option>
        </select>
      </div>

      <!-- Chọn giờ kết thúc -->
      <div class="form-group">
        <label class="form-label">
          <i class="fas fa-clock mr-2"></i>Giờ kết thúc
        </label>
        <select id="selected-hour-end" class="form-input">
          <option value="">Chọn giờ kết thúc</option>
        </select>
      </div>
    </div>

    <!-- Search Button -->
    <div class="mt-6">
      <form id="booking-form" action="<%= request.getContextPath() %>/sanBong/danhSachSanCoSanNhanVien" method="POST">
        <input type="hidden" name="timestamp" id="hidden-timestamp">
        <input type="hidden" name="timestampEnd" id="hidden-timestamp-end">
        <button id="search-button" type="button" class="btn-primary w-full md:w-auto">
          <i class="fas fa-search mr-2"></i>
          Tìm kiếm sân có sẵn
        </button>
      </form>
    </div>
  </div>

  <!-- Available Fields -->
  <div class="modern-card">
    <h2 class="text-xl font-semibold text-gray-800 mb-6">
      <i class="fas fa-futbol mr-2"></i>Danh sách sân có sẵn
    </h2>

    <%
      List<sanBong> availableFields = (List<sanBong>) request.getAttribute("availableFields");
      if (availableFields != null) {
        if (availableFields.isEmpty()) {
    %>
    <div class="text-center py-12">
      <div class="w-24 h-24 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
        <i class="fas fa-calendar-times text-gray-400 text-3xl"></i>
      </div>
      <h3 class="text-lg font-medium text-gray-800 mb-2">Không có sân nào khả dụng</h3>
      <p class="text-gray-600">Không có sân nào có sẵn trong khoảng thời gian này. Vui lòng chọn thời gian khác.</p>
    </div>
    <%
    } else {
    %>
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      <%
        for (sanBong sb : availableFields) {
          String fieldTypeIcon = "";
          String fieldTypeColor = "";
          if (sb.getKieuSan().name().equals("SAN_5")) {
            fieldTypeIcon = "fas fa-users";
            fieldTypeColor = "text-blue-600";
          } else {
            fieldTypeIcon = "fas fa-user-friends";
            fieldTypeColor = "text-purple-600";
          }
      %>
      <div class="bg-white rounded-lg border border-gray-200 p-6 hover:shadow-lg transition-shadow">
        <div class="flex items-center justify-between mb-4">
          <div class="flex items-center space-x-3">
            <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center">
              <i class="fas fa-futbol text-green-600 text-xl"></i>
            </div>
            <div>
              <h3 class="font-semibold text-gray-800"><%= sb.getTenSan() %></h3>
              <div class="flex items-center space-x-1 text-sm text-gray-600">
                <i class="<%= fieldTypeIcon %> <%= fieldTypeColor %>"></i>
                <span><%= sb.getKieuSan().toVietnamese() %></span>
              </div>
            </div>
          </div>
          <span class="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-green-100 text-green-800">
            <i class="fas fa-check-circle mr-1"></i>
            Có sẵn
          </span>
        </div>

        <div class="border-t border-gray-200 pt-4">
          <form action="<%=request.getContextPath()%>/datSan/taoLichDatNhanVien" method="POST">
            <input type="hidden" name="idSanBong" value="<%= sb.getId() %>">
            <input type="hidden" name="timestamp" class="hidden-timestamp-datSan" >
            <input type="hidden" name="timestampEnd" class="hidden-timestamp-ketThuc">
            <button type="submit" class="btn-primary w-full">
              <i class="fas fa-calendar-plus mr-2"></i>
              Đặt sân này
            </button>
          </form>
        </div>
      </div>
      <%
        }
      %>
    </div>
    <%
      }
    } else {
    %>
    <div class="text-center py-12">
      <div class="w-24 h-24 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
        <i class="fas fa-search text-gray-400 text-3xl"></i>
      </div>
      <h3 class="text-lg font-medium text-gray-800 mb-2">Tìm kiếm sân bóng</h3>
      <p class="text-gray-600">Vui lòng chọn ngày và giờ để tìm kiếm sân có sẵn</p>
    </div>
    <%
      }
    %>
  </div>
</div>


<!-- Footer -->
<%@include file="footer.jsp" %>




<script>
  $(document).ready(function() {
    // Available hours
    const availableStartHour = [6, 7, 8, 9, 15, 16, 17, 18, 19, 20];
    const availableEndHour = [7, 8, 9, 10, 16, 17, 18, 19, 20, 21];

    // Initialize Flatpickr
    flatpickr("#datepicker", {
      dateFormat: "Y-m-d",
      minDate: "today",
      onChange: function(selectedDates, dateStr, instance) {
        loadAvailableHours(dateStr);
      }
    });

    // Load available hours based on selected date
    function loadAvailableHours(date, selectedHour = null) {
      const currentDate = new Date();
      const currentHour = currentDate.getHours();
      const validHours = getValidStartHour(currentHour, date);

      let hoursDropdown = $('#select-hour-start');
      hoursDropdown.empty();
      hoursDropdown.append('<option value="">Chọn giờ bắt đầu</option>');

      validHours.forEach(hour => {
        const isSelected = selectedHour && hour == parseInt(selectedHour.split(":")[0]);
        hoursDropdown.append(`<option value="${hour}" ${isSelected ? "selected" : ""}>${hour}:00</option>`);
      });

      setTimeout(() => updateEndHours(), 0);
    }

    // Get valid start hours
    function getValidStartHour(currentHour, selectedDate) {
      const today = new Date();
      const targetDate = new Date(selectedDate);

      if (targetDate.toDateString() === today.toDateString()) {
        return availableStartHour.filter(hour => hour > currentHour);
      }
      return availableStartHour;
    }

    // Get valid end hours
    function getValidEndHour(currentHour, selectedDate) {
      const today = new Date();
      const targetDate = new Date(selectedDate);

      if (targetDate.toDateString() === today.toDateString()) {
        return availableEndHour.filter(hour => hour > currentHour);
      }
      return availableEndHour;
    }

    // Update end hours when start hour changes
    $('#select-hour-start').on('change', function() {
      updateEndHours();
    });

    function updateEndHours() {
      const startHour = parseInt($('#select-hour-start').val());
      const selectedDate = $('#datepicker').val();
      const validHours = getValidEndHour(new Date().getHours(), selectedDate);

      let endDropdown = $('#selected-hour-end');
      endDropdown.empty();
      endDropdown.append('<option value="">Chọn giờ kết thúc</option>');

      validHours.forEach(hour => {
        if (hour > startHour) {
          endDropdown.append(`<option value="${hour}">${hour}:00</option>`);
        }
      });

      if (endDropdown.children().length === 1) {
        endDropdown.append('<option disabled>Không có giờ kết thúc hợp lệ</option>');
      }
    }

    // Get timestamp functions
    function getTimeStamp() {
      let selectedDate = $('#datepicker').val();
      let selectedHour = $('#select-hour-start').val();

      if (!selectedDate || !selectedHour) {
        return null;
      }
      return `${selectedDate} ${selectedHour}:00:00`;
    }

    function getEndTimeStamp() {
      let selectedDate = $('#datepicker').val();
      let endHour = $('#selected-hour-end').val();

      if (!selectedDate || !endHour) {
        return null;
      }
      return `${selectedDate} ${endHour}:00:00`;
    }

    // Search button click handler
    $('#search-button').click(function() {
      const startTime = getTimeStamp();
      const endTime = getEndTimeStamp();

      if (!startTime || !endTime) {
        // Show error notification
        const errorDiv = document.createElement('div');
        errorDiv.className = 'fixed top-4 right-4 bg-red-500 text-white px-6 py-3 rounded-lg shadow-lg z-50';
        errorDiv.innerHTML = '<i class="fas fa-exclamation-triangle mr-2"></i>Vui lòng chọn đầy đủ ngày và giờ';
        document.body.appendChild(errorDiv);

        setTimeout(() => {
          errorDiv.remove();
        }, 3000);
        return;
      }

      // Show loading state
      const originalText = this.innerHTML;
      this.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i>Đang tìm kiếm...';
      this.disabled = true;

      // Set hidden values and submit
      $('#hidden-timestamp').val(startTime);
      $('#hidden-timestamp-end').val(endTime);
      $('.hidden-timestamp-datSan').val(startTime);
      $('.hidden-timestamp-ketThuc').val(endTime);

      $('#booking-form').submit();
    });

    // Handle booking form submissions
    $(document).on('submit', 'form[action="<%=request.getContextPath()%>/datSan/taoLichDatNhanVien"]', function(e) {
      const timestampStart = getTimeStamp();
      const timestampEnd = getEndTimeStamp();

      if (!timestampStart || !timestampEnd) {
        e.preventDefault();
        return;
      }

      $(this).find('.hidden-timestamp-datSan').val(timestampStart);
      $(this).find('.hidden-timestamp-ketThuc').val(timestampEnd);

      // Show loading state
      const submitBtn = $(this).find('button[type="submit"]');
      const originalText = submitBtn.html();
      submitBtn.html('<i class="fas fa-spinner fa-spin mr-2"></i>Đang đặt...');
      submitBtn.prop('disabled', true);
    });

    // Load initial values if available
    const selectedDate = '<%= selectedDate %>';
    const selectedHour = '<%= selectedHour %>';
    const selectedEndHour = '<%= selectedEndHour %>';

    if (selectedDate) {
      $('#datepicker').val(selectedDate);
      loadAvailableHours(selectedDate, selectedHour);

      setTimeout(() => {
        if (selectedHour) {
          $('#select-hour-start').val(parseInt(selectedHour.split(":")[0]));
          updateEndHours();
        }
        if (selectedEndHour) {
          setTimeout(() => {
            $('#selected-hour-end').val(parseInt(selectedEndHour.split(":")[0]));
          }, 100);
        }
      }, 100);
    }
  });
</script>

</body>
</html>
