package com.icbt.service;

import com.icbt.model.BillItem;
import org.junit.jupiter.api.*;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class BillItemServiceTest {

    private static BillItemService billItemService;
    private static int testBillItemId;
    private static int validBillId = 1;  // 🔁 Replace with an actual bill ID
    private static int validItemId = 1;  // 🔁 Replace with an actual item ID

    @BeforeAll
    static void setup() {
        billItemService = new BillItemService();
    }

    @Test
    @Order(1)
    void testSaveBillItems() {
        List<BillItem> items = new ArrayList<>();
        BillItem item = new BillItem();
        item.setBillId(validBillId);
        item.setItemId(validItemId);
        item.setQuantity(2);
        item.setPrice(500.0);

        items.add(item);
        billItemService.saveBillItems(items);

        // Retrieve the latest inserted item to get the billItemId
        List<BillItem> allItems = billItemService.getAllBillItems();
        BillItem last = allItems.get(allItems.size() - 1);
        testBillItemId = last.getBillItemId();

        assertEquals(validBillId, last.getBillId(), "Inserted item bill ID should match");
    }

    @Test
    @Order(2)
    void testUpdateBillItem() {
        BillItem updatedItem = new BillItem();
        updatedItem.setBillItemId(testBillItemId);
        updatedItem.setBillId(validBillId);
        updatedItem.setItemId(validItemId);
        updatedItem.setQuantity(3);
        updatedItem.setPrice(900.0);

        boolean result = billItemService.updateBillItem(updatedItem);
        assertTrue(result, "Bill item should be updated");

        List<BillItem> items = billItemService.getAllBillItems();
        BillItem updated = items.stream()
                .filter(i -> i.getBillItemId() == testBillItemId)
                .findFirst()
                .orElse(null);

        assertNotNull(updated);
        assertEquals(3, updated.getQuantity(), "Updated quantity should be 3");
    }

    @Test
    @Order(3)
    void testGetBillItemsByBillId() {
        List<BillItem> items = billItemService.getBillItemsByBillId(validBillId);
        assertNotNull(items, "Items list should not be null");
        assertTrue(items.stream().anyMatch(i -> i.getBillItemId() == testBillItemId),
                "Should find the test item by bill ID");
    }

    @Test
    @Order(4)
    void testDeleteBillItem() {
        boolean result = billItemService.deleteBillItem(testBillItemId);
        assertTrue(result, "Bill item should be deleted");

        List<BillItem> items = billItemService.getAllBillItems();
        boolean exists = items.stream().anyMatch(i -> i.getBillItemId() == testBillItemId);
        assertFalse(exists, "Deleted item should not exist anymore");
    }
}
