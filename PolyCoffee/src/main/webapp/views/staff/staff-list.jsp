<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Nhân viên" scope="request"/>
<c:set var="activeNav" value="staff"    scope="request"/>
<%@ include file="/views/layout/admin/header.jsp" %>

<main class="container mt-4">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4>
            <span class="material-symbols-outlined">groups</span>Danh sách nhân viên
        </h4>
        <a href="${pageContext.request.contextPath}/manager/staff/add"
           class="btn btn-primary">
            <span class="material-symbols-outlined">person_add</span>Thêm nhân viên
        </a>
    </div>

    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show">
            <span class="material-symbols-outlined">check_circle</span>${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="card">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead>
                        <tr>
                            <th>Mã</th>
                            <th>Họ và tên</th>
                            <th>Email</th>
                            <th>Số điện thoại</th>
                            <th>Trạng thái</th>
                            <th class="text-center">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${staffList}" var="staff">
                            <tr>
                                <td>${staff.id}</td>
                                <td>
                                    <span class="material-symbols-outlined text-muted">person</span>
                                    <strong>${staff.fullName}</strong>
                                </td>
                                <td>${staff.email}</td>
                                <td>${staff.phone}</td>
                                <td>
                                    <span class="badge ${staff.active ? 'bg-success' : 'bg-danger'}">
                                        ${staff.active ? 'Hoạt động' : 'Bị khóa'}
                                    </span>
                                </td>
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/manager/staff/edit?id=${staff.id}"
                                       class="btn btn-sm btn-outline-primary me-1">
                                        <span class="material-symbols-outlined">edit</span>Sửa
                                    </a>
                                    <a href="${pageContext.request.contextPath}/manager/staff/toggle?id=${staff.id}"
                                       class="btn btn-sm ${staff.active ? 'btn-outline-warning' : 'btn-outline-success'}">
                                        <span class="material-symbols-outlined">
                                            ${staff.active ? 'lock' : 'lock_open'}
                                        </span>
                                        ${staff.active ? 'Khóa' : 'Mở khóa'}
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty staffList}">
                            <tr>
                                <td colspan="6" class="text-center text-muted py-4">
                                    <span class="material-symbols-outlined">inbox</span> Chưa có nhân viên nào
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</main>

<%@ include file="/views/layout/admin/footer.jsp" %>