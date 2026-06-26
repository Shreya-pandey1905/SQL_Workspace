/*TemporARY TABLE */

create temporary table temp (id int);-- also practice temp of existing table 

create or replace temporary table temp_table 
as
select id, name, salary, email , designation from emp; 

select * from temp_table;

insert into temp_table values(6,'spiderman',80000,"spider@gmail.com",'developwe');

desc temp;
select * from emp where name ='jake';
use sp;
create or replace view customer_view
as
(select id, name, salary, email , designation from emp);


select * from customer_view;
update  customer_view set salary=100000 where id=1;
alter view customer_view as (select id, name, salary, email , designation from emp);

insert into customer_view values (5,'henry',50000,'henry@gmail.com','developer0');

alter table emp add column designation varchar(100);

create table sales (id int primary key auto_increment,city varchar(100));
INSERT INTO sales (city)
VALUES
    ('Bombay'),
    ('Delhi'),
    ('Pune'),
    ('Bengaluru'),
    ('Chennai');



SET SQL_SAFE_UPDATES = 0;

create temporary table sales_temp

as

 select * from sales_temp;


update sales_temp set city ='Mumbai' where id =1;
insert into sales(city) select city from sales_temp;

explain analyze select * from sales;


explain  select * from emp;

explain analyze select * from emp;

SELECT VERSION();

/* Assignments
 * How to select an efficient database for you application?
 * Normalization types and denormalization
 * views,subquery,temp,cte 
 * over , partioning , rank
 * 
 * */


/*
*CTE are widely used in reporting queries , complex simplification , recursive queries , banking an erp application
*CTE is a temporary named result set that exists only during execution of that query.
*
**/

with dept_salary
as
(select department, AVG(salary)
as avg_salary 
from emp
group by department ) ,
high_salary
as
(select * from department, salary where avg_salary>60000 );
select * from high_salary;

select * from emp;
truncate table emp;

/*window function  performs calculation approx a set of rows while still returning indivisual rows
group by collapses rows while windows fucntion keeps row intact
*/

INSERT INTO emp (id, name, salary, email, designation, did) VALUES
(1, 'Amit Sharma', 45000, 'amit.sharma@example.com', 'Developer', 1),
(2, 'Priya Patel', 52000, 'priya.patel@example.com', 'Senior Developer', 1),
(3, 'Rahul Verma', 48000, 'rahul.verma@example.com', 'Developer', 1),

(4, 'Sneha Gupta', 60000, 'sneha.gupta@example.com', 'HR Executive', 2),
(5, 'Anjali Desai', 58000, 'anjali.desai@example.com', 'HR Manager', 2),

(6, 'Vikram Singh', 75000, 'vikram.singh@example.com', 'Finance Manager', 3),
(7, 'Karan Malhotra', 68000, 'karan.malhotra@example.com', 'Accountant', 3),

(8, 'Neha Joshi', 47000, 'neha.joshi@example.com', 'Developer', 1),
(9, 'Arjun Mehta', 55000, 'arjun.mehta@example.com', 'Tester', 1),
(10, 'Pooja Nair', 50000, 'pooja.nair@example.com', 'Support Engineer', 1);
ALTER TABLE emp
ADD CONSTRAINT fk_emp_department
FOREIGN KEY (did)
REFERENCES departments(department_id);

select name,salary,row_number() over(order by salary desc) as salary_column from emp;

select name,salary,rank() over(order by salary desc) as salary_column from emp;
select name,salary,dense_rank() over(order by salary desc) as salary_column from emp;

-- row -1234
-- rank -  1134
-- dense rank - 1123

select * from emp;

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

INSERT INTO departments (department_id, department_name) VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Sales'),
(5, 'Marketing'),
(6, 'Operations');

with high_sal AS (
    select
        name,
        salary,
        did,
        ROW_NUMBER() over (partition BY did order by salary DESC) AS rn_dense from emp)
SELECT * FROM high_sal where rn_dense = 1;

-- top three earners in each dept 

with high3_sal AS (
    select
        name,
        salary,
        did,
        ROW_NUMBER() over (partition BY did ORDER BY salary desc limit 3)  from emp)
SELECT * FROM high_sal ;

with duplicate_column as 
(select * row_number () over (partition by did order by id  ) as duplicate from emp where row_number>1;


select * from duplicate where 

-- windows fucntion performs calculation accross related rows without collapsing data .
-- row number gives unique numbering, rank fucntion allows ties and skips rank while dense rank allows ties without skippping rank 
-- these are basicaaly used for ranking top n analysis , duplication and reporting


/*Indexing is one of the most important topic for query optimization 
 * An index is a db object that helps mysql find rows faster without scanning the entire table 
 * 
 * 
 * */