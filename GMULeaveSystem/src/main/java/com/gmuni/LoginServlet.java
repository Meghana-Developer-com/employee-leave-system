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

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String empId    = request.getParameter("empId");
        String password = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {

            PreparedStatement ps = conn.prepareStatement(
                "SELECT * FROM users WHERE employee_id = ? AND password = ?");
            ps.setString(1, empId);
            ps.setString(2, password);  // TODO: Compare hashed password in real app
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setEmployeeId(rs.getString("employee_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setBranch(rs.getString("branch"));
                user.setPhone(rs.getString("phone"));

                HttpSession session = request.getSession();
                session.setAttribute("currentUser", user);

                if ("admin".equals(user.getRole())) {
                    response.sendRedirect("admin.jsp");
                } else {
                    response.sendRedirect("employee-dashboard.jsp");
                }
            } else {
                request.setAttribute("errorMsg", "Invalid Employee ID or Password");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Database error");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}