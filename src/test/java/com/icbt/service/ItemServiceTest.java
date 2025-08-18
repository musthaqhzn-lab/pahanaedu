package com.icbt.service;

import com.icbt.model.Item;
import org.junit.jupiter.api.*;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class ItemServiceTest {

    private static ItemService itemService;
    private static int testItemId; // Will hold the ID of the item created during the test

    @BeforeAll
    static void setup() {
        itemService = new ItemService();
    }

    @Test
    @Order(1)
    void testRegisterItem() {
        Item item = new Item();
        item.setItem_name("Test Item");
        item.setItem_description("Test Description");
        item.setUnit_price(String.valueOf(99.99));
        item.setStock_quantity(String.valueOf(50.));

        boolean result = itemService.registerItem(item);
        assertTrue(result, "Item should be registered successfully");

        // Fetch the item list to get the ID of the last inserted item
        List<Item> itemList = itemService.getAllItems();
        Item lastItem = itemList.get(itemList.size() - 1);
        testItemId = lastItem.getItem_id();
    }

    @Test
    @Order(2)
    void testUpdateItem() {
        Item updatedItem = new Item();
        updatedItem.setItem_id(testItemId);
        updatedItem.setItem_name("Updated Item Name");
        updatedItem.setItem_description("Updated Description");
        updatedItem.setUnit_price(String.valueOf(199.99));
        updatedItem.setStock_quantity(String.valueOf(25));

        boolean result = itemService.updateItem(updatedItem);
        assertTrue(result, "Item should be updated successfully");
    }

    @Test
    @Order(3)
    void testGetAllItems() {
        List<Item> items = itemService.getAllItems();
        assertNotNull(items, "Item list should not be null");
        assertFalse(items.isEmpty(), "Item list should not be empty");
    }

    @Test
    @Order(4)
    void testDeleteItem() {
        boolean result = itemService.deleteItem(testItemId);
        assertTrue(result, "Item should be deleted successfully");

        // Verify it is actually deleted
        List<Item> items = itemService.getAllItems();
        boolean itemExists = items.stream().anyMatch(item -> item.getItem_id() == testItemId);
        assertFalse(itemExists, "Deleted item should not exist in the list");
    }
}
