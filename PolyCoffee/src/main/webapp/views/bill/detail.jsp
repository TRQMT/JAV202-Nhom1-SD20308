<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Chi tiết hóa đơn" scope="request"/>
<c:set var="activeNav" value="bills" scope="request"/>
<%@ include file="/views/layout/admin/header.jsp" %>

<main class="container mt-4">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4>
            <span class="material-symbols-outlined">receipt_long</span>
            Chi tiết hóa đơn ${bill.code}
        </h4>
        <a href="${pageContext.request.contextPath}/bills" class="btn btn-outline-secondary">
            <span class="material-symbols-outlined">arrow_back</span>Quay lại danh sách
        </a>
    </div>

    <div class="row g-3 mb-3">
        <div class="col-md-4">
            <div class="card h-100">
                <div class="card-body">
                    <div class="text-muted">Trạng thái</div>
                    <div class="mt-2">
                        <c:choose>
                            <c:when test="${bill.status == 'finish'}">
                                <span class="badge bg-success fs-6">Đã thanh toán</span>
                            </c:when>
                            <c:when test="${bill.status == 'cancel'}">
                                <span class="badge bg-danger fs-6">Đã huỷ</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-warning text-dark fs-6">Chờ xử lý</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card h-100">
                <div class="card-body">
                    <div class="text-muted">Nhân viên tạo đơn</div>
                    <div class="fw-semibold mt-2">${not empty bill.userName ? bill.userName : bill.userId}</div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card h-100">
                <div class="card-body">
                    <div class="text-muted">Ngày tạo đơn</div>
                    <div class="fw-semibold mt-2">
                        <fmt:formatDate value="${bill.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-header bg-light fw-semibold">Danh sách sản phẩm</div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Tên sản phẩm</th>
                            <th class="text-end">Số lượng</th>
                            <th class="text-end">Đơn giá</th>
                            <th class="text-end">Thành tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${billDetails}" var="item" varStatus="stt">
                            <tr>
                                <td>${stt.index + 1}</td>
                                <td>${item.drinkName}</td>
                                <td class="text-end">${item.quantity}</td>
                                <td class="text-end"><fmt:formatNumber value="${item.price}" type="number"/> đ</td>
                                <td class="text-end"><fmt:formatNumber value="${item.lineTotal}" type="number"/> đ</td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty billDetails}">
                            <tr>
                                <td colspan="5" class="text-center text-muted py-4">Không có sản phẩm trong hóa đơn.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="card-footer text-end fw-bold">
            Tổng tiền:
            <span class="text-danger"><fmt:formatNumber value="${calculatedTotal}" type="number"/> đ</span>
        </div>
    </div>

</main>

<%@ include file="/views/layout/admin/footer.jsp" %>
