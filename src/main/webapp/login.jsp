
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pahana Edu - Login</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">

</head>
<body>

<div class="login-container">
    <div class="brand-section">
        <div class="logo">
            <i class="fas fa-book-open"></i>
        </div>
        <h2 class="brand-title">Login</h2>
        <h1 class="brand-title">Pahana Edu</h1>
        <p class="brand-subtitle">Leading Bookshop Management System</p>
    </div>

    <form action="login" method="post" id="loginForm">
        <div class="form-group">
            <label class="form-label" for="username">Username</label>
            <div class="input-wrapper">
                <input
                        type="text"
                        id="username"
                        name="username"
                        class="form-input"
                        placeholder="Enter your username"
                        required
                        autocomplete="username"
                />
                <i class="fas fa-user input-icon"></i>
            </div>
        </div>

        <div class="form-group">
            <label class="form-label" for="password">Password</label>
            <div class="input-wrapper">
                <input
                        type="password"
                        id="password"
                        name="password"
                        class="form-input"
                        placeholder="Enter your password"
                        required
                        autocomplete="current-password"
                />
                <i class="fas fa-lock input-icon"></i>
            </div>
        </div>

        <button type="submit" class="login-button" id="loginBtn">
            <span>Sign In</span>
        </button>
    </form>

<% if (request.getAttribute("error") != null) { %>
<p style="color:red;"><%= request.getAttribute("error") %></p>
<% } %>
    <div class="footer-text">
        <p>© 2025 Pahana Edu Bookshop. All rights reserved.</p>
        <p><a href="#help">Need help?</a> Contact support</p>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/login.js"></script>

</body>
</html>
