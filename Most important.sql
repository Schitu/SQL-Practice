drop table if exists Employee;
drop table if exists EmployeeDetail;
CREATE TABLE Employee (
EmpID int NOT NULL,
EmpName Varchar(255),
Gender Char,
Salary int,
City Char(20) );
--- first run the above code then below code
INSERT INTO Employee
VALUES (1, 'Arjun', 'M', 75000, 'Pune'),
(2, 'Ekadanta', 'M', 125000, 'Bangalore'),
(3, 'Lalita', 'F', 150000 , 'Mathura'),
(4, 'Madhav', 'M', 250000 , 'Delhi'),
(5, 'Visakha', 'F', 120000 , 'Mathura');


CREATE TABLE EmployeeDetail (
EmpID int NOT NULL,
Project Varchar(255),
EmpPosition Char(20),
DOJ date );

--- first run the above code then below code
INSERT INTO EmployeeDetail
VALUES (1, 'P1', 'Executive', '2019-01-26'),
       (2, 'P2', 'Executive', '2020-05-04'),
       (3, 'P1', 'Lead', '2021-10-21'),
       (4, 'P3', 'Manager', '2019-11-29'),
       (5, 'P2', 'Manager', '2020-08-01');
       
select * from Employee;
select * from EmployeeDetail;

-- Q1(a): Find the list of employees whose salary ranges between 1L to 3L.

select * from Employee
where salary between 100000 and 300000;

-- Q1(b): Write a query to retrieve the list of employees from the same city.



SELECT E1.EmpID, E1.EmpName, E1.City
FROM Employee E1, Employee E2
WHERE E1.City = E2.City AND E1.EmpID != E2.EmpID;



SELECT E1.EmpID, E1.EmpName, E2.EmpID AS EmpID2, E2.EmpName AS EmpName2, E1.City
FROM Employee E1
INNER JOIN Employee E2 ON E1.City = E2.City AND E1.EmpID <E2.EmpID
ORDER BY E1.City, E1.EmpID, E2.EmpID;




-- Q1(c): Query to find the null values in the Employee table.

select * from Employee;
select * from EmployeeDetail;

select * from Employee
where EmpID is null;

-- Q2(a): Query to find the cumulative sum of employee’s salary.

select * from Employee;

with cte as(
select * ,
sum(salary) over(order by salary) as cs from Employee
)
select * from cte;



-- Q2(b): What’s the male and female employees ratio.

select * from Employee;

SELECT 
    SUM(CASE WHEN Gender = 'M' THEN 1 ELSE 0 END) AS MaleCount,
    SUM(CASE WHEN Gender = 'F' THEN 1 ELSE 0 END) AS FemaleCount,
    (SUM(CASE WHEN Gender = 'M' THEN 1 ELSE 0 END) / 
     SUM(CASE WHEN Gender = 'F' THEN 1 ELSE 0 END)) AS MaleToFemaleRatio
FROM Employee;






-- Q2(c): Write a query to fetch 50% records from the Employee table.

select * from employee;

select * from employee
where empid<(select count(empid)/2 from employee);


-- Q3: Query to fetch the employee’s salary but replace the LAST 2 digits with ‘XX’



select empid,empname,
SUBSTRING(Salary, 1, LENGTH(Salary) - 2), 'XX' AS ModifiedSalary
from employee;

select empid,empname,
concat(substring(salary,1,length(salary)-2),'XX') as modified_salary
from employee;

-- Q4: Write a query to fetch even and odd rows from Employee table.

select * from employee;
with cte as(
select*,row_number() over(order by empid) as rn
from employee
)
select * from cte
where rn %2=1;

with cte as(
select * ,row_number() over(order by empid) as rn
from employee
)
select * from cte
where rn %2=0;




-- Q5(a): Write a query to find all the Employee names whose name:

select * from employee;
---  Begin with ‘A’
SELECT * FROM Employee WHERE EmpName LIKE 'A%';
-- Contains ‘A’ alphabet at second place
select * from employee where empname like'_a%';
-- Contains ‘Y’ alphabet at second last place
select * from employee where empname like'%y_';

-- Ends with ‘L’ and contains 4 alphabets
SELECT *
FROM Employee
WHERE EmpName LIKE '___l' AND LENGTH(EmpName) = 4;


-- Begins with ‘V’ and ends with ‘A’

select * from employee where empname like 'V%a';



-- Q5(b): Write a query to find the list of Employee names which is:
-- • starting with vowels (a, e, i, o, or u), without duplicates

select empname from employee 
where lower(empname) regexp '^[a,e,i,o,u]';
-- • ending with vowels (a, e, i, o, or u), without duplicates

select empname from employee
where lower(empname) regexp '[aeiou]$';
-- • starting & ending with vowels (a, e, i, o, or u), without duplicates

select empname from employee
where lower(empname) regexp '^[aeiou].*[aeiou]$';


-- Find Nth highest salary from employee table with and without using the
-- TOP/LIMIT keywords.

select * from employee;
with cte as(
select * ,rank() over(order by salary desc) as rn
from employee
) 
select * from cte
where rn=1;




-- Q7(a): Write a query to find and remove duplicate records from a table.

select * from employee;

select *,count(*) from employee
group by empid,empname,gender,salary,city
having count(*)>1;

-- Q7(b): Query to retrieve the list of employees working in same project.
select * from employee;
select * from EmployeeDetail;
with cte as(
select e1.empid,e1.empname,e2.project
from employee e1
inner join employeedetail e2
on e1.empid=e2.empid
)
SELECT c1.EmpName, c2.EmpName, c1.project
FROM CTE c1, CTE c2
WHERE c1.Project = c2.Project AND c1.EmpID != c2.EmpID AND c1.EmpID < c2.EmpID;

-- Q8: Show the employee with the highest salary for each project
with cte as(
select e1.empid,e1.empname,e1.salary,e2.project ,rank() over(partition by project order by salary desc) as rn from employee e1
join employeedetail e2
on e1.empid=e2.empid
)
select * from cte 
where rn=1;

-- Q9: Query to find the total count of employees joined each year

select * from employeedetail;

select year(e2.doj)as joined_year,count(e2.empid) as count_of_employee 
from employee e1
join employeedetail e2sys_config
on e1.empid=e2.empid
group by year(e2.doj);





-- Q10: Create 3 groups based on salary col, salary less than 1L is low, between 1 -
-- 2L is medium and above 2L is High

select *,case
when salary >200000 then 'High'
when salary between 100000 and 200000 then 'medium'
when salary <100000 then 'low'
else null
end as salary_status
from employee;


-- Query to pivot the data in the Employee table and retrieve the total
-- salary for each city.
-- The result should display the EmpID, EmpName, and separate columns for each city
-- (Mathura, Pune, Delhi), containing the corresponding total salary.

select empid,empname,
sum(case when city='mathura' then salary end) as 'Mathura',
sum(case when city='Delhi' then salary end) as 'Delhi',
sum(case when city='Bangalore' then salary end ) as 'Bangalore',
sum(case when city='pune' then salary end) as 'pune'
from employee
group by empid,empname;