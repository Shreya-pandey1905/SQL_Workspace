-- use shreya;

CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    department_id INT,
    salary DECIMAL(10,2) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE performance_reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    rating INT NOT NULL,
    review_date DATE,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)  on delete cascade
);

CREATE TABLE employee_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    name VARCHAR(100),
    email VARCHAR(100),
    deleted_at DATETIME
);

CREATE TABLE employee_bonus (
    bonus_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    bonus_amount DECIMAL(10,2),
    created_at DATETIME,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)  on delete cascade
);

CREATE TABLE error_logs (
    error_id INT AUTO_INCREMENT PRIMARY KEY,
    error_message TEXT,
    created_at DATETIME
);

-- 3
CREATE TABLE accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    account_holder VARCHAR(100) NOT NULL,
    balance DECIMAL(10,2) NOT NULL
);

CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    from_account INT,
    to_account INT,
    amount DECIMAL(10,2),
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'PLACED',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE orders_archive (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME,
    total_amount DECIMAL(10,2),
    status VARCHAR(20),
    archived_at DATETIME DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE order_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    log_message VARCHAR(255),
    created_at DATETIME,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);


CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE purchase_items (
    purchase_item_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL, 
    quantity INT NOT NULL,
    purchase_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) on delete cascade,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255),
    status VARCHAR(20) NOT NULL
);

-- Departments
INSERT INTO departments (department_name) VALUES
('Engineering'),
('Human Resources'),
('Finance'),
('Sales'),
('Operations');

-- Employees
INSERT INTO employees (name, email, department_id, salary) VALUES
('Amit Sharma', 'amit.sharma@example.com', 1, 90000.00),
('Priya Mehta', 'priya.mehta@example.com', 1, 105000.00),
('Rahul Verma', 'rahul.verma@example.com', 2, 65000.00),
('Sneha Iyer', 'sneha.iyer@example.com', 3, 78000.00),
('Vikram Rao', 'vikram.rao@example.com', 4, 85000.00),
('Neha Singh', 'neha.singh@example.com', 5, 72000.00);

-- Performance Reviews
INSERT INTO performance_reviews (employee_id, rating, review_date) VALUES
(1, 4, '2026-01-15'),
(2, 5, '2026-01-15'),
(3, 3, '2026-01-16'),
(4, 4, '2026-01-17'),
(5, 5, '2026-01-18'),
(6, 2, '2026-01-19');

-- Accounts
INSERT INTO accounts (account_holder, balance) VALUES
('Amit Sharma', 50000.00),
('Priya Mehta', 30000.00),
('Rahul Verma', 15000.00);

-- Customers
INSERT INTO customers (customer_name, email) VALUES
('Acme Corp', 'billing@acme.com'),
('Globex Ltd', 'accounts@globex.com'),
('Initech', 'finance@initech.com'),
('Umbrella Pvt Ltd', 'orders@umbrella.com');

-- Categories
INSERT INTO categories (category_name) VALUES
('Electronics'),
('Furniture'),
('Stationery');

-- Products
INSERT INTO products (product_name, category_id, price, stock_quantity) VALUES
('Laptop', 1, 75000.00, 10),
('Mouse', 1, 700.00, 100),
('Office Chair', 2, 8500.00, 25),
('Desk', 2, 12000.00, 15),
('Notebook', 3, 80.00, 500),
('Pen', 3, 20.00, 1000);

-- Orders
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES
(1, '2026-01-10 10:30:00', 75700.00, 'PLACED'),
(2, '2026-02-12 14:20:00', 20500.00, 'PLACED'),
(3, '2026-03-18 09:10:00', 15000.00, 'PLACED'),
(4, '2025-11-05 16:45:00', 9000.00, 'PLACED'),
(1, '2025-12-20 11:00:00', 120000.00, 'PLACED');

-- Order Items
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 75000.00),
(1, 2, 1, 700.00),
(2, 3, 1, 8500.00),
(2, 4, 1, 12000.00),
(3, 5, 100, 80.00),
(3, 6, 350, 20.00),
(4, 3, 1, 8500.00),
(4, 6, 25, 20.00),
(5, 1, 1, 75000.00),
(5, 4, 3, 12000.00),
(5, 2, 10, 700.00);

-- Purchase Items
INSERT INTO purchase_items (product_id, quantity, purchase_date) VALUES
(1, 20, '2026-01-01'),
(2, 200, '2026-01-01'),
(3, 40, '2026-01-02'),
(4, 25, '2026-01-02'),
(5, 800, '2026-01-03'),
(6, 1500, '2026-01-03');

-- Users
INSERT INTO users (email, password_hash, status) VALUES
('active.user@example.com', 'hashed_password_1', 'ACTIVE'),
('blocked.user@example.com', 'hashed_password_2', 'BLOCKED'),
('inactive.user@example.com', 'hashed_password_3', 'INACTIVE');


CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    department_id INT,
    salary DECIMAL(10,2) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);


DELIMITER //
create or replace procedure email_check(IN ename varchar(100), IN email_id varchar(255) ,IN dept int,IN sal decimal(10,2))
BEGIN
IF EXISTS(select 1 from employees where email=email_id) then
signal sqlstate '45000'
set message_text ="email already exists";

ELSE
insert into employees (name, email, department_id,salary) values(ename,email_id,dept,sal);
END IF;

END //

DELIMITER ;

CALL email_check('jake','jake@gmail.com',3,50000);

delimiter //
create  procedure salarycheck(IN eid int, IN sal decimal(10,2))
BEGIN
IF sal<=0 then
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT= 'SALARY IS NOT VALID';
ELSE
UPDATE employees SET salary=sal where employee_id= eid;
END IF;
END //
DELIMITER ;
select * from transactions;
CALL salarycheck(1,0);

----------------------------------------------------------------------------------------------


DELIMITER //
CREATE or replace PROCEDURE transactions(IN sender varchar(255) ,IN receiver varchar(255), IN bal decimal(10,2))
BEGIN
DECLARE checksal decimal(10,2);
DECLARE EXIT HANDLER FOR SQLEXCEPTION
 BEGIN
 ROLLBACK;
 resignal;
 end;
 START transaction;
 BEGIN
 select bal into checksal from accounts where account_id=sender;
 IF checksal> bal then
 
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT= 'Balance is not sufficient';
ELSE
UPdate accounts set balance = (balance - bal) where account_id = sender;

Update accounts set balance = (balance + bal) where account_id = receiver;
insert into transactions (from_account, to_account, amount) values(sender, receiver,amount);
commit;
end if ;
end ;

END //
delimiter ;


call transactions(1,2,2000);


select * from departments;
select * from accounts;
----------------------------------------------------------------------------------------------

delimiter //
create  procedure departmentEmployees(IN did int)
begin
select * from employees where department_id = did order by name desc;
end //
delimiter ;

call departmentEmployees(2);

----------------------------------------------------------------------------------------------


delimiter //
create or replace procedure search(IN did int , IN ename varchar(50),IN sal decimal(10,2))
begin
select * from employees where
 (department_id = did or name = ename or salary< sal);

end //
delimiter ;
call search(1,null ,null);
call search(null ,'Amit Sharma',null);

----------------------------------------------------------------------------------------------


delimiter //
create or replace procedure salInfo(IN did int)
begin
select department_id , count(*), avg(salary), min(salary), max(salary),sum(salary) from employees where department_id = did group by department_id;
end //
delimiter ;
-- dname bhi aana chahiye 
call salInfo(1);

select * from employee_audit;
select * from orders3;

----------------------------------------------------------------------------------------------


delimiter //
create or replace procedure auditlog(IN eid int)
begin

insert into employee_audit (employee_id, name , email) values(eid,(select name from employees where employee_id = eid),(select email from employees where employee_id = eid));
delete from employees where employee_id =eid;
end //
delimiter ;

call auditlog(6);
use shreya;

----------------------------------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE review(
    IN ratings INT,
    IN increment DECIMAL(10,2)
)
BEGIN
    UPDATE employees AS e
    JOIN performance_reviews AS pr
        ON e.employee_id = pr.employee_id
    SET e.salary = e.salary + (e.salary * increment)
    WHERE pr.rating >= ratings;
END //

DELIMITER ;

-- promote employees based on performance rating 
-- generate monthyly sales report 
-- monthwise no of items sold and sum of the amount , argument me year doge 
-- 
select * from orders;
----------------------------------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE monthly_sal(
    IN years int
)
BEGIN
    SELECT
        MONTH(order_date) as month,
        COUNT(order_id) as total_orders,
        SUM(total_amount) as total_sales
    FROM orders
    WHERE YEAR(order_date) = years
    GROUP BY MONTH(order_date)
    ORDER BY MONTH(order_date);
END //

DELIMITER ;
select * from products ;
select * from orders ;

----------------------------------------------------------------------------------------------


delimiter //
CREATE PROCEDURE high_revenue(IN limits int)
BEGIN
SELECT c.customer_id , c.customer_name , o.total_amount, sum(total_amount) as revenue
from customers c inner join orders o group by customer_id order by revenue limit 10 ;
end //

delimiter ;

call high_revenue(1,'Initech');

----------------------------------------------------------------------------------------------

delimiter //
create procedure increment_price (IN cid int , IN increment decimal(10,2))
BEGIN
update products set price = price +(price*increment) where category_id = cid;
end //
delimiter ;
select * from order_logs;
select * from orders;

call increment_price(2,0.5);

----------------------------------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE order_loggs(IN cid INT,IN amt DECIMAL(10,2)
)
BEGIN
    DECLARE last_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    INSERT INTO orders(customer_id, order_date, total_amount, status)
    VALUES (cid, NOW(), amt, 'PLACED');

    SET last_id = LAST_INSERT_ID();

    INSERT INTO order_logs(order_id, log_message, created_at)
    VALUES (last_id, 'ORDER PLACED SUCCESSFULLY', NOW());

    COMMIT;
END //

DELIMITER ;

call order_loggs(1,5000);


----------------------------------------------------------------------------------------------


delimiter //

CREATE or replace PROCEDURE deleteandinsert(IN years date)

BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

start transaction;
begin
insert into orders_archive (customer_id, order_date, total_amount,status) select customer_id,order_date, total_amount,status from orders  where order_date< years;
delete from orders where order_date< years ;
commit ;
end ;

end //
delimiter ;

call deleteandinsert('2026-11-05'); 
set sql_safe_updates =0;

select * from orders_archive;
select * from departments;
----------------------------------------------------------------------------------------------


delimiter //
create procedure logincheck(in email_id varchar(255))
begin
select user_id,email,status,
case when status='ACTIVE' then 'Login allowed'
else 'Login blocked'
end as login_status from users where email= email_id;
end //
delimiter ;

call logincheck('blocked.user@example.com');

----------------------------------------------------------------------------------------------


delimiter //
CREATE or replace PROCEDURE salaryoutput(IN emp_id int, OUT sal decimal(10,2))
BEGIN 
SELECT salary into sal from employees where employee_id = emp_id ;
end //
delimiter ;

call salaryoutput(1,@sal);
select @sal;

----------------------------------------------------------------------------------------------


delimiter //
create or replace procedure deptWiseSalStatistics (IN dept_id int ,OUT max_sal decimal(10,2),OUT min_sal decimal(10,2), 
OUT avg_sal decimal(10,2) ,OUT total_sal decimal(10,2))
BEGIN
SELECT  ifnull(max(salary),0) , ifnull(min(salary),0)  ,ifnull(avg(salary),0) ,ifnull(sum(salary),0)
 into max_sal,min_sal ,avg_sal,total_sal from employees where department_id=dept_id;
end //
delimiter ;

call deptWiseSalStatistics(1,@max_sal,@min_sal,@avg_sal,@total_sal);
select @max_sal,@min_sal,@avg_sal,@total_sal;

----------------------------------------------------------------------------------------------


DELIMITER //
CREATE PROCEDURE lastInsertedEmp(IN emp_name varchar(50),IN email_id varchar(50),IN did int , IN sal decimal(10,2),OUT LAST_ID int)
BEGIN
insert into employees (name , email , department_id , salary) values(emp_name, email_id, did, sal);
SET  last_id = last_insert_id();
END //
DELIMITER ;

CALL lastInsertedEmp('JAKE GYLLENHAAL', 'jake@gmail.com',1,5000,@last_id);
select @last_id;
----------------------------------------------------------------------------------------------

DELIMITER //
CREATE or replace PROCEDURE discountAmount(IN discount decimal(10,2), INOUT amt decimal(10,2))
BEGIN

SET amt = amt -(amt*discount);

END //
DELIMITER ;

set @amt=10000;
call discountAmount(0.5,@amt);
select @amt;
----------------------------------------------------------------------------------------------
DELIMITER //
CREATE OR REPLACE PROCEDURE StringFunction(INOUT STR VARCHAR(100))
BEGIN
set str = trim(str);
set str = concat(upper(left(str,1)),lower(substr(str,2)));
end //
delimiter ;

set @str='    jaKEe  ';
call StringFunction(@str);
select @str;
----------------------------------------------------------------------------------------------

DELIMITER //

CREATE or replace PROCEDURE pagination (IN current_page varchar(50),IN total_records VARCHAR(100))
BEGIN
DECLARE START INT;
DECLARE END INT;
SET START= (CURRENT_PAGE-1) * (total_records);
SET END = (current_page*total_records);
select start,end;

END //
delimiter ;
call pagination(3,10);

-------------------------------------------------------------------------------------

DELIMITER //
CREATE OR REPLACE PROCEDURE atm_procedure(IN max_retry int , INOUT retry_count int , INOUT status varchar(100))
BEGIN
set retry_count = retry_count +1;
IF max_retry> retry_count
then set status= 'ALLowed';
else
set status= 'Not allowed';
end if ;
End //

DELIMITER ;

set @retry_count =1;
call atm_procedure(3,@retry_count,@status);
select @retry_count;

select @status;

----------------------------------------------------------------------------------------------




select * from orders;
select * from products;
select * from order_items;




/*  
Assignment
cancel order and restock order , tables- order_items , products , orders

-- delete the records from the main table before 20th jan
-- and take a log in a order_archive 

-- genneratesequence ("inv,@seq",@invoiceno)
-- output = inv-2026-'00100'
-- 		 inv-2026-'00101'
*/

DELIMITER //
CREATE PROCEDURE orderOperation(IN oid int)
BEGIN
    START TRANSACTION;

    UPDATE orders
    SET status = 'CANCELLED'
    WHERE order_id = oid;

    UPDATE products p
    JOIN order_items oi
        ON p.product_id = oi.product_id
    SET p.stock_quantity = p.stock_quantity + oi.quantity
    WHERE oi.order_id = oid;

    commit;
END //
DELIMITER ;

call orderOperation(4);


DELIMITER //
CREATE OR REPLACE PROCEDURE generateSequence(
    IN inv VARCHAR(20),
    INOUT seq INT,
    OUT invoice_no VARCHAR(30)
)
BEGIN
    SET invoice_no = CONCAT(inv, '-', LPAD(seq, 5, '0'));

    SET seq = seq + 1;
END //
DELIMITER ;

SET @seq = 100;

CALL generateSequence('INV-2026', @seq, @invoice);

select @invoice;




select * from departments;