<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Order Detail - PhoneMarket Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/css/admin/admin-home.css">
    <link rel="stylesheet" href="/css/admin/admin-profile.css">
    <style>
        .order-section { margin-top: 20px; background: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 2px 4px rgba(0,0,0,0.08); }
        .order-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }
        .order-id { font-size: 26px; font-weight: 700; color: #1e293b; }
        .status-badge { padding: 6px 12px; border-radius: 6px; font-size: 14px; font-weight: 600; color: #fff; }
        .pending { background: #facc15; }
        .processing { background: #3b82f6; }
        .shipped { background: #8b5cf6; }
        .completed { background: #10b981; }
        .cancelled { background: #f87171; }
        .product-list { margin-top: 15px; }
        .product-item { display: flex; align-items: center; margin-bottom: 15px; background: #f8fafc; padding: 12px; border-radius: 8px; }
        .product-item img { width: 70px; height: 70px; object-fit: contain; margin-right: 15px; background: #fff; border: 1px solid #e2e8f0; border-radius: 8px; }
        .product-info { flex-grow: 1; }
        .product-title { font-size: 16px; font-weight: 600; color: #1e293b; }
        .product-detail { font-size: 14px; color: #475569; }
        .info-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 15px; }
        .info-item { display: flex; flex-direction: column; }
        .info-label { color: #64748b; font-weight: 600; margin-bottom: 4px; }
        .info-value { font-size: 16px; color: #1e293b; }
        .action-buttons { margin-top: 20px; text-align: right; }
        .btn-cancel, .btn-complete { padding: 10px 18px; border-radius: 6px; cursor: pointer; color: #fff; font-weight: 600; border: none; }
        .btn-cancel { background: #ef4444; }
        .btn-complete { background: #10b981; }
    </style>
</head>
<body>

<div class="profile-container">

    <%@ include file="../component/sidebar.jsp" %>

    <!-- Breadcrumb -->
    <nav class="breadcrumb">
        <a href="/admin/home"><i class="fas fa-home"></i> Home</a>
        <span>/</span>
        <a href="/admin/orders/">Orders</a>
        <span>/</span>
        <span>Order Detail</span>
    </nav>

    <!-- MAIN ORDER DETAIL SECTION -->
    <div class="order-section">
        <div class="order-header">
            <h1 class="order-id">Order #<c:out value="${order.orderId}"/></h1>

            <!-- BADGE STATUS -->
            <span class="status-badge
                <c:out value="${order.status.toLowerCase()}"/>">
                <c:out value="${order.status}"/>
            </span>
        </div>

        <!-- CUSTOMER INFORMATION -->
        <h2 class="section-title">Customer Information</h2>
        <div class="info-grid">
            <div class="info-item">
                <span class="info-label">Customer Name</span>
                <span class="info-value"><c:out value="${order.customerName}"/></span>
            </div>
            <div class="info-item">
                <span class="info-label">User ID</span>
                <span class="info-value"><c:out value="${order.userId}"/></span>
            </div>
            <div class="info-item">
                <span class="info-label">Order Date</span>
                <span class="info-value"><c:out value="${order.orderDate}"/></span>
            </div>
            <div class="info-item">
                <span class="info-label">Shipping Address</span>
                <span class="info-value"><c:out value="${order.shippingAddress}"/></span>
            </div>
        </div>

        <hr style="margin: 25px 0; border: 0; border-top: 2px solid #e2e8f0;">

        <!-- PRODUCT LIST -->
        <h2 class="section-title">Products</h2>

        <div class="product-list">

            <c:set var="names" value="${fn:split(order.productNames, ', ')}"/>
            <c:set var="images" value="${fn:split(order.productImages, ', ')}"/>
            <c:set var="details" value="${fn:split(order.detailItems, ', ')}"/>

            <c:forEach var="i" begin="0" end="${fn:length(names)-1}">
                <div class="product-item">
                    <img src="${images[i]}" alt="Product Image">
                    <div class="product-info">
                        <p class="product-title">${names[i]}</p>
                        <p class="product-detail">${details[i]}</p>
                    </div>
                </div>
            </c:forEach>

        </div>

        <hr style="margin: 25px 0; border: 0; border-top: 2px solid #e2e8f0;">

        <!-- ORDER SUMMARY -->
        <h2 class="section-title">Order Summary</h2>
        <div class="info-item">
            <span class="info-label">Total Amount</span>
            <span class="info-value" style="font-size: 20px; font-weight: 700; color: #16a34a;">
                $<c:out value="${order.totalAmount}"/>
            </span>
        </div>

        <!-- ACTION BUTTONS -->
        <div class="action-buttons">
            <c:if test="${order.status != 'Cancelled' && order.status != 'Completed'}">
                <button class="btn-cancel" onclick="location.href='/admin/orders/delete?id=${order.orderId}'">
                    Cancel Order
                </button>
            </c:if>

            <c:if test="${order.status != 'Completed'}">
                <button class="btn-complete" onclick="alert('Cập nhật trạng thái sau này');">
                    Mark as Completed
                </button>
            </c:if>
        </div>
    </div>

</div>
</body>
</html>
