<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.phonemarket.model.bean.Products,java.util.List" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products Management - PhoneMarket Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/admin-home.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/admin-table.css">
    <style>
        .product-img { width: 40px; height: 40px; border-radius: 8px; object-fit: cover; }
        .no-data { text-align: center; padding: 40px; color: #64748b; }
    </style>
</head>
<body>
<div class="admin-wrapper">
    <!-- Include Sidebar nếu cần (từ trước) -->
    <%@ include file="../component/sidebar.jsp" %>  <!-- Adjust path nếu cần -->

    <!-- Main Content -->
    <main class="main-content">
        <!-- Include Header với Dropdown -->
        <%@ include file="../component/header.jsp" %>

        <!-- Breadcrumb & New Product Button -->
        <div class="breadcrumb-section">
            <nav class="breadcrumb">
                <a href="/admin/home"><i class="fas fa-home"></i> Home</a>
                <span>/</span>
                <a href="#">Ecommerce</a>
                <span>/</span>
                <span>Products</span>
            </nav>
            <button class="btn-new-product" onclick="window.location.href='/admin/products/add'">
                <i class="fas fa-plus"></i>  New Product
            </button>
        </div>

        <!-- Search & Filters -->
        <div class="filter-section">
            <div class="search-input">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="Search products..." id="searchInput" onkeyup="filterTable()">
            </div>
            <div class="filters">
                <button class="btn-filter" onclick="toggleFilters()">More filter</button>
                <select id="categoryFilter" onchange="filterTable()">
                    <option value="">All Categories</option>
                    <option value="accessories">Accessories</option>
                    <option value="bags">Bags</option>
                    <option value="mens-fashion">Men's Fashion</option>
                    <option value="womens-fashion">Women's Fashion</option>
                </select>
                <button class="btn-export"><i class="fas fa-download"></i> Export</button>
            </div>
        </div>

        <!-- Products Table -->
        <div class="table-container">
            <table id="productsTable">
                <thead>
                <tr>
                    <th><input type="checkbox" id="selectAll" onclick="toggleSelectAll()"></th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Quantity</th>

                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <%
                    List<Products> productsList = (List<Products>) request.getAttribute("productsList");
                    if (productsList != null && !productsList.isEmpty()) {
                        for (Products product : productsList) {
                %>
                <tr>
                    <td><input type="checkbox" class="row-checkbox"></td>
                    <td>
                        <div class="product-info">
                            <img src="<%= product.getImage() %>" alt="<%= product.getName() %>" class="product-img">
                            <span><%= product.getName() %></span>
                        </div>
                    </td>


                    <td>$<%= product.getPrice() %></td>
                    <td><%= product.getStock_quantity() %></td>

                    <td class="action-buttons">
                        <a href="/admin/products/view/<%= product.getId() %>" title="View"><i class="fas fa-eye"></i></a>
                        <a href="/admin/products/edit?id=<%= product.getId() %>" title="Edit"><i class="fas fa-edit"></i></a>
                        <a href="/admin/products/delete?id=<%= product.getId() %>" title="Delete" onclick="return confirm('Xóa sản phẩm?')"><i class="fas fa-trash"></i></a>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="8" class="no-data">
                        <i class="fas fa-box-open" style="font-size: 3rem; color: #cbd5e1;"></i>
                        <p>Không có sản phẩm nào. Kiểm tra Controller/DB.</p>
                        <a href="/admin/products/add">Thêm sản phẩm mới</a>
                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>

        <!-- Pagination -->
        <div class="pagination-section">
            <div class="pagination-info">
                Showing 1 to <%
                if (productsList != null) {
                    out.print(productsList.size());
                } else {
                    out.print(0);
                }
            %> of <%
                if (productsList != null) {
                    out.print(productsList.size());
                } else {
                    out.print(0);
                }
            %> entries
            </div>
            <div class="pagination-buttons">
                <button class="btn-pag prev" onclick="changePage(-1)">Previous</button>
                <button class="btn-pag active" onclick="changePage(1)">1</button>
                <button class="btn-pag next" onclick="changePage(1)">Next</button>
            </div>
        </div>
    </main>
</div>

<!-- JS cho search, filter, pagination -->
<script src="/js/admin-script.js"></script>
<script>
    // JS đơn giản cho test (filter/search work trên data giả lập)
    function filterTable() {
        const search = document.getElementById('searchInput').value.toLowerCase();
        const category = document.getElementById('categoryFilter').value;
        const rows = document.querySelectorAll('#productsTable tbody tr');
        let visible = 0;

        rows.forEach(row => {
            const productName = row.cells[1].textContent.toLowerCase();
            const cat = row.cells[2].textContent.toLowerCase();
            const show = productName.includes(search) && (category === '' || cat.includes(category));
            row.style.display = show ? '' : 'none';
            if (show) visible++;
        });

        document.querySelector('.pagination-info').textContent = `Showing 1 to ${visible} of ${visible} entries`;
    }

    function toggleSelectAll() {
        const checkboxes = document.querySelectorAll('.row-checkbox');
        checkboxes.forEach(cb => cb.checked = document.getElementById('selectAll').checked);
    }

    function changePage(direction) {
        console.log('Change page:', direction);  // Test log
    }

    function toggleFilters() {
        console.log('Toggle filters');  // Test log
    }
</script>
</body>
</html>