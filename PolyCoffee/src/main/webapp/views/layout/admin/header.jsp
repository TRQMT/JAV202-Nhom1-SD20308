<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Poly Coffee — <c:out value="${not empty pageTitle ? pageTitle : 'Trang chủ'}"/></title>

<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet"/>

<style>
.material-symbols-outlined { font-size: 18px; vertical-align: middle; margin-right: 5px; }
.header-title { font-family: 'Playfair Display', serif; color: #fff; font-size: 32px; letter-spacing: 2px; }
.navbar { background: #1a0a00 !important; }
.card  { border-radius: 16px; box-shadow: 0 4px 16px rgba(0,0,0,.1); }
.table th { background: #f8f5f0; }
</style>

${extraStyles}
</head>
<body>

<!-- BANNER -->
<header class="text-center py-3"
        style="background: linear-gradient(135deg,#3b1f0a,#6b3317);">
    <h1 class="header-title">
        <img src="${pageContext.request.contextPath}/images/logo.png"
             alt="logo" height="36" class="me-2"
             onerror="this.style.display='none'">
        MyCafe
    </h1>
</header>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-xl navbar-dark">
    <div class="container-fluid px-4">

        <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse" data-bs-target="#navMain">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navMain">

            <!-- LEFT -->
            <ul class="navbar-nav me-auto">

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

                <%-- Thống kê — StatisticDAO đã có sẵn --%>
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

            <!-- RIGHT — ACCOUNT -->
            <ul class="navbar-nav">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">
                        <span class="material-symbols-outlined">account_circle</span>
                        ${sessionScope.user != null ? sessionScope.user.fullName : "Tài khoản"}
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <c:choose>
                            <c:when test="${sessionScope.user == null}">
                                <li>
                                    <a class="dropdown-item"
                                       href="${pageContext.request.contextPath}/dang-nhap">
                                        <span class="material-symbols-outlined">login</span>Đăng nhập
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
                                        <span class="material-symbols-outlined">person</span>Thông tin cá nhân
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item"
                                       href="${pageContext.request.contextPath}/change-pass">
                                        <span class="material-symbols-outlined">password</span>Đổi mật khẩu
                                    </a>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item text-danger"
                                       href="${pageContext.request.contextPath}/logout">
                                        <span class="material-symbols-outlined">logout</span>Đăng xuất
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
