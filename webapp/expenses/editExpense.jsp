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
  <title>Edit Expense</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.6.2/css/bootstrap.min.css">
  <style>
    /* Edit Expense Page Enhanced Glassmorphism CSS */
body {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    position: relative;
    overflow-x: hidden;
    padding: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
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
    width: 350px;
    height: 350px;
    top: -100px;
    left: -100px;
    background: radial-gradient(circle, rgba(108, 99, 255, 0.25) 0%, rgba(108, 99, 255, 0) 70%);
}

.circle.two {
    width: 450px;
    height: 450px;
    bottom: -150px;
    right: -100px;
    background: radial-gradient(circle, rgba(0, 201, 167, 0.25) 0%, rgba(0, 201, 167, 0) 70%);
    animation-delay: 3s;
}

/* Additional floating shapes */
.circle.three {
    width: 220px;
    height: 220px;
    top: 25%;
    left: 8%;
    background: radial-gradient(circle, rgba(255, 193, 7, 0.15) 0%, rgba(255, 193, 7, 0) 70%);
    animation-delay: 2s;
}

.circle.four {
    width: 180px;
    height: 180px;
    bottom: 35%;
    right: 12%;
    background: radial-gradient(circle, rgba(33, 150, 243, 0.15) 0%, rgba(33, 150, 243, 0) 70%);
    animation-delay: 4s;
}

@keyframes float {
    0%, 100% { 
        transform: translateY(0) rotate(0deg) scale(1); 
    }
    33% { 
        transform: translateY(-20px) rotate(120deg) scale(1.05); 
    }
    66% { 
        transform: translateY(10px) rotate(240deg) scale(0.95); 
    }
}

.auth-container {
    width: 800px;
    max-width: 95%;
    padding: 50px 40px;
    background: rgba(255, 255, 255, 0.95);
    border-radius: 24px;
    border: 1px solid rgba(255, 255, 255, 0.3);
    color: #2d3748;
    backdrop-filter: blur(20px);
    box-shadow: 
        0 25px 50px rgba(0, 0, 0, 0.15),
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
        rgba(255, 193, 7, 0.4), 
        transparent);
}

.auth-container::after {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle, rgba(255,255,255,0.05) 0%, transparent 70%);
    pointer-events: none;
}

@keyframes slideUp {
    from { 
        opacity: 0; 
        transform: translateY(30px) scale(0.96);
    }
    to { 
        opacity: 1; 
        transform: translateY(0) scale(1);
    }
}

/* Title Styles */
.title {
    text-align: center;
    color: #2d3748;
    font-weight: 700;
    font-size: 2.4rem;
    margin-bottom: 40px;
    position: relative;
    padding-bottom: 20px;
}

.title::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 50%;
    transform: translateX(-50%);
    width: 80px;
    height: 4px;
    background: linear-gradient(90deg, #ffc107, #6c63ff);
    border-radius: 2px;
}

/* Form Styles */
form {
    margin-top: 20px;
}

.form-row {
    display: flex;
    gap: 20px;
    flex-wrap: wrap;
    margin-bottom: 25px;
}

.form-row > div {
    flex: 1;
    min-width: 180px;
}

/* Label Styles */
label {
    color: #2d3748;
    font-weight: 600;
    font-size: 0.95rem;
    margin-bottom: 8px;
    display: block;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

/* Input Styles */
.auth-input {
    width: 100%;
    padding: 14px 16px;
    border: 2px solid rgba(255, 193, 7, 0.2);
    border-radius: 12px;
    font-size: 1rem;
    font-weight: 500;
    color: #2d3748;
    background: rgba(255, 255, 255, 0.9);
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    backdrop-filter: blur(10px);
}

.auth-input:focus {
    outline: none;
    border-color: #ffc107;
    background: rgba(255, 255, 255, 0.95);
    box-shadow: 
        0 0 0 3px rgba(255, 193, 7, 0.1),
        0 5px 20px rgba(255, 193, 7, 0.15);
    transform: translateY(-2px);
}

.auth-input::placeholder {
    color: #a0aec0;
    font-weight: 400;
}

/* Textarea Specific Styles */
textarea.auth-input {
    resize: vertical;
    min-height: 100px;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    line-height: 1.5;
}

/* Button Container */
.button-container {
    display: flex;
    gap: 15px;
    align-items: center;
    margin-top: 30px;
    flex-wrap: wrap;
}

/* Update Button */
.btn.save {
    background: linear-gradient(135deg, #ffc107 0%, #ff9800 100%);
    color: white;
    border: none;
    padding: 16px 32px;
    border-radius: 12px;
    font-weight: 600;
    font-size: 1.1rem;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    position: relative;
    overflow: hidden;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    min-width: 160px;
    justify-content: center;
}

.btn.save::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
    transition: left 0.5s;
}

.btn.save:hover::before {
    left: 100%;
}

.btn.save:hover {
    transform: translateY(-3px);
    box-shadow: 0 10px 25px rgba(255, 193, 7, 0.4);
    text-decoration: none;
    color: white;
}

.btn.save:active {
    transform: translateY(-1px);
}

/* Cancel Button */
.btn.cancel {
    background: rgba(255, 255, 255, 0.8);
    color: #6c63ff;
    border: 2px solid rgba(108, 99, 255, 0.2);
    padding: 14px 28px;
    border-radius: 12px;
    font-weight: 600;
    font-size: 1rem;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    min-width: 140px;
    justify-content: center;
    backdrop-filter: blur(10px);
}

.btn.cancel:hover {
    background: rgba(108, 99, 255, 0.05);
    border-color: rgba(108, 99, 255, 0.4);
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(108, 99, 255, 0.2);
    text-decoration: none;
    color: #6c63ff;
}

/* Form Group Enhancements */
.form-group {
    margin-bottom: 25px;
    position: relative;
}

/* Input Icons */
.input-with-icon {
    position: relative;
}

.input-with-icon .auth-input {
    padding-left: 45px;
}

.input-with-icon i {
    position: absolute;
    left: 16px;
    top: 50%;
    transform: translateY(-50%);
    color: #ffc107;
    font-size: 1.1rem;
}

/* Validation Styles */
.auth-input:invalid:not(:focus) {
    border-color: rgba(239, 68, 68, 0.3);
}

.auth-input:valid:not(:focus) {
    border-color: rgba(72, 187, 120, 0.3);
}

/* Amount Input Specific */
input[type="number"].auth-input {
    font-weight: 600;
    font-size: 1.1rem;
}

/* Category Suggestions */
.category-suggestions {
    display: flex;
    gap: 8px;
    flex-wrap: wrap;
    margin-top: 8px;
}

.category-chip {
    background: rgba(255, 193, 7, 0.1);
    color: #b28704;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease;
    border: 1px solid rgba(255, 193, 7, 0.3);
}

.category-chip:hover {
    background: rgba(255, 193, 7, 0.2);
    transform: translateY(-1px);
}

/* Expense Preview Card */
.expense-preview {
    background: rgba(255, 193, 7, 0.05);
    border: 2px dashed rgba(255, 193, 7, 0.3);
    border-radius: 12px;
    padding: 20px;
    margin-bottom: 25px;
    text-align: center;
}

.preview-title {
    color: #b28704;
    font-weight: 600;
    margin-bottom: 10px;
    font-size: 0.9rem;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.preview-amount {
    font-size: 1.8rem;
    font-weight: 700;
    color: #ffc107;
    margin-bottom: 5px;
}

.preview-details {
    color: #718096;
    font-size: 0.9rem;
}

/* Responsive Design */
@media (max-width: 768px) {
    .auth-container {
        padding: 30px 25px;
        margin: 20px auto;
    }
    
    .title {
        font-size: 2rem;
        margin-bottom: 30px;
    }
    
    .form-row {
        gap: 15px;
    }
    
    .form-row > div {
        min-width: 100%;
    }
    
    .button-container {
        flex-direction: column;
        width: 100%;
    }
    
    .btn.save,
    .btn.cancel {
        width: 100%;
        min-width: auto;
    }
    
    .circle.one,
    .circle.two,
    .circle.three,
    .circle.four {
        display: none;
    }
}

/* Loading State */
.btn.loading {
    position: relative;
    color: transparent;
}

.btn.loading::after {
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

/* Update Animation */
@keyframes updatePulse {
    0% { transform: scale(1); }
    50% { transform: scale(1.02); }
    100% { transform: scale(1); }
}

.update-animation {
    animation: updatePulse 0.6s ease;
}
  </style>
</head>
<body>
  <div class="circle one"></div>
  <div class="circle two"></div>
  <div class="circle three"></div>
  <div class="circle four"></div>

  <div class="auth-container">
    <h3 class="title"> Edit Expense</h3>

    <!-- Expense Preview -->
    <div class="expense-preview">
      <div class="preview-title">Editing Expense</div>
      <div class="preview-amount">$${expense.amount}</div>
      <div class="preview-details">${expense.category}  ${expense.date}</div>
    </div>

    <form method="post" action="${pageContext.request.contextPath}/editExpense">
      <input type="hidden" name="id" value="${expense.id}">

      <div class="form-row">
        <div class="form-group input-with-icon">
          <label> Date</label>
          <i class="fas fa-calendar-alt"></i>
          <input type="date" name="date" class="auth-input" value="${expense.date}" required>
        </div>
        <div class="form-group input-with-icon">
          <label> Category</label>
          <i class="fas fa-tag"></i>
          <input type="text" name="category" class="auth-input" value="${expense.category}" placeholder="e.g., Food, Transport, Entertainment" required>
          <!-- Category suggestions -->
          <div class="category-suggestions">
            <div class="category-chip" onclick="document.querySelector('input[name=\"category\"]').value='Food'">Food</div>
            <div class="category-chip" onclick="document.querySelector('input[name=\"category\"]').value='Transport'">Transport</div>
            <div class="category-chip" onclick="document.querySelector('input[name=\"category\"]').value='Shopping'">Shopping</div>
            <div class="category-chip" onclick="document.querySelector('input[name=\"category\"]').value='Bills'">Bills</div>
          </div>
        </div>
        <div class="form-group input-with-icon">
          <label> Amount</label>
          <i class="fas fa-dollar-sign"></i>
          <input type="number" step="0.01" name="amount" class="auth-input" value="${expense.amount}" placeholder="0.00" required>
        </div>
      </div>

      <div class="form-group input-with-icon">
        <label> Notes</label>
        <i class="fas fa-sticky-note"></i>
        <textarea name="notes" rows="3" class="auth-input" placeholder="Add any additional details about this expense...">${expense.notes}</textarea>
      </div>

      <div class="button-container">
        <button class="btn save" type="submit" id="updateBtn">
          <i class="fas fa-sync-alt"></i> Update Expense
        </button>
        <a class="btn cancel" href="${pageContext.request.contextPath}/expenses/viewExpenses.jsp">
          <i class="fas fa-arrow-left"></i> Cancel
        </a>
      </div>
    </form>
  </div>

  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/js/all.min.js"></script>
  
  <script>
    // Add loading state to form submission
    document.querySelector('form').addEventListener('submit', function(e) {
      const updateBtn = document.getElementById('updateBtn');
      updateBtn.classList.add('loading');
      updateBtn.innerHTML = '<i class="fas fa-spinner"></i> Updating...';
    });

    // Add update animation on input changes
    const inputs = document.querySelectorAll('.auth-input');
    inputs.forEach(input => {
      input.addEventListener('input', function() {
        this.classList.add('update-animation');
        setTimeout(() => {
          this.classList.remove('update-animation');
        }, 600);
      });
    });

    // Format date for display
    const dateInput = document.querySelector('input[type="date"]');
    if(dateInput.value) {
      const formattedDate = new Date(dateInput.value).toLocaleDateString();
      document.querySelector('.preview-details').textContent = 
        `${document.querySelector('input[name="category"]').value} • ${formattedDate}`;
    }
  </script>
</body>
</html>
