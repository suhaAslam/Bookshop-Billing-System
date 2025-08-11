
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>add bills</title>
</head>
<body>
<form action="bill" method="post">
    <label>Customer ID:</label>
    <input type="number" name="customerId" required><br>

    <label>Total Amount:</label>
    <input type="number" step="0.01" name="totalAmount" required><br>

    <button type="submit">Create Bill</button>
</form>

</body>
</html>
