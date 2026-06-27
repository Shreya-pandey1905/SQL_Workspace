-- select * from orders;
-- create table orders2(order_id int primary key auto_increment, product_id int, quantity int , order_date datetime);
-- insert into orders2 (product_id, quantity, order_date) values (101,2,current_time()),(102,1,current_time()),
-- (103, 3, current_time()),
-- (104,2,current_time()),
-- (105,5, current_time());

-- create table inventory(product_id int primary key , stock_qty int);

-- insert into inventory values(101,50),(102,30),(103,20),(104,15),(105,40);

-- create table audit_log(audit_id int primary key auto_increment, 
-- action_type varchar(50),
-- description varchar(255), 
-- created_at datetime);

-- insert into audit_log(action_type,description,created_at) values
-- ('order','initial order for product 101',now()),
-- ('order','initial order for product 102',now()),
-- ('order','initial order for product 103',now()),
-- ('order','initial order for product 104',now()),
-- ('order','initial order for product 105',now());

-- delimiter //
-- create or replace procedure placeOrder (
-- IN p_product_id int ,
-- IN p_quantity int 
-- )
-- BEGIN
-- DECLARE v_stock int ;
-- DECLARE v_order_id int;
-- DECLARE EXIT HANDLER FOR SQLEXCEPTION
-- BEGIN
-- ROLLBACK;
-- SIGNAL SQLSTATE '45000'
-- SET MESSAGE_TEXT = 'Order processign failed , transaction rolled back';
-- END;

-- START TRANSACTION;
-- select stock_qty
--  into v_stock
--  from inventory
--  where product_id = p_product_id
-- for update;-- thread locking mechanism(works like synchronised)

-- IF 
-- v_stock is NULL THEN
-- SIGNAL SQLSTATE '45000'
-- SET  MESSAGE_TEXT = 'Product Not found';
-- END IF;


-- IF v_stock < p_quantity THEN
-- SIGNAL SQLSTATE '45000'
-- SET  MESSAGE_TEXT = 'Insufficient inventory';
-- END IF;

-- insert into orders2(product_id,quantity, order_date) 
-- values
--  (p_product_id, p_quantity, NOW());
--  
--  SET v_order_id = LAST_INSERT_ID();
--  
--  UPDATE inventory 
--  SET stock_qty= (stock_qty - p_quantity)
--  WHERE product_id = p_product_id;
--  
--  insert into audit_log(action_type , description, created_at)
--  values
--  (
--  'ORDER_CREATED',
--  CONCAT('ORDER_ID', v_order_id, 'created for product',p_product_id,'qty',p_quantity),
--  NOW()
--  );
--  
--  commit;
--  
--  END //
--  delimiter ;

/*Trigger
A trigger is special database object that automatically executes when a specify even occurs in a table.
Triggers will be applied on dml commands.
for every trigger command there Insert before after,  update before after , delete before after .
In mysql triggers provide special pseudo records - old and new 
 old- existing values before update or delete operation /
new - the new rows value for insert and update 

*/


-- select * from emp;
-- use sp;


-- call  placeOrder(103,1);

-- select * from audit_log;
-- select * from orders2;
-- select * from inventory;