use sp;
create database sp;
create table emp(id int primary key,name varchar (100) ,salary decimal(10,2));
desc emp;
insert into emp values(1,"jake",90000),(2,"shreya",89000),(3,"megan", 78000);
insert into emp values(4,"Henry", 85000,"henry@gmail.com");
select * from emp;
alter table emp add column email varchar(100);

/* what if the table already contains huge amount of data 
metadata lock
alter operation may take sometime
application performance can be impacted
need a maintainence window 
what if we need to add contraint as well
*/
update emp set email="megan@gmail.com" where id=3;
alter table emp add constraint uk Unique (email) ;

select email , count(*) from emp group by email having count(*)>1;

/* before adding unique constraint to the column we should check if the duplicate data is not present */

alter table emp add constraint ck check (salary>0);

create table products(pid int primary key , pname varchar(100), price decimal(10,2));
INSERT INTO products (pid, pname, price)
VALUES
(1, 'Laptop', 55000.00),
(2, 'Smartphone', 25000.50),
(3, 'Headphones', 1999.99),
(4, 'Keyboard', 1499.00);
select * from products;
alter table products add column category varchar(100);

/*  rename is giving syntax error for new version */
ALTER TABLE products
CHANGE COLUMN price sellingPrice DECIMAL(10,2);

alter table products modify sellingPrice decimal(10,3);

/* what risks exist while changing datatype?
1. Data conversion issues 
2. long lock time- While changing in the definition of the table we are manupulating the structure of the table so we cant perform read or write operation due to the lock.
3. Application compatibility
4. Index rebuild: If index is created on the column that we are trying to change we will have to rebuild the index.it uses binary search tree and all which also includes nodes and all. 

Truncate effect: Delete all rows structure remains . Truncate is faster than delete because delete processes data row by row and writes the complete entry to the transaction log for every single row removed 
                 while truncates acts as a ddl command that bypasses row by row scanning and instantly drops all rows by deallocating the undersline data pages.
 */

create table orders (id int primary key auto_increment , name varchar(50));
insert into orders (name) values ("order1 ");
insert into orders (name) values ("order2 ");
select * from orders;

truncate table orders;
delete from orders;
-- set sql_safe_updates == 0; 



/* 
TRUNCATE

instead of deleting rows indivisually truncate drops the table data pages.
 creates a fresh table empty structure . truncate resets autoincrement , we cant use where clause
 Primary key and unique key
 
 the structural constraints survive , underline index are completetly empty but rename ready for new data 
 Check constraints: rules for data validity stays active .
 Not Null :Columns will still require mandatary values  for insert
 */
 
 
 /* for Restore 
  if we backup ? depends upon dba and logs
Options 
 1.Restore from backup (if dba takes daily backup).
 2.Point and time recovery , bin log recovery, disaster recovery process.
 
 */
 
 set autocommit =0;  -- permission  not given in the company if 0 is the value then the rollback will not be done  
 
create table users (id bigint primary key , username varchar(100));
desc users;
select * from users;
alter table users add column created_at timestamp default current_timestamp, 
        add column updated_at timestamp default current_timestamp on update current_timestamp;
        
insert into users(id,username) values(1,"jake"),(2,"shreya");
        
update users set username = "Henry" where id =2;   


/* Why every enterprise need these columns - created_at and updated_at 
1.Audit tracking
2.Debugging
3. Reporting
4. Compliance
*/   

SHOW VARIABLES LIKE 'binlog_format'; 
SET GLOBAL binlog_format='STATEMENT';
SHOW VARIABLES LIKE 'log_bin';
SHOW binary logs; -- maintains all the operations you have perform 

-- show binlog events on 'desktop path from output';

-- is truncate can be rollback?
-- how do you add a column in the 5 hundred million tables without downtime?


create table student (id int , name varchar(50));
select * from student;

-- rollback will work on dml commnads if auto_commit is not on
/* biggest risk in update is
1. missing where clause
2.mass data corruption
3.log contention on large tables 
 
 */

select * from emp;
alter table emp add column department varchar(100);
update emp set department="IT" where id=1;
update emp set department="Sales" where id=2;
update emp set department="Marketing" where id=3;

insert into emp values(4,"Henry", 85000,"henry@gmail.com","IT");

update emp set salary=salary*0.02 where department ='IT' ;


/* 
Soft Delete vs Hard Delete

Soft Delete means keeping one more boolean column inside the table and keeping it true when the data is deleted. 
Most enterprise system avoid actual delete.

e.g command - alter table emp add column is_delted boolean default false;

*/

create table accounts(id int, account_number bigint, holdername varchar(100) );

insert into accounts values(1,123456789, "jake",8000),(2,789456123,"henry",6000);
alter table accounts add column balance decimal(10,2);
select * from accounts;
truncate table accounts;
start transaction;
update accounts set balance = balance +6000 where id =1 ;
update accounts set balance = balance +2000 where id =2;
commit ;

