-- pagination can be used with limit by order by 

/*why order by is expensive , if the dataset is huge  then the problems are :
1. CPU processing
2. Memory
3.Temporary space

*/

-- order of the queries - from where group by having select  limit order by



create table customers (cid int primary key , cname varchar(100));
create table orders (oid int primary key , itemname varchar(100), cid int , foreign key (cid) references customers(cid));

-- Customers
INSERT INTO customers (cid, cname) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David'),
(5, 'Emma');



-- Orders
INSERT INTO orders (oid, itemname, cid) VALUES
(101, 'Laptop', 1),
(102, 'Mobile Phone', 2),
(103, 'Headphones', 1),
(104, 'Keyboard', 3),
(105, 'Monitor', 5);

INSERT INTO orders (oid, itemname, cid) VALUES (106,'Mouse',null);

desc orders;
desc customers;
alter table orders add column price decimal(10,2);

alter TABLE orders ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

alter table orders add column updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP;
select c.*, o.* FROM customers c INNER JOIN orders o ON c.cid = o.cid;

select * from orders;
select * from customers;
update orders set price = 70000 where oid=101;
update orders set price = 50000 where oid=102;
update orders set price = 40000 where oid=103;
update orders set price = 30000 where oid=104;
update orders set price = 20000 where oid=105;



select c.cid,c.cname , o.oid, o.price from customers c left join orders o on c.cid= o.cid where o.oid is null;
explain select c.cid,c.cname  from customers c left join orders o on c.cid= o.cid where o.oid is null;


/*
Problem statement:
self join- find an emp who has reffered another employee.

Clustered and non clustered indexing

Modern mysql often rewrites a subquery as a semi join which makes performance better and similar to join .
Problem with correlated subquery:
*/

select * from customers c where (amount)> (select avg(price), from orders o where o.oid = c.cid);

-- it will run average again and again

select c.cid, avg(o.price) from customers c join orders o on c.cid = o.cid group by c.id; -- single pass processing usually much faster 

select e.eid , d.did ,avg(salary) from emp e inner join department d on e.eid=d.eid group by did where salary>avg(salary)

select * from emp e1 where salary >(select avg(salary) from emp e2 where e1.eid = e2.did );

select e1.eid , e2.eid , salary from emp e1 inner join emp e2 on e1.eid = e2.did where  salary>avg(salary);



-- cte - common table expression - example is below
-- cte is for readability

with department_avg
as
(select department, 
avg(salary) as avg_salary
 from emp
 group by department)

select e.* from employees e join department_avg d on e.department = d.department where e.salary>d.avg_salary;

/* Difference between exists and join
my sql 8 optimizer
many developer things joins are faster and subquery are slow which is not always true 
myql 8.0 optimizer can transform it , exists subquery into optimize join internally

*/

select * from employees;

select department , count(*) from employees group by departments;

-- the combination of join and group by outperforms correlated subqueries

create or replace view orders_view
as
(select oid , itemname from orders);

select * from orders_view;

create or replace view it_employees
as 
(select name,department from emp where department ='IT' );
-- materialised way

-- for only reading - indexing 
-- for manipulation - no indexing
select * from emp;
select name , salary , (select avg(salary) from emp ) as avg_salary from emp; -- subquery  in select clause 

select * from (select department ,avg(salary) as avg_salary from emp group by departments) as derived_table;-- subquery from clause

