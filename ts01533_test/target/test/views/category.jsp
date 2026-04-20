<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách loại đồ uống</title>
</head>

<body>
    <h2>Danh sách loại đồ uống</h2>

    <form method="get" action="${pageContext.request.contextPath}/categories">
        Trạng thái :
        <input type="radio" name="status" value=""  ${status == null ? 'checked' : ''}> Tất cả
        <input type="radio" name="status" value="1" ${'1'.equals(status) ? 'checked' : ''}> Đang kinh doanh
        <input type="radio" name="status" value="0" ${'0'.equals(status) ? 'checked' : ''}> Tạm ngưng
        <button type="submit">Lọc</button>

        &nbsp;&nbsp; User : ${sessionScope.user.hoTen}
    </form>

    <table border="1">
        <tr>
            <th>ID</th>
            <th>Tên loại</th>
            <th>Mô tả</th>
            <th>Hình ảnh</th>
            <th>Trạng thái</th>
        </tr>
        <c:forEach var="c" items="${categories}">
            <tr>
                <td>${c.id}</td>
                <td>${c.tenLoai}</td>
                <td>${c.moTa}</td>
                <td>${c.hinhAnh}</td>
                <td>${c.trangThai ? 'Đang kinh doanh' : 'Tạm ngưng'}</td>
            </tr>
        </c:forEach>
    </table>

</body>

</html>