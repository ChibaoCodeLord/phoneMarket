<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Edit Order - PhoneMarket Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/css/admin/home.css">
    <link rel="stylesheet" href="/css/admin/admin-table.css">
    <style>
        .edit-container {
            background: white;
            padding: 25px;
            margin: 20px;
            border-radius: 12px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }

        .edit-container h2 {
            margin-bottom: 15px;
            color: #1e293b;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .form-group label {
            font-weight: bold;
            color: #475569;
            margin-bottom: 5px;
            display: block;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
        }

        .order-items-table img {
            width: 50px;
            border-radius: 8px;
        }

        .btn-submit {
            background: #2563eb;
            color: white;
            padding: 12px 20px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
        }

        .btn-back {
            padding: 12px 20px;
            border-radius: 8px;
            border: 1px solid #94a3b8;
            color: #475569;
            text-decoration: none;
            margin-left: 10px;
        }
    </style>
</head>

<body>

<div class="admin-wrapper">

    <%@ include file="../component/sidebar.jsp" %>

    <main class="main-content">

        <%@ include file="../component/header.jsp" %>

        <div class="edit-container">

            <h2>Edit Order #${order.orderId}</h2>

            <!-- FORM UPDATE -->
            <form action="/admin/orders/edit" method="post">

                <input type="hidden" name="orderId" value="${order.orderId}">
                <input type="hidden" name="userId" value="${order.userId}">

                <div class="form-grid">

                    <div class="form-group">
                        <label>Order Date</label>

                        <fmt:formatDate value="${order.orderDate}"
                                        pattern="yyyy-MM-dd'T'HH:mm"
                                        var="formattedDate"/>

                        <input type="datetime-local"
                               name="orderDate"
                               value="${formattedDate}"
                               required>
                    </div>


                    <div class="form-group">
                        <label>Total Amount ($)</label>
                        <input type="number"
                               step="0.01"
                               name="totalAmount"
                               value="${order.totalAmount}"
                               required>
                    </div>

                    <div class="form-group">
                        <label>Shipping Address</label>
                        <input type="text"
                               name="shippingAddress"
                               value="${order.shippingAddress}"
                               required>
                    </div>

                    <div class="form-group">
                        <label>Status</label>
                        <select name="status" required>
                            <option ${order.status == "Pending" ? "selected" : ""}>Pending</option>
                            <option ${order.status == "Processing" ? "selected" : ""}>Processing</option>
                            <option ${order.status == "Shipped" ? "selected" : ""}>Shipped</option>
                            <option ${order.status == "Completed" ? "selected" : ""}>Completed</option>
                            <option ${order.status == "Cancelled" ? "selected" : ""}>Cancelled</option>
                        </select>
                    </div>

                </div>

                <h3 style="margin-top: 30px;">Order Items</h3>

                <table class="order-items-table">
                    <thead>
                    <tr>
                        <th>Product</th>
                        <th>Qty</th>
                        <th>Price</th>
                        <th>Total</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach var="item" items="${orderItems}">
                        <tr>
                            <td>
                                <img src="${item.productImage}">
                                    ${item.productName}
                            </td>
                            <td>${item.quantity}</td>
                            <td>$${item.priceAtPurchase}</td>
                            <td>$<fmt:formatNumber value="${item.quantity * item.priceAtPurchase}" minFractionDigits="2"/></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <button class="btn-submit" type="submit">
                    <i class="fa fa-save"></i> Save Changes
                </button>

                <a href="/admin/orders" class="btn-back">Back</a>
            </form>

        </div>

    </main>
</div>

</body>
</html>
