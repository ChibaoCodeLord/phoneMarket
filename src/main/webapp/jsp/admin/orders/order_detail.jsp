<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Detail - PhoneMarket Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/css/admin/home.css">
    <link rel="stylesheet" href="/css/admin/admin-table.css">
    <link rel="stylesheet" href="/css/admin/order-detail.css">
    <style>
        .status-badge { padding: 4px 8px; border-radius: 6px; font-size: 12px; font-weight: bold; }
        .status-pending { background: #fef3c7; color: #d97706; }
        .status-processing { background: #dbeafe; color: #1d4ed8; }
        .status-shipped { background: #dcfce7; color: #16a34a; }
        .status-completed { background: #ecfdf5; color: #059669; }
        .status-cancelled { background: #fef2f2; color: #dc2626; }
        .product-img-detail { width: 60px; height: 60px; border-radius: 8px; object-fit: cover; }
    </style>
</head>

<body>
<div class="admin-wrapper">

    <%@ include file="../component/sidebar.jsp" %>

    <main class="main-content">
        <!-- Order Detail -->
        <%@ include file="../component/header.jsp" %>
        <div class="order-detail-container">
            <div class="order-header">
                <h2>Order #${order.orderId}</h2>

                <p>
                    Placed on
                    <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" />
                </p>

                <span class="status-badge status-${order.status.toLowerCase()}">
                    ${order.status}
                </span>
            </div>

            <!-- Customer Info -->
            <div class="customer-info">
                <h3>Customer Information</h3>
                <p><strong>Name:</strong> ${order.customerName}</p>
                <p><strong>Email:</strong> ${order.customerEmail}</p>
                <p><strong>Phone:</strong> ${order.customerPhone}</p>
                <p><strong>Shipping Address:</strong> ${order.shippingAddress}</p>
            </div>

            <!-- Order Items -->
            <div class="order-items">
                <h3>Order Items</h3>

                <table class="order-items-table">
                    <thead>
                    <tr>
                        <th>Product</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Total</th>
                    </tr>
                    </thead>

                    <tbody>

                    <!-- CHỈNH TẠI ĐÂY -->
                    <c:forEach var="detail" items="${orderItems}">
                        <tr>
                            <td>
                                <div class="product-info">
                                    <img src="${detail.productImage}" class="product-img-detail" alt="">
                                    <span>${detail.productName}</span>
                                </div>
                            </td>

                            <td>${detail.quantity}</td>

                            <td>
                                $<fmt:formatNumber value="${detail.priceAtPurchase}" minFractionDigits="2" />
                            </td>

                            <td>
                                $<fmt:formatNumber value="${detail.quantity * detail.priceAtPurchase}" minFractionDigits="2" />
                            </td>
                        </tr>
                    </c:forEach>
                    <!-- HẾT CHỈNH -->

                    </tbody>
                </table>

                <div class="order-total">
                    <h4>
                        Total Amount:
                        $<fmt:formatNumber value="${order.totalAmount}" minFractionDigits="2" />
                    </h4>
                </div>
            </div>

            <!-- Actions -->
            <div class="order-actions">
                <button class="btn-primary" onclick="window.print()">Print Order</button>
                <a href="/admin/orders" class="btn-outline">Back to Orders</a>
            </div>
        </div>

    </main>
</div>

<script src="/js/admin-script.js"></script>
</body>
</html>
