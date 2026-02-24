<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.gmuni.*, java.sql.*, java.util.*" %>

<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null || !"admin".equals(currentUser.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<LeaveApplication> allLeaves = new ArrayList<>();

    try (Connection conn = DBConnection.getConnection()) {
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM leave_applications ORDER BY applied_at DESC");
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            LeaveApplication app = new LeaveApplication();
            app.setEmpName(rs.getString("emp_name"));
            app.setEmpId(rs.getString("emp_id"));
            app.setLeaveType(rs.getString("leave_type"));
            app.setBranch(rs.getString("branch"));
            app.setProgramLevel(rs.getString("program_level"));
            app.setStartDate(rs.getString("start_date"));
            app.setEndDate(rs.getString("end_date"));
            app.setReason(rs.getString("reason"));

            app.setDeanApproved(rs.getBoolean("dean_approved"));
            app.setDirectorApproved(rs.getBoolean("director_approved"));
            app.setDeanRejected(rs.getBoolean("dean_rejected"));
            app.setDirectorRejected(rs.getBoolean("director_rejected"));

            allLeaves.add(app);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<!-- Rest of your admin HTML -->
<!-- Loop through allLeaves instead of application.getAttribute -->
<% for (int i = 0; i < allLeaves.size(); i++) { 
    LeaveApplication app = allLeaves.get(i);
%>
    <tr>
        <td><%= app.getEmpName() %></td>
        <td><%= app.getEmpId() %></td>
        <!-- ... other columns ... -->
        <td class="action">
            <!-- Your approve/reject forms, use i as appIndex -->
            <input type="hidden" name="appIndex" value="<%= i %>">
            <!-- ... -->
        </td>
    </tr>
<% } %>