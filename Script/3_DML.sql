/* --- DATA MANIPULATION ---- */
use mydatabase;

/*  INSERT */
-- Q :: Insert 1 new customers
insert into customers (id, first_name, country, score) values(6, 'Anna', 'USA', NULL);
select * from customers;
-- Q :: Insert 2 new customers
insert into customers(id, first_name, country, score) values(7, 'adey', 'Germany', 100),(8, 'asa', NULL, 90);
-- Q :: Insert 2 new customers without using column names
insert into customers values(9, 'adey', 'Germany', 100),(10, 'asa', NULL, 90);
-- Q :: Insert a new customer with id = 11 and first_name = 'sam', providing values for only these two columns
insert into customers values(11, 'sam'); -- !! ERROR
/* ERROR BECAUSE 
--if you don't specify the column names,
-- MySQL expects a value for every column in the table, in the defined order.
-- QUERY WRITTEN BELOW,The number of values does not match the number of columns.
*/
-- Correction :: TO solve this error by explicitly specifying the column names.
insert into customers(id, first_name) values(11, 'sam');
select * from customers;

-- Insert using Select 
-- Q :: Copy data from 'customers' table into 'persons'
CREATE TABLE persons(
    id INT NOT NULL PRIMARY KEY,
    person_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    phone VARCHAR(15) NOT NULL
);
insert into persons(id, person_name, birth_date, phone) select id, first_name, NULL, 'unknown' from customers;
select * from persons;


/* UPDATE  */
-- Q :: Change the score of customers with ID 6 to 0
update customers set score = 0 where id=6;
 
-- Q :: change the score of customer with ID 10 to 0 and update the country to 'UK
update customers set score=0, country='UK' where id=10;
-- Q :: Update all customers with a NULL score by setting their score to 0 
SET SQL_SAFE_UPDATES = 0;
update customers set score=0 where score is NULL; 
SET SQL_SAFE_UPDATES = 0;
select * from customers;

/* DELETE */
delete from customers where id>5;

-- delete all data from table persons
SET SQL_SAFE_UPDATES = 0;
delete from persons;
truncate table persons;  -- truncate delete all rows from table
SET SQL_SAFE_UPDATES = 1;
select * from persons;
