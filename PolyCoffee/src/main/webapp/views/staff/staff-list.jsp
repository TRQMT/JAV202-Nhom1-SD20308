<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Nhân viên" scope="request"/>
<c:set var="activeNav" value="staff" scope="request"/>
<%@ include file="/views/layout/admin/header.jsp" %>

<main class="container mt-4">

    <!-- ===== TITLE + BUTTON ===== -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="page-heading">
            <span class="material-symbols-outlined me-1">groups</span>
            Danh sách nhân viên
        </h4>

        <a href="${pageContext.request.contextPath}/manager/staff/add"
           class="btn btn-primary d-flex align-items-center gap-1">
            <span class="material-symbols-outlined">person_add</span>
            Thêm
        </a>
    </div>

    <!-- ===== SEARCH BAR ===== -->
    <div class="search-bar-container">
        <form action="${pageContext.request.contextPath}/manager/staff" method="get">
            <div class="search-row">

                <div class="search-input-wrap">
                    <span class="material-symbols-outlined search-icon-svg">search</span>
                    <input type="text" name="keyword"
                           class="search-input"
                           placeholder="Tìm theo tên, email, SĐT..."
                           value="${param.keyword}">
                </div>

                <button type="submit" class="btn-search">
                    <span class="material-symbols-outlined">search</span>
                    Tìm
                </button>

                <a href="${pageContext.request.contextPath}/manager/staff" class="btn-reset">
                    Reset
                </a>

            </div>
        </form>
    </div>

    <!-- ===== TABLE ===== -->
    <div class="card">
        <div class="card-body p-0">
            <div class="table-responsive">

                <table class="table table-hover align-middle mb-0">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Nhân viên</th>
                            <th>Email</th>
                            <th>Điện thoại</th>
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
                                        <span class="material-symbols-outlined" style="font-size:14px;">
                                            ${staff.active ? 'check_circle' : 'cancel'}
                                        </span>
                                        ${staff.active ? 'Hoạt động' : 'Bị khóa'}
                                    </span>
                                </td>

                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/manager/staff/edit?id=${staff.id}"
                                       class="btn btn-sm btn-outline-primary">
                                        <span class="material-symbols-outlined">edit</span>
                                    </a>

                                    <a href="${pageContext.request.contextPath}/manager/staff/update-status?id=${staff.id}"
                                       class="btn btn-sm ${staff.active ? 'btn-outline-warning' : 'btn-outline-success'}">
                                        <span class="material-symbols-outlined">
                                            ${staff.active ? 'lock' : 'lock_open'}
                                        </span>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty staffList}">
                            <tr>
                                <td colspan="6" class="text-center text-muted py-4">
                                    <span class="material-symbols-outlined">inbox</span>
                                    Chưa có nhân viên nào
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

<style>
.search-bar-container {
    margin-bottom: 22px;
}

.search-row {
    display: flex;
    align-items: center;
    gap: 12px;
}

.search-input-wrap {
    position: relative;
    flex: 1;
}

.search-icon-svg {
    position: absolute;
    top: 50%;
    left: 14px;
    transform: translateY(-50%);
    color: var(--text-muted);
    font-size: 18px;
}

.search-input {
    width: 100%;
    padding: 10px 16px 10px 42px;
    border: 1.5px solid var(--border);
    border-radius: var(--radius-md);
    background: var(--white);
    font-size: 14px;
    transition: all 0.2s;
}

.search-input:focus {
    border-color: var(--caramel);
    box-shadow: 0 0 0 3px rgba(184,98,26,.15);
    outline: none;
}

.btn-search {
    display: flex;
    align-items: center;
    gap: 6px;
    padding: 10px 18px;
    background: linear-gradient(135deg, var(--caramel), var(--gold));
    color: #fff;
    border: none;
    border-radius: var(--radius-md);
    font-weight: 600;
    transition: all 0.2s;
}

.btn-search:hover {
    background: linear-gradient(135deg, var(--roast), var(--caramel));
    transform: translateY(-1px);
}

.btn-reset {
    padding: 10px 16px;
    background: var(--latte);
    border: 1.5px solid var(--border);
    border-radius: var(--radius-md);
    color: var(--text-main);
    text-decoration: none;
    transition: 0.2s;
}

.btn-reset:hover {
    background: var(--border);
}
</style>
