<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách Đơn hàng</title>
</head>

<body>
    <h2>Danh sách Đơn hàng</h2>

    <p>Tổng Doanh thu :
        <fmt:formatNumber value="${tongDoanhThu}" type="number" groupingUsed="true"/> VNĐ
    </p>

    <form method="get" action="${pageContext.request.contextPath}/orders">
        Nhân viên :
        <select name="tenNhanVien">
            <option value="">-- Tất cả --</option>
            <c:forEach var="name" items="${danhSachNV}">
                 <option value="${name}" ${name == tenNhanVien ? 'selected' : ''}>${name}</option>
            </c:forEach>
        </select>
        <button type="submit">Lọc</button>
    </form>

    <table border="1">
        <tr>
            <th>Mã đơn</th>
            <th>Tên Nhân viên</th>
            <th>Ngày tạo</th>
            <th>Tổng tiền</th>
            <th>Trạng thái</th>
        </tr>
        <c:forEach var="b" items="${bills}">
            <tr>
                <td>
                    bill_<fmt:formatNumber value="${b.id}" minIntegerDigits="6" maxFractionDigits="0"/>
                </td>
                <td>${b.tenNhanVien}</td>
                <td>${b.ngayTao}</td>
                <td>
                    <fmt:formatNumber value="${b.tongTien}" type="number" groupingUsed="true"/> VNĐ
                </td>
                <td>${b.trangThai}</td>
            </tr>
        </c:forEach>
    </table>

</body>

</html>