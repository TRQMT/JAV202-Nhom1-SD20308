<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Poly Coffee — ${drink != null && drink.id != null ? 'Sửa đồ uống' : 'Thêm đồ uống'}</title>

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Material Icons -->
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />

<!-- CSS -->
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
.img-preview {
    max-width: 200px;
    max-height: 200px;
    object-fit: contain;
    border: 1.5px solid var(--border);
    border-radius: var(--radius-sm);
    padding: 4px;
    background: var(--white);
}
</style>

</head>

<body>

<!-- HEADER -->
<header class="text-center py-3" style="background: linear-gradient(135deg,#3b1f0a,#6b3317);">
    <h1 class="header-title">WELCOME TO MY COFFEE</h1>
</header>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark">
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

                <li class="nav-item">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/manager/categories">
                        <span class="material-symbols-outlined">category</span>
                        Loại đồ uống
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link active"
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

            </ul>

            <!-- ACCOUNT -->
            <ul class="navbar-nav">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#"
                       data-bs-toggle="dropdown">
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
<main class="container mt-4">

    <div class="row justify-content-center">
        <div class="col-12 col-md-8">

            <div class="card">
                <div class="card-header">
                    <h5 class="card-title">
                        <span class="material-symbols-outlined">
                            ${drink != null && drink.id != null ? 'edit' : 'add'}
                        </span>
                        ${drink != null && drink.id != null ? 'Sửa đồ uống' : 'Thêm đồ uống'}
                    </h5>
                </div>

                <div class="card-body">

                    <form action="${pageContext.request.contextPath}${drink != null && drink.id != null ? '/manager/drinks/edit' : '/manager/drinks/add'}"
                          method="post" enctype="multipart/form-data">

                        <c:if test="${drink != null && drink.id != null}">
                            <input type="hidden" name="drinkId" value="${drink.id}">
                        </c:if>

                        <!-- CATEGORY -->
                        <div class="mb-3">
                            <label class="form-label">Danh mục *</label>
                            <select class="form-select" name="categoryId" required>
                                <option value="">-- Chọn danh mục --</option>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.id}" ${cat.id == drink.categoryId ? 'selected' : ''}>
                                        ${cat.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- NAME -->
                        <div class="mb-3">
                            <label class="form-label">Tên *</label>
                            <input type="text" class="form-control"
                                   name="name" value="${drink.name}" required>
                        </div>

                        <!-- DESCRIPTION -->
                        <div class="mb-3">
                            <label class="form-label">Mô tả</label>
                            <textarea class="form-control" name="description" rows="4">${drink.description}</textarea>
                        </div>

                        <!-- IMAGE -->
                        <div class="mb-3">
                            <label class="form-label">Ảnh</label>
                            <input type="file" class="form-control" name="imageFile" accept="image/*">

                            <c:if test="${drink != null && drink.image != null}">
                                <img class="img-preview mt-2"
                                     src="${pageContext.request.contextPath}/uploads/${drink.image}">
                            </c:if>
                        </div>

                        <!-- PRICE -->
                        <div class="mb-3">
                            <label class="form-label">Giá (VNĐ) *</label>
                            <input type="number" class="form-control"
                                   name="price" value="${drink.price}" min="0">
                        </div>

                        <!-- ACTIVE -->
                        <div class="form-check mb-4">
                            <input class="form-check-input" type="checkbox"
                                   name="active" value="1"
                                   ${drink == null || drink.active ? 'checked' : ''}>
                            <label class="form-check-label">Hiển thị</label>
                        </div>

                        <!-- BUTTON -->
                        <div class="d-flex gap-2">
                            <button class="btn btn-primary">
                                <span class="material-symbols-outlined">save</span>
                                Lưu
                            </button>

                            <a href="${pageContext.request.contextPath}/manager/drinks"
                               class="btn btn-secondary">
                                <span class="material-symbols-outlined">close</span>
                                Hủy
                            </a>
                        </div>

                    </form>

                </div>
            </div>

        </div>
    </div>

</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
