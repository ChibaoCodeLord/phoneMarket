<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Add Product - PhoneMarket Admin</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="../../css/admin.css">

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
        <li><a href="${pageContext.request.contextPath}/admin/products/"><i class="fas fa-list"></i> Products List</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/products/add" class="active"><i class="fas fa-box"></i> Add Product</a></li>
      </ul>
    </nav>
  </aside>
  <main class="main-content">
    <header class="header">
      <h1>Update Product</h1>
      <p>Change in the product details to update into the catalog.</p>
    </header>

    <c:set var="product" value="${product}" />

    <section class="form-section">
        <%-- functype="multipart/form-data" cho phép gửi dữ liệu file  --%>
      <form action="${pageContext.request.contextPath}/admin/products/update" method="post" class="product-form" enctype="multipart/form-data">
        <div class="form-grid">
            <input type="hidden" name="id" value="${product.id}">
          <div class="form-group">
            <label for="name">Product Name</label>
            <input type="text" id="name" name="name" value="${product.name}" required>
          </div>

          <div class="form-group">
            <label for="price">Price (USD)</label>
            <input type="number" step="0.01" id="price" name="price" value="${product.price}" required>
          </div>

          <div class="form-group">
            <label for="stock">Stock Quantity</label>
            <input type="number" id="stock" name="stock_quantity" min="0" value="${product.stock_quantity}" required>
          </div>

          <div class="form-group full-width">
            <label for="description">Description</label>
            <textarea id="description" name="description" rows="3" >${product.description}</textarea>
          </div>

          <div class="form-group">
              <img class="product-image-thumb" src="${pageContext.request.contextPath}${product.image}" alt="${product.name}" />
           </div>

          <div class="form-group">
            <label for="imageURL">Image file</label>
            <input type="file" id="imageURL" name="imageUrl" value="${param.imageUrl}">
          </div>
        </div>

        <div class="form-actions">
          <button type="reset" class="btn-outline">Reset</button>
          <button type="submit" class="btn-primary">Update Product</button>
        </div>
      </form>
    </section>
  </main>
</div>
</body>
</html>