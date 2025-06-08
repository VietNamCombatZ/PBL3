<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tạo khách hàng - Modern</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern-style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        .create-customer-container {
            max-width: 600px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        .create-customer-card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-md);
            overflow: hidden;
            animation: slideUp 0.6s ease-out;
        }

        .create-customer-header {
            background: var(--gradient-primary);
            color: white;
            padding: 2rem;
            text-align: center;
        }

        .customer-icon {
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

        .create-customer-title {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .create-customer-subtitle {
            opacity: 0.9;
            font-size: 0.9rem;
        }

        .create-customer-form {
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
            .create-customer-container {
                padding: 0 1rem;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .create-customer-form {
                padding: 1.5rem;
            }

            .create-customer-header {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>

<%@ include file="navbar-nhanvien.jsp" %>

<div class="create-customer-container fade-in">
    <a href="<%= request.getContextPath() %>/nguoiDung/DanhsachKhachHang" class="back-link">
        <i class="fas fa-arrow-left"></i>
        Quay lại danh sách khách hàng
    </a>

    <div class="create-customer-card">
        <div class="create-customer-header">
            <div class="customer-icon">
                <i class="fas fa-user-plus"></i>
            </div>
            <h1 class="create-customer-title">Tạo khách hàng mới</h1>
            <p class="create-customer-subtitle">Thêm khách hàng mới vào hệ thống</p>
        </div>

        <div class="create-customer-form">
            <% String thongBao = (String) request.getAttribute("thongBao");
                if(thongBao == null){
                    thongBao = (String) session.getAttribute("thongBao");
                }%>
            <% if (thongBao != null) { %>
            <div class="modern-alert alert-error">
                <i class="fas fa-exclamation-triangle"></i>
                <%= thongBao %>
            </div>
            <% } %>

            <form action="<%= request.getContextPath()%>/nguoiDung/taoKhachHang" method="post" id="createCustomerForm">
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

                <div class="form-grid">
                    <div class="form-group">
                        <label for="matkhau" class="form-label">
                            <i class="fas fa-lock"></i> Mật khẩu
                        </label>
                        <input type="password" id="matkhau" name="matkhau" class="form-input" placeholder="Nhập mật khẩu" required />
                        <div class="password-strength" id="passwordStrength"></div>
                        <div class="error-message" id="matkhauError">Mật khẩu phải có ít nhất 6 ký tự</div>
                    </div>

                    <div class="form-group">
                        <label for="nhaplaimatkhau" class="form-label">
                            <i class="fas fa-lock"></i> Nhập lại mật khẩu
                        </label>
                        <input type="password" id="nhaplaimatkhau" name="nhaplaimatkhau" class="form-input" placeholder="Nhập lại mật khẩu" required />
                        <div class="error-message" id="nhaplaimatkhauError">Mật khẩu không khớp</div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="ngaysinh" class="form-label">
                        <i class="fas fa-calendar"></i> Ngày sinh
                    </label>
                    <input type="date" id="ngaysinh" name="ngaysinh" class="form-input" required />
                    <div class="error-message" id="ngaysinhError">Vui lòng chọn ngày sinh hợp lệ</div>
                </div>

                <button type="submit" class="submit-btn" id="submitBtn">
                    <i class="fas fa-user-plus"></i>
                    Tạo khách hàng
                </button>
            </form>
        </div>
    </div>
</div>


<!-- Footer -->
<%@include file="footer.jsp" %>




<script>
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('createCustomerForm');
        const inputs = document.querySelectorAll('.form-input');
        const passwordInput = document.getElementById('matkhau');
        const confirmPasswordInput = document.getElementById('nhaplaimatkhau');
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
            const errorElement = document.getElementById('nhaplaimatkhauError');

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
            const matkhau = document.getElementById('matkhau');
            const matkhauError = document.getElementById('matkhauError');
            if (matkhau.value.length < 6) {
                matkhauError.style.display = 'block';
                matkhau.style.borderColor = '#ef4444';
                isValid = false;
            } else {
                matkhauError.style.display = 'none';
                matkhau.style.borderColor = '#22c55e';
            }

            // Validate confirm password
            const nhaplaimatkhau = document.getElementById('nhaplaimatkhau');
            const nhaplaimatkhauError = document.getElementById('nhaplaimatkhauError');
            if (nhaplaimatkhau.value !== matkhau.value) {
                nhaplaimatkhauError.style.display = 'block';
                nhaplaimatkhau.style.borderColor = '#ef4444';
                isValid = false;
            } else {
                nhaplaimatkhauError.style.display = 'none';
                nhaplaimatkhau.style.borderColor = '#22c55e';
            }

            // Validate birth date
            const ngaysinh = document.getElementById('ngaysinh');
            const ngaysinhError = document.getElementById('ngaysinhError');
            if (!ngaysinh.value) {
                ngaysinhError.style.display = 'block';
                ngaysinh.style.borderColor = '#ef4444';
                isValid = false;
            } else {
                ngaysinhError.style.display = 'none';
                ngaysinh.style.borderColor = '#22c55e';
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
