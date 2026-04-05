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
        <small class="text-muted">Tổng cộng: ${totalRecords} đơn</small>
    </div>

    <c:if test="${param.message == 'cancel-success'}">
        <div class="alert alert-success">Huỷ đơn hàng thành công.</div>
    </c:if>
    <c:if test="${param.message == 'cancel-failed'}">
        <div class="alert alert-danger">Không thể huỷ đơn hàng.</div>
    </c:if>

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
                                <td>${not empty bill.userName ? bill.userName : bill.userId}</td>
                                <td>
                                    <fmt:formatDate value="${bill.createdAt}"
                                                    pattern="dd/MM/yyyy HH:mm"/>
                                </td>
                                <td>
                                    <fmt:formatNumber value="${bill.total}"
                                                      type="number"/> đ
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${bill.status == 'finish'}">
                                            <span class="badge bg-success">Đã thanh toán</span>
                                        </c:when>
                                        <c:when test="${bill.status == 'cancel'}">
                                            <span class="badge bg-danger">Đã huỷ</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-warning text-dark">Chờ xử lý</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/bills/detail?id=${bill.id}"
                                       class="btn btn-sm btn-outline-secondary">
                                        <span class="material-symbols-outlined">visibility</span>Chi tiết
                                    </a>
                                    <c:if test="${bill.status == 'waiting' || bill.status == 'finish'}">
                                        <form method="post"
                                              action="${pageContext.request.contextPath}/bills/cancel"
                                              class="d-inline"
                                              onsubmit="return confirm('Bạn có chắc muốn huỷ đơn này?');">
                                            <input type="hidden" name="id" value="${bill.id}">
                                            <button type="submit" class="btn btn-sm btn-outline-danger">
                                                <span class="material-symbols-outlined">cancel</span>Huỷ
                                            </button>
                                        </form>
                                    </c:if>
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

    <c:if test="${totalPages > 1}">
        <nav class="mt-3">
            <ul class="pagination justify-content-center">
                <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/bills?page=${currentPage - 1}">Trước</a>
                </li>
                <c:forEach begin="1" end="${totalPages}" var="p">
                    <li class="page-item ${p == currentPage ? 'active' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/bills?page=${p}">${p}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/bills?page=${currentPage + 1}">Sau</a>
                </li>
            </ul>
        </nav>
    </c:if>

</main>

<%@ include file="/views/layout/admin/footer.jsp" %>
