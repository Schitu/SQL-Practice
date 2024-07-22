drop table if exists emp;
create table emp(
emp_id int,
emp_name varchar(20),
department_id int,
salary int,
manager_id int,
emp_age int);

insert into emp
values
(1, 'Ankit', 100,10000, 4, 39);
insert into emp
values (2, 'Mohit', 100, 15000, 5, 48);
insert into emp
values (3, 'Vikas', 100, 10000,4,37);
insert into emp
values (4, 'Rohit', 100, 5000, 2, 16);
insert into emp
values (5, 'Mudit', 200, 12000, 6,55);
insert into emp
values (6, 'Agam', 200, 12000,2, 14);
insert into emp
values (7, 'Sanjay', 200, 9000, 2,13);
insert into emp
values (8, 'Ashish', 200,5000,2,12);
insert into emp
values (9, 'Mukesh',300,6000,6,51);
insert into emp
values (10, 'Rakesh',300,7000,6,50);

select * from emp;

-- corealted subquery
select * from emp e1
where salary>(select avg(e2.salary) from emp e2 where e1.department_id=e2.department_id);

-- Independent subquery


SELECT e.emp_id, e.emp_name, d.avg_salary
FROM emp e
INNER JOIN 
    (SELECT department_id, AVG(salary) AS avg_salary 
     FROM emp
     GROUP BY department_id) d 
ON e.department_id = d.department_id
WHERE e.salary > d.avg_salary;

