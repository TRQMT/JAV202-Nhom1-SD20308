<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Poly Coffee — Kết quả thanh toán</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">

<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet"/>

<style>
body {
    font-family: 'Poppins', sans-serif;
    background: #f8f5f2;
}

/* Navbar */
.navbar-custom {
    background: linear-gradient(135deg, #4b2e2e, #6f4e37);
}

.navbar-brand-custom {
    font-weight: 700;
    font-size: 22px;
    color: #fff !important;
    letter-spacing: 1px;
}

/* Result Card */
.result-wrap {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 80vh;
}

.result-card {
    max-width: 420px;
    width: 100%;
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 10px 30px rgba(0,0,0,0.1);
}

.result-header {
    background: linear-gradient(135deg, #4b2e2e, #6f4e37);
    padding: 28px;
    text-align: center;
    color: #fff;
}

.result-icon {
    font-size: 48px;
    margin-bottom: 10px;
}

.result-body {
    padding: 28px;
    text-align: center;
}
</style>
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-xl navbar-custom px-4">
    <a class="navbar-brand navbar-brand-custom" href="${pageContext.request.contextPath}/trang-chu">
        WELCOME TO MY COFFEE
    </a>
</nav>

<!-- MAIN -->
<main>
    <div class="result-wrap">

        <div class="result-card card">

            <!-- HEADER -->
            <div class="result-header">
                <div class="result-icon">
                    <c:choose>
                        <c:when test="${transResult}">✔</c:when>
                        <c:otherwise>✖</c:otherwise>
                    </c:choose>
                </div>
                <h4>Kết quả giao dịch VNPAY</h4>
            </div>

            <!-- BODY -->
            <div class="result-body">

                <c:if test="${transResult}">
                    <div class="alert alert-success">
                        Thanh toán thành công. Cảm ơn bạn!
                    </div>
                    <a class="btn btn-success w-100"
                       href="${pageContext.request.contextPath}/employee/pos?message=vnpay-success">
                        Quay về POS
                    </a>
                </c:if>

                <c:if test="${!transResult}">
                    <div class="alert alert-danger">
                        Thanh toán thất bại hoặc dữ liệu không hợp lệ.
                    </div>
                    <a class="btn btn-outline-secondary w-100"
                       href="${pageContext.request.contextPath}/employee/pos?message=vnpay-failed">
                        Quay lại POS
                    </a>
                </c:if>

            </div>

        </div>

    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
