<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách khách hàng</title>
</head>
<body>
<div class="container">
    <div class="header">
        <h1> Quản lý khách hàng</h1>
        <p>Danh sách tổng hợp thông tin khách hàng</p>
    </div>

    <div class="controls">
        <div class="search-box">
            <input type="text" placeholder="Tìm kiếm khách hàng..." id="searchInput">
            <span class="search-icon">🔍</span>
        </div>
        <div style="display: flex; gap: 10px; flex-wrap: wrap;">
            <button class="btn btn-success">
                ➕ Thêm khách hàng
            </button>
            <button class="btn btn-primary">
                📊 Xuất báo cáo
            </button>
        </div>
    </div>

    <div class="table-container">
        <table class="customer-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Họ và tên</th>
                <th>Email</th>
                <th>Số điện thoại</th>
                <th>Địa chỉ</th>
                <th>Ngày tạo</th>
                <th>Trạng thái</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody id="customerTableBody">
            <tr>
                <td>001</td>
                <td>DENDY XAYSONGKHAM</td>
                <td>Denny2004@gmail.com</td>
                <td>0123456789</td>
                <td> Đường 60 Ngô sĩ liên, Quận 1, TP.ĐN</td>
                <td>15/03/2024</td>
                <td><span class="status active">Hoạt động</span></td>
                <td class="actions">
                    <button class="btn btn-info btn-sm">👁️ Xem</button>
                    <button class="btn btn-warning btn-sm">✏️ Sửa</button>
                    <button class="btn btn-danger btn-sm">🗑️ Xóa</button>
                </td>
            </tr>
            <tr>
                <td>002</td>
                <td>BOUNYOUNG CHANTHANA</td>
                <td>BOUN33@gmail.com</td>
                <td>0987654321</td>
                <td>456 Đường tôn đức thắng, Quận 2, TP.ĐN</td>
                <td>20/03/2024</td>
                <td><span class="status pending">Chờ duyệt</span></td>
                <td class="actions">
                    <button class="btn btn-info btn-sm">👁️ Xem</button>
                    <button class="btn btn-warning btn-sm">✏️ Sửa</button>
                    <button class="btn btn-danger btn-sm">🗑️ Xóa</button>
                </td>
            </tr>
            <tr>
                <td>003</td>
                <td>CHAISANA PHIYAVONG</td>
                <td>Chai@gmail.com</td>
                <td>0369258147</td>
                <td>Ngô văn sở , Quận 3, TP.ĐN</td>
                <td>25/03/2024</td>
                <td><span class="status active">Hoạt động</span></td>
                <td class="actions">
                    <button class="btn btn-info btn-sm">👁️ Xem</button>
                    <button class="btn btn-warning btn-sm">✏️ Sửa</button>
                    <button class="btn btn-danger btn-sm">🗑️ Xóa</button>
                </td>
            </tr>
            <tr>
                <td>004</td>
                <td>LATSADA NITTNANON</td>
                <td>Latsada@gmail.com</td>
                <td>0741258963</td>
                <td>Vũ ngọc phan, Quận 4, TP.ĐN</td>
                <td>28/03/2024</td>
                <td><span class="status inactive">Tạm khóa</span></td>
                <td class="actions">
                    <button class="btn btn-info btn-sm">👁️ Xem</button>
                    <button class="btn btn-warning btn-sm">✏️ Sửa</button>
                    <button class="btn btn-danger btn-sm">🗑️ Xóa</button>
                </td>
            </tr>
            <tr>
                <td>005</td>
                <td>HATSAPHONE THILAVONG</td>
                <td>Hatsaphone@gmail.com</td>
                <td>0852741963</td>
                <td>Đường Ngô thì nhậm, Quận 5, TP.ĐN</td>
                <td>01/04/2024</td>
                <td><span class="status active">Hoạt động</span></td>
                <td class="actions">
                    <button class="btn btn-info btn-sm">👁️ Xem</button>
                    <button class="btn btn-warning btn-sm">✏️ Sửa</button>
                    <button class="btn btn-danger btn-sm">🗑️ Xóa</button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>

    <div class="pagination">
        <button>⏮️ Đầu</button>
        <button>⏪ Trước</button>
        <button class="active">1</button>
        <button>2</button>
        <button>3</button>
        <button>⏩ Sau</button>
        <button>⏭️ Cuối</button>
    </div>

    <div class="stats">
        <div class="stat-item">
            <div class="stat-number">2,324</div>
            <div class="stat-label">Tổng khách hàng</div>
        </div>
        <div class="stat-item">
            <div class="stat-number">1,398</div>
            <div class="stat-label">Đang hoạt động</div>
        </div>
        <div class="stat-item">
            <div class="stat-number">200</div>
            <div class="stat-label">Chờ duyệt</div>
        </div>
        <div class="stat-item">
            <div class="stat-number">255</div>
            <div class="stat-label">Tạm khóa</div>
        </div>
    </div>
</div>

<script>
    // Tìm kiếm khách hàng
    document.getElementById('searchInput').addEventListener('input', function(e) {
        const searchTerm = e.target.value.toLowerCase();
        const tableRows = document.querySelectorAll('#customerTableBody tr');

        tableRows.forEach(row => {
            const text = row.textContent.toLowerCase();
            if (text.includes(searchTerm)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });

    // Xử lý click các nút thao tác
    document.addEventListener('click', function(e) {
        if (e.target.classList.contains('btn-info')) {
            alert('Xem chi tiết khách hàng');
        } else if (e.target.classList.contains('btn-warning')) {
            alert('Chỉnh sửa thông tin khách hàng');
        } else if (e.target.classList.contains('btn-danger')) {
            if (confirm('Bạn có chắc chắn muốn xóa khách hàng này?')) {
                alert('Đã xóa khách hàng');
            }
        }
    });

    // Hiệu ứng hover cho các hàng
    document.querySelectorAll('#customerTableBody tr').forEach(row => {
        row.addEventListener('mouseenter', function() {
            this.style.boxShadow = '0 5px 15px rgba(0,0,0,0.1)';
        });

        row.addEventListener('mouseleave', function() {
            this.style.boxShadow = 'none';
        });
    });
</script>