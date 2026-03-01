<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
  <title>Login</title>
  <link rel="stylesheet" href="style.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: linear-gradient(135deg, #1a2a6c, #b21f1f, #fdbb2d);
            background-size: 400% 400%;
            animation: gradient 15s ease infinite;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            position: relative;
        }

        @keyframes gradient {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .circle {
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            animation: float 6s ease-in-out infinite;
        }

        .circle.one {
            width: 150px;
            height: 150px;
            top: 10%;
            left: 10%;
            animation-delay: 0s;
        }

        .circle.two {
            width: 200px;
            height: 200px;
            bottom: 15%;
            right: 10%;
            animation-delay: 2s;
        }

        @keyframes float {
            0% { transform: translateY(0) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
            100% { transform: translateY(0) rotate(360deg); }
        }

        .auth-container {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 450px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            z-index: 10;
            position: relative;
            overflow: hidden;
        }

        .auth-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, #1a2a6c, #b21f1f, #fdbb2d);
        }

        h1 {
            text-align: center;
            color: #1a2a6c;
            margin-bottom: 30px;
            font-size: 28px;
            font-weight: 700;
        }

        h2 {
            text-align: center;
            color: #1a2a6c;
            margin-bottom: 30px;
            font-size: 24px;
            font-weight: 600;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        input {
            padding: 15px;
            margin-bottom: 20px;
            border: none;
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.8);
            box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.1);
            font-size: 16px;
            transition: all 0.3s ease;
        }

        input:focus {
            outline: none;
            box-shadow: 0 0 0 2px #1a2a6c, inset 0 2px 5px rgba(0, 0, 0, 0.1);
            background: white;
        }

        button {
            padding: 15px;
            border: none;
            border-radius: 10px;
            background: linear-gradient(90deg, #1a2a6c, #b21f1f);
            color: white;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        button:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
        }

        p {
            text-align: center;
            margin-top: 20px;
            color: #555;
        }

        a {
            color: #1a2a6c;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        a:hover {
            color: #b21f1f;
            text-decoration: underline;
        }

        .success-message {
            color: #2e7d32;
            background-color: #e8f5e9;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            border-left: 4px solid #2e7d32;
        }

        .error-message {
            color: #c62828;
            background-color: #ffebee;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            border-left: 4px solid #c62828;
        }

        .app-title {
            position: absolute;
            top: 20px;
            left: 0;
            width: 100%;
            text-align: center;
            color: white;
            font-size: 36px;
            font-weight: 700;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            z-index: 5;
        }

        @media (max-width: 600px) {
            .auth-container {
                margin: 20px;
                padding: 30px 20px;
            }
            
            .app-title {
                font-size: 28px;
                top: 10px;
            }
        }
    </style>
</head>
<body>
    <h1 class="app-title">Expense Tracking & Budgeting</h1>
    
    <div class="circle one"></div>
    <div class="circle two"></div>

    <div class="auth-container">
        <h2>Login</h2>

        <!-- Success message for registered users -->
        <div class="success-message" style="display: none;">Registered successfully!</div>

        <!-- Error message for login failures -->
        <div class="error-message" style="display: none;">Invalid username or password</div>

        <form method="post" action="auth">
            <input type="hidden" name="action" value="login"/>
            <input type="text" name="username" placeholder="Username" required/>
            <input type="password" name="password" placeholder="Password" required/>
            <button type="submit">Login</button>
        </form>

        <p>No account? <a href="register.jsp">Register</a></p>
    </div>

    <script>
        // This would typically be handled by your JSP, but for demonstration:
        // Uncomment the following lines to show messages as needed
        
        // To show success message after registration:
        // document.querySelector('.success-message').style.display = 'block';
        
        // To show error message on login failure:
        // document.querySelector('.error-message').style.display = 'block';
    </script>
</body>
</html>
