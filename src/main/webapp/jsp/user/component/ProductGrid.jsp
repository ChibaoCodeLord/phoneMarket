<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    // Lấy productList từ request
    List<?> productList = (List<?>) request.getAttribute("productList");
    if (productList == null) {
        productList = new ArrayList<>();
    }
%>

<section class="product-grid-section">
    <div class="container">
        <h2 class="section-title">Danh sách sản phẩm</h2>


        <div class="product-grid">
            <% if (productList.isEmpty()) { %>
            <div style="grid-column:1/-1; text-align:center; padding:40px; color:#999;">
                <p>Không có sản phẩm nào để hiển thị</p>
            </div>
            <% } else {
                for (Object item : productList) {
                    try {
                        // Dùng reflection để lấy thông tin sản phẩm
                        Class<?> clazz = item.getClass();

                        // Lấy ID
                        java.lang.reflect.Method getId = clazz.getMethod("getId");
                        Object idObj = getId.invoke(item);
                        String id = (idObj != null) ? idObj.toString() : "0";

                        // Lấy Name
                        java.lang.reflect.Method getName = clazz.getMethod("getName");
                        Object nameObj = getName.invoke(item);
                        String name = (nameObj != null) ? nameObj.toString() : "Không có tên";

                        // Lấy Price - XỬ LÝ CẢ INTEGER VÀ DOUBLE
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
            %>
            <div class="product-card">
                <a href="<%= request.getContextPath() %>/detail?id=<%= id %>" class="product-image">
                    <img src="<%= (image != null && !image.isEmpty()) ? image : "https://placehold.co/250x250" %>"
                         alt="<%= name.replace("\"", "&quot;") %>" loading="lazy"/>
                </a>
                <h3 class="product-name">
                    <%= name.length() > 50 ? name.substring(0, 50) + "..." : name %>
                </h3>
                <div class="product-price">
                <span class="price">
                  <%= String.format("%,.0f", price) %>đ
                </span>
                </div>
                <button class="btn-add-to-cart" onclick="addToCart('<%= id %>')">Thêm vào giỏ</button>
            </div>
            <%
            } catch (Exception e) {
                // Hiển thị lỗi chi tiết hơn
                String errorMsg = e.getMessage();
                if (e.getCause() != null) {
                    errorMsg += " (Cause: " + e.getCause().getMessage() + ")";
                }
            %>
            <div class="product-card" style="background:#ffebee; color:#d32f2f;">
                <h4>⚠️ Lỗi hiển thị sản phẩm</h4>
                <p><small><%= errorMsg %></small></p>
                <p><small>Item: <%= item.getClass().getName() %></small></p>
                <p><small>Methods:
                    <%
                        // Hiển thị tất cả methods của object để debug
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
                </small></p>
            </div>
            <%
                        }
                    }
                }
            %>
        </div>
    </div>
</section>

<!-- CSS và script giữ nguyên -->