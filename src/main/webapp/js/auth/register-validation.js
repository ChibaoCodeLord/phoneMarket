// register-validation.js: Hàm kiểm tra validation form register
function validateRegisterForm() {
    let isValid = true;
    const fields = {
        fullname: document.getElementById('fullname'),
        email: document.getElementById('email'),
        username: document.getElementById('username'),
        password: document.getElementById('password'),
        confirmPassword: document.getElementById('confirmPassword')
    };

    // Reset errors trước
    Object.keys(fields).forEach(key => {
        fields[key].classList.remove('error-field');
        document.getElementById(key + 'Error').textContent = '';
    });

    // Kiểm tra Full Name: Không rỗng, chỉ chữ cái và khoảng trắng
    if (!fields.fullname.value.trim() || !/^[a-zA-Z\s]+$/.test(fields.fullname.value.trim())) {
        showError(fields.fullname, 'fullnameError', 'Họ tên không được rỗng và chỉ chứa chữ cái!');
        isValid = false;
    }

    // Kiểm tra Email: Định dạng hợp lệ
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!fields.email.value.trim() || !emailRegex.test(fields.email.value.trim())) {
        showError(fields.email, 'emailError', 'Email không hợp lệ!');
        isValid = false;
    }

    // Kiểm tra Username: Độ dài 3-20, chỉ chữ cái, số, underscore
    const usernameRegex = /^[a-zA-Z0-9_]{3,20}$/;
    if (!fields.username.value.trim() || !usernameRegex.test(fields.username.value.trim())) {
        showError(fields.username, 'usernameError', 'Username phải 3-20 ký tự, chỉ chữ cái, số và underscore!');
        isValid = false;
    }

    // Kiểm tra Password: Độ dài 6-20, có chữ hoa, chữ thường, số
    const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,20}$/;
    if (!fields.password.value || !passwordRegex.test(fields.password.value)) {
        showError(fields.password, 'passwordError', 'Mật khẩu phải 6-20 ký tự, có chữ hoa, chữ thường và số!');
        isValid = false;
    }

    // Kiểm tra Confirm Password: Khớp với Password
    if (fields.confirmPassword.value !== fields.password.value) {
        showError(fields.confirmPassword, 'confirmPasswordError', 'Mật khẩu xác nhận không khớp!');
        isValid = false;
    }

    return isValid;
}

// Hàm helper hiển thị lỗi
function showError(input, errorId, message) {
    input.classList.add('error-field');
    document.getElementById(errorId).textContent = message;
    input.focus();  // Focus vào trường lỗi đầu tiên
}

// Event listener cho submit form (chạy khi load trang)
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('registerForm');
    if (form) {
        form.addEventListener('submit', function(e) {
            if (!validateRegisterForm()) {
                e.preventDefault();  // Ngăn submit nếu có lỗi
            }
        });
    }
});