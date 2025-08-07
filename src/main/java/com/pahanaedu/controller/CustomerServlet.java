package com.pahanaedu.controller;

import com.pahanaedu.model.Customer;
import com.pahanaedu.service.CustomerService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/customer")
public class CustomerServlet extends HttpServlet {

    private final CustomerService customerService = new CustomerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        switch (action != null ? action : "") {
            case "edit":
                int editId = Integer.parseInt(request.getParameter("id"));
                Customer customer = customerService.getCustomerById(editId);
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("editCustomer.jsp").forward(request, response);
                break;

            case "delete":
                int deleteId = Integer.parseInt(request.getParameter("id"));
                customerService.deleteCustomer(deleteId);
                response.sendRedirect("customer?action=view");
                break;

            case "view":
            default:
                List<Customer> list = customerService.getAllCustomers();
                request.setAttribute("customerList", list);
                request.getRequestDispatcher("viewCustomers.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int accNo = Integer.parseInt(request.getParameter("accountNumber"));
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phoneNumber");
        int units = Integer.parseInt(request.getParameter("unitsConsumed"));

        Customer customer = new Customer.CustomerBuilder()
                .setAccountNumber(accNo)
                .setName(name)
                .setAddress(address)
                .setPhoneNumber(phone)
                .setUnitsConsumed(units)
                .build();

        String action = request.getParameter("action");

        if ("update".equalsIgnoreCase(action)) {
            customerService.updateCustomer(customer);
        } else {
            customerService.addCustomer(customer);
        }

        response.sendRedirect("customer?action=view");
    }
}
