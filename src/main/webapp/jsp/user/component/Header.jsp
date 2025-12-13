<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<header class="header">
    <div class="container">
        <div class="header-left">
            <a href="#" class="logo">
                <span class="logo-text">CellphoneS</span>
            </a>

            <!-- BỌC 2 NÚT NÀY LẠI -->
            <div class="catalog-group">
                <div class="category-dropdown">
                    <button class="btn-category">
                        <i class="fas fa-bars"></i> Danh mục
                    </button>
                    <div class="dropdown-menu">
                        <a href="#">Điện thoại</a>
                        <a href="#">Laptop</a>
                        <a href="#">Tablet</a>
                        <a href="#">Phụ kiện</a>
                    </div>
                </div>

                <div class="location-select">
                    <i class="fas fa-map-marker-alt"></i>
                    <select>
                        <option>Hà Nội</option>
                        <option>TP. HCM</option>
                    </select>
                </div>
            </div>
        </div>

        <!-- GIỮA: Tìm kiếm -->
        <div class="search-bar">
            <input type="text" placeholder="Bạn muốn mua gì hôm nay?" />
            <button><i class="fas fa-search"></i></button>
        </div>

        <!-- PHẢI: Giỏ hàng + Đăng nhập -->
        <div class="header-actions">
            <a href="${pageContext.request.contextPath}/orders" class="orders-icon" title="Lịch sử mua hàng">
                <i class="fas fa-receipt"></i>
            </a>
            <a href="${pageContext.request.contextPath}/cart" class="cart-icon">
                <i class="fas fa-shopping-cart"></i>
                <span class="badge">${fn:length(sessionScope.cart)}</span>
            </a>
            <c:choose>
                <c:when test="${not empty sessionScope.currentUser}">
                    <a href="${pageContext.request.contextPath}/logout" class="login-btn">Đăng xuất</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="login-btn">Đăng nhập</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>