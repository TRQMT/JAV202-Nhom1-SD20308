<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý loại đồ uống</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
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
						<c:if test="${sessionScope.user != null}">
							<li class="nav-item">
								<a class="nav-link" href="${pageContext.request.contextPath}/employee/pos">Phiếu bán hàng</a>
							</li>
							<li class="nav-item">
								<a class="nav-link  active" href="${pageContext.request.contextPath}/manager/categories">Quản lý loại đồ uống</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" href="${pageContext.request.contextPath}/manager/drinks">Quản lý đồ uống</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" href="${pageContext.request.contextPath}/bills">Quản lý hóa đơn</a>
							</li>
							<c:if test="${sessionScope.user.role}">
								<li class="nav-item">
									<a class="nav-link" href="${pageContext.request.contextPath}/manager/staff">Quản lý nhân viên</a>
								</li>
							</c:if>
						</c:if>
						<li class="nav-item dropdown">
							<a	class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"> ${sessionScope.user!= null? sessionScope.user.fullName :"Tài Khoản"} </a>
							<ul class="dropdown-menu">
								<c:if test="${sessionScope.user== null}">
									<li><a class="dropdown-item" href="${pageContext.request.contextPath}/dang-nhap">Đăng nhập</a></li>
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
			
			<div class="card">
				<div class="card-body">
					<h3 class="text-primary">Thông tin loại đồ uống</h3>
					<hr>
					<c:if test="${message!=null }">
						<label class="text-success">${message}</label>
					</c:if>
					<c:if test="${error!=null }">
						<label class="text-danger">${error}</label>
					</c:if>
					<form method="post">
						<div class="mb-3">
						  <label for="name" class="form-label">Tên loại</label>
						  <input type="text" class="form-control" id="name" name="name" 
						  		 placeholder="Tên loại" value="${category.name}">
						  <input type="hidden" class="form-control" id="id" name="id" value="${category.id}">
						</div>
						
						<button class="btn btn-success px-4"  
							 	formaction="${pageContext.request.contextPath}/manager/categories/add" ${category!=null?"disabled":"" }>
							<i class="fa fa-plus-circle" aria-hidden="true"></i>  Thêm mới
						</button>
						<button class="btn btn-primary px-4"  
								formaction="${pageContext.request.contextPath}/manager/categories/edit" ${category==null?"disabled":""}>
							<i class="fa fa-floppy-o" aria-hidden="true"></i>  Cập nhật
						</button>
						<button formaction="${pageContext.request.contextPath}/manager/categories/delete"  
								class="btn btn-danger" ${category==null?"disabled":""}>
							<i class="fa fa-trash" aria-hidden="true"></i> Xóa
						</button>
						<a href="${pageContext.request.contextPath}/manager/categories"
							 class="btn btn-secondary">
							<i class="fa fa-undo" aria-hidden="true"></i> Làm mới</a>
					</form>
				</div>
			</div>
			
			<div class="clearfix mt-2"></div>
			<div class="card">
				<div class="card-body">
					<h3 class="text-primary">Danh sách loại đồ uống</h3><hr>
					<table class="table">
						<thead>
							<tr>
								<th scope="col" width="10%">STT</th>
								<th scope="col">TÊN LOẠI</th>
								<th scope="col" width="20%" class="text-center">Hành động</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="cate" varStatus="vs">
							<tr>
								<th scope="row">${vs.count}</th>
								<td>${cate.name}</td>
								<td class="text-center">
									<a href="${pageContext.request.contextPath}/manager/categories/edit?id=${cate.id}" class="btn btn-success" data-bs-toggle="tooltip" data-bs-title="Default tooltip">
										<i class="fa fa-pencil-square-o" aria-hidden="true"></i> Chỉnh sửa
									</a>
									
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</main>
		<footer>
		
		</footer>
	</div>
</body>
</html>