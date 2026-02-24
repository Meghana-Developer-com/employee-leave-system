<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome - GM University Leave Management System</title>
    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
            background: linear-gradient(135deg, #e0f7fa 0%, #b2dfdb 100%);
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: #004d40;
        }
        .container {
            text-align: center;
            background: rgba(255, 255, 255, 0.92);
            padding: 60px 50px;
            border-radius: 16px;
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
            max-width: 700px;
            margin: 40px;
        }
        h1 {
            font-size: 3.2rem;
            margin-bottom: 1rem;
            color: #004d40;
        }
        p {
            font-size: 1.3rem;
            margin-bottom: 3rem;
            color: #555;
        }
        .buttons {
            display: flex;
            justify-content: center;
            gap: 3rem;
            flex-wrap: wrap;
        }
        .btn {
            display: inline-block;
            padding: 18px 60px;
            font-size: 1.4rem;
            font-weight: bold;
            text-decoration: none;
            border-radius: 12px;
            transition: all 0.3s ease;
            min-width: 220px;
            text-align: center;
        }
        .btn-login {
            background: #00695c;
            color: white;
        }
        .btn-login:hover {
            background: #004d40;
            transform: translateY(-4px);
            box-shadow: 0 8px 20px rgba(0, 105, 92, 0.3);
        }
        .btn-register {
            background: #0288d1;
            color: white;
        }
        .btn-register:hover {
            background: #0277bd;
            transform: translateY(-4px);
            box-shadow: 0 8px 20px rgba(2, 136, 209, 0.3);
        }
        footer {
            margin-top: 4rem;
            color: #555;
            font-size: 0.95rem;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Welcome to GM University</h1>
        <p>Leave Management System</p>
        <p style="font-size:1.1rem; margin-bottom:2.5rem;">
            Securely apply for leaves, track status, and manage approvals.
        </p>

        <div class="buttons">
            <a href="login.jsp" class="btn btn-login">Login</a>
            <a href="register.jsp" class="btn btn-register">Register</a>
        </div>
    </div>

    <footer>
        © 2026 GM University | All Rights Reserved
    </footer>

</body>
</html>