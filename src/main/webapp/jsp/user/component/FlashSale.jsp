<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<section class="flash-sale">
    <div class="container">
        <div class="section-header">
            <h2><i class="fas fa-bolt"></i> HOT SALE CUỐI TUẦN</h2>
            <div class="countdown-timer" id="countdown">
                Kết thúc sau: <span id="timer">02 : 15 : 08</span>
            </div>
        </div>
        <div class="flash-sale-slider">
             <%@ include file="ProductCard.jsp" %>
             <%@ include file="ProductCard.jsp" %>
             <%@ include file="ProductCard.jsp" %>
             <%@ include file="ProductCard.jsp" %>
             <%@ include file="ProductCard.jsp" %>
        </div>
    </div>
</section>