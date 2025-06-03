<%@ page import="model.*" import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Chỉnh Sửa Lịch Đặt</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
</head>
<body class="bg-gray-100">

<%-- Navbar --%>
<%@ include file="navbar.jsp" %>



<div class="max-w-3xl mx-auto bg-white shadow-md p-6 mt-6 rounded">
  <h2 class="text-2xl font-bold mb-4">Chỉnh Sửa Lịch Đặt Của Tôi</h2>
  <%
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
    datSan ds = (datSan) request.getAttribute("lichDat");
    if (ds == null) {


      response.sendRedirect(request.getContextPath() + "/nguoiDung/lichDatCuaToi");
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


  <!-- Chọn ngày -->
  <div class="mb-4">
    <label class="block text-gray-700">Chọn ngày:</label>
    <input type="text" id="datepicker" name="ngay" class="w-full px-3 py-2 border rounded" />
  </div>

  <!-- Chọn giờ bắt đầu -->
  <div class="mb-4">
    <label class="block text-gray-700">Giờ bắt đầu:</label>
    <select id="start-hour" name="startHour" class="w-full px-3 py-2 border rounded"></select>
  </div>

  <!-- Chọn giờ kết thúc -->
  <div class="mb-4">
    <label class="block text-gray-700">Giờ kết thúc:</label>
    <select id="end-hour" name="endHour" class="w-full px-3 py-2 border rounded"></select>
  </div>

  <!-- Chọn sân -->
  <div class="mb-4">
    <label class="block text-gray-700">Chọn sân:</label>
    <select name="idSanBong" id="idSanBongSelect" class="w-full px-3 py-2 border rounded">
      <%
        List<sanBong> sanBongCungKieu = (List<sanBong>) request.getAttribute("sanBongCungKieu");
        if (sanBongCungKieu != null) {
          for (sanBong sb : sanBongCungKieu) {
      %>
      <option value="<%= sb.getId() %>"><%= sb.getTenSan() %></option>
      <%
          }
        }
      %>
    </select>
  </div>

  <!-- Submit -->
  <div class="mb-4">
    <form action="<%= request.getContextPath() %>/datSan/capNhatLichDatCuaToi" method="post">
        <input type="hidden" name="idDatSan" value="<%= ds.getId() %>">
        <input type="hidden" name="idSanBong" id="hidden-idSanBong" >
      <input type="hidden" name="timestampStart" id="hidden-timestamp-start">
      <input type="hidden" name="timestampEnd" id="hidden-timestamp-end">
      <button type="submit" onclick="return prepareSubmit()"
              class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">Lưu Thay Đổi
      </button>
    </form>
  </div>
</div>

<script>
  const availableStartHour = [6, 7, 8, 9, 15, 16, 17, 18, 19, 20];
  const availableEndHour =[7,8,9,10,16,17,18,19,20,21]
  $('#idSanBongSelect').on('change', function () {
    const selectedId = $(this).val();
    $('#hidden-idSanBong').val(selectedId);
  });

  function loadStartHours(dateStr) {
    const today = new Date();
    const selectedDate = new Date(dateStr);
    let nowHour = today.getHours();

    $('#start-hour').empty();
    availableStartHour.forEach(hour => {
      if (selectedDate.toDateString() !== today.toDateString() || hour > nowHour) {
        $('#start-hour').append(`<option value="${hour}:00">${hour}:00</option>`);
      }
    });
    $('#start-hour').trigger('change'); // Load giờ kết thúc tương ứng
  }

  function loadEndHours(start) {
    const startHour = parseInt(start.split(":")[0]);
    $('#end-hour').empty();
    availableEndHour.forEach(hour => {
      if (hour > startHour) {
        $('#end-hour').append(`<option value="${hour}:00">${hour}:00</option>`);
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

  // Khởi tạo ngày
  flatpickr("#datepicker", {
    dateFormat: "Y-m-d",
    minDate: "today",
    onChange: function(selectedDates, dateStr) {
      loadStartHours(dateStr);
    }
  });

  // Khi chọn giờ bắt đầu, cập nhật giờ kết thúc tương ứng
  $('#start-hour').on('change', function () {
    const selectedStart = $(this).val();
    if (selectedStart) {
      loadEndHours(selectedStart);
    }
  });

  const initialDate = "<%= ngay %>";
  const initialStart = "<%= gioBD %>";
  const initialEnd = "<%= gioKT %>";

  $('#datepicker').val(initialDate);
  loadStartHours(initialDate);

  setTimeout(() => {
    $('#start-hour').val(initialStart).trigger('change');
    setTimeout(() => {
      $('#end-hour').val(initialEnd);
    }, 100);
  }, 100);
</script>

</body>
</html>
