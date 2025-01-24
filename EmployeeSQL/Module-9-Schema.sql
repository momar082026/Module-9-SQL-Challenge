-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/oY1fm5
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

----Drop Tables If they exists
DROP TABLE IF EXISTS Dept_emp;
DROP TABLE IF EXISTS Dept_manager;
DROP TABLE IF EXISTS Salaries;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Titles;
DROP TABLE IF EXISTS Departments;

----Create Tables

CREATE TABLE Departments (
    dept_no varchar(60)   NOT NULL,
    dept_name varchar(60)   NOT NULL,
    CONSTRAINT pk_Departments PRIMARY KEY (
        dept_no
     )
);
Select * from Departments;

CREATE TABLE Dept_manager (
    dept_no varchar(60)   NOT NULL,
    emp_no int   NOT NULL,
    CONSTRAINT pk_Dept_manager PRIMARY KEY (
        dept_no, emp_no
     )
);
Select * from Dept_manager;

CREATE TABLE Titles (
    title_id varchar(60)   NOT NULL,
    title varchar(60)   NOT NULL,
    CONSTRAINT pk_Titles PRIMARY KEY (
        title_id
     )
);
Select * from Titles;

CREATE TABLE Dept_emp (
    emp_no int   NOT NULL,
    dept_no varchar   NOT NULL
    CONSTRAINT pk_DEPT_EMP PRIMARY KEY (
        emp_no, dept_no
    )
);
Select * from Dept_emp;

CREATE TABLE Employees (
    emp_no int   NOT NULL,
    emp_title_id varchar(60)   NOT NULL,
    birth_date date   NOT NULL,
    first_name varchar(60)   NOT NULL,
    last_name varchar(60)   NOT NULL,
    sex varchar(60)   NOT NULL,
    hire_date date   NOT NULL,
    CONSTRAINT pk_Employees PRIMARY KEY (
        emp_no
     )
);
Select * from Employees;

CREATE TABLE Salaries (
    emp_no int   NOT NULL,
    salary int   NOT NULL,
    CONSTRAINT pk_Salaries PRIMARY KEY (
        emp_no, salary
     )
);
Select * from Salaries;


ALTER TABLE Employees ADD CONSTRAINT fk_Employees_emp_title_id FOREIGN KEY(emp_title_id)
REFERENCES Titles (title_id);

ALTER TABLE Salaries ADD CONSTRAINT fk_Salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

ALTER TABLE Dept_manager ADD CONSTRAINT fk_Dept_manager_dept_no FOREIGN KEY(dept_no)
REFERENCES Departments (dept_no);

ALTER TABLE Dept_manager ADD CONSTRAINT fk_Dept_manager_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

ALTER TABLE Dept_emp ADD CONSTRAINT fk_Dept_emp_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

ALTER TABLE Dept_emp ADD CONSTRAINT fk_DEPT_emp_dept_no FOREIGN KEY(dept_no)
REFERENCES Departments (dept_no);

