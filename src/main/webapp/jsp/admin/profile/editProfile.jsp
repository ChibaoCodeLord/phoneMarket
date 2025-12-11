<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.phonemarket.model.bean.Users" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile - Phone Market</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/admin-table.css">
</head>
<body>
    <div class="admin-wrapper">
        <%@ include file="../component/sidebar.jsp" %>

        <!-- Main Content -->
        <main class="main-content">
            <!-- Header -->
            <header class="header">
                <div class="header-left">
                    <h2>Edit Profile</h2>
                </div>
                <div class="header-right">
                    <div class="admin-info">
                        <a href="${pageContext.request.contextPath}/admin/profile" class="btn-back">Back to Profile</a>
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

            <!-- Edit Profile Form -->
            <section class="edit-profile-section">
                <div class="edit-card">
                    <div class="card-header">
                        <h2>Update Your Information</h2>
                        <p>Modify your account details below</p>
                    </div>

                    <form action="${pageContext.request.contextPath}/admin/profile/edit" method="post" id="editProfileForm">
                        <div class="form-grid">
                            <div class="form-group full-width">
                                <label for="username">Username <span class="required">*</span></label>
                                <input type="text" id="username" name="username" value="${currentUser.username}"  class="form-control ">
                            </div>

                            <!-- Full Name -->
                            <div class="form-group">
                                <label for="fullName">Full Name <span class="required">*</span></label>
                                <input type="text" id="fullName" name="fullName" value="${currentUser.fullName}" required class="form-control">
                                <small class="form-text">Enter your full name</small>
                            </div>

                            <!-- Email -->
                            <div class="form-group">
                                <label for="email">Email <span class="required">*</span></label>
                                <input type="email" id="email" name="email" value="${currentUser.email}" required class="form-control">
                                <small class="form-text">Valid email required</small>
                            </div>

                            <!-- Phone -->
                            <div class="form-group">
                                <label for="phone">Phone Number <span class="required">*</span></label>
                                <input type="tel" id="phone" name="phone_number" value="${currentUser.phone}" required pattern="[0-9]{10}" class="form-control">
                                <small class="form-text">10 digit phone number</small>
                            </div>

                            <!-- Address -->
                            <div class="form-group full-width">
                                <label for="address">Address</label>
                                <textarea id="address" name="address" rows="3" class="form-control">${currentUser.address}</textarea>
                                <small class="form-text">Your current address</small>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">
                                <span class="btn-icon">💾</span>
                                Save Changes
                            </button>
                            <button type="reset" class="btn btn-secondary">
                                <span class="btn-icon">↻</span>
                                Reset
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/profile" class="btn btn-cancel">
                                <span class="btn-icon">✕</span>
                                Cancel
                            </a>
                        </div>
                    </form>
                </div>
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
        .header-right { display: flex; gap: 1rem; }
        .btn-back { padding: 0.5rem 1rem; background: #64748b; color: #fff; text-decoration: none; border-radius: 6px; font-size: 0.875rem; transition: background 0.2s; }
        .btn-back:hover { background: #475569; }
        .btn-logout { padding: 0.5rem 1rem; background: #ef4444; color: #fff; text-decoration: none; border-radius: 6px; font-size: 0.875rem; }

        /* Alerts */
        .alert { display: flex; align-items: center; gap: 0.75rem; padding: 1rem; border-radius: 8px; margin-bottom: 1.5rem; animation: slideIn 0.3s ease; }
        .alert-success { background: #d1fae5; color: #065f46; border: 1px solid #10b981; }
        .alert-error { background: #fee2e2; color: #991b1b; border: 1px solid #ef4444; }
        .alert-icon { font-weight: bold; font-size: 1.25rem; }
        .alert-close { margin-left: auto; background: none; border: none; font-size: 1.5rem; cursor: pointer; color: inherit; }

        @keyframes slideIn { from { transform: translateY(-20px); opacity: 0; } to { transform: translateY(0); opacity: 1; } }

        /* Edit Profile Section */
        .edit-profile-section { max-width: 900px; margin: 0 auto; }
        .edit-card { background: #fff; border-radius: 16px; padding: 2.5rem; box-shadow: 0 10px 30px rgba(15,23,42,0.08); }

        .card-header { margin-bottom: 2rem; padding-bottom: 1.5rem; border-bottom: 2px solid #f1f5f9; }
        .card-header h2 { font-size: 1.75rem; color: #0f172a; margin-bottom: 0.5rem; }
        .card-header p { color: #64748b; font-size: 0.95rem; }

        /* Form Styles */
        .form-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 1.5rem; margin-bottom: 2rem; }
        .form-group { display: flex; flex-direction: column; }
        .form-group.full-width { grid-column: 1 / -1; }

        .form-group label { font-weight: 600; color: #334155; margin-bottom: 0.5rem; font-size: 0.95rem; display: flex; align-items: center; gap: 0.5rem; }
        .required { color: #ef4444; font-weight: bold; }
        .read-only-badge { background: #fef3c7; color: #92400e; font-size: 0.75rem; padding: 0.125rem 0.5rem; border-radius: 4px; font-weight: 500; }

        .form-control { padding: 0.875rem 1rem; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 0.95rem; transition: all 0.2s; font-family: inherit; }
        .form-control:focus { outline: none; border-color: #2563eb; box-shadow: 0 0 0 3px rgba(37,99,235,0.1); }
        .form-control.read-only { background: #f8fafc; cursor: not-allowed; color: #64748b; }

        textarea.form-control { resize: vertical; min-height: 80px; }

        .form-text { color: #64748b; font-size: 0.8rem; margin-top: 0.375rem; }

        /* Form Actions */
        .form-actions { display: flex; gap: 1rem; padding-top: 1.5rem; border-top: 2px solid #f1f5f9; }
        .btn { border: none; border-radius: 8px; padding: 0.875rem 1.75rem; cursor: pointer; font-weight: 600; transition: all 0.2s; display: inline-flex; align-items: center; gap: 0.5rem; font-size: 0.95rem; text-decoration: none; }
        .btn-icon { font-size: 1.1rem; }
        .btn-primary { background: #2563eb; color: #fff; flex: 1; justify-content: center; }
        .btn-primary:hover { background: #1d4ed8; transform: translateY(-1px); box-shadow: 0 4px 12px rgba(37,99,235,0.3); }
        .btn-secondary { background: #f1f5f9; color: #0f172a; }
        .btn-secondary:hover { background: #e2e8f0; }
        .btn-cancel { background: #fff; color: #ef4444; border: 2px solid #fee2e2; }
        .btn-cancel:hover { background: #fee2e2; }

        /* Responsive */
        @media (max-width: 768px) {
            .form-grid { grid-template-columns: 1fr; }
            .form-actions { flex-direction: column; }
            .btn { width: 100%; }
        }
    </style>

    <script>
        // Form Validation
        document.getElementById('editProfileForm').addEventListener('submit', function(e) {
            const phone = document.getElementById('phone').value;
            const email = document.getElementById('email').value;

            // Phone validation
            if (!/^[0-9]{10}$/.test(phone)) {
                e.preventDefault();
                alert('Please enter a valid 10-digit phone number');
                return;
            }

            // Email validation
            if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                e.preventDefault();
                alert('Please enter a valid email address');
                return;
            }
        });

        // Auto-hide alerts after 5 seconds
        setTimeout(() => {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                alert.style.animation = 'slideOut 0.3s ease forwards';
                setTimeout(() => alert.remove(), 300);
            });
        }, 5000);
    </script>
</body>
</html>
