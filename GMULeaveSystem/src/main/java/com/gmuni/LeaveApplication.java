package com.gmuni;

import java.io.Serializable;

public class LeaveApplication implements Serializable {
    private String empName;
    private String empId;
    private String leaveType;
    private String branch;
    private String programLevel;
    private String startDate;
    private String endDate;
    private String reason;

    private boolean deanApproved = false;
    private boolean directorApproved = false;
    private boolean deanRejected = false;
    private boolean directorRejected = false;

    private String deanComment = "";
    private String directorComment = "";

    public String getStatus() {
        if (deanRejected || directorRejected) {
            return "Rejected";
        }
        if (deanApproved && directorApproved) {
            return "Approved";
        }
        return "Pending";
    }

    public boolean isRejected() {
        return deanRejected || directorRejected;
    }

    // Getters & Setters
    public String getEmpName() { return empName; }
    public void setEmpName(String empName) { this.empName = empName; }
    public String getEmpId() { return empId; }
    public void setEmpId(String empId) { this.empId = empId; }
    public String getLeaveType() { return leaveType; }
    public void setLeaveType(String leaveType) { this.leaveType = leaveType; }
    public String getBranch() { return branch; }
    public void setBranch(String branch) { this.branch = branch; }
    public String getProgramLevel() { return programLevel; }
    public void setProgramLevel(String programLevel) { this.programLevel = programLevel; }
    public String getStartDate() { return startDate; }
    public void setStartDate(String startDate) { this.startDate = startDate; }
    public String getEndDate() { return endDate; }
    public void setEndDate(String endDate) { this.endDate = endDate; }
    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }

    public boolean isDeanApproved() { return deanApproved; }
    public void setDeanApproved(boolean deanApproved) { this.deanApproved = deanApproved; }
    public boolean isDirectorApproved() { return directorApproved; }
    public void setDirectorApproved(boolean directorApproved) { this.directorApproved = directorApproved; }
    public boolean isDeanRejected() { return deanRejected; }
    public void setDeanRejected(boolean deanRejected) { this.deanRejected = deanRejected; }
    public boolean isDirectorRejected() { return directorRejected; }
    public void setDirectorRejected(boolean directorRejected) { this.directorRejected = directorRejected; }
    public String getDeanComment() { return deanComment; }
    public void setDeanComment(String deanComment) { this.deanComment = deanComment; }
    public String getDirectorComment() { return directorComment; }
    public void setDirectorComment(String directorComment) { this.directorComment = directorComment; }
}