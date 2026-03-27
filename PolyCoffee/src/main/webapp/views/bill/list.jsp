<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Hóa đơn"      scope="request"/>
<c:set var="activeNav" value="bills"         scope="request"/>
<%@ include file="/views/layout/admin/header.jsp" %>

<main class="container mt-4">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4>
            <span class="material-symbols-outlined">receipt_long</span>
            Danh sách hóa đơn
        </h4>
        <a href="${pageContext.request.contextPath}/bills/create"
           class="btn btn-primary">
            <span class="material-symbols-outlined">add</span>Tạo đơn mới
        </a>
    </div>

    <div class="card">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Mã đơn</th>
                            <th>Nhân viên</th>
                            <th>Ngày tạo</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                            <th class="text-center">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${bills}" var="bill">
                            <tr>
                                <td>${bill.id}</td>
                                <td><strong>${bill.code}</strong></td>
                                <td>${bill.userId}</td>
                                <td>
                                    <fmt:formatDate value="${bill.createdAt}"
                                                    pattern="dd/MM/yyyy HH:mm"/>
                                </td>
                                <td>
                                    <fmt:formatNumber value="${bill.total}"
                                                      type="number"/> đ
                                </td>
                                <td>
                                    <span class="badge ${bill.status == 'PAID' ? 'bg-success' : 'bg-warning text-dark'}">
                                        ${bill.status == 'PAID' ? 'Đã thanh toán' : 'Chờ xử lý'}
                                    </span>
                                </td>
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/bills/detail?id=${bill.id}"
                                       class="btn btn-sm btn-outline-secondary">
                                        <span class="material-symbols-outlined">visibility</span>Chi tiết
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty bills}">
                            <tr>
                                <td colspan="7" class="text-center text-muted py-4">
                                    <span class="material-symbols-outlined">inbox</span> Chưa có hóa đơn
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