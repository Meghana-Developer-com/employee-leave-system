package com.gmuni;

import java.io.Serializable;

public class User implements Serializable {
    private String employeeId;
    private String fullName;
    private String email;
    private String password;
    private String role;        // "employee" or "admin"
    private String branch;
    private String phone;

    public User() {}

    public User(String employeeId, String fullName, String email,
                String password, String role, String branch, String phone) {
        this.employeeId = employeeId;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.role = role;
        this.branch = branch;
        this.phone = phone;
    }

    // Getters and setters
    public String getEmployeeId() { return employeeId; }
    public void setEmployeeId(String employeeId) { this.employeeId = employeeId; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public String getBranch() { return branch; }
    public void setBranch(String branch) { this.branch = branch; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
}