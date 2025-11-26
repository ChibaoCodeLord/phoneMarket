<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
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
<div class="max-w-4xl mx-auto px-4 py-12 text-center">

    <!-- Hình minh họa giỏ hàng trống -->
    <div class="relative">
        <img src="https://cdn2.cellphones.com.vn/x,webp/media/cart/Cart-empty-v2.png"
             alt="Giỏ hàng trống"
             class="w-80 mx-auto">
    </div>

    <!-- Văn bản -->
    <div class="mt-10">
        <h2 class="text-2xl font-bold text-gray-800 mb-3">
            Giỏ hàng của bạn đang trống.
        </h2>
        <p class="text-lg text-gray-600">
            Hãy chọn thêm sản phẩm để mua sắm nhé
        </p>
    </div>

    <!-- Nút quay lại trang chủ / tiếp tục mua sắm -->
    <div class="mt-12">
        <a href=""
           class="inline-block bg-red-600 hover:bg-red-700 text-white font-bold text-lg px-12 py-4 rounded-full shadow-lg hover:shadow-xl transform hover:scale-105 transition-all duration-300">
            <i class="fas fa-home mr-2"></i>
            Quay lại trang chủ
        </a>
    </div>

</div>

</body>
</html>