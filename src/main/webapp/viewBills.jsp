<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.model.Bill" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Bills</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/viewBills.css">
</head>
<body>

<h1 class="page-title">All Bills</h1>

<div class="header-actions">
    <a href="bill?action=add" class="btn btn-primary">Add New Bill</a>
</div>

<table class="bills-table">
    <thead>
    <tr>
        <th>Bill ID</th>
        <th>Customer ID</th>
        <th>Item ID</th>
        <th>Quantity</th>
        <th>Total Price</th>
        <th>Bill Date</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
        List<Bill> billList = (List<Bill>) request.getAttribute("billList");
        System.out.println("JSP: Bill list size: " + (billList != null ? billList.size() : "null"));

        if (billList != null && !billList.isEmpty()) {
            for (Bill bill : billList) {
    %>
    <tr>
        <td><%= bill.getBillId() %></td>
        <td><%= bill.getCustomerId() %></td>
        <td><%= bill.getItemId() %></td>
        <td><%= bill.getQuantity() %></td>
        <td>Rs <%= bill.getTotalPrice() %></td>
        <td><%= bill.getBillDate() %></td>
        <td>
            <a href="bill?action=delete&id=<%= bill.getBillId() %>"
               class="btn btn-danger"
               onclick="return confirm('Are you sure you want to delete this bill?')">
                Delete
            </a>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="7" class="no-data">No bills found.</td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>

<br>
<a href="index.jsp" class="btn btn-back">⬅ Back to Dashboard</a>

</body>
</html>
