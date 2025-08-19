<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String accountNumber = request.getParameter("accountNumber");
  String name = request.getParameter("name");
  String address = request.getParameter("address");
  String telephone = request.getParameter("telephone");
%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="light">
<head>
  <meta charset="UTF-8" />
  <title>Edit Customer | Pahana Edu</title>
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
            <h1 class="h4 fw-bold mb-1">Edit Customer</h1>
            <p class="text-body-secondary mb-0">Update details or delete this customer</p>
          </div>

          <form action="CustomerServlet" method="post" class="needs-validation" novalidate id="editCustomerForm">
            <!-- Keep account number hidden for submission -->
            <input type="hidden" name="accountNumber" value="<%= accountNumber != null ? accountNumber : "" %>">

            <!-- Display account number (read-only) -->
            <div class="mb-3">
              <label class="form-label"><i class="bi bi-hash me-1"></i> Account Number</label>
              <input type="text" class="form-control" value="<%= accountNumber != null ? accountNumber : "" %>" disabled>
            </div>

            <!-- Name -->
            <div class="form-floating mb-3">
              <input type="text" class="form-control" id="name" name="name"
                     placeholder="Name" value="<%= name != null ? name : "" %>" required>
              <label for="name"><i class="bi bi-person me-1"></i> Name</label>
              <div class="invalid-feedback">Please enter the customer's name.</div>
            </div>

            <!-- Address -->
            <div class="mb-3">
              <label for="address" class="form-label"><i class="bi bi-geo-alt me-1"></i> Address</label>
              <textarea id="address" name="address" class="form-control" rows="3" required><%= address != null ? address : "" %></textarea>
              <div class="invalid-feedback">Please provide the customer's address.</div>
            </div>

            <!-- Telephone (optional) -->
            <div class="mb-4">
              <label for="telephone" class="form-label"><i class="bi bi-telephone me-1"></i> Telephone</label>
              <div class="input-group">
                <span class="input-group-text">+94</span>
                <input type="text" class="form-control" id="telephone" name="telephone"
                       inputmode="tel" placeholder="7XXXXXXXX"
                       value="<%= telephone != null ? telephone : "" %>">
              </div>
              <div class="form-text">Optional. Example: 771234567</div>
            </div>

            <!-- Actions -->
            <div class="d-flex gap-2">
              <button type="submit" class="btn btn-primary flex-fill d-flex justify-content-center align-items-center gap-2" id="updateBtn">
                <span class="btn-text">Update</span>
                <span class="spinner-border spinner-border-sm d-none" role="status" aria-hidden="true"></span>
              </button>

              <button type="submit" name="delete" value="true"
                      class="btn btn-danger flex-fill d-flex justify-content-center align-items-center gap-2"
                      id="deleteBtn"
                      onclick="return confirm('Are you sure you want to delete this customer?');">
                <i class="bi bi-trash"></i>
                <span class="btn-text">Delete</span>
                <span class="spinner-border spinner-border-sm d-none" role="status" aria-hidden="true"></span>
              </button>
            </div>

            <div class="mt-3 text-center">
              <a href="CustomerServlet" class="btn btn-outline-secondary w-100">← Back to Customer List</a>
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

<!-- Client-side validation & busy-state handling -->
<script>
  (() => {
    'use strict';
    const form = document.getElementById('editCustomerForm');
    const updateBtn = document.getElementById('updateBtn');
    const deleteBtn = document.getElementById('deleteBtn');

    form.addEventListener('submit', (e) => {
      if (!form.checkValidity()) {
        e.preventDefault();
        e.stopPropagation();
        form.classList.add('was-validated');
        return;
      }

      // Determine which button was used to submit
      const clicked = document.activeElement && document.activeElement.closest('button[type="submit"]');
      const targetBtn = clicked || updateBtn;
      const spinner = targetBtn.querySelector('.spinner-border');
      const text = targetBtn.querySelector('.btn-text');

      // Busy state
      targetBtn.disabled = true;
      spinner?.classList.remove('d-none');
      if (targetBtn === deleteBtn) {
        text && (text.textContent = 'Deleting...');
      } else {
        text && (text.textContent = 'Updating...');
      }

      // Prevent double submits by disabling the other button too
      (targetBtn === updateBtn ? deleteBtn : updateBtn).disabled = true;
    }, false);
  })();
</script>
</body>
</html>
