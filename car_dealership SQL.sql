--Week 4 Weekend Project
--Table creation

CREATE TABLE salesperson(
	salesperson_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50)
);

CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50)
);

ALTER TABLE customer
ADD credit_rating INTEGER


CREATE TABLE car(
	car_id SERIAL PRIMARY KEY,
	car_make VARCHAR(50),
	car_model VARCHAR(50),
	car_year INTEGER,
	car_cost NUMERIC(10,2),
	car_color VARCHAR(50),
	car_new BOOLEAN,
	salesperson_id INTEGER NOT NULL,
	customer_id INTEGER NOT NULL,
	FOREIGN KEY(salesperson_id) REFERENCES salesperson(salesperson_id),
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE invoice(
	invoice_id SERIAL PRIMARY KEY,
	invoice_date DATE,
	salesperson_id INTEGER,
	car_id INTEGER,
	customer_id INTEGER,
	FOREIGN KEY(salesperson_id) REFERENCES salesperson(salesperson_id),
	FOREIGN KEY(car_id) REFERENCES car(car_id),
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE mechanic(
	mechanic_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	cars_serviced INTEGER
);

CREATE TABLE car_mechanic(
	car_mechanic_id SERIAL PRIMARY KEY,
	car_id INTEGER NOT NULL,
	mechanic_id INTEGER NOT NULL,
	FOREIGN KEY(car_id) REFERENCES car(car_id),
	FOREIGN KEY(mechanic_id) REFERENCES mechanic(mechanic_id)
);

CREATE TABLE car_parts(
	part_id SERIAL PRIMARY KEY,
	part_cost NUMERIC(10,2),
	part_amount INTEGER,
	car_id INTEGER,
	FOREIGN KEY(car_id) REFERENCES car(car_id)
);
ALTER TABLE car_parts
ADD part_name VARCHAR(50)

CREATE TABLE service_record(
	ticket_id SERIAL PRIMARY KEY,
	ticket_cost NUMERIC(8,2),
	service_date DATE,
	part_id INTEGER,
	mechanic_id INTEGER,
	car_id INTEGER,
	customer_id INTEGER,
	FOREIGN KEY(part_id) REFERENCES car_parts(part_id),
	FOREIGN KEY(mechanic_id) REFERENCES mechanic(mechanic_id),
	FOREIGN KEY(car_id) REFERENCES car(car_id),
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

--Inserting Values
--Customer Table
CREATE OR REPLACE PROCEDURE customerinsert(
	f_name VARCHAR(50),
	l_name VARCHAR(50),
	c_rating INTEGER
)
LANGUAGE plpgsql
AS
$$
BEGIN
	INSERT INTO customer(first_name, last_name, credit_rating)
	VALUES(f_name, l_name,c_rating);
	
END;
$$

CALL customerinsert('Chien', 'Yu', 850);
CALL customerinsert('Ivan', 'Wong', 700);
CALL customerinsert('Shoha', 'Tsuchida', 800);
CALL customerinsert('Homer', 'Simpson', 400);
CALL customerinsert('Teddy', 'Roosevelt', 550);

DELETE FROM customer
WHERE customer_id = 6

--Salesperson table
CREATE OR REPLACE FUNCTION salespersoninsert(
	sale_id INTEGER,
	f_name VARCHAR(50),
	l_name VARCHAR(50)
)
RETURNS void
LANGUAGE plpgsql
AS
$MAIN$
BEGIN
	INSERT INTO salesperson(salesperson_id, first_name, last_name)
	VALUES(sale_id, f_name, l_name);
END;
$MAIN$



SELECT salespersoninsert(1, 'Jose', 'Quevedo');
SELECT salespersoninsert(2, 'Jaeger', 'Meister');
SELECT salespersoninsert(3, 'Don', 'Julio');

--Car table
CREATE OR REPLACE PROCEDURE carinsert(
	c_make VARCHAR(50),
	c_model VARCHAR(50),
	c_year INTEGER,
	c_cost NUMERIC(10,2),
	c_color VARCHAR(50),
	c_new BOOLEAN,
	s_id INTEGER,
	custom_id INTEGER
)
LANGUAGE plpgsql
AS
$$
BEGIN
	INSERT INTO car(car_make, car_model, car_year, car_cost, car_color, car_new, salesperson_id, customer_id)
	VALUES(c_make, c_model, c_year, c_cost, c_color, c_new, s_id, custom_id);
	
END;
$$

CALL carinsert('Tesla', 'Model 3', 2020, 52000, 'White', 'True', 1, 1);
CALL carinsert('Tesla', 'Model X', 2020, 70000, 'Red', 'True', 2, 1);
CALL carinsert('Tesla', 'Model Y', 2021, 12000, 'Blue', 'False', 3, 2);
CALL carinsert('Tesla', 'Model 3', 2020, 52000, 'Black', 'True', 2, 3);
CALL carinsert('Tesla', 'Model S', 2020, 85000, 'White', 'True', 1, 4);

--Invoice table
INSERT INTO invoice(
	invoice_date,
	salesperson_id,
	customer_id,
	car_id
) VALUES (
	'2020-08-25',
	1,
	1,
	1
),(
	'2020-08-25',
	2,
	1,
	2	
),(
	'2021-04-29',
	3,
	2,
	3
),(
	'2021-03-29',
	2,
	3,
	4
),(
	'2021-01-20',
	1,
	4,
	5
);
DELETE FROM invoice
WHERE invoice_id = 1

--Mechanic Table
INSERT INTO mechanic(
	mechanic_id,
	first_name,
	last_name,
	cars_serviced 
)Values(
	1,
	'Bob',
	'Builder',
	39
),(
	2,
	'Dom',
	'Torreto',
	70
);

--Insert into car_mechanic table
INSERT INTO car_mechanic(
	car_mechanic_id,
	car_id,
	mechanic_id
)VALUES(
	1,
	4,
	1
),(
	2,
	5,
	2
)

--Insert into car_parts table
INSERT INTO car_parts(
	part_id,
	part_cost,
	part_amount,
	part_name,
	car_id
)VALUES(
	1,
	800,
	4,
	'Michelin Tires',
	4
),(
	2,
	400,
	4,
	'Brake pad',
	4
),(
	3,
	550,
	1,
	'Compressor',
	5
)

--Insert into service_record table
INSERT INTO service_record(
	ticket_id,
	ticket_cost,
	service_date,
	part_id,
	mechanic_id,
	car_id,
	customer_id
)VALUES(
	1,
	800,
	'2020-05-29',
	1,
	1,
	4,
	3
),(
	2,
	400,
	'2020-06-11',
	2,
	1,
	4,
	3
),(
	3,
	550,
	'2020-05-13',
	3,
	2,
	5,
	4
);


	
