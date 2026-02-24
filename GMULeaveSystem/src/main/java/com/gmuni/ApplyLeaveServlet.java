package com.gmuni;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class ApplyLeaveServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String empName       = request.getParameter("empName");
        String empId         = request.getParameter("empId");
        String leaveType     = request.getParameter("leaveType");
        String branch        = request.getParameter("branch");
        String programLevel  = request.getParameter("programLevel");
        String startDate     = request.getParameter("startDate");
        String endDate       = request.getParameter("endDate");
        String reason        = request.getParameter("reason");

        try (Connection conn = DBConnection.getConnection()) {

            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO leave_applications " +
                "(emp_id, leave_type, branch, program_level, start_date, end_date, reason, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, 'Pending')"
            );

            ps.setString(1, empId);
            ps.setString(2, leaveType);
            ps.setString(3, branch);
            ps.setString(4, programLevel);
            ps.setString(5, startDate);
            ps.setString(6, endDate);
            ps.setString(7, reason);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("employee-dashboard.jsp");
            } else {
                response.sendRedirect("employee-dashboard.jsp?error=Failed to submit leave");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("employee-dashboard.jsp?error=Database error: " + e.getMessage());
        }
    }
}