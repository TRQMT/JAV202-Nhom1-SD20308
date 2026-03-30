<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Sửa nhân viên"/>
<c:set var="activeNav" value="staff"/>

<%@ include file="/views/layout/admin/header.jsp" %>

<main class="container mt-4">
<div class="row justify-content-center">
<div class="col-md-6">

<div class="card">
    <div class="card-header">✏️ Sửa nhân viên</div>

    <div class="card-body">

        <form action="${pageContext.request.contextPath}/manager/staff/edit" method="post">

            <input type="hidden" name="userId" value="${staff.id}">

            <div class="mb-3">
                <label>Họ và tên</label>
                <input type="text" name="fullName" value="${staff.fullName}" class="form-control">
                <small class="text-danger">${fullNameError}</small>
            </div>

            <div class="mb-3">
                <label>Email</label>
                <input type="email" name="email" value="${staff.email}" class="form-control">
                <small class="text-danger">${emailError}</small>
            </div>

            <div class="mb-3">
                <label>SĐT</label>
                <input type="text" name="phone" value="${staff.phone}" class="form-control">
                <small class="text-danger">${phoneError}</small>
            </div>

            <div class="form-check mb-3">
                <input type="checkbox" name="active" value="1"
                       class="form-check-input"
                       ${staff.active ? 'checked' : ''}>
                <label class="form-check-label">Hoạt động</label>
            </div>

            <button class="btn btn-primary w-100">Cập nhật</button>

        </form>

    </div>
</div>

</div>
</div>
</main>

<%@ include file="/views/layout/admin/footer.jsp" %>
