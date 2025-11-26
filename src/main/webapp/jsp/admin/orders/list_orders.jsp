<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.phonemarket.model.bean.Orders,java.util.List" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Orders Management - PhoneMarket Admin</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="/css/admin/admin-home.css">
  <link rel="stylesheet" href="/css/admin/admin-table.css">
  <style>
    .no-data { text-align: center; padding: 40px; color: #64748b; }
    .status-badge { padding: 4px 8px; border-radius: 6px; font-size: 12px; font-weight: bold; }
    .status-pending { background: #fef3c7; color: #d97706; }
    .status-processing { background: #dbeafe; color: #1d4ed8; }
    .status-shipped { background: #dcfce7; color: #16a34a; }
    .status-completed { background: #ecfdf5; color: #059669; }
    .status-cancelled { background: #fef2f2; color: #dc2626; }
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
        <span>/</span><span>Orders</span>
      </nav>


    </div>

    <!-- Search -->
    <div class="filter-section">
      <div class="search-input">
        <i class="fas fa-search"></i>
        <input type="text" placeholder="Search orders by customer or product..." id="searchInput" onkeyup="filterTable()">
      </div>
    </div>

    <!-- Orders Table -->
    <div class="table-container">
      <table id="ordersTable">
        <thead>
        <tr>
          <th><input type="checkbox" id="selectAll" onclick="toggleSelectAll()"></th>
          <th>ID</th>
          <th>Customer</th>
          <th>Product</th>
          <th>Date</th>
          <th>Amount</th>
          <th>Status</th>
          <th>Action</th>
        </tr>
        </thead>

        <tbody>
        <%
          List<Orders> ordersList = (List<Orders>) request.getAttribute("ordersList");
          if (ordersList != null && !ordersList.isEmpty()) {
            for (Orders o : ordersList) {
        %>

        <tr>
          <td><input type="checkbox" class="row-checkbox"></td>
          <td><%= o.getOrderId() %></td>
          <td><%= o.getCustomerName() %></td>  <!-- Từ JOIN users -->
          <td><%= o.getProductNames() %></td>  <!-- Concat từ products -->
          <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(o.getOrderDate()) %></td>
          <td>$<%= o.getTotalAmount() %></td>
          <td>
            <span class="status-badge status-<%= o.getStatus().toLowerCase() %>">
              <%= o.getStatus() %>
            </span>
          </td>
          <td class="action-buttons">
            <a href="/admin/orders/view?id=<%= o.getOrderId() %>" title="View"><i class="fas fa-eye"></i></a>
            <a href="/admin/orders/edit?id=<%= o.getOrderId() %>" title="Edit"><i class="fas fa-edit"></i></a>
            <a href="/admin/orders/delete?id=<%= o.getOrderId() %>"
               onclick="return confirm('Xóa đơn hàng này?')"
               title="Delete"><i class="fas fa-trash"></i></a>
          </td>
        </tr>

        <%
          }
        } else {
        %>
        <tr>
          <td colspan="8" class="no-data">
            <i class="fas fa-shopping-cart" style="font-size: 3rem; color: #cbd5e1;"></i>
            <p>Không có đơn hàng nào.</p>
            <a href="/admin/orders/add">Tạo đơn hàng mới</a>
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
        <%= (ordersList != null ? ordersList.size() : 0) %>
        of
        <%= (ordersList != null ? ordersList.size() : 0) %>
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
    const rows = document.querySelectorAll('#ordersTable tbody tr');
    rows.forEach(row => {
      const customer = row.cells[2].textContent.toLowerCase();  // Customer column
      const product = row.cells[3].textContent.toLowerCase();  // Product column
      const show = customer.includes(search) || product.includes(search);
      row.style.display = show ? '' : 'none';
    });
  }

  function toggleSelectAll() {
    const checked = document.getElementById('selectAll').checked;
    document.querySelectorAll('.row-checkbox').forEach(cb => cb.checked = checked);
  }
</script>

<style>
  .status-badge { padding: 4px 8px; border-radius: 6px; font-size: 12px; font-weight: bold; }
  .status-pending { background: #fef3c7; color: #d97706; }
  .status-processing { background: #dbeafe; color: #1d4ed8; }
  .status-shipped { background: #dcfce7; color: #16a34a; }
  .status-completed { background: #ecfdf5; color: #059669; }
  .status-cancelled { background: #fef2f2; color: #dc2626; }
</style>

</body>
</html>