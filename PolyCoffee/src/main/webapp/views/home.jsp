<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core"      prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt"       prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<%--
    TODO (TEAM):
    - Import database from .sql file
    - Create DB connection (JDBC)
    - Check tables: drinks, categories, staff, bills
    - Update DB username/password
--%>

<c:set var="pageTitle" value="Trang chủ" scope="request"/>
<c:set var="activeNav" value="home"      scope="request"/>

<%@ include file="/views/layout/admin/header.jsp" %>

<!-- ===== MAIN ===== -->
<main class="container mt-5">

    <div class="text-center mb-5">
        <h2 class="fw-bold">Choose Your Coffee</h2>
        <p class="text-muted">Select a drink to start your experience</p>
    </div>

    <%-- Hiển thị drinks từ DB nếu có, fallback về 3 card tĩnh --%>
    <c:choose>

        <c:when test="${not empty drinks}">
            <div class="row g-4">
                <c:forEach items="${drinks}" var="drink">
                    <div class="col-6 col-md-4 col-lg-3">
                        <div class="card text-center p-3 h-100">

                            <c:choose>
                                <c:when test="${not empty drink.image}">
                                    <img src="${pageContext.request.contextPath}/uploads/${drink.image}"
                                         class="card-img-top mb-2"
                                         style="height:120px;object-fit:cover;border-radius:10px;"
                                         alt="${drink.name}"
                                         onerror="this.src='${pageContext.request.contextPath}/images/cafesua.jpg'">
                                </c:when>
                                <c:otherwise>
                                    <div style="height:120px;background:#f8f5f0;border-radius:10px;
                                                display:flex;align-items:center;justify-content:center;"
                                         class="mb-2">
                                        <span class="material-symbols-outlined"
                                              style="font-size:48px;color:#c9a07a;">coffee</span>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                            <h6 class="fw-bold">${drink.name}</h6>
                            <p class="text-muted small mb-2">${drink.description}</p>
                            <p class="fw-semibold mb-3" style="color:#6b3317;">
                                <fmt:formatNumber value="${drink.price}" type="number"/> đ
                            </p>

                            <c:if test="${sessionScope.user != null}">
                                <form action="${pageContext.request.contextPath}/employee/pos/add-item"
                                      method="post">
                                    <input type="hidden" name="drinkId" value="${drink.id}">
                                    <button type="submit" class="btn btn-primary btn-sm w-100">
                                        <span class="material-symbols-outlined">shopping_cart</span>Chọn
                                    </button>
                                </form>
                            </c:if>

                            <c:if test="${sessionScope.user == null}">
                                <a href="${pageContext.request.contextPath}/dang-nhap"
                                   class="btn btn-outline-primary btn-sm w-100">
                                    <span class="material-symbols-outlined">lock</span>Đăng nhập để chọn
                                </a>
                            </c:if>

                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>

        <%-- Fallback: chưa có data từ DB --%>
        <c:otherwise>
            <div class="row g-4 justify-content-center">

                <div class="col-md-4">
                    <div class="card text-center p-3">
                        <span class="material-symbols-outlined"
                              style="font-size:48px;color:#6b3317;">coffee</span>
                        <h5 class="mt-2">Espresso</h5>
                        <p class="text-muted small">Strong and bold coffee</p>
                        <button class="btn btn-primary btn-sm">
                            <span class="material-symbols-outlined">shopping_cart</span>Chọn
                        </button>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card text-center p-3">
                        <span class="material-symbols-outlined"
                              style="font-size:48px;color:#6b3317;">local_cafe</span>
                        <h5 class="mt-2">Cappuccino</h5>
                        <p class="text-muted small">Smooth with milk foam</p>
                        <button class="btn btn-success btn-sm">
                            <span class="material-symbols-outlined">shopping_cart</span>Chọn
                        </button>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card text-center p-3">
                        <span class="material-symbols-outlined"
                              style="font-size:48px;color:#6b3317;">emoji_food_beverage</span>
                        <h5 class="mt-2">Latte</h5>
                        <p class="text-muted small">Light and creamy</p>
                        <button class="btn btn-warning btn-sm">
                            <span class="material-symbols-outlined">shopping_cart</span>Chọn
                        </button>
                    </div>
                </div>

            </div>
        </c:otherwise>

    </c:choose>

</main>
<%-- ===== END MAIN ===== --%>

<%@ include file="/views/layout/admin/footer.jsp" %>
