<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<section class="product-grid-section">
    <div class="container">
        <div class="product-grid">
            <% for(int i = 0; i < 10; i++) { %>
                <%@ include file="ProductCard.jsp" %>
            <% } %>
        </div>
    </div>
</section>