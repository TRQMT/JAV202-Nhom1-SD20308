<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Poly Coffee — Loại đồ uống</title>

<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet"/>

<style>
.material-symbols-outlined { font-size: 18px; vertical-align: middle; margin-right: 6px; }
.header-title { font-family: 'Playfair Display', serif; color: #fff; font-size: 32px; letter-spacing: 2px; }
.navbar { background: #1a0a00 !important; }
</style>
</head>
<body>

<!-- sửa: bỏ ký tự < thừa -->
<header class="text-center py-3" style="background: linear-gradient(135deg,#3b1f0a,#6b3317);">
    <h1 class="header-title">WELCOME TO MY COFFEE</h1>
</header>

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
                <li class="nav-item">
                    <a class="nav-link active"
                       href="${pageContext.request.contextPath}/manager/categories">
                        <span class="material-symbols-outlined">category</span>
                        Loại đồ uống
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

<main class="container mt-4">

    <%-- Thông báo thành công --%>
    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <span class="material-symbols-outlined">check_circle</span>${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <%-- Thông báo lỗi --%>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <span class="material-symbols-outlined">error</span>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3>
            <span class="material-symbols-outlined">category</span>
            Quản lý loại đồ uống
        </h3>
        <%-- Nút mở modal thêm mới --%>
        <button class="btn btn-primary" id="btnThemMoi">
            <span class="material-symbols-outlined">add</span>
            Thêm loại
        </button>
    </div>

    <div class="card">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0 align-middle">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên loại</th>
                            <th>Trạng thái</th>
                            <th class="text-center">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%-- Hiển thị danh sách loại đồ uống --%>
                        <c:forEach items="${categories}" var="cat">
                            <tr>
                                <td>${cat.maLoai}</td><%-- sửa: id → maLoai --%>
                                <td style="font-weight:600;">${cat.tenLoai}</td><%-- sửa: name → tenLoai --%>
                                <td>
                                    <%-- sửa: active → trangThai --%>
                                    <span class="badge ${cat.trangThai ? 'bg-success' : 'bg-secondary'}">
                                        ${cat.trangThai ? 'Hoạt động' : 'Ẩn'}
                                    </span>
                                </td>
                                <td class="text-center">
                                    <%-- Nút sửa: truyền dữ liệu vào modal qua thuộc tính data --%>
                                    <button class="btn btn-sm btn-warning btnSua"
                                            data-id="${cat.maLoai}"
                                            data-name="${cat.tenLoai}"><%-- sửa field --%>
                                        <span class="material-symbols-outlined" style="margin:0">edit</span>
                                    </button>
                                    <%-- Nút xóa: POST form đến /delete --%>
                                    <form method="post"
                                          action="${pageContext.request.contextPath}/manager/categories/delete"
                                          class="d-inline"
                                          onsubmit="return confirm('Xác nhận xóa loại \'${cat.tenLoai}\'?')">
                                        <input type="hidden" name="id" value="${cat.maLoai}">
                                        <button type="submit" class="btn btn-sm btn-danger">
                                            <span class="material-symbols-outlined" style="margin:0">delete</span>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>

                        <%-- Hiển thị khi danh sách rỗng --%>
                        <c:if test="${empty categories}">
                            <tr>
                                <td colspan="4" class="text-center text-muted py-3">
                                    Chưa có loại đồ uống
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</main>

<div class="modal fade" id="modalLoai" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="tieuDeModal">Thêm loại đồ uống</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form id="formLoai" method="post">
                <div class="modal-body">
                    <%-- thêm: input ẩn id để phân biệt thêm mới và chỉnh sửa --%>
                    <input type="hidden" name="id" id="catId">

                    <div class="mb-3">
                        <label class="form-label fw-semibold">
                            Tên loại <span class="text-danger">*</span>
                        </label>
                        <input type="text" name="name" id="catName"
                               class="form-control" placeholder="Nhập tên loại..." required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">Lưu</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const ctx     = '${pageContext.request.contextPath}';
    const modal   = new bootstrap.Modal(document.getElementById('modalLoai'));
    const form    = document.getElementById('formLoai');
    const tieuDe  = document.getElementById('tieuDeModal');
    const catId   = document.getElementById('catId');
    const catName = document.getElementById('catName');

    // Mở modal thêm mới
    document.getElementById('btnThemMoi').addEventListener('click', () => {
        tieuDe.textContent = 'Thêm loại đồ uống';
        form.action        = ctx + '/manager/categories/add';
        catId.value        = '';
        catName.value      = '';
        modal.show();
    });

    // Mở modal sửa: điền dữ liệu từ thuộc tính data-*
    document.querySelectorAll('.btnSua').forEach(btn => {
        btn.addEventListener('click', () => {
            tieuDe.textContent = 'Chỉnh sửa loại đồ uống';
            form.action        = ctx + '/manager/categories/edit';
            catId.value        = btn.dataset.id;
            catName.value      = btn.dataset.name;
            modal.show();
        });
    });
</script>
</body>
</html>