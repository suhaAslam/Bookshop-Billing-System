<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>View bills</title>
</head>
<body>
<h2>Bill List</h2>
<table border="1">
    <tr>
        <th>Bill ID</th>
        <th>Customer ID</th>
        <th>Bill Date</th>
        <th>Total Amount</th>
        <th>Action</th>
    </tr>
    <c:forEach var="bill" items="${billList}">
        <tr>
            <td>${bill.billId}</td>
            <td>${bill.customerId}</td>
            <td>${bill.billDate}</td>
            <td>${bill.totalAmount}</td>
            <td><a href="bill?action=delete&id=${bill.billId}">Delete</a></td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
