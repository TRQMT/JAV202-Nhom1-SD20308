<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Kết quả thanh toán</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
</head>
<body>
<div class="container py-5" style="max-width: 720px;">
    <div class="card shadow-sm">
        <div class="card-body text-center p-4">
            <h3 class="mb-3">Kết quả giao dịch VNPAY</h3>

            <c:if test="${transResult}">
                <div class="alert alert-success mb-3">Thanh toán thành công.</div>
                <a class="btn btn-success" href="${pageContext.request.contextPath}/employee/pos?message=vnpay-success">Về màn hình POS</a>
            </c:if>

            <c:if test="${!transResult}">
                <div class="alert alert-danger mb-3">Thanh toán thất bại hoặc dữ liệu trả về không hợp lệ.</div>
                <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/employee/pos?message=vnpay-failed">Quay lại POS</a>
            </c:if>
        </div>
    </div>
</div>
</body>
</html>
