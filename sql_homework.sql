-- Create Tables:
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS titles;

CREATE TABLE departments (
	dept_no VARCHAR(10),
	dept_name VARCHAR(100),
	PRIMARY KEY (dept_no)
);

CREATE TABLE dept_emp (
	emp_no INT,
	dept_no VARCHAR(10),
	from_date VARCHAR(20),
	to_date VARCHAR(20),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE dept_manager (
    dept_no VARCHAR(10),
	emp_no INT,
	from_date VARCHAR(20),
	to_date VARCHAR(20),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE employees (
	emp_no INT,
	birth_date VARCHAR(10),
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	gender VARCHAR(5),
	hire_date VARCHAR(10),
	PRIMARY KEY (emp_no)
);

CREATE TABLE salaries (
	emp_no INT,
	salary INT,
	from_date VARCHAR(20),
	to_date VARCHAR(20),
	PRIMARY KEY (emp_no)
);

CREATE TABLE titles (
	emp_no INT,
	title VARCHAR(50),
	from_date VARCHAR(20),
	to_date VARCHAR(20),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

--Imported CSV, table check
SELECT * FROM departments LIMIT 10
SELECT * FROM dept_emp LIMIT 10
SELECT * FROM dept_manager LIMIT 10
SELECT * FROM employees LIMIT 10
SELECT * FROM salaries LIMIT 10
SELECT * FROM titles LIMIT 10


--List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees AS e
INNER JOIN salaries AS s ON
e.emp_no=s.emp_no;

--List employees who were hired in 1986
SELECT *
FROM employees
WHERE hire_date LIKE '1986______'

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT  e.last_name, e.first_name, m.emp_no, m.dept_no, d.dept_name, m.from_date, m.to_date
FROM dept_manager AS m
join departments AS d ON m.dept_no=d.dept_no
join employees AS e ON m.emp_no=e.emp_no

--List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT  d.dept_name, de.emp_no, e.last_name, e.first_name
FROM departments AS d
join dept_emp AS de ON d.dept_no=de.dept_no
join employees AS e ON de.emp_no=e.emp_no
ORDER BY d.dept_name;

--List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employees
WHERE
first_name LIKE 'Hercules'
AND last_name LIKE 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name
SELECT  d.dept_name, de.emp_no, e.last_name, e.first_name
FROM departments AS d
join dept_emp AS de ON d.dept_no=de.dept_no
join employees AS e ON de.emp_no=e.emp_no
WHERE 
dept_name = 'Sales'
ORDER BY d.dept_name;

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT  d.dept_name, de.emp_no, e.last_name, e.first_name
FROM departments AS d
join dept_emp AS de ON d.dept_no=de.dept_no
join employees AS e ON de.emp_no=e.emp_no
WHERE 
dept_name = 'Sales'
OR
dept_name = 'Development'
ORDER BY d.dept_name;


--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT  last_name, COUNT(last_name) AS "Count_Same_Last_Name"
FROM employees
GROUP BY last_name
ORDER BY "Count_Same_Last_Name" DESC;
