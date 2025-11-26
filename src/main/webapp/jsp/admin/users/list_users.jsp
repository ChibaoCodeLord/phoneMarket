<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.phonemarket.model.bean.Users,java.util.List" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Users Management - PhoneMarket Admin</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/admin-home.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/admin-table.css">

  <style>
    .no-data { text-align: center; padding: 40px; color: #64748b; }
  </style>
</head>

<body>
<div class="admin-wrapper">

  <%@ include file="../component/sidebar.jsp" %>

  <main class="main-content">

    <%@ include file="../component/header.jsp" %>

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

    <!-- Search -->
    <div class="filter-section">
      <div class="search-input">
        <i class="fas fa-search"></i>
        <input type="text" placeholder="Search users..." id="searchInput" onkeyup="filterTable()">
      </div>
    </div>

    <!-- Users Table -->
    <div class="table-container">
      <table id="usersTable">
        <thead>
        <tr>
          <th><input type="checkbox" id="selectAll" onclick="toggleSelectAll()"></th>
          <th>Full Name</th>
          <th>Username</th>
          <th>Email</th>
          <th>Phone</th>
          <th>Role</th>
          <th>Action</th>
        </tr>
        </thead>

        <tbody>
        <%
          List<Users> usersList = (List<Users>) request.getAttribute("usersList");
          if (usersList != null && !usersList.isEmpty()) {
            for (Users u : usersList) {
        %>

        <tr>
          <td><input type="checkbox" class="row-checkbox"></td>
          <td><%= u.getFullName() %></td>
          <td><%= u.getUsername() %></td>
          <td><%= u.getEmail() %></td>
          <td><%= u.getPhone() %></td>

          <td>
            <% if (u.isRole()) { %>
            <span class="badge-admin">Admin</span>
            <% } else { %>
            <span class="badge-user">User</span>
            <% } %>
          </td>

          <td class="action-buttons">
            <a href="/admin/users/detail?id=<%= u.getUserId() %>" title="View"><i class="fas fa-eye"></i></a>
            <a href="/admin/users/edit?id=<%= u.getUserId() %>" title="Edit"><i class="fas fa-edit"></i></a>
            <a href="/admin/users/delete?id=<%= u.getUserId() %>"
               onclick="return confirm('Xóa người dùng này?')"
               title="Delete"><i class="fas fa-trash"></i></a>
          </td>
        </tr>

        <%
          }
        } else {
        %>
        <tr>
          <td colspan="7" class="no-data">
            <i class="fas fa-user-slash" style="font-size: 3rem; color: #cbd5e1;"></i>
            <p>Không có người dùng nào.</p>
            <a href="/admin/customer/add">Thêm người dùng mới</a>
          </td>
        </tr>
        <% } %>
        </tbody>
      </table>
    </div>

    <!-- Pagination -->
    <div class="pagination-section">
      <div class="pagination-info">
        Showing 1 to
        <%= (usersList != null ? usersList.size() : 0) %>
        of
        <%= (usersList != null ? usersList.size() : 0) %>
        entries
      </div>
      <div class="pagination-buttons">
        <button class="btn-pag prev">Previous</button>
        <button class="btn-pag active">1</button>
        <button class="btn-pag next">Next</button>
      </div>
    </div>

  </main>
</div>

<script src="/js/admin-script.js"></script>
<script>
  function filterTable() {
    const search = document.getElementById('searchInput').value.toLowerCase();
    const rows = document.querySelectorAll('#usersTable tbody tr');
    rows.forEach(row => {
      const name = row.cells[1].textContent.toLowerCase();
      const show = name.includes(search);
      row.style.display = show ? '' : 'none';
    });
  }

  function toggleSelectAll() {
    const checked = document.getElementById('selectAll').checked;
    document.querySelectorAll('.row-checkbox').forEach(cb => cb.checked = checked);
  }
</script>

<style>
  .badge-admin { background: #dc2626; color: white; padding: 4px 8px; border-radius: 6px; }
  .badge-user { background: #3b82f6; color: white; padding: 4px 8px; border-radius: 6px; }
</style>

</body>
</html>
