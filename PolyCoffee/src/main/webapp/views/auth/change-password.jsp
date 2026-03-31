<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Đổi mật khẩu" scope="request"/>
<%@ include file="/views/layout/admin/header.jsp" %>

<main class="container py-4" style="max-width: 620px;">
    <div class="card">
        <div class="card-body">
            <h4 class="mb-3">Đổi mật khẩu</h4>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/change-pass">
                <div class="mb-3">
                    <label class="form-label">Mật khẩu hiện tại</label>
                    <input type="password" name="currentPassword" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Mật khẩu mới</label>
                    <input type="password" name="newPassword" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Xác nhận mật khẩu mới</label>
                    <input type="password" name="confirmPassword" class="form-control" required>
                </div>
                <button class="btn btn-primary">Cập nhật mật khẩu</button>
            </form>
        </div>
    </div>
</main>

<%@ include file="/views/layout/admin/footer.jsp" %>
