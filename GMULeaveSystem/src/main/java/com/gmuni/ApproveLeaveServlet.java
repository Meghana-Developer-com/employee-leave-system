package com.gmuni;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ApproveLeaveServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action   = request.getParameter("action");     // approve / reject
        String level    = request.getParameter("level");      // dean / director
        String appIdStr = request.getParameter("appId");      // leave application ID
        String comment  = request.getParameter("comment");

        int appId;
        try {
            appId = Integer.parseInt(appIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("admin.jsp?error=Invalid application ID");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "UPDATE leave_applications SET ";

            if ("approve".equals(action)) {
                if ("dean".equals(level)) {
                    sql += "dean_approved = 1, dean_rejected = 0, dean_comment = ?";
                } else if ("director".equals(level)) {
                    sql += "director_approved = 1, director_rejected = 0, director_comment = ?";
                }
            } else if ("reject".equals(action)) {
                if ("dean".equals(level)) {
                    sql += "dean_rejected = 1, dean_approved = 0, dean_comment = ?";
                } else if ("director".equals(level)) {
                    sql += "director_rejected = 1, director_approved = 0, director_comment = ?";
                }
            }

            sql += ", status = CASE " +
                   "  WHEN dean_rejected = 1 OR director_rejected = 1 THEN 'Rejected' " +
                   "  WHEN dean_approved = 1 AND director_approved = 1 THEN 'Approved' " +
                   "  ELSE 'Pending' END " +
                   "WHERE id = ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, comment != null ? comment.trim() : (action.equals("approve") ? "Approved" : "Rejected"));
            ps.setInt(2, appId);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("admin.jsp");
            } else {
                response.sendRedirect("admin.jsp?error=Application not found");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin.jsp?error=Database error: " + e.getMessage());
        }
    }
}