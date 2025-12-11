<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            <a href="/jsp/user/cart.jsp" class="cart-icon">
                <i class="fas fa-shopping-cart"></i>
                <span class="badge">3</span>
            </a>
            <a href="/jsp/auth/login.jsp" class="login-btn">Đăng nhập</a>
        </div>
    </div>
</header>