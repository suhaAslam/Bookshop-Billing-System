<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<%@ page import="com.pahanaedu.model.Item" %>

<html>
<head>
    <title>Add Bill</title>
    <style>/* Reset and Base Styles */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        padding: 20px;
        color: #333;
    }

    .page-title {
        text-align: center;
        color: white;
        font-size: 2.5rem;
        margin-bottom: 30px;
        text-shadow: 0 2px 4px rgba(0,0,0,0.3);
        font-weight: 300;
        letter-spacing: 1px;
    }

    /* Error Message Styling */
    .error-message {
        background: linear-gradient(45deg, #ff6b6b, #ee5a52);
        color: white;
        padding: 15px 20px;
        border-radius: 10px;
        margin-bottom: 25px;
        text-align: center;
        font-weight: 500;
        box-shadow: 0 4px 15px rgba(238, 90, 82, 0.3);
        animation: slideInDown 0.5s ease-out;
    }

    /* Form Container */
    .bill-form {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
        border-radius: 20px;
        padding: 40px;
        max-width: 600px;
        margin: 0 auto 30px auto;
        box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        border: 1px solid rgba(255,255,255,0.2);
    }

    /* Form Labels */
    .bill-form label {
        display: block;
        margin-bottom: 8px;
        font-weight: 600;
        color: #444;
        font-size: 1rem;
        margin-top: 20px;
    }

    .bill-form label:first-of-type {
        margin-top: 0;
    }

    /* Form Inputs and Selects */
    .form-select, .form-input {
        width: 100%;
        padding: 15px 18px;
        border: 2px solid #e1e8ed;
        border-radius: 12px;
        font-size: 16px;
        transition: all 0.3s ease;
        background: white;
        outline: none;
        font-family: inherit;
    }

    .form-select:focus, .form-input:focus {
        border-color: #667eea;
        box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        transform: translateY(-2px);
    }

    .form-select:hover, .form-input:hover {
        border-color: #b8c5d6;
    }

    /* Select specific styling */
    .form-select {
        cursor: pointer;
        background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6,9 12,15 18,9'%3e%3c/polyline%3e%3c/svg%3e");
        background-repeat: no-repeat;
        background-position: right 15px center;
        background-size: 20px;
        padding-right: 45px;
        appearance: none;
    }

    /* Button Styles */
    .btn {
        display: inline-block;
        padding: 15px 30px;
        border: none;
        border-radius: 12px;
        font-size: 16px;
        font-weight: 600;
        text-decoration: none;
        text-align: center;
        cursor: pointer;
        transition: all 0.3s ease;
        font-family: inherit;
        letter-spacing: 0.5px;
        position: relative;
        overflow: hidden;
    }

    .btn::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
        transition: left 0.5s;
    }

    .btn:hover::before {
        left: 100%;
    }

    .btn-primary {
        background: linear-gradient(45deg, #667eea, #764ba2);
        color: white;
        box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        margin-top: 25px;
        width: 100%;
    }

    .btn-primary:hover {
        transform: translateY(-3px);
        box-shadow: 0 12px 35px rgba(102, 126, 234, 0.4);
    }

    .btn-primary:active {
        transform: translateY(-1px);
    }

    .btn-back {
        background: linear-gradient(45deg, #6c757d, #5a6268);
        color: white;
        display: block;
        max-width: 250px;
        margin: 0 auto;
        box-shadow: 0 6px 20px rgba(108, 117, 125, 0.3);
    }

    .btn-back:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(108, 117, 125, 0.4);
    }

    /* Responsive Design */
    @media (max-width: 768px) {
        body {
            padding: 10px;
        }

        .page-title {
            font-size: 2rem;
            margin-bottom: 20px;
        }

        .bill-form {
            padding: 25px 20px;
            margin-bottom: 20px;
        }

        .form-select, .form-input {
            padding: 12px 15px;
            font-size: 16px;
        }

        .btn {
            padding: 12px 25px;
            font-size: 15px;
        }
    }

    /* Animation */
    @keyframes slideInDown {
        from {
            transform: translate3d(0, -100%, 0);
            opacity: 0;
        }
        to {
            transform: translate3d(0, 0, 0);
            opacity: 1;
        }
    }

    /* Focus styles for accessibility */
    .btn:focus,
    .form-select:focus,
    .form-input:focus {
        outline: 2px solid #667eea;
        outline-offset: 2px;
    }

    /* Loading state for form submission */
    .bill-form.loading {
        pointer-events: none;
        opacity: 0.7;
    }

    .bill-form.loading .btn-primary::after {
        content: '';
        position: absolute;
        width: 20px;
        height: 20px;
        margin: auto;
        border: 2px solid transparent;
        border-top-color: #ffffff;
        border-radius: 50%;
        animation: spin 1s linear infinite;
    }

    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }</style>

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


</body>
</html>
