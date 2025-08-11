<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<%@ page import="com.pahanaedu.model.Item" %>

<html>
<head>
    <title>Add Bill</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/addBill.css">

    <script>
        function validateForm() {
            var customerId = document.getElementById("customer_id").value;
            var itemId = document.getElementById("item_id").value;
            var quantity = document.getElementById("quantity").value;

            if (!customerId) {
                alert("Please select a customer!");
                return false;
            }
            if (!itemId) {
                alert("Please select an item!");
                return false;
            }
            if (!quantity || quantity <= 0) {
                alert("Please enter a valid quantity!");
                return false;
            }
            return true;
        }
    </script>
</head>

<body>

<h2 class="page-title">Create New Bill</h2>

<%
    String error = (String) request.getAttribute("error");
    if (error != null) {
%>
<p class="error-message"><%= error %></p>
<%
    }
%>

<%
    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
    List<Item> items = (List<Item>) request.getAttribute("items");
%>

<form action="bill" method="post" onsubmit="return validateForm()" class="bill-form">
    <input type="hidden" name="action" value="create">

    <label for="customer_id">Customer: *</label>
    <select name="customer_id" id="customer_id" class="form-select" required>
        <option value="">--Select Customer--</option>
        <%
            if (customers != null && !customers.isEmpty()) {
                for(Customer c : customers) {
        %>
        <option value="<%= c.getAccountNumber() %>">
            <%= c.getAccountNumber() %> - <%= c.getName() %>
        </option>
        <%
            }
        } else {
        %>
        <option value="" disabled>No customers available</option>
        <%
            }
        %>
    </select>

    <label for="item_id">Item: *</label>
    <select name="item_id" id="item_id" class="form-select" required>
        <option value="">--Select Item--</option>
        <%
            if (items != null && !items.isEmpty()) {
                for(Item i : items) {
        %>
        <option value="<%= i.getItemId() %>">
            <%= i.getName() %> - Rs<%= i.getPrice() %>
        </option>
        <%
            }
        } else {
        %>
        <option value="" disabled>No items available</option>
        <%
            }
        %>
    </select>

    <label for="quantity">Quantity: *</label>
    <input type="number" name="quantity" id="quantity" min="1" class="form-input" required>

    <button type="submit" class="btn btn-primary">Create Bill</button>
</form>

<a href="bill?action=view" class="btn btn-back">⬅ Back to Bills List</a>

<script src="<%= request.getContextPath() %>/js/addBill.js"></script>
</body>
</html>
