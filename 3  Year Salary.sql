CREATE TABLE employee_salary (
    employee_id INTEGER,
    name VARCHAR(255),
    year INTEGER,
    salary INTEGER,
    department VARCHAR(255)
);


INSERT INTO employee_salary (employee_id, name, year, salary, department) VALUES
(125, 'John Doe', 2021, 50000, 'Sales'),
(125, 'John Doe', 2022, 52000, 'Sales'),
(125, 'John Doe', 2023, 54000, 'Sales'),
(125, 'John Doe', 2024, 56000, 'Sales'),
(102, 'Jane Smith', 2020, 45000, 'Marketing'),
(102, 'Jane Smith', 2021, 47000, 'Marketing'),
(102, 'Jane Smith', 2022, 49000, 'Marketing'),
(102, 'Jane Smith', 2023, 51000, 'Marketing'),
(165, 'Alice Johnson', 2021, 60000, 'Engineering'),
(165, 'Alice Johnson', 2022, 62000, 'Engineering'),
(165, 'Alice Johnson', 2023, 64000, 'Engineering'),
(200, 'Bob Brown', 2021, 55000, 'HR'),
(200, 'Bob Brown', 2022, 57000, 'HR'),
(200, 'Bob Brown', 2023, 58000, 'HR');


SELECT * FROM EMPLOYEE_SALARY


/*
-- Identify the employee who received at least 
 3 year over year increase in salaries!
*/

-- lag to check prev year salary
-- group by emp_id and name

WITH CTE AS
(
SELECT EMPLOYEE_ID,
       NAME,
       YEAR,
       SALARY,
       LAG(SALARY,1)OVER(PARTITION BY EMPLOYEE_ID ORDER BY YEAR) AS PREV_YEAR_SALARY
FROM EMPLOYEE_SALARY
)
SELECT EMPLOYEE_ID,
	   NAME,
       COUNT(*) AS NUMBER_OF_YEAR_SALARY_RAISE
FROM CTE
WHERE SALARY > PREV_YEAR_SALARY
GROUP BY EMPLOYEE_ID,NAME
HAVING COUNT(*) >= 3
