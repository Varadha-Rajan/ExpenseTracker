<%@ page session="true" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.User" %>
<%
    User u = (User) session.getAttribute("user");
    if (u == null) { response.sendRedirect("login.jsp"); return; }

    Map<String, Double> data = (Map<String, Double>) request.getAttribute("data");
    if (data == null) { data = new java.util.LinkedHashMap<>(); }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Reports & Analytics</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <style>
    /* Reports & Analytics Enhanced Glassmorphism CSS */
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
    width: 250px;
    height: 250px;
    top: 50%;
    left: 10%;
    background: radial-gradient(circle, rgba(255, 107, 107, 0.15) 0%, rgba(255, 107, 107, 0) 70%);
    animation-delay: 1.5s;
}

.circle.four {
    width: 180px;
    height: 180px;
    bottom: 30%;
    right: 15%;
    background: radial-gradient(circle, rgba(255, 206, 86, 0.15) 0%, rgba(255, 206, 86, 0) 70%);
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
    width: 1100px;
    max-width: 95%;
    margin: 30px auto;
    padding: 40px;
    background: rgba(255, 255, 255, 0.08);
    border-radius: 24px;
    border: 1px solid rgba(255, 255, 255, 0.2);
    color: #fff;
    backdrop-filter: blur(25px);
    box-shadow: 
        0 20px 40px rgba(0, 0, 0, 0.3),
        inset 0 1px 0 rgba(255, 255, 255, 0.1);
    animation: slideIn 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94);
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
        rgba(255, 255, 255, 0.4), 
        transparent);
}

.auth-container::after {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle, rgba(255,255,255,0.03) 0%, transparent 70%);
    pointer-events: none;
}

@keyframes slideIn {
    from { 
        opacity: 0; 
        transform: translateY(30px) scale(0.98);
    }
    to { 
        opacity: 1; 
        transform: translateY(0) scale(1);
    }
}

/* Header Styles */
.header-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
    padding-bottom: 20px;
    border-bottom: 1px solid rgba(255, 255, 255, 0.15);
    position: relative;
}

.header-container::after {
    content: '';
    position: absolute;
    bottom: -1px;
    left: 0;
    width: 100px;
    height: 3px;
    background: linear-gradient(90deg, #6c63ff, #00c9a7);
    border-radius: 3px;
}

h3 {
    color: #fff;
    font-weight: 700;
    font-size: 2.4rem;
    margin: 0;
    text-shadow: 0 2px 10px rgba(0,0,0,0.3);
    background: linear-gradient(135deg, #fff 0%, #e0f7fa 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

/* Back Button */
.back-btn {
    background: rgba(255, 255, 255, 0.1) !important;
    border: 1px solid rgba(255, 255, 255, 0.25) !important;
    color: #fff !important;
    padding: 12px 24px !important;
    border-radius: 12px !important;
    text-decoration: none !important;
    font-weight: 600 !important;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
    backdrop-filter: blur(10px) !important;
    position: relative !important;
    overflow: hidden !important;
}

.back-btn::before {
    content: '' !important;
    position: absolute !important;
    top: 0 !important;
    left: -100% !important;
    width: 100% !important;
    height: 100% !important;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.1), transparent) !important;
    transition: left 0.5s !important;
}

.back-btn:hover::before {
    left: 100% !important;
}

.back-btn:hover {
    background: rgba(255, 255, 255, 0.15) !important;
    border-color: rgba(108, 99, 255, 0.5) !important;
    transform: translateY(-2px) !important;
    box-shadow: 0 5px 15px rgba(108, 99, 255, 0.3) !important;
    text-decoration: none !important;
    color: #fff !important;
}

/* Description Text */
.description {
    color: #dfeff2;
    font-size: 1.1rem;
    margin-bottom: 30px;
    text-align: center;
    font-weight: 500;
    text-shadow: 0 1px 2px rgba(0,0,0,0.2);
    padding: 15px;
    background: rgba(255, 255, 255, 0.05);
    border-radius: 12px;
    border-left: 3px solid #00c9a7;
}

/* Chart Container */
.chart-container {
    background: rgba(255, 255, 255, 0.06);
    border-radius: 16px;
    padding: 25px;
    margin-top: 20px;
    border: 1px solid rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(10px);
    box-shadow: 
        inset 0 2px 4px rgba(0, 0, 0, 0.1),
        0 5px 15px rgba(0, 0, 0, 0.2);
    position: relative;
    overflow: hidden;
}

.chart-container::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 1px;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
}

/* Chart.js Customizations */
#chart {
    border-radius: 12px;
    padding: 10px;
}

/* Enhanced Chart Legend */
.chartjs-legend {
    background: rgba(255, 255, 255, 0.08) !important;
    border-radius: 10px !important;
    padding: 15px !important;
    backdrop-filter: blur(10px) !important;
}

/* Additional Stats Section */
.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
    margin-top: 30px;
}

.stat-card {
    background: rgba(255, 255, 255, 0.08);
    border-radius: 16px;
    padding: 20px;
    text-align: center;
    backdrop-filter: blur(10px);
    border: 1px solid rgba(255, 255, 255, 0.1);
    transition: all 0.3s ease;
}

.stat-card:hover {
    transform: translateY(-5px);
    background: rgba(255, 255, 255, 0.12);
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
}

.stat-value {
    font-size: 2rem;
    font-weight: 700;
    color: #00c9a7;
    margin-bottom: 5px;
}

.stat-label {
    font-size: 0.9rem;
    color: #dfeff2;
    font-weight: 500;
}

/* Responsive Design */
@media (max-width: 768px) {
    .auth-container {
        padding: 25px 20px;
        margin: 20px auto;
    }
    
    h3 {
        font-size: 1.8rem;
        text-align: center;
    }
    
    .header-container {
        flex-direction: column;
        gap: 15px;
        text-align: center;
    }
    
    .header-container::after {
        left: 50%;
        transform: translateX(-50%);
    }
    
    .circle.one,
    .circle.two,
    .circle.three,
    .circle.four {
        display: none;
    }
    
    .chart-container {
        padding: 15px;
    }
    
    .stats-grid {
        grid-template-columns: 1fr;
    }
}

/* Animation for chart loading */
@keyframes chartLoad {
    from {
        opacity: 0;
        transform: scale(0.9);
    }
    to {
        opacity: 1;
        transform: scale(1);
    }
}

#chart {
    animation: chartLoad 1s ease-out;
}

/* Print Styles */
@media print {
    .circle,
    .back-btn {
        display: none;
    }
    
    .auth-container {
        background: white;
        color: black;
        box-shadow: none;
    }
} padding:8px; }
  </style>
</head>
<body>
  <div class="circle one"></div>
  <div class="circle two"></div>
  <div class="circle three"></div>
  <div class="circle four"></div>

  <div class="auth-container">
    <div class="header-container">
      <h3>Reports & Analytics  <%= u.getUsername() %></h3>
      <a href="{pageContext.request.contextPath}/profile.jsp" class="back-btn">
        Back to Profile
      </a>
    </div>

    <p class="description">Expense distribution by category - Visual insights into your spending patterns</p>

    <div class="chart-container">
      <canvas id="chart" width="800" height="400"></canvas>
    </div>

    <!-- Optional: Add stats grid if you have additional data -->
    <!--
    <div class="stats-grid">
      <div class="stat-card">
        <div class="stat-value">$<%= data.values().stream().mapToDouble(Double::doubleValue).sum() %></div>
        <div class="stat-label">Total Expenses</div>
      </div>
      <div class="stat-card">
        <div class="stat-value"><%= data.size() %></div>
        <div class="stat-label">Categories</div>
      </div>
    </div>
    -->
  </div>

  <script>
    // build labels and values safely from server-provided map
    const labels = [
      <% boolean first=true;
         for (String k : data.keySet()) {
            if (!first) out.print(","); first=false;
            out.print("'" + k.replace("'", "\\'") + "'");
         }
      %>
    ];

    const values = [
      <% first=true;
         for (Double v : data.values()) {
            if (!first) out.print(","); first=false;
            out.print(v == null ? "0" : v);
         }
      %>
    ];

    // fall back if empty
    const finalLabels = labels.length ? labels : ['No data'];
    const finalValues = values.length ? values : [1];

    const ctx = document.getElementById('chart').getContext('2d');
    new Chart(ctx, {
        type: 'pie',
        data: {
            labels: finalLabels,
            datasets: [{
                data: finalValues,
                backgroundColor: ['#6c63ff','#00c9a7','#ff9a8b','#ffc75f','#f9f871','#9ad0f5','#b8a2ff']
            }]
        },
        options: {
            plugins: { legend: { labels: { color: 'white' } } }
        }
    });
  </script>
</body>
</html>
