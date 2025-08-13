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
        System.out.println("GET request received with action: " + action);

        switch (action != null ? action : "") {
            case "add":
                // Load add bill form with dropdown data
                try {
                    List<Customer> customers = billService.getCustomers();
                    List<Item> items = billService.getItems();

                    System.out.println("Customers loaded: " + (customers != null ? customers.size() : 0));
                    System.out.println("Items loaded: " + (items != null ? items.size() : 0));

                    request.setAttribute("customers", customers);
                    request.setAttribute("items", items);
                    request.getRequestDispatcher("addBill.jsp").forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
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
        System.out.println("POST request received with action: " + action);

        if ("create".equals(action)) {
            try {
                String customerIdStr = request.getParameter("customer_id");
                String itemIdStr = request.getParameter("item_id");
                String quantityStr = request.getParameter("quantity");

                System.out.println("Form parameters received:");
                System.out.println("customer_id: " + customerIdStr);
                System.out.println("item_id: " + itemIdStr);
                System.out.println("quantity: " + quantityStr);

                int customerId = Integer.parseInt(request.getParameter("customer_id"));
                int itemId = Integer.parseInt(request.getParameter("item_id"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));

                // Validate quantity
                if (quantity <= 0) {
                    request.setAttribute("error", "Quantity must be greater than zero.");
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
                System.out.println("Bill created successfully!");

                response.sendRedirect("bill?action=view");
            } catch (NumberFormatException e) {
                System.err.println("NumberFormatException: " + e.getMessage());
                request.setAttribute("error", "Invalid input data.");
                loadDropdownData(request);
                request.getRequestDispatcher("addBill.jsp").forward(request, response);
            } catch (Exception e) {
                System.err.println("Exception in bill creation: " + e.getMessage());
                e.printStackTrace();
                request.setAttribute("error", "Error creating bill: " + e.getMessage());
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