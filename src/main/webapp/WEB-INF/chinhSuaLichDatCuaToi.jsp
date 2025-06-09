<%@ page import="model.*" import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Chỉnh Sửa Lịch Đặt</title>
  <link rel="stylesheet" href="modern-style.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
</head>
<body>

<%-- Navbar --%>
<%@ include file="navbar.jsp" %>

<div class="page-header">
  <div class="container">
    <h1 class="page-title">Chỉnh Sửa Lịch Đặt</h1>
    <p class="page-subtitle">Cập nhật thông tin lịch đặt sân của bạn</p>
  </div>
</div>

<%--&lt;%&ndash; Hiển thị thông báo lỗi nếu có &ndash;%&gt;--%>
<%--<% String error = (String) request.getAttribute("error");--%>
<%--  if(error == null){--%>
<%--    error = (String) session.getAttribute("error");--%>
<%--  }%>--%>
<%--<% if (error != null) {--%>
<%--  session.removeAttribute("error"); // Xóa sau khi hiển thị--%>
<%--%>--%>
<%--<div class="error-message">--%>
<%--  <i class="fas fa-exclamation-triangle"></i> <%= error %>--%>
<%--</div>--%>
<%--<% } %>--%>

<div class="container" style="max-width: 800px; margin: 0 auto; padding: 0 2rem;">
  <%
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
    datSan ds = (datSan) request.getAttribute("lichDat");
    if (ds == null) {
      response.sendRedirect(request.getContextPath() + "/datSan/tatCaLichDat");
      return;
    }
    String gioBatDau = sdf.format(ds.getGioBatDau());
    String gioKetThuc = sdf.format(ds.getGioKetThuc());

    System.out.println("GioBatDau ở trang chinhSuaLichDatCuaToi: " + gioBatDau);
    System.out.println("GioKetThuc ở trang chinhSuaLichDatCuaToi: " + gioKetThuc);
    String ngay = gioBatDau.substring(0, 10);       // yyyy-MM-dd
    String gioBD = gioBatDau.substring(11, 16);     // HH:mm
    String gioKT = gioKetThuc.substring(11, 16);    // HH:mm

    System.out.println("Ngày: " + ngay);
    System.out.println("Giờ bắt đầu: " + gioBD);
    System.out.println("Giờ kết thúc: " + gioKT);
  %>

  <div class="modern-form fade-in">
    <div class="modern-card-header">
      <h2 class="modern-card-title">Thông tin đặt sân</h2>
    </div>

    <%-- Hiển thị thông báo lỗi nếu có --%>
    <% String error = (String) request.getAttribute("error");
      if(error == null){
        error = (String) session.getAttribute("error");
      }%>
    <% if (error != null) {
      session.removeAttribute("error"); // Xóa sau khi hiển thị
    %>
    <div class="error-message">
      <i class="fas fa-exclamation-triangle"></i> <%= error %>
    </div>
    <% } %>

    <!-- Chọn ngày -->
    <div class="modern-form-group">
      <label class="modern-form label">Chọn ngày:</label>
      <input type="text" id="datepicker" name="ngay" class="modern-form input" />
    </div>

    <!-- Chọn giờ bắt đầu -->
    <div class="modern-form-group">
      <label class="modern-form label">Giờ bắt đầu:</label>
      <select id="start-hour" name="startHour" class="modern-form select"></select>
    </div>

    <!-- Chọn giờ kết thúc -->
    <div class="modern-form-group">
      <label class="modern-form label">Giờ kết thúc:</label>
      <select id="end-hour" name="endHour" class="modern-form select"></select>
    </div>

    <!-- Chọn sân -->
    <div class="modern-form-group">
      <label class="modern-form label">Chọn sân:</label>
      <select name="idSanBong" id="idSanBongSelect" class="modern-form select">
        <%
          List<sanBong> sanBongCungKieu = (List<sanBong>) request.getAttribute("sanBongCungKieu");
          if (sanBongCungKieu != null) {
            for (sanBong sb : sanBongCungKieu) {
              boolean isSelected = Objects.equals(sb.getId(), ds.getIdSanBong());
        %>
<%--        <option value="<%= sb.getId() %>"><%= sb.getTenSan() %></option>--%>
        <option value="<%= sb.getId() %>" <%= isSelected ? "selected" : "" %>><%= sb.getTenSan() %></option>
        <%
            }
          }
        %>
      </select>
    </div>

    <!-- Submit -->
    <div class="modern-form-group">
      <form action="<%= request.getContextPath() %>/datSan/capNhatLichDatCuaToi" method="post">
        <input type="hidden" name="idDatSan" value="<%= ds.getId() %>">
        <input type="hidden" name="idSanBong" id="hidden-idSanBong" >
        <input type="hidden" name="timestampStart" id="hidden-timestamp-start">
        <input type="hidden" name="timestampEnd" id="hidden-timestamp-end">
        <button type="submit" onclick="return prepareSubmit()"
                class="btn-modern btn-primary">
          <i class="fas fa-save"></i>
          Lưu Thay Đổi
        </button>
      </form>
    </div>
  </div>
</div>

<%--footer--%>
<%@include file="footer.jsp" %>


<%--&lt;%&ndash;v1&ndash;%&gt;--%>
<%--<script>--%>
<%--  const availableStartHour = [6, 7, 8, 9, 15, 16, 17, 18, 19, 20];--%>
<%--  const availableEndHour =[7,8,9,10,16,17,18,19,20,21]--%>
<%--  $('#idSanBongSelect').on('change', function () {--%>
<%--    const selectedId = $(this).val();--%>
<%--    $('#hidden-idSanBong').val(selectedId);--%>
<%--  });--%>



<%--  //v1--%>
<%--  function loadStartHours(dateStr) {--%>
<%--    const today = new Date();--%>
<%--    const selectedDate = new Date(dateStr);--%>
<%--    let nowHour = today.getHours();--%>

<%--    $('#start-hour').empty();--%>
<%--    availableStartHour.forEach(hour => {--%>
<%--      if (selectedDate.toDateString() !== today.toDateString() || hour > nowHour) {--%>
<%--        $('#start-hour').append(`<option value="${hour}:00">${hour}:00</option>`);--%>
<%--      }--%>
<%--    });--%>
<%--    $('#start-hour').trigger('change'); // Load giờ kết thúc tương ứng--%>
<%--  }--%>

<%--  function loadEndHours(start) {--%>
<%--    const startHour = parseInt(start.split(":")[0]);--%>
<%--    $('#end-hour').empty();--%>
<%--    availableEndHour.forEach(hour => {--%>
<%--      if(startHour <= 9){ //nếu giờ bắt đầu là buổi sáng, chỉ cho chọn giờ kết thúc là buổi sáng--%>
<%--      if (hour > startHour && hour <= 10) {--%>
<%--        $('#end-hour').append(`<option value="${hour}:00">${hour}:00</option>`);--%>
<%--      }}--%>
<%--      else--%>
<%--        if (hour > startHour && hour <= 21) { //nếu giờ bắt đầu là buổi chiều, chỉ cho chọn giờ kết thúc là buổi chiều--%>
<%--            $('#end-hour').append(`<option value="${hour}:00">${hour}:00</option>`);--%>
<%--        }--%>
<%--    });--%>
<%--  }--%>



<%--  &lt;%&ndash;//v2&ndash;%&gt;--%>
<%--  &lt;%&ndash;$(document).ready(function () {&ndash;%&gt;--%>
<%--  &lt;%&ndash;  const initialDate = "<%= ngay %>";&ndash;%&gt;--%>
<%--  &lt;%&ndash;  const initialStart = "<%= gioBD %>";&ndash;%&gt;--%>
<%--  &lt;%&ndash;  const initialEnd = "<%= gioKT %>";&ndash;%&gt;--%>
<%--  --%>
<%--  &lt;%&ndash;  $('#datepicker').val(initialDate);&ndash;%&gt;--%>
<%--  --%>
<%--  &lt;%&ndash;  // Gọi loadStartHours với cả giá trị mặc định giờ bắt đầu và kết thúc&ndash;%&gt;--%>
<%--  &lt;%&ndash;  loadStartHours(initialDate, initialStart, initialEnd);&ndash;%&gt;--%>
<%--  &lt;%&ndash;});&ndash;%&gt;--%>
<%--  &lt;%&ndash;function loadStartHours(dateStr, selectedStart = null, selectedEnd = null) {&ndash;%&gt;--%>
<%--  &lt;%&ndash;  const today = new Date();&ndash;%&gt;--%>
<%--  &lt;%&ndash;  const selectedDate = new Date(dateStr);&ndash;%&gt;--%>
<%--  &lt;%&ndash;  const nowHour = today.getHours();&ndash;%&gt;--%>
<%--  --%>
<%--  &lt;%&ndash;  const $startHour = $('#start-hour');&ndash;%&gt;--%>
<%--  &lt;%&ndash;  $startHour.empty();&ndash;%&gt;--%>
<%--  --%>
<%--  &lt;%&ndash;  // Gán danh sách giờ bắt đầu&ndash;%&gt;--%>
<%--  &lt;%&ndash;  availableStartHour.forEach(hour => {&ndash;%&gt;--%>
<%--  &lt;%&ndash;    if (selectedDate.toDateString() !== today.toDateString() || hour > nowHour) {&ndash;%&gt;--%>
<%--  &lt;%&ndash;      const value = `${hour}:00`;&ndash;%&gt;--%>
<%--  &lt;%&ndash;      $startHour.append(`<option value="${value}" ${selectedStart == value ? "selected" : ""}>${value}</option>`);&ndash;%&gt;--%>
<%--  &lt;%&ndash;    }&ndash;%&gt;--%>
<%--  &lt;%&ndash;  });&ndash;%&gt;--%>
<%--  --%>
<%--  &lt;%&ndash;  // Nếu có giờ bắt đầu mặc định, thì gán giờ kết thúc tương ứng&ndash;%&gt;--%>
<%--  &lt;%&ndash;  const currentStart = selectedStart || $startHour.val();&ndash;%&gt;--%>
<%--  &lt;%&ndash;  if (currentStart) {&ndash;%&gt;--%>
<%--  &lt;%&ndash;    loadEndHours(currentStart, selectedEnd);&ndash;%&gt;--%>
<%--  &lt;%&ndash;  }&ndash;%&gt;--%>
<%--  &lt;%&ndash;}&ndash;%&gt;--%>
<%--  --%>
<%--  --%>
<%--  &lt;%&ndash;function loadEndHours(start, selectedEnd = null) {&ndash;%&gt;--%>
<%--  &lt;%&ndash;  const startHour = parseInt(start.split(":")[0]);&ndash;%&gt;--%>
<%--  &lt;%&ndash;  const $endHour = $('#end-hour');&ndash;%&gt;--%>
<%--  &lt;%&ndash;  $endHour.empty();&ndash;%&gt;--%>
<%--  --%>
<%--  &lt;%&ndash;  availableEndHour.forEach(hour => {&ndash;%&gt;--%>
<%--  &lt;%&ndash;    const value = `${hour}:00`;&ndash;%&gt;--%>
<%--  &lt;%&ndash;    const validMorning = startHour <= 9 && hour > startHour && hour <= 10;&ndash;%&gt;--%>
<%--  &lt;%&ndash;    const validAfternoon = startHour > 9 && hour > startHour && hour <= 21;&ndash;%&gt;--%>
<%--  --%>
<%--  &lt;%&ndash;    if (validMorning || validAfternoon) {&ndash;%&gt;--%>
<%--  &lt;%&ndash;      $endHour.append(`<option value="${value}" ${selectedEnd == value ? "selected" : ""}>${value}</option>`);&ndash;%&gt;--%>
<%--  &lt;%&ndash;    }&ndash;%&gt;--%>
<%--  &lt;%&ndash;  });&ndash;%&gt;--%>
<%--  &lt;%&ndash;}&ndash;%&gt;--%>
<%--  --%>
<%--  &lt;%&ndash;$('#datepicker').on('change', function () {&ndash;%&gt;--%>
<%--  &lt;%&ndash;  const dateStr = $(this).val();&ndash;%&gt;--%>
<%--  &lt;%&ndash;  loadStartHours(dateStr); // Không cần truyền giờ mặc định&ndash;%&gt;--%>
<%--  &lt;%&ndash;});&ndash;%&gt;--%>
<%--  --%>
<%--  &lt;%&ndash;//end of v2&ndash;%&gt;--%>






<%--  function prepareSubmit() {--%>
<%--    const date = $('#datepicker').val();--%>
<%--    const start = $('#start-hour').val();--%>
<%--    const end = $('#end-hour').val();--%>
<%--    const sanBongId = $('#idSanBongSelect').val();--%>

<%--    if (!date || !start || !end || !sanBongId) {--%>
<%--      alert("Vui lòng chọn đầy đủ ngày, giờ bắt đầu và giờ kết thúc.");--%>
<%--      return false;--%>
<%--    }--%>

<%--    $('#hidden-timestamp-start').val(`${date} ${start}:00`);--%>
<%--    $('#hidden-timestamp-end').val(`${date} ${end}:00`);--%>
<%--    $('#hidden-idSanBong').val(sanBongId);--%>
<%--    return true;--%>
<%--  }--%>

<%--  // Khởi tạo ngày--%>
<%--  flatpickr("#datepicker", {--%>
<%--    dateFormat: "Y-m-d",--%>
<%--    minDate: "today",--%>
<%--    onChange: function(selectedDates, dateStr) {--%>
<%--      loadStartHours(dateStr);--%>
<%--    }--%>
<%--  });--%>




<%--  //v1--%>
<%--  // Khi chọn giờ bắt đầu, cập nhật giờ kết thúc tương ứng--%>
<%--  $('#start-hour').on('change', function () {--%>
<%--    const selectedStart = $(this).val();--%>
<%--    if (selectedStart) {--%>
<%--      loadEndHours(selectedStart);--%>
<%--    }--%>
<%--  });--%>


<%--  // //v2--%>
<%--  // $('#start-hour').on('change', function () {--%>
<%--  //   const start = $(this).val();--%>
<%--  //   if (start) {--%>
<%--  //     loadEndHours(start);--%>
<%--  //   }--%>
<%--  // });--%>
<%--  //--%>
<%--  // //end of v2--%>

<%--  const initialDate = "<%= ngay %>";--%>
<%--  const initialStart = "<%= gioBD %>";--%>
<%--  const initialEnd = "<%= gioKT %>";--%>

<%--  $('#datepicker').val(initialDate);--%>
<%--  loadStartHours(initialDate);--%>

<%--  setTimeout(() => {--%>
<%--    $('#start-hour').val(initialStart).trigger('change');--%>
<%--    setTimeout(() => {--%>
<%--      $('#end-hour').val(initialEnd);--%>
<%--    }, 100);--%>
<%--  }, 100);--%>
<%--</script>--%>


<%--v2--%>
<script>
  const availableStartHour = [6, 7, 8, 9, 15, 16, 17, 18, 19, 20];
  const availableEndHour = [7, 8, 9, 10, 16, 17, 18, 19, 20, 21];

  function loadStartHours(dateStr, selectedStart = null, selectedEnd = null) {
    const today = new Date();
    const selectedDate = new Date(dateStr);
    const nowHour = today.getHours();

    const $startHour = $('#start-hour');
    $startHour.empty();

    console.log("Selected Date: " + selectedDate.toDateString());
    console.log("giờ bắt đầu: " + selectedStart);
    console.log("giờ kết thúc: " + selectedEnd);

    availableStartHour.forEach(hour => {
      if (selectedDate.toDateString() !== today.toDateString() || hour > nowHour) {
        <%--const value = `${hour}:00`;--%>
        const value = `${hour.toString().padStart(2, '0')}:00`;

        console.log("Adding start hour: " + value +" isMatch: " + (selectedStart === value));

        $startHour.append(`<option value="${value}" ${selectedStart == value ? "selected" : ""}>${value}</option>`);
      }
    });

    const currentStart = selectedStart || $startHour.val();
    if (currentStart) {
      loadEndHours(currentStart, selectedEnd);
    }
  }

  function loadEndHours(start, selectedEnd = null) {
    const startHour = parseInt(start.split(":")[0]);
    const $endHour = $('#end-hour');
    $endHour.empty();

    availableEndHour.forEach(hour => {
      const value = `${hour}:00`;
      const validMorning = startHour <= 9 && hour > startHour && hour <= 10;
      const validAfternoon = startHour > 9 && hour > startHour && hour <= 21;

      if (validMorning || validAfternoon) {
        $endHour.append(`<option value="${value}" ${selectedEnd == value ? "selected" : ""}>${value}</option>`);
      }
    });
  }

  function prepareSubmit() {
    const date = $('#datepicker').val();
    const start = $('#start-hour').val();
    const end = $('#end-hour').val();
    const sanBongId = $('#idSanBongSelect').val();

    if (!date || !start || !end || !sanBongId) {
      alert("Vui lòng chọn đầy đủ ngày, giờ bắt đầu và giờ kết thúc.");
      return false;
    }

    $('#hidden-timestamp-start').val(`${date} ${start}:00`);
    $('#hidden-timestamp-end').val(`${date} ${end}:00`);
    $('#hidden-idSanBong').val(sanBongId);
    return true;
  }

  $(document).ready(function () {
    const initialDate = "<%= ngay %>";
    const initialStart = "<%= gioBD %>";
    const initialEnd = "<%= gioKT %>";

    console.log("Initial Date: " + initialDate);
    console.log("Initial Start: " + initialStart);
    console.log("Initial End: " + initialEnd);


    $('#datepicker').val(initialDate);
    loadStartHours(initialDate, initialStart, initialEnd);

    $('#start-hour').on('change', function () {
      const start = $(this).val();
      if (start) loadEndHours(start);
    });

    $('#datepicker').on('change', function () {
      const dateStr = $(this).val();
      loadStartHours(dateStr); // Không truyền giờ mặc định
    });

    $('#idSanBongSelect').on('change', function () {
      const selectedId = $(this).val();
      $('#hidden-idSanBong').val(selectedId);
    });

    flatpickr("#datepicker", {
      dateFormat: "Y-m-d",
      minDate: "today",
      onChange: function (selectedDates, dateStr) {
        loadStartHours(dateStr);
      }
    });
  });
</script>


</body>
</html>
