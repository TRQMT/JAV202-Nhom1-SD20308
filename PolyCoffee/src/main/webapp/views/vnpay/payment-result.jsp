<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Form Nhân viên</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet"/>
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/manager/drinks">Quản lý đồ uống</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/bills">Quản lý hóa đơn</a>
                        </li>
                        <c:if test="${sessionScope.user.role}">
                            <li class="nav-item">
                                <a class="nav-link active" href="${pageContext.request.contextPath}/manager/staff">Quản lý nhân viên</a>
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
                        <h5 class="card-title mb-0">${user != null && user.id != null ? 'Sửa nhân viên' : 'Thêm nhân viên'}</h5>
                    </div>
                    <div class="card-body">
                    <form id="staffForm" action="${pageContext.request.contextPath}${user != null && user.id != null ? '/manager/staff/edit' : '/manager/staff/add'}" method="post">

                        <c:if test="${user != null && user.id != null}">
                            <input type="hidden" name="userId" value="${user.id}" />
                        </c:if>

                        <div class="mb-3">
                            <label for="email" class="form-label">Email <strong class="text-danger">*</strong></label>
                            <input type="email" class="form-control" id="email" name="email" value="${user.email}" required maxlength="250">
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label">Mật khẩu ${user != null && user.id != null ? '(Để trống nếu không đổi)' : '<strong class="text-danger">*</strong>'}</label>
                            <input type="password" class="form-control" id="password" name="password" ${user == null || user.id == null ? 'required minlength="6"' : ''}>
                        </div>

                        <div class="mb-3">
                            <label for="fullName" class="form-label">Họ và tên <strong class="text-danger">*</strong></label>
                            <input type="text" class="form-control" id="fullName" name="fullName" value="${user.fullName}" required maxlength="250">
                        </div>

                        <div class="mb-3">
                            <label for="phone" class="form-label">Số điện thoại <strong class="text-danger">*</strong></label>
                            <input type="tel" class="form-control" id="phone" name="phone" value="${user.phone}" pattern="[0-9]{9,12}">
                        </div>

                        <div class="form-check mb-3">
                            <input class="form-check-input" type="checkbox" id="active" name="active" value="1" ${user != null && user.active ? 'checked' : ''}>
                            <label class="form-check-label" for="active">Kích hoạt tài khoản</label>
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary">${user != null && user.id != null ? 'Lưu' : 'Thêm'}</button>
                            <a href="${pageContext.request.contextPath}/manager/staff" class="btn btn-secondary">Hủy</a>
                        </div>

                    </form>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer>
        <p>© 2025 Poly Coffee &nbsp;·&nbsp; FPT Polytechnic</p>
    </footer>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
