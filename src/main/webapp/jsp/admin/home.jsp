<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bảng Điều Khiển Quản Trị - PhoneMarket</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="/css/admin/home.css">
  <link rel="stylesheet" href="/css/component/dropdown.css">
  <style>
    .product-img { width: 40px; height: 40px; border-radius: 8px; object-fit: cover; margin-right: 8px; }
    .no-data { text-align: center; padding: 40px; color: #64748b; }
    .top-product-item { display: flex; align-items: center; gap: 12px; margin-bottom: 8px; }
  </style>
</head>
<body>
<div class="admin-wrapper">
  <!-- Sidebar Menu (CRUD Functions) -->
  <%@ include file="/jsp/admin/component/sidebar.jsp" %>

  <!-- Main Content -->
  <main class="main-content">
    <!-- Header -->
    <%@ include file="/jsp/admin/component/header.jsp" %>

    <!-- Thống kê tổng -->
    <section class="stats-grid">
      <div class="stat-card">
        <div class="stat-icon"><i class="fas fa-users"></i></div>
        <div class="stat-info">
          <h3>${totalUsers}</h3>
          <p>Tổng Người Dùng</p>
        </div>
      </div>
      <div class="stat-card">
        <div class="stat-icon"><i class="fas fa-mobile-screen-button"></i></div>
        <div class="stat-info">
          <h3>${totalProducts}</h3>
          <p>Tổng Sản Phẩm</p>
        </div>
      </div>
      <div class="stat-card">
        <div class="stat-icon"><i class="fas fa-dollar-sign"></i></div>
        <div class="stat-info">
          <h3><fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="$" /></h3>
          <p>Tổng Doanh Thu</p>
        </div>
      </div>
      <div class="stat-card">
        <div class="stat-icon"><i class="fas fa-shopping-cart"></i></div>
        <div class="stat-info">
          <h3>${totalOrders}</h3>
          <p>Tổng Đơn Hàng</p>
        </div>
      </div>
    </section>

    <!-- Biểu đồ Doanh Thu Tháng -->
    <section class="charts-section">
      <div class="chart-card">
        <h3>Doanh Thu Theo Tháng</h3>
        <div class="bar-chart">
          <c:forEach var="month" items="${monthlySales}" varStatus="status">
            <div class="bar" style="height: ${month.value * 2}px; background: ${status.index % 2 == 0 ? '#3b82f6' : '#10b981'}">
              <span>${month.label}</span>
            </div>
          </c:forEach>
        </div>
      </div>

      <!-- Sản phẩm bán chạy (với ảnh) -->
      <div class="chart-card">
        <h3>Sản Phẩm Bán Chạy</h3>
        <ul>
          <c:forEach var="item" items="${topSellingProducts}">
            <li class="top-product-item">
              <img src="${item.image}" alt="${item.label}" class="product-img">
              <span>${item.label} - ${item.value} sản phẩm</span>
            </li>
          </c:forEach>
        </ul>
      </div>

      <!-- Đơn hàng theo trạng thái -->
      <div class="chart-card">
        <h3>Đơn Hàng Theo Trạng Thái</h3>
        <ul>
          <c:forEach var="entry" items="${orderStatusCount}">
            <li>${entry.key}: ${entry.value} đơn</li>
          </c:forEach>
        </ul>
      </div>

      <!-- Doanh thu theo sản phẩm (với ảnh) -->
      <div class="chart-card">
        <h3>Doanh Thu Theo Sản Phẩm</h3>
        <ul>
          <c:forEach var="item" items="${revenueByProduct}">
            <li class="top-product-item">
              <img src="${item.image}" alt="${item.label}" class="product-img">
              <span>${item.label}: $<fmt:formatNumber value="${item.value}" type="currency" currencySymbol=""/></span>
            </li>
          </c:forEach>
        </ul>
      </div>

      <!-- Người dùng theo role -->
      <div class="chart-card">
        <h3>Người Dùng Theo Role</h3>
        <ul>
          <c:forEach var="entry" items="${usersByRole}">
            <li>${entry.key}: ${entry.value} người</li>
          </c:forEach>
        </ul>
      </div>
    </section>

    <!-- Bảng Đơn Hàng Gần Đây -->
    <section class="table-section">
      <div class="table-card">
        <h3>Đơn Hàng Gần Đây</h3>
        <table>
          <thead>
          <tr>
            <th>ID</th>
            <th>Khách Hàng</th>
            <th>Sản Phẩm</th>
            <th>Trạng Thái</th>
            <th>Thành Tiền</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach var="order" items="${recentOrders}">
            <tr>
              <td>${order.orderId}</td>
              <td>${order.customerName}</td>
              <td>${order.productNames}</td>
              <td><span class="status pending">${order.status}</span></td>
              <td>$<fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol=""/></td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
    </section>
  </main>
</div>

<script>
  // Toggle sidebar
  document.querySelector('.menu-toggle')?.addEventListener('click', () => {
    document.querySelector('.sidebar')?.classList.toggle('collapsed');
  });
</script>
<script src="/js/admin/dropdown.js"></script>
</body>
</html>