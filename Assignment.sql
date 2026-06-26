-- Assignment
 

create table employees(emp_id int primary key,emp_name varchar(100),department_id int , manager_id int , salary decimal (10,2), hire_date date, city varchar(100) );

alter table employees add constraint fk1 foreign key (department_id) references departments(department_id);

create table departments (department_id int primary key , department_name varchar(100),location varchar(100));

create table orders(order_id int primary key , customer_id int ,order_date date , amount decimal(10,2), status varchar(100), foreign key (customer_id) references customers(customer_id));

create table customers(customer_id int primary key, customer_name varchar(100),city varchar(100),registration_date date);

desc employees;
desc departments;
desc customers;
desc orders;

INSERT INTO departments (department_id, department_name, location)
VALUES
(101, 'Human Resources', 'Pune'),
(102, 'Finance', 'Mumbai'),
(103, 'Information Technology', 'Bangalore'),
(104, 'Sales', 'Delhi'),
(105, 'Marketing', 'Hyderabad');

insert into departments values(106,'Operations','mumbai');

INSERT INTO employees
(emp_id, emp_name, department_id, manager_id, salary, hire_date, city)
VALUES
(1, 'Jake Gyllenhaal', 101, NULL, 75000.00, '2022-01-15', 'New York'),
(2, 'Homelandar', 102, 1, 65000.00, '2022-03-10', 'orlando'),
(3, 'Tommy Shelby', 103, 1, 85000.00, '2021-07-20', 'Toronto'),
(4, 'Sophia Davis', 104, 2, 55000.00, '2023-05-12', 'Sydney'),
(5, 'Daniel Wilson', 105, 3, 60000.00, '2023-09-01', 'Singapore');

insert into employees values (6,'Henry',101,4,30000,'2023-06-01','uk');

insert into employees values (7,'Chris',102,5,50000,'2023-06-02','uk');

INSERT INTO orders
(order_id, customer_id, order_date, amount, status)
VALUES
(101, 1, '2024-01-15', 2500.00, 'Delivered'),
(102, 2, '2024-02-10', 1800.50, 'Pending'),
(103, 3, '2024-03-05', 3200.75, 'Shipped'),
(104, 4, '2024-04-20', 1500.00, 'Delivered'),
(105, 5, '2024-05-12', 2750.25, 'Cancelled');

insert into customers values (6,'henry','uk','2023-03-01'); 

INSERT INTO customers
(customer_id, customer_name, city, registration_date)
VALUES
(1, 'Jake Gyllenhaal', 'New York', '2023-01-10'),
(2, 'Emma Stone', 'London', '2023-02-15'),
(3, 'Spiderman', 'Toronto', '2023-03-20'),
(4, 'Sophia Davis', 'Sydney', '2023-04-05'),
(5, 'Daniel Wilson', 'Singapore', '2023-05-12');


-- SELECT & WHERE
select * from employees;

select emp_name, salary from employees;

select * from employees where salary>70000; 

select * from employees where city='Sydney';

select * from employees where salary between 70000 and 90000; 

select * from employees where department_id in (101,102);

select * from employees where city!='sydney';

select * from employees where hire_date > '2023-01-01';

select * from employees where emp_name like 'j%';

select * from employees where emp_name like '%ake%';

-- IN, NOT IN, BETWEEN, LIKE

select * from employees where department_id in (101,102,103);

select * from employees where department_id not in (101,102,103);

select * from orders where order_date between '2024-01-01' and '2024-03-30';

select * from employees where emp_name like '%l';

select * from employees where length(emp_name)=15; 

-- GROUP BY & AGGREGATE FUNCTIONS

select department_id as department, count(*) from employees group by department_id;

select department_id, max(salary) from employees group by department_id;

select department_id, min(salary) from employees group by department_id;

select department_id, avg(salary) from employees group by department_id;

select department_id, sum(salary) from employees group by department_id;

select count(*) from employees group by city;

select count(emp_id), department_id from employees group by department_id having count(emp_id)>1;  

select department_id, avg(salary) as avg_salary from employees group by department_id having avg(salary)>70000 ;

select count(*) , city from employees group by city having count(emp_id)>=1; 

select avg(salary),department_id from employees group by department_id order by avg(salary) desc limit 1;

-- HAVING Clause
select department_id , count(*) from employees group by department_id having count(*)>1;

select city , sum(salary) from employees group by city having sum(salary)>70000;

select department_id , min(salary) from employees group by department_id having min(salary)>60000;  -- 

select department_id , max(salary) from employees group by department_id having max(salary)>60000;  -- 

select department_id, count(*) from employees group by department_id having count(*) between 2 and 3;

-- SUBQUERIES
select * from employees where salary>(select avg(salary) from employees);

select * from employees where salary= (select salary from employees order by salary desc limit 1);

select * from employees where salary= (select salary from employees order by salary desc limit 1 offset 1 );

select * from employees where salary<(select avg(salary) from employees);

select * from employees where department_id = (select department_id  from employees where emp_name ="Henry"); 


select * from employees where salary> (select salary from employees where emp_name='Henry'); 

select  * from departments where department_id not in(select department_id from employees) ;

select * from employees where department_id = (select department_id from departments where location='Bangalore');


select * from customers where customer_id in (select customer_id from orders);

select * from customers where customer_id not in (select customer_id from orders);

-- EXISTS / NOT EXISTS

select * from customers c where exists (select 1 from orders o where o.customer_id = c.customer_id);

select * from customers c where not exists  (select 1 from orders o where o.customer_id = c.customer_id);

select * from departments d where exists (select 1 from employees e where e.department_id = d.department_id);

select * from departments d where not exists (select 1 from employees e where e.department_id = d.department_id);

select * from employees e where exists (select 1 from employees m where m.manager_id = e.emp_id);  -- doubt

-- DATE FUNCTIONS

select * from employees where date(hire_date) = date(current_date()); 

update employees set hire_date='2026-06-26' where emp_id=8;

select * from employees where hire_date>= date_sub(current_date(),interval 30 day); 

select * from orders where year(order_date)=year(current_date()) and month(order_date)= month(current_date()) ;

select * from employees where hire_date <= date_sub(current_date(),interval 5 year); 

-- Display month-wise order count for the current year. doubt

-- Real Project Questions
select emp_name,count(*) from employees group by emp_name having count(*)>1; 

select emails,count(*) from customers group by emails having count(*)>1; 


select * from employees;
select * from departments;
select * from orders;
select * from customers;





