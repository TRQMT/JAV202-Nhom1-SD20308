<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<%--
    TODO (TEAM):
    - Import database from .sql file
    - Create DB connection (JDBC)
    - Check tables: drinks, categories, staff, bills
    - Update DB username/password
--%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang chủ - Poly Coffee</title>

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

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
    font-size: 34px;
    letter-spacing: 2px;
}

.navbar {
    background: #1a0a00 !important;
}

.card {
    border-radius: 16px;
    box-shadow: 0 6px 18px rgba(0,0,0,0.1);
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
            data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">

            <!-- LEFT -->
            <ul class="navbar-nav me-auto">

                <li class="nav-item">
                    <a class="nav-link active"
                       href="${pageContext.request.contextPath}/trang-chu">
                        <span class="material-symbols-outlined">home</span>
                        Trang chủ
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/manager/drinks">
                        <span class="material-symbols-outlined">coffee</span>
                        Đồ uống
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/bills">
                        <span class="material-symbols-outlined">receipt_long</span>
                        Hóa đơn
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/manager/staff">
                        <span class="material-symbols-outlined">groups</span>
                        Nhân viên
                    </a>
                </li>

                <c:if test="${sessionScope.user != null}">
                    <li class="nav-item">
                        <a class="nav-link"
                           href="${pageContext.request.contextPath}/employee/pos">
                            <span class="material-symbols-outlined">point_of_sale</span>
                            Bán hàng
                        </a>
                    </li>
                </c:if>

            </ul>

            <!-- RIGHT -->
            <ul class="navbar-nav">
                <li class="nav-item dropdown">

                    <a class="nav-link dropdown-toggle" href="#"
                       role="button" data-bs-toggle="dropdown">
                        <span class="material-symbols-outlined">account_circle</span>
                        ${sessionScope.user != null ? sessionScope.user.fullName : "Tài khoản"}
                    </a>

                    <ul class="dropdown-menu dropdown-menu-end">

                        <c:if test="${sessionScope.user == null}">
                            <li>
                                <a class="dropdown-item"
                                   href="${pageContext.request.contextPath}/dang-nhap">
                                    <span class="material-symbols-outlined">login</span>
                                    Đăng nhập
                                </a>
                            </li>
                        </c:if>

                        <c:if test="${sessionScope.user != null}">
                            <li>
                                <a class="dropdown-item"
                                   href="${pageContext.request.contextPath}/edit-profile">
                                    <span class="material-symbols-outlined">person</span>
                                    Thông tin
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
<main class="container mt-5">

    <div class="text-center mb-4">
        <h2>Choose Your Coffee</h2>
        <p class="text-muted">Select a drink to start your experience</p>
    </div>

    <div class="row">

        <!-- Espresso -->
        <div class="col-md-4 mb-4">
            <div class="card text-center p-3">
                <h5>
                    <span class="material-symbols-outlined">coffee</span>
                    Espresso
                </h5>
                <p class="text-muted">Strong and bold coffee</p>
                <button class="btn btn-primary">
                    <span class="material-symbols-outlined">shopping_cart</span>
                    Chọn
                </button>
            </div>
        </div>

        <!-- Cappuccino -->
        <div class="col-md-4 mb-4">
            <div class="card text-center p-3">
                <h5>
                    <span class="material-symbols-outlined">local_cafe</span>
                    Cappuccino
                </h5>
                <p class="text-muted">Smooth with milk foam</p>
                <button class="btn btn-success">
                    <span class="material-symbols-outlined">shopping_cart</span>
                    Chọn
                </button>
            </div>
        </div>

        <!-- Latte -->
        <div class="col-md-4 mb-4">
            <div class="card text-center p-3">
                <h5>
                    <span class="material-symbols-outlined">emoji_food_beverage</span>
                    Latte
                </h5>
                <p class="text-muted">Light and creamy</p>
                <button class="btn btn-warning">
                    <span class="material-symbols-outlined">shopping_cart</span>
                    Chọn
                </button>
            </div>
        </div>

    </div>

</main>

</body>
</html>
