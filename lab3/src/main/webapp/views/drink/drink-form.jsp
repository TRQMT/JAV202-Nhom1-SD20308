<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Form Đồ Uống</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<style>
    .img-preview {
        max-width: 200px;
        max-height: 200px;
        object-fit: contain;
        border: 1px solid #ddd;
        padding: 4px;
        background: #fff;
    }
</style>
</head>
<body>
<div class="container">
    <header>
        <h1>
            <img alt="" src="${pageContext.request.contextPath}/images/logo.png" width="150">
        </h1>
        <hr>
    </header>

    <nav class="navbar navbar-expand-lg bg-body-tertiary">
        <div class="container-fluid">
            <a class="navbar-brand" href="#"></a>
            <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false"
                aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" aria-current="page" href="${pageContext.request.contextPath}/trang-chu">Trang chủ</a>
                    </li>
                    <c:if test="${sessionScope.user != null}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/employee/pos">Phiếu bán hàng</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/manager/categories">Quản lý loại đồ uống</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/manager/drinks">Quản lý đồ uống</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/bills">Quản lý hóa đơn</a>
                        </li>
                        <c:if test="${sessionScope.user.role}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/manager/staff">Quản lý nhân viên</a>
                            </li>
                        </c:if>
                    </c:if>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            ${sessionScope.user != null ? sessionScope.user.fullName : "Tài Khoản"}
                        </a>
                        <ul class="dropdown-menu">
                            <c:if test="${sessionScope.user == null}">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/dang-nhap">Đăng nhập</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/quen-mat-khau">Quên mật khẩu</a></li>
                            </c:if>

                            <c:if test="${sessionScope.user != null}">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/edit-profile">Thông tin cá nhân</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/change-pass">Đổi mật khẩu</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
                            </c:if>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <main>
        <div class="mt-4 row justify-content-center">
            <div class="col-12 col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">${drink != null && drink.id != null ? 'Sửa đồ uống' : 'Thêm đồ uống'}</h5>
                    </div>
                    <div class="card-body">
                    <form id="drinkForm" action="${pageContext.request.contextPath}${drink != null && drink.id != null ? '/manager/drinks/edit' : '/manager/drinks/add'}" 
                    	method="post" 
                    	enctype="multipart/form-data">

						<c:if test="${drink != null && drink.id != null}">
							<input type="hidden" name="drinkId" value="${drink.id}">
						</c:if>

                        <div class="mb-3">
                            <label for="categoryId" class="form-label">Danh mục <strong class="text-danger">*</strong></label>
                            <select class="form-select" id="categoryId" name="categoryId" required>
                                <option value="">-- Chọn danh mục --</option>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.id}" ${cat.id == drink.categoryId ? 'selected' : ''}>${cat.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="name" class="form-label">Tên <strong class="text-danger">*</strong></label>
                            <input type="text" class="form-control" id="name" name="name" value="${drink.name}" required maxlength="250">
                        </div>

                        <div class="mb-3">
                            <label for="description" class="form-label">Mô tả <strong class="text-danger">*</strong></label>
                            <textarea class="form-control" id="description" name="description" rows="4">${drink.description}</textarea>
                        </div>

                        <div class="mb-3">
                            <label for="imageFile" class="form-label">Tải ảnh lên <strong class="text-danger">*</strong></label>
                            <input class="form-control" type="file" id="imageFile" name="imageFile" accept="image/*">
                            <c:if test="${not empty errImage}">
                                <div class="text-danger mt-1">${errImage}</div>
                            </c:if>
                            <c:if test="${drink != null && drink.image != null && fn:length(drink.image) > 0}">
                                <img class="img-preview mt-2" src="${pageContext.request.contextPath}/uploads/${drink.image}" alt="drink-image" onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/${drink.image}';">
                            </c:if>
                        </div>

                        <div class="mb-3">
                            <label for="price" class="form-label">Giá <strong class="text-danger">*</strong></label>
                            <input type="number" class="form-control" id="price" name="price" value="${drink.price}" min="0">
                        </div>

                        <div class="form-check mb-3">
                            <input class="form-check-input" type="checkbox" id="active" name="active" value="1" ${drink == null || drink.active ? 'checked' : ''}>
                            <label class="form-check-label" for="active">Hiển thị</label>
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary">Lưu</button>
                            <a href="${pageContext.request.contextPath}/manager/drinks" class="btn btn-secondary">Hủy</a>
                        </div>
                    </form>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>

</body>
</html>