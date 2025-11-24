
    document.addEventListener("DOMContentLoaded", function () {
    const currentPath = window.location.pathname;

    // Lấy tất cả link trong sidebar
    const menuLinks = document.querySelectorAll(".sidebar-nav a");

    menuLinks.forEach(link => {
    const linkPath = link.getAttribute("href");

    // Nếu đường dẫn trùng hoặc bắt đầu bằng
    if (currentPath.startsWith(linkPath)) {
    menuLinks.forEach(l => l.classList.remove("active")); // xóa active cũ
    link.classList.add("active"); // gắn active mới
}
});
});

