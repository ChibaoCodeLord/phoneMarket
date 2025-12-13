<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
    /* Override CSS để đảm bảo card có cùng kích thước và chiều cao */
    .flash-sale-wrapper .flash-sale-slider {
        align-items: stretch !important;
    }
    
    .flash-sale-wrapper .flash-sale-slider .product-card {
        width: 240px !important;
        min-width: 240px !important;
        max-width: 240px !important;
        height: auto !important;
        min-height: 100% !important;
        flex-shrink: 0 !important;
        flex-grow: 0 !important;
        box-sizing: border-box !important;
        display: flex !important;
        flex-direction: column !important;
    }
    
    /* Đảm bảo tất cả phần tử trong card có cùng layout */
    .flash-sale-wrapper .flash-sale-slider .product-card .product-link {
        flex: 1 !important;
        display: flex !important;
        flex-direction: column !important;
    }
    
    .flash-sale-wrapper .flash-sale-slider .product-card .product-image-wrapper {
        width: 100% !important;
        padding-top: 100% !important;
        flex-shrink: 0 !important;
    }
    
    .flash-sale-wrapper .flash-sale-slider .product-card .product-info {
        flex: 1 !important;
        display: flex !important;
        flex-direction: column !important;
        padding: 18px !important;
        gap: 10px !important;
    }
    
    .flash-sale-wrapper .flash-sale-slider .product-card .product-name {
        min-height: 45px !important;
        max-height: 45px !important;
        margin: 0 !important;
    }
    
    .flash-sale-wrapper .flash-sale-slider .product-card .btn-add-to-cart {
        margin-top: auto !important;
        flex-shrink: 0 !important;
    }
    
    /* Style mũi tên đẹp */
    .flash-sale-wrapper .flash-sale-arrow {
        position: absolute !important;
        top: 50% !important;
        transform: translateY(-50%) !important;
        background: white !important;
        border: 1px solid #d0d0d0 !important;
        border-radius: 50% !important;
        width: 40px !important;
        height: 40px !important;
        display: flex !important;
        align-items: center !important;
        justify-content: center !important;
        cursor: pointer !important;
        z-index: 10 !important;
        transition: all 0.3s ease !important;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1) !important;
    }
    
    .flash-sale-wrapper .flash-sale-arrow:hover {
        background: #f8f8f8 !important;
        border-color: #b0b0b0 !important;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15) !important;
        transform: translateY(-50%) scale(1.05) !important;
    }
    
    .flash-sale-wrapper .flash-sale-arrow:active {
        transform: translateY(-50%) scale(0.95) !important;
    }
    
    .flash-sale-wrapper .flash-sale-arrow-left {
        left: 0 !important;
    }
    
    .flash-sale-wrapper .flash-sale-arrow-right {
        right: 0 !important;
    }
    
    .flash-sale-wrapper .flash-sale-arrow i {
        font-size: 16px !important;
        color: #333 !important;
        font-weight: 600 !important;
        transition: color 0.3s ease !important;
    }
    
    .flash-sale-wrapper .flash-sale-arrow:hover i {
        color: #E30613 !important;
    }
</style>
<section class="flash-sale">
    <div class="container">
        <div class="section-header">
            <h2><i class="fas fa-bolt"></i> HOT SALE CUỐI TUẦN</h2>
            <div class="countdown-timer" id="countdown">
                Kết thúc sau: <span id="flashSaleTimer">02 : 15 : 08</span>
            </div>
        </div>
        
        <!-- 5 sản phẩm trên 1 hàng -->
        <c:if test="${not empty productList}">
            <div class="flash-sale-wrapper">
                <button class="flash-sale-arrow flash-sale-arrow-left" id="flashSaleArrowLeft" aria-label="Scroll left">
                    <i class="fas fa-chevron-left"></i>
                </button>
                <div class="flash-sale-slider" id="flashSaleSlider">
                    <c:forEach var="product" items="${productList}" begin="0" end="4" varStatus="status">
                        <c:set var="product" value="${product}" scope="page" />
                        <%@ include file="ProductCard.jsp" %>
                    </c:forEach>
                </div>
                <button class="flash-sale-arrow flash-sale-arrow-right" id="flashSaleArrowRight" aria-label="Scroll right">
                    <i class="fas fa-chevron-right"></i>
                </button>
            </div>
        </c:if>
    </div>
</section>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const timer = document.getElementById('flashSaleTimer');
        if (!timer) {
            console.warn('FlashSale timer element not found!');
            return;
        }

        // Đếm ngược từ 2 giờ 15 phút 8 giây (8158 giây)
        let time = 2 * 3600 + 15 * 60 + 8; // 8158 giây

        const updateTimer = () => {
            if (time <= 0) {
                timer.textContent = '00 : 00 : 00';
                timer.parentElement.innerHTML = '<span style="color: #E30613; font-weight: bold;">Đã kết thúc</span>';
                return;
            }
            
            const hours = Math.floor(time / 3600);
            const minutes = Math.floor((time % 3600) / 60);
            const seconds = time % 60;
            
            const h = String(hours).padStart(2, '0');
            const m = String(minutes).padStart(2, '0');
            const s = String(seconds).padStart(2, '0');
            
            timer.textContent = `${h} : ${m} : ${s}`;
            time--;
        };

        // Cập nhật ngay lập tức
        updateTimer();
        // Cập nhật mỗi giây
        setInterval(updateTimer, 1000);
    });

    // Xử lý nút mũi tên scroll
    document.addEventListener('DOMContentLoaded', () => {
        const slider = document.getElementById('flashSaleSlider');
        const arrowLeft = document.getElementById('flashSaleArrowLeft');
        const arrowRight = document.getElementById('flashSaleArrowRight');

        if (!slider || !arrowLeft || !arrowRight) {
            return;
        }

        const scrollAmount = 264; // 240px (card width) + 24px (gap)

        // Kiểm tra và cập nhật trạng thái nút mũi tên
        const updateArrowVisibility = () => {
            const isScrollable = slider.scrollWidth > slider.clientWidth;
            arrowLeft.style.display = isScrollable ? 'flex' : 'none';
            arrowRight.style.display = isScrollable ? 'flex' : 'none';

            // Ẩn nút trái nếu đã scroll về đầu
            arrowLeft.style.opacity = slider.scrollLeft <= 0 ? '0.5' : '1';
            arrowLeft.style.pointerEvents = slider.scrollLeft <= 0 ? 'none' : 'auto';

            // Ẩn nút phải nếu đã scroll đến cuối
            const maxScroll = slider.scrollWidth - slider.clientWidth;
            arrowRight.style.opacity = slider.scrollLeft >= maxScroll - 10 ? '0.5' : '1';
            arrowRight.style.pointerEvents = slider.scrollLeft >= maxScroll - 10 ? 'none' : 'auto';
        };

        // Scroll trái
        arrowLeft.addEventListener('click', () => {
            slider.scrollBy({
                left: -scrollAmount,
                behavior: 'smooth'
            });
        });

        // Scroll phải
        arrowRight.addEventListener('click', () => {
            slider.scrollBy({
                left: scrollAmount,
                behavior: 'smooth'
            });
        });

        // Cập nhật khi scroll
        slider.addEventListener('scroll', updateArrowVisibility);

        // Cập nhật khi resize
        window.addEventListener('resize', updateArrowVisibility);

        // Cập nhật ban đầu
        updateArrowVisibility();
    });
</script>