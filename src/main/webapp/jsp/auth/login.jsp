<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - PhoneMarket</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/css/auth.css">
</head>
<body>
<div class="auth-container">
    <!-- Bên trái: Form Login -->
    <div class="auth-left">
        <h1>Sign In</h1>
        <p class="social-login">
            <a href="#"><i class="fab fa-facebook-f"></i></a>
            <a href="#"><i class="fab fa-twitter"></i></a>
        </p>
        <c:if test="${not empty error}">
            <div class="error-message">
                <i class="fas fa-exclamation-triangle"></i> ${error}
            </div>
        </c:if>
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="input-group">
                <label>USERNAME</label>
                <input type="text" name="username" placeholder="Username" required id="username">
                <span class="error-msg" id="usernameError"></span>
            </div>
            <div class="input-group">
                <label>PASSWORD</label>
                <input type="password" name="password" placeholder="Password" required id="password">
                <span class="error-msg" id="passwordError"></span>
            </div>
            <div class="form-options">
                <label class="checkbox">
                    <input type="checkbox" name="rememberMe"> <span class="checkmark"></span> Remember Me
                </label>
                <a href="#" class="forgot-link">Forgot Password</a>
            </div>
            <button type="submit" class="auth-btn primary">Sign In</button>
        </form>
    </div>

    <!-- Bên phải: Welcome + Sign Up -->
    <div class="auth-right">
        <h2>Welcome to login</h2>
        <p>Don't have an account?</p>
        <a href="/register" class="auth-btn secondary">Sign Up</a>
    </div>
</div>
<script src="/js/auth/login-validation.js"></script>
</body>
</html>