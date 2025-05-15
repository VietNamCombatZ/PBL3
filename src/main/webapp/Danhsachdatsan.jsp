<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt sân bóng</title>
</head>
<body>
<div class="container">
    <h2>Đặt sân bóng</h2>

    <div class="form-group">
        <label for="maSan">Mã sân</label>
        <input type="text" id="maSan" name="maSan" value="Sân A1" readonly>
    </div>

    <div class="form-group">
        <label for="thoiGian">Thời gian đặt</label>
        <input type="datetime-local" id="thoiGian" name="thoiGian">
    </div>

    <div class="form-group">
        <label>Dịch vụ bổ sung</label>
        <div class="checkbox-group">
            <input type="checkbox" id="nuoc" name="dichvu" value="nuoc">
            <label for="nuoc">Mua nước</label><br>

            <input type="checkbox" id="bia" name="dichvu" value="bia">
            <label for="bia">Mua bia</label>
        </div>
    </div>

    <div class="buttons">
        <button class="btn-cancel" onclick="window.history.back()">Quay lại</button>
        <button class="btn-confirm" onclick="xacNhanDatSan()">Xác nhận đặt sân</button>
    </div>
</div>

<script>
    function xacNhanDatSan() {
        const maSan = document.getElementById('maSan').value;
        const thoiGian = document.getElementById('thoiGian').value;
        const nuoc = document.getElementById('nuoc').checked;
        const bia = document.getElementById('bia').checked;

        let dv = [];
        if (nuoc) dv.push("Nước");
        if (bia) dv.push("Bia");

        alert(
            ` Bạn đã đặt sân: ${maSan}\n Thời gian: ${thoiGian}\n  Dịch vụ: ${dv.length > 0 ? dv.join(", ") : "Không"}`
        );
    }
</script>
</body>
</html>