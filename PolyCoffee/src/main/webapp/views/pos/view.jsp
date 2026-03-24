<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>POS - Bán hàng</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet"/>
<style>
    .thumb { width: 64px; height: 48px; object-fit: cover; border-radius: 6px; }
    .fixed-right { position: sticky; top: 20px; }
    @media (max-width: 767px) {
        .fixed-right { position: static; margin-top: 1rem; }
    }
    .order-card { border-radius: 16px !important; box-shadow: 0 8px 32px rgba(28,16,8,.13) !important; }
    .order-card .card-title {
        font-family: 'Lora', serif;
        font-size: 16px;
        font-weight: 700;
        color: #3b1f0a;
    }
    .total-row { border-top: 2px solid #ede0cc; padding-top: 10px; }
</style>
</head>
<body>
<div class="container">
    <header>
        <h1>
            <img alt="" src="${pageContext.request.contextPath}/images/logo.png" width="150">
        </h1>
        <hr>
    </header>

    <nav class="navbar navbar-expand-lg bg-body-tertiary">
        <div class="container-fluid">
            <a class="navbar-brand" href="#"></a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/trang-chu">Trang chủ</a></li>
                    <c:if test="${sessionScope.user != null}">
                        <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/employee/pos">Phiếu bán hàng</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/manager/categories">Quản lý loại đồ uống</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/manager/drinks">Quản lý đồ uống</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/bills">Quản lý hóa đơn</a></li>
                        <c:if test="${sessionScope.user.role}">
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/manager/staff">Quản lý nhân viên</a></li>
                        </c:if>
                    </c:if>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            ${sessionScope.user != null ? sessionScope.user.fullName : "Tài Khoản"}
                        </a>
                        <ul class="dropdown-menu">
                            <c:if test="${sessionScope.user == null}">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/dang-nhap">Đăng nhập</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/quen-mat-khau">Quên mật khẩu</a></li>
                            </c:if>
                            <c:if test="${sessionScope.user != null}">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/edit-profile">Thông tin cá nhân</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/change-pass">Đổi mật khẩu</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
                            </c:if>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <main class="mt-4">
        <c:if test="${param.message == 'paid-cash'}">
            <div class="alert alert-success">Thanh toán tiền mặt thành công.</div>
        </c:if>
        <c:if test="${param.message == 'vnpay-success'}">
            <div class="alert alert-success">Thanh toán VNPAY thành công.</div>
        </c:if>
        <c:if test="${param.message == 'vnpay-failed'}">
            <div class="alert alert-danger">Thanh toán VNPAY thất bại hoặc chữ ký không hợp lệ.</div>
        </c:if>
        <c:if test="${param.message == 'add-item-failed'}">
            <div class="alert alert-danger">Không thể thêm món vào đơn hàng. Vui lòng thử lại.</div>
        </c:if>

        <c:if test="${not empty waitingBills}">
            <div class="mb-3 d-flex flex-wrap gap-2">
                <span class="fw-semibold">Đơn chờ:</span>
                <c:forEach items="${waitingBills}" var="waiting">
                    <a class="btn btn-sm ${billId == waiting.id ? 'btn-primary' : 'btn-outline-primary'}"
                       href="${pageContext.request.contextPath}/employee/pos?billId=${waiting.id}">
                        ${waiting.code}
                    </a>
                </c:forEach>
                <a class="btn btn-sm btn-outline-secondary" href="${pageContext.request.contextPath}/employee/pos">Đơn mới</a>
            </div>
        </c:if>

        <div class="row">
            <div class="col-lg-8 col-md-7">
                <h4 class="mb-3" style="font-family:'Lora',serif;color:#3b1f0a;">Danh sách sản phẩm</h4>
                <div class="row g-3">
                    <c:forEach items="${drinks}" var="drink">
                        <div class="col-6 col-md-4 col-lg-3">
                            <div class="product-card">
                                <img src="${pageContext.request.contextPath}/uploads/${drink.image}" class="w-100 mb-2" style="height:120px;object-fit:cover;border-radius:8px;" alt="drink" onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/${drink.image}';">
                                <div class="fw-semibold" style="font-size:13.5px;">${drink.name}</div>
                                <div class="text-success mb-2" style="font-size:13px;">${drink.price}</div>
                                <form action="${pageContext.request.contextPath}/employee/pos/add-item" method="post">
                                    <input type="hidden" name="drinkId" value="${drink.id}">
                                    <input type="hidden" name="billId" value="${billId}">
                                    <button class="btn btn-sm btn-primary w-100">Thêm</button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <div class="col-lg-4 col-md-5">
                <div class="card order-card fixed-right">
                    <div class="card-body">
                        <h5 class="card-title">Đơn hàng ${bill != null ? bill.code : ''}</h5>
                        <div class="table-responsive" style="max-height:420px; overflow:auto;">
                            <table class="table table-sm align-middle mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th>Tên</th>
                                        <th class="text-center">SL</th>
                                        <th class="text-end">Thành tiền</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${billDetails}" var="detail">
                                        <tr>
                                            <td>${detailDrinkMap[detail.drinkId].name}</td>
                                            <td class="text-center">
                                                <div class="d-flex justify-content-center gap-1">
                                                    <form action="${pageContext.request.contextPath}/employee/pos/update-quantity" method="post">
                                                        <input type="hidden" name="billId" value="${bill.id}">
                                                        <input type="hidden" name="billDetailId" value="${detail.id}">
                                                        <input type="hidden" name="action" value="decrease">
                                                        <button class="btn btn-sm btn-outline-secondary">-</button>
                                                    </form>
                                                    <span class="px-2">${detail.quantity}</span>
                                                    <form action="${pageContext.request.contextPath}/employee/pos/update-quantity" method="post">
                                                        <input type="hidden" name="billId" value="${bill.id}">
                                                        <input type="hidden" name="billDetailId" value="${detail.id}">
                                                        <input type="hidden" name="action" value="increase">
                                                        <button class="btn btn-sm btn-outline-secondary">+</button>
                                                    </form>
                                                </div>
                                            </td>
                                            <td class="text-end">${detail.price * detail.quantity}</td>
                                            <td>
                                                <form action="${pageContext.request.contextPath}/employee/pos/update-quantity" method="post">
                                                    <input type="hidden" name="billId" value="${bill.id}">
                                                    <input type="hidden" name="billDetailId" value="${detail.id}">
                                                    <input type="hidden" name="action" value="remove">
                                                    <button class="btn btn-sm btn-light text-danger">X</button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty billDetails}">
                                        <tr>
                                            <td colspan="4" class="text-center text-muted">Chưa có sản phẩm</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>

                        <div class="mt-3">
                            <div class="d-flex justify-content-between fw-bold fs-5 mt-2 total-row">
                                <div>Tổng</div>
                                <div>${bill != null ? bill.total : 0}</div>
                            </div>
                        </div>

                        <div class="d-flex gap-2 mt-3">
                            <form class="w-100" action="${pageContext.request.contextPath}/employee/pos/checkout" method="post">
                                <input type="hidden" name="billId" value="${bill.id}">
                                <select class="form-select form-select-sm mb-2" name="paymentMethod">
                                    <option value="cash">Tiền mặt</option>
                                    <option value="transfer">Chuyển khoản / Quét QR (VNPAY)</option>
                                </select>
                                <button class="btn btn-success w-100" ${bill == null || empty billDetails ? 'disabled' : ''}>Hoàn thành đơn</button>
                            </form>
                            <form class="w-100" action="${pageContext.request.contextPath}/employee/pos/cancel" method="post">
                                <input type="hidden" name="billId" value="${bill.id}">
                                <button class="btn btn-outline-danger w-100" ${bill == null ? 'disabled' : ''}>Hủy đơn</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer>
        <p>© 2025 Poly Coffee &nbsp;·&nbsp; FPT Polytechnic</p>
    </footer>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
