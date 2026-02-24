-- =============================================
-- GM University Leave Management System
-- Database Setup Script
-- Run this in MySQL Workbench or any MySQL client
-- =============================================

-- Create database (drop if exists - be careful in production!)
DROP DATABASE IF EXISTS gmuni_leaves;
CREATE DATABASE gmuni_leaves CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE gmuni_leaves;

-- =============================================
-- Users Table (for registration & login)
-- =============================================
CREATE TABLE users (
    employee_id     VARCHAR(10) PRIMARY KEY,                -- e.g. GMU0001, GMU0002...
    full_name       VARCHAR(100) NOT NULL,
    email           VARCHAR(100) UNIQUE NOT NULL,
    password        VARCHAR(255) NOT NULL,                  -- plain text for learning (hash in production!)
    role            ENUM('employee', 'admin') NOT NULL DEFAULT 'employee',
    branch          VARCHAR(50) DEFAULT NULL,               -- e.g. FCIT, FET, FMS
    phone           VARCHAR(15) DEFAULT NULL,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- Leave Applications Table
-- =============================================
CREATE TABLE leave_applications (
    id                  INT AUTO_INCREMENT PRIMARY KEY,
    emp_id              VARCHAR(10) NOT NULL,
    leave_type          VARCHAR(50) NOT NULL,
    branch              VARCHAR(50) DEFAULT NULL,
    program_level       VARCHAR(20) DEFAULT NULL,
    start_date          DATE NOT NULL,
    end_date            DATE NOT NULL,
    reason              TEXT,
    
    dean_approved       TINYINT(1) DEFAULT 0,
    director_approved   TINYINT(1) DEFAULT 0,
    dean_rejected       TINYINT(1) DEFAULT 0,
    director_rejected   TINYINT(1) DEFAULT 0,
    
    dean_comment        TEXT DEFAULT NULL,
    director_comment    TEXT DEFAULT NULL,
    
    status              ENUM('Pending', 'Approved', 'Rejected') DEFAULT 'Pending',
    applied_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (emp_id) REFERENCES users(employee_id) ON DELETE CASCADE
);

-- =============================================
-- Optional: Add some sample data (for testing)
-- =============================================

-- Sample Admin User
INSERT INTO users (employee_id, full_name, email, password, role, phone)
VALUES ('GMU0001', 'Admin User', 'admin@gmuni.edu', 'admin123', 'admin', '9876543210');

-- Sample Employee
INSERT INTO users (employee_id, full_name, email, password, role, branch, phone)
VALUES ('GMU0002', 'Meghana K', 'meghana@gmuni.edu', 'meghana123', 'employee', 'FCIT', '9123456789');

-- Sample Leave Application (for testing)
INSERT INTO leave_applications (
    emp_id, leave_type, branch, program_level, start_date, end_date, reason
) VALUES (
    'GMU0002', 'CASUAL', 'FCIT', 'MCA', '2026-02-20', '2026-02-22', 'Family function'
);

-- =============================================
-- Quick Check Queries (run these after setup)
-- =============================================

-- See all users
SELECT * FROM users;

-- See all leave applications
SELECT * FROM leave_applications;

-- See pending leaves only
SELECT * FROM leave_applications WHERE status = 'Pending';