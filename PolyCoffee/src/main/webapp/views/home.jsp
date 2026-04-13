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
                <a href="${pageContext.request.contextPath}/employee/pos"
                   class="btn-hero-primary">
                    <span class="material-symbols-outlined" style="font-size:18px">menu_book</span>
                    Browse Menu
                </a>
            </div>
        </div>
    </div>

    <!-- BEST SELLERS -->
    <div class="drink-section">

        <div class="drink-wrapper">

            <div class="section-header">
                <div class="section-label">Bán chạy nhất</div>
                <h2 class="section-title">Đồ uống nổi bật</h2>
                <p class="section-sub">Những ly cà phê được yêu thích nhất tại Poly Coffee</p>
            </div>

            <div class="drink-grid">

                <!-- CARD 1 -->
                <div class="drink-card">
                    <div class="drink-img-wrap">
                        <img src="https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400&h=300&fit=crop"
                             class="drink-img" alt="Cà phê đen đá">
                        <div class="bestseller-badge">
                            <span class="material-symbols-outlined" style="font-size:13px">star</span>
                            Best Seller
                        </div>
                    </div>
                    <div class="drink-body">
                        <h4>Cà phê đen đá</h4>
                        <p class="price">25.000 VNĐ</p>
                        <a href="${pageContext.request.contextPath}/employee/pos" class="btn-choose">Chọn</a>
                    </div>
                </div>

                <!-- CARD 2 -->
                <div class="drink-card">
                    <div class="drink-img-wrap">
                        <img src="https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=400&h=300&fit=crop"
                             class="drink-img" alt="Cà phê sữa đá">
                        <div class="bestseller-badge">
                            <span class="material-symbols-outlined" style="font-size:13px">star</span>
                            Best Seller
                        </div>
                    </div>
                    <div class="drink-body">
                        <h4>Cà phê sữa đá</h4>
                        <p class="price">30.000 VNĐ</p>
                        <a href="${pageContext.request.contextPath}/employee/pos" class="btn-choose">Chọn</a>
                    </div>
                </div>

                <!-- CARD 3 -->
                <div class="drink-card">
                    <div class="drink-img-wrap">
                        <img src="https://images.unsplash.com/photo-1570968915860-54d5c301fa9f?w=400&h=300&fit=crop"
                             class="drink-img" alt="Cappuccino">
                        <div class="bestseller-badge">
                            <span class="material-symbols-outlined" style="font-size:13px">star</span>
                            Best Seller
                        </div>
                    </div>
                    <div class="drink-body">
                        <h4>Cappuccino</h4>
                        <p class="price">45.000 VNĐ</p>
                        <a href="${pageContext.request.contextPath}/employee/pos" class="btn-choose">Chọn</a>
                    </div>
                </div>

                <!-- CARD 4 -->
                <div class="drink-card">
                    <div class="drink-img-wrap">
                        <img src="https://i.pinimg.com/736x/c5/8a/88/c58a88f9190b8b751a4576edca99f7ef.jpg"
                             class="drink-img" alt="Bạc xỉu">
                        <div class="bestseller-badge">
                            <span class="material-symbols-outlined" style="font-size:13px">star</span>
                            Best Seller
                        </div>
                    </div>
                    <div class="drink-body">
                        <h4>Bạc xỉu</h4>
                        <p class="price">32.000 VNĐ</p>
                        <a href="${pageContext.request.contextPath}/employee/pos" class="btn-choose">Chọn</a>
                    </div>
                </div>

            </div>

            <div class="text-center mt-5">
                <a href="${pageContext.request.contextPath}/employee/pos" class="btn-viewall">
                    <span class="material-symbols-outlined" style="font-size:18px">menu_book</span>
                    Xem toàn bộ menu
                </a>
            </div>

        </div>

    </div>

</main>

<!-- FOOTER -->
     <footer>
        <div class="footer-inner">
          <div class="footer-grid">
            <div>
              <div class="footer-brand">
                <div class="footer-brand-mark">
                  <span class="material-symbols-outlined" style="font-size: 16px; color: #fff"
                    >storefront</span
                  >
                </div>
                Fresh Market
              </div>
              <div class="footer-desc">
                Farm-fresh cold-pressed juices, herbal teas and smoothies
                delivered across Ho Chi Minh City every morning.
              </div>
              <div class="footer-socials">
                <div
                  class="social-btn"
                  onclick="showToast('Follow us @freshmarket on Instagram!')"
                >
                  <span class="material-symbols-outlined" style="font-size: 18px">photo_camera</span>
                </div>
                <div
                  class="social-btn"
                  onclick="showToast('Like us on Facebook!')"
                >
                  <span class="material-symbols-outlined" style="font-size: 18px">thumb_up</span>
                </div>
                <div
                  class="social-btn"
                  onclick="showToast('Chat with us on WhatsApp!')"
                >
                  <span class="material-symbols-outlined" style="font-size: 18px">chat</span>
                </div>
              </div>
            </div>
            <div>
              <h4>Shop</h4>
              <a class="footer-link" onclick="showPage('menu')">All drinks</a
              ><a class="footer-link" onclick="setCat('juice');showPage('menu')"
                >Cold-pressed juices</a
              ><a
                class="footer-link"
                onclick="setCat('smoothie');showPage('menu')"
                >Smoothies</a
              ><a class="footer-link" onclick="setCat('tea');showPage('menu')"
                >Herbal teas</a
              >
            </div>
            <div>
              <h4>Company</h4>
              <a class="footer-link" onclick="showPage('about')">About us</a
              ><a class="footer-link" onclick="showPage('delivery')">Delivery</a
              ><a class="footer-link" onclick="showToast('Blog coming soon!')"
                >Blog</a
              ><a
                class="footer-link"
                onclick="showToast('Careers page coming soon!')"
                >Careers</a
              >
            </div>
            <div>
              <h4>Help</h4>
              <a
                class="footer-link"
                onclick="showToast('Team available 8am–8pm daily.')"
                >Contact us</a
              ><a
                class="footer-link"
                onclick="showToast('Full refund within 24 hours if unsatisfied.')"
                >Returns</a
              ><a
                class="footer-link"
                onclick="showToast('We never share your data.')"
                >Privacy</a
              ><a
                class="footer-link"
                onclick="showToast('Terms available on request.')"
                >Terms</a
              >
            </div>
          </div>
          <div class="footer-bottom">
            <span>© 2026 Fresh Market All rights reserved.</span
            ><span
              >Made with
              <span class="material-symbols-outlined" style="font-size: 14px; color: var(--caramel)"
                >favorite</span
              >
              in Ho Chi Minh City</span
            >
          </div>
        </div>
      </footer>

<!-- SCRIPT -->
<script></script>
<%@ include file="/views/layout/admin/footer.jsp" %>
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
    padding: 64px 24px 72px;
    background: #fdf8f2;
}

.drink-wrapper {
    max-width: 1160px;
    margin: 0 auto;
}

/* SECTION HEADER */
.section-header {
    text-align: center;
    margin-bottom: 44px;
}

.section-label {
    display: inline-block;
    background: rgba(184,98,26,0.12);
    color: #b8621a;
    font-size: 12.5px;
    font-weight: 700;
    letter-spacing: 1px;
    text-transform: uppercase;
    padding: 5px 14px;
    border-radius: 999px;
    margin-bottom: 14px;
    border: 1px solid rgba(184,98,26,0.2);
}

.section-title {
    font-family: 'Playfair Display', Georgia, serif;
    font-size: 32px;
    font-weight: 700;
    color: #2c1810;
    margin-bottom: 10px;
}

.section-sub {
    color: #8a7060;
    font-size: 15px;
    margin: 0;
}

/* GRID */
.drink-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 24px;
}

@media (max-width: 1024px) { .drink-grid { grid-template-columns: repeat(2, 1fr); } }
@media (max-width: 540px)  { .drink-grid { grid-template-columns: 1fr; } }

/* CARD */
.drink-card {
    background: #fff;
    border-radius: 18px;
    overflow: hidden;
    border: 1px solid #ede0cc;
    box-shadow: 0 2px 12px rgba(26,10,0,0.07);
    transition: box-shadow 0.25s, transform 0.25s;
}

.drink-card:hover {
    box-shadow: 0 12px 36px rgba(26,10,0,0.14);
    transform: translateY(-5px);
}

/* IMAGE WRAP */
.drink-img-wrap {
    position: relative;
    overflow: hidden;
}

.drink-img {
    width: 100%;
    height: 210px;
    object-fit: cover;
    display: block;
    transition: transform 0.35s;
}

.drink-card:hover .drink-img {
    transform: scale(1.05);
}

/* BEST SELLER BADGE */
.bestseller-badge {
    position: absolute;
    top: 12px;
    left: 12px;
    background: #b8621a;
    color: #fff;
    font-size: 11px;
    font-weight: 700;
    padding: 4px 10px;
    border-radius: 999px;
    display: flex;
    align-items: center;
    gap: 4px;
    box-shadow: 0 2px 8px rgba(184,98,26,0.4);
    letter-spacing: .3px;
}

/* CARD BODY */
.drink-body {
    padding: 18px 18px 22px;
    text-align: center;
}

.drink-body h4 {
    font-size: 16px;
    font-weight: 700;
    color: #2c1810;
    margin-bottom: 6px;
    font-family: 'Playfair Display', Georgia, serif;
}

.price {
    color: #b8621a;
    font-size: 14.5px;
    font-weight: 600;
    margin-bottom: 16px;
}

/* CHOOSE BUTTON */
.btn-choose {
    display: inline-block;
    background: #b8621a;
    color: #fff;
    border: none;
    border-radius: 9px;
    padding: 8px 30px;
    font-size: 14px;
    font-weight: 600;
    text-decoration: none;
    transition: background 0.2s, transform 0.15s;
}

.btn-choose:hover {
    background: #3b1f0a;
    color: #fff;
    transform: translateY(-1px);
}

/* VIEW ALL BUTTON */
.btn-viewall {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    border: 2px solid #b8621a;
    color: #b8621a;
    background: transparent;
    padding: 12px 32px;
    border-radius: 12px;
    font-size: 15px;
    font-weight: 600;
    text-decoration: none;
    transition: all 0.2s;
}

.btn-viewall:hover {
    background: #b8621a;
    color: #fff;
}

/* ===== FOOTER ===== */
footer {
    background: #1a0a00;
    color: rgba(255,255,255,0.5);
    font-size: 13px;
    border-top: 1px solid rgba(255,255,255,0.08);
    margin-top: 0;
}

.footer-inner {
    max-width: 1100px;
    margin: 0 auto;
    padding: 52px 32px 28px;
}

.footer-grid {
    display: grid;
    grid-template-columns: 2fr 1fr 1fr 1fr;
    gap: 48px;
    margin-bottom: 40px;
    text-align: left;
}

.footer-brand {
    display: flex;
    align-items: center;
    gap: 10px;
    font-size: 18px;
    color: #fff;
    font-weight: 700;
    margin-bottom: 12px;
    font-family: 'Playfair Display', Georgia, serif;
}

.footer-brand-mark {
    width: 34px;
    height: 34px;
    background: #b8621a;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
}

.footer-desc {
    font-size: 13.5px;
    color: rgba(255,255,255,0.4);
    line-height: 1.75;
    margin-bottom: 20px;
}

.footer-socials {
    display: flex;
    gap: 10px;
}

.social-btn {
    width: 38px;
    height: 38px;
    border-radius: 50%;
    background: rgba(255,255,255,0.07);
    border: 1px solid rgba(255,255,255,0.12);
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    color: rgba(255,255,255,0.55);
    transition: background 0.2s, color 0.2s, border-color 0.2s;
}

.social-btn:hover {
    background: #b8621a;
    color: #fff;
    border-color: #b8621a;
}

.footer-grid h4 {
    font-size: 11px;
    font-weight: 700;
    color: #fff;
    letter-spacing: 1.2px;
    text-transform: uppercase;
    margin-bottom: 16px;
    margin-top: 0;
}

.footer-link {
    display: block;
    font-size: 13.5px;
    color: rgba(255,255,255,0.45);
    padding: 5px 0;
    cursor: pointer;
    transition: color 0.2s;
    text-decoration: none;
}

.footer-link:hover {
    color: #d4903a;
}

.footer-bottom {
    border-top: 1px solid rgba(255,255,255,0.08);
    padding-top: 22px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 8px;
    font-size: 12px;
    color: rgba(255,255,255,0.28);
}

@media (max-width: 900px) {
    .footer-grid {
        grid-template-columns: 1fr 1fr;
        gap: 28px;
    }
}

@media (max-width: 540px) {
    .footer-grid {
        grid-template-columns: 1fr;
    }
    .footer-bottom {
        flex-direction: column;
        text-align: center;
    }
}

</style>
