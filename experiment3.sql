-- AIM:
-- Create an Employee–Department–Project schema. Insert at least 30 employees across 5 departments and 8 projects. Write SQL queries demonstrating selection, projection, aggregates, GROUP BY, HAVING, CASE expressions, and ORDER BY.
-- QUERY:
-- 1. Create Database and Tables

CREATE DATABASE CompanyDB;
USE CompanyDB;

-- Department Table
CREATE TABLE Department (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(50) NOT NULL,
    Location VARCHAR(50)
);
-- Project Table
CREATE TABLE Project (
    Project_ID INT PRIMARY KEY,
    Project_Name VARCHAR(100) NOT NULL,
    Budget DECIMAL(12,2),
    Dept_ID INT,
    FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID)
);

-- Employee Table
CREATE TABLE Employee (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(100) NOT NULL,
    Salary DECIMAL(10,2),
    Job_Title VARCHAR(50),
    Dept_ID INT,
    Project_ID INT,
    FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID),
    FOREIGN KEY (Project_ID) REFERENCES Project(Project_ID)
);

--2. Insert 5 Departments
INSERT INTO Department VALUES
(1, 'IT', 'Delhi'),
(2, 'HR', 'Mumbai'),
(3, 'Finance', 'Bangalore'),
(4, 'Marketing', 'Pune'),
(5, 'Operations', 'Chennai');

--3. Insert 8 Projects
INSERT INTO Project VALUES
(101, 'Website Development', 500000, 1),
(102, 'Mobile Application', 750000, 1),
(103, 'Recruitment System', 300000, 2),
(104, 'Financial Analysis', 600000, 3),
(105, 'Marketing Campaign', 450000, 4),
(106, 'Customer Management', 550000, 4),
(107, 'Inventory System', 400000, 5),
(108, 'Business Automation', 800000, 5);

--4. Insert 30 Employees
INSERT INTO Employee VALUES

(1, 'Aarav Sharma', 55000, 'Developer', 1, 101),
(2, 'Riya Gupta', 62000, 'Developer', 1, 102),
(3, 'Arjun Verma', 48000, 'Tester', 1, 101),
(4, 'Ananya Singh', 70000, 'Team Lead', 1, 102),
(5, 'Karan Mehta', 45000, 'Support Engineer', 1, 101),
(6, 'Priya Sharma', 58000, 'Developer', 1, 102),
(7, 'Neha Kapoor', 50000, 'HR Executive', 2, 103),
(8, 'Rahul Jain', 65000, 'HR Manager', 2, 103),
(9, 'Simran Kaur', 42000, 'Recruiter', 2, 103),
(10, 'Aditya Roy', 46000, 'HR Executive', 2, 103),

(11, 'Megha Joshi', 55000, 'Recruiter', 2, 103),
(12, 'Vivek Malhotra', 72000, 'HR Manager', 2, 103),
(13, 'Ishita Rao', 60000, 'Accountant', 3, 104),
(14, 'Manish Kumar', 75000, 'Financial Analyst', 3, 104),
(15, 'Pooja Agarwal', 52000, 'Accountant', 3, 104),
(16, 'Rohit Bansal', 68000, 'Financial Analyst', 3, 104),
(17, 'Kavya Nair', 58000, 'Accountant', 3, 104),
(18, 'Sahil Gupta', 80000, 'Finance Manager', 3, 104),
(19, 'Tanya Singh', 47000, 'Marketing Executive', 4, 105),
(20, 'Yash Verma', 56000, 'Marketing Analyst', 4, 105),

(21, 'Nisha Patel', 62000, 'Marketing Manager', 4, 106),
(22, 'Aman Khan', 44000, 'Sales Executive', 4, 106),
(23, 'Shreya Das', 51000, 'Marketing Executive', 4, 105),
(24, 'Dev Sharma', 59000, 'Sales Executive', 4, 106),
(25, 'Akash Yadav', 49000, 'Operations Executive', 5, 107),
(26, 'Sneha Roy', 57000, 'Operations Analyst', 5, 107),
(27, 'Varun Singh', 63000, 'Operations Manager', 5, 108),
(28, 'Komal Gupta', 46000, 'Operations Executive', 5, 107),
(29, 'Nitin Sharma', 54000, 'Process Analyst', 5, 108),
(30, 'Aditi Mehta', 69000, 'Operations Manager', 5, 108);

-- SQL Queries
-- 5. Selection
-- Selection retrieves rows that satisfy a condition.
-- Employees having salary greater than ₹60,000
SELECT *
FROM Employee
WHERE Salary > 60000;

-- 6. Projection
-- Projection retrieves only specific columns from a table.
SELECT Emp_ID, Emp_Name, Salary
FROM Employee;

-- 7. Aggregate Functions
-- COUNT,  SUM,  AVG, MAX, MIN

SELECT
    COUNT(*) AS Total_Employees,
    SUM(Salary) AS Total_Salary,
    AVG(Salary) AS Average_Salary,
    MAX(Salary) AS Highest_Salary,
    MIN(Salary) AS Lowest_Salary
FROM Employee;

-- 8. GROUP BY
-- Find the average salary of each department:
SELECT Dept_ID, AVG(Salary) AS Average_Salary
FROM Employee
GROUP BY Dept_ID;
-- Using the department name:
SELECT d.Dept_Name, COUNT(e.Emp_ID) AS Employee_Count
FROM Department d
JOIN Employee e
ON d.Dept_ID = e.Dept_ID
GROUP BY d.Dept_Name;

-- 9. HAVING
-- HAVING is used to filter groups created by GROUP BY.
-- Departments having more than 5 employees
SELECT Dept_ID, COUNT(*) AS Employee_Count
FROM Employee
GROUP BY Dept_ID
HAVING COUNT(*) > 5;

-- 10. CASE Expression
-- Classify employees according to their salary:
SELECT
    Emp_Name,
    Salary,
    CASE
        WHEN Salary >= 70000 THEN 'High Salary'
        WHEN Salary >= 50000 THEN 'Medium Salary'
        ELSE 'Low Salary'
    END AS Salary_Category
FROM Employee;

-- 11. ORDER BY
-- Sort employees by salary in ascending order
SELECT Emp_Name, Salary
FROM Employee
ORDER BY Salary ASC;


