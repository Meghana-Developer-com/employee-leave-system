<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - GM University</title>
    <style>
        body { font-family:Arial,sans-serif; background:#f0f2f5; margin:0; padding:60px 20px; }
        .box { max-width:480px; margin:auto; background:white; padding:40px; border-radius:10px; box-shadow:0 4px 20px rgba(0,0,0,0.15); }
        h2 { text-align:center; color:#00695c; margin-bottom:30px; }
        label { display:block; margin:14px 0 6px; font-weight:600; color:#444; }
        input, select { width:100%; padding:12px; margin:10px 0; border:1px solid #ccc; border-radius:6px; }
        button { width:100%; padding:14px; background:#00695c; color:white; border:none; border-radius:6px; cursor:pointer; }
        button:hover { background:#004d40; }
        .error { color:#c62828; text-align:center; margin:10px 0; font-weight:bold; }
        #branchField, #facultyField { display:none; }
    </style>
</head>
<body>
<div class="box">
    <h2>Create Account</h2>
    <% if(request.getAttribute("errorMsg") != null){ %>
        <div class="error"><%= request.getAttribute("errorMsg") %></div>
    <% } %>
    <form action="register" method="post" id="regForm">
        <label>Full Name</label>
        <input type="text" name="fullName" required>

        <label>Email</label>
        <input type="email" name="email" required>

        <label>Password</label>
        <input type="password" name="password" required>

        <label>Phone (10 digits)</label>
        <input type="text" name="phone" pattern="\d{10}" title="10 digits only" required>

        <label>Role</label>
        <select name="role" id="role" required onchange="toggleFields()">
            <option value="">-- Select --</option>
            <option value="employee">Employee</option>
            <option value="admin">Administrator</option>
        </select>

        <div id="facultyField">
            <label>Faculty</label>
            <select name="faculty" id="faculty" onchange="updateBranches()">
                <option value="">-- Select Faculty --</option>
                <option value="FCIT">FCIT</option>
                <option value="FET">FET</option>
                <option value="FMS">FMS</option>
            </select>
        </div>

        <div id="branchField">
            <label>Branch / Course</label>
            <select name="branch" id="branch" required>
                <option value="">-- Select --</option>
            </select>
        </div>

        <button type="submit">Register</button>
    </form>
</div>

<script>
    function toggleFields() {
        const role = document.getElementById("role").value;
        const facultyDiv = document.getElementById("facultyField");
        const branchDiv = document.getElementById("branchField");

        if (role === "employee") {
            facultyDiv.style.display = "block";
            branchDiv.style.display = "block";
            document.getElementById("branch").required = true;
        } else {
            facultyDiv.style.display = "none";
            branchDiv.style.display = "none";
            document.getElementById("branch").required = false;
        }
    }

    function updateBranches() {
        const faculty = document.getElementById("faculty").value;
        const branch = document.getElementById("branch");
        branch.innerHTML = '<option value="">-- Select --</option>';
        if (faculty === "FCIT") {
            ["BCA", "BSc", "MCA", "MSc"].forEach(opt => {
                let o = document.createElement("option");
                o.value = opt;
                o.text = opt;
                branch.appendChild(o);
            });
        }
    }

    // Run on page load in case of back button
    toggleFields();
</script>
</body>
</html>