<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Products List - PhoneMarket Admin</title>

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">

  <style>
    /* CSS TÙY CHỈNH CHO BẢNG */
    .data-table {
        width: 100%;
        border-collapse: collapse;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
        background-color: white;
        border-radius: 8px;
        margin-top: 20px;
    }
    .data-table th, .data-table td {
        padding: 12px 15px;
        text-align: left;
        border-bottom: 1px solid #dee2e6;
    }
    .data-table th {
        background-color: #f8f9fa; /* Màu nền nhẹ cho tiêu đề cột */
        color: #495057;
        font-weight: 600;
        text-transform: uppercase;
        font-size: 0.9em;
    }
    .data-table img {
        max-width: 60px;
        height: auto;
        display: block;
        border-radius: 4px;
    }
    .actions a {
        margin-right: 10px;
        text-decoration: none;
        color: #007bff;
    }
    .actions a:last-child { color: #dc3545; }

    /* Bố cục header cho trang danh sách */
    .list-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }
    .btn-add {
        background-color: #28a745;
        color: white;
        padding: 8px 15px;
        text-decoration: none;
        border-radius: 5px;
        font-weight: bold;
        display: inline-block;
    }
  </style>

</head>
<body>
<div class="admin-wrapper">

  <aside class="sidebar">
    <div class="sidebar-header">
      <h2><i class="fas fa-mobile-alt"></i> PhoneMarket Admin</h2>
    </div>
    <nav class="sidebar-nav">
      <ul>
        <li><a href="${pageContext.request.contextPath}/admin/home.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/products/" class="active"><i class="fas fa-list"></i> Products List</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/products/add"><i class="fas fa-box"></i> Add Product</a></li>
        </ul>
    </nav>
  </aside>

  <main class="main-content">

    <c:if test="${not empty success}">
      <div class="alert alert-success">${success}</div>
    </c:if>

    <c:if test="${not empty error}">
      <div class="alert alert-danger">${error}</div>
    </c:if>

    <header class="header">
      <h1>Product List</h1>
      <p>Quản lý và xem danh sách các sản phẩm hiện có trong hệ thống.</p>
    </header>

    <section class="data-section">
      <div class="list-header">
        <a href="${pageContext.request.contextPath}/admin/products/add" class="btn-add">
            <i class="fas fa-plus-circle"></i> Add new product
        </a>
      </div>

      <c:set var="list" value="${productsList}" />

      <c:if test="${empty list}">
        <div style="background-color: #fff3cd; color: #856404; padding: 15px; border: 1px solid #ffeeba; border-radius: 4px; margin-top: 15px;">
            <p style="margin: 0;">Hiện chưa có sản phẩm nào được tìm thấy.</p>
        </div>
      </c:if>

      <c:if test="${not empty list}">
        <table class="data-table">
          <thead>
            <tr>
              <th>ID</th>
              <th>Name</th>
              <th>Price</th>
              <th>Stock</th>
              <th>Image</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="p" items="${list}">
              <tr>
                <td>${p.id}</td>
                <td>${p.name}</td>
                <td>${p.price}</td>
                <td>${p.stock_quantity}</td>
                <td>
                    <img src="${pageContext.request.contextPath}${p.image}" alt="${p.name}" />
                </td>
                <td class="actions">
                  <a href="${pageContext.request.contextPath}/admin/products/update?id=${p.id}"><i class="fas fa-edit"></i> Edit</a> |
                  <a href="${pageContext.request.contextPath}/admin/products/delete?id=${p.id}"
                     onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm ID: ${p.id} không?');"><i class="fas fa-trash-alt"></i> Delete</a>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </c:if>
    </section>
  </main>
</div>
</body>
</html>