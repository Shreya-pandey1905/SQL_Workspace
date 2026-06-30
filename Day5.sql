use sp;
select * from emp;
Delimiter //
create or replace procedure Demo()
begin
select  * from emp ;
end //
delimiter ;

call Demo();

Delimiter //
create or replace procedure GetEmp(In dept_name varchar (50))
 begin
select  * from emp where dept = dept_name ;
end //
delimiter ;

call GetEmp('HR')
  
  Delimiter //  -- Total number of employees 
  create or replace procedure get_emp(out total_count bigint)
  begin
   select count(*) into total_count from emp ;
   end//
delimiter ;
call get_emp(@count);-- Global variable should be declared with @. 
select @count ;
desc emp;

delimiter // -- Total number of employees in the IT department. 
 create or replace procedure get_deptemp(in dept_n varchar(20),out total_count bigint)
  begin
   select count(*) into total_count from emp where dept=dept_n ;
   end//
delimiter ;
call get_deptemp('IT',@countdeptemp);
select @countdeptemp;
select * from emp;


delimiter // -- Total number of employees of each department 
 create or replace procedure get_deptempall()
  begin
   select count(*) as total_emp from emp group by dept ;
   end//
delimiter ;
call get_deptempall();


delimiter //  -- Total sum of salary of a specific department 
 create or replace procedure get_totalsalary(in dept_n varchar(20),out total_salary decimal(10,2))
  begin
   select sum(salary) into total_salary from emp where dept=dept_n ;
   end//
delimiter ;
call get_totalsalary('IT',@total_sal);
select @total_sal;



-- Increment the salary of the employee by a certain percentage.
delimiter // 
create or replace procedure increament_sal(in empid int,in percent decimal(10,2))
begin
 update emp set salary = salary+(salary*percent) where id = empid;
 select * from emp;
end//
delimiter ;
call increament_sal(103,0.1);

-- If salary is less than 80,000 then increment by 10%. If the salary is greater than 80,000 then increment by 20%. 

delimiter //
create or replace procedure calculate_bonus(in emp_id int,out bonus decimal(10,2))
begin
declare emp_salary decimal(10,2);
select salary into emp_salary from emp where id=emp_id;

if emp_salary>=80000 then 
   set bonus = 0.2;
else set bonus = 0.1;
end if;
end//
delimiter ;

call calculate_bonus(103,@bonus);
select @bonus;



-- stored procedure has multiple in and multiple out
-- we can use 
-- Why are stored procedures faster?
-- 1 precompiled execution plan 
-- 2 reduce network traffic
-- 3 login executes on database server

-- # handling exception with help of stored procedure
-- declare handler_action handler for condition_value handler_exception statement
-- handler_action => uses exit to stop execution of a block or continue to keep running
-- condition_value => it uses genaric classes like sqlexception is handler for all else,sqlwarning(this for warning),not found(no rows / end of cursor),signal(similar to throw in java it tell my sql  to stop execution and generate an error)
-- sql_state=> its 5 character error code 
-- mysql uses sql state to chatagories the error
-- 02000 => no data found
-- 23000 => constraints voilated
-- 42000 => syntax error
-- 45000 => user define exception

