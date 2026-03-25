<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>

    <!DOCTYPE html>
    <html lang="vi">

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">

      <title>Poly Coffee — ${user != null && user.id != null ? 'Sửa nhân viên' : 'Thêm nhân viên'}</title>

      <!-- Google Font -->
      <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">

      <!-- Bootstrap -->
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

      <!-- Material Icons -->
      <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />

      <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" />

      <style>
        .material-symbols-outlined {
          font-size: 18px;
          vertical-align: middle;
          margin-right: 6px;
        }

        .header-title {
          font-family: 'Playfair Display', serif;
          color: #fff;
          font-size: 32px;
          letter-spacing: 2px;
        }

        .navbar {
          background: #1a0a00 !important;
        }
      </style>

    </head>

    <body>

      <!-- HEADER -->
      <header class="text-center py-3" style="background: linear-gradient(135deg,#3b1f0a,#6b3317);">
        <h1 class="header-title">WELCOME TO MY COFFEE</h1>
      </header>

      <!-- NAVBAR -->
      <nav class="navbar navbar-expand-xl navbar-dark">
        <div class="container-fluid px-4">

          <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain">
            <span class="navbar-toggler-icon"></span>
          </button>

          <div class="collapse navbar-collapse" id="navbarMain">

            <ul class="navbar-nav me-auto">

              <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/trang-chu">
                  <span class="material-symbols-outlined">home</span>Trang chủ
                </a>
              </li>

              <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/employee/pos">
                  <span class="material-symbols-outlined">point_of_sale</span>POS
                </a>
              </li>

              <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/manager/categories">
                  <span class="material-symbols-outlined">category</span>Loại đồ uống
                </a>
              </li>

              <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/manager/drinks">
                  <span class="material-symbols-outlined">coffee</span>Đồ uống
                </a>
              </li>

              <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/bills">
                  <span class="material-symbols-outlined">receipt_long</span>Hóa đơn
                </a>
              </li>

              <li class="nav-item">
                <a class="nav-link active" href="${pageContext.request.contextPath}/manager/staff">
                  <span class="material-symbols-outlined">groups</span>Nhân viên
                </a>
              </li>

            </ul>

            <ul class="navbar-nav">
              <li class="nav-item dropdown">

                <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                  <span class="material-symbols-outlined">account_circle</span>
                  ${sessionScope.user != null ? sessionScope.user.fullName : "Tài khoản"}
                </a>

                <ul class="dropdown-menu dropdown-menu-end">

                  <c:if test="${sessionScope.user == null}">
                    <li>
                      <a class="dropdown-item" href="${pageContext.request.contextPath}/dang-nhap">
                        <span class="material-symbols-outlined">login</span>Đăng nhập
                      </a>
                    </li>
                  </c:if>

                  <c:if test="${sessionScope.user != null}">
                    <li>
                      <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                        <span class="material-symbols-outlined">logout</span>Đăng xuất
                      </a>
                    </li>
                  </c:if>

                </ul>

              </li>
            </ul>

          </div>
        </div>
      </nav>

      <!-- MAIN -->
      <main class="container mt-4">

        <div class="row justify-content-center">
          <div class="col-md-8">

            <div class="card shadow-sm">
              <div class="card-header">
                <h5>
                  <span class="material-symbols-outlined">person</span>
                  ${user != null && user.id != null ? 'Sửa nhân viên' : 'Thêm nhân viên'}
                </h5>
              </div>

              <div class="card-body">

                <form
                  action="${pageContext.request.contextPath}${user != null && user.id != null ? '/manager/staff/edit' : '/manager/staff/add'}"
                  method="post">

                  <c:if test="${user != null && user.id != null}">
                    <input type="hidden" name="userId" value="${user.id}">
                  </c:if>

                  <div class="mb-3">
                    <label>Email *</label>
                    <input type="email" class="form-control" name="email" value="${user.email}" required>
                  </div>

                  <div class="mb-3">
                    <label>Mật khẩu</label>
                    <input type="password" class="form-control" name="password" ${user==null || user.id==null
                      ? 'required' : '' }>
                  </div>

                  <div class="mb-3">
                    <label>Họ tên *</label>
                    <input type="text" class="form-control" name="fullName" value="${user.fullName}" required>
                  </div>

                  <div class="mb-3">
                    <label>Số điện thoại</label>
                    <input type="text" class="form-control" name="phone" value="${user.phone}">
                  </div>

                  <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" name="active" ${user !=null && user.active
                      ? 'checked' : '' }>
                    <label class="form-check-label">Kích hoạt</label>
                  </div>

                  <div class="d-flex gap-2">
                    <button class="btn btn-primary">
                      <span class="material-symbols-outlined">save</span>
                      ${user != null && user.id != null ? 'Lưu' : 'Thêm'}
                    </button>

                    <a href="${pageContext.request.contextPath}/manager/staff" class="btn btn-secondary">
                      <span class="material-symbols-outlined">close</span>
                      Hủy
                    </a>
                  </div>

                </form>

              </div>
            </div>

          </div>
        </div>

      </main>

      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

    </body>

    </html>
