-- try me commit , catch rollback
start transaction;
insert into accounts values(6,741258963, "jh",50000),
							(7,85471255, "rdmbe",6000);
                           

rollback;

create user 'chris'@'%' identified by '12345' ;
grant insert on  sp.emp to 'chris'@'%';

/* This user can only login when your application is running a script or terminal directly on the same physical server where mysql is installed*/

 /*
the user can only login from that specific internet IP addres s*/
create user 'shreya'@ '192.168.1.50' identified by '12345';



grant all privileges on *.* to 'shreya'@'%' with grant option;

-- with grant - user can give the access to whoever he wants 
-- this user will have access to everything, and can grant permission to others.

-- revoke
revoke insert,update,delete on sp.emp from 'chris'@'%';

-- drop will delete the profile from user 
drop user 'chris'@'%';

select * from emp;

delete from emp where id = 8;

show grants for 'chris'@'%';
set autocommit=0;
-- RBAC -Role based access control

create role manager ;

grant select on sp.* to manager;

grant manager to 'chris'@'%','shreyaa'@'%';

/* from above rbac we unnderstood
easier management , better security, standardized permissions
*/
select * from emp;

start transaction;
insert into emp values (4,"chris",65800,"chris@gmail.com");
savepoint sp1;

insert into emp values (5,"henry",98000,"henry@gmail.com");
savepoint sp2;

insert into emp values(6,"jade", 87000,"jade@gmail.com");

rollback to sp1;


/* 
1.Explain acid properties.
2.architecture plan for database like how the it happens , how traslated.
3.DBMS vs RDBMS.
4.datatypes
5. list all library methods of string

*/

create table employee(emp_id int , emp_name varchar(100), dept varchar(100), salary decimal(10,2), city varchar(50), doj DATE);
desc employee;
INSERT INTO employee (emp_id, emp_name, dept, salary, city, doj) VALUES
(101, 'Rahul Sharma', 'IT', 65000.00, 'Mumbai', '2021-06-15'),
(102, 'Priya Verma', 'HR', 55000.00, 'Pune', '2020-09-10'),
(103, 'Amit Patel', 'Finance', 72000.50, 'Ahmedabad', '2019-03-25'),
(104, 'Sneha Joshi', 'Marketing', 60000.75, 'Nagpur', '2022-01-12'),
(105, 'Vikram Singh', 'IT', 80000.00, 'Delhi', '2018-11-05');

select * from employee where emp_id =101;

select * from employee where salary>50000 && city='Pune';
select * from employee where city in ('Mumbai','Pune');

-- in will compare all field defined and exist will only return the first occurennce.IN doesnt work properly with null .

select * from transactions where status='success'&& amount >100000;

select * from employee where salary  between 60000 and 80000;
select * from employee where emp_name like 's%';
select * from employee where emp_name like '%l';
select * from employee where emp_name like '%l%';

select * from customers c where exists(select 1 from orders as o  where c.cid = o.ordersid); -- check once

/*For large correlated dataset , exist often performs better because it stops searching once a macthed is found while in compares and returns all the data 
fetch it employees , salary >50000, coming form mumbai or pune , joined in 2025
in vs exists - in compares values , exists checks the existence of the rows, exists is often better for large dataset with correlated subqueries. 

%gmail.com - what is problem with this command? .
 1.leading wildcard prevent index usage ,
 2.full table scan may occur ,
 3.query becomes slow
 
 charLength- return no of bytes 
 */
-- also use word seperator , substr , replace, ceil ,floor
select concat(emp_name, salary) from employee;
select round(10.11);

-- Date fucntions
select current_date() ;
select now();
select year(2026);
select month();
select day(doj) from employee;

select datediff(current_date(),doj) from employee;

-- my sql provides interval as a keyword which is used to represent a time period (days, months , years,hrs) that can be added to or subtracted from a date time values
select current_date()+interval 7 day;
select date_add(current_date(),interval 30 day) from employee;
select date_sub(current_date(), interval 7 day); 
select timestampdiff(month, start date , end date);  -- use to calculate difference between two dates and timstamp in the specified unit 
-- expiry
select concat(upper(emp_name), upper(city)) from employee;

-- pagination can be used with limit by order by 



