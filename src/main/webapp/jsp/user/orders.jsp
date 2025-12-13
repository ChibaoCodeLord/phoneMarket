<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử mua hàng</title>
    <link rel="stylesheet" href="/css/home.css" />
    <style>
        .orders-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }
        .orders-title {
            font-size: 1.75rem;
            font-weight: bold;
            margin-bottom: 1.5rem;
            color: #333;
        }
        .orders-table {
            width: 100%;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .orders-table thead {
            background: #f8f9fa;
        }
        .orders-table th {
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            color: #333;
            border-bottom: 2px solid #e0e0e0;
        }
        .orders-table td {
            padding: 1rem;
            border-bottom: 1px solid #f0f0f0;
        }
        .orders-table tbody tr:hover {
            background: #f8f9fa;
        }
        .order-link {
            color: #0066cc;
            text-decoration: none;
        }
        .order-link:hover {
            text-decoration: underline;
        }
        .empty-orders {
            text-align: center;
            padding: 3rem;
            color: #666;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .error-message {
            background: #fee;
            color: #c33;
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
<%@ include file="component/Header.jsp" %>
<div class="orders-container">
    <h1 class="orders-title">Lịch sử mua hàng</h1>

    <c:if test="${not empty error}">
        <div class="error-message">${error}</div>
    </c:if>

    <c:if test="${not empty orders}">
        <table class="orders-table">
            <thead>
            <tr>
                <th>Mã đơn</th>
                <th>Ngày</th>
                <th>Tổng tiền</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="order" items="${orders}">
                <tr>
                    <td>#${order.orderId}</td>
                    <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                    <td style="color: #E30613; font-weight: bold;">
                        <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/>đ
                    </td>
                    <td>${order.status}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/order-detail?id=${order.orderId}" 
                           class="order-link">Chi tiết</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
    <c:if test="${empty orders}">
        <div class="empty-orders">
            <p>Chưa có đơn hàng nào.</p>
        </div>
    </c:if>
</div>
<%@ include file="component/Footer.jsp" %>
</body>
</html>
