<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Existing values from query parameters
    String item_id = request.getParameter("item_id");
    String item_name = request.getParameter("item_name");
    String item_description = request.getParameter("item_description");
    String unit_price = request.getParameter("unit_price");
    String stock_quantity = request.getParameter("stock_quantity");
%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="light">
<head>
    <meta charset="UTF-8" />
    <title>Edit Item | Pahana Edu</title>
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

<main class="container flex-grow-1 d-flex align-items-center py-5">
    <div class="row justify-content-center w-100">
        <div class="col-12 col-md-8 col-lg-6 col-xl-5">
            <div class="card border-0 shadow-lg rounded-4">
                <div class="card-body p-4 p-md-5">
                    <div class="text-center mb-4">
                        <h1 class="h4 fw-bold mb-1">Edit Item</h1>
                        <p class="text-body-secondary mb-0">Update the item details below</p>
                    </div>

                    <form action="ItemServlet" method="post" id="editItemForm" class="needs-validation" novalidate>
                        <!-- Hidden ID for submission -->
                        <input type="hidden" name="item_id" value="<%= item_id != null ? item_id : "" %>">

                        <!-- Display Item ID (read-only) -->
                        <div class="mb-3">
                            <label class="form-label"><i class="bi bi-hash me-1"></i> Item ID</label>
                            <input type="text" class="form-control" value="<%= item_id != null ? item_id : "" %>" disabled>
                        </div>

                        <!-- Item Name -->
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="item_name" name="item_name"
                                   placeholder="Item Name" value="<%= item_name != null ? item_name : "" %>" required>
                            <label for="item_name"><i class="bi bi-box-seam me-1"></i> Item Name</label>
                            <div class="invalid-feedback">Please enter the item name.</div>
                        </div>

                        <!-- Description -->
                        <div class="mb-3">
                            <label for="item_description" class="form-label"><i class="bi bi-card-text me-1"></i> Item Description</label>
                            <input type="text" class="form-control" id="item_description" name="item_description"
                                   value="<%= item_description != null ? item_description : "" %>" required>
                            <div class="invalid-feedback">Please enter a short description.</div>
                        </div>

                        <!-- Unit Price -->
                        <div class="mb-3">
                            <label for="unit_price" class="form-label"><i class="bi bi-cash-coin me-1"></i> Unit Price</label>
                            <div class="input-group">
                                <span class="input-group-text">LKR</span>
                                <input type="number" class="form-control text-end" id="unit_price" name="unit_price"
                                       step="0.01" min="0" placeholder="0.00"
                                       value="<%= unit_price != null ? unit_price : "" %>" required>
                            </div>
                            <div class="invalid-feedback">Enter a valid price (0 or more).</div>
                        </div>

                        <!-- Stock Quantity -->
                        <div class="mb-4">
                            <label for="stock_quantity" class="form-label"><i class="bi bi-123 me-1"></i> Stock Quantity</label>
                            <input type="number" class="form-control text-end" id="stock_quantity" name="stock_quantity"
                                   step="1" min="0" value="<%= stock_quantity != null ? stock_quantity : "" %>" required>
                            <div class="invalid-feedback">Enter a valid stock quantity (0 or more).</div>
                        </div>

                        <!-- Actions -->
                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary flex-fill d-flex align-items-center justify-content-center gap-2" id="saveBtn">
                                <span class="btn-text">Update Item</span>
                                <span class="spinner-border spinner-border-sm d-none" role="status" aria-hidden="true"></span>
                            </button>
                            <a href="ItemServlet" class="btn btn-outline-secondary flex-fill">
                                ← Back to Item List
                            </a>
                        </div>
                    </form>
                </div>
            </div>

            <p class="text-center text-body-secondary small mt-4 mb-0">
                &copy; 2025 Pahana Edu Bookshop System
            </p>
        </div>
    </div>
</main>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- Client-side validation & busy state -->
<script>
    (() => {
        'use strict';
        const form = document.getElementById('editItemForm');
        const saveBtn = document.getElementById('saveBtn');
        const spinner = saveBtn.querySelector('.spinner-border');
        const btnText = saveBtn.querySelector('.btn-text');

        form.addEventListener('submit', (e) => {
            if (!form.checkValidity()) {
                e.preventDefault();
                e.stopPropagation();
            } else {
                saveBtn.disabled = true;
                spinner.classList.remove('d-none');
                btnText.textContent = 'Saving...';
            }
            form.classList.add('was-validated');
        }, false);
    })();
</script>
</body>
</html>
