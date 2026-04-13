<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Poly Coffee — <c:out value="${not empty pageTitle ? pageTitle : 'Trang chủ'}"/></title>

<!-- FONT + BOOTSTRAP -->
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet"/>

<!-- CSS -->
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet"/>

<style>
/* ── Navbar reset to dark espresso design ── */
.navbar {
    background: #1a0a00 !important;
    border-bottom: none;
    min-height: 64px;
    padding: 0 !important;
    box-shadow: 0 2px 12px rgba(0,0,0,0.3);
}

/* LOGO */
.navbar-brand {
    font-family: 'Playfair Display', serif;
    font-weight: 700;
    font-size: 20px;
    color: #fff !important;
    display: flex;
    align-items: center;
    gap: 8px;
    padding: 0 !important;
}

.navbar-brand .material-symbols-outlined {
    font-size: 22px;
    color: #fff;
    background: #b8621a;
    border-radius: 8px;
    padding: 5px;
    width: 36px;
    height: 36px;
    display: flex;
    align-items: center;
    justify-content: center;
}

/* CENTER NAV LINKS */
.navbar-nav.mx-auto {
    gap: 2px;
}

.nav-link {
    color: rgba(255,255,255,0.75) !important;
    font-size: 14px;
    font-weight: 500;
    padding: 7px 16px !important;
    border-radius: 999px;
    transition: all 0.18s ease;
    display: flex;
    align-items: center;
    gap: 5px;
}

.nav-link .material-symbols-outlined {
    font-size: 16px;
    vertical-align: middle;
}

.nav-link:hover {
    background: rgba(255,255,255,0.08);
    color: #fff !important;
}

.nav-link.active {
    background: rgba(184,98,26,0.25);
    color: #d4903a !important;
    font-weight: 600;
}

.nav-link.active::after { display: none; }

/* DROPDOWN */
.dropdown-menu {
    background: #1a0a00 !important;
    border: 1px solid rgba(255,255,255,0.1) !important;
    border-radius: 12px !important;
    box-shadow: 0 8px 24px rgba(0,0,0,0.35) !important;
    padding: 6px !important;
    min-width: 200px;
}

.dropdown-item {
    color: rgba(255,255,255,0.75) !important;
    font-size: 13.5px;
    border-radius: 8px;
    padding: 9px 14px !important;
    display: flex;
    align-items: center;
    gap: 8px;
    transition: background 0.15s;
}

.dropdown-item:hover {
    background: rgba(184,98,26,0.2) !important;
    color: #d4903a !important;
}

.dropdown-item.text-danger { color: #f87171 !important; }
.dropdown-item.text-danger:hover { background: rgba(220,38,38,0.15) !important; }

.dropdown-divider { border-color: rgba(255,255,255,0.1) !important; margin: 4px 8px !important; }

/* ACCOUNT BUTTON */
.navbar .navbar-nav:last-child .nav-link.dropdown-toggle {
    border: 1.5px solid #b8621a !important;
    color: #d4903a !important;
    border-radius: 999px;
    padding: 6px 16px !important;
    font-weight: 600;
    background: transparent;
}

.navbar .navbar-nav:last-child .nav-link.dropdown-toggle:hover {
    background: #b8621a !important;
    color: #fff !important;
}

/* MOBILE TOGGLER */
.navbar-toggler {
    border-color: rgba(255,255,255,0.3) !important;
}
.navbar-toggler-icon {
    filter: invert(1) !important;
}

.material-symbols-outlined {
    font-size: 18px;
    vertical-align: middle;
}

/* ── Navbar Responsive ── */
@media (max-width: 1199px) {
    .navbar .navbar-collapse {
        background: #1a0a00;
        padding: 12px 8px 16px;
        border-top: 1px solid rgba(255,255,255,0.08);
        margin-top: 4px;
    }
    .navbar-nav.mx-auto {
        gap: 2px;
        margin-bottom: 8px;
    }
    .nav-link {
        padding: 10px 14px !important;
        border-radius: 8px;
    }
    .navbar .navbar-nav:last-child .nav-link.dropdown-toggle {
        border-radius: 8px !important;
        margin-top: 4px;
        width: 100%;
        justify-content: center;
    }
    .dropdown-menu {
        position: static !important;
        background: rgba(255,255,255,0.05) !important;
        border: none !important;
        box-shadow: none !important;
        margin-top: 4px;
    }
}

@media (max-width: 576px) {
    .navbar-brand {
        font-size: 17px !important;
    }
    .navbar-brand .material-symbols-outlined {
        width: 30px !important;
        height: 30px !important;
        font-size: 18px !important;
    }
}
</style>

${extraStyles}
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-xl">
    <div class="container-fluid px-4 d-flex align-items-center justify-content-between">

        <!-- LEFT LOGO -->
        <a class="navbar-brand"
           href="${pageContext.request.contextPath}/trang-chu">
            <span class="material-symbols-outlined">local_cafe</span>
            MyCafe
        </a>

        <!-- TOGGLE MOBILE -->
        <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse" data-bs-target="#navMain">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- NAV CONTENT -->
        <div class="collapse navbar-collapse justify-content-between" id="navMain">

            <!-- CENTER MENU -->
            <ul class="navbar-nav mx-auto">

                <li class="nav-item">
                    <a class="nav-link ${activeNav == 'home' ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/trang-chu">
                        <span class="material-symbols-outlined">home</span>Trang chủ
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link ${activeNav == 'categories' ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/manager/categories">
                        <span class="material-symbols-outlined">category</span>Loại đồ uống
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link ${activeNav == 'drinks' ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/manager/drinks">
                        <span class="material-symbols-outlined">coffee</span>Đồ uống
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link ${activeNav == 'bills' ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/bills">
                        <span class="material-symbols-outlined">receipt_long</span>Hóa đơn
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link ${activeNav == 'staff' ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/manager/staff">
                        <span class="material-symbols-outlined">groups</span>Nhân viên
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link ${activeNav == 'statistics' ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/manager/statistics">
                        <span class="material-symbols-outlined">bar_chart</span>Thống kê
                    </a>
                </li>

                <c:if test="${sessionScope.user != null}">
                    <li class="nav-item">
                        <a class="nav-link ${activeNav == 'pos' ? 'active' : ''}"
                           href="${pageContext.request.contextPath}/employee/pos">
                            <span class="material-symbols-outlined">point_of_sale</span>Bán hàng
                        </a>
                    </li>
                </c:if>

            </ul>

            <!-- RIGHT ACCOUNT -->
            <ul class="navbar-nav">
                <li class="nav-item dropdown">

                    <a class="nav-link dropdown-toggle"
                       href="#" data-bs-toggle="dropdown">

                        <span class="material-symbols-outlined">account_circle</span>

                        <c:choose>
                            <c:when test="${sessionScope.user != null}">
                                ${sessionScope.user.fullName}
                            </c:when>
                            <c:otherwise>
                                Tài khoản
                            </c:otherwise>
                        </c:choose>

                    </a>

                    <ul class="dropdown-menu dropdown-menu-end">

                        <c:choose>

                            <c:when test="${sessionScope.user == null}">
                                <li>
                                    <a class="dropdown-item"
                                       href="${pageContext.request.contextPath}/dang-nhap">
                                        <span class="material-symbols-outlined">login</span>
                                        Đăng nhập
                                    </a>
                                </li>
                            </c:when>

                            <c:otherwise>

                                <li class="dropdown-header text-muted small">
                                    ${sessionScope.user.email}
                                </li>

                                <li><hr class="dropdown-divider"></li>

                                <li>
                                    <a class="dropdown-item"
                                       href="${pageContext.request.contextPath}/edit-profile">
                                        <span class="material-symbols-outlined">person</span>
                                        Thông tin cá nhân
                                    </a>
                                </li>

                                <li>
                                    <a class="dropdown-item"
                                       href="${pageContext.request.contextPath}/change-pass">
                                        <span class="material-symbols-outlined">password</span>
                                        Đổi mật khẩu
                                    </a>
                                </li>

                                <li><hr class="dropdown-divider"></li>

                                <li>
                                    <a class="dropdown-item text-danger"
                                       href="${pageContext.request.contextPath}/logout">
                                        <span class="material-symbols-outlined">logout</span>
                                        Đăng xuất
                                    </a>
                                </li>

                            </c:otherwise>

                        </c:choose>

                    </ul>
                </li>
            </ul>

        </div>
    </div>
</nav>

