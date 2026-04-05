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

    <div class="card mb-3">
        <div class="card-body">
            <form method="get" action="${pageContext.request.contextPath}/manager/statistics" class="row g-3 align-items-end">
                <div class="col-md-4">
                    <label class="form-label">Từ ngày</label>
                    <input type="date" class="form-control" name="fromDate" value="${fromDate}">
                </div>
                <div class="col-md-4">
                    <label class="form-label">Đến ngày</label>
                    <input type="date" class="form-control" name="toDate" value="${toDate}">
                </div>
                <div class="col-md-4 d-grid">
                    <button class="btn btn-primary" type="submit">
                        <span class="material-symbols-outlined">filter_alt</span>Lọc dữ liệu
                    </button>
                </div>
            </form>
        </div>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="card h-100">
        <div class="card-header bg-light fw-semibold">Biểu đồ doanh thu theo ngày</div>
        <div class="card-body">
            <canvas id="revenueChart" height="130"></canvas>
        </div>
    </div>

</main>

<c:set var="extraScripts" scope="request">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
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
                        tension: 0.25,
                        borderWidth: 2,
                        pointRadius: 4
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            display: true
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        }
    </script>
</c:set>

<%@ include file="/views/layout/admin/footer.jsp" %>
