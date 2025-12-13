<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn hàng</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/css/home.css" />
    <style>
        .order-detail-container {
            max-width: 1000px;
            margin: 2rem auto;
            padding: 2rem;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .order-header {
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 1.5rem;
            margin-bottom: 2rem;
        }
        .order-header h2 {
            color: #333;
            margin-bottom: 0.5rem;
        }
        .order-header p {
            color: #666;
            margin: 0.5rem 0;
        }
        .status-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: bold;
            margin-top: 0.5rem;
        }
        .status-pending { background: #fef3c7; color: #d97706; }
        .status-processing { background: #dbeafe; color: #1d4ed8; }
        .status-shipped { background: #dcfce7; color: #16a34a; }
        .status-completed { background: #ecfdf5; color: #059669; }
        .status-cancelled { background: #fef2f2; color: #dc2626; }
        .customer-info, .order-items {
            margin: 2rem 0;
        }
        .customer-info h3, .order-items h3 {
            color: #333;
            margin-bottom: 1rem;
            font-size: 1.25rem;
        }
        .customer-info p {
            margin: 0.5rem 0;
            color: #666;
        }
        .order-items-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }
        .order-items-table thead {
            background: #f8f9fa;
        }
        .order-items-table th {
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            color: #333;
            border-bottom: 2px solid #e0e0e0;
        }
        .order-items-table td {
            padding: 1rem;
            border-bottom: 1px solid #f0f0f0;
        }
        .product-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        .product-img-detail {
            width: 60px;
            height: 60px;
            border-radius: 8px;
            object-fit: cover;
        }
        .order-total {
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 2px solid #e0e0e0;
            text-align: right;
        }
        .order-total h4 {
            font-size: 1.5rem;
            color: #E30613;
            margin: 0;
        }
        .order-actions {
            margin-top: 2rem;
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
        }
        .btn-back {
            display: inline-block;
            padding: 10px 20px;
            background: #6c757d;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            transition: background 0.3s;
        }
        .btn-back:hover {
            background: #5a6268;
        }
    </style>
</head>
<body>
<%@ include file="component/Header.jsp" %>

<div class="order-detail-container">
    <div class="order-header">
        <h2>Đơn hàng #${order.orderId}</h2>
        <p>
            Đặt hàng ngày
            <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" />
        </p>
        <span class="status-badge status-${fn:toLowerCase(order.status)}">
            ${order.status}
        </span>
    </div>

    <!-- Customer Info -->
    <div class="customer-info">
        <h3>Thông tin giao hàng</h3>
        <p><strong>Địa chỉ:</strong> ${order.shippingAddress}</p>
    </div>

    <!-- Order Items -->
    <div class="order-items">
        <h3>Sản phẩm đã mua</h3>

        <table class="order-items-table">
            <thead>
            <tr>
                <th>Sản phẩm</th>
                <th>Số lượng</th>
                <th>Đơn giá</th>
                <th>Thành tiền</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="detail" items="${orderItems}">
                <tr>
                    <td>
                        <div class="product-info">
                            <c:choose>
                                <c:when test="${not empty detail.productImage}">
                                    <img src="${pageContext.request.contextPath}${detail.productImage}" 
                                         class="product-img-detail" 
                                         alt="${detail.productName}">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/assets/images/products/default.png" 
                                         class="product-img-detail" 
                                         alt="${detail.productName}">
                                </c:otherwise>
                            </c:choose>
                            <span>${detail.productName}</span>
                        </div>
                    </td>
                    <td>${detail.quantity}</td>
                    <td>
                        <fmt:formatNumber value="${detail.priceAtPurchase}" pattern="#,##0"/>đ
                    </td>
                    <td>
                        <fmt:formatNumber value="${detail.quantity * detail.priceAtPurchase}" pattern="#,##0"/>đ
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <div class="order-total">
            <h4>
                Tổng tiền:
                <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/>đ
            </h4>
        </div>
    </div>

    <!-- Actions -->
    <div class="order-actions">
        <a href="${pageContext.request.contextPath}/orders" class="btn-back">
            <i class="fas fa-arrow-left"></i> Quay lại
        </a>
    </div>
</div>

<%@ include file="component/Footer.jsp" %>
</body>
</html>

