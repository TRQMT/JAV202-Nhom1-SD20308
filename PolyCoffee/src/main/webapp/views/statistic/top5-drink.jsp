<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Top 5 Best-Selling Drinks" scope="request"/>
<c:set var="activeNav" value="statistics"               scope="request"/>

<%@ include file="/views/layout/admin/header.jsp" %>

<main class="container mt-4">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3 class="mb-0">
            <span class="material-symbols-outlined">bar_chart</span>
            Top 5 đồ uống bán chạy nhất
        </h3>
    </div>

    <%-- Date range filter --%>
    <div class="card mb-4">
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/manager/statistics"
                  method="get" class="row g-3 align-items-end">
                <div class="col-12 col-md-4">
                    <label class="form-label fw-semibold">Từ ngày</label>
                    <input type="date" name="fromDate" class="form-control"
                           value="${fromDate}">
                </div>
                <div class="col-12 col-md-4">
                    <label class="form-label fw-semibold">Đến ngày</label>
                    <input type="date" name="toDate" class="form-control"
                           value="${toDate}">
                </div>
                <div class="col-12 col-md-4 d-flex gap-2">
                    <button type="submit" class="btn btn-primary w-100">
                        <span class="material-symbols-outlined">filter_alt</span> Lọc
                    </button>
                    <a href="${pageContext.request.contextPath}/manager/statistics"
                       class="btn btn-secondary w-100">
                        <span class="material-symbols-outlined">refresh</span> Reset
                    </a>
                </div>
            </form>
        </div>
    </div>

    <c:choose>
        <c:when test="${empty top5}">
            <div class="card">
                <div class="card-body text-center text-muted py-5">
                    <span class="material-symbols-outlined d-block mb-2"
                          style="font-size:48px;">sentiment_dissatisfied</span>
                    <p class="mb-0">Chưa có dữ liệu bán hàng để thống kê</p>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row g-4">

                <%-- Ranking table --%>
                <div class="col-12 col-lg-5">
                    <div class="card h-100">
                        <div class="card-header fw-semibold">
                            <span class="material-symbols-outlined">leaderboard</span>
                            Bảng xếp hạng
                        </div>
                        <div class="card-body p-0">
                            <table class="table table-hover mb-0 align-middle">
                                <thead>
                                    <tr>
                                        <th class="text-center" style="width:55px">Hạng</th>
                                        <th>Tên đồ uống</th>
                                        <th class="text-end">Số ly</th>
                                        <th class="text-end">Doanh thu</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${top5}" var="item" varStatus="st">
                                        <tr>
                                            <td class="text-center">
                                                <c:choose>
                                                    <c:when test="${st.index == 0}">🥇</c:when>
                                                    <c:when test="${st.index == 1}">🥈</c:when>
                                                    <c:when test="${st.index == 2}">🥉</c:when>
                                                    <c:otherwise>
                                                        <span class="fw-bold text-muted">
                                                            ${st.count}
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="fw-semibold">${item.drinkName}</td>
                                            <td class="text-end fw-bold">${item.totalQuantitySold}</td>
                                            <td class="text-end text-success">${item.totalRevenue}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </div>
        </c:otherwise>
    </c:choose>

</main>

<c:if test="${not empty top5}">
    <input type="hidden" id="dataLabels"     value="${chartLabels}">
    <input type="hidden" id="dataQuantities" value="${chartQuantities}">
</c:if>

<%@ include file="/views/layout/admin/footer.jsp" %>

<c:if test="${not empty top5}">
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function () {

     var labelsInput     = document.getElementById('dataLabels');
    var quantitiesInput = document.getElementById('dataQuantities');

    // ── SỬA: khai báo thẳng 2 array thay vì dùng .map() + regex ──
    var bgColors = [
        'rgba(255, 193,   7, 0.85)',
        'rgba(108, 117, 125, 0.85)',
        'rgba(205, 127,  50, 0.85)',
        'rgba( 13, 110, 253, 0.80)',
        'rgba( 25, 135,  84, 0.80)'
    ];
    var borderColors = [
        'rgba(255, 193,   7, 1)',
        'rgba(108, 117, 125, 1)',
        'rgba(205, 127,  50, 1)',
        'rgba( 13, 110, 253, 1)',
        'rgba( 25, 135,  84, 1)'
    ];

    new Chart(document.getElementById('chartTop5'), {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Số ly bán ra',
                data: quantities,
                backgroundColor: bgColors,
                borderColor: borderColors,
                borderWidth: 1,
                borderRadius: 6
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { display: false }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: { stepSize: 1 }
                }
            }
        }
    });
});
</script>
</c:if>
