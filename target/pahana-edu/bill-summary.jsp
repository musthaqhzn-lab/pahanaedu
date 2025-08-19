<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.text.*, com.icbt.model.Bill, com.icbt.model.BillItem, com.icbt.model.Customer, com.icbt.model.Item" %>
<%
    Bill bill = (Bill) request.getAttribute("bill");
    List<BillItem> billItems = (List<BillItem>) request.getAttribute("billItems");
    Customer customer = (Customer) request.getAttribute("customer");
    List<Item> items = (List<Item>) request.getAttribute("items");

    // Helpers
    Map<Integer, Item> itemById = new HashMap<>();
    if (items != null) {
        for (Item it : items) itemById.put(it.getItem_id(), it);
    }
    DecimalFormat money = new DecimalFormat("#,##0.00");
    String billDateStr;
    if (bill != null && bill.getBillDate() != null) {
        billDateStr = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").format(bill.getBillDate());
    } else {
        billDateStr = "";
    }
%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="light">
<head>
    <meta charset="UTF-8" />
    <title>Bill Summary | Pahana Edu</title>
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
        <div class="ms-auto">
            <button class="btn btn-primary" onclick="printBill()">
                <i class="bi bi-printer me-1"></i> Print / Save as PDF
            </button>
        </div>
    </div>
</nav>

<main class="container py-4 flex-grow-1">
    <div class="card shadow-sm rounded-4" id="billArea">
        <div class="card-body p-4 p-md-5">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-start gap-3">
                <div>
                    <h1 class="h4 fw-bold mb-1">Bill Statement</h1>
                    <div class="text-body-secondary">Pahana Edu Billing System</div>
                </div>
                <div class="text-md-end">
                    <div class="fw-semibold">Bill # <%= (bill != null ? bill.getBillId() : "") %></div>
                    <div class="text-body-secondary">Date: <%= billDateStr %></div>
                </div>
            </div>

            <hr class="my-4">

            <div class="row g-3">
                <div class="col-12 col-md-6">
                    <div class="border rounded-3 p-3">
                        <div class="fw-semibold mb-1">Billed To</div>
                        <div><%= (customer != null ? customer.getName() : "") %></div>
                    </div>
                </div>
                <div class="col-12 col-md-6">
                    <div class="border rounded-3 p-3 h-100">
                        <div class="fw-semibold mb-1">Bill Details</div>
                        <div>Reference: <span class="text-body-secondary"><%= (bill != null ? bill.getBillId() : "") %></span></div>
                        <div>Status: <span class="badge text-bg-success">Generated</span></div>
                    </div>
                </div>
            </div>

            <div class="table-responsive mt-4">
                <table class="table table-striped table-hover align-middle mb-0">
                    <thead class="table-light">
                    <tr>
                        <th style="min-width: 220px;">Item</th>
                        <th class="text-end">Quantity</th>
                        <th class="text-end">Unit Price (Rs.)</th>
                        <th class="text-end">Total (Rs.)</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        double grandTotal = 0.0;
                        if (billItems != null) {
                            for (BillItem bi : billItems) {
                                double lineTotal = bi.getQuantity() * bi.getPrice();
                                grandTotal += lineTotal;
                                String itemName = String.valueOf(bi.getItemId());
                                Item found = itemById.get(bi.getItemId());
                                if (found != null) itemName = found.getItem_name();
                    %>
                    <tr>
                        <td><%= itemName %></td>
                        <td class="text-end"><%= bi.getQuantity() %></td>
                        <td class="text-end"><%= money.format(bi.getPrice()) %></td>
                        <td class="text-end"><%= money.format(lineTotal) %></td>
                    </tr>
                    <%
                            }
                        }
                    %>
                    </tbody>
                    <tfoot>
                    <tr>
                        <th colspan="3" class="text-end">Grand Total (Rs.)</th>
                        <th class="text-end"><%= money.format(grandTotal) %></th>
                    </tr>
                    </tfoot>
                </table>
            </div>

            <div class="d-flex flex-wrap gap-2 justify-content-between align-items-center mt-4">
                <a href="BillServlet" class="btn btn-outline-secondary">
                    ← Back to Billing
                </a>
                <button class="btn btn-primary" onclick="printBill()">
                    <i class="bi bi-printer me-1"></i> Print / Save as PDF
                </button>
            </div>
        </div>
    </div>

    <p class="text-center text-body-secondary small mt-4 mb-0">
        &copy; 2025 Pahana Edu Bookshop System
    </p>
</main>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- Print helper -->
<script>
    function printBill() {
        const billContent = document.getElementById("billArea").outerHTML;
        const win = window.open('', '_blank', 'height=800,width=900');
        if (!win) return;

        win.document.open();
        win.document.write(`<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Bill</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-white">
  <div class="container my-4">
    ${billContent}
  </div>
  <script>
    window.addEventListener('load', function () {
      window.print();
      setTimeout(() => window.close(), 300);
    });
  <\/script>
</body>
</html>`);
        win.document.close();
    }
</script>

</body>
</html>
