
-- Create table schema for 6 CSV files, remembering to specify data types and keys.

create table departments (
	dept_no varchar,
	dept_name varchar
);
	select * from departments;

create table dept_employee (
	emp_no int,
	dept_no varchar
);
	select * from dept_employee;

create table dept_manager (
	dept_no varchar,
	emp_no int
);
	select * from dept_employee

create table employee_info (
	emp_no int,
	emp_title varchar,
	birth_date date,
	first_name varchar,
	last_name varchar,
	sex varchar,
	hire_date date
);
	select * from employee_info

create table salaries (
	emp_no int,
	salary int
);
	select * from salaries

create table titles (
	title_id varchar,
	title varchar
);
	select * from titles

-- List details of each employee: employee number, last name, first name, sex, and salary.

select employee_info.emp_no,employee_info.last_name,employee_info.first_name,employee_info.sex,salaries.salary
from employee_info 
	inner join salaries
		on employee_info.emp_no=salaries.emp_no;
		
-- List first name, last name, hire date for employees hired in 1986.		

select first_name,last_name,hire_date
from employee_info
where extract(year from hire_date) = '1986'; 

-- List manager of each department with department number, department name, ID, last name, first name.

select dept_manager.dept_no, departments.dept_name,dept_manager.emp_no,employee_info.last_name, employee_info.first_name
from dept_manager
	left join departments
		on dept_manager.dept_no = departments.dept_no
	left join employee_info
		on dept_manager.emp_no = employee_info.emp_no
order by emp_no;

--List department of each employee with employee number, last name, first name, and department

select employee_info.emp_no,employee_info.last_name,employee_info.first_name,dept_employee.dept_no,departments.dept_name
from  employee_info 
	inner join dept_employee 
		on employee_info.emp_no=dept_employee.emp_no
	inner join departments 
		on departments.dept_no=dept_employee.dept_no
order by emp_no;

--List first name, last name, and sex for employees whose first name is 'Hercules' and last name begins with 'B'

select *
from employee_info
where first_name='Hercules'
and last_name like 'B%' ;

--List all employees in sales dept--including employee number, last name, first name, and dept name

select employee_info.emp_no, 
employee_info.last_name, 
employee_info.first_name,
departments.dept_name
from employee_info
	left join dept_employee 
		on employee_info.emp_no=dept_employee.emp_no
	inner join departments 
		on departments.dept_no=dept_employee.dept_no
WHERE departments.dept_name='Sales';


--List all employees in sales and development dept, including employee number, last name, first name, and dept name

select employee_info.emp_no, 
employee_info.last_name, 
employee_info.first_name,
departments.dept_name
from employee_info
	left join dept_employee 
		on employee_info.emp_no=dept_employee.emp_no
	inner join departments 
		on departments.dept_no=dept_employee.dept_no
WHERE departments.dept_name in ('Sales','Development');


--In descending order, list frequency count of employee last names, i.e., how many employees share each last name

select count(last_name), last_name
	from employee_info
		group by last_name
			order by count desc;
			


