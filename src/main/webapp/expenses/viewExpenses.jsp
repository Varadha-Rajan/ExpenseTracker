<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.User" %>
<%
    User u = (User) session.getAttribute("user");
    if (u == null) { response.sendRedirect("../login.jsp"); return; }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>My Expenses</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
  <!-- Optional Bootstrap if you still use its grid/table -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.6.2/css/bootstrap.min.css">
  <style>
    /* Expenses Page Enhanced Glassmorphism CSS */
body {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    position: relative;
    overflow-x: hidden;
    padding: 20px;
}

/* Enhanced Floating Background Elements */
.circle {
    position: fixed;
    border-radius: 50%;
    background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 70%);
    animation: float 8s ease-in-out infinite;
    z-index: -1;
}

.circle.one {
    width: 400px;
    height: 400px;
    top: -150px;
    left: -150px;
    background: radial-gradient(circle, rgba(108, 99, 255, 0.25) 0%, rgba(108, 99, 255, 0) 70%);
}

.circle.two {
    width: 500px;
    height: 500px;
    bottom: -200px;
    right: -150px;
    background: radial-gradient(circle, rgba(0, 201, 167, 0.25) 0%, rgba(0, 201, 167, 0) 70%);
    animation-delay: 3s;
}

/* Additional floating shapes */
.circle.three {
    width: 300px;
    height: 300px;
    top: 40%;
    left: 5%;
    background: radial-gradient(circle, rgba(255, 107, 107, 0.15) 0%, rgba(255, 107, 107, 0) 70%);
    animation-delay: 2s;
}

@keyframes float {
    0%, 100% { 
        transform: translateY(0) rotate(0deg) scale(1); 
    }
    33% { 
        transform: translateY(-25px) rotate(120deg) scale(1.08); 
    }
    66% { 
        transform: translateY(15px) rotate(240deg) scale(0.92); 
    }
}

.auth-container {
    width: 1200px;
    max-width: 98%;
    margin: 30px auto;
    padding: 40px;
    background: rgba(255, 255, 255, 0.95);
    border-radius: 24px;
    border: 1px solid rgba(255, 255, 255, 0.3);
    color: #2d3748;
    backdrop-filter: blur(20px);
    box-shadow: 
        0 20px 40px rgba(0, 0, 0, 0.15),
        inset 0 1px 0 rgba(255, 255, 255, 0.8);
    animation: slideUp 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    position: relative;
    overflow: hidden;
}

.auth-container::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 1px;
    background: linear-gradient(90deg, 
        transparent, 
        rgba(108, 99, 255, 0.4), 
        transparent);
}

@keyframes slideUp {
    from { 
        opacity: 0; 
        transform: translateY(40px) scale(0.96);
    }
    to { 
        opacity: 1; 
        transform: translateY(0) scale(1);
    }
}

/* Header Styles */
.wrap-head {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
    padding-bottom: 25px;
    border-bottom: 2px solid rgba(108, 99, 255, 0.1);
    flex-wrap: wrap;
    gap: 20px;
}

.wrap-head h4 {
    color: #2d3748;
    font-weight: 700;
    font-size: 2.2rem;
    margin: 0;
}

.wrap-head h4 span {
    background: linear-gradient(135deg, #6c63ff 0%, #00c9a7 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

.note {
    color: #718096;
    font-size: 1rem;
    font-weight: 500;
    margin-top: 5px;
    display: block;
}

/* Top Actions */
.top-actions {
    display: flex;
    gap: 15px;
    align-items: center;
    flex-wrap: wrap;
}

.btn {
    padding: 12px 24px;
    border-radius: 12px;
    text-decoration: none;
    font-weight: 600;
    font-size: 0.95rem;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    border: none;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    gap: 8px;
}

.btn.ghost {
    background: rgba(108, 99, 255, 0.1);
    color: #6c63ff;
    border: 2px solid rgba(108, 99, 255, 0.2);
}

.btn.ghost:hover {
    background: rgba(108, 99, 255, 0.15);
    border-color: rgba(108, 99, 255, 0.4);
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(108, 99, 255, 0.2);
}

.btn:not(.ghost) {
    background: linear-gradient(135deg, #6c63ff 0%, #00c9a7 100%);
    color: white;
    border: 2px solid transparent;
}

.btn:not(.ghost):hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(108, 99, 255, 0.4);
    text-decoration: none;
    color: white;
}

/* Enhanced Table Styles */
.expenses-table {
    background: transparent;
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
    margin-bottom: 0;
}

.expenses-table thead th {
    background: linear-gradient(135deg, #6c63ff 0%, #00c9a7 100%);
    color: white;
    font-weight: 600;
    font-size: 0.95rem;
    padding: 18px 16px;
    border: none;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    position: relative;
}

.expenses-table thead th::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 2px;
    background: rgba(255, 255, 255, 0.3);
}

.expenses-table tbody tr {
    transition: all 0.3s ease;
    background: rgba(255, 255, 255, 0.7);
}

.expenses-table tbody tr:nth-child(even) {
    background: rgba(248, 250, 252, 0.8);
}

.expenses-table tbody tr:hover {
    background: rgba(108, 99, 255, 0.05);
    transform: translateX(5px);
}

.expenses-table tbody td {
    padding: 16px;
    border-color: rgba(0, 0, 0, 0.06);
    font-weight: 500;
    color: #4a5568;
    vertical-align: middle;
}

/* Amount column styling */
.expenses-table tbody td:nth-child(3) {
    font-weight: 700;
    color: #2d3748;
    font-size: 1.05rem;
}

/* Action Buttons */
.action-btn {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    margin-right: 8px;
    padding: 8px 16px;
    border-radius: 10px;
    text-decoration: none;
    font-size: 0.85rem;
    font-weight: 600;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    border: 2px solid transparent;
}

.action-edit {
    background: rgba(108, 99, 255, 0.1);
    color: #6c63ff;
    border-color: rgba(108, 99, 255, 0.2);
}

.action-edit:hover {
    background: rgba(108, 99, 255, 0.2);
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(108, 99, 255, 0.3);
    text-decoration: none;
    color: #6c63ff;
}

.action-delete {
    background: rgba(239, 68, 68, 0.1);
    color: #dc2626;
    border-color: rgba(239, 68, 68, 0.2);
}

.action-delete:hover {
    background: rgba(239, 68, 68, 0.2);
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
    text-decoration: none;
    color: #dc2626;
}

/* Empty State */
.text-center.text-muted {
    padding: 60px 20px;
    color: #718096 !important;
    font-size: 1.1rem;
}

.text-center.text-muted a {
    color: #6c63ff;
    font-weight: 600;
    text-decoration: none;
}

.text-center.text-muted a:hover {
    text-decoration: underline;
}

/* Status Indicators */
.status-badge {
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.status-paid {
    background: rgba(72, 187, 120, 0.1);
    color: #38a169;
    border: 1px solid rgba(72, 187, 120, 0.3);
}

.status-pending {
    background: rgba(237, 137, 54, 0.1);
    color: #dd6b20;
    border: 1px solid rgba(237, 137, 54, 0.3);
}

/* Quick Stats */
.quick-stats {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
    margin-bottom: 30px;
}

.stat-card {
    background: rgba(255, 255, 255, 0.8);
    border-radius: 16px;
    padding: 20px;
    text-align: center;
    backdrop-filter: blur(10px);
    border: 1px solid rgba(255, 255, 255, 0.3);
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
    transition: all 0.3s ease;
}

.stat-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
}

.stat-value {
    font-size: 2rem;
    font-weight: 700;
    color: #6c63ff;
    margin-bottom: 5px;
}

.stat-label {
    font-size: 0.9rem;
    color: #718096;
    font-weight: 500;
}

/* Responsive Design */
@media (max-width: 768px) {
    .auth-container {
        padding: 25px 20px;
        margin: 20px auto;
    }
    
    .wrap-head {
        flex-direction: column;
        text-align: center;
        gap: 15px;
    }
    
    .wrap-head h4 {
        font-size: 1.8rem;
    }
    
    .top-actions {
        justify-content: center;
    }
    
    .expenses-table {
        font-size: 0.9rem;
    }
    
    .expenses-table thead {
        display: none;
    }
    
    .expenses-table tbody tr {
        display: block;
        margin-bottom: 15px;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }
    
    .expenses-table tbody td {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 12px 16px;
        border: none;
        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
    }
    
    .expenses-table tbody td::before {
        content: attr(data-label);
        font-weight: 600;
        color: #4a5568;
        text-transform: uppercase;
        font-size: 0.8rem;
        letter-spacing: 0.5px;
    }
    
    .circle.one,
    .circle.two,
    .circle.three {
        display: none;
    }
    
    .action-btn {
        padding: 6px 12px;
        font-size: 0.8rem;
    }
}

/* Loading Animation */
@keyframes pulse {
    0%, 100% { opacity: 1; }
    50% { opacity: 0.5; }
}

.loading-row {
    animation: pulse 2s infinite;
}

/* Print Styles */
@media print {
    .circle,
    .top-actions,
    .action-btn {
        display: none;
    }
    
    .auth-container {
        background: white;
        box-shadow: none;
        border: 1px solid #ddd;
    }
    
    .expenses-table {
        box-shadow: none;
    }
}
  </style>
</head>
<body>
  <div class="circle one"></div>
  <div class="circle two"></div>
  <div class="circle three"></div>

  <div class="auth-container">
    <!-- Optional Quick Stats Section -->
    <!--
    <div class="quick-stats">
      <div class="stat-card">
        <div class="stat-value">$<c:out value="${totalExpenses}"/></div>
        <div class="stat-label">Total Spent</div>
      </div>
      <div class="stat-card">
        <div class="stat-value"><c:out value="${expenseCount}"/></div>
        <div class="stat-label">Total Expenses</div>
      </div>
      <div class="stat-card">
        <div class="stat-value"><c:out value="${categoryCount}"/></div>
        <div class="stat-label">Categories</div>
      </div>
    </div>
    -->

    <div class="wrap-head">
      <div>
        <h4> Expense Manager  <span><%= u.getUsername() %></span></h4>
        <small class="note">Manage your personal expenses efficiently</small>
      </div>

      <div class="top-actions">
        <a href="${pageContext.request.contextPath}/profile.jsp" class="btn ghost">
           Back to Profile
        </a>
        <a href="${pageContext.request.contextPath}/expenses/addExpense.jsp" class="btn">
          <i class="fas fa-plus"></i> Add Expense
        </a>
      </div>
    </div>

    <div style="margin-top: 25px;">
      <table class="table expenses-table">
        <thead>
          <tr>
            <th style="width:120px"> Date</th>
            <th> Category</th>
            <th style="width:140px"> Amount</th>
            <th> Notes</th>
            <th style="width:200px"> Actions</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="exp" items="${expenses}">
            <tr>
              <td data-label="Date"><c:out value="${exp.date}"/></td>
              <td data-label="Category"><c:out value="${exp.category}"/></td>
              <td data-label="Amount">$<c:out value="${exp.amount}"/></td>
              <td data-label="Notes"><c:out value="${exp.notes}"/></td>
              <td data-label="Actions">
                <a href="${pageContext.request.contextPath}/editExpense?id=${exp.id}" class="action-btn action-edit">
                  <i class="fas fa-edit"></i> Edit
                </a>
                <a href="${pageContext.request.contextPath}/deleteExpense?id=${exp.id}" class="action-btn action-delete" onclick="return confirm('Delete this expense?');">
                  <i class="fas fa-trash"></i> Delete
                </a>
              </td>
            </tr>
          </c:forEach>

          <c:if test="${empty expenses}">
            <tr>
              <td colspan="5" class="text-center text-muted" style="padding: 60px 20px;">
                No expenses recorded yet. 
                <br><br>
                <a href="${pageContext.request.contextPath}/expenses/addExpense.jsp" class="btn" style="display: inline-flex; align-items: center; gap: 8px;">
                  <i class="fas fa-plus"></i> Add Your First Expense
                </a>
              </td>
            </tr>
          </c:if>
        </tbody>
      </table>
    </div>
  </div>

  <!-- Optional Bootstrap JS -->
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
