package com.gmuni;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName  = request.getParameter("fullName");
        String email     = request.getParameter("email");
        String password  = request.getParameter("password");
        String role      = request.getParameter("role");
        String branch    = request.getParameter("branch");
        String phone     = request.getParameter("phone");

        try (Connection conn = DBConnection.getConnection()) {

            // Check if email already exists
            PreparedStatement check = conn.prepareStatement("SELECT employee_id FROM users WHERE email = ?");
            check.setString(1, email);
            ResultSet rs = check.executeQuery();
            if (rs.next()) {
                request.setAttribute("errorMsg", "Email already registered");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
                return;
            }

            // Generate next GMU ID
            PreparedStatement max = conn.prepareStatement("SELECT MAX(employee_id) FROM users WHERE employee_id LIKE 'GMU%'");
            ResultSet maxRs = max.executeQuery();
            int next = 1;
            if (maxRs.next() && maxRs.getString(1) != null) {
                String last = maxRs.getString(1);
                next = Integer.parseInt(last.substring(3)) + 1;
            }
            String newId = String.format("GMU%04d", next);

            // Insert new user
            PreparedStatement insert = conn.prepareStatement(
                "INSERT INTO users (employee_id, full_name, email, password, role, branch, phone) VALUES (?, ?, ?, ?, ?, ?, ?)");
            insert.setString(1, newId);
            insert.setString(2, fullName);
            insert.setString(3, email);
            insert.setString(4, password);  // TODO: Hash this in production!
            insert.setString(5, role);
            insert.setString(6, branch);
            insert.setString(7, phone);
            insert.executeUpdate();

            // Auto-login
            User newUser = new User(newId, fullName, email, password, role, branch, phone);
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", newUser);

            // Redirect based on role
            if ("admin".equals(role)) {
                response.sendRedirect("admin.jsp");
            } else {
                response.sendRedirect("employee-dashboard.jsp");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}