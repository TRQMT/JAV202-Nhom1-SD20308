<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Document</title>
        </head>

        <body>
            <h2>Danh sách đồ uống</h2>

            <form method="get" action="${pageContext.request.contextPath}/drinks">
                Trạng thái :
                <input type="radio" name="status" value="" ${status==null ? 'checked' : '' }> Tất cả
                <input type="radio" name="status" value="1" ${'1'.equals(status) ? 'checked' : '' }> Đang bán
                <input type="radio" name="status" value="0" ${'0'.equals(status) ? 'checked' : '' }> Tạm ngưng
                <button type="submit">Lọc</button>

                &nbsp;&nbsp; User : ${sessionScope.user.hoTen}
            </form>

            <table border="1">
                <tr>
                    <th>ID</th>
                    <th>Tên đồ uống</th>
                    <th>Giá</th>
                    <th>Loại</th>
                    <th>Trạng thái</th>
                </tr>
                <c:forEach var="d" items="${drinks}">
                    <tr>
                        <td>${d.id}</td>
                        <td>${d.name}</td>
                        <td>${d.price}</td>
                        <td>${d.categoryName}</td>
                        <td>${d.active ? 'Đang bán' : 'Tạm ngưng'}</td>
                    </tr>
                </c:forEach>
            </table>

        </body>

        </html>