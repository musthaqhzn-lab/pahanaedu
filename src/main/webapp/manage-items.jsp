<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.icbt.model.Item" %>
<%
  List<Item> items = (List<Item>) request.getAttribute("items");
%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="light">
<head>
  <meta charset="UTF-8" />
  <title>Items List | Pahana Edu</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <!-- Bootstrap 5 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap Icons (optional) -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-body-tertiary d-flex flex-column min-vh-100">

<!-- Top Bar -->
<nav class="navbar navbar-expand-lg bg-body shadow-sm">
  <div class="container">
    <a class="navbar-brand d-flex align-items-center gap-2" href="main-menu.jsp">
      <i class="bi bi-journal-check"></i>
      <span class="fw-semibold">Pahana Edu Billing</span>
    </a>
    <div class="ms-auto">
      <a class="btn btn-primary" href="add-item.jsp">
        <i class="bi bi-plus-lg me-1"></i> Add New Item
      </a>
    </div>
  </div>
</nav>

<main class="container py-4 flex-grow-1">
  <header class="text-center mb-4">
    <h1 class="h4 fw-bold mb-1">Item List</h1>
    <p class="text-body-secondary mb-0">View, edit, and manage items</p>
  </header>

  <div class="card border-0 shadow-sm rounded-4">
    <div class="card-body p-0">
      <div class="table-responsive">
        <table class="table table-striped table-hover align-middle mb-0">
          <thead class="table-light">
          <tr>
            <th>Item Code</th>
            <th>Name</th>
            <th>Description</th>
            <th class="text-end">Price</th>
            <th class="text-end">Stock</th>
            <th class="text-center" style="width: 220px;">Actions</th>
          </tr>
          </thead>
          <tbody>
          <% if (items != null && !items.isEmpty()) {
            for (Item item : items) { %>
          <tr>
            <td><%= item.getItem_id() %></td>
            <td><%= item.getItem_name() %></td>
            <td><%= item.getItem_description() %></td>
            <td class="text-end"><%= item.getUnit_price() %></td>
            <td class="text-end"><%= item.getStock_quantity() %></td>
            <td class="text-center">
              <div class="btn-group" role="group" aria-label="Actions">
                <!-- Keep original query params exactly (design change only) -->
                <a class="btn btn-sm btn-outline-primary"
                   href="edit-item.jsp?item_id=<%= item.getItem_id() %>&item_name=<%= item.getItem_name() %>&item_description=<%= item.getItem_description() %>&unit_price=<%= item.getUnit_price() %>&stock_quantity=<%= item.getStock_quantity() %>">
                  <i class="bi bi-pencil-square me-1"></i>Edit
                </a>
                <a class="btn btn-sm btn-outline-danger"
                   href="ItemServlet?action=delete&id=<%= item.getItem_id() %>"
                   onclick="return confirm('Are you sure you want to delete this item?');">
                  <i class="bi bi-trash me-1"></i>Delete
                </a>
              </div>
            </td>
          </tr>
          <% } } else { %>
          <tr>
            <td colspan="6" class="text-center py-4 text-body-secondary">No items available.</td>
          </tr>
          <% } %>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <div class="text-center mt-4">
    <a href="main-menu.jsp" class="btn btn-outline-secondary">
      ← Back to Home
    </a>
  </div>
</main>

<footer class="container py-4">
  <p class="text-center text-body-secondary small mb-0">
    &copy; 2025 Pahana Edu Bookshop System
  </p>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
