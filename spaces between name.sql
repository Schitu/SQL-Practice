drop table if exists customers;
-- Create table
CREATE TABLE customers (
    name VARCHAR(100)
);

-- Insert data
INSERT INTO customers (name) VALUES 
    ('Ankit Bansal'),
    ('Vishal Pratap Singh'),
    ('Michael');
select * from customers;


-- Find the spaces between names

select replace(name," ",'') as name_with_no_commas
from customers;

select length(replace(name," ",'')) as len_of_the_name_with_no_commas
from customers;

select length(name) as length_of_orginal_name
from customers;

select length(name)-length(replace(name," ",'')) as no_of_spaces 
from customers;


with cte as
(
select *,length(name)-length(replace(name," ",'')) as no_of_spaces 
from customers
)
select *, 
case 
when no_of_spaces=0 then name
when no_of_spaces=1 then substring_index(name,' ',1) 
when no_of_spaces=2 then substring_index(name,' ',1)
else null
end as firstname,
case 
when no_of_spaces = 2 then substring_index(substring_index(name, ' ', -2), ' ', 1)
else null
end as middle_name,
case
 when no_of_spaces=1 then substring_index(name,' ',-1)
 when no_of_spaces=2 then substring_index(name,' ',-1)
 ELSE NULL
 end as last_name
from cte;




