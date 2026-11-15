use mydatabase;

/* Comparision Operators */
select * from customers WHERE country = 'Germany';
select * from customers WHERE country != 'India';
select * from customers WHERE score > 300;
select * from customers WHERE score < 300;	
select * from customers WHERE score >= 400;
select * from customers WHERE score <= 250;

/* Logical Operator */
-- ------ AND OPERATOR
-- Q :: Retrieve all customers who are from USA andhave a score greater than 500
SELECT * FROM customers WHERE country = 'USA' AND score > 500;
-- ------ OR OPERATOR
-- Q :: Retrieve all customers who are either from USA pr have a score greater than 500
SELECT * FROM customers WHERE country = 'USA' OR score>=500;

-- ------ NOT OPERATOR 
SELECT * FROM customers WHERE NOT country = 'India';
-- Q :: Retrieve all customers with a score not less than 500
select * from customers where NOT score < 500;     -- we can also use :: where score >= 500


/* Range Operator */
-- ------  BETWEEN
-- Q :: Retrieve all customers whose scores falls in range between 200 and 400
SELECT * FROM customers WHERE score BETWEEN 200 AND 400;    -- we can also use :: where score>=200 AND score<=400

/* Membership Operators */
-- ------ IN
-- Q :: Retrieve all customers from germany or USA 
SELECT * FROM customers WHERE country IN ('USA', 'Germany');

-- ------ NOT IN
-- Opposite of IN


-- ------ LIKE
-- Q :: find all customers whose first_name starts with m or M
SELECT * FROM customers WHERE first_name LIKE 'm%';
-- Q :: find all customers whose first_name contians a or A
SELECT * FROM customers WHERE first_name LIKE '%A%';
-- Q :: find all customers whose first_name has 'r' in third position
SELECT * FROM customers WHERE first_name LIKE '__r%';








