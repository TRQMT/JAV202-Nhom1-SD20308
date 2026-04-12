<%-- FOOTER --%>
<footer>
    <div class="footer-inner">
        <div class="footer-grid">
            <div>
                <div class="footer-brand">
                    <div class="footer-brand-mark">
                        <span class="material-symbols-outlined" style="font-size: 16px; color: #fff">local_cafe</span>
                    </div>
                    Poly Coffee
                </div>
                <div class="footer-desc">
                    Thưởng thức cà phê nguyên chất mỗi ngày tại Poly Coffee.
                    Pha chế tươi mỗi buổi sáng.
                </div>
                <div class="footer-socials">
                    <div class="social-btn">
                        <span class="material-symbols-outlined" style="font-size: 18px">photo_camera</span>
                    </div>
                    <div class="social-btn">
                        <span class="material-symbols-outlined" style="font-size: 18px">thumb_up</span>
                    </div>
                    <div class="social-btn">
                        <span class="material-symbols-outlined" style="font-size: 18px">chat</span>
                    </div>
                </div>
            </div>
            <div>
                <h4>Menu</h4>
                <a class="footer-link" href="${pageContext.request.contextPath}/manager/drinks">Tất cả đồ uống</a>
                <a class="footer-link" href="${pageContext.request.contextPath}/manager/categories">Loại đồ uống</a>
            </div>
            <div>
                <h4>Quản lý</h4>
                <a class="footer-link" href="${pageContext.request.contextPath}/manager/staff">Nhân viên</a>
                <a class="footer-link" href="${pageContext.request.contextPath}/bills">Hóa đơn</a>
                <a class="footer-link" href="${pageContext.request.contextPath}/manager/statistics">Thống kê</a>
            </div>
            <div>
                <h4>Tài khoản</h4>
                <a class="footer-link" href="${pageContext.request.contextPath}/edit-profile">Thông tin cá nhân</a>
                <a class="footer-link" href="${pageContext.request.contextPath}/change-pass">Đổi mật khẩu</a>
                <a class="footer-link" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
            </div>
        </div>
        <div class="footer-bottom">
            <span>&copy; 2025 Poly Coffee — Nhóm 1 JAV202</span>
            <span>Made with
                <span class="material-symbols-outlined" style="font-size: 14px; color: #d4903a">favorite</span>
                in Ho Chi Minh City
            </span>
        </div>
    </div>
</footer>

<style>
footer {
    background: #1a0a00;
    color: rgba(255,255,255,0.5);
    font-size: 13px;
    border-top: 1px solid rgba(255,255,255,0.08);
}

.footer-inner {
    max-width: 1160px;
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
    font-family: 'Playfair Display', Georgia, serif;
    font-size: 18px;
    color: #fff;
    font-weight: 700;
    margin-bottom: 12px;
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
    text-decoration: none;
    transition: color 0.2s;
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
    .footer-grid { grid-template-columns: 1fr 1fr; gap: 28px; }
}
@media (max-width: 540px) {
    .footer-grid { grid-template-columns: 1fr; }
    .footer-bottom { flex-direction: column; text-align: center; }
}
</style>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
${extraScripts}
</body>
</html>
