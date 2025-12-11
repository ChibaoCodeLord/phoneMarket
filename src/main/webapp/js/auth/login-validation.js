// login-validation.js: Hàm kiểm tra validation form login
function validateLoginForm() {
    let isValid = true;
    const fields = {
        username: document.getElementById('username'),
        password: document.getElementById('password')
    };

    // Reset errors trước
    Object.keys(fields).forEach(key => {
        fields[key].classList.remove('error-field');
        document.getElementById(key + 'Error').textContent = '';
    });

    // Kiểm tra Username: Không rỗng, độ dài 3-20, chỉ chữ cái, số, underscore
    const usernameRegex = /^[a-zA-Z0-9_]{3,20}$/;
    if (!fields.username.value.trim() || !usernameRegex.test(fields.username.value.trim())) {
        showError(fields.username, 'usernameError', 'Username phải 3-20 ký tự, chỉ chữ cái, số và underscore!');
        isValid = false;
    }

    // Kiểm tra Password: Không rỗng, độ dài 6-20, có chữ hoa, chữ thường, số
    const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,20}$/;
    if (!fields.password.value || !passwordRegex.test(fields.password.value)) {
        showError(fields.password, 'passwordError', 'Mật khẩu phải 6-20 ký tự, có chữ hoa, chữ thường và số!');
        isValid = false;
    }

    return isValid;
}

// Hàm helper hiển thị lỗi (giống register)
function showError(input, errorId, message) {
    input.classList.add('error-field');
    document.getElementById(errorId).textContent = message;
    input.focus();  // Focus vào trường lỗi đầu tiên
}

// Event listener cho submit form (chạy khi load trang)
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('loginForm');
    if (form) {
        form.addEventListener('submit', function(e) {
            if (!validateLoginForm()) {
                e.preventDefault();  // Ngăn submit nếu có lỗi
            }
        });
    }
});