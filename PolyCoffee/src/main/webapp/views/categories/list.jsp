<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Quản lý loại đồ uống" scope="request"/>
<c:set var="activeNav" value="categories" scope="request"/>

<%@ include file="/views/layout/admin/header.jsp" %>

<main class="container mt-4">

    <%-- Flash messages --%>
    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <span class="material-symbols-outlined">check_circle</span> ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <span class="material-symbols-outlined">error</span> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <%-- Tiêu đề + nút thêm --%>
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="mb-0">
            <span class="material-symbols-outlined">category</span>
            Quản lý loại đồ uống
        </h3>
        <button class="btn btn-primary" id="btnThemMoi">
            <span class="material-symbols-outlined">add</span> Thêm loại
        </button>
    </div>

    <%-- Search bar --%>
    <div class="search-bar-container mb-3">
        <form action="${pageContext.request.contextPath}/manager/categories" method="get">
            <div class="search-row">
                <div class="search-input-wrap">
                    <span class="material-symbols-outlined search-icon-svg">search</span>
                    <input type="text" name="keyword" class="search-input"
                           placeholder="Tìm theo tên loại..." value="${keyword}">
                </div>
                <button type="submit" class="btn-search">
                    <span class="material-symbols-outlined">search</span> Tìm
                </button>
                <a href="${pageContext.request.contextPath}/manager/categories" class="btn-reset">
                    Reset
                </a>
            </div>
        </form>
    </div>

    <%-- Kết quả tìm kiếm --%>
    <c:if test="${not empty keyword}">
        <p class="text-muted mb-2">
            Kết quả cho: <strong>"${keyword}"</strong>
        </p>
    </c:if>

    <%-- Bảng danh sách --%>
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
                        <c:forEach items="${categories}" var="cat">
                            <tr>
                                <td>${cat.maLoai}</td>
                                <td style="font-weight:600;">${cat.tenLoai}</td>
                                <td>
                                    <span class="badge ${cat.trangThai ? 'bg-success' : 'bg-secondary'}">
                                        ${cat.trangThai ? 'Hoạt động' : 'Ẩn'}
                                    </span>
                                </td>
                                <td class="text-center">
                                    <button class="btn btn-sm btn-warning btnSua"
                                            data-id="${cat.maLoai}"
                                            data-name="${cat.tenLoai}">
                                        <span class="material-symbols-outlined" style="margin:0">edit</span>
                                    </button>
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

                        <c:if test="${empty categories}">
                            <tr>
                                <td colspan="4" class="text-center text-muted py-4">
                                    <span class="material-symbols-outlined d-block mb-1"
                                          style="font-size:32px;">search_off</span>
                                    <c:choose>
                                        <c:when test="${not empty keyword}">
                                            Không tìm thấy loại nào với từ khoá
                                            "<strong>${keyword}</strong>"
                                        </c:when>
                                        <c:otherwise>Chưa có loại đồ uống nào</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</main>

<%-- Modal thêm / sửa --%>
<div class="modal fade" id="modalLoai" tabindex="-1"
     aria-labelledby="tieuDeModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="tieuDeModal">Thêm loại đồ uống</h5>
                <button type="button" class="btn-close"
                        data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <form id="formLoai" method="post">
                <div class="modal-body">
                    <input type="hidden" name="id" id="catId">
                    <div class="mb-3">
                        <label for="catName" class="form-label fw-semibold">
                            Tên loại <span class="text-danger">*</span>
                        </label>
                        <input type="text" name="name" id="catName"
                               class="form-control"
                               placeholder="Nhập tên loại..."
                               maxlength="100" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary"
                            data-bs-dismiss="modal">
                        <span class="material-symbols-outlined">close</span> Hủy
                    </button>
                    <button type="submit" class="btn btn-primary">
                        <span class="material-symbols-outlined">save</span> Lưu
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<%-- Include footer TRƯỚC script để Bootstrap JS đã được load --%>
<%@ include file="/views/layout/admin/footer.jsp" %>

<script>
    const ctx     = '${pageContext.request.contextPath}';
    const form    = document.getElementById('formLoai');
    const tieuDe  = document.getElementById('tieuDeModal');
    const catId   = document.getElementById('catId');
    const catName = document.getElementById('catName');

    // Dùng getOrCreateInstance thay vì new bootstrap.Modal()
    // → tránh tạo trùng instance khi mở modal nhiều lần
    function getModal() {
        return bootstrap.Modal.getOrCreateInstance(
            document.getElementById('modalLoai')
        );
    }

    document.getElementById('btnThemMoi').addEventListener('click', () => {
        tieuDe.textContent = 'Thêm loại đồ uống';
        form.action        = ctx + '/manager/categories/add';
        catId.value        = '';
        catName.value      = '';
        getModal().show();
    });

    document.querySelectorAll('.btnSua').forEach(btn => {
        btn.addEventListener('click', () => {
            tieuDe.textContent = 'Chỉnh sửa loại đồ uống';
            form.action        = ctx + '/manager/categories/edit';
            catId.value        = btn.dataset.id;
            catName.value      = btn.dataset.name;
            getModal().show();
        });
    });
</script>