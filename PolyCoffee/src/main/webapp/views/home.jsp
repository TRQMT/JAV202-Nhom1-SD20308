<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
   <link
      href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,500;0,600;1,400;1,600&family=DM+Sans:wght@300;400;500&display=swap"
      rel="stylesheet"
    />
<!-- HEADER -->
<jsp:include page="/views/layout/admin/header.jsp">
    <jsp:param name="pageTitle" value="Trang chủ"/>
    <jsp:param name="activeNav" value="home"/>
</jsp:include>

<!-- MAIN -->
<main class="home-page">

    <!-- HERO -->
    <div class="hero-full">
        <div class="hero-overlay"></div>

        <div class="hero-content">
            <div class="hero-tag">
                <span class="material-symbols-outlined" style="font-size:14px">local_cafe</span>
                100% Nguyên chất · Từ Hạt Đến Ly
            </div>
            <h1>Fresh Coffee,<br><span>Real Flavor</span></h1>
            <p>Thưởng thức cà phê nguyên chất mỗi ngày tại Poly Coffee.<br>Pha chế tươi mỗi buổi sáng.</p>

            <div class="hero-btns">
                <a href="${pageContext.request.contextPath}/manager/drinks"
                   class="btn-hero-primary">
                    <span class="material-symbols-outlined" style="font-size:18px">menu_book</span>
                    Browse Menu
                </a>
                <a href="${pageContext.request.contextPath}/trang-chu#about"
                   class="btn-hero-ghost">
                    <span class="material-symbols-outlined" style="font-size:18px">play_circle</span>
                    Our Story
                </a>
            </div>
        </div>
    </div>

    <!-- DRINK LIST -->
    <div class="drink-section">

        <h2 class="section-title text-center" style="padding-bottom: 20px;">Danh sách đồ uống</h2>

        <div class="drink-wrapper">

            <div class="drink-grid">

                <c:forEach var="d" items="${drinks}" varStatus="loop">
                    <div class="drink-card drink-item ${loop.index >= 10 ? 'hidden' : ''}">

                        <img
                            src="${pageContext.request.contextPath}/images/${d.image}"
                            class="drink-img"
                            onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/uploads/${d.image}'"
                        >

                        <div class="drink-body">
                            <h4>${d.name}</h4>
                            <p class="price">${d.price} VNĐ</p>

                            <a href="${pageContext.request.contextPath}/employee/pos?id=${d.id}"
                               class="btn btn-sm btn-primary">
                                Chọn
                            </a>
                        </div>

                    </div>
                </c:forEach>

            </div>

            <!-- LOAD MORE -->
            <div class="text-center mt-4">
                <button id="loadMoreBtn" class="btn btn-outline-primary">
                    Load more
                </button>
            </div>

        </div>

    </div>

</main>

<!-- SCRIPT -->
<script>
    let current = 10;
    const step = 10;

    const items = document.querySelectorAll('.drink-item');
    const btn = document.getElementById('loadMoreBtn');

    btn.addEventListener('click', () => {
        let count = 0;

        for (let i = current; i < items.length && count < step; i++) {
            items[i].classList.remove('hidden');
            count++;
        }

        current += step;

        if (current >= items.length) {
            btn.style.display = 'none';
        }
    });
</script>


<!-- STYLE -->
<style>

/* FULL PAGE */
.home-page {
    width: 100%;
}

/* HERO */
.hero-full {
    position: relative;
    height: 520px;
    background: url("https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?q=80&w=1920")
                center/cover no-repeat;
    display: flex;
    align-items: center;
}

.hero-overlay {
    position: absolute;
    inset: 0;
    background: linear-gradient(
        100deg,
        rgba(26, 10, 0, 0.88) 0%,
        rgba(59, 31, 10, 0.65) 50%,
        rgba(0, 0, 0, 0.08) 100%
    );
}

.hero-content {
    position: relative;
    color: white;
    text-align: left;
    padding-left: 72px;
    max-width: 560px;
}

.hero-tag {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    background: rgba(184, 98, 26, 0.25);
    backdrop-filter: blur(4px);
    border: 1px solid rgba(212, 144, 58, 0.4);
    padding: 6px 14px;
    border-radius: 999px;
    font-size: 13px;
    color: rgba(255,255,255,0.9);
    margin-bottom: 20px;
}

.hero-content h1 {
    font-size: 52px;
    font-family: 'Playfair Display', Georgia, serif;
    font-weight: 700;
    line-height: 1.12;
    margin-bottom: 16px;
    color: #fff;
}

.hero-content h1 span {
    color: #d4903a;
    font-style: italic;
}

.hero-content p {
    color: rgba(255,255,255,0.80);
    margin-bottom: 32px;
    font-size: 15.5px;
    line-height: 1.65;
}

.hero-btns {
    display: flex;
    gap: 14px;
    flex-wrap: wrap;
}

.btn-hero-primary {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    background: #b8621a;
    color: #fff;
    padding: 13px 26px;
    border-radius: 10px;
    font-size: 15px;
    font-weight: 600;
    text-decoration: none;
    transition: background 0.2s, transform 0.15s;
}

.btn-hero-primary:hover {
    background: #3b1f0a;
    color: #fff;
    transform: translateY(-1px);
}

.btn-hero-ghost {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    border: 1.5px solid rgba(255,255,255,0.55);
    color: #fff;
    padding: 13px 24px;
    border-radius: 10px;
    font-size: 15px;
    font-weight: 500;
    text-decoration: none;
    transition: background 0.2s, border-color 0.2s;
}

.btn-hero-ghost:hover {
    background: rgba(255,255,255,0.12);
    border-color: rgba(255,255,255,0.8);
    color: #fff;
}

/* SECTION */
.drink-section {
    padding: 48px 24px 60px;
    background: #fdf8f2;
}

.section-title {
    font-family: 'Playfair Display', Georgia, serif;
    font-size: 26px;
    font-weight: 700;
    color: #2c1810;
}

/* CENTER WRAPPER */
.drink-wrapper {
    max-width: 1160px;
    margin: 0 auto;
}

/* GRID */
.drink-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 24px;
}

@media (max-width: 1024px) {
    .drink-grid { grid-template-columns: repeat(3, 1fr); }
}
@media (max-width: 700px) {
    .drink-grid { grid-template-columns: repeat(2, 1fr); }
}
@media (max-width: 440px) {
    .drink-grid { grid-template-columns: 1fr; }
}

/* CARD */
.drink-card {
    background: #fff;
    border-radius: 16px;
    overflow: hidden;
    border: 1px solid #ede0cc;
    box-shadow: 0 2px 10px rgba(26,10,0,0.07);
    transition: box-shadow 0.2s, transform 0.2s;
}

.drink-card:hover {
    box-shadow: 0 8px 28px rgba(26,10,0,0.14);
    transform: translateY(-4px);
}

/* IMAGE */
.drink-img {
    width: 100%;
    height: 200px;
    object-fit: cover;
    display: block;
}

/* BODY */
.drink-body {
    padding: 16px 16px 20px;
    text-align: center;
}

.drink-body h4 {
    font-size: 16px;
    font-weight: 600;
    color: #2c1810;
    margin-bottom: 6px;
}

.price {
    color: #b8621a;
    font-size: 14px;
    font-weight: 600;
    margin-bottom: 14px;
}

.drink-body .btn {
    background: #b8621a !important;
    border-color: #b8621a !important;
    color: #fff !important;
    border-radius: 8px !important;
    padding: 7px 28px !important;
    font-size: 14px !important;
    font-weight: 500 !important;
    transition: background 0.2s !important;
}

.drink-body .btn:hover {
    background: #3b1f0a !important;
    border-color: #3b1f0a !important;
}

/* LOAD MORE */
#loadMoreBtn {
    border-color: #b8621a !important;
    color: #b8621a !important;
    border-radius: 10px !important;
    padding: 10px 36px !important;
    font-size: 14px !important;
    font-weight: 500 !important;
    background: transparent !important;
    transition: all 0.2s !important;
}

#loadMoreBtn:hover {
    background: #b8621a !important;
    color: #fff !important;
}

/* HIDDEN */
.hidden {
    display: none;
}

</style>

<%@ include file="/views/layout/admin/footer.jsp" %>
