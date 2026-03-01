<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.User" %>
<%
    User u = (User) session.getAttribute("user");
    if(u==null){ response.sendRedirect("../login.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Edit Budget</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.6.2/css/bootstrap.min.css">
  <style>
    .auth-container { width:720px; max-width:95%; padding:28px; color:#082033; background: rgba(255,255,255,0.95); }
    label{font-weight:600;color:#27455a;}
  </style>
</head>
<body>
  <div class="circle one"></div><div class="circle two"></div>
  <div class="auth-container">
    <h3>Edit Budget</h3>
    <form method="post" action="${pageContext.request.contextPath}/editBudget">
      <input type="hidden" name="id" value="${budget.id}">
      <div style="display:flex; gap:12px; flex-wrap:wrap;">
        <div style="min-width:160px;">
          <label>Category</label>
          <input name="category" class="auth-input" value="${budget.category}" required>
        </div>
        <div style="min-width:120px;">
          <label>Month</label>
          <select name="month" class="auth-input">
            <c:forEach begin="1" end="12" var="m">
              <option value="${m}" ${m == budget.periodMonth ? 'selected' : ''}>${m}</option>
            </c:forEach>
          </select>
        </div>
        <div style="min-width:120px;">
          <label>Year</label>
          <input name="year" type="number" min="2020" value="${budget.periodYear}" class="auth-input" required>
        </div>
        <div style="min-width:160px;">
          <label>Amount</label>
          <input name="amount" type="number" step="0.01" class="auth-input" value="${budget.amount}" required>
        </div>
      </div>
      <div style="margin-top:14px;">
        <button class="btn" type="submit">Save</button>
        <a class="btn ghost" href="${pageContext.request.contextPath}/viewBudgets">Cancel</a>
      </div>
    </form>
  </div>
</body>
</html>
