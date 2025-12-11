<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${product != null}">
    <div class="product-card">
        <a href="${pageContext.request.contextPath}/detail?id=${product.id}" class="product-image">
            <img src="${not empty product.image ? product.image : 'https://placehold.co/250x250'}"
                 alt="${fn:escapeXml(product.name)}" loading="lazy"/>
        </a>
        <h3 class="product-name">${fn:substring(product.name, 0, 50)}</h3>
        <div class="product-price">
            <span class="price"><fmt:formatNumber value="${product.price}" pattern="#,##0"/>đ</span>
        </div>
        <button class="btn-add-to-cart" onclick="addToCart('${product.id}')">Thêm vào giỏ</button>
    </div>
</c:if>

<style>
    .product-card { border: 1px solid #e9ecef; border-radius: 8px; padding: 15px; background: white; transition: all 0.3s; }
    .product-card:hover { box-shadow: 0 8px 24px rgba(0,0,0,0.12); }
    .product-image { display: block; width: 100%; height: 200px; overflow: hidden; border-radius: 6px; margin-bottom: 10px; }
    .product-image img { width: 100%; height: 100%; object-fit: cover; }
    .product-name { font-size: 14px; font-weight: 600; margin: 8px 0; color: #333; }
    .product-price { margin: 8px 0; }
    .price { font-size: 16px; font-weight: 700; color: #ff4444; }
    .btn-add-to-cart { width: 100%; background: #007bff; color: white; border: none; padding: 8px; border-radius: 4px; cursor: pointer; font-weight: 600; margin-top: 10px; }
    .btn-add-to-cart:hover { background: #0056b3; }
</style>

<script>
    function addToCart(id) { alert('Thêm sản phẩm #' + id); }
</script>