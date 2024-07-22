CREATE DATABASE THEMLMINE;
USE THEMLMINE;

CREATE TABLE Employees(
ID INT NOT NULL PRIMARY KEY,
Name VARCHAR(20),
Salary INT
);

INSERT INTO Employees VALUES 
(1, 'Somesh', 90000),
(2, 'Vinay', 70000),
(3, 'Hima', 75000),
(4, 'Prashant', 70000),
(5, 'Shivangi', 45000),
(6, 'Priya', 40000),
(7, 'Mohan', 95000);

select * from employees;

-- Write s sql quert to find the nth highest salary

-- find 2nd highest salary
-- usin offset and limit
select * from employees
order by salary desc
limit 1 offset 1;

-- using desnse rank
with cte as(
select *,
dense_rank() over( order by Salary Desc) as dn
from employees
)
select *  from cte
where dn=2;

-- find 6 th highest salary

select * from employees
order by salary desc
limit 1 offset 5;

with cte as(
select * ,rank() over(order by salary desc) as dn
from employees
) 
select * from cte 
where dn=6;


CREATE TABLE sales (
order_id INT PRIMARY KEY,
product_name varchar(20) NOT NULL,
units_sold INT DEFAULT 0,
unit_price FLOAT 
);

CREATE TABLE products (
category varchar(20) NOT NULL,
product varchar(20)
);

INSERT INTO sales VALUES
(122,'Bikaji_namkeen',1500,200),
(112,'Lays',10000,20),
(110,'Amul_kool',2200,25),
(138,'Dairy_milk',2000,149),
(202,'Monaco',9000,50),
(118,'Coke',7000,95),
(104,'Appy_fizz',8000,35),
(189,'KitKat',4500,70),
(238,'Dosa_batter',3000,99),
(199,'Munch',4500,80),
(448,'Maggi',10000,168);

INSERT INTO products VALUES
('Snacks','Bikaji_namkeen'),
('Snacks','Lays'),
('Snacks','Monaco'),
('Drinks','Amul_kool'),
('Drinks','Coke'),
('Drinks','Appy_fizz'),
('Chocolates','KitKat'),
('Chocolates','Munch'),
('Chocolates','Dairy_milk'),
('Instant_food','Dosa_batter'),
('Instant_food','Maggi');

select * from sales;
select * from products;

-- sql query to fing second highest selling product for each product category order by product name
with cte as(
select s.*,p.category ,s.units_sold*s.unit_price as sold,dense_rank() over(partition by category order by s.units_sold*s.unit_price desc) as dn
from sales s
inner join products p
on s.product_name=p.product
)
select category,product_name from cte where dn=2;
drop table emp;
CREATE TABLE emp
(
 emp_id INT,
 name varchar(20),
 age INT,
 salary FLOAT
);

INSERT INTO emp VALUES
(102, 'Aviral', 24, 20000),
(103, 'Arohi', 28, 350000),
(104, 'James',35, 120000),
(998, 'Aviral', 24, 20000);


select * from emp;

-- find the duplicate entry

select name ,age,salary ,count(*),max(emp_id) from emp
group by name,age,salary 
having count(*)>1;


-- delete the dupplicate entry
-- need to create a temporary table
create temporary table  emp_temp  as 
select * from emp;

delete from emp 
where emp_id in (select max(emp_id) from emp_temp
group by name,age,salary
having count(*)>1);
drop table emp_temp;

select * from emp;

-- To keep the entries
create temporary table emp_temp as
select * from emp;
delete from emp
where emp_id not in ( select min(emp_id) from emp_temp
group by name,age,salary );
select * from emp;

-- if they have two entries and delete it

create temporary table emp1
as select * from emp;

delete from emp where emp_id in(
with cte as
(
select *,row_number()over(partition by name,age,salary order by emp_id) as rn
from emp1
)
select emp_id from cte
where rn>1);
select * from emp;


-- if everything is duppicate all columns are repeated
drop table emp;
CREATE TABLE emp
(
 emp_id INT,
 name varchar(20),
 age INT,
 salary FLOAT
);

INSERT INTO emp VALUES
(102, 'Aviral', 24, 20000),
(103, 'Arohi', 28, 350000),
(104, 'James',35, 120000),
(102, 'Aviral', 24, 20000);
select * from emp;

-- using distinct keyword copied unique value and renamed the column name with original col name by depeting the previous one
create table emp2 as 
select distinct * from emp;

select * from emp2;
drop table emp;
Alter table emp2 rename emp;
select * from emp;

-- If we want to replace it by not deleting 
create table emp1 as 
select  distinct * from emp;

truncate table emp;
insert into emp
select * from emp1;

select * from emp








