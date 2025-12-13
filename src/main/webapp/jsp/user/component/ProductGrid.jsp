<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    List<?> productList = (List<?>) request.getAttribute("productList");
    if (productList == null) {
        productList = new ArrayList<>();
    }
%>

<section class="product-grid-section">
    <div class="container">
        <div class="section-header">
            <h2 class="section-title">Sản phẩm nổi bật</h2>
            <div class="section-actions">
                <button class="filter-btn active">Tất cả</button>
                <button class="filter-btn">Bán chạy</button>
                <button class="filter-btn">Giá tốt</button>
            </div>
        </div>

        <div class="product-grid">
            <% if (productList.isEmpty()) { %>
            <div class="empty-state">
                <svg width="80" height="80" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                    <circle cx="9" cy="21" r="1"/>
                    <circle cx="20" cy="21" r="1"/>
                    <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/>
                </svg>
                <h3>Không có sản phẩm nào</h3>
                <p>Hiện tại chưa có sản phẩm để hiển thị</p>
            </div>
            <% } else {
                for (Object item : productList) {
                    try {
                        Class<?> clazz = item.getClass();

                        // Lấy ID
                        java.lang.reflect.Method getId = clazz.getMethod("getId");
                        Object idObj = getId.invoke(item);
                        String id = (idObj != null) ? idObj.toString() : "0";

                        // Lấy Name
                        java.lang.reflect.Method getName = clazz.getMethod("getName");
                        Object nameObj = getName.invoke(item);
                        String name = (nameObj != null) ? nameObj.toString() : "Không có tên";

                        // Lấy Price
                        java.lang.reflect.Method getPrice = clazz.getMethod("getPrice");
                        Object priceObj = getPrice.invoke(item);
                        double price = 0.0;

                        if (priceObj != null) {
                            if (priceObj instanceof Integer) {
                                price = ((Integer) priceObj).doubleValue();
                            } else if (priceObj instanceof Double) {
                                price = (Double) priceObj;
                            } else if (priceObj instanceof Long) {
                                price = ((Long) priceObj).doubleValue();
                            } else {
                                price = Double.parseDouble(priceObj.toString());
                            }
                        }

                        // Lấy Image
                        java.lang.reflect.Method getImage = clazz.getMethod("getImage");
                        Object imageObj = getImage.invoke(item);
                        String image = (imageObj != null) ? imageObj.toString() : "";

                        // Normalize image src: prefix context path for relative paths, and use default image when absent
                        String imageSrc;
                        if (image != null && !image.isEmpty()) {
                            if (image.startsWith("/")) {
                                imageSrc = request.getContextPath() + image;
                            } else {
                                imageSrc = image;
                            }
                        } else {
                            imageSrc = request.getContextPath() + "/assets/images/products/default.png";
                        }

                        double oldPrice = price * 1.2;
                        double discount = price * 0.2;
            %>
            <div class="product-card">
                <a href="<%= request.getContextPath() %>/detail?id=<%= id %>" class="product-link">
                    <div class="product-image-wrapper">
                            <img src="<%= imageSrc %>"
                                alt="<%= name.replace("\"", "&quot;") %>"
                             class="product-image"
                             loading="lazy"/>
                        <div class="product-badge">Trả góp 0%</div>
                    </div>

                    <div class="product-info">
                        <h3 class="product-name">
                            <%= name.length() > 60 ? name.substring(0, 60) + "..." : name %>
                        </h3>

                        <div class="product-price-wrapper">
                            <span class="product-price"><%= String.format("%,.0f", price) %>đ</span>
                            <span class="product-price-old"><%= String.format("%,.0f", oldPrice) %>đ</span>
                        </div>

                        <div class="product-discount">Giảm <%= String.format("%,.0f", discount) %>đ</div>

                        <div class="product-rating">
                            <span class="stars">★★★★★</span>
                            <span class="rating-count">(128)</span>
                        </div>
                    </div>
                </a>

                <button class="btn-add-to-cart" onclick="addToCart('<%= id %>')">
                    <svg width="16" height="16" viewBox="0 0 16 16" fill="currentColor">
                        <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4z"/>
                    </svg>
                    Mua ngay
                </button>
            </div>
            <%
            } catch (Exception e) {
                String errorMsg = e.getMessage();
                if (e.getCause() != null) {
                    errorMsg += " (Cause: " + e.getCause().getMessage() + ")";
                }
            %>
            <div class="error-card">
                <div class="error-icon">⚠️</div>
                <h4>Lỗi hiển thị sản phẩm</h4>
                <p class="error-message"><%= errorMsg %></p>
                <details class="error-details">
                    <summary>Chi tiết kỹ thuật</summary>
                    <p><strong>Class:</strong> <%= item.getClass().getName() %></p>
                    <p><strong>Methods:</strong>
                        <%
                            try {
                                java.lang.reflect.Method[] methods = item.getClass().getMethods();
                                for (java.lang.reflect.Method m : methods) {
                                    if (m.getName().startsWith("get")) {
                                        out.print(m.getName() + " ");
                                    }
                                }
                            } catch (Exception ex) {
                                out.print("Không thể lấy methods");
                            }
                        %>
                    </p>
                </details>
            </div>
            <%
                        }
                    }
                }
            %>
        </div>
    </div>
</section>

<style>
    * {
        box-sizing: border-box;
    }

    .product-grid-section {
        padding: 40px 0;
        background: #f4f4f4;
    }

    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 16px;
    }

    .section-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 24px;
        flex-wrap: wrap;
        gap: 16px;
    }

    .section-title {
        font-size: 24px;
        font-weight: 700;
        color: #333;
        margin: 0;
        position: relative;
        padding-bottom: 8px;
    }

    .section-title::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 60px;
        height: 3px;
        background: linear-gradient(135deg, #d70018 0%, #ff0000 100%);
        border-radius: 2px;
    }

    .section-actions {
        display: flex;
        gap: 8px;
    }

    .filter-btn {
        padding: 8px 16px;
        border: 1px solid #e0e0e0;
        background: white;
        border-radius: 20px;
        cursor: pointer;
        font-size: 14px;
        font-weight: 500;
        color: #666;
        transition: all 0.3s;
    }

    .filter-btn:hover {
        border-color: #d70018;
        color: #d70018;
    }

    .filter-btn.active {
        background: linear-gradient(135deg, #d70018 0%, #ff0000 100%);
        color: white;
        border-color: transparent;
    }

    .product-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
        gap: 16px;
    }

    @media (max-width: 768px) {
        .product-grid {
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
        }
    }

    @media (max-width: 480px) {
        .product-grid {
            grid-template-columns: repeat(2, 1fr);
            gap: 8px;
        }
    }

    /* Product Card Styles */
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
        margin: 0 0 8px 0;
        font-weight: 500;
        height: 40px;
        overflow: hidden;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
    }

    .product-price-wrapper {
        display: flex;
        align-items: center;
        gap: 8px;
        margin-bottom: 4px;
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

    /* Empty State */
    .empty-state {
        grid-column: 1 / -1;
        text-align: center;
        padding: 60px 20px;
        color: #999;
    }

    .empty-state svg {
        margin-bottom: 16px;
        opacity: 0.5;
    }

    .empty-state h3 {
        font-size: 18px;
        color: #666;
        margin: 0 0 8px 0;
    }

    .empty-state p {
        font-size: 14px;
        margin: 0;
    }

    /* Error Card */
    .error-card {
        background: #fff3f3;
        border: 1px solid #ffcdd2;
        border-radius: 12px;
        padding: 20px;
        text-align: center;
    }

    .error-icon {
        font-size: 32px;
        margin-bottom: 8px;
    }

    .error-card h4 {
        color: #d32f2f;
        font-size: 16px;
        margin: 0 0 8px 0;
    }

    .error-message {
        font-size: 13px;
        color: #c62828;
        margin: 0 0 12px 0;
    }

    .error-details {
        text-align: left;
        background: white;
        border-radius: 6px;
        padding: 8px;
        font-size: 12px;
        color: #666;
    }

    .error-details summary {
        cursor: pointer;
        font-weight: 600;
        color: #d32f2f;
        margin-bottom: 8px;
    }

    .error-details p {
        margin: 4px 0;
        word-break: break-all;
    }
</style>

<script>
    function addToCart(id) {
        alert('Đã thêm sản phẩm #' + id + ' vào giỏ hàng');
    }
</script>