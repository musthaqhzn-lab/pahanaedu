package com.icbt.servlet;

import com.icbt.model.Bill;
import com.icbt.model.BillItem;
import com.icbt.model.Customer;
import com.icbt.model.Item;
import com.icbt.service.BillItemService;
import com.icbt.service.BillService;
import com.icbt.service.CustomerService;
import com.icbt.service.ItemService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/BillServlet")
public class BillServlet extends HttpServlet {
    private final BillService billService = new BillService();
    private final BillItemService billItemService = new BillItemService();
    private final CustomerService customerService = new CustomerService();
    private final ItemService itemService = new ItemService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action != null) {
                switch (action) {
                    case "new":
                        List<Item> items = itemService.getAllItems();
                        List<Customer> customers = customerService.getAllCustomers();
                        request.setAttribute("items", items);
                        request.setAttribute("customers", customers);
                        request.getRequestDispatcher("create-bill.jsp").forward(request, response);
                        break;

                    case "edit":
                        int editId = Integer.parseInt(request.getParameter("id"));
                        Bill billToEdit = billService.getBillById(editId);
                        List<BillItem> billItems = billItemService.getBillItemsByBillId(editId);
                        List<Item> allItems = itemService.getAllItems();
                        List<Customer> allCustomers = customerService.getAllCustomers();

                        request.setAttribute("bill", billToEdit);
                        request.setAttribute("billItems", billItems);
                        request.setAttribute("items", allItems);
                        request.setAttribute("customers", allCustomers);
                        request.getRequestDispatcher("edit-bill.jsp").forward(request, response);
                        break;

                    case "delete":
                        int deleteId = Integer.parseInt(request.getParameter("id"));
                        billItemService.getBillItemsByBillId(deleteId)
                                .forEach(item -> billItemService.deleteBillItem(item.getBillItemId()));
                        billService.deleteBill(deleteId);
                        response.sendRedirect("BillServlet");
                        break;

                    default:
                        response.sendRedirect("error.jsp");
                }
            } else {
                // Default: Show all bills
                List<Bill> bills = billService.getAllBills();
                request.setAttribute("bills", bills);
                request.getRequestDispatcher("billing.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            String formAction = request.getParameter("formAction"); // "create" or "update"

            int accountNumber = Integer.parseInt(request.getParameter("customer_id"));
            String[] itemIds = request.getParameterValues("itemId[]");
            String[] quantities = request.getParameterValues("quantity[]");
            String[] prices = request.getParameterValues("price[]");

            // Debug prints (optional)
            // System.out.println(request.getParameter("customer_id"));
            // System.out.println(java.util.Arrays.toString(itemIds));
            // System.out.println(java.util.Arrays.toString(quantities));
            // System.out.println(java.util.Arrays.toString(prices));

            if (itemIds == null || quantities == null || prices == null
                    || itemIds.length != quantities.length || itemIds.length != prices.length) { // fixed .length
                response.sendRedirect("error.jsp");
                return;
            }

            List<BillItem> billItems = new ArrayList<>();
            double totalAmount = 0;

            for (int i = 0; i < itemIds.length; i++) {
                BillItem item = new BillItem();
                item.setItemId(Integer.parseInt(itemIds[i]));
                item.setQuantity(Integer.parseInt(quantities[i]));
                item.setPrice(Double.parseDouble(prices[i]));
                totalAmount += item.getQuantity() * item.getPrice();
                billItems.add(item);
            }

            if ("update".equals(formAction)) {
                int billId = Integer.parseInt(request.getParameter("billId"));
                Bill bill = new Bill();
                bill.setBillId(billId);
                bill.setAccountNumber(accountNumber);
                bill.setTotalAmount(totalAmount);
                bill.setBillDate(new Date());

                boolean updated = billService.updateBill(bill);
                if (updated) {
                    // Remove old bill items
                    billItemService.getBillItemsByBillId(billId)
                            .forEach(item -> billItemService.deleteBillItem(item.getBillItemId()));

                    // Save new items
                    for (BillItem item : billItems) {
                        item.setBillId(billId);
                    }
                    billItemService.saveBillItems(billItems);

                    response.sendRedirect("BillServlet");
                } else {
                    response.sendRedirect("error.jsp");
                }
            } else {
                // Add new bill
                Bill bill = new Bill();
                bill.setAccountNumber(accountNumber);
                bill.setTotalAmount(totalAmount);
                bill.setBillDate(new Date());

                int billId = billService.addBill(bill);

                if (billId > 0) {
                    for (BillItem item : billItems) {
                        item.setBillId(billId);
                    }
                    billItemService.saveBillItems(billItems);

                    Bill newBill = billService.getBillById(billId); // fetch the inserted bill
                    List<BillItem> newBillItems = billItemService.getBillItemsByBillId(billId);
                    Customer customer = customerService.getCustomerById(bill.getAccountNumber());
                    List<Item> items = itemService.getAllItems();

                    request.setAttribute("bill", newBill);
                    request.setAttribute("billItems", newBillItems);
                    request.setAttribute("customer", customer);
                    request.setAttribute("items", items);

                    request.getRequestDispatcher("bill-summary.jsp").forward(request, response);
                } else {
                    response.sendRedirect("error.jsp");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
