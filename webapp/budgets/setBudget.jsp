<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.User" %>
<%
    User u = (User) session.getAttribute("user");
    if (u == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    // compute selected month & year safely in Java
    int selectedMonth = 0;
    int selectedYear = java.time.LocalDate.now().getYear();

    String monthParam = request.getParameter("month");
    String yearParam  = request.getParameter("year");

    try {
        if (monthParam != null && !monthParam.isEmpty()) selectedMonth = Integer.parseInt(monthParam);
    } catch (NumberFormatException ignored) {}

    try {
        if (yearParam != null && !yearParam.isEmpty()) selectedYear = Integer.parseInt(yearParam);
    } catch (NumberFormatException ignored) {}
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Set Budget</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.6.2/css/bootstrap.min.css">
  
    <style>
  .auth-container { 
    width:720px; 
    max-width:95%; 
    padding:28px; 
    color:#082033; 
    background: rgba(255,255,255,0.95); 
    border-radius: 12px;
    box-shadow: 0 8px 24px rgba(0,0,0,0.1);
    margin: 40px auto;
  }
  
  h3 {
    text-align: center;
    margin-bottom: 24px;
    color: #27455a;
    font-weight: 700;
  }
  
  label {
    font-weight: 600;
    color: #27455a;
    display: block;
    margin-bottom: 6px;
    font-size: 14px;
  }
  
  .auth-input {
    width: 100%;
    padding: 10px 12px;
    border: 1px solid #d1d9e6;
    border-radius: 6px;
    font-size: 14px;
    transition: all 0.3s ease;
    background: #f9fafb;
  }
  
  .auth-input:focus {
    outline: none;
    border-color: #4a90e2;
    background: white;
    box-shadow: 0 0 0 3px rgba(74, 144, 226, 0.1);
  }
  
  .auth-input:required {
    border-left: 3px solid #4a90e2;
  }
  
  select.auth-input {
    cursor: pointer;
  }
  
  .btn {
    background: #4a90e2;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 6px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    text-decoration: none;
    display: inline-block;
    margin-right: 10px;
  }
  
  .btn:hover {
    background: #357abd;
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(74, 144, 226, 0.3);
    color: white;
    text-decoration: none;
  }
  
  .btn.ghost {
    background: transparent;
    color: #6c757d;
    border: 1px solid #d1d9e6;
  }
  
  .btn.ghost:hover {
    background: #f8f9fa;
    color: #495057;
    border-color: #adb5bd;
  }
  
  form {
    margin-top: 8px;
  }
  
  .circle {
    position: fixed;
    border-radius: 50%;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    z-index: -1;
  }
  
  .circle.one {
    width: 200px;
    height: 200px;
    top: -50px;
    left: -50px;
    opacity: 0.6;
  }
  
  .circle.two {
    width: 150px;
    height: 150px;
    bottom: -30px;
    right: -30px;
    opacity: 0.4;
  }
  
  body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    margin: 0;
    padding: 20px;
  }
  
  /* Responsive adjustments */
  @media (max-width: 768px) {
    .auth-container {
      padding: 20px;
      margin: 20px auto;
    }
    
    .btn {
      width: 100%;
      margin-bottom: 10px;
      margin-right: 0;
    }
  }
</style>
 
</head>
<body>
  <div class="circle one"></div><div class="circle two"></div>
  <div class="auth-container">
    <h3>Set Monthly Budget</h3>

    <form method="post" action="${pageContext.request.contextPath}/setBudget">
      <div style="display:flex; gap:12px; flex-wrap:wrap;">
        <div style="min-width:160px;">
          <label>Category</label>
          <input name="category" class="auth-input" required>
        </div>

        <div style="min-width:120px;">
          <label>Month</label>
          <select name="month" class="auth-input" required>
            <% for (int m = 1; m <= 12; m++) { %>
              <option value="<%= m %>" <%= (m == selectedMonth) ? "selected" : "" %>><%= m %></option>
            <% } %>
          </select>
        </div>

        <div style="min-width:120px;">
          <label>Year</label>
          <input name="year" type="number" min="2020"
                 value="<%= selectedYear %>" class="auth-input" required>
        </div>

        <div style="min-width:160px;">
          <label>Amount</label>
          <input name="amount" type="number" step="0.01" class="auth-input" required>
        </div>
      </div>

      <div style="margin-top:14px;">
        <button class="btn" type="submit">Save Budget</button>
        <a class="btn ghost" href="${pageContext.request.contextPath}/viewBudgets">Cancel</a>
      </div>
    </form>
  </div>
</body>
</html>
