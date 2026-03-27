<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Đăng nhập — MyCafe</title>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet"/>
<style>
body { background: linear-gradient(135deg,#3b1f0a,#6b3317); min-height: 100vh; display:flex; align-items:center; }
.login-card { border-radius: 20px; box-shadow: 0 10px 40px rgba(0,0,0,.3); }
.login-title { font-family: 'Playfair Display', serif; color: #6b3317; font-size: 26px; }
.material-symbols-outlined { font-size: 18px; vertical-align: middle; margin-right: 5px; }
</style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-12 col-sm-8 col-md-5">

            <div class="card login-card p-4">

                <div class="text-center mb-4">
                    <img src="${pageContext.request.contextPath}/images/logo.png"
                         alt="logo" height="60"
                         onerror="this.style.display='none'">
                    <h2 class="login-title mt-2">MyCafe</h2>
                    <p class="text-muted small">Hệ thống quản lý MyCafe</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger py-2">
                        <span class="material-symbols-outlined">error</span>${error}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/dang-nhap" method="post">

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Email</label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <span class="material-symbols-outlined">mail</span>
                            </span>
                            <input type="email" class="form-control"
                                   name="email" placeholder="admin@polycoffee.vn"
                                   value="${param.email}" required autofocus>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold">Mật khẩu</label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <span class="material-symbols-outlined">lock</span>
                            </span>
                            <input type="password" class="form-control"
                                   name="password" placeholder="••••••••" required>
                        </div>
                    </div>

                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary btn-lg"
                                style="background:#6b3317; border-color:#6b3317;">
                            <span class="material-symbols-outlined">login</span>Đăng nhập
                        </button>
                    </div>

                </form>

            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>