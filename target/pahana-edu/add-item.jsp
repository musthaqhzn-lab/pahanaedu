<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="light">
<head>
  <meta charset="UTF-8" />
  <title>Add New Item | Pahana Edu</title>
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
            <h1 class="h4 fw-bold mb-1">Add New Item</h1>
            <p class="text-body-secondary mb-0">Fill in the item details below</p>
          </div>

          <form action="ItemServlet" method="post" class="needs-validation" novalidate id="addItemForm">
            <!-- Item Name -->
            <div class="form-floating mb-3">
              <input type="text" class="form-control" id="name" name="item_name" placeholder="Item Name" required>
              <label for="name"><i class="bi bi-box-seam me-1"></i> Item Name</label>
              <div class="invalid-feedback">Please enter the item name.</div>
            </div>

            <!-- Description -->
            <div class="mb-3">
              <label for="description" class="form-label"><i class="bi bi-card-text me-1"></i> Item Description</label>
              <input type="text" class="form-control" id="description" name="item_description" required>
              <div class="invalid-feedback">Please enter a short description.</div>
            </div>

            <!-- Price -->
            <div class="mb-3">
              <label for="price" class="form-label"><i class="bi bi-cash-coin me-1"></i> Price</label>
              <div class="input-group">
                <span class="input-group-text" id="price-addon">LKR</span>
                <input type="number" class="form-control" id="price" name="unit_price" step="0.01" min="0" aria-describedby="price-addon" placeholder="0.00" required>
              </div>
              <div class="form-text">Enter unit price in Sri Lankan Rupees.</div>
              <div class="invalid-feedback">Please enter a valid price (0 or more).</div>
            </div>

            <!-- Stock -->
            <div class="mb-4">
              <label for="stock" class="form-label"><i class="bi bi-123 me-1"></i> Stock Quantity</label>
              <input type="number" class="form-control" id="stock" name="stock_quantity" step="1" min="0" required>
              <div class="invalid-feedback">Please enter a valid stock quantity (0 or more).</div>
            </div>

            <button type="submit" class="btn btn-primary w-100 d-flex align-items-center justify-content-center gap-2" id="submitBtn">
              <span class="btn-text">Add Item</span>
              <span class="spinner-border spinner-border-sm d-none" role="status" aria-hidden="true"></span>
            </button>
          </form>

          <div class="row g-2 mt-4">
            <div class="col-12">
              <a href="ItemServlet" class="btn btn-outline-secondary w-100">← Back to Item List</a>
            </div>
          </div>

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

<!-- Client-side validation + busy state -->
<script>
  (() => {
    'use strict';
    const form = document.getElementById('addItemForm');
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
        btnText.textContent = 'Adding...';
      }
      form.classList.add('was-validated');
    }, false);
  })();
</script>
</body>
</html>
