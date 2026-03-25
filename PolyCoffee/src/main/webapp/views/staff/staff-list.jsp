<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>

    <!DOCTYPE html>
    <html lang="vi">

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">

      <title>Poly Coffee — Danh sách nhân viên</title>

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

        <div class="d-flex justify-content-between align-items-center mb-3">
          <h3 class="page-heading mb-0">
            <span class="material-symbols-outlined">groups</span>
            Danh sách nhân viên
          </h3>

          <a href="${pageContext.request.contextPath}/manager/staff/add" class="btn btn-success">
            <span class="material-symbols-outlined">person_add</span>
            Thêm mới
          </a>
        </div>

        <div class="card">
          <div class="card-body p-0">

            <div class="table-responsive">
              <table class="table table-striped table-hover mb-0 align-middle">

                <thead>
                  <tr>
                    <th>Mã</th>
                    <th>Email</th>
                    <th>Họ và tên</th>
                    <th>SĐT</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                  </tr>
                </thead>

                <tbody>

                  <c:forEach items="${staffList}" var="staff">
                    <tr>

                      <td>${staff.id}</td>

                      <td style="color:var(--text-muted);font-size:13px;">
                        ${staff.email}
                      </td>

                      <td style="font-weight:500;">
                        ${staff.fullName}
                      </td>

                      <td>${staff.phone}</td>

                      <td>
                        <span class="badge ${staff.active ? 'bg-success' : 'bg-secondary'}">
                          ${staff.active ? 'Hoạt động' : 'Bị khóa'}
                        </span>
                      </td>

                      <td>

                        <a href="${pageContext.request.contextPath}/manager/staff/edit?id=${staff.id}"
                          class="btn btn-sm btn-warning me-1">
                          <span class="material-symbols-outlined">edit</span>
                        </a>

                        <a href="${pageContext.request.contextPath}/manager/staff/update-status?id=${staff.id}&active=${staff.active ? 0 : 1}"
                          class="btn btn-sm ${staff.active ? 'btn-danger' : 'btn-success'}"
                          onclick="return confirm('Bạn có chắc muốn đổi trạng thái?');">
                          <span class="material-symbols-outlined">
                            ${staff.active ? 'lock' : 'lock_open'}
                          </span>
                        </a>

                      </td>

                    </tr>
                  </c:forEach>

                  <c:if test="${empty staffList}">
                    <tr>
                      <td colspan="6" class="text-center py-4 text-muted">
                        Chưa có nhân viên nào
                      </td>
                    </tr>
                  </c:if>

                </tbody>

              </table>
            </div>

          </div>
        </div>

      </main>

      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

    </body>

    </html>
