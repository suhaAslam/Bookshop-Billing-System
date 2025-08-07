package com.pahanaedu.controller;
import com.pahanaedu.model.customer;
import com.pahanaedu.service.CustomerService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
@WebServlet("/customer")
public class CustomerServlet  extends HttpServlet {
    private CustomerService service = new CustomerService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "add":
                customer newCust = new customer();
                newCust.setName(request.getParameter("name"));
                newCust.setPhone(request.getParameter("phone"));
                newCust.setAddress(request.getParameter("address"));
                service.addCustomer(newCust);
                break;

            case "update":
                customer updateCust = new customer();
                updateCust.setId(Integer.parseInt(request.getParameter("id")));
                updateCust.setName(request.getParameter("name"));
                updateCust.setPhone(request.getParameter("phone"));
                updateCust.setAddress(request.getParameter("address"));
                service.updateCustomer(updateCust);
                break;

            case "delete":
                int deleteId = Integer.parseInt(request.getParameter("id"));
                service.deleteCustomer(deleteId);
                break;
        }

        response.sendRedirect("viewCustomers.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<customer> customers = service.getAllCustomers();
        request.setAttribute("customerList", customers);
        RequestDispatcher dispatcher = request.getRequestDispatcher("viewCustomers.jsp");
        dispatcher.forward(request, response);
    }


}
