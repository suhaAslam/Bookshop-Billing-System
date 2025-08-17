<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.model.Bill" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Bills</title>
    <style>
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
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            animation: slideUp 0.8s ease;
        }

        @keyframes slideUp {
            from {
                transform: translateY(50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .header {
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            color: white;
            padding: 30px 40px;
            text-align: center;
        }

        .header h1 {
            font-size: 2.5rem;
            font-weight: 300;
            margin-bottom: 10px;
        }

        .header p {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        .actions-bar {
            padding: 25px 40px;
            background: #f8f9fa;
            border-bottom: 1px solid #e9ecef;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .search-container {
            position: relative;
            flex: 1;
            max-width: 400px;
        }

        .search-input {
            width: 100%;
            padding: 12px 45px 12px 15px;
            border: 2px solid #e9ecef;
            border-radius: 25px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .search-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #7f8c8d;
            font-size: 1.2rem;
        }

        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 25px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
            color: white;
        }

        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(108, 117, 125, 0.4);
        }

        .btn-small {
            padding: 8px 15px;
            font-size: 0.9rem;
            border-radius: 15px;
        }

        .btn-edit {
            background: #f39c12;
            color: white;
        }

        .btn-edit:hover {
            background: #e67e22;
            transform: translateY(-1px);
        }

        .btn-delete {
            background: #e74c3c;
            color: white;
        }

        .btn-delete:hover {
            background: #c0392b;
            transform: translateY(-1px);
        }

        .table-container {
            padding: 0 40px 40px;
            overflow-x: auto;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .table thead {
            background: linear-gradient(135deg, #34495e 0%, #2c3e50 100%);
            color: white;
        }

        .table th,
        .table td {
            padding: 15px 20px;
            text-align: left;
            border-bottom: 1px solid #e9ecef;
        }

        .table th {
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.9rem;
        }

        .table tbody tr {
            transition: all 0.3s ease;
        }

        .table tbody tr:hover {
            background: #f8f9fa;
            transform: scale(1.01);
        }

        .table tbody tr:nth-child(even) {
            background: rgba(102, 126, 234, 0.05);
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #7f8c8d;
        }

        .empty-state h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: #95a5a6;
        }

        .empty-state p {
            font-size: 1.1rem;
            margin-bottom: 30px;
        }

        .actions-cell {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        /* Bill specific styles */
        .bill-id {
            font-weight: bold;
            color: #667eea;
        }

        .customer-id {
            font-weight: 600;
            color: #34495e;
        }

        .price-badge {
            background: linear-gradient(135deg, #27ae60, #2ecc71);
            color: white;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 0.9rem;
            font-weight: bold;
        }

        .quantity-badge {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: bold;
        }

        .date-cell {
            color: #7f8c8d;
            font-size: 0.9rem;
        }

        @media (max-width: 768px) {
            .container {
                margin: 10px;
                border-radius: 15px;
            }

            .header,
            .actions-bar,
            .table-container {
                padding: 20px;
            }

            .header h1 {
                font-size: 2rem;
            }

            .actions-bar {
                flex-direction: column;
                align-items: stretch;
            }

            .search-container {
                max-width: none;
            }

            .table {
                font-size: 0.9rem;
            }

            .table th,
            .table td {
                padding: 10px;
            }

            .actions-cell {
                flex-direction: column;
                gap: 5px;
            }

            .btn-small {
                padding: 6px 12px;
                font-size: 0.8rem;
            }
        }

        .loading {
            text-align: center;
            padding: 40px;
            color: #7f8c8d;
        }

        .loading::after {
            content: '';
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 2px solid #667eea;
            border-radius: 50%;
            border-top-color: transparent;
            animation: spin 1s ease-in-out infinite;
            margin-left: 10px;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Legacy class names for backward compatibility */
        .bills-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .bills-table thead {
            background: linear-gradient(135deg, #34495e 0%, #2c3e50 100%);
            color: white;
        }

        .bills-table th,
        .bills-table td {
            padding: 15px 20px;
            text-align: left;
            border-bottom: 1px solid #e9ecef;
        }

        .bills-table th {
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.9rem;
        }

        .bills-table tbody tr {
            transition: all 0.3s ease;
        }

        .bills-table tbody tr:hover {
            background: #f8f9fa;
            transform: scale(1.01);
        }

        .bills-table tbody tr:nth-child(even) {
            background: rgba(102, 126, 234, 0.05);
        }

        .no-data {
            text-align: center;
            padding: 60px 20px;
            color: #7f8c8d;
            font-size: 1.1rem;
        }

        .page-title {
            font-size: 2.5rem;
            font-weight: 300;
            margin-bottom: 10px;
        }

        .header-actions {
            padding: 25px 40px;
            background: #f8f9fa;
            border-bottom: 1px solid #e9ecef;
            text-align: center;
        }

        .btn-back {
            background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 25px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-top: 20px;
        }

        .btn-back:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(108, 117, 125, 0.4);
        }

    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <h1>Bill Management</h1>
        <p>Manage your billing records</p>
    </div>

    <div class="actions-bar">

        <a href="bill?action=add" class="btn btn-primary">
            ➕ Add New Bill
        </a>
        <a href="index.jsp" class="btn btn-secondary" style="margin-left:10px;">
            ⬅ Back to Home
        </a>
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
</div>
</body>
</html>
