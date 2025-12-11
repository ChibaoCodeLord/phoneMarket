<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>CellphoneS - Trang chủ</title>


    <link rel="stylesheet" href="/css/home.css" />

    <!-- Font Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
</head>
<body>
<%@ include file="component/Header.jsp" %>
<%@ include file="component/Banner.jsp" %>
<%@ include file="component/BrandFilter.jsp" %>
<%@ include file="component/CategoryFilter.jsp" %>
<%@ include file="component/FlashSale.jsp" %>
<%@ include file="component/FilterBar.jsp" %>
<%@ include file="component/ProductGrid.jsp" %>
<%@ include file="component/Footer.jsp" %>

<!-- Mobile Nav -->
<div class="mobile-bottom-nav">
    <a href="#" class="active"><i class="fas fa-home"></i><span>Trang chủ</span></a>
    <a href="#"><i class="fas fa-th-large"></i><span>Danh mục</span></a>
    <a href="#"><i class="fas fa-search"></i><span>Tìm kiếm</span></a>
    <a href="#"><i class="fas fa-shopping-cart"></i><span>Giỏ hàng</span></a>
    <a href="#"><i class="fas fa-user"></i><span>Tài khoản</span></a>
</div>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const timer = document.getElementById('timer');
        if (!timer) {
            console.warn('Timer element not found! Check FlashSale.jsp');
            return;
        }

        let time = 2 * 3600 + 15 * 60 + 8;

        const updateTimer = () => {
            if (time <= 0) {
                timer.textContent = '00 : 00 : 00';
                return;
            }
            time--;
            const h = String(Math.floor(time / 3600)).padStart(2, '0');
            const m = String(Math.floor((time % 3600) / 60)).padStart(2, '0');
            const s = String(time % 60).padStart(2, '0');
            timer.textContent = `${h} : ${m} : ${s}`;
        };

        updateTimer();
        setInterval(updateTimer, 1000);
    });
</script>
</body>
</html>