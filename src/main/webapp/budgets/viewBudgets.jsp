<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.User" %>

<%
    User u = (User) session.getAttribute("user");
    if (u == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>My Budgets</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.6.2/css/bootstrap.min.css">
  <style>
    body {
      background: linear-gradient(120deg, #0f2027, #203a43, #2c5364);
      font-family: "Poppins", sans-serif;
      color: #fff;
    }

    .auth-container {
      max-width: 1000px;
      width: 95%;
      margin: 60px auto;
      padding: 30px 40px;
      background: rgba(255, 255, 255, 0.12);
      border: 1px solid rgba(255, 255, 255, 0.2);
      border-radius: 20px;
      backdrop-filter: blur(14px);
      box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
      color: #fff;
      animation: fadeIn 0.7s ease;
    }

    .auth-container h3 {
      font-weight: 600;
      margin-bottom: 20px;
      color: #fff;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 15px;
      background: rgba(255,255,255,0.08);
      border-radius: 10px;
      overflow: hidden;
    }

    th, td {
      text-align: center;
      padding: 12px;
      color: #fff;
    }

    thead {
      background: rgba(255,255,255,0.18);
    }

    tbody tr:nth-child(even) {
      background: rgba(255,255,255,0.06);
    }

    tbody tr:hover {
      background: rgba(255,255,255,0.2);
      transition: 0.3s;
    }

    .btn {
      padding: 8px 15px;
      border-radius: 8px;
      font-weight: 600;
      transition: all 0.3s ease;
      text-decoration: none;
    }

    .btn-primary {
      background: linear-gradient(90deg, #6c63ff, #00c9a7);
      color: #fff;
      border: none;
    }

    .btn-primary:hover {
      transform: translateY(-2px);
      box-shadow: 0 0 15px rgba(108,99,255,0.5);
    }

    .btn-outline {
      border: 1px solid rgba(255,255,255,0.5);
      color: #fff;
      background: transparent;
    }

    .btn-outline:hover {
      background: rgba(255,255,255,0.15);
    }

    .progress {
      height: 14px;
      border-radius: 7px;
      background: rgba(255,255,255,0.2);
      overflow: hidden;
      margin-top: 4px;
    }

    .progress-bar {
      height: 14px;
      text-align: right;
      color: #fff;
      font-size: 12px;
      line-height: 14px;
      padding-right: 5px;
      background: linear-gradient(90deg,#6c63ff,#00c9a7);
      border-radius: 7px;
    }

    .action-edit {
      background: rgba(108,99,255,0.2);
      color: #bdbaff;
    }

    .action-delete {
      background: rgba(255,99,99,0.2);
      color: #ffbaba;
    }

    .action-edit:hover, .action-delete:hover {
      transform: scale(1.05);
    }

    @keyframes fadeIn {
      from {opacity: 0; transform: translateY(30px);}
      to {opacity: 1; transform: translateY(0);}
    }
  </style>
</head>

<body>
  <div class="circle one"></div>
  <div class="circle two"></div>

  <div class="auth-container">
    <div class="d-flex justify-content-between align-items-center flex-wrap">
      <h3>Budgets for ${month}/${year}</h3>
      <div>
        <a href="${pageContext.request.contextPath}/budgets/setBudget.jsp" class="btn btn-primary">+ Set Budget</a>
        <a href="${pageContext.request.contextPath}/profile.jsp" class="btn btn-outline">Back</a>
      </div>
    </div>

    <c:if test="${empty budgets}">
      <p class="mt-3 text-center">No budgets found for this month. 
      <a href="${pageContext.request.contextPath}/budgets/setBudget.jsp" style="color:#00c9a7;">Create one</a>.</p>
    </c:if>

    <c:if test="${not empty budgets}">
      <table class="table table-borderless">
        <thead>
          <tr>
            <th>Category</th>
            <th>Budget (₹)</th>
            <th>Spent (₹)</th>
            <th>Remaining (₹)</th>
            <th style="width: 200px;">Progress</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="b" items="${budgets}">
            <c:set var="spent" value="${spentMap[b.id]}" />
            <c:set var="percent" value="${percentMap[b.id]}" />
            <c:if test="${spent == null}"><c:set var="spent" value="0.0" /></c:if>
            <c:if test="${percent == null}"><c:set var="percent" value="0.0" /></c:if>
            <c:set var="remaining" value="${b.amount - spent}" />

            <tr>
              <td>${b.category}</td>
              <td><fmt:formatNumber value="${b.amount}" type="number" maxFractionDigits="2" /></td>
              <td><fmt:formatNumber value="${spent}" type="number" maxFractionDigits="2" /></td>
              <td><fmt:formatNumber value="${remaining}" type="number" maxFractionDigits="2" /></td>
              <td>
                <div class="progress">
                  <div class="progress-bar" style="width:${percent}%;"></div>
                </div>
                <small><fmt:formatNumber value="${percent}" type="number" maxFractionDigits="0" />%</small>
              </td>
              <td>
                <a href="${pageContext.request.contextPath}/editBudget?id=${b.id}" class="btn action-edit">Edit</a>
                <a href="${pageContext.request.contextPath}/deleteBudget?id=${b.id}" class="btn action-delete" onclick="return confirm('Delete this budget?');">Delete</a>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </c:if>
  </div>
</body>
</html>
