<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.gmuni.*, java.sql.*, java.util.*, java.time.*, java.time.temporal.ChronoUnit" %>

<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null || !"employee".equals(currentUser.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<LeaveApplication> myApps = new ArrayList<>();
    int pending = 0, approved = 0, rejected = 0;
    long usedDays = 0;
    int totalLeaves = 44;

    try (Connection conn = DBConnection.getConnection()) {
        PreparedStatement ps = conn.prepareStatement(
            "SELECT * FROM leave_applications WHERE emp_id = ? ORDER BY applied_at DESC");
        ps.setString(1, currentUser.getEmployeeId());
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

            myApps.add(app);

            if (app.isRejected()) rejected++;
            else if (app.isDeanApproved() && app.isDirectorApproved()) approved++;
            else pending++;

            if (!app.isRejected()) {
                try {
                    LocalDate s = LocalDate.parse(app.getStartDate());
                    LocalDate e = LocalDate.parse(app.getEndDate());
                    long days = ChronoUnit.DAYS.between(s, e) + 1;
                    if (days > 0) usedDays += days;
                } catch (Exception ignored) {}
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    int remainingLeaves = totalLeaves - (int) usedDays;
    if (remainingLeaves < 0) remainingLeaves = 0;
%>

<!-- Rest of your HTML + JSP code remains almost the same -->
<!-- Just use myApps list, pending, approved, rejected, remainingLeaves, usedDays -->
<!-- Example table loop: -->
<% for (LeaveApplication app : myApps) { %>
    <tr>
        <td><%= app.getLeaveType() %></td>
        <td><%= app.getStartDate() %> – <%= app.getEndDate() %></td>
        <td><%= app.getReason() %></td>
        <td class="status-<%= app.getStatus().toLowerCase() %>"><%= app.getStatus() %></td>
    </tr>
<% } %>