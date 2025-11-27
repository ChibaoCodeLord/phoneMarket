<!-- File: src/main/webapp/jsp/admin/profile/changePassword.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password - Phone Market</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/admin-home.css">
      <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/admin-home.css">
      <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/admin-table.css">
      <link rel="script" src="js/component/sidebar.js"></script>
</head>
<body>
    <div class="admin-wrapper">
        <%@ include file="../component/sidebar.jsp" %>

        <main class="main-content">
            <header class="header">
                <div class="header-left">
                    <h2>Change Password</h2>
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
                <c:remove var="success" scope="session"/>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <span class="alert-icon">✗</span>
                    <span>${error}</span>
                    <button class="alert-close" onclick="this.parentElement.remove()">×</button>
                </div>
                <c:remove var="error" scope="session"/>
            </c:if>

            <!-- Change Password Form -->
            <section class="form-section">
                <div class="form-card">
                    <form action="${pageContext.request.contextPath}/admin/profile/changePassword" method="post" id="changePasswordForm">
                        <div class="form-group">
                            <label for="currentPassword">Current Password <span class="required">*</span></label>
                            <input type="password" id="currentPassword" name="currentPassword" required>
                        </div>

                        <div class="form-group">
                            <label for="newPassword">New Password <span class="required">*</span></label>
                            <input type="password" id="newPassword" name="newPassword" required minlength="6">
                            <small class="help-text">Minimum 6 characters</small>
                        </div>

                        <div class="form-group">
                            <label for="confirmPassword">Confirm New Password <span class="required">*</span></label>
                            <input type="password" id="confirmPassword" name="confirmPassword" required minlength="6">
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">Change Password</button>
                            <button type="button" class="btn btn-secondary" onclick="window.location.href='${pageContext.request.contextPath}/admin/profile'">Cancel</button>
                        </div>
                    </form>
                </div>
            </section>
        </main>
    </div>

    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background: #f8fafc; }


        .admin-info { display: flex; align-items: center; gap: 1rem; }
        .btn-logout { padding: 0.5rem 1rem; background: #ef4444; color: #fff; text-decoration: none; border-radius: 6px; font-size: 0.875rem; }

        /* Form */
        .form-section { max-width: 600px; margin: 0 auto; }
        .form-card { background: #fff; border-radius: 16px; padding: 2rem; box-shadow: 0 10px 30px rgba(15,23,42,0.08); }
        .form-group { margin-bottom: 1.5rem; }
        .form-group label { display: block; margin-bottom: 0.5rem; font-weight: 600; color: #0f172a; }
        .required { color: #ef4444; }
        .form-group input { width: 100%; padding: 0.75rem; border: 1px solid #e2e8f0; border-radius: 8px; font-size: 1rem; }
        .form-group input:focus { outline: none; border-color: #2563eb; box-shadow: 0 0 0 3px rgba(37,99,235,0.1); }
        .help-text { display: block; margin-top: 0.25rem; font-size: 0.875rem; color: #64748b; }

        .form-actions { display: flex; gap: 1rem; margin-top: 2rem; }
        .btn { border: none; border-radius: 8px; padding: 0.75rem 1.5rem; cursor: pointer; font-weight: 600; transition: all 0.2s; }
        .btn-primary { background: #2563eb; color: #fff; }
        .btn-primary:hover { background: #1d4ed8; }
        .btn-secondary { background: #f1f5f9; color: #0f172a; }
        .btn-secondary:hover { background: #e2e8f0; }
    </style>

    <script>
        document.getElementById('changePasswordForm').addEventListener('submit', function(e) {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;

            if (newPassword !== confirmPassword) {
                e.preventDefault();
                alert('New password and confirm password do not match!');
                return false;
            }

            if (newPassword.length < 6) {
                e.preventDefault();
                alert('Password must be at least 6 characters long!');
                return false;
            }
        });
    </script>
</body>
</html>
