<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Thống kê" scope="request"/>
<c:set var="activeNav" value="statistics" scope="request"/>
<%@ include file="/views/layout/admin/header.jsp" %>

<style>
.stat-page { padding: 32px 0 56px; background: #fdf8f2; min-height: calc(100vh - 64px); }

/* PAGE HEADING */
.stat-heading {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 28px;
}
.stat-heading .icon-wrap {
    width: 44px; height: 44px;
    background: linear-gradient(135deg, #b8621a, #d4903a);
    border-radius: 12px;
    display: flex; align-items: center; justify-content: center;
    color: #fff;
    box-shadow: 0 4px 12px rgba(184,98,26,0.35);
}
.stat-heading h4 {
    font-family: 'Playfair Display', Georgia, serif;
    font-size: 22px;
    font-weight: 700;
    color: #2c1810;
    margin: 0;
}

/* FILTER CARD */
.filter-card {
    background: #fff;
    border: 1px solid #ede0cc;
    border-radius: 16px;
    padding: 22px 24px;
    margin-bottom: 24px;
    box-shadow: 0 2px 10px rgba(26,10,0,0.06);
}
.filter-card .form-label {
    font-size: 12.5px;
    font-weight: 600;
    color: #8a7060;
    text-transform: uppercase;
    letter-spacing: .5px;
    margin-bottom: 6px;
}
.filter-card .form-control {
    border: 1.5px solid #e0cdb8 !important;
    border-radius: 10px !important;
    background: #fdf8f2 !important;
    color: #2c1810 !important;
    font-size: 14px !important;
    padding: 9px 14px !important;
}
.filter-card .form-control:focus {
    border-color: #b8621a !important;
    box-shadow: 0 0 0 3px rgba(184,98,26,0.12) !important;
    background: #fff !important;
}
.btn-filter {
    background: #b8621a;
    color: #fff;
    border: none;
    border-radius: 10px;
    padding: 10px 20px;
    font-size: 14px;
    font-weight: 600;
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 7px;
    transition: background .2s, transform .15s;
    cursor: pointer;
}
.btn-filter:hover { background: #3b1f0a; transform: translateY(-1px); }

/* CHART CARDS */
.chart-card {
    background: #fff;
    border: 1px solid #ede0cc;
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 2px 10px rgba(26,10,0,0.06);
    height: 100%;
}
.chart-card-header {
    padding: 16px 20px;
    border-bottom: 1px solid #f0e4d0;
    display: flex;
    align-items: center;
    gap: 8px;
    background: #fffaf5;
}
.chart-card-header .dot {
    width: 8px; height: 8px;
    border-radius: 50%;
    background: #b8621a;
    flex-shrink: 0;
}
.chart-card-header span {
    font-size: 13.5px;
    font-weight: 600;
    color: #2c1810;
}
.chart-card-body { padding: 20px; }

/* TABLE CARD */
.table-card {
    background: #fff;
    border: 1px solid #ede0cc;
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 2px 10px rgba(26,10,0,0.06);
    margin-top: 24px;
}
.table-card-header {
    padding: 16px 20px;
    border-bottom: 1px solid #f0e4d0;
    display: flex;
    align-items: center;
    gap: 8px;
    background: #fffaf5;
}
.table-card-header .dot { width: 8px; height: 8px; border-radius: 50%; background: #b8621a; }
.table-card-header span { font-size: 13.5px; font-weight: 600; color: #2c1810; }

.stat-table { width: 100%; border-collapse: collapse; }
.stat-table thead th {
    background: #fdf5ec;
    color: #8a7060;
    font-size: 11.5px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: .6px;
    padding: 12px 20px;
    border-bottom: 1px solid #ede0cc;
}
.stat-table tbody td {
    padding: 14px 20px;
    font-size: 14px;
    color: #2c1810;
    border-bottom: 1px solid #f5ede0;
    vertical-align: middle;
}
.stat-table tbody tr:last-child td { border-bottom: none; }
.stat-table tbody tr:hover td { background: #fffaf5; }

/* RANK BADGE */
.rank-badge {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 28px; height: 28px;
    border-radius: 8px;
    font-size: 12px;
    font-weight: 700;
}
.rank-1 { background: #fef3c7; color: #92400e; }
.rank-2 { background: #f3f4f6; color: #374151; }
.rank-3 { background: #fef3c7; color: #78350f; }
.rank-other { background: #fdf5ec; color: #8a7060; }

.revenue-text { font-weight: 600; color: #b8621a; }
.qty-text { font-weight: 500; color: #5a3e2b; }
</style>

<main class="stat-page">
<div class="container">

    <!-- HEADING -->
    <div class="stat-heading">
        <div class="icon-wrap">
            <span class="material-symbols-outlined" style="font-size:22px">bar_chart</span>
        </div>
        <h4>Thống kê doanh thu</h4>
    </div>

    <!-- FILTER -->
    <div class="filter-card">
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
            <div class="col-md-4">
                <button class="btn-filter" type="submit">
                    <span class="material-symbols-outlined" style="font-size:17px">filter_alt</span>
                    Lọc dữ liệu
                </button>
            </div>
        </form>
    </div>

    <!-- CHARTS -->
    <div class="row g-4">
        <div class="col-md-7">
            <div class="chart-card">
                <div class="chart-card-header">
                    <div class="dot"></div>
                    <span>Biểu đồ doanh thu theo ngày</span>
                </div>
                <div class="chart-card-body">
                    <canvas id="revenueChart"></canvas>
                </div>
            </div>
        </div>
        <div class="col-md-5">
            <div class="chart-card">
                <div class="chart-card-header">
                    <div class="dot"></div>
                    <span>Top 5 đồ uống (biểu đồ tròn)</span>
                </div>
                <div class="chart-card-body">
                    <canvas id="pieChartTop5"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- TABLE -->
    <div class="table-card">
        <div class="table-card-header">
            <div class="dot"></div>
            <span>Top 5 loại nước bán chạy nhất</span>
        </div>
        <table class="stat-table">
            <thead>
                <tr>
                    <th>Hạng</th>
                    <th>Tên đồ uống</th>
                    <th class="text-end">Số lượng</th>
                    <th class="text-end">Doanh thu</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${topDrinks}" var="item" varStatus="st">
                    <tr>
                        <td>
                            <span class="rank-badge ${st.index == 0 ? 'rank-1' : st.index == 1 ? 'rank-2' : st.index == 2 ? 'rank-3' : 'rank-other'}">
                                ${st.index + 1}
                            </span>
                        </td>
                        <td>${item.drinkName}</td>
                        <td class="text-end qty-text">
                            <fmt:formatNumber value="${item.totalQuantity}" type="number"/>
                        </td>
                        <td class="text-end revenue-text">
                            <fmt:formatNumber value="${item.totalRevenue}" type="number"/> đ
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty topDrinks}">
                    <tr>
                        <td colspan="4" class="text-center py-5" style="color:#b8a898">
                            <span class="material-symbols-outlined" style="font-size:36px;display:block;margin-bottom:8px">inbox</span>
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
                    borderColor: '#b8621a',
                    backgroundColor: 'rgba(184,98,26,0.10)',
                    pointBackgroundColor: '#b8621a',
                    pointRadius: 4,
                    pointHoverRadius: 6,
                    fill: true,
                    tension: 0.4
                }]
            },
            options: {
                plugins: { legend: { labels: { color: '#2c1810', font: { size: 13 } } } },
                scales: {
                    x: { ticks: { color: '#8a7060' }, grid: { color: 'rgba(0,0,0,0.05)' } },
                    y: { ticks: { color: '#8a7060' }, grid: { color: 'rgba(0,0,0,0.05)' } }
                }
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
                        '#b8621a',
                        '#d4903a',
                        '#3b1f0a',
                        '#e8c07a',
                        '#8a5030'
                    ],
                    borderWidth: 2,
                    borderColor: '#fff'
                }]
            },
            options: {
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: { color: '#2c1810', font: { size: 12 }, padding: 16 }
                    }
                }
            }
        });
    }

});
</script>
</c:set>

<%@ include file="/views/layout/admin/footer.jsp" %>
