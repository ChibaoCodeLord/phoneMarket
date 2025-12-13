<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng của bạn | CellphoneS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body { font-family: 'Inter', sans-serif; }
    </style>
</head>
<body class="bg-gray-50 min-h-screen">

<!-- Header nhỏ (khi vào giỏ hàng) -->
<div class="bg-white shadow-sm border-b">
    <div class="max-w-6xl mx-auto px-4 py-4 flex items-center gap-4">
        <a href="javascript:history.back()" class="text-gray-700 hover:text-red-600">
            <i class="fas fa-arrow-left text-xl"></i>
        </a>
        <h1 class="text-xl font-bold text-gray-900">Giỏ hàng của bạn</h1>
    </div>
</div>

<!-- Nội dung chính -->
<div class="max-w-4xl mx-auto px-4 py-12">

    <c:set var="cart" value="${sessionScope.cart}" />
    <c:choose>
        <c:when test="${empty cart}">
            <!-- Giỏ hàng trống -->
            <div class="text-center">
                <img src="https://cdn2.cellphones.com.vn/x,webp/media/cart/Cart-empty-v2.png"
                     alt="Giỏ hàng trống"
                     class="w-80 mx-auto">
                <h2 class="text-2xl font-bold text-gray-800 mb-3 mt-10">
                    Giỏ hàng của bạn đang trống.
                </h2>
                <p class="text-lg text-gray-600">
                    Hãy chọn thêm sản phẩm để mua sắm nhé
                </p>
                <div class="mt-12">
                    <a href="${pageContext.request.contextPath}/home"
                       class="inline-block bg-red-600 hover:bg-red-700 text-white font-bold text-lg px-12 py-4 rounded-full shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-300">
                        <i class="fas fa-home mr-2"></i>
                        Quay lại trang chủ
                    </a>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <!-- Danh sách sản phẩm trong giỏ hàng -->
            <div class="bg-white rounded-2xl shadow-lg p-6 mb-6">
                <h2 class="text-2xl font-bold mb-6">Sản phẩm trong giỏ</h2>
                <table class="w-full text-left">
                    <thead>
                    <tr class="border-b">
                        <th class="py-3">Sản phẩm</th>
                        <th class="py-3">Giá</th>
                        <th class="py-3">Số lượng</th>
                        <th class="py-3">Tổng</th>
                        <th class="py-3">Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${cart}">
                        <tr class="border-b">
                            <td class="py-4">
                                <div class="flex items-center gap-4">
                                    <img src="${item.product.image}" alt="${item.product.name}" class="w-16 h-16 object-contain rounded">
                                    <span>${item.product.name}</span>
                                </div>
                            </td>
                            <td class="py-4"><fmt:formatNumber value="${item.product.price}" pattern="#,##0"/>đ</td>
                            <td class="py-4">${item.quantity}</td>
                            <td class="py-4"><fmt:formatNumber value="${item.totalPrice}" pattern="#,##0"/>đ</td>
                            <td class="py-4">
                                <a href="${pageContext.request.contextPath}/remove-from-cart?id=${item.product.id}" class="text-red-600 hover:text-red-800">
                                    <i class="fas fa-trash"></i> Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Tổng tiền -->
            <div class="bg-white rounded-2xl shadow-lg p-6 mb-6 text-right">
                <h3 class="text-xl font-bold">
                    Tổng cộng:
                    <span class="text-red-600">
                        <fmt:formatNumber value="${cart.stream().mapToDouble(item -> item.totalPrice).sum()}" pattern="#,##0"/>đ
                    </span>
                </h3>
            </div>

            <!-- Nút thanh toán -->
            <div class="text-center">
                <a href="${pageContext.request.contextPath}/checkout" class="inline-block bg-red-600 hover:bg-red-700 text-white font-bold text-lg px-12 py-4 rounded-full shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-300">
                    <i class="fas fa-credit-card mr-2"></i>
                    Tiến hành thanh toán
                </a>
            </div>
        </c:otherwise>
    </c:choose>

</div>

</body>
</html>