package com.pahanaedu.controller;

import com.pahanaedu.model.Bill;
import com.pahanaedu.model.Customer;
import com.pahanaedu.model.Item;
import com.pahanaedu.service.BillService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/bill")
public class BillServlet extends HttpServlet {
    private final BillService billService = new BillService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");


        //adding ites and customers to have in the dropdown
        switch (action != null ? action : "") {
            case "add":
                try {
                    List<Customer> customers = billService.getCustomers();
                    List<Item> items = billService.getItems();

                    //this prints the customers and items added
                    System.out.println("Customers loaded: " + (customers != null ? customers.size() : 0));
                    System.out.println("Items loaded: " + (items != null ? items.size() : 0));

                    request.setAttribute("customers", customers);
                    request.setAttribute("items", items);
                    request.getRequestDispatcher("addBill.jsp").forward(request, response);
                } catch (Exception e) {
                    request.setAttribute("error", "Error loading form data: " + e.getMessage());
                    request.getRequestDispatcher("addBill.jsp").forward(request, response);
                }
                break;

            case "delete":
                try {
                    int deleteId = Integer.parseInt(request.getParameter("id"));
                    billService.deleteBill(deleteId);
                    response.sendRedirect("bill?action=view");
                } catch (NumberFormatException e) {
                    response.sendRedirect("bill?action=view");
                }
                break;

            case "view":
            default:
                List<Bill> bills = billService.getAllBills();
                //this print the no of bills added
                System.out.println("Bills loaded: " + (bills != null ? bills.size() : 0));
                request.setAttribute("billList", bills);
                request.getRequestDispatcher("viewBills.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("create".equalsIgnoreCase(action)) {
            try {

//


                int customerId = Integer.parseInt(request.getParameter("customer_id"));
                int itemId = Integer.parseInt(request.getParameter("item_id"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));

                // check the quantity
                if (quantity <= 0) {
                    request.setAttribute("error", "error occured .");
                    loadDropdownData(request);
                    request.getRequestDispatcher("addBill.jsp").forward(request, response);
                    return;
                }

                // Get item to calculate price
                Item item = billService.getItemById(itemId);
                if (item == null) {
                    request.setAttribute("error", "Selected item not found.");
                    loadDropdownData(request);
                    request.getRequestDispatcher("addBill.jsp").forward(request, response);
                    return;
                }

                BigDecimal price = BigDecimal.valueOf(item.getPrice());
                BigDecimal totalPrice = price.multiply(BigDecimal.valueOf(quantity));

                Bill bill = new Bill();
                bill.setCustomerId(customerId);
                bill.setItemId(itemId);
                bill.setQuantity(quantity);
                bill.setTotalPrice(totalPrice);


                billService.addBill(bill);

                response.sendRedirect("bill?action=view");
            } catch (NumberFormatException e) {

                request.setAttribute("error", "Invalid input data.");

                loadDropdownData(request);
                request.getRequestDispatcher("addBill.jsp").forward(request, response);
            } catch (Exception e) {

                request.setAttribute("error", "Error creating bill:");
                loadDropdownData(request);
                request.getRequestDispatcher("addBill.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("bill?action=view");
        }
    }

    private void loadDropdownData(HttpServletRequest request) {
        try {
            List<Customer> customers = billService.getCustomers();
            List<Item> items = billService.getItems();
            request.setAttribute("customers", customers);
            request.setAttribute("items", items);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}