<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh sách hóa đơn</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
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
                            <a class="nav-link active" href="${pageContext.request.contextPath}/bills">Quản lý hóa đơn</a>
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
        <div class="mt-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3 class="mb-0">Danh sách hóa đơn</h3>
                <a href="${pageContext.request.contextPath}/employee/pos" class="btn btn-primary">Tạo đơn mới</a>
            </div>

            <div class="card">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover mb-0 align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th style="width:80px">ID</th>
                                    <th style="width:120px">Mã đơn</th>
                                    <th style="width:100px">Nhân viên</th>
                                    <th style="width:160px">Ngày tạo</th>
                                    <th style="width:120px">Tổng tiền</th>
                                    <th style="width:120px">Trạng thái</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${bills}" var="bill">
                                    <tr>
                                        <td>${bill.id}</td>
                                        <td>${bill.code}</td>
                                        <td>${bill.userId}</td>
                                        <td>${bill.createdAt}</td>
                                        <td>${bill.total}</td>
                                        <td>
                                            <span class="badge ${bill.status == 'finish' ? 'bg-success' : (bill.status == 'cancel' ? 'bg-danger' : 'bg-warning text-dark')}">
                                                ${bill.status}
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty bills}">
                                    <tr>
                                        <td colspan="6" class="text-center text-muted py-3">Chưa có hóa đơn</td>
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
