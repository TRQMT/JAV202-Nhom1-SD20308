<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Quên mật khẩu — MyCafe</title>
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,400;0,600;1,400&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet"/>
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}

:root{
    --espresso:#1c0f07;--mahogany:#4a1e10;--caramel:#8b4513;--latte:#c9a07a;
    --cream:#f5ede3;--parchment:#faf6f0;--gold:#c9973a;--gold-light:#e8c97a;
    --border:#e8d8c8;--danger:#8b2020;
}

body{
    font-family:'DM Sans',sans-serif;
    min-height:100vh;
    display:grid;
    grid-template-columns:1fr 1fr;
    background:var(--espresso);
    overflow:hidden;
}

.visual-panel{
    background:linear-gradient(160deg,var(--mahogany) 0%,#2e1008 60%,#0d0503 100%);
    display:flex;flex-direction:column;align-items:center;justify-content:center;
    padding:3rem;
    position:relative;
    overflow:hidden;
}
.visual-panel::before{
    content:'';position:absolute;inset:0;
    background:radial-gradient(ellipse at 30% 40%,rgba(201,151,58,.18) 0%,transparent 65%),
             radial-gradient(ellipse at 75% 80%,rgba(139,69,19,.25) 0%,transparent 55%);
}
.visual-panel .rings{
    position:absolute;width:480px;height:480px;
    border-radius:50%;border:1px solid rgba(201,160,122,.08);
    top:50%;left:50%;transform:translate(-50%,-50%);
}
.visual-panel .rings::before{
    content:'';position:absolute;inset:40px;border-radius:50%;
    border:1px solid rgba(201,160,122,.1);
}
.visual-panel .rings::after{
    content:'';position:absolute;inset:80px;border-radius:50%;
    border:1px solid rgba(201,160,122,.08);
}

.brand-area{position:relative;text-align:center;}
.brand-icon{
    width:90px;height:90px;border-radius:50%;
    background:linear-gradient(135deg,var(--caramel),var(--mahogany));
    display:flex;align-items:center;justify-content:center;
    font-size:2.8rem;margin:0 auto 1.5rem;
    box-shadow:0 8px 32px rgba(201,151,58,.3);
}
.brand-name{
    font-family:'Cormorant Garamond',serif;
    font-size:3rem;font-weight:600;
    color:var(--gold-light);letter-spacing:.12em;
    line-height:1;margin-bottom:.5rem;
}
.brand-tagline{
    color:rgba(255,255,255,.45);
    font-size:.85rem;letter-spacing:.18em;text-transform:uppercase;
    font-weight:300;
}

.visual-footer{
    position:absolute;bottom:2rem;left:0;right:0;
    text-align:center;color:rgba(255,255,255,.18);
    font-size:.75rem;letter-spacing:.1em;text-transform:uppercase;
}

.form-panel{
    background:var(--parchment);
    display:flex;flex-direction:column;align-items:center;justify-content:center;
    padding:2.3rem 3.5rem;
    position:relative;
}
.form-panel::before{
    content:'';position:absolute;
    top:0;bottom:0;left:0;width:1px;
    background:linear-gradient(to bottom,transparent,var(--border) 20%,var(--border) 80%,transparent);
}

.form-inner{width:100%;max-width:420px;}

.form-heading{
    font-family:'Cormorant Garamond',serif;
    font-size:2rem;font-weight:600;
    color:var(--espresso);margin-bottom:.35rem;
}
.form-sub{
    color:#7a6858;font-size:.875rem;margin-bottom:1.4rem;
}

.otp-email{
    overflow-wrap:anywhere;
    word-break:break-word;
}

.field{margin-bottom:1rem;}
.field label{
    display:block;font-size:.78rem;font-weight:600;
    letter-spacing:.06em;text-transform:uppercase;
    color:var(--mahogany);margin-bottom:.45rem;
}
.input-wrap{position:relative;}
.input-wrap .icon{
    position:absolute;left:.85rem;top:50%;transform:translateY(-50%);
    color:var(--latte);font-size:18px!important;pointer-events:none;
}
.input-wrap input{
    width:100%;border:1.5px solid var(--border);border-radius:10px;
    padding:.7rem .9rem .7rem 2.7rem;
    font-size:.9rem;font-family:'DM Sans',sans-serif;
    background:#fff;color:var(--espresso);
    transition:border-color .2s,box-shadow .2s;outline:none;
}
.input-wrap input:focus{
    border-color:var(--latte);
    box-shadow:0 0 0 3px rgba(201,160,122,.2);
}
.input-wrap input::placeholder{color:#c0ab9a;}

.notice-box{
    border-radius:10px;padding:.75rem 1rem;
    font-size:.85rem;display:flex;align-items:center;gap:.5rem;
    margin-bottom:1rem;
}
.error-box{
    background:rgba(139,32,32,.07);border:1.5px solid rgba(139,32,32,.25);
    color:var(--danger);
}
.success-box{
    background:rgba(25,135,84,.08);border:1.5px solid rgba(25,135,84,.3);
    color:#146c43;
}

.btn-primary-cafe{
    width:100%;padding:.85rem;border:none;
    background:linear-gradient(135deg,var(--caramel),var(--mahogany));
    color:#fff;font-family:'DM Sans',sans-serif;font-size:.95rem;font-weight:600;
    letter-spacing:.04em;border-radius:10px;cursor:pointer;
    display:flex;align-items:center;justify-content:center;gap:.5rem;
    box-shadow:0 4px 18px rgba(74,30,16,.3);
    transition:opacity .2s,transform .15s,box-shadow .2s;
}
.btn-primary-cafe:hover{
    opacity:.92;transform:translateY(-1px);
    box-shadow:0 8px 28px rgba(74,30,16,.38);
}

.form-links{
    display:flex;justify-content:space-between;gap:12px;margin-top:14px;
    font-size:.88rem;
}
.form-links a{color:#6b3317;text-decoration:none;}
.form-links a:hover{text-decoration:underline;}

.material-symbols-outlined{font-size:18px!important;vertical-align:middle;}

@media(max-width:700px){
    body{grid-template-columns:1fr;overflow:auto;}
    .visual-panel{padding:2.5rem 1.5rem;min-height:220px;}
    .brand-name{font-size:2.2rem;}
    .brand-icon{width:64px;height:64px;font-size:2rem;margin-bottom:1rem;}
    .form-panel{padding:2.2rem 1.2rem;}
    .rings{display:none;}
}
</style>
</head>
<body>

<div class="visual-panel">
    <div class="rings"></div>
    <div class="brand-area">
        <div class="brand-icon">☕</div>
        <div class="brand-name">MyCafe</div>
        <div class="brand-tagline">Khôi phục quyền truy cập</div>
    </div>
    <div class="visual-footer">mycafe account</div>
</div>

<div class="form-panel">
    <div class="form-inner">
            <div class="form-heading">Quên mật khẩu</div>
            <div class="form-sub">Nhập email để nhận OTP đặt lại mật khẩu</div>

            <c:if test="${not empty error}">
                <div class="notice-box error-box">
                    <span class="material-symbols-outlined">error</span>
                    ${error}
                </div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="notice-box success-box">
                    <span class="material-symbols-outlined">check_circle</span>
                    ${success}
                </div>
            </c:if>

            <c:choose>
                <c:when test="${step == 'verify'}">
                    <div class="form-sub otp-email" style="margin-bottom:1rem;">
                        Nhập OTP và mật khẩu mới cho email: <strong>${email}</strong>
                    </div>
                    <form method="post" action="${pageContext.request.contextPath}/quen-mat-khau" autocomplete="off">
                        <input type="hidden" name="action" value="reset">
                        <div class="field">
                            <label>Mã OTP</label>
                            <div class="input-wrap">
                                <span class="material-symbols-outlined icon">pin</span>
                                <input type="text" maxlength="6" name="otp" placeholder="Nhập 6 chữ số" required>
                            </div>
                        </div>
                        <div class="field">
                            <label>Mật khẩu mới</label>
                            <div class="input-wrap">
                                <span class="material-symbols-outlined icon">lock</span>
                                <input type="password" name="newPassword" placeholder="••••••••" required>
                            </div>
                        </div>
                        <div class="field" style="margin-bottom:1.4rem;">
                            <label>Xác nhận mật khẩu mới</label>
                            <div class="input-wrap">
                                <span class="material-symbols-outlined icon">lock_reset</span>
                                <input type="password" name="confirmPassword" placeholder="Nhập lại mật khẩu" required>
                            </div>
                        </div>
                        <button class="btn-primary-cafe" type="submit">
                            <span class="material-symbols-outlined">lock_reset</span>
                            Đặt lại mật khẩu
                        </button>
                    </form>
                </c:when>
                <c:otherwise>
                    <form method="post" action="${pageContext.request.contextPath}/quen-mat-khau" autocomplete="off">
                        <div class="field" style="margin-bottom:1.4rem;">
                            <label>Email</label>
                            <div class="input-wrap">
                                <span class="material-symbols-outlined icon">mail</span>
                                <input type="email" name="email" value="${email}" placeholder="ban@mycafe.vn" required autofocus>
                            </div>
                        </div>
                        <button class="btn-primary-cafe" type="submit">
                            <span class="material-symbols-outlined">mark_email_read</span>
                            Gửi OTP
                        </button>
                    </form>
                </c:otherwise>
            </c:choose>

            <div class="form-links">
                <a href="${pageContext.request.contextPath}/dang-nhap">Quay lại đăng nhập</a>
                <a href="${pageContext.request.contextPath}/dang-ky">Tạo tài khoản</a>
            </div>
    </div>
</div>
</body>
</html>
