package com.icbt.service;

import com.icbt.model.Customer;
import org.junit.jupiter.api.*;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class CustomerServiceTest {

    private static CustomerService customerService;
    private static int testAccountNumber; // For tracking the test customer

    @BeforeAll
    static void setup() {
        customerService = new CustomerService();
    }

    @Test
    @Order(1)
    void testRegisterCustomer() {
        Customer customer = new Customer();
        customer.setName("Test Customer");
        customer.setTelephone("0771234567");
        customer.setAddress("Test Address");

        boolean result = customerService.registerCustomer(customer);
        assertTrue(result, "Customer should be registered");

        // Get all customers and find the newly inserted one
        List<Customer> customerList = customerService.getAllCustomers();
        assertFalse(customerList.isEmpty(), "Customer list should not be empty");

        Customer lastCustomer = customerList.getLast();
        testAccountNumber = lastCustomer.getAccountNumber(); // Store ID for later tests
    }

    @Test
    @Order(2)
    void testUpdateCustomer() {
        Customer updated = new Customer();
        updated.setAccountNumber(testAccountNumber);
        updated.setName("Updated Name");
        updated.setTelephone("0712345678");
        updated.setAddress("Updated Address");

        boolean result = customerService.updateCustomer(updated);
        assertTrue(result, "Customer should be updated");
    }

    @Test
    @Order(3)
    void testGetAllCustomers() {
        List<Customer> customers = customerService.getAllCustomers();
        assertNotNull(customers, "Customer list should not be null");
        assertTrue(customers.stream().anyMatch(c -> c.getAccountNumber() == testAccountNumber),
                "Inserted test customer should be in the list");
    }

    @Test
    @Order(4)
    void testDeleteCustomer() {
        boolean result = customerService.deleteCustomer(testAccountNumber);
        assertTrue(result, "Customer should be deleted");

        List<Customer> customers = customerService.getAllCustomers();
        boolean stillExists = customers.stream()
                .anyMatch(c -> c.getAccountNumber() == testAccountNumber);
        assertFalse(stillExists, "Deleted customer should not exist");
    }
}
