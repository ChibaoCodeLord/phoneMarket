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
    <link rel="stylesheet" href="/css/admin/home.css">

    <style>
        /* ========= CARD CHUẨN THEO ORDER DETAIL ========= */
        .page-wrapper {
            margin-left: 260px;
            padding: 25px;
        }

        .breadcrumb {
            background: none;
            margin-bottom: 20px;
            font-size: 14px;
            color: #475569;
        }
        .breadcrumb a {
            color: #1e293b;
            text-decoration: none;
            font-weight: 500;
        }

        .profile-card {
            background: white;
            padding: 25px;
            border-radius: 14px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            margin-bottom: 25px;
        }

        .profile-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 15px;
            border-bottom: 1px solid #e2e8f0;
        }

        .profile-info h1 {
            margin: 0;
            font-size: 26px;
            color: #1e293b;
        }

        .profile-role {
            margin-top: 4px;
            color: #64748b;
            font-size: 15px;
        }

        .edit-btn {
            padding: 8px 16px;
            background: #2563eb;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.2s;
        }
        .edit-btn:hover {
            background: #1d4ed8;
        }

        .section-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 15px;
            color: #1e293b;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 18px;
        }

        .info-item {
            display: flex;
            flex-direction: column;
        }

        .info-label {
            font-size: 13px;
            color: #64748b;
            margin-bottom: 3px;
            text-transform: uppercase;
            font-weight: 600;
        }

        .info-value {
            font-size: 16px;
            color: #1e293b;
            font-weight: 500;
        }

        .profile-section {
            background: white;
            padding: 25px;
            border-radius: 14px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            margin-bottom: 25px;
        }
    </style>
</head>

<body>
<div class="profile-container">
    <%@ include file="../component/sidebar.jsp" %>

    <main class="main-content">
        <%@ include file="../component/header.jsp" %>
        <!-- Breadcrumb -->
        <nav class="breadcrumb">
            <a href="/admin/home"><i class="fas fa-home"></i> Home</a> /
            <span>User Profile</span>
        </nav>

        <!-- Profile Header Card -->
        <div class="profile-card">
            <div class="profile-header">
                <div class="profile-info">
                    <h1><c:out value="${user.fullName != null ? user.fullName : '-'}"/></h1>
                    <p class="profile-role">
                        <c:out value="${user.role ? 'Admin' : 'User'}"/>
                    </p>
                </div>

                <button class="edit-btn"
                        onclick="window.location.href='/admin/users/edit?id=${user.userId}'">
                    <i class="fas fa-edit"></i> Edit
                </button>
            </div>
        </div>

        <!-- Personal Information -->
        <div class="profile-section">
            <h2 class="section-title">Personal Information</h2>

            <div class="info-grid">
                <div class="info-item">
                    <span class="info-label">Full Name</span>
                    <span class="info-value"><c:out value="${user.fullName != null ? user.fullName : '-'}"/></span>
                </div>

                <div class="info-item">
                    <span class="info-label">Email</span>
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
            <h2 class="section-title">Role</h2>
            <div class="info-item">
                <span class="info-label">Role</span>
                <span class="info-value"><c:out value="${user.role ? 'Admin' : 'User'}"/></span>
            </div>
        </div>
    </main>
</div>

</body>
</html>
