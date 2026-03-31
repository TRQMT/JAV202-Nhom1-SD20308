<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Đồ uống"  scope="request"/>
<c:set var="activeNav" value="drinks"   scope="request"/>
<%@ include file="/views/layout/admin/header.jsp" %>

<main class="container mt-4">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4>
            <span class="material-symbols-outlined">coffee</span>
            Danh sách đồ uống
        </h4>
        <a href="${pageContext.request.contextPath}/manager/drinks/add"
           class="btn btn-primary">
            <span class="material-symbols-outlined">add</span>Thêm mới
        </a>
    </div>

    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show">
            <span class="material-symbols-outlined">check_circle</span>${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

  <form action="${pageContext.request.contextPath}/manager/drinks" method="GET" class="mb-3">
    <div class="input-group" style="max-width: 480px;">
        <span class="input-group-text bg-white border-end-0">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="none"
                 viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                <circle cx="11" cy="11" r="8"/>
                <line x1="21" y1="21" x2="16.65" y2="16.65"/>
            </svg>
        </span>
        <input
            type="text"
            name="keyword"
            value="${keyword}"
            class="form-control border-start-0 ps-0"
            placeholder="Tìm kiếm theo tên đồ uống..."
        />
        <button type="submit" class="btn btn-primary px-3">
            <span class="material-symbols-outlined" style="font-size:18px; vertical-align:middle;">search</span>
            Tìm kiếm
        </button>
        <a href="${pageContext.request.contextPath}/manager/drinks"
           class="btn btn-outline-secondary px-3">
            <span class="material-symbols-outlined" style="font-size:18px; vertical-align:middle;">close</span>
            Xóa
        </a>
    </div>
</form>


    <div class="card">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Ảnh</th>
                            <th>Tên</th>
                            <th>Danh mục</th>
                            <th>Giá</th>
                            <th>Hiển thị</th>
                            <th class="text-center">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${drinks}" var="drink">
                            <tr>
                                <td>${drink.id}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty drink.image}">
                                            <img src="${pageContext.request.contextPath}/uploads/${drink.image}"
                                                 width="48" height="48"
                                                 style="object-fit:cover; border-radius:8px;">
                                        </c:when>
                                        <c:otherwise>
                                            <span class="material-symbols-outlined text-muted">no_photography</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td><strong>${drink.name}</strong>
                                    <div class="text-muted small">${drink.description}</div>
                                </td>
                                <td>${drink.name}</td>
                                <td>
                                    <fmt:formatNumber value="${drink.price}" type="number"/> đ
                                </td>
                                <td>
                                    <span class="badge ${drink.active ? 'bg-success' : 'bg-secondary'}">
                                        ${drink.active ? 'Hiển thị' : 'Ẩn'}
                                    </span>
                                </td>
                                <td class="text-center">
                                    <a href="${pageContext.request.contextPath}/manager/drinks/edit?id=${drink.id}"
                                       class="btn btn-sm btn-outline-primary me-1">
                                        <span class="material-symbols-outlined">edit</span>Sửa
                                    </a>
                                    <a href="${pageContext.request.contextPath}/manager/drinks/toggle?id=${drink.id}"
                                       class="btn btn-sm ${drink.active ? 'btn-outline-warning' : 'btn-outline-success'}">
                                        <span class="material-symbols-outlined">
                                            ${drink.active ? 'visibility_off' : 'visibility'}
                                        </span>
                                        ${drink.active ? 'Ẩn' : 'Hiện'}
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty drinks}">
                            <tr>
                                <td colspan="7" class="text-center text-muted py-4">
                                    <span class="material-symbols-outlined">inbox</span> Chưa có đồ uống nào
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