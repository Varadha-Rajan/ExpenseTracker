<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
  <title>Register</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <div class="circle one"></div>
  <div class="circle two"></div>

  <div class="auth-container">
    <h2>Register</h2>

    <c:if test="${not empty error}">
      <div style="color:#ffb3b3;margin-bottom:10px;">${error}</div>
    </c:if>

    <form method="post" action="auth">
      <input type="hidden" name="action" value="register"/>
      <input type="text" name="username" placeholder="Username" required/>
      <input type="email" name="email" placeholder="Email" required/>
      <input type="text" name="fullName" placeholder="Full name"/>
      <input type="password" name="password" placeholder="Password" required/>
      <button type="submit">Register</button>
    </form>

    <p style="margin-top:15px;">Already registered? <a href="login.jsp">Login</a></p>
  </div>
</body>
</html>
