<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="pageTitle" value="Thông tin cá nhân" scope="request"/>
<%@ include file="/views/layout/admin/header.jsp" %>

<main class="container py-4" style="max-width: 760px;">
    <div class="card mb-4">
        <div class="card-body">
            <h4 class="mb-3">Thông tin cá nhân</h4>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/edit-profile">
                <input type="hidden" name="action" value="update-info">
                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" class="form-control" value="${profile.email}" disabled>
                </div>
                <div class="mb-3">
                    <label class="form-label">Họ tên</label>
                    <input type="text" name="fullName" class="form-control" value="${profile.fullName}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Số điện thoại</label>
                    <input type="text" name="phone" class="form-control" value="${profile.phone}" required>
                </div>
                <button class="btn btn-primary">Lưu thay đổi</button>
            </form>
        </div>
    </div>

    <div class="card">
        <div class="card-body">
            <h4 class="mb-3">Bảo mật tài khoản (2FA)</h4>
            <p class="mb-3">Trạng thái hiện tại:
                <strong class="${twoFactorEnabled ? 'text-success' : 'text-secondary'}">
                    ${twoFactorEnabled ? 'Đã bật' : 'Đang tắt'}
                </strong>
            </p>

            <c:if test="${not pendingToggle}">
                <form method="post" action="${pageContext.request.contextPath}/edit-profile">
                    <input type="hidden" name="action" value="request-2fa-toggle">
                    <button class="btn ${twoFactorEnabled ? 'btn-outline-danger' : 'btn-outline-success'}">
                        ${twoFactorEnabled ? 'Tắt 2FA' : 'Bật 2FA'}
                    </button>
                </form>
            </c:if>

            <c:if test="${pendingToggle}">
                <form method="post" action="${pageContext.request.contextPath}/edit-profile">
                    <input type="hidden" name="action" value="confirm-2fa-toggle">
                    <div class="mb-3">
                        <label class="form-label">Nhập OTP xác nhận</label>
                        <input type="text" name="otp" maxlength="6" class="form-control" required>
                    </div>
                    <button class="btn btn-primary">Xác nhận OTP</button>
                </form>
            </c:if>
        </div>
    </div>
</main>

<%@ include file="/views/layout/admin/footer.jsp" %>
