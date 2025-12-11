<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>iPhone Air 256GB | Chính hãng VN/A</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; }
        .glass { background: rgba(255, 255, 255, 0.85); backdrop-filter: blur(12px); -webkit-backdrop-filter: blur(12px); }
        .countdown { font-feature-settings: "tnum"; font-variant-numeric: tabular-nums; }
        .sticky-buy { position: fixed; bottom: 0; left: 0; right: 0; z-index: 50; }
        .color-selected::before { content: "✓"; position: absolute; top: -4px; right: -4px; background: #e60023; color: white; width: 20px; height: 20px; border-radius: 50%; font-size: 12px; display: flex; align-items: center; justify-content: center; font-weight: bold; }
        .capacity-selected { border: 2px solid #e60023 !important; }
        .price-strike { text-decoration: line-through; opacity: 0.6; }
        .gradient-red { background: linear-gradient(135deg, #e60023 0%, #ff1a3c 100%); }
    </style>
</head>
<body class="bg-gray-50 text-gray-900">

<div class="max-w-5xl mx-auto px-4 py-6">

    <!-- Header Rating -->
    <div class="flex items-center gap-3 text-sm mb-4">
        <span class="text-yellow-500">★ 5.1 (danh giá)</span>
        <span class="text-blue-600">Yêu thích</span>
        <span class="text-gray-500">| Hỏi đáp</span>
        <span class="text-gray-500">| Thông số</span>
        <span class="text-gray-500">| So sánh</span>
    </div>

    <!-- Title -->
    <h1 class="text-3xl font-bold mb-4">iPhone Air | Chính hãng VN/A</h1>

    <!-- YouTube Video -->
    <div class="relative rounded-2xl overflow-hidden shadow-2xl mb-8 glass">
        <iframe class="w-full aspect-video" src="https://www.youtube.com/embed/nK9Qivs4f3s?si=8eo8FnGhm2jjccVL" title="YouTube video player" frameborder="0" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
        <div class="absolute bottom-4 left-4 bg-black bg-opacity-70 text-white px-3 py-1 rounded text-sm">
            Sơn Tùng M-TP | Quảng cáo iPhone Air chính thức
        </div>
    </div>

    <!-- Price Section -->
    <div class="bg-white rounded-2xl p-6 shadow-lg mb-6 glass border border-gray-100">
        <div class="flex items-baseline gap-4 mb-3">
            <span class="text-4xl font-bold text-red-600">28.890.000đ</span>
            <span class="text-xl price-strike">31.990.000đ</span>
            <span class="text-lg text-gray-500">→ giảm còn</span>
        </div>
        <div class="flex items-center gap-3 mb-4">
            <span class="bg-red-600 text-white px-4 py-2 rounded-full font-bold text-lg">Trợ giá đến 2.000.000đ</span>
            <div class="flex gap-2 countdown text-2xl font-bold">
                <div><span id="hours">08</span>h</div>
                <div><span id="minutes">08</span>p</div>
                <div><span id="seconds">08</span>s</div>
                <span class="text-lg ml-2 text-red-600">còn lại</span>
            </div>
        </div>
    </div>

    <!-- Capacity Selection -->
    <div class="bg-white rounded-2xl p-6 shadow-lg mb-6">
        <h3 class="font-bold text-lg mb-4">Phiên bản</h3>
        <div class="grid grid-cols-3 gap-4">
            <button class="border-2 border-gray-300 rounded-xl py-4 text-center hover:border-red-500 transition capacity-btn" data-price="33.890.000đ">1TB</button>
            <button class="border-2 border-gray-300 rounded-xl py-4 text-center hover:border-red-500 transition capacity-btn" data-price="31.890.000đ">512GB</button>
            <button class="border-2 capacity-selected rounded-xl py-4 text-center bg-red-50 font-bold text-red-600">256GB</button>
        </div>
    </div>

    <!-- Color Selection -->
    <div class="bg-white rounded-2xl p-6 shadow-lg mb-6">
        <h3 class="font-bold text-lg mb-4">Màu sắc</h3>
        <div class="grid grid-cols-4 gap-4">
            <div class="relative">
                <button class="w-full h-24 rounded-2xl border-4 border-gray-300 bg-gray-100 hover:border-gray-400 transition color-btn" style="background: linear-gradient(45deg, #f8f9fa, #ffffff);"></button>
                <p class="text-center mt-2 text-sm">Trắng Mây</p>
            </div>
            <div class="relative">
                <button class="w-full h-24 rounded-2xl border-4 border-gray-300 bg-gray-900 hover:border-gray-700 transition color-btn"></button>
                <p class="text-center mt-2 text-sm text-gray-600">Đen Không Gian</p>
            </div>
            <div class="relative">
                <button class="w-full h-24 rounded-2xl border-4 border-gray-300 bg-gradient-to-br from-yellow-100 to-amber-200 hover:border-amber-400 transition color-btn"></button>
                <p class="text-center mt-2 text-sm">Vàng Nhạt</p>
            </div>
            <div class="relative">
                <button class="w-full h-24 rounded-2xl border-4 border-red-600 bg-gradient-to-br from-cyan-400 to-blue-500 color-btn color-selected"></button>
                <p class="text-center mt-2 text-sm font-bold text-red-600">Xanh Da Trời</p>
            </div>
        </div>
        <p class="text-sm text-red-600 mt-3">Tiết kiệm thêm đến 309.000đ cho Smember</p>
    </div>

    <!-- Banner Giảm thêm 300K -->
    <div class="bg-gradient-to-r from-pink-500 to-red-500 text-white rounded-2xl p-6 mb-6 shadow-xl text-center">
        <div class="text-3xl font-bold mb-2">Chào bạn Mới!</div>
        <div class="text-4xl font-black">iPhone Air thêm giảm 300K</div>
    </div>

    <!-- Thông tin vận chuyển -->
    <div class="bg-white rounded-2xl p-6 shadow-lg mb-6">
        <div class="flex items-center justify-between mb-4">
            <div>
                <p class="text-sm text-gray-500">Chọn địa chỉ giao hàng để nhận ưu đãi</p>
            </div>
            <button class="text-red-600 font-bold">XEM ƯU ĐÃI</button>
        </div>
        <div class="grid grid-cols-2 gap-4 text-sm">
            <select class="border rounded-lg px-4 py-3">
                <option>Hồ Chí Minh</option>
            </select>
            <select class="border rounded-lg px-4 py-3">
                <option>Quận/Huyện</option>
            </select>
        </div>
        <div class="mt-4 grid grid-cols-2 gap-4 text-sm">
            <div class="bg-gray-50 rounded-lg p-4">
                <p class="font-bold">197-199 Nguyễn Thị Minh Khai, P. Phạm Ngũ Lão, Q.1</p>
                <p class="text-green-600">☎ 02871060159</p>
            </div>
            <div class="bg-gray-50 rounded-lg p-4">
                <p class="font-bold">134 Nguyễn Thái Học, P. Phạm Ngũ Lão, Q.1</p>
                <p class="text-green-600">☎ 02871060132</p>
            </div>
        </div>
    </div>

    <!-- Thông số kỹ thuật -->
    <div class="bg-white rounded-2xl p-6 shadow-lg mb-20">
        <h3 class="font-bold text-xl mb-6">Thông số kỹ thuật</h3>
        <table class="w-full text-left">
            <tr class="border-b"><td class="py-3 font-medium">Kích thước màn hình</td><td>6.5 inches</td></tr>
            <tr class="border-b"><td class="py-3 font-medium">Công nghệ màn hình</td><td>Super Retina XDR</td></tr>
            <tr class="border-b"><td class="py-3 font-medium">Camera sau</td><td>48MP Fusion Main f/1.6</td></tr>
            <tr class="border-b"><td class="py-3 font-medium">Camera trước</td><td>18MP Center Stage f/1.8</td></tr>
            <tr class="border-b"><td class="py-3 font-medium">Chipset</td><td>Chip A19 Pro</td></tr>
            <tr class="border-b"><td class="py-3 font-medium">Công nghệ NFC</td><td>Có</td></tr>
            <tr class="border-b"><td class="py-3 font-medium">Bộ nhớ trong</td><td>256 GB</td></tr>
            <tr class="border-b"><td class="py-3 font-medium">Pin</td><td>Xem video: 27 giờ<br>Xem video (trực tuyến): 22 giờ</td></tr>
            <tr><td class="py-3 font-medium">Thẻ SIM</td><td>Sim kép (nano‑SIM và e‑SIM) • Hỗ trợ 2 e‑SIM</td></tr>
        </table>
    </div>
</div>

<!-- Fixed Bottom Buy Bar -->
<div class="sticky-buy bg-white border-t-2 border-red-600 shadow-2xl">
    <div class="max-w-5xl mx-auto px-4 py-4 flex items-center justify-between">
        <div>
            <p class="text-sm text-gray-600">Tổng tiền</p>
            <p class="text-3xl font-bold text-red-600">28.890.000đ</p>
        </div>
        <div class="flex gap-3">
            <button class="bg-gray-200 text-gray-800 px-8 py-4 rounded-xl font-bold text-lg hover:bg-gray-300 transition">Trả góp 0%</button>
            <button class="gradient-red text-white px-12 py-4 rounded-xl font-bold text-xl shadow-lg hover:shadow-xl transform hover:scale-105 transition">MUA NGAY</button>
        </div>
    </div>
</div>

<script>
    // Countdown Timer - 8 giờ 8 phút 8 giây
    let timeLeft = 8 * 3600 + 8 * 60 + 8;
    const timer = setInterval(() => {
        if (timeLeft <= 0) {
            clearInterval(timer);
            document.querySelector('.countdown').innerHTML = '<span class="text-red-600">Đã hết khuyến mãi!</span>';
            return;
        }
        timeLeft--;
        const h = String(Math.floor(timeLeft / 3600)).padStart(2, '0');
        const m = String(Math.floor((timeLeft % 3600) / 60)).padStart(2, '0');
        const s = String(timeLeft % 60).padStart(2, '0');
        document.getElementById('hours').textContent = h;
        document.getElementById('minutes').textContent = m;
        document.getElementById('seconds').textContent = s;
    }, 1000);

    // Capacity selection
    document.querySelectorAll('.capacity-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            document.querySelectorAll('.capacity-btn').forEach(b => b.classList.remove('capacity-selected', 'bg-red-50', 'text-red-600', 'font-bold'));
            this.classList.add('capacity-selected', 'bg-red-50', 'text-red-600', 'font-bold');
        });
    });

    // Color selection
    document.querySelectorAll('.color-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            document.querySelectorAll('.color-btn').forEach(b => b.classList.remove('color-selected'));
            this.classList.add('color-selected');
            this.closest('div').querySelector('p').classList.add('font-bold', 'text-red-600');
            document.querySelectorAll('.color-btn').forEach(other => {
                if (other !== this) {
                    other.closest('div').querySelector('p').classList.remove('font-bold', 'text-red-600');
                }
            });
        });
    });
</script>

</body>
</html>