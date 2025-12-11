// admin-script.js: JS cho menu toggle và dropdown (đã wrap DOMContentLoaded)
document.addEventListener('DOMContentLoaded', function() {
    // Menu toggle
    const menuToggle = document.querySelector('.menu-toggle');
    const sidebar = document.querySelector('.sidebar');
    if (menuToggle && sidebar) {
        menuToggle.addEventListener('click', () => {
            sidebar.classList.toggle('collapsed');
        });
    }

    // Function toggleDropdown (định nghĩa global để onclick gọi được)
    window.toggleDropdown = function() {
        const dropdown = document.getElementById('userDropdown');
        if (dropdown) {
            dropdown.classList.toggle('open');
        }
    };

    // Click outside dropdown để đóng
    document.addEventListener('click', function(e) {
        const userProfile = document.querySelector('.user-profile');
        const dropdown = document.getElementById('userDropdown');
        if (userProfile && !userProfile.contains(e.target) && dropdown && dropdown.classList.contains('open')) {
            dropdown.classList.remove('open');
        }
    });
});

// Nếu dùng Chart.js, thêm code canvas ở đây
// const ctx = document.getElementById('lineChart').getContext('2d');
// new Chart(ctx, { /* config */ });