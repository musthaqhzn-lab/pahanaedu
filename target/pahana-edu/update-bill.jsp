<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.icbt.model.Bill, com.icbt.model.BillItem, java.util.List" %>
<%
    Bill bill = (Bill) request.getAttribute("bill");
    List<BillItem> billItems = (List<BillItem>) request.getAttribute("billItems");
%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="light">
<head>
    <meta charset="UTF-8" />
    <title>Update Bill | Pahana Edu</title>
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
        <h1 class="h4 fw-bold mb-1">Update Bill</h1>
        <p class="text-body-secondary mb-0">
            Bill ID:
            <span class="badge text-bg-secondary">
        #<%= (bill != null ? bill.getId() : 0) %>
      </span>
        </p>
    </header>

    <div class="card border-0 shadow-lg rounded-4">
        <div class="card-body p-4 p-md-5">
            <form action="BillUpdateServlet" method="post" class="needs-validation" novalidate
                  onsubmit="return prepareFormBeforeSubmit()" id="updateBillForm">

                <input type="hidden" name="billId" value="<%= (bill != null ? bill.getId() : 0) %>"/>

                <!-- Customer account number -->
                <div class="mb-4">
                    <label for="accountNumber" class="form-label">
                        <i class="bi bi-person-vcard me-1"></i> Customer Account Number
                    </label>
                    <input type="number" class="form-control" id="accountNumber" name="accountNumber"
                           value="<%= (bill != null ? bill.getAccountNumber() : 0) %>" required>
                    <div class="invalid-feedback">Please enter a valid account number.</div>
                </div>

                <!-- Items header + add button -->
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
                            <th style="min-width: 160px;">Item ID</th>
                            <th class="text-end" style="width: 140px;">Quantity</th>
                            <th class="text-end" style="width: 200px;">Unit Price (LKR)</th>
                            <th class="text-end" style="width: 160px;">Line Total</th>
                            <th class="text-center" style="width: 100px;">Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <% if (billItems != null) {
                            for (BillItem it : billItems) { %>
                        <tr>
                            <td>
                                <input type="number" name="itemId" class="form-control"
                                       value="<%= it.getItemId() %>" min="1" required oninput="calcRow(this)">
                                <div class="invalid-feedback">Enter a valid item ID.</div>
                            </td>
                            <td>
                                <input type="number" name="quantity" class="form-control text-end"
                                       min="1" value="<%= it.getQuantity() %>" required oninput="calcRow(this)">
                                <div class="invalid-feedback">Quantity must be at least 1.</div>
                            </td>
                            <td>
                                <div class="input-group">
                                    <span class="input-group-text">LKR</span>
                                    <input type="number" name="price" class="form-control text-end"
                                           step="0.01" min="0" value="<%= it.getPrice() %>" required oninput="calcRow(this)">
                                </div>
                                <div class="invalid-feedback">Enter a valid price (0 or more).</div>
                            </td>
                            <td class="text-end fw-semibold"><span class="line-total">0.00</span></td>
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
                    <a href="BillServlet" class="btn btn-outline-secondary">← Back to Billing</a>
                    <button type="submit" class="btn btn-primary d-flex align-items-center gap-2" id="submitBtn">
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

<!-- Row template for adding new items -->
<template id="item-row-template">
    <tr>
        <td>
            <input type="number" name="itemId" class="form-control" min="1" required oninput="calcRow(this)">
            <div class="invalid-feedback">Enter a valid item ID.</div>
        </td>
        <td>
            <input type="number" name="quantity" class="form-control text-end" min="1" value="1" required oninput="calcRow(this)">
            <div class="invalid-feedback">Quantity must be at least 1.</div>
        </td>
        <td>
            <div class="input-group">
                <span class="input-group-text">LKR</span>
                <input type="number" name="price" class="form-control text-end" step="0.01" min="0" value="0.00" required oninput="calcRow(this)">
            </div>
            <div class="invalid-feedback">Enter a valid price (0 or more).</div>
        </td>
        <td class="text-end fw-semibold"><span class="line-total">0.00</span></td>
        <td class="text-center">
            <button type="button" class="btn btn-sm btn-outline-danger" onclick="removeRow(this)">
                <i class="bi bi-trash"></i>
            </button>
        </td>
    </tr>
</template>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- JS: add/remove rows, totals, validation, name[] conversion, busy state -->
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

    function calcRow(el) {
        const row = el.closest('tr');
        const qty = parseFloat(row.querySelector('input[name="quantity"]').value || '0');
        const price = parseFloat(row.querySelector('input[name="price"]').value || '0');
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

    // Convert names to arrays right before submit (to match server parsing)
    function prepareFormBeforeSubmit() {
        const form = document.getElementById('updateBillForm');

        // Client-side validity
        if (!form.checkValidity()) {
            form.classList.add('was-validated');
            return false;
        }

        const rename = (selector, newName) => {
            document.querySelectorAll(selector).forEach(inp => inp.name = newName);
        };
        rename('input[name="itemId"]', 'itemId[]');
        rename('input[name="quantity"]', 'quantity[]');
        rename('input[name="price"]', 'price[]');

        // Busy state
        const submitBtn = document.getElementById('submitBtn');
        submitBtn.disabled = true;
        submitBtn.querySelector('.spinner-border').classList.remove('d-none');
        submitBtn.querySelector('.btn-text').textContent = 'Updating...';

        return true;
    }

    // Initialize line totals for pre-filled rows
    document.addEventListener('DOMContentLoaded', () => {
        document.querySelectorAll('#itemTable tbody tr').forEach(tr => {
            const anyInput = tr.querySelector('input[name="quantity"]') || tr.querySelector('input[name="price"]');
            if (anyInput) calcRow(anyInput);
        });
    });
</script>
</body>
</html>
