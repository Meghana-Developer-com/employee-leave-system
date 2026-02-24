<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - GM University</title>
    <style>
        body { font-family:Arial,sans-serif; background:#f0f2f5; margin:0; padding:80px 20px; }
        .box { max-width:420px; margin:auto; background:white; padding:40px; border-radius:10px; box-shadow:0 4px 20px rgba(0,0,0,0.15); }
        h2 { text-align:center; color:#00695c; margin-bottom:30px; }
        input { width:100%; padding:12px; margin:12px 0; border:1px solid #ccc; border-radius:6px; font-size:16px; }
        button { width:100%; padding:14px; background:#00695c; color:white; border:none; border-radius:6px; cursor:pointer; }
        button:hover { background:#004d40; }
        .error { color:#c62828; text-align:center; margin:15px 0; font-weight:bold; }
    </style>
</head>
<body>
<div class="box">
    <h2>Sign In</h2>
    <% if(request.getAttribute("errorMsg") != null){ %>
        <div class="error"><%= request.getAttribute("errorMsg") %></div>
    <% } %>
    <form action="login" method="post">
        <input type="text" name="empId" placeholder="Employee ID (GMU0001)" required pattern="GMU[0-9]{4}">
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Login</button>
    </form>
</div>
</body>
</html>