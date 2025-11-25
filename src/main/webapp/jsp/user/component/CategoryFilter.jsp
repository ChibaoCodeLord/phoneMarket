<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .category-needs {
        padding: 24px 0;
        background: #f8f9fa;
    }
    .category-needs .container {
        max-width: 1400px;
        margin: 0 auto;
        padding: 0 16px;
    }
    .category-needs .grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 12px;
    }
    @media (min-width: 640px) {
        .category-needs .grid { grid-template-columns: repeat(3, 1fr); }
    }
    @media (min-width: 1024px) {
        .category-needs .grid { grid-template-columns: repeat(6, 1fr); }
    }
    .category-needs a {
        display: flex;
        align-items: center;
        background: white;
        border-radius: 16px;
        padding: 12px 16px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        transition: all 0.3s ease;
        text-decoration: none;
        overflow: hidden;
    }
    .category-needs a:hover {
        transform: translateY(-4px);
        box-shadow: 0 8px 20px rgba(227,6,19,0.15);
    }
    .category-needs img {
        width: 72px;
        height: 72px;
        object-fit: contain;
        margin-right: 16px;
        flex-shrink: 0;
    }
    .category-needs span {
        font-weight: 500;
        color: #1a1a1a;
        font-size: 14px;
        line-height: 1.4;
    }
</style>

<section class="category-needs">
    <div class="container">
        <div class="grid">
            <a href="#">
                <img src="https://cdn2.cellphones.com.vn/insecure/rs:fill:96:96/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Web/icon/mobile-5g_1.png" alt="5G" loading="lazy">
                <span>Điện thoại 5G</span>
            </a>
            <a href="#">
                <img src="https://cdn2.cellphones.com.vn/insecure/rs:fill:96:96/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Web/icon/mobile-chup-anh.png" alt="Chụp ảnh đẹp" loading="lazy">
                <span>Điện thoại<br>chụp ảnh đẹp</span>
            </a>
            <a href="#">
                <img src="https://cdn2.cellphones.com.vn/insecure/rs:fill:96:96/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Web/icon/mobile-gap_1.png" alt="Gập" loading="lazy">
                <span>Điện thoại gập</span>
            </a>
            <a href="#">
                <img src="https://cdn2.cellphones.com.vn/insecure/rs:fill:96:96/q:90/plain/https://cellphones.com.vn/media/wysiwyg/dien-thoai-ai-icon-cate.png" alt="AI" loading="lazy">
                <span>Điện thoại AI</span>
            </a>
            <a href="#">
                <img src="https://cdn2.cellphones.com.vn/insecure/rs:fill:96:96/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Web/icon/mobile-gamning.png" alt="Game" loading="lazy">
                <span>Điện thoại<br>chơi game</span>
            </a>
            <a href="#">
                <img src="https://cdn2.cellphones.com.vn/insecure/rs:fill:96:96/q:90/plain/https://cellphones.com.vn/media/wysiwyg/dien-thoai-pho-thong-icon-cate.png" alt="Phổ thông" loading="lazy">
                <span>Điện thoại<br>phổ thông</span>
            </a>
        </div>
    </div>
</section>