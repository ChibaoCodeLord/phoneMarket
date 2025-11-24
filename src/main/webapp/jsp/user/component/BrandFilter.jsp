<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<section class="brand-filter">
    <div class="container">
        <div class="brand-list">
            <%
                String[] brands = {"Apple", "Samsung", "Xiaomi", "Oppo", "Tecno", "Honor", "ZTE", "Nubia", "Sony", "Nokia", "Infinix", "Nothing", "Meizu", "Realme", "Vivo"};
                for (String brand : brands) {
            %>
            <button class="brand-btn"><%= brand %></button>
            <% } %>
        </div>
    </div>
</section>