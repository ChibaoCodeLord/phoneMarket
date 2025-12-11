<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Edit User - PhoneMarket Admin</title>

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="/css/admin/home.css">
  <link rel="stylesheet" href="/css/component/update-form.css">

  <style>
    /* ==== CARD CHUẨN DASHBOARD ==== */
    .page-wrapper {
      margin-left: 260px;
      padding: 25px;
    }

    .breadcrumb {
      background: none;
      margin-bottom: 25px;
      font-size: 14px;
      color: #475569;
    }
    .breadcrumb a {
      color: #1e293b;
      text-decoration: none;
      font-weight: 500;
    }

    .form-card {
      background: white;
      padding: 25px;
      border-radius: 14px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.06);
    }

    .section-title {
      font-size: 22px;
      font-weight: 600;
      margin-bottom: 20px;
      color: #1e293b;
    }

    .form-grid {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 20px;
    }

    .full-width {
      grid-column: 1 / 3;
    }

    .form-group label {
      display: block;
      font-size: 14px;
      font-weight: 600;
      margin-bottom: 6px;
      color: #475569;
    }

    .form-group input,
    .form-group textarea,
    .form-group select {
      width: 100%;
      padding: 10px 12px;
      border: 1px solid #cbd5e1;
      border-radius: 8px;
      font-size: 15px;
      color: #1e293b;
    }

    .form-actions {
      margin-top: 25px;
      display: flex;
      justify-content: flex-end;
      gap: 12px;
    }

    .btn-primary {
      background: #2563eb;
      color: white;
      border: none;
      padding: 10px 22px;
      border-radius: 8px;
      cursor: pointer;
      transition: 0.2s;
      font-size: 15px;
      font-weight: 600;
    }
    .btn-primary:hover {
      background: #1d4ed8;
    }

    .btn-outline {
      background: white;
      border: 1px solid #94a3b8;
      padding: 10px 22px;
      border-radius: 8px;
      cursor: pointer;
      font-size: 15px;
      color: #475569;
      font-weight: 600;
    }
    .btn-outline:hover {
      background: #f1f5f9;
    }
  </style>
</head>

<body>
<%@ include file="../component/sidebar.jsp" %>
<main class="main-content">
  <%@ include file="../component/header.jsp" %>
  <div class="page-wrapper">

    <!-- Breadcrumb -->
    <nav class="breadcrumb">
      <a href="/admin/home"><i class="fas fa-home"></i> Home</a> /
      <a href="/admin/users">Users</a> /
      <span>Edit User</span>
    </nav>

    <div class="form-card">
      <h2 class="section-title">Update User</h2>

      <form action="${pageContext.request.contextPath}/admin/users/update"
            method="post" enctype="multipart/form-data">

        <input type="hidden" name="id" value="${user.userId}">

        <div class="form-grid">

          <div class="form-group">
            <label for="fullName">Full Name</label>
            <input type="text" id="fullName" name="full_name"
                   value="${user.fullName}" required>
          </div>

          <div class="form-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email"
                   value="${user.email}" required>
          </div>

          <div class="form-group">
            <label for="phone">Phone Number</label>
            <input type="text" id="phone" name="phone_number"
                   value="${user.phone}">
          </div>

          <div class="form-group full-width">
            <label for="address">Address</label>
            <textarea id="address" name="address" rows="3">${user.address}</textarea>
          </div>

          <div class="form-group">
            <label for="role">Role</label>
            <select id="role" name="role">
              <option value="false" ${!user.role ? "selected" : ""}>User</option>
              <option value="true"  ${user.role ? "selected" : ""}>Admin</option>
            </select>
          </div>

        </div>

        <div class="form-actions">
          <button type="reset" class="btn-outline">Reset</button>
          <button type="submit" class="btn-primary">Update User</button>
        </div>

      </form>
    </div>
  </div>
</main>
</body>
</html>
