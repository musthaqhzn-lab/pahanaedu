<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.icbt.model.*" %>
<%
    Bill bill = (Bill) request.getAttribute("bill");
    List<BillItem> billItems = (List<BillItem>) request.getAttribute("billItems");
    List<Item> items = (List<Item>) request.getAttribute("items");
    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="light">
<head>
    <meta charset="UTF-8" />
    <title>Edit Bill | Pahana Edu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-body-tertiary d-flex flex-column min-vh-100">

<!-- Top bar -->
<nav class="navbar navbar-expand-lg bg-body shadow-sm">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center gap-2" href="main-menu.jsp">
            <i class="bi bi-journal-check"></i>
            <span class="fw-semibold">Pahana Edu Billing</span>
        </a>
    </div>
</nav>

<main class="container py-5 flex-grow-1">
    <header class="text-center mb-4">
        <h1 class="h4 fw-bold mb-1">Edit Bill</h1>
        <p class="text-body-secondary mb-0">Bill ID: <span class="badge text-bg-secondary">#<%= bill.getBillId() %></span></p>
    </header>

    <div class="card border-0 shadow-lg rounded-4">
        <div class="card-body p-4 p-md-5">

            <form action="BillServlet" method="post" id="editBillForm" class="needs-validation" novalidate>
                <input type="hidden" name="formAction" value="update" />
                <input type="hidden" name="billId" value="<%= bill.getBillId() %>" />

                <!-- Customer -->
                <div class="mb-4">
                    <label for="customer_id" class="form-label"><i class="bi bi-person-circle me-1"></i> Account Number</label>
                    <select name="customer_id" id="customer_id" class="form-select" required>
                        <% if (customers != null) {
                            for (Customer c : customers) { %>
                        <option value="<%= c.getAccountNumber() %>"
                                <%= (c.getAccountNumber() == bill.getAccountNumber()) ? "selected" : "" %>>
                            <%= c.getAccountNumber() %> - <%= c.getName() %>
                        </option>
                        <% } } %>
                    </select>
                    <div class="invalid-feedback">Please select an account number.</div>
                </div>

                <!-- Items table header + add button -->
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <h2 class="h6 fw-semibold mb-0">Items</h2>
                    <button type="button" class="btn btn-sm btn-outline-primary" onclick="addRow()">
                        <i class="bi bi-plus-lg me-1"></i>Add Item
                    </button>
                </div>

                <div class="table-responsive">
                    <table class="table table-striped table-hover align-middle mb-3" id="itemTable">
                        <thead class="table-light">
                        <tr>
                            <th style="min-width: 240px;">Item</th>
                            <th class="text-end" style="width: 140px;">Quantity</th>
                            <th class="text-end" style="width: 180px;">Unit Price (LKR)</th>
                            <th class="text-end" style="width: 160px;">Line Total</th>
                            <th class="text-center" style="width: 100px;">Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <% if (billItems != null) {
                            for (BillItem bi : billItems) { %>
                        <tr>
                            <td>
                                <select name="itemId[]" class="form-select" onchange="setPrice(this); calcRow(this);" required>
                                    <option value="">Select Item</option>
                                    <% if (items != null) {
                                        for (Item it : items) { %>
                                    <option value="<%= it.getItem_id() %>" data-price="<%= it.getUnit_price() %>"
                                            <%= (it.getItem_id() == bi.getItemId()) ? "selected" : "" %>>
                                        <%= it.getItem_name() %>
                                    </option>
                                    <% } } %>
                                </select>
                                <div class="invalid-feedback">Please choose an item.</div>
                            </td>
                            <td>
                                <input type="number" name="quantity[]" class="form-control text-end"
                                       min="1" value="<%= bi.getQuantity() %>" required oninput="calcRow(this)">
                                <div class="invalid-feedback">Enter a quantity of at least 1.</div>
                            </td>
                            <td>
                                <div class="input-group">
                                    <span class="input-group-text">LKR</span>
                                    <input type="number" name="price[]" class="form-control text-end"
                                           step="0.01" min="0" value="<%= bi.getPrice() %>" required oninput="calcRow(this)">
                                </div>
                                <div class="invalid-feedback">Enter a valid price.</div>
                            </td>
                            <td class="text-end fw-semibold">
                                <span class="line-total">0.00</span>
                            </td>
                            <td class="text-center">
                                <button type="button" class="btn btn-sm btn-outline-danger" onclick="removeRow(this)">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </td>
                        </tr>
                        <% } } %>
                        </tbody>
                        <tfoot class="table-light">
                        <tr>
                            <th colspan="3" class="text-end">Grand Total (LKR)</th>
                            <th class="text-end"><span id="grandTotal">0.00</span></th>
                            <th></th>
                        </tr>
                        </tfoot>
                    </table>
                </div>

                <div class="d-flex justify-content-between align-items-center">
                    <a href="BillServlet" class="btn btn-outline-secondary">← Cancel</a>
                    <button type="submit" id="submitBtn" class="btn btn-primary d-flex align-items-center gap-2">
                        <span class="btn-text">Update Bill</span>
                        <span class="spinner-border spinner-border-sm d-none" role="status" aria-hidden="true"></span>
                    </button>
                </div>
            </form>

        </div>
    </div>

    <p class="text-center text-body-secondary small mt-4 mb-0">
        &copy; 2025 Pahana Edu Bookshop System
    </p>
</main>

<!-- Row template -->
<template id="item-row-template">
    <tr>
        <td>
            <select name="itemId[]" class="form-select" onchange="setPrice(this); calcRow(this);" required>
                <option value="">Select Item</option>
                <%
                    List<Item> items2 = (List<Item>) request.getAttribute("items");
                    if (items2 != null) {
                        for (Item it2 : items2) {
                %>
                <option value="<%= it2.getItem_id() %>" data-price="<%= it2.getUnit_price() %>">
                    <%= it2.getItem_name() %>
                </option>
                <%  } } %>
            </select>
            <div class="invalid-feedback">Please choose an item.</div>
        </td>
        <td>
            <input type="number" name="quantity[]" class="form-control text-end" min="1" value="1" required oninput="calcRow(this)">
            <div class="invalid-feedback">Enter a quantity of at least 1.</div>
        </td>
        <td>
            <div class="input-group">
                <span class="input-group-text">LKR</span>
                <input type="number" name="price[]" class="form-control text-end" step="0.01" min="0" value="0.00" required oninput="calcRow(this)">
            </div>
            <div class="invalid-feedback">Enter a valid price.</div>
        </td>
        <td class="text-end fw-semibold">
            <span class="line-total">0.00</span>
        </td>
        <td class="text-center">
            <button type="button" class="btn btn-sm btn-outline-danger" onclick="removeRow(this)">
                <i class="bi bi-trash"></i>
            </button>
        </td>
    </tr>
</template>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- JS: add/remove rows, price autofill, totals, validation, busy state -->
<script>
    function addRow() {
        const tpl = document.getElementById('item-row-template');
        const tbody = document.querySelector('#itemTable tbody');
        tbody.appendChild(tpl.content.cloneNode(true));
        recalcGrand();
    }

    function removeRow(btn) {
        const row = btn.closest('tr');
        row?.remove();
        recalcGrand();
    }

    function setPrice(selectEl) {
        const opt = selectEl.options[selectEl.selectedIndex];
        const priceAttr = opt.getAttribute('data-price');
        if (priceAttr !== null) {
            const row = selectEl.closest('tr');
            const priceInput = row.querySelector('input[name="price[]"]');
            if (priceInput && (parseFloat(priceInput.value) === 0 || priceInput.value === "")) {
                priceInput.value = Number(priceAttr).toFixed(2);
                calcRow(priceInput);
            }
        }
    }

    function calcRow(el) {
        const row = el.closest('tr');
        const qty = parseFloat(row.querySelector('input[name="quantity[]"]').value || '0');
        const price = parseFloat(row.querySelector('input[name="price[]"]').value || '0');
        const total = (qty * price) || 0;
        row.querySelector('.line-total').textContent = total.toFixed(2);
        recalcGrand();
    }

    function recalcGrand() {
        const totals = Array.from(document.querySelectorAll('.line-total'))
            .map(span => parseFloat(span.textContent || '0'));
        const grand = totals.reduce((a, b) => a + b, 0);
        document.getElementById('grandTotal').textContent = grand.toFixed(2);
    }

    // Initialize totals for prefilled rows
    document.addEventListener('DOMContentLoaded', () => {
        document.querySelectorAll('#itemTable tbody tr').forEach(tr => {
            const qty = tr.querySelector('input[name="quantity[]"]');
            const price = tr.querySelector('input[name="price[]"]');
            calcRow(qty || price || tr); // triggers recalc
        });
    });

    // Form validation & busy state
    (() => {
        'use strict';
        const form = document.getElementById('editBillForm');
        const submitBtn = document.getElementById('submitBtn');
        const spinner = submitBtn.querySelector('.spinner-border');
        const btnText = submitBtn.querySelector('.btn-text');

        form.addEventListener('submit', (e) => {
            if (!form.checkValidity()) {
                e.preventDefault();
                e.stopPropagation();
            } else {
                submitBtn.disabled = true;
                spinner.classList.remove('d-none');
                btnText.textContent = 'Updating...';
            }
            form.classList.add('was-validated');
        }, false);
    })();
</script>
</body>
</html>
