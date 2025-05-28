<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thông tin cá nhân</title>
</head>
<body>
<div class="profile-container">
    <h2>Thông tin cá nhân</h2>
    <div class="info-item">
        <label>Gmail:</label>
        <span id="gmail">nguoimau@gmail.com</span>
    </div>
    <div class="info-item">
        <label>Họ tên:</label>
        <span id="hoten">HATSAPHONE</span>
    </div>
    <div class="info-item">
        <label>Ngày sinh:</label>
        <span id="ngaysinh">2000/01/01</span>
    </div>
    <div class="info-item">
        <label>Vai trò:</label>
        <span id="vaitro">Sinh viên</span>
    </div>
    <button class="edit-button" onclick="toggleEdit()">Chỉnh sửa</button>
</div>

<script>
    let isEditing = false;

    function toggleEdit() {
        const button = document.querySelector('.edit-button');
        const fields = ['gmail', 'hoten', 'ngaysinh', 'vaitro'];

        if (!isEditing) {
            fields.forEach(id => {
                const span = document.getElementById(id);
                const value = span.textContent;
                const inputType = id === 'gmail' ? 'email' : (id === 'ngaysinh' ? 'date' : 'text');
                span.outerHTML = `<input type="${inputType}" id="${id}" value="${value}">`;
            });
            button.textContent = 'Lưu';
            isEditing = true;
        } else {
            fields.forEach(id => {
                const input = document.getElementById(id);
                const value = input.value;
                input.outerHTML = `<span id="${id}">${value}</span>`;
            });
            button.textContent = 'Chỉnh sửa';
            isEditing = false;
        }
    }
</script>
</body>
</html>
