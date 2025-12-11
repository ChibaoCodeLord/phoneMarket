<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - PhoneMarket</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
</head>
<body>
<div class="auth-container">
    <!-- Bên trái: Form Register -->
    <div class="auth-left">
        <h1>Sign Up</h1>
        <p class="social-login">
            <a href="#"><i class="fab fa-facebook-f"></i></a>
            <a href="#"><i class="fab fa-twitter"></i></a>
        </p>
        <c:if test="${not empty error}">
            <div class="error-message">
                <i class="fas fa-exclamation-triangle"></i> ${error}
            </div>
        </c:if>
        <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm">
            <div class="input-group">
                <label>FULL NAME</label>
                <input type="text" name="fullName" placeholder="Full Name" required id="fullName">
                <span class="error-msg" id="fullNameError"></span>
            </div>
            <div class="input-group">
                <label>EMAIL</label>
                <input type="email" name="email" placeholder="Email" required id="email">
                <span class="error-msg" id="emailError"></span>
            </div>
            <div class="input-group">
                <label>USERNAME</label>
                <input type="text" name="username" placeholder="Username" required id="username">
                <span class="error-msg" id="usernameError"></span>
            </div>
            <div class="input-group">
                <label>PHONE</label>
                <input type="tel" name="phone" placeholder="Phone Number" id="phone">
                <span class="error-msg" id="phoneError"></span>
            </div>
            <div class="input-group">
                <label>ADDRESS</label>
                <input type="text" name="address" placeholder="Address" id="address">
                <span class="error-msg" id="addressError"></span>
            </div>
            <div class="input-group">
                <label>PASSWORD</label>
                <input type="password" name="password" placeholder="Password" id="password" required>
                <span class="error-msg" id="passwordError"></span>
            </div>
            <div class="input-group">
                <label>CONFIRM PASSWORD</label>
                <input type="password" name="confirmPassword" placeholder="Confirm Password" id="confirmPassword" required>
                <span class="error-msg" id="confirmPasswordError"></span>
            </div>
            <button type="submit" class="auth-btn primary">Sign Up</button>
        </form>
    </div>
    <!-- Bên phải: Welcome + Sign In -->
    <div class="auth-right">
        <h2>Welcome to register</h2>
        <p>Already have an account?</p>
        <a href="/login" class="auth-btn secondary">Sign In</a>
    </div>
</div>

<!-- Link file JS riêng -->
<script src="/js/auth/register-validation.js"></script>
</body>
</html>