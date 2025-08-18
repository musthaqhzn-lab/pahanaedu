package com.icbt.service;

import com.icbt.model.Bill;
import org.junit.jupiter.api.*;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class BillServiceTest {

    private static BillService billService;
    private static int testBillId;

    @BeforeAll
    static void setup() {
        billService = new BillService();
    }

    @Test
    @Order(1)
    void testAddBill() {
        Bill bill = new Bill();
        bill.setAccountNumber(1);           // Replace with a valid test accountNumber
        bill.setTotalAmount(500.0);
        bill.setBillDate(new java.sql.Date(System.currentTimeMillis()));

        testBillId = billService.addBill(bill);
        assertTrue(testBillId > 0, "Bill ID should be greater than 0 after insertion");
    }

    @Test
    @Order(2)
    void testGetBillById() {
        Bill bill = billService.getBillById(testBillId);
        assertNotNull(bill, "Bill should not be null");
        assertEquals(500.0, bill.getTotalAmount(), "Total amount should match");
        assertEquals(1, bill.getAccountNumber(), "Account number should match");
    }

    @Test
    @Order(3)
    void testUpdateBill() {
        Bill updatedBill = new Bill();
        updatedBill.setBillId(testBillId);
        updatedBill.setAccountNumber(1);
        updatedBill.setTotalAmount(750.0);  // Updated amount
        updatedBill.setBillDate(new java.sql.Date(System.currentTimeMillis()));

        boolean result = billService.updateBill(updatedBill);
        assertTrue(result, "Bill should be updated");

        Bill updated = billService.getBillById(testBillId);
        assertEquals(750.0, updated.getTotalAmount(), "Updated amount should be reflected");
    }

    @Test
    @Order(4)
    void testGetAllBills() {
        List<Bill> bills = billService.getAllBills();
        assertNotNull(bills, "Bill list should not be null");
        assertTrue(bills.stream().anyMatch(b -> b.getBillId() == testBillId),
                "Inserted test bill should be in the list");
    }

    @Test
    @Order(5)
    void testDeleteBill() {
        boolean result = billService.deleteBill(testBillId);
        assertTrue(result, "Bill should be deleted");

        Bill deletedBill = billService.getBillById(testBillId);
        assertNull(deletedBill, "Deleted bill should not be found");
    }
}
