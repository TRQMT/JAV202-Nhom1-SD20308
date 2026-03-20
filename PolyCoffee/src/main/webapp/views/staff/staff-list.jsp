<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh sách nhân viên</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<style>
    .thumb { width: 80px; height: 60px; object-fit: cover; border-radius: 4px; }
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
        <div class="mt-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3 class="mb-0">Danh sách nhân viên</h3>
                <a href="${pageContext.request.contextPath}/manager/staff/add" class="btn btn-success">Thêm mới</a>
            </div>

            <div class="card">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover mb-0 align-middle">
                    <thead class="table-light">
                        <tr>
                            <th style="width:60px">Mã</th>
                            <th>Email</th>
                            <th>Họ và tên</th>
                            <th style="width:140px">Số điện thoại</th>
                            <th style="width:100px">Trạng thái</th>
                            <th style="width:220px">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${staffList}" var="staff">
                            <tr>
                                <td>${staff.id}</td>
                                <td>${staff.email}</td>
                                <td>${staff.fullName}</td>
                                <td>${staff.phone}</td>
                                <td>
                                    <span class="badge ${staff.active ? 'bg-success' : 'bg-secondary'}">
                                        ${staff.active ? 'Hoạt động' : 'Không hoạt động'}
                                    </span>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/manager/staff/edit?id=${staff.id}" class="btn btn-sm btn-warning me-2">Cập nhật</a>
                                    <a href="${pageContext.request.contextPath}/manager/staff/update-status?id=${staff.id}&active=${staff.active ? 0 : 1}" class="btn btn-sm ${staff.active ? 'btn-danger' : 'btn-success'}" onclick="return confirm('Bạn có chắc muốn cập nhật trạng thái tài khoản này không?');">
                                        ${staff.active ? 'Khóa tài khoản' : 'Mở khóa'}
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty staffList}">
                            <tr>
                                <td colspan="6" class="text-center text-muted py-3">Chưa có nhân viên</td>
                            </tr>
                        </c:if>

                    </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>