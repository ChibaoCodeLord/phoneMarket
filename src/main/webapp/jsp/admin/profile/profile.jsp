<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.phonemarket.model.bean.Users" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Profile - Phone Market</title>
      <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/admin-home.css">
      <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/admin-table.css">
      <link rel="script" src="js/component/sidebar.js"></script>
</head>
<body>
    <div class="admin-wrapper">
        <%@ include file="../component/sidebar.jsp" %>

        <!-- Main Content -->
        <main class="main-content">
            <!-- Header -->
            <header class="header">
                <div class="header-left">
                    <h2>Admin Profile</h2>
                </div>
                <div class="header-right">
                    <div class="admin-info">

                        <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a>
                    </div>
                </div>
            </header>

            <!-- Notifications -->
            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <span class="alert-icon">✓</span>
                    <span>${success}</span>
                    <button class="alert-close" onclick="this.parentElement.remove()">×</button>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <span class="alert-icon">✗</span>
                    <span>${error}</span>
                    <button class="alert-close" onclick="this.parentElement.remove()">×</button>
                </div>
            </c:if>

            <!-- Profile Content -->
            <section class="admin-account-detail">
                <c:if test="${not empty currentUser}">
                    <div class="detail-card">
                        <div class="card-header">
                            <h2>Admin Account Details</h2>
                            <span class="status ${currentUser.role ? 'admin' : 'user'}">
                                ${currentUser.role ? 'Admin' : 'User'}
                            </span>
                        </div>
                        <div class="detail-body">
                            <div class="detail-row">
                                <label>User ID</label>
                                <span>${currentUser.userId}</span>
                            </div>
                            <div class="detail-row">
                                <label>Username</label>
                                <span>${currentUser.username}</span>
                            </div>
                            <div class="detail-row">
                                <label>Full Name</label>
                                <span>${currentUser.fullName}</span>
                            </div>
                            <div class="detail-row">
                                <label>Email</label>
                                <span>${currentUser.email}</span>
                            </div>
                            <div class="detail-row">
                                <label>Phone</label>
                                <span>${currentUser.phone}</span>
                            </div>
                            <div class="detail-row">
                                <label>Address</label>
                                <span>${currentUser.address}</span>
                            </div>
                        </div>
                        <div class="detail-actions">
                            <button class="btn btn-primary" onclick="window.location.href='${pageContext.request.contextPath}/admin/profile/edit'">
                                Edit Profile
                            </button>
                            <button class="btn btn-secondary" onclick="window.location.href='${pageContext.request.contextPath}/admin/profile/changePassword'">
                                Change Password
                            </button>
                        </div>
                    </div>
                </c:if>
                <c:if test="${empty currentUser}">
                    <div class="no-data">
                        <p>Unable to load admin details.</p>
                        <button class="btn btn-primary" onclick="window.location.reload()">Reload</button>
                    </div>
                </c:if>
            </section>
        </main>
    </div>

    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background: #f8fafc; }

        .admin-wrapper { display: flex; min-height: 100vh; }
        /* Main Content */
        .main-content { flex: 1; padding: 2rem; }

        /* Header */
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; padding-bottom: 1rem; border-bottom: 1px solid #e2e8f0; }
        .header h2 { font-size: 1.75rem; color: #0f172a; }
        .admin-info { display: flex; align-items: center; gap: 1rem; }
        .btn-logout { padding: 0.5rem 1rem; background: #ef4444; color: #fff; text-decoration: none; border-radius: 6px; font-size: 0.875rem; }

        /* Profile Card */
        .admin-account-detail { max-width: 800px; margin: 0 auto; }
        .detail-card { background: #fff; border-radius: 16px; padding: 2rem; box-shadow: 0 10px 30px rgba(15,23,42,0.08); }
        .card-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; padding-bottom: 1rem; border-bottom: 2px solid #f1f5f9; }
        .card-header h2 { font-size: 1.5rem; color: #0f172a; }
        .status { font-size: 0.875rem; padding: 0.375rem 0.875rem; border-radius: 9999px; font-weight: 600; }
        .status.admin { background: #dbeafe; color: #1e40af; }
        .status.user { background: #e0e7ff; color: #4338ca; }

        .detail-body { margin-bottom: 1.5rem; }
        .detail-row { display: flex; justify-content: space-between; padding: 1rem 0; border-bottom: 1px solid #f1f5f9; }
        .detail-row:last-child { border-bottom: none; }
        .detail-row label { font-weight: 600; color: #64748b; }
        .detail-row span { color: #0f172a; font-weight: 500; }

        .detail-actions { display: flex; gap: 1rem; }
        .btn { border: none; border-radius: 8px; padding: 0.75rem 1.5rem; cursor: pointer; font-weight: 600; transition: all 0.2s; }
        .btn-primary { background: #2563eb; color: #fff; }
        .btn-primary:hover { background: #1d4ed8; }
        .btn-secondary { background: #f1f5f9; color: #0f172a; }
        .btn-secondary:hover { background: #e2e8f0; }

        .no-data { text-align: center; padding: 3rem; background: #fff; border-radius: 16px; }
        .no-data p { color: #64748b; margin-bottom: 1rem; }
    </style>
</body>
</html>
