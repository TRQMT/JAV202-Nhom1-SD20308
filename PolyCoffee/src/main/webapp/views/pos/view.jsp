<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%-- ① Layout variables --%>
<c:set var="pageTitle" value="Bán hàng — POS" scope="request"/>
<c:set var="activeNav" value="pos"            scope="request"/>

<%-- ② CSS riêng trang POS --%>
<c:set var="extraStyles" scope="request">
<style>
.product-card {
    border-radius: 12px;
    border: 1px solid #e8e0d8;
    padding: 8px;
    background: #fff;
    transition: .15s;
    cursor: pointer;
}
.product-card:hover {
    transform: translateY(-3px);
    box-shadow: 0 6px 18px rgba(0,0,0,.12);
}
.product-card img {
    border-radius: 8px;
    width: 100%;
    height: 110px;
    object-fit: cover;
}
.order-card {
    border-radius: 16px;
    box-shadow: 0 8px 32px rgba(0,0,0,.1);
}
.fixed-right { position: sticky; top: 20px; }
@media (max-width: 767px) {
    .fixed-right { position: static; }
}
</style>
</c:set>

<%-- ③ Nhúng header dùng chung --%>
<%@ include file="/views/layout/admin/header.jsp" %>

<!-- ===== MAIN CONTENT ===== -->
<main class="container mt-4">
<div class="row g-4">

    <%-- LEFT: Danh sách sản phẩm --%>
    <div class="col-lg-8">

        <h4 class="mb-3">
            <span class="material-symbols-outlined">coffee</span>
            Danh sách sản phẩm
        </h4>

        <form action="${pageContext.request.contextPath}/employee/pos" method="get" class="card mb-3">
            <div class="card-body">
                <input type="hidden" name="billId" value="${billId}">
                <div class="row g-2">
                    <div class="col-md-5">
                        <input type="text" class="form-control" name="keyword" value="${keyword}"
                               placeholder="Tìm theo tên đồ uống...">
                    </div>
                    <div class="col-md-4">
                        <select class="form-select" name="categoryId">
                            <option value="">Tất cả danh mục</option>
                            <c:forEach items="${categories}" var="cat">
                                <option value="${cat.maLoai}"
                                    ${selectedCategoryId == cat.maLoai ? 'selected' : ''}>
                                    ${cat.tenLoai}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3 d-grid">
                        <button type="submit" class="btn btn-primary">
                            <span class="material-symbols-outlined">search</span>Tìm
                        </button>
                    </div>
                </div>
            </div>
        </form>

        <div class="row g-3">
            <c:forEach items="${drinks}" var="drink">
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="product-card">

                        <%-- Ảnh fallback --%>
                        <c:choose>
                            <c:when test="${not empty drink.image}">
                                <img src="${pageContext.request.contextPath}/uploads/${drink.image}"
                                     alt="${drink.name}"
                                     onerror="this.src='${pageContext.request.contextPath}/images/cafesua.jpg'">
                            </c:when>
                            <c:otherwise>
                                <div style="height:110px;background:#f8f5f0;border-radius:8px;
                                            display:flex;align-items:center;justify-content:center;">
                                    <span class="material-symbols-outlined"
                                          style="font-size:40px;color:#c9a07a;">coffee</span>
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <div class="fw-semibold mt-2" style="font-size:13px;">
                            ${drink.name}
                        </div>
                        <div class="fw-semibold" style="color:#6b3317;font-size:13px;">
                            <fmt:formatNumber value="${drink.price}" type="number"/> đ
                        </div>

                        <%-- Form thêm vào đơn --%>
                        <form action="${pageContext.request.contextPath}/employee/pos/add-item"
                              method="post">
                            <input type="hidden" name="drinkId" value="${drink.id}">
                            <input type="hidden" name="billId"  value="${billId}">
                            <input type="hidden" name="keyword" value="${keyword}">
                            <input type="hidden" name="categoryId" value="${selectedCategoryId}">
                            <button type="submit" class="btn btn-sm btn-primary w-100 mt-1">
                                <span class="material-symbols-outlined">add</span>Thêm
                            </button>
                        </form>

                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty drinks}">
                <div class="text-muted text-center py-5">
                    <span class="material-symbols-outlined" style="font-size:48px;">inbox</span>
                    <p class="mt-2">Chưa có sản phẩm nào</p>
                </div>
            </c:if>
        </div>

    </div>

    <%-- RIGHT: Đơn hàng --%>
    <div class="col-lg-4">
        <div class="card order-card fixed-right">
            <div class="card-body">

                <h5 class="mb-3">
                    <span class="material-symbols-outlined">receipt</span>
                    Đơn hàng
                    <span class="text-muted small fw-normal">${bill != null ? bill.code : ''}</span>
                </h5>

                <%-- Chi tiết đơn --%>
                <table class="table table-sm mb-2">
                    <tbody>
                        <c:forEach items="${billDetails}" var="d">
                            <tr>
                                <td>${detailDrinkMap[d.drinkId].name}</td>
                                <td class="text-center">x${d.quantity}</td>
                                <td class="text-end fw-semibold">
                                    <fmt:formatNumber value="${d.price * d.quantity}" type="number"/> đ
                                </td>
                                <td class="text-end">
                                    <%-- Nút xóa từng dòng --%>
                                    <form action="${pageContext.request.contextPath}/employee/pos/remove-item"
                                          method="post" class="d-inline">
                                        <input type="hidden" name="billDetailId" value="${d.id}">
                                        <input type="hidden" name="billId" value="${bill.id}">
                                        <button type="submit" class="btn btn-link btn-sm p-0 text-danger">
                                            <span class="material-symbols-outlined"
                                                  style="font-size:16px;">delete</span>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty billDetails}">
                            <tr>
                                <td colspan="4" class="text-muted text-center py-3">
                                    Chưa có sản phẩm
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>

                <%-- Tổng tiền --%>
                <div class="d-flex justify-content-between fw-bold border-top pt-2 mb-3">
                    <span>Tổng cộng</span>
                    <span style="color:#6b3317;">
                        <fmt:formatNumber value="${bill != null ? bill.total : 0}"
                                          type="number"/> đ
                    </span>
                </div>

                <%-- Form thanh toán --%>
                <form action="${pageContext.request.contextPath}/employee/pos/checkout"
                      method="post">
                    <input type="hidden" name="billId" value="${bill.id}">

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Phương thức thanh toán</label>
                        <div class="form-check">
                            <input class="form-check-input" type="radio"
                                   name="paymentMethod" id="payCash" value="cash" checked>
                            <label class="form-check-label" for="payCash">
                                <span class="material-symbols-outlined">payments</span>
                                Tiền mặt
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio"
                                   name="paymentMethod" id="payVnpay" value="vnpay">
                            <label class="form-check-label" for="payVnpay">
                                <span class="material-symbols-outlined">credit_card</span>
                                Chuyển khoản VNPay
                            </label>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-success w-100"
                            ${bill == null || empty billDetails ? 'disabled' : ''}>
                        <span class="material-symbols-outlined">check_circle</span>
                        Thanh toán
                    </button>

                </form>

                <%-- Nút xóa toàn bộ đơn --%>
                <c:if test="${not empty billDetails}">
                    <form action="${pageContext.request.contextPath}/employee/pos/clear"
                          method="post" class="mt-2">
                        <input type="hidden" name="billId" value="${bill.id}">
                        <button type="submit" class="btn btn-outline-danger w-100"
                                onclick="return confirm('Xóa toàn bộ đơn hàng?')">
                            <span class="material-symbols-outlined">delete_sweep</span>
                            Xóa đơn
                        </button>
                    </form>
                </c:if>

            </div>
        </div>
    </div>

</div>
</main>
<%-- ===== END MAIN ===== --%>

<%@ include file="/views/layout/admin/footer.jsp" %>