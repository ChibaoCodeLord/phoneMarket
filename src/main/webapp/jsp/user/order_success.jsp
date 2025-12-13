<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt hàng thành công</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>
<div style="max-width:800px;margin:40px auto;text-align:center;">
    <h1 style="font-size:28px;color:#0f172a;">Thanh toán thành công</h1>
    <p style="font-size:18px;color:#374151;">Cảm ơn bạn đã đặt hàng! Mã đơn hàng của bạn là: <strong>${orderId}</strong></p>
    <p style="margin-top:20px;"><a href="${pageContext.request.contextPath}/home">Trở lại trang chủ</a> | <a href="${pageContext.request.contextPath}/orders">Xem đơn hàng</a></p>
</div>
</body>
</html>