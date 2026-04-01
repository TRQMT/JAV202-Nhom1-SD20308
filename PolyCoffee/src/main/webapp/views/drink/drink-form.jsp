<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="pageTitle"
       value="${drink != null && drink.id != null ? 'Sửa đồ uống' : 'Thêm đồ uống'}"
       scope="request"/>
<c:set var="activeNav" value="drinks" scope="request"/>

<c:set var="extraStyles" scope="request">
<style>
.img-preview {
    max-width: 180px; max-height: 180px;
    object-fit: contain; border-radius: 10px;
    border: 1.5px solid #dee2e6; padding: 4px;
}
</style>
</c:set>

<%@ include file="/views/layout/admin/header.jsp" %>

<main class="container mt-4">
<div class="row justify-content-center">
<div class="col-12 col-md-7">

    <div class="card">
        <div class="card-header d-flex align-items-center gap-2">
            <span class="material-symbols-outlined">
                ${drink != null && drink.id != null ? 'edit' : 'add'}
            </span>
            <strong>${drink != null && drink.id != null ? 'Sửa đồ uống' : 'Thêm đồ uống mới'}</strong>
        </div>
        <div class="card-body">

            <form action="${pageContext.request.contextPath}${drink != null && drink.id != null
                          ? '/manager/drinks/edit' : '/manager/drinks/add'}"
                  method="post" enctype="multipart/form-data">

                <c:if test="${drink != null && drink.id != null}">
                    <input type="hidden" name="drinkId" value="${drink.id}">
                </c:if>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Danh mục <span class="text-danger">*</span></label>
                    <select class="form-select" name="categoryId" required>
                        <option value="">-- Chọn danh mục --</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.maLoai}"
                                    ${cat.maLoai == drink.categoryId ? 'selected' : ''}>
                                ${cat.tenLoai}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Tên đồ uống <span class="text-danger">*</span></label>
                    <input type="text" class="form-control"
                           name="name" value="${drink.name}" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Mô tả</label>
                    <textarea class="form-control" name="description" rows="3">${drink.description}</textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Ảnh</label>
                    <input type="file" class="form-control" name="imageFile" accept="image/*">
                    <c:if test="${drink != null && not empty drink.image}">
                        <img class="img-preview mt-2"
                             src="${pageContext.request.contextPath}/uploads/${drink.image}"
                             alt="${drink.name}">
                    </c:if>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Giá (VNĐ) <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <input type="number" class="form-control"
                               name="price" value="${drink.price}" min="0" step="500" required>
                        <span class="input-group-text">đ</span>
                    </div>
                </div>

                <div class="form-check mb-4">
                    <input class="form-check-input" type="checkbox"
                           name="active" value="1" id="chkActive"
                           ${drink == null || drink.active ? 'checked' : ''}>
                    <label class="form-check-label" for="chkActive">Hiển thị trên menu</label>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">
                        <span class="material-symbols-outlined">save</span>Lưu
                    </button>
                    <a href="${pageContext.request.contextPath}/manager/drinks"
                       class="btn btn-secondary">
                        <span class="material-symbols-outlined">close</span>Hủy
                    </a>
                </div>

            </form>
        </div>
    </div>

</div>
</div>
</main>

<%@ include file="/views/layout/admin/footer.jsp" %>