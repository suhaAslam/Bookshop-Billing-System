package com.pahanaedu.controller;

import com.pahanaedu.model.Item;
import com.pahanaedu.service.ItemService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
@WebServlet("/items")
public class ItemServlet extends HttpServlet{
    private ItemService itemService;

    @Override
    public void init() {
        itemService = new ItemService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "new":
                showNewForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteItem(request, response);
                break;
            case "list":
            default:
                listItems(request, response);
                break;
        }
    }

    private void listItems(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Item> listItems = itemService.getAllItems();
        request.setAttribute("listItems", listItems);
        request.getRequestDispatcher("item-list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("item-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int itemId = Integer.parseInt(request.getParameter("itemId"));
        Item existingItem = itemService.getItemById(itemId);
        request.setAttribute("item", existingItem);
        request.getRequestDispatcher("item-form.jsp").forward(request, response);
    }

    private void deleteItem(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int itemId = Integer.parseInt(request.getParameter("itemId"));
        itemService.deleteItem(itemId);
        response.sendRedirect("items?action=list");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        // Parse form data
        String itemIdStr = request.getParameter("itemId");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String quantityStr = request.getParameter("quantityInStock");

        double price = 0;
        int quantity = 0;

        try {
            price = Double.parseDouble(priceStr);
            quantity = Integer.parseInt(quantityStr);
        } catch (NumberFormatException e) {
            // handle invalid input - for now just redirect back
            response.sendRedirect("items?action=new");
            return;
        }

        Item item;

        if (itemIdStr == null || itemIdStr.isEmpty()) {
            // Create new Item using Builder pattern
            item = new Item.Builder()
                    .setName(name)
                    .setDescription(description)
                    .setPrice(price)
                    .setQuantityInStock(quantity)
                    .build();

            itemService.addItem(item);
        } else {
            int itemId = Integer.parseInt(itemIdStr);
            item = new Item.Builder()
                    .setItemId(itemId)
                    .setName(name)
                    .setDescription(description)
                    .setPrice(price)
                    .setQuantityInStock(quantity)
                    .build();

            itemService.updateItem(item);
        }
        response.sendRedirect("items?action=list");
    }
}
