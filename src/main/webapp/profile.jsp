<%@ page import="model.User" %>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Profile</title>

    <!-- Common glassmorphism / gradient CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
    <link rel="stylesheet"
          href="https://stackpath.bootstrapcdn.com/bootstrap/4.6.2/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/js/all.min.js"></script>

    <style>
       /* Profile Page Enhanced Glassmorphism CSS */
body {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    position: relative;
    overflow-x: hidden;
}

/* Floating gradient circles background */
.circle {
    position: absolute;
    border-radius: 50%;
    background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 70%);
    animation: float 6s ease-in-out infinite;
    z-index: -1;
}

.circle.one {
    width: 300px;
    height: 300px;
    top: -100px;
    left: -100px;
    background: radial-gradient(circle, rgba(108, 99, 255, 0.2) 0%, rgba(108, 99, 255, 0) 70%);
}

.circle.two {
    width: 400px;
    height: 400px;
    bottom: -150px;
    right: -100px;
    background: radial-gradient(circle, rgba(0, 201, 167, 0.2) 0%, rgba(0, 201, 167, 0) 70%);
    animation-delay: 2s;
}

@keyframes float {
    0%, 100% { transform: translateY(0) scale(1); }
    50% { transform: translateY(-20px) scale(1.05); }
}

.auth-container {
    width: 750px;
    max-width: 95%;
    margin: 40px auto;
    padding: 50px 40px;
    background: rgba(255, 255, 255, 0.08);
    border-radius: 24px;
    border: 1px solid rgba(255, 255, 255, 0.2);
    color: #fff;
    backdrop-filter: blur(20px);
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
    animation: slideUp 0.8s ease-out;
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
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent);
}

@keyframes slideUp {
    from { 
        opacity: 0; 
        transform: translateY(40px) scale(0.95);
    }
    to { 
        opacity: 1; 
        transform: translateY(0) scale(1);
    }
}

h3 {
    text-align: center;
    color: #fff;
    font-weight: 700;
    margin-bottom: 30px;
    font-size: 2.2rem;
    text-shadow: 0 2px 10px rgba(0,0,0,0.3);
    background: linear-gradient(135deg, #fff 0%, #e0f7fa 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

h5 {
    color: #fff;
    font-weight: 600;
    margin-bottom: 25px;
    font-size: 1.3rem;
    display: flex;
    align-items: center;
    gap: 10px;
}

h5 i {
    color: #00c9a7;
}

label {
    font-weight: 600;
    color: #e3f2fd;
    margin-bottom: 8px;
    font-size: 0.95rem;
    text-shadow: 0 1px 2px rgba(0,0,0,0.2);
}

input.form-control {
    background: rgba(255, 255, 255, 0.12);
    color: #fff;
    border: 1px solid rgba(255, 255, 255, 0.2);
    border-radius: 12px;
    padding: 14px 16px;
    font-size: 1rem;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    backdrop-filter: blur(10px);
}

input.form-control::placeholder {
    color: rgba(255, 255, 255, 0.6);
}

input.form-control:focus {
    background: rgba(255, 255, 255, 0.18);
    border-color: rgba(108, 99, 255, 0.6);
    box-shadow: 0 0 0 3px rgba(108, 99, 255, 0.25), 0 5px 20px rgba(108, 99, 255, 0.3);
    color: #fff;
    transform: translateY(-2px);
}

.btn-primary {
    background: linear-gradient(135deg, #6c63ff 0%, #00c9a7 100%);
    border: none;
    color: #fff;
    font-weight: 600;
    border-radius: 12px;
    padding: 14px 20px;
    font-size: 1.1rem;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    position: relative;
    overflow: hidden;
}

.btn-primary::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
    transition: left 0.5s;
}

.btn-primary:hover::before {
    left: 100%;
}

.btn-primary:hover {
    transform: translateY(-3px);
    box-shadow: 0 10px 25px rgba(108, 99, 255, 0.4);
}

.btn-warning {
    background: linear-gradient(135deg, #ffb300 0%, #ff9100 100%);
    border: none;
    font-weight: 600;
    border-radius: 12px;
    padding: 14px 20px;
    font-size: 1.1rem;
    color: #fff;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.btn-warning:hover {
    transform: translateY(-3px);
    box-shadow: 0 10px 25px rgba(255, 179, 0, 0.4);
    color: #fff;
}

.divider {
    border-top: 1px solid rgba(255, 255, 255, 0.15);
    margin: 35px 0;
    position: relative;
}

.divider::after {
    content: '';
    position: absolute;
    top: -2px;
    left: 50%;
    transform: translateX(-50%);
    width: 60px;
    height: 3px;
    background: linear-gradient(90deg, #6c63ff, #00c9a7);
    border-radius: 3px;
}

.actions {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 15px;
    margin-top: 30px;
}

a.btn-small {
    font-size: 0.95rem;
    padding: 14px 20px;
    border-radius: 12px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    font-weight: 600;
    text-decoration: none;
    text-align: center;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    backdrop-filter: blur(10px);
    border: 1px solid rgba(255, 255, 255, 0.1);
    position: relative;
    overflow: hidden;
}

a.btn-small::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.1), transparent);
    transition: left 0.5s;
}

a.btn-small:hover::before {
    left: 100%;
}

a.btn-small:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
    text-decoration: none;
}

/* Specific button styles */
a.btn-small:first-child {
    background: linear-gradient(135deg, #00c9a7 0%, #6c63ff 100%);
}

a.btn-small:nth-child(2) {
    background: linear-gradient(135deg, #6c63ff 0%, #00c9a7 100%);
}

a.btn-small:nth-child(3) {
    background: linear-gradient(135deg, #00c9a7 0%, #2196f3 100%);
}

a.btn-small.btn-danger {
    background: linear-gradient(135deg, #ff4b5c 0%, #ff6b6b 100%);
    grid-column: 1 / -1;
    margin-top: 10px;
}

/* Alert enhancements */
.alert {
    border: none;
    border-radius: 12px;
    padding: 16px 20px;
    font-weight: 500;
    backdrop-filter: blur(10px);
    border-left: 4px solid;
}

.alert-success {
    background: rgba(46, 204, 113, 0.15);
    color: #2ecc71;
    border-left-color: #2ecc71;
}

.alert-danger {
    background: rgba(231, 76, 60, 0.15);
    color: #e74c3c;
    border-left-color: #e74c3c;
}

/* Responsive design */
@media (max-width: 768px) {
    .auth-container {
        padding: 30px 20px;
        margin: 20px auto;
    }
    
    h3 {
        font-size: 1.8rem;
    }
    
    .actions {
        grid-template-columns: 1fr;
    }
    
    .circle.one, .circle.two {
        display: none;
    }
}

/* Form group enhancements */
.form-group {
    margin-bottom: 25px;
    position: relative;
}

/* Loading animation for buttons */
.btn-loading {
    position: relative;
    color: transparent !important;
}

.btn-loading::after {
    content: '';
    position: absolute;
    width: 20px;
    height: 20px;
    top: 50%;
    left: 50%;
    margin-left: -10px;
    margin-top: -10px;
    border: 2px solid #ffffff;
    border-radius: 50%;
    border-top-color: transparent;
    animation: spin 1s ease-in-out infinite;
}

@keyframes spin {
    to { transform: rotate(360deg); }
}
    </style>
</head>

<body>
    <!-- Floating gradient circles background -->
    <div class="circle one"></div>
    <div class="circle two"></div>

    <div class="auth-container">
        <h3>Welcome, <%= user.getUsername() %></h3>

        <!-- Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <!-- Profile Update -->
        <form method="post" action="profile">
            <div class="form-group">
                <label>Email</label>
                <input name="email" type="email" class="form-control"
                       value="<%= user.getEmail() != null ? user.getEmail() : "" %>" required/>
            </div>
            <div class="form-group">
                <label>Full Name</label>
                <input name="fullName" class="form-control"
                       value="<%= user.getFullName() != null ? user.getFullName() : "" %>"/>
            </div>
            <button type="submit" class="btn btn-primary btn-block mt-3">Update Profile</button>
        </form>

        <div class="divider"></div>

        <!-- Password Change -->
        <h5 class="text-light mb-3"><i class="fa fa-lock"></i> Change Password</h5>
        <c:if test="${not empty errorChange}">
            <div class="alert alert-danger">${errorChange}</div>
        </c:if>
        <c:if test="${not empty successChange}">
            <div class="alert alert-success">${successChange}</div>
        </c:if>

        <form method="post" action="auth">
            <input type="hidden" name="action" value="changePassword"/>
            <div class="form-group">
                <label>Current Password</label>
                <input name="currentPassword" type="password" class="form-control" required/>
            </div>
            <div class="form-group">
                <label>New Password</label>
                <input name="newPassword" type="password" class="form-control" required/>
            </div>
            <button type="submit" class="btn btn-warning btn-block mt-3">Change Password</button>
        </form>

        <div class="divider"></div>

        <!-- Module Connections -->
        <div class="actions">
            <a href="viewExpenses" class="btn-small"
               style="background:linear-gradient(90deg,#00c9a7,#6c63ff); color:white;">
               <i class="fa-solid fa-wallet"></i> Manage My Expenses
            </a>

            <a href="viewBudgets" class="btn-small"
               style="background:linear-gradient(90deg,#6c63ff,#00c9a7); color:white;">
               <i class="fa-solid fa-coins"></i> My Budgets
            </a>

            <a href="ReportServlet" class="btn-small"
               style="background:linear-gradient(90deg,#00c9a7,#6c63ff); color:white;">
               <i class="fa-solid fa-chart-line"></i> Reports & Analytics
            </a>

            <a href="logout" class="btn-small btn-danger"
               style="background:#ff4b5c; color:white;">
               <i class="fa-solid fa-right-from-bracket"></i> Logout
            </a>
        </div>
    </div>
</body>
</html>
