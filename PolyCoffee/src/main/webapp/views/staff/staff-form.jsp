<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle"
       value="${staff != null && staff.id != null ? 'Sửa nhân viên' : 'Thêm nhân viên'}"
       scope="request"/>
<c:set var="activeNav" value="staff" scope="request"/>
<%@ include file="/views/layout/admin/header.jsp" %>

<main class="container mt-4">
<div class="row justify-content-center">
<div class="col-12 col-md-6">

    <div class="card">
        <div class="card-header d-flex align-items-center gap-2">
            <span class="material-symbols-outlined">
                ${staff != null && staff.id != null ? 'edit' : 'person_add'}
            </span>
            <strong>${staff != null && staff.id != null ? 'Sửa nhân viên' : 'Thêm nhân viên mới'}</strong>
        </div>
        <div class="card-body">

            <form action="${pageContext.request.contextPath}${staff != null && staff.id != null
                          ? '/manager/staff/edit' : '/manager/staff/add'}"
                  method="post">

                <c:if test="${staff != null && staff.id != null}">
                    <input type="hidden" name="staffId" value="${staff.id}">
                </c:if>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Họ và tên <span class="text-danger">*</span></label>
                    <input type="text" class="form-control"
                           name="fullName" value="${staff.fullName}" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Email <span class="text-danger">*</span></label>
                    <input type="email" class="form-control"
                           name="email" value="${staff.email}" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Số điện thoại</label>
                    <input type="tel" class="form-control"
                           name="phone" value="${staff.phone}"
                           placeholder="0912345678">
                </div>

                <c:if test="${staff == null || staff.id == null}">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Mật khẩu <span class="text-danger">*</span></label>
                        <input type="password" class="form-control"
                               name="password" required minlength="6">
                    </div>
                </c:if>

                <div class="form-check mb-4">
                    <input class="form-check-input" type="checkbox"
                           name="active" value="1" id="chkActive"
                           ${staff == null || staff.active ? 'checked' : ''}>
                    <label class="form-check-label" for="chkActive">Tài khoản đang hoạt động</label>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">
                        <span class="material-symbols-outlined">save</span>Lưu
                    </button>
                    <a href="${pageContext.request.contextPath}/manager/staff"
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