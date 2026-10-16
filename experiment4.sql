-- AIM:
-- Using the Employee schema, write queries with INNER JOIN, LEFT JOIN, self-join, 3-way join, correlated subqueries, EXISTS, and simulated INTERSECT and EXCEPT. Compare execution plans using EXPLAIN.

-- SQL Queries
-- 1. INNER JOIN
-- Display employees along with their department names.
SELECT 
    e.Emp_ID,
    e.Emp_Name,
    e.Salary,
    d.Dept_Name
FROM Employee e
INNER JOIN Department d
ON e.Dept_ID = d.Dept_ID;
 
-- 2. LEFT JOIN
-- Display all departments and their employees.
SELECT
    d.Dept_ID, d.Dept_Name, e.Emp_Name
FROM Department d
LEFT JOIN Employee e
ON d.Dept_ID = e.Dept_ID;
 
-- 3. SELF JOIN
-- Find pairs of employees who work in the same department.
SELECT
    e1.Emp_Name AS Employee1,
    e2.Emp_Name AS Employee2,
    e1.Dept_ID
FROM Employee e1
JOIN Employee e2
ON e1.Dept_ID = e2.Dept_ID
AND e1.Emp_ID < e2.Emp_ID;
 
-- 4. Three-Way JOIN
-- Display employee name, department name, and project name.
SELECT
    e.Emp_Name, d.Dept_Name, p.Project_Name, e.Salary
FROM Employee e
JOIN Department d
ON e.Dept_ID = d.Dept_ID
JOIN Project p
ON e.Project_ID = p.Project_ID;
  
-- 5. Correlated Subquery
-- Find employees whose salary is greater than the average salary of their own department.
SELECT
    e.Emp_ID, e.Emp_Name, e.Dept_ID, e.Salary
FROM Employee e
WHERE e.Salary >
(
    SELECT AVG(e2.Salary)
    FROM Employee e2
    WHERE e2.Dept_ID = e.Dept_ID
);
 
-- 6. EXISTS
-- Find departments that have at least one employee earning more than ₹70,000.
SELECT
    d.Dept_ID,
    d.Dept_Name
FROM Department d
WHERE EXISTS
(
    SELECT 1
    FROM Employee e
    WHERE e.Dept_ID = d.Dept_ID
      AND e.Salary > 70000
);
 

-- 7. EXISTS with Projects
-- Find employees who are assigned to a project.
SELECT
    e.Emp_ID,
    e.Emp_Name
FROM Employee e
WHERE EXISTS
(
    SELECT 1
    FROM Project p
    WHERE p.Project_ID = e.Project_ID
);
 
-- 8. Simulated INTERSECT
-- MySQL does not traditionally use the INTERSECT operator in the same way as some other SQL systems, so we can simulate it using INNER JOIN.
-- Find employees who belong to the IT department AND have salary greater than ₹60,000
SELECT Emp_ID, Emp_Name
FROM Employee
WHERE Dept_ID = 1

AND Emp_ID IN
(
    SELECT Emp_ID
    FROM Employee
    WHERE Salary > 60000
);
 
-- 9. Simulated EXCEPT
-- Suppose we want employees who are not working in the IT department.
SELECT Emp_ID, Emp_Name
FROM Employee
WHERE Dept_ID <> 1;

-- 10. EXPLAIN – INNER JOIN
-- EXPLAIN shows how MySQL plans to execute a query.
EXPLAIN
SELECT
    e.Emp_Name,
    d.Dept_Name
FROM Employee e
INNER JOIN Department d
ON e.Dept_ID = d.Dept_ID;
 
-- 11. EXPLAIN – LEFT JOIN
EXPLAIN
SELECT
    d.Dept_Name,
    e.Emp_Name
FROM Department d
LEFT JOIN Employee e
ON d.Dept_ID = e.Dept_ID;
 
-- 12. EXPLAIN – Three-Way JOIN
EXPLAIN
SELECT
    e.Emp_Name,
    d.Dept_Name,
    p.Project_Name
FROM Employee e
JOIN Department d
ON e.Dept_ID = d.Dept_ID
JOIN Project p
ON e.Project_ID = p.Project_ID;
 
-- 13. EXPLAIN – Correlated Subquery
EXPLAIN
SELECT
    e.Emp_Name,
    e.Salary
FROM Employee e
WHERE e.Salary >
(
    SELECT AVG(e2.Salary)
    FROM Employee e2
    WHERE e2.Dept_ID = e.Dept_ID
);
 
