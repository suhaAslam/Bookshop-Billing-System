<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Pahana Edu</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/index.css">
</head>
<body>
<!-- Header -->
<header class="header">
    <h1>📚 Pahana Edu Bookshop</h1>
    <p class="subtitle">Comprehensive Billing & Inventory Management System</p>
</header>

<!-- Navigation -->
<nav class="navigation">
    <div class="nav-container">
        <a href="customer?action=view" class="nav-link customers">
            <span>👥</span>
            <span>Manage Customers</span>
        </a>
        <a href="items?action=list" class="nav-link items">
            <span>📦</span>
            <span>Manage Items</span>
        </a>
        <a href="createBill.jsp" class="nav-link billing">
            <span>🧾</span>
            <span>Create Bill</span>
        </a>
        <a href="viewBills.jsp" class="nav-link billing">
            <span>📋</span>
            <span>View Bills</span>
        </a>

        <a href="help.jsp" class="nav-link help">
            <span>❓</span>
            <span>Help & Guide</span>
        </a>

        <form action="login.jsp" method="post" class="logout-form">
            <button type="submit" class="logout-btn" onclick="return confirmLogout()">
                <span>🚪</span>
                <span>Logout</span>
            </button>
        </form>
    </div>
</nav>
<!-- Main Container -->
<div class="container">

    <div class="welcome-section">
        <h2>Welcome to Admin Dashboard</h2>
        <p>improve your bookshop management with this system. Access all your administrative tools from this central hub.</p>
        <p>Monitor your inventory, manage customer relationships, and generate bills all in one place.</p>
    </div>



    <div class="actions-section">
        <h2 class="section-title">Services</h2>
        <div class="action-cards">
            <a href="customer?action=view" class="action-card">
                <span class="action-icon">👥</span>
                <h3 class="action-title">Customer Management</h3>
                <p class="action-description">Add, edit, and manage customer information. View customer purchase history and contact details.</p>
            </a>

            <a href="items?action=list" class="action-card">
                <span class="action-icon">📦</span>
                <h3 class="action-title">Inventory Control</h3>
                <p class="action-description">Manage your book inventory.</p>
            </a>

            <a href="createBill.jsp" class="action-card">
                <span class="action-icon">🧾</span>
                <h3 class="action-title">Create New Bill</h3>
                <p class="action-description">Generate new bills for customers, calculate totals, and process transactions.</p>
            </a>

            <a href="viewBills.jsp" class="action-card">
                <span class="action-icon">📋</span>
                <h3 class="action-title">View All Bills</h3>
                <p class="action-description">Review past transactions and search bills.</p>
            </a>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer">
    <p>&copy; 2025 Pahana Edu Bookshop | Billing System | Developed for Academic purposes</p>
</footer>


</body>
</html>
