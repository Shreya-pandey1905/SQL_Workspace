-- DELIMITER //

-- DROP TRIGGER IF EXISTS negativeSalary//

-- CREATE TRIGGER negativeSalary
-- BEFORE INSERT
-- ON emp
-- FOR EACH ROW
-- BEGIN
--     IF NEW.salary < 0 THEN
--         SIGNAL SQLSTATE '45000'
--         SET MESSAGE_TEXT = 'Salary cannot be negative';
--     END IF;
-- END//

-- DELIMITER ;

-- select * from emp;

-- insert into emp values(11,'test',-6454,'ss@gmail.com','hr',2);

-- create table emp_audit(audit_id int primary key auto_increment,action_type varchar(100), emp_id int , action_time datetime);

delimiter //
CREATE TRIGGER afteremp
after insert
on emp
for each row
begin
   insert into emp_audit (action_type , emp_id , action_time) values ('INSERT',new.id, now());
   end //
   
delimiter ;

select * from emp;
insert into emp values(12,'test2',5666,'ss2@gmail.com','hr',2);

select * from emp_audit;

delimiter //
create trigger updateemp
before update 
on emp
for each row
begin
if new.salary<(old.salary*0.5) then
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'new salary cant be less that 50 % of the old salary';
     END IF;
  end //
  delimiter ;
  
  update emp set salary=90000 where id =1;
  
  create table salaryHistory(id int , old_salary decimal(10,2), new_salary decimal(10,2));
  
  delimiter //
  create or replace trigger updatesalarylog
  after update 
  on emp
  for each row 
  begin
  if old.salary<>new.salary then
  insert into salaryHistory values(old.id, old.salary, new.salary);
  end if ;
  end //
  delimiter ;
 
  
  select * from salaryHistory;
  
  delimiter //
  create or replace trigger deleteEmp
  before delete 
on emp
for each row 
begin
if old.id=1 then
signal sqlstate  '45000'
set message_text = 'ceo will not be removed ';
end if ;
end //
delimiter ;

delete from emp where id =1;
insert into emp values(1,'test2',5666,'ss3@gmail.com','hr',2);
  se
  
  
  update emp set salary = 60000 where id=8;
  update emp set salary =60000 where id =8;
  
  create table deleteHistory(id int , name varchar(50), deleted_on datetime);

delimiter //
create or replace trigger deleteLog
after delete
on emp
for each row 
begin 
   insert into deleteHistory values(old.id, old.name, now());
end //
delimiter ;

delete from emp where id =12;
   
 select * from deleteHistory;