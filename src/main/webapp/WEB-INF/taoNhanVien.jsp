<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tạo nhân viên - Modern</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern-style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        .create-employee-container {
            max-width: 700px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        .create-employee-card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-md);
            overflow: hidden;
            animation: slideUp 0.6s ease-out;
        }

        .create-employee-header {
            background: var(--gradient-primary);
            color: white;
            padding: 2rem;
            text-align: center;
        }

        .employee-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: var(--gradient-secondary);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: var(--dark-blue);
            margin: 0 auto 1rem;
            border: 4px solid white;
            box-shadow: var(--shadow-md);
        }

        .create-employee-title {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .create-employee-subtitle {
            opacity: 0.9;
            font-size: 0.9rem;
        }

        .create-employee-form {
            padding: 2rem;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .form-group-full {
            grid-column: 1 / -1;
        }

        .role-selector {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-top: 0.5rem;
        }

        .role-option {
            position: relative;
        }

        .role-option input[type="radio"] {
            position: absolute;
            opacity: 0;
            width: 100%;
            height: 100%;
            margin: 0;
            cursor: pointer;
        }

        .role-label {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 1rem;
            border: 2px solid #e2e8f0;
            border-radius: var(--border-radius);
            background: #f8fafc;
            cursor: pointer;
            transition: var(--transition);
            font-weight: 500;
        }

        .role-option input[type="radio"]:checked + .role-label {
            border-color: var(--primary-blue);
            background: var(--light-blue);
            color: var(--primary-blue);
        }

        .role-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--gradient-primary);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1rem;
        }

        .role-option input[type="radio"]:checked + .role-label .role-icon {
            background: var(--gradient-secondary);
            color: var(--dark-blue);
        }

        .role-details h4 {
            margin: 0 0 0.25rem 0;
            font-size: 1rem;
        }

        .role-details p {
            margin: 0;
            font-size: 0.8rem;
            opacity: 0.7;
        }

        .password-strength {
            margin-top: 0.5rem;
            padding: 0.5rem;
            border-radius: var(--border-radius);
            font-size: 0.8rem;
            display: none;
        }

        .strength-weak {
            background: #fef2f2;
            color: #dc2626;
            border-left: 4px solid #ef4444;
        }

        .strength-medium {
            background: #fef3c7;
            color: #92400e;
            border-left: 4px solid #f59e0b;
        }

        .strength-strong {
            background: #dcfce7;
            color: #166534;
            border-left: 4px solid #22c55e;
        }

        .submit-btn {
            width: 100%;
            padding: 1rem;
            background: var(--gradient-secondary);
            color: var(--dark-blue);
            border: none;
            border-radius: var(--border-radius);
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            margin-top: 1rem;
            box-shadow: var(--shadow-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .submit-btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }

        @media (max-width: 768px) {
            .create-employee-container {
                padding: 0 1rem;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .role-selector {
                grid-template-columns: 1fr;
            }

            .create-employee-form {
                padding: 1.5rem;
            }

            .create-employee-header {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
<%@ include file="navbar-nhanvien.jsp" %>

<div class="create-employee-container fade-in">
    <a href="<%= request.getContextPath() %>/nguoiDung/DanhsachNhanVien" class="back-link">
        <i class="fas fa-arrow-left"></i>
        Quay lại danh sách nhân viên
    </a>

    <div class="create-employee-card">
        <div class="create-employee-header">
            <div class="employee-icon">
                <i class="fas fa-user-plus"></i>
            </div>
            <h1 class="create-employee-title">Tạo nhân viên mới</h1>
            <p class="create-employee-subtitle">Thêm nhân viên mới vào hệ thống quản lý</p>
        </div>

        <div class="create-employee-form">
            <% String thongBao = (String) request.getAttribute("error");
                if(thongBao == null){
                    thongBao = (String) session.getAttribute("error");
                }%>
            <% if (thongBao != null) { %>
            <div class="modern-alert alert-error">
                <i class="fas fa-exclamation-triangle"></i>
                <%= thongBao %>
            </div>
            <% } %>

            <form action="<%= request.getContextPath()%>/nguoiDung/taoNhanVien" method="post" id="createEmployeeForm">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="ten" class="form-label">
                            <i class="fas fa-user"></i> Họ và tên
                        </label>
                        <input type="text" id="ten" name="ten" class="form-input" placeholder="Nhập họ và tên" required />
                        <div class="error-message" id="tenError">Vui lòng nhập họ và tên hợp lệ</div>
                    </div>

                    <div class="form-group">
                        <label for="email" class="form-label">
                            <i class="fas fa-envelope"></i> Email
                        </label>
                        <input type="email" id="email" name="email" class="form-input" placeholder="Nhập địa chỉ email" required />
                        <div class="error-message" id="emailError">Vui lòng nhập email hợp lệ</div>
                    </div>
                </div>

                <div class="form-grid">
                    <div class="form-group">
                        <label for="matKhau" class="form-label">
                            <i class="fas fa-lock"></i> Mật khẩu
                        </label>
                        <input type="password" id="matKhau" name="matKhau" class="form-input" placeholder="Nhập mật khẩu" required />
                        <div class="password-strength" id="passwordStrength"></div>
                        <div class="error-message" id="matKhauError">Mật khẩu phải có ít nhất 6 ký tự</div>
                    </div>

                    <div class="form-group">
                        <label for="nhapLaiMatKhau" class="form-label">
                            <i class="fas fa-lock"></i> Nhập lại mật khẩu
                        </label>
                        <input type="password" id="nhapLaiMatKhau" name="nhapLaiMatKhau" class="form-input" placeholder="Nhập lại mật khẩu" required />
                        <div class="error-message" id="nhapLaiMatKhauError">Mật khẩu không khớp</div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="ngaySinh" class="form-label">
                        <i class="fas fa-calendar"></i> Ngày sinh
                    </label>
                    <input type="date" id="ngaySinh" name="ngaySinh" class="form-input" required />
                    <div class="error-message" id="ngaySinhError">Vui lòng chọn ngày sinh hợp lệ</div>
                </div>

                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-user-tag"></i> Vai trò
                    </label>
                    <div class="role-selector">
                        <div class="role-option">
                            <input type="radio" id="nhanVien" name="vaiTro" value="NHAN_VIEN" checked>
                            <label for="nhanVien" class="role-label">
                                <div class="role-icon">
                                    <i class="fas fa-user"></i>
                                </div>
                                <div class="role-details">
                                    <h4>Nhân viên</h4>
                                    <p>Quản lý đặt sân và khách hàng</p>
                                </div>
                            </label>
                        </div>

                        <div class="role-option">
                            <input type="radio" id="quanLy" name="vaiTro" value="QUAN_LY">
                            <label for="quanLy" class="role-label">
                                <div class="role-icon">
                                    <i class="fas fa-user-tie"></i>
                                </div>
                                <div class="role-details">
                                    <h4>Quản lý</h4>
                                    <p>Toàn quyền quản lý hệ thống</p>
                                </div>
                            </label>
                        </div>
                    </div>
                    <div class="error-message" id="vaiTroError">Vui lòng chọn vai trò</div>
                </div>

                <button type="submit" class="submit-btn" id="submitBtn">
                    <i class="fas fa-user-plus"></i>
                    Tạo nhân viên
                </button>
            </form>
        </div>
    </div>
</div>


<!-- Footer -->
<%@include file="footer.jsp" %>




<script>
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('createEmployeeForm');
        const inputs = document.querySelectorAll('.form-input');
        const passwordInput = document.getElementById('matKhau');
        const confirmPasswordInput = document.getElementById('nhapLaiMatKhau');
        const passwordStrength = document.getElementById('passwordStrength');

        // Add focus effects
        inputs.forEach(input => {
            input.addEventListener('focus', function() {
                this.style.borderColor = 'var(--primary-blue)';
                this.style.background = 'white';
            });

            input.addEventListener('blur', function() {
                if (!this.value) {
                    this.style.borderColor = '#e2e8f0';
                    this.style.background = '#f8fafc';
                }
            });
        });

        // Password strength checker
        passwordInput.addEventListener('input', function() {
            const password = this.value;
            const strength = checkPasswordStrength(password);

            if (password.length > 0) {
                passwordStrength.style.display = 'block';
                passwordStrength.className = 'password-strength ' + strength.class;
                passwordStrength.innerHTML = '<i class="fas fa-shield-alt"></i> ' + strength.text;
            } else {
                passwordStrength.style.display = 'none';
            }
        });

        // Confirm password validation
        confirmPasswordInput.addEventListener('input', function() {
            const password = passwordInput.value;
            const confirmPassword = this.value;
            const errorElement = document.getElementById('nhapLaiMatKhauError');

            if (confirmPassword && password !== confirmPassword) {
                errorElement.style.display = 'block';
                this.style.borderColor = '#ef4444';
            } else {
                errorElement.style.display = 'none';
                if (confirmPassword) this.style.borderColor = '#22c55e';
            }
        });

        // Form validation
        form.addEventListener('submit', function(e) {
            let isValid = true;

            // Validate name
            const ten = document.getElementById('ten');
            const tenError = document.getElementById('tenError');
            if (ten.value.trim().length < 2) {
                tenError.style.display = 'block';
                ten.style.borderColor = '#ef4444';
                isValid = false;
            } else {
                tenError.style.display = 'none';
                ten.style.borderColor = '#22c55e';
            }

            // Validate email
            const email = document.getElementById('email');
            const emailError = document.getElementById('emailError');
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email.value)) {
                emailError.style.display = 'block';
                email.style.borderColor = '#ef4444';
                isValid = false;
            } else {
                emailError.style.display = 'none';
                email.style.borderColor = '#22c55e';
            }

            // Validate password
            const matKhau = document.getElementById('matKhau');
            const matKhauError = document.getElementById('matKhauError');
            if (matKhau.value.length < 6) {
                matKhauError.style.display = 'block';
                matKhau.style.borderColor = '#ef4444';
                isValid = false;
            } else {
                matKhauError.style.display = 'none';
                matKhau.style.borderColor = '#22c55e';
            }

            // Validate confirm password
            const nhapLaiMatKhau = document.getElementById('nhapLaiMatKhau');
            const nhapLaiMatKhauError = document.getElementById('nhapLaiMatKhauError');
            if (nhapLaiMatKhau.value !== matKhau.value) {
                nhapLaiMatKhauError.style.display = 'block';
                nhapLaiMatKhau.style.borderColor = '#ef4444';
                isValid = false;
            } else {
                nhapLaiMatKhauError.style.display = 'none';
                nhapLaiMatKhau.style.borderColor = '#22c55e';
            }

            // Validate birth date
            const ngaySinh = document.getElementById('ngaySinh');
            const ngaySinhError = document.getElementById('ngaySinhError');
            if (!ngaySinh.value) {
                ngaySinhError.style.display = 'block';
                ngaySinh.style.borderColor = '#ef4444';
                isValid = false;
            } else {
                ngaySinhError.style.display = 'none';
                ngaySinh.style.borderColor = '#22c55e';
            }

            if (!isValid) {
                e.preventDefault();
            } else {
                // Add loading state
                const submitBtn = document.getElementById('submitBtn');
                submitBtn.innerHTML = '<div class="loading"></div> Đang tạo...';
                submitBtn.disabled = true;
            }
        });

        // Real-time validation
        inputs.forEach(input => {
            input.addEventListener('input', function() {
                const errorElement = document.getElementById(this.id + 'Error');
                if (errorElement && errorElement.style.display === 'block') {
                    errorElement.style.display = 'none';
                    this.style.borderColor = '#e2e8f0';
                }
            });
        });

        // Animate form elements
        const formElements = document.querySelectorAll('.form-group');
        formElements.forEach((element, index) => {
            element.style.opacity = '0';
            element.style.transform = 'translateY(20px)';
            element.style.transition = 'all 0.6s ease-out';

            setTimeout(() => {
                element.style.opacity = '1';
                element.style.transform = 'translateY(0)';
            }, index * 100);
        });
    });

    function checkPasswordStrength(password) {
        let score = 0;

        if (password.length >= 8) score++;
        if (/[a-z]/.test(password)) score++;
        if (/[A-Z]/.test(password)) score++;
        if (/[0-9]/.test(password)) score++;
        if (/[^A-Za-z0-9]/.test(password)) score++;

        if (score < 3) {
            return { class: 'strength-weak', text: 'Mật khẩu yếu' };
        } else if (score < 4) {
            return { class: 'strength-medium', text: 'Mật khẩu trung bình' };
        } else {
            return { class: 'strength-strong', text: 'Mật khẩu mạnh' };
        }
    }
</script>
</body>
</html>
