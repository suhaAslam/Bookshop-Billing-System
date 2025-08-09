<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Pahana Edu</title>
    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --primary-color: #2c3e50;
            --secondary-color: #34495e;
            --accent-color: #3498db;
            --success-color: #27ae60;
            --warning-color: #f39c12;
            --danger-color: #e74c3c;
            --light-gray: #ecf0f1;
            --dark-gray: #7f8c8d;
            --white: #ffffff;
            --shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            --border-radius: 12px;
            --transition: all 0.3s ease;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: var(--primary-color);
            line-height: 1.6;
        }

        /* Header Styles */
        .header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: var(--white);
            padding: 2rem 0;
            text-align: center;
            position: relative;
            overflow: hidden;
            box-shadow: var(--shadow);
        }

        .header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 50%);
            animation: float 8s ease-in-out infinite;
        }

        .header h1 {
            font-size: 2.5rem;
            font-weight: 300;
            margin-bottom: 0.5rem;
            letter-spacing: 1px;
            position: relative;
            z-index: 2;
        }

        .header .subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
            position: relative;
            z-index: 2;
        }

        .header-help-btn {
            position: absolute;
            top: 1rem;
            right: 2rem;
            background: rgba(255, 255, 255, 0.2);
            border: 2px solid rgba(255, 255, 255, 0.3);
            color: var(--white);
            padding: 0.5rem 1rem;
            border-radius: 25px;
            text-decoration: none;
            font-size: 0.9rem;
            transition: var(--transition);
            backdrop-filter: blur(10px);
            z-index: 3;
        }

        .header-help-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            border-color: rgba(255, 255, 255, 0.5);
            transform: translateY(-2px);
        }

        /* Navigation Styles */
        .navigation {
            background: var(--white);
            padding: 0;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .nav-container {
            max-width: 1300px;
            margin: 0 auto;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 2rem;
            padding: 1rem 2rem;
            flex-wrap: wrap;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            text-decoration: none;
            color: var(--primary-color);
            font-weight: 500;
            border-radius: 25px;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }

        .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(52, 152, 219, 0.2), transparent);
            transition: left 0.5s;
        }

        .nav-link:hover::before {
            left: 100%;
        }

        .nav-link:hover {
            background: linear-gradient(135deg, var(--accent-color), #2980b9);
            color: var(--white);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
        }

        .nav-link.customers:hover { background: linear-gradient(135deg, var(--success-color), #2ecc71); }
        .nav-link.items:hover { background: linear-gradient(135deg, var(--warning-color), #e67e22); }
        .nav-link.billing:hover { background: linear-gradient(135deg, #9b59b6, #8e44ad); }

        .logout-form {
            margin-left: auto;
        }

        .logout-btn {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            background: linear-gradient(135deg, var(--danger-color), #c0392b);
            color: var(--white);
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 25px;
            font-weight: 500;
            cursor: pointer;
            transition: var(--transition);
            font-size: 0.95rem;
        }

        .logout-btn:hover {
            background: linear-gradient(135deg, #c0392b, #a93226);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
        }

        /* Main Container */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 3rem 2rem 6rem;
        }

        /* Welcome Section */
        .welcome-section {
            background: var(--white);
            border-radius: var(--border-radius);
            padding: 3rem;
            text-align: center;
            box-shadow: var(--shadow);
            margin-bottom: 3rem;
            position: relative;
            overflow: hidden;
        }

        .welcome-section::before {
            content: '📚';
            position: absolute;
            top: -20px;
            right: -20px;
            font-size: 8rem;
            opacity: 0.05;
            transform: rotate(15deg);
        }

        .welcome-section h2 {
            font-size: 2.2rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
            font-weight: 300;
        }

        .welcome-section p {
            color: var(--dark-gray);
            font-size: 1.1rem;
            margin-bottom: 1rem;
            line-height: 1.8;
        }


        .actions-section {
            margin-bottom: 3rem;
        }

        .section-title {
            text-align: center;
            font-size: 2rem;
            color: var(--white);
            margin-bottom: 2rem;
            font-weight: 300;
        }

        .action-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
        }

        .action-card {
            background: var(--white);
            border-radius: var(--border-radius);
            padding: 2.5rem 2rem;
            text-align: center;
            box-shadow: var(--shadow);
            transition: var(--transition);
            text-decoration: none;
            color: var(--primary-color);
            position: relative;
            overflow: hidden;
        }

        .action-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
            transition: left 0.6s;
        }

        .action-card:hover::before {
            left: 100%;
        }

        .action-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
        }

        .action-icon {
            font-size: 4rem;
            margin-bottom: 1.5rem;
            display: block;
            filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.1));
        }

        .action-title {
            font-size: 1.4rem;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .action-description {
            color: var(--dark-gray);
            line-height: 1.6;
        }

        /* Footer */
        .footer {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: var(--white);
            text-align: center;
            padding: 2rem;
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            z-index: 100;
            box-shadow: 0 -2px 15px rgba(0, 0, 0, 0.1);
        }

        .footer p {
            margin: 0;
            opacity: 0.9;
        }

        /* Animations */
        @keyframes float {
            0%, 100% { transform: translate(0, 0) rotate(0deg); }
            25% { transform: translate(10px, -15px) rotate(1deg); }
            50% { transform: translate(-5px, -10px) rotate(-1deg); }
            75% { transform: translate(15px, -5px) rotate(0.5deg); }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Page Animation */
        .container > * {
            animation: fadeInUp 0.6s ease-out forwards;
        }

        .container > *:nth-child(2) { animation-delay: 0.1s; }
        .container > *:nth-child(3) { animation-delay: 0.2s; }
        .container > *:nth-child(4) { animation-delay: 0.3s; }

        /* Responsive Design */
        @media (max-width: 768px) {
            .header h1 {
                font-size: 2rem;
            }

            .nav-container {
                flex-direction: column;
                gap: 1rem;
                padding: 1rem;
            }

            .logout-form {
                margin-left: 0;
            }

            .container {
                padding: 2rem 1rem 6rem;
            }

            .welcome-section {
                padding: 2rem 1.5rem;
            }

            .stats-section {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }

            .action-cards {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }

            .section-title {
                font-size: 1.6rem;
            }
        }

        /* Loading Animation */
        .loading {
            position: relative;
            overflow: hidden;
        }

        .loading::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
            animation: loading 1.5s infinite;
        }

        @keyframes loading {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        /* Utility Classes */
        .text-center { text-align: center; }
        .mb-2 { margin-bottom: 2rem; }
        .mt-2 { margin-top: 2rem; }
    </style>
    </style>
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
        <p>Streamline your bookshop operations with our comprehensive management system. Access all your administrative tools from this central hub.</p>
        <p>Monitor your inventory, manage customer relationships, and track your sales performance all in one place.</p>
    </div>



    <div class="actions-section">
        <h2 class="section-title">functionalities</h2>
        <div class="action-cards">
            <a href="customer?action=view" class="action-card">
                <span class="action-icon">👥</span>
                <h3 class="action-title">Customer Management</h3>
                <p class="action-description">Add, edit, and manage customer information. View customer purchase history and contact details.</p>
            </a>

            <a href="items?action=list" class="action-card">
                <span class="action-icon">📦</span>
                <h3 class="action-title">Inventory Control</h3>
                <p class="action-description">Manage your book inventory, update stock levels, and track item availability.</p>
            </a>

            <a href="createBill.jsp" class="action-card">
                <span class="action-icon">🧾</span>
                <h3 class="action-title">Create New Bill</h3>
                <p class="action-description">Generate new bills for customers, calculate totals, and process transactions.</p>
            </a>

            <a href="viewBills.jsp" class="action-card">
                <span class="action-icon">📋</span>
                <h3 class="action-title">View All Bills</h3>
                <p class="action-description">Review past transactions, search bills, and generate reports for analysis.</p>
            </a>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer">
    <p>&copy; 2025 Pahana Edu Bookshop | Professional Billing System | Developed for Academic Excellence</p>
</footer>


</body>
</html>
