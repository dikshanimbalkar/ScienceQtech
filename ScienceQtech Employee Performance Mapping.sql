#1.create database name employee: 
create database employee;

use  employee;
show databases;

/*2.import data_science_team.csv proj_table.csv and emp_record_table.csv into 
the employee database from the given resources*/

show tables;

select * from employee.emp_record_table;

/*4.Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and 
DEPARTMENT from the employee record table*/

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT
from employee.emp_record_table;

/*Write a query to Experince is less than 5 and Gender is Female in*/
select * from emp_record_table
where EXP < 5 and GENDER = 'F';

/*5.make a list of employees and details of their department*/

select DEPT as deparment, count(*) as Employees
from emp_record_table
group by DEPT;

/*6.fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, 
DEPARTMENT, and EMP_RATING if the EMP_RATING is:
less than two*/

select EMP_ID, FIRST_NAME,LAST_NAME, GENDER, 
DEPT, EMP_RATING from emp_record_table
where EMP_RATING < 2;

# EMP_Rating is greater than four 

select EMP_ID, FIRST_NAME,LAST_NAME, GENDER, 
DEPT, EMP_RATING from emp_record_table
where EMP_RATING > 4;

# EMP_Rating between 2 and 4

select EMP_ID, FIRST_NAME,LAST_NAME, GENDER, 
DEPT, EMP_RATING from emp_record_table
where EMP_RATING between 2 and 4;


select * from emp_record_table
where 
ROLE = 'MANAGER' or ROLE = 'LEAD DATA SCIENTIST';

# EMP_Rating between 3 and 7.

select * from emp_record_table
where EXP between 3 and 7;

select FIRST_NAME, LAST_NAME, GENDER from emp_record_table
where GENDER = 'F';

/*concatenate the FIRST_NAME and the LAST_NAME of 
employees in the Finance department from the employee table and then 
give the resultant column alias as NAME*/

select concat( FIRST_NAME,' ',LAST_NAME) as 'Name', DEPT
from emp_record_table
where DEPT = "FINANCE";

/*list only those employees who have someone reporting to them. 
Also, show the number of reporters (including the President).*/

select concat(FIRST_NAME, LAST_NAME) as Name, DEPT
from emp_record_table
where ROLE <> 'MANAGER' and ROLE != 'PRESIDENT';

select count(ROLE) as ROLE from emp_record_table;


/*list down all the employees from the healthcare and 
finance departments using union*/

select concat(first_name,last_name) as 'Name',dept from  emp_record_table
where DEPT= 'finance' or dept='healthcare'
union 
select concat(first_name,' ',last_name) as 'Name',dept from  data_science_team
where DEPT= 'finance' or dept='healthcare';

/* list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME,
 ROLE, DEPARTMENT, and EMP_RATING grouped by dept  max EMP_Rating*/
 
select EMP_ID, FIRST_NAME, LAST_NAME, ROLE,
EMP_RATING, DEPT, max(EMP_RATING) as Total_DEPT
from emp_record_table 
group by DEPT
order by max(EMP_RATING);

/*calculate the minimum and the maximum salary of 
the employees in each role*/

select first_name, Role, min(SALARY) as minSalary, max(SALARY) as maxSalary
from emp_record_table 
group by ROLE;

# Find Minimum and Maximum value of each role using window function.

select e.*, 
max(SALARY) over(partition by ROLE) as Max_salary, 
min(SALARY) over(partition by ROLE) as min_salary
from emp_record_table e;

/*Write a query to assign ranks to each employee based on their experience*/

select concat(first_name, ' ', last_name) as Name, EXP,
rank () over (order by EXP) Ranks
from emp_record_table;

/*create a view that displays employees in various countries whose salary is more than six thousand.*/

select concat(first_name, ' ', last_name)as Name, Country, SALARY 
from emp_record_table
where SALARY >6000;

/*Write a nested query to find employees with experience of more than ten years.*/

select concat(FIRST_NAME, ' ', LAST_NAME) as FUll_Name, EXP
from emp_record_table
where EXP > 10;

/*create a stored procedure to retrieve the details of the employees whose experience
 is more than three years*/

select * from emp_record_table;

call employee_info(3);


/*Create an index to improve the cost and performance of the query to find the employee whose FIRST_NAME is ‘Eric’ in 
the employee table after checking the execution plan*/

select concat(first_name, ' ', last_name) as Name
from emp_record_table
where FIRST_NAME = "eric";

alter table emp_record_table add index firstname(first_name(50));
drop index firstname on emp_record_table;

select concat(first_name, ' ', last_name) as Name
from emp_record_table
where FIRST_NAME = "eric";

/*calculate the bonus for all the employees, based on their ratings and salaries (Use the formula: 5% of salary * employee rating).*/

select concat(first_name, ' ', last_name) as Name, salary, EMP_Rating, (0.05 * salary)* EMP_RATING as bonus
from emp_record_table;

/*Calculate the average salary distribution based on the continent and country*/

select concat(first_name,' ', last_name) as Name, COUNTRY, CONTINENT, avg(SALARY) as avg_salary
from emp_record_table
group by COUNTRY, CONTINENT;
