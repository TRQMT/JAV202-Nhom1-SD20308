<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Poly Coffee — Đăng nhập</title>

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Google Material Icons -->
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />

<!-- Your CSS -->
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet"/>

<style>
.material-symbols-outlined {
    font-size: 18px;
    vertical-align: middle;
    margin-right: 6px;
}

.header-title {
    font-family: 'Playfair Display', serif;
    color: #fff;
    font-size: 32px;
    letter-spacing: 2px;
}

.navbar {
    background: #1a0a00 !important;
}
</style>

</head>

<body>

<!-- HEADER -->
<header class="text-center py-3" style="background: linear-gradient(135deg,#3b1f0a,#6b3317);">
    <h1 class="header-title">WELCOME TO MY COFFEE</h1>
</header>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-xl navbar-dark">
    <div class="container-fluid px-4">

        <button class="navbar-toggler" type="button"
            data-bs-toggle="collapse" data-bs-target="#navbarMain">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarMain">
            <ul class="navbar-nav me-auto">

                <li class="nav-item">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/trang-chu">
                        <span class="material-symbols-outlined">home</span>
                        Trang chủ
                    </a>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle active" href="#"
                       role="button" data-bs-toggle="dropdown">

                        <span class="material-symbols-outlined">account_circle</span>

                        ${sessionScope.user != null ? sessionScope.user.fullName : "Tài khoản"}
                    </a>

                    <ul class="dropdown-menu">

                        <c:if test="${sessionScope.user == null}">
                            <li>
                                <a class="dropdown-item"
                                   href="${pageContext.request.contextPath}/dang-nhap">
                                    <span class="material-symbols-outlined">login</span>
                                    Đăng nhập
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item"
                                   href="${pageContext.request.contextPath}/quen-mat-khau">
                                    <span class="material-symbols-outlined">lock_reset</span>
                                    Quên mật khẩu
                                </a>
                            </li>
                        </c:if>

                        <c:if test="${sessionScope.user != null}">
                            <li>
                                <a class="dropdown-item"
                                   href="${pageContext.request.contextPath}/edit-profile">
                                    <span class="material-symbols-outlined">person</span>
                                    Thông tin cá nhân
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item"
                                   href="${pageContext.request.contextPath}/logout">
                                    <span class="material-symbols-outlined">logout</span>
                                    Đăng xuất
                                </a>
                            </li>
                        </c:if>

                    </ul>
                </li>

            </ul>
        </div>
    </div>
</nav>

<!-- MAIN -->
<main>
    <div class="login-split">
        <div class="login-card card">

            <!-- TOP -->
            <div class="login-card-top">
                <h3>ĐĂNG NHẬP</h3>
                <p>Hệ thống quản lý Poly Coffee</p>
            </div>

            <!-- FORM -->
            <div class="card-body" style="padding:32px !important;">

                <c:if test="${not empty message}">
                    <div class="alert alert-danger mb-3">${message}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/dang-nhap" method="post">

                    <!-- EMAIL -->
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control"
                               name="email" placeholder="example@gmail.com" required>
                    </div>

                    <!-- PASSWORD -->
                    <div class="mb-3">
                        <label class="form-label">Mật khẩu</label>
                        <input type="password" class="form-control"
                               name="password" placeholder="Nhập mật khẩu" required>
                    </div>

                    <!-- BUTTON -->
                    <div class="mb-4">
                        <button class="btn btn-primary w-100" style="padding:10px;">
                            <span class="material-symbols-outlined">login</span>
                            Đăng nhập
                        </button>
                    </div>

                    <!-- FORGOT -->
                    <div class="text-center">
                        <a href="${pageContext.request.contextPath}/quen-mat-khau"
                           style="color:var(--caramel);font-size:13.5px;">
                            <span class="material-symbols-outlined">lock_reset</span>
                            Quên mật khẩu?
                        </a>
                    </div>

                </form>

            </div>
        </div>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
