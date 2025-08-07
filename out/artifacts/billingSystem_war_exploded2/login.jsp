<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 6/08/2025
  Time: 6:36 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Pahana Edu - Login</title>
  </head>
  <body>
  <h2>Login to Pahana Edu Bookshop System</h2>
  <form action="LoginServlet" method="post">
    <label>Username:</label>
    <input type="text" name="username" required /><br/><br/>
    <label>Password:</label>
    <input type="password" name="password" required /><br/><br/>
    <button type="submit">Login</button>
  </form>
  <br/>
  <p style="color:red;">
    <%
      String errorMsg = (String) request.getAttribute("errorMsg");
      if (errorMsg != null) { out.print(errorMsg); }
    %>
  </p>
  </body>
</html>
