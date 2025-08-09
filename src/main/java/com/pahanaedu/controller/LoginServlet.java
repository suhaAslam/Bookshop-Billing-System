package com.pahanaedu.controller;
import com.pahanaedu.dao.UserDAO;
import com.pahanaedu.model.User;
import com.pahanaedu.util.HashUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
@WebServlet("/login")
public class LoginServlet  extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        System.out.println("Entered username: " + username);
        System.out.println("Entered password (plain): " + password);

        String hashedPassword = HashUtil.hashPassword(password);
        User user = new User(username, hashedPassword);



        UserDAO dao = new UserDAO();


        if (dao.validateUser(user)) {
            // Login successful - redirect to dashboard or home page
            response.sendRedirect("index.jsp");


        } else {
            // Login failed - show error message
            request.setAttribute("error", "Invalid username or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

}
