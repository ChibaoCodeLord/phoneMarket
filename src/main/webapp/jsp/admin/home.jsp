<%@ page import="com.phonemarket.model.bean.Orders" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard - PhoneMarket</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="/css/admin/admin-home.css">
  <link rel="stylesheet" href="/css/component/dropdown.css">
</head>
<body>
<div class="admin-wrapper">
  <!-- Sidebar Menu (CRUD Functions) -->
  <%@ include file="/jsp/admin/component/sidebar.jsp" %>

  <!-- Main Content -->
  <main class="main-content">
    <!-- Header -->
    <%@ include file="/jsp/admin/component/header.jsp" %>

    <!-- Stats Cards -->
    <section class="stats-grid">
      <div class="stat-card">
        <div class="stat-icon"><i class="fas fa-users"></i></div>
        <div class="stat-info">
          <h3><%= request.getAttribute("totalUsers") %></h3>
          <p>Total Users</p>
        </div>
      </div>

      <div class="stat-card">
        <div class="stat-icon"><i class="fas fa-mobile-screen-button"></i></div>
        <div class="stat-info">
          <h3><%= request.getAttribute("totalProducts") %></h3>
          <p>Total Products</p>
        </div>
      </div>

      <div class="stat-card">
        <div class="stat-icon"><i class="fas fa-dollar-sign"></i></div>
        <div class="stat-info">
          <h3><%= request.getAttribute("totalRevenue") %></h3>
          <p>Total Revenue</p>
        </div>
      </div>

      <div class="stat-card">
        <div class="stat-icon"><i class="fas fa-shopping-cart"></i></div>
        <div class="stat-info">
          <h3><%= request.getAttribute("totalOrders") %></h3>
          <p>Total Orders</p>
        </div>
      </div>
    </section>

    <!-- Charts Section -->
    <section class="charts-section">
      <div class="chart-card">
        <h3>Monthly Sales</h3>
        <div class="bar-chart">
          <%
            java.util.List monthlySales = (java.util.List) request.getAttribute("monthlySales");

            // Tìm giá trị lớn nhất để scale
            double maxValue = 0;
            for (Object obj : monthlySales) {
              com.phonemarket.model.bean.MonthlySale month = (com.phonemarket.model.bean.MonthlySale) obj;
              if (month.getValue() > maxValue) maxValue = month.getValue();
            }

            int chartMaxHeight = 200; // chiều cao tối đa của chart (px)

            for (int i = 0; i < monthlySales.size(); i++) {
              com.phonemarket.model.bean.MonthlySale month = (com.phonemarket.model.bean.MonthlySale) monthlySales.get(i);
              String color = (i % 2 == 0) ? "#3b82f6" : "#10b981";
              // Tính chiều cao tỷ lệ
              int barHeight = (int) ((month.getValue() / maxValue) * chartMaxHeight);
          %>
          <div class="bar" style="height: <%= barHeight %>px; background: <%= color %>;">
            <span><%= month.getLabel() %></span>
          </div>
          <% } %>
        </div>

      </div>
    </section>

    <!-- Table Section -->
    <section class="table-section">
      <div class="table-card">
        <h3>Recent Orders</h3>
        <table>
          <thead>
          <tr>
            <th>ID</th>
            <th>Customer</th>
            <th>Product</th>
            <th>Status</th>
            <th>Amount</th>
          </tr>
          </thead>
          <tbody>
          <%
            java.util.List recentOrders = (java.util.List) request.getAttribute("recentOrders");
            for (Object obj : recentOrders) {
              Orders order = (Orders) obj;
          %>
          <tr>
            <td><%= order.getId() %></td>
            <td><%= order.getCustomer() %></td>
            <td><%= order.getProduct() %></td>
            <td><span class="status pending"><%= order.getStatus() %></span></td>
            <td>$<%= order.getAmount() %></td>
          </tr>
          <% } %>
          </tbody>
        </table>
      </div>
    </section>
  </main>
</div>

<script>
  // Simple JS cho menu toggle và chart (tùy chọn)
  document.querySelector('.menu-toggle').addEventListener('click', () => {
    document.querySelector('.sidebar').classList.toggle('collapsed');
  });
  // Nếu dùng Chart.js, thêm <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> và code canvas
</script>
<script src="/js/admin/dropdown.js"></script>
</body>
</html>