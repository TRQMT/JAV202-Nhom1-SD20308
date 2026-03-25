<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Poly Coffee — POS</title>

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Material Icons -->
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />

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
.navbar { background: #1a0a00 !important; }

.product-card img {
    border-radius: 8px;
    width: 100%;
    height: 110px;
    object-fit: cover;
}

.order-card {
    border-radius: 16px;
    box-shadow: 0 8px 32px rgba(0,0,0,0.1);
}

.fixed-right { position: sticky; top: 20px; }
@media (max-width: 767px) {
    .fixed-right { position: static; }
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

<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain">
    <span class="navbar-toggler-icon"></span>
</button>

<div class="collapse navbar-collapse" id="navbarMain">

<ul class="navbar-nav me-auto">

<li class="nav-item">
<a class="nav-link" href="${pageContext.request.contextPath}/trang-chu">
<span class="material-symbols-outlined">home</span>Trang chủ
</a>
</li>

<li class="nav-item">
<a class="nav-link active" href="${pageContext.request.contextPath}/employee/pos">
<span class="material-symbols-outlined">point_of_sale</span>POS
</a>
</li>

<li class="nav-item">
<a class="nav-link" href="${pageContext.request.contextPath}/manager/categories">
<span class="material-symbols-outlined">category</span>Loại đồ uống
</a>
</li>

<li class="nav-item">
<a class="nav-link" href="${pageContext.request.contextPath}/manager/drinks">
<span class="material-symbols-outlined">coffee</span>Đồ uống
</a>
</li>

<li class="nav-item">
<a class="nav-link" href="${pageContext.request.contextPath}/bills">
<span class="material-symbols-outlined">receipt_long</span>Hóa đơn
</a>
</li>

<li class="nav-item">
<a class="nav-link" href="${pageContext.request.contextPath}/manager/staff">
<span class="material-symbols-outlined">groups</span>Nhân viên
</a>
</li>

</ul>

<ul class="navbar-nav">
<li class="nav-item dropdown">
<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
<span class="material-symbols-outlined">account_circle</span>
${sessionScope.user != null ? sessionScope.user.fullName : "Tài khoản"}
</a>

<ul class="dropdown-menu dropdown-menu-end">
<c:if test="${sessionScope.user == null}">
<li><a class="dropdown-item" href="${pageContext.request.contextPath}/dang-nhap">
<span class="material-symbols-outlined">login</span>Đăng nhập
</a></li>
</c:if>

<c:if test="${sessionScope.user != null}">
<li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
<span class="material-symbols-outlined">logout</span>Đăng xuất
</a></li>
</c:if>
</ul>

</li>
</ul>

</div>
</div>
</nav>

<!-- MAIN -->
<main class="container mt-4">

<!-- PRODUCTS -->
<div class="row g-4">

<div class="col-lg-8">
<h4 class="mb-3">
<span class="material-symbols-outlined">coffee</span>
Danh sách sản phẩm
</h4>

<div class="row g-3">
<c:forEach items="${drinks}" var="drink">
<div class="col-6 col-md-4 col-lg-3">

<div class="product-card">
<img src="${pageContext.request.contextPath}/uploads/${drink.image}"
onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/${drink.image}';">

<div style="font-weight:600;font-size:13px;margin-top:6px;">
${drink.name}
</div>

<div style="color:var(--caramel);font-weight:600;">
${drink.price} đ
</div>

<form action="${pageContext.request.contextPath}/employee/pos/add-item" method="post">
<input type="hidden" name="drinkId" value="${drink.id}">
<input type="hidden" name="billId" value="${billId}">
<button class="btn btn-sm btn-primary w-100 mt-1">
<span class="material-symbols-outlined">add</span>Thêm
</button>
</form>

</div>

</div>
</c:forEach>
</div>
</div>

<!-- ORDER -->
<div class="col-lg-4">

<div class="card order-card fixed-right">
<div class="card-body">

<h5>
<span class="material-symbols-outlined">receipt</span>
Đơn hàng ${bill != null ? bill.code : ''}
</h5>

<table class="table table-sm">
<tbody>

<c:forEach items="${billDetails}" var="d">
<tr>
<td>${detailDrinkMap[d.drinkId].name}</td>
<td>x${d.quantity}</td>
<td>${d.price * d.quantity}</td>
</tr>
</c:forEach>

<c:if test="${empty billDetails}">
<tr><td class="text-muted">Chưa có sản phẩm</td></tr>
</c:if>

</tbody>
</table>

<h5 class="text-end">
Tổng: ${bill != null ? bill.total : 0} đ
</h5>

<form action="${pageContext.request.contextPath}/employee/pos/checkout" method="post">
<input type="hidden" name="billId" value="${bill.id}">
<div class="mb-3">
<label class="form-label mb-2 fw-semibold">Phương thức thanh toán</label>
<div class="form-check">
<input class="form-check-input" type="radio" name="paymentMethod" id="paymentCash" value="cash" checked>
<label class="form-check-label" for="paymentCash">Tiền mặt</label>
</div>
<div class="form-check">
<input class="form-check-input" type="radio" name="paymentMethod" id="paymentVnpay" value="vnpay">
<label class="form-check-label" for="paymentVnpay">Chuyển khoản VNPay</label>
</div>
</div>
<button class="btn btn-success w-100"
${bill == null || empty billDetails ? 'disabled' : ''}>
<span class="material-symbols-outlined">payments</span>
Thanh toán
</button>
</form>

</div>
</div>

</div>

</div>

</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
