use mydatabase;
/* ---- DATA DEFINITION LANGUAGE ---- */

/* CREATE*/
-- Q :: Create a new Table called persons with columns : id, persons_name, birth_date and phone
create table persons(
	id INT NOT NULL,
    person_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    phone VARCHAR(15) NOT NULL,
    CONSTRAINT pk_persons primary key(id)
);

-- Currently our persons table is empty 
select * from persons;


/* ALTER : change definition of table*/ 

-- Q :: Add a new column called email to the persons table 
alter table persons add email VARCHAR(50) NOT NULL;
select * from persons;

-- Q :: Remove the column phone from the persons table 
alter table persons drop column phone;
select * from persons;

/* DROP */ 
drop table persons;
select * from persons;












