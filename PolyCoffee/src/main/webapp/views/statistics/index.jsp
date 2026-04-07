<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Thống kê" scope="request"/>
<c:set var="activeNav" value="statistics" scope="request"/>
<%@ include file="/views/layout/admin/header.jsp" %>

<main class="container mt-4">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4>
            <span class="material-symbols-outlined">bar_chart</span>
            Thống kê doanh thu
        </h4>
    </div>

    <!-- FILTER -->
    <div class="card mb-3">
        <div class="card-body">
            <form method="get" action="${pageContext.request.contextPath}/manager/statistics"
                  class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="form-label">Từ ngày</label>
                    <input type="date" class="form-control" name="fromDate" value="${fromDate}">
                </div>
                <div class="col-md-4">
                    <label class="form-label">Đến ngày</label>
                    <input type="date" class="form-control" name="toDate" value="${toDate}">
                </div>
                <div class="col-md-4 d-grid">
                    <button class="btn btn-primary" type="submit">Lọc dữ liệu</button>
                </div>
            </form>
        </div>
    </div>

    <!-- CHARTS -->
    <div class="row">

        <!-- LINE CHART -->
        <div class="col-md-7">
            <div class="card h-100">
                <div class="card-header bg-light fw-semibold">
                    Biểu đồ doanh thu theo ngày
                </div>
                <div class="card-body">
                    <canvas id="revenueChart"></canvas>
                </div>
            </div>
        </div>

        <!-- PIE CHART -->
        <div class="col-md-5">
            <div class="card h-100">
                <div class="card-header bg-light fw-semibold">
                    Top 5 đồ uống (biểu đồ tròn)
                </div>
                <div class="card-body">
                    <canvas id="pieChartTop5"></canvas>
                </div>
            </div>
        </div>

    </div>

    <!-- TABLE -->
    <div class="card mt-3">
        <div class="card-header bg-light fw-semibold">
            Top 5 loại nước bán chạy nhất
        </div>
        <div class="card-body p-0">
            <table class="table table-hover mb-0 align-middle">
                <thead>
                    <tr>
                        <th>Hạng</th>
                        <th>Tên</th>
                        <th class="text-end">Số lượng</th>
                        <th class="text-end">Doanh thu</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${topDrinks}" var="item" varStatus="st">
                        <tr>
                            <td>#${st.index + 1}</td>
                            <td>${item.drinkName}</td>
                            <td class="text-end">
                                <fmt:formatNumber value="${item.totalQuantity}" type="number"/>
                            </td>
                            <td class="text-end">
                                <fmt:formatNumber value="${item.totalRevenue}" type="number"/> đ
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty topDrinks}">
                        <tr>
                            <td colspan="4" class="text-center text-muted py-4">
                                Không có dữ liệu
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

</main>

<!-- SCRIPT -->
<c:set var="extraScripts" scope="request">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
document.addEventListener('DOMContentLoaded', function () {

    // ===== LINE CHART =====
    const chartLabels = JSON.parse('<c:out value="${chartLabels}" escapeXml="false"/>');
    const chartRevenueData = JSON.parse('<c:out value="${chartRevenueData}" escapeXml="false"/>');

    const ctx = document.getElementById('revenueChart');

    if (ctx) {
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: chartLabels,
                datasets: [{
                    label: 'Doanh thu (VND)',
                    data: chartRevenueData,
                    borderColor: '#7A3B16',
                    backgroundColor: 'rgba(122,59,22,0.15)',
                    fill: true,
                    tension: 0.3
                }]
            }
        });
    }

    // ===== PIE CHART =====
    const pieLabels = [
        <c:forEach items="${topDrinks}" var="item" varStatus="st">
            "${item.drinkName}"${!st.last ? ',' : ''}
        </c:forEach>
    ];

    const pieData = [
        <c:forEach items="${topDrinks}" var="item" varStatus="st">
            ${item.totalQuantity}${!st.last ? ',' : ''}
        </c:forEach>
    ];

    const pieCtx = document.getElementById('pieChartTop5');

    if (pieCtx && pieData.length > 0) {
        new Chart(pieCtx, {
            type: 'pie',
            data: {
                labels: pieLabels,
                datasets: [{
                    data: pieData,
                    backgroundColor: [
                        '#FFC107',
                        '#6C757D',
                        '#CD7F32',
                        '#0D6EFD',
                        '#198754'
                    ]
                }]
            }
        });
    }

});
</script>
</c:set>

<%@ include file="/views/layout/admin/footer.jsp" %>
