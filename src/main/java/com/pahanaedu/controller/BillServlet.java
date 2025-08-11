package com.pahanaedu.controller;

import com.pahanaedu.dao.BillDAO;
import com.pahanaedu.dao.BillDAOImpl;
import com.pahanaedu.model.Bill;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Date;
import java.util.List;


@WebServlet("/bill")
public class BillServlet extends HttpServlet {
    private BillDAO billDAO = new BillDAOImpl();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) action = "list";

        switch (action) {
            case "new":
                request.getRequestDispatcher("addBill.jsp").forward(request, response);
                break;
            case "list":
                List<Bill> bills = billDAO.getAllBills();
                request.setAttribute("billList", bills);
                request.getRequestDispatcher("viewBills.jsp").forward(request, response);
                break;
            case "delete":
                int id = Integer.parseInt(request.getParameter("id"));
                billDAO.deleteBill(id);
                response.sendRedirect("bill?action=list");
                break;
            default:
                response.sendRedirect("bill?action=list");
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));

        Bill bill = new Bill();
        bill.setCustomerId(customerId);
        bill.setBillDate(new Date());
        bill.setTotalAmount(totalAmount);

        billDAO.addBill(bill);
        response.sendRedirect("bill?action=list");
    }
}
