<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${product != null}">
    <div class="product-card">
        <a href="${pageContext.request.contextPath}/detail?id=${product.id}" class="product-link">
            <div class="product-image-wrapper">
                <img src="${not empty product.image ? product.image : 'https://placehold.co/250x250'}"
                     alt="${fn:escapeXml(product.name)}"
                     class="product-image"
                     loading="lazy"/>
                <div class="product-badge">Trả góp 0%</div>
            </div>

            <div class="product-info">
                <h3 class="product-name">${fn:substring(product.name, 0, 60)}</h3>

                <div class="product-price-wrapper">
                    <span class="product-price"><fmt:formatNumber value="${product.price}" pattern="#,##0"/>đ</span>
                    <span class="product-price-old"><fmt:formatNumber value="${product.price * 1.2}" pattern="#,##0"/>đ</span>
                </div>

                <div class="product-discount">Giảm <fmt:formatNumber value="${(product.price * 0.2)}" pattern="#,##0"/>đ</div>

                <div class="product-rating">
                    <span class="stars">★★★★★</span>
                    <span class="rating-count">(128)</span>
                </div>
            </div>
        </a>

        <button class="btn-add-to-cart" onclick="addToCart('${product.id}')">
            <svg width="16" height="16" viewBox="0 0 16 16" fill="currentColor">
                <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4z"/>
            </svg>
            Mua ngay
        </button>
    </div>
</c:if>

<style>
    .product-card {
        background: #fff;
        border-radius: 12px;
        overflow: hidden;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        border: 1px solid #e0e0e0;
        height: 100%;
        display: flex;
        flex-direction: column;
    }

    .product-card:hover {
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
        transform: translateY(-4px);
        border-color: #d70018;
    }

    .product-link {
        text-decoration: none;
        color: inherit;
        flex: 1;
        display: flex;
        flex-direction: column;
    }

    .product-image-wrapper {
        position: relative;
        width: 100%;
        padding-top: 100%;
        background: #f8f8f8;
        overflow: hidden;
    }

    .product-image {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        width: 80%;
        height: 80%;
        object-fit: contain;
        transition: transform 0.3s;
    }

    .product-card:hover .product-image {
        transform: translate(-50%, -50%) scale(1.05);
    }

    .product-badge {
        position: absolute;
        top: 8px;
        left: 8px;
        background: linear-gradient(135deg, #d70018 0%, #ff0000 100%);
        color: white;
        padding: 4px 8px;
        border-radius: 4px;
        font-size: 11px;
        font-weight: 600;
        z-index: 1;
    }

    .product-info {
        padding: 12px;
        flex: 1;
        display: flex;
        flex-direction: column;
    }

    .product-name {
        font-size: 14px;
        line-height: 1.4;
        color: #333;
        margin: 0 0 12px 0;
        font-weight: 500;
        min-height: 40px;
        max-height: 40px;
        overflow: hidden;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        word-break: break-word;
    }

    .product-price-wrapper {
        display: flex;
        align-items: center;
        gap: 4px;
        margin-bottom: 4px;
        margin-top: 6px;
    }

    .product-price {
        font-size: 16px;
        font-weight: 700;
        color: #d70018;
    }

    .product-price-old {
        font-size: 13px;
        color: #999;
        text-decoration: line-through;
    }

    .product-discount {
        display: inline-block;
        background: #fff0f1;
        color: #d70018;
        font-size: 12px;
        font-weight: 600;
        padding: 2px 6px;
        border-radius: 4px;
        margin-bottom: 8px;
        width: fit-content;
    }

    .product-rating {
        display: flex;
        align-items: center;
        gap: 4px;
        margin-top: auto;
    }

    .stars {
        color: #ffa500;
        font-size: 12px;
        letter-spacing: 1px;
    }

    .rating-count {
        font-size: 12px;
        color: #666;
    }

    .btn-add-to-cart {
        width: calc(100% - 24px);
        margin: 0 12px 12px 12px;
        background: linear-gradient(135deg, #d70018 0%, #ff0000 100%);
        color: white;
        border: none;
        padding: 10px 16px;
        border-radius: 8px;
        cursor: pointer;
        font-weight: 600;
        font-size: 14px;
        transition: all 0.3s;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 6px;
    }

    .btn-add-to-cart:hover {
        background: linear-gradient(135deg, #b00015 0%, #d70018 100%);
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(215, 0, 24, 0.3);
    }

    .btn-add-to-cart:active {
        transform: translateY(0);
    }
</style>

<script>
    function addToCart(id) {
        alert('Đã thêm sản phẩm #' + id + ' vào giỏ hàng');
    }
</script>