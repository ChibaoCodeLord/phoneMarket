<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile - PhoneMarket Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/css/admin/admin-home.css">
    <link rel="stylesheet" href="/css/admin/admin-profile.css">
</head>
<body>
<div class="profile-container">
    <!-- Sidebar -->
    <%@ include file="../component/sidebar.jsp" %>

    <!-- Breadcrumb -->
    <nav class="breadcrumb">
        <a href="/admin/home"><i class="fas fa-home"></i> Home</a>
        <span>/</span>
        <span>User Profile</span>
    </nav>

    <!-- Profile Header -->
    <div class="profile-header">
        <div class="profile-info">
            <h1><c:out value="${user.fullName != null ? user.fullName : '-'}"/></h1>
            <p class="profile-role"><c:out value="${user.role ? 'Admin' : 'User'}"/></p>
        </div>
        <div class="social-links">
            <a href="#"><i class="fab fa-facebook-f"></i></a>
            <a href="#"><i class="fab fa-twitter"></i></a>
            <a href="#"><i class="fab fa-linkedin-in"></i></a>
            <a href="#"><i class="fab fa-instagram"></i></a>
        </div>
        <button class="edit-btn" onclick="window.location.href='/admin/users/edit?id=${user.userId}'">Edit</button>
    </div>

    <!-- Personal Information Section -->
    <div class="profile-section">
        <div class="section-header">
            <h2 class="section-title">Personal Information</h2>
            <button class="section-edit-btn" onclick="window.location.href='/admin/users/edit?id=${user.userId}'">Edit</button>
        </div>
        <div class="info-grid">
            <div class="info-item">
                <span class="info-label">Full Name</span>
                <span class="info-value"><c:out value="${user.fullName != null ? user.fullName : '-'}"/></span>
            </div>
            <div class="info-item">
                <span class="info-label">Email Address</span>
                <span class="info-value"><c:out value="${user.email != null ? user.email : '-'}"/></span>
            </div>
            <div class="info-item">
                <span class="info-label">Phone</span>
                <span class="info-value"><c:out value="${user.phone != null ? user.phone : '-'}"/></span>
            </div>
            <div class="info-item">
                <span class="info-label">Address</span>
                <span class="info-value"><c:out value="${user.address != null ? user.address : '-'}"/></span>
            </div>
        </div>
    </div>

    <!-- Role Section -->
    <div class="profile-section">
        <div class="section-header">
            <h2 class="section-title">Role</h2>
        </div>
        <div class="info-item full-width">
            <span class="info-label">Role</span>
            <span class="info-value"><c:out value="${user.role ? 'Admin' : 'User'}"/></span>
        </div>
    </div>
</div>
</body>
</html>
