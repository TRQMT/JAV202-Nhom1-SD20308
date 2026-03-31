<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng nhập</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet"/>
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
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item">
							<a class="nav-link" aria-current="page" href="${pageContext.request.contextPath}/trang-chu">Trang chủ</a>
						</li>
						
						<li class="nav-item dropdown">
							<a	class="nav-link dropdown-toggle active"  href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"> ${sessionScope.user!= null? sessionScope.user.fullName :"Tài Khoản"} </a>
							<ul class="dropdown-menu">
								<c:if test="${sessionScope.user== null}">
									<li><a class="dropdown-item" href="${pageContext.request.contextPath}/dang-nhap">Đăng nhập</a></li>
									<li><a class="dropdown-item" href="${pageContext.request.contextPath}/dang-ky">Đăng ký</a></li>
									<li><a class="dropdown-item" href="${pageContext.request.contextPath}/quen-mat-khau">Quên mật khẩu</a></li>
									
								</c:if>
								
								<c:if test="${sessionScope.user!= null}">
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
		<main>
			<div class="clearfix mt-5"></div>
			<div class="row">
				<div class="col-md-3">
				
				</div>
				<div class="col-md-6">
					<div class="card">
						
						<div class="card-body">
							<h3 class="text-center text-primary">ĐĂNG NHẬP</h3>
							<label class="text-danger">${message }</label>
							<form action="${pageContext.request.contextPath}/dang-nhap" method="post">
								<div class="mb-3">
								  <label for="email" class="form-label">Email: </label>
								  <input type="email" class="form-control" id="email" name="email" placeholder="example@gmail.com" >
								</div>
								<div class="mb-3">
								  <label for="password" class="form-label">Mật khẩu: </label>
								  <input type="password" class="form-control" id="password" name=password placeholder="Mật khẩu" >
								</div>
								<div class="mb-3 text-center">
									<button class="btn btn-primary"><i class="fa fa-sign-in" aria-hidden="true"></i> Đăng nhập</button>
								</div>
								<div class="mb-3">
									<a href="${pageContext.request.contextPath}/quen-mat-khau"> Quên mật khẩu?</a>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			
		</main>
		<footer>
		
		</footer>
	</div>
</body>
</html>