package com.pahanaedu.service;
import com.pahanaedu.model.Item;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import java.util.List;
import static org.junit.jupiter.api.Assertions.*;

class ItemServiceTest {
    private ItemService itemService;

    @BeforeEach
    void setUp() {
        itemService = new ItemService();
    }

    void addItem() {
        // Test with valid item
        Item validItem = new Item.Builder()
                .setItemId(17)
                .setName("Test item")
                .setDescription("testing item adding")
                .setPrice(999.99)
                .setQuantityInStock(10)
                .build();

        // Should not throw exception for valid item
        assertDoesNotThrow(() -> itemService.addItem(validItem));


    }

    @Test
    void updateItem() {
        // Test with valid item update
        Item updateItem = new Item.Builder()
                .setItemId(17)
                .setName("Updated test item")
                .setDescription("Updated test item to check updating feature")
                .setPrice(1199.99)
                .setQuantityInStock(15)
                .build();

        assertDoesNotThrow(() -> itemService.updateItem(updateItem));
    }

    void deleteItem() {
        // Test deleting with positive ID
        assertDoesNotThrow(() -> itemService.deleteItem(1));

    }

    @Test
    void getItemById() {
        // Test getting item with positive ID
        assertDoesNotThrow(() -> {
            Item result = itemService.getItemById(13);

        });
    }


    @Test
    void getAllItems() {
        // Test getting all items
        assertDoesNotThrow(() -> {
            List<Item> items = itemService.getAllItems();
            assertNotNull(items, "Should return a list, even if empty");
        });
    }



}