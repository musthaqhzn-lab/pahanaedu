<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="light">
<head>
  <meta charset="UTF-8" />
  <title>Add New Customer | Pahana Edu</title>
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
            <h1 class="h4 fw-bold mb-1">Add New Customer</h1>
            <p class="text-body-secondary mb-0">Enter the customer details below</p>
          </div>

          <form action="CustomerServlet" method="post" class="needs-validation" novalidate id="addCustomerForm">
            <!-- Name -->
            <div class="form-floating mb-3">
              <input type="text" class="form-control" id="name" name="name" placeholder="Customer Name" required>
              <label for="name"><i class="bi bi-person me-1"></i> Name</label>
              <div class="invalid-feedback">Please enter the customer's name.</div>
            </div>

            <!-- Address -->
            <div class="mb-3">
              <label for="address" class="form-label"><i class="bi bi-geo-alt me-1"></i> Address</label>
              <textarea id="address" name="address" class="form-control" rows="3" required></textarea>
              <div class="form-text">Street, city, and any other relevant details.</div>
              <div class="invalid-feedback">Please provide the address.</div>
            </div>

            <!-- Telephone -->
            <div class="mb-4">
              <label for="telephone" class="form-label"><i class="bi bi-telephone me-1"></i> Telephone</label>
              <div class="input-group">
                <span class="input-group-text" id="tel-addon">+94</span>
                <input type="text" class="form-control" id="telephone" name="telephone" aria-describedby="tel-addon" placeholder="7XXXXXXXX">
              </div>
              <div class="form-text">Optional. Example: 771234567</div>
            </div>

            <button type="submit" class="btn btn-primary w-100 d-flex align-items-center justify-content-center gap-2" id="submitBtn">
              <span class="btn-text">Register Customer</span>
              <span class="spinner-border spinner-border-sm d-none" role="status" aria-hidden="true"></span>
            </button>
          </form>

          <!-- Back links -->
          <div class="row g-2 mt-4">
            <div class="col-12 col-sm-6">
              <a href="show-customer.jsp" class="btn btn-outline-secondary w-100">
                ← Back to Customer List
              </a>
            </div>
            <div class="col-12 col-sm-6">
              <a href="main-menu.jsp" class="btn btn-outline-secondary w-100">
                ← Back to Home
              </a>
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
    const form = document.getElementById('addCustomerForm');
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
        btnText.textContent = 'Saving...';
      }
      form.classList.add('was-validated');
    }, false);
  })();
</script>
</body>
</html>
