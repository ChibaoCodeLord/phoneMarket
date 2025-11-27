<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Update User - PhoneMarket Admin</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="/css/admin/admin-home.css">
  <link rel="stylesheet" href="/css/component/update-form.css">
</head>
<body>
<div class="admin-wrapper">

  <!-- Sidebar -->
  <%@ include file="../component/sidebar.jsp" %>

  <!-- Main Content -->
  <main class="main-content">

    <!-- Breadcrumb -->
    <div class="breadcrumb-section">
      <nav class="breadcrumb">
        <a href="/admin/home"><i class="fas fa-home"></i> Home</a>
        <span>/</span><span>Users</span>
      </nav>

      <button class="btn-new-product" onclick="window.location.href='/admin/customer/add'">
        <i class="fas fa-plus"></i> New User
      </button>
    </div>
    <!-- Lấy thông tin user -->
    <c:set var="user" value="${user}" />

    <!-- Update Form -->
    <section class="form-section">
      <form action="${pageContext.request.contextPath}/admin/users/update"
            method="post" class="user-form" enctype="multipart/form-data">

        <input type="hidden" name="id" value="${user.userId}">

        <div class="form-grid">

          <div class="form-group">
            <label for="fullName">Full Name</label>
            <input type="text" id="fullName" name="full_name" value="${user.fullName}" required>
          </div>

          <div class="form-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" value="${user.email}" required>
          </div>

          <div class="form-group">
            <label for="phone">Phone Number</label>
            <input type="text" id="phone" name="phone_number" value="${user.phone}">
          </div>

          <div class="form-group full-width">
            <label for="address">Address</label>
            <textarea id="address" name="address" rows="3">${user.address}</textarea>
          </div>

<%--          <!-- Avatar hiển thị -->--%>
<%--          <div class="form-group">--%>
<%--            <img class="product-image-thumb"--%>
<%--                 src="${pageContext.request.contextPath}${user.avatar}"--%>
<%--                 alt="${user.full_name}">--%>
<%--          </div>--%>

<%--          <!-- Upload avatar file -->--%>
<%--          <div class="form-group">--%>
<%--            <label for="imageURL">Avatar Image</label>--%>
<%--            <input type="file" id="imageURL" name="avatarFile">--%>
<%--          </div>--%>

          <!-- Role -->
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
    </section>
  </main>
</div>
</body>
</html>
