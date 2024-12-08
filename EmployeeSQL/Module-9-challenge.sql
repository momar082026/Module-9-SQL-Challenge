-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/oY1fm5
-- Used QuickDBD to create initial DB schema diagram.


--Drop Tables if they Exist 
DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS Dept_manager;
DROP TABLE IF EXISTS Titles;
DROP TABLE IF EXISTS Dept_emp;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Salaries;

---Create Department table to store information
CREATE TABLE Departments (
    dept_no varchar(60)   NOT NULL,
    dept_name varchar(60)   NOT NULL,
    CONSTRAINT pk_Departments PRIMARY KEY (
        dept_no
     )
);

SELECT * FROM Departments

---Create Department Manager table to store Manager information
CREATE TABLE Dept_manager (
    dept_no varchar(60)   NOT NULL,
    emp_no int   NOT NULL,
    CONSTRAINT pk_Dept_manager PRIMARY KEY (
        emp_no
     )
);

SELECT * FROM Dept_manager

---Create Title table to store Titles information of Employees
CREATE TABLE Titles (
    title_id varchar(60)   NOT NULL,
    title varchar(60)   NOT NULL,
    CONSTRAINT pk_Titles PRIMARY KEY (
        title_id
     )
);

SELECT * FROM Titles

---Create Department Employees table to store what Department employees work at.
CREATE TABLE Dept_emp (
    emp_no int   NOT NULL,
    dept_no varchar   NOT NULL
);

SELECT * FROM Dept_emp

---Create Employees table to store Employees info such as names, birth date, titles etc...
CREATE TABLE Employees (
    emp_no int   NOT NULL,
    emp_title_id varchar(60)   NOT NULL,
    birth_date date   NOT NULL,
    first_name varchar(60)   NOT NULL,
    last_name varchar(60)   NOT NULL,
    sex varchar   NOT NULL,
    hire_date date   NOT NULL,
    CONSTRAINT pk_Employees PRIMARY KEY (
        emp_no
     )
);

SELECT * FROM Employees

---Create Employees Salary table to store Employees Salary information
CREATE TABLE Salaries (
    emp_no int   NOT NULL,
    salary int   NOT NULL,
    CONSTRAINT pk_Salaries PRIMARY KEY (
        emp_no
     )
);

SELECT * FROM Salaries

--1) List the employee number, last name, first name, sex, and salary of each employee.

SELECT Employees.emp_no, Employees.last_name, Employees.first_name, Employees.sex, Salaries.salary
FROM Employees
JOIN Salaries ON Employees.emp_no = Salaries.emp_no;

--2) List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT (YEAR FROM hire_date) = 1986;

--3) List the manager of each department along with their department number, 
--department name, employee number, last name, and first name
SELECT 
    d.dept_no,
    d.dept_name,
    dm.emp_no,
    e.last_name,
    e.first_name
FROM 
    Departments d
    JOIN Dept_manager dm ON d.dept_no = dm.dept_no
    JOIN Employees e ON dm.emp_no = e.emp_no;
	
--4) List the department number for each employee along with that 
-- employee’s employee number, last name, first name, and department name.
SELECT 
    de.dept_no,
    e.emp_no,
    e.last_name,
    e.first_name,
    d.dept_name
FROM 
    Employees e
    JOIN Dept_emp de ON e.emp_no = de.emp_no
    JOIN Departments d ON de.dept_no = d.dept_no;

--5) List first name, last name, and sex of each employee whose first name is Hercules,
-- and whose last name begins with the letter B.
SELECT 
    first_name,
    last_name,
    sex
FROM 
    Employees
WHERE 
    first_name = 'Hercules'
    AND last_name LIKE 'B%';	

-- 6) List each employee in the Sales department, including their employee number,
-- last name, and first name.
SELECT 
    e.emp_no,
    e.last_name,
    e.first_name
FROM 
    Employees e
    JOIN Dept_emp de ON e.emp_no = de.emp_no
    JOIN Departments d ON de.dept_no = d.dept_no
WHERE 
    d.dept_name = 'Sales';

-- 7) List each employee in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
SELECT 
    e.emp_no,
    e.last_name,
    e.first_name,
    d.dept_name
FROM 
    Employees e
    JOIN Dept_emp de ON e.emp_no = de.emp_no
    JOIN Departments d ON de.dept_no = d.dept_no
WHERE 
    d.dept_name IN ('Sales', 'Development');


-- 8) List the frequency counts, in descending order, of all the employee last names 
-- (that is, how many employees share each last name).
SELECT 
    last_name,
    COUNT(*) as name_count
FROM 
    Employees
GROUP BY 
    last_name
ORDER BY 
    name_count DESC;


ALTER TABLE Departments ADD CONSTRAINT fk_Departments_dept_no FOREIGN KEY(dept_no)
REFERENCES Dept_emp (dept_no);

ALTER TABLE Dept_manager ADD CONSTRAINT fk_Dept_manager_dept_no FOREIGN KEY(dept_no)
REFERENCES Departments (dept_no);

ALTER TABLE Dept_emp ADD CONSTRAINT fk_Dept_emp_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

ALTER TABLE Employees ADD CONSTRAINT fk_Employees_emp_no FOREIGN KEY(emp_no)
REFERENCES Salaries (emp_no);

ALTER TABLE Employees ADD CONSTRAINT fk_Employees_emp_title_id FOREIGN KEY(emp_title_id)
REFERENCES Titles (title_id);

