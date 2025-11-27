<!-- Header Component với Dropdown cho User Profile -->
<link rel="stylesheet" href="/css/component/header.css">
<!-- Header Component với Dropdown cho User Profile -->
<header class="header">
    <div class="header-left">
        <i class="fas fa-bars menu-toggle"></i>
        <h1>Dashboard</h1>
    </div>
    <div class="header-right">
        <div class="search-bar">
            <i class="fas fa-search"></i>
            <input type="text" placeholder="Search or type command...">
        </div>
        <div class="user-profile" onclick="toggleDropdown();">  <!-- Giữ onclick, giờ function global -->
            <span>MuSher</span>
            <img src="/images/avatar.jpg" alt="User Avatar" class="avatar">
            <!-- Dropdown Menu -->
            <div class="dropdown" id="userDropdown">
                <a href="/admin/profile"><i class="fas fa-user"></i>Profile</a>
                <a href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        </div>
    </div>
</header>
<script src="/js/admin/dropdown.js"></script>