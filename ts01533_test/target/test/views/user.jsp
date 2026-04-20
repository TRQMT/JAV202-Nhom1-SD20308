<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách nhân viên</title>
</head>

<body>
    <h2>Danh sách nhân viên</h2>

    <form method="get" action="${pageContext.request.contextPath}/users">
        Trạng thái :
        <input type="radio" name="status" value=""  ${status == null ? 'checked' : ''}> Tất cả
        <input type="radio" name="status" value="1" ${'1'.equals(status) ? 'checked' : ''}> Đang làm việc
        <input type="radio" name="status" value="0" ${'0'.equals(status) ? 'checked' : ''}> Nghỉ việc
        <button type="submit">Lọc</button>

        &nbsp;&nbsp; User : ${sessionScope.user.hoTen}
    </form>

    <table border="1">
        <tr>
            <th>ID</th>
            <th>Họ tên</th>
            <th>Email</th>
            <th>Vai trò</th>
            <th>Trạng thái</th>
        </tr>
        <c:forEach var="u" items="${users}">
            <tr>
                <td>${u.id}</td>
                <td>${u.hoTen}</td>
                <td>${u.email}</td>
                <td>${u.vaiTro}</td>
                <td>${u.trangThai ? 'Đang làm việc' : 'Nghỉ việc'}</td>
            </tr>
        </c:forEach>
    </table>

</body>

</html>