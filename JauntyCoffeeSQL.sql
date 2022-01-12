/* Create Employee table */
CREATE TABLE EMPLOYEE
(
  employee_id INTEGER PRIMARY KEY,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  hire_date DATE,
  job_title VARCHAR(30)
);

/* Create Coffee Shop table */
CREATE TABLE COFFEE_SHOP
(
  shop_id INTEGER PRIMARY KEY,
  shop_name VARCHAR(50),
  city VARCHAR(50),
  state CHAR(2)
);

/* Create Coffee table */
CREATE TABLE COFFEE
(
  coffee_id INTEGER PRIMARY KEY,
  coffee_name VARCHAR(30),
  price_per_pound NUMERIC(5,2)
);

/* Create Supplier table */
CREATE TABLE SUPPLIER
(
  supplier_id INTEGER PRIMARY KEY,
  company_name VARCHAR(50),
  country VARCHAR(30),
  sales_contact_name VARCHAR(60),
  email VARCHAR(50) NOT NULL
);

/* Add shop_id FK */
ALTER TABLE EMPLOYEE
  ADD shop_id INTEGER,
  ADD FOREIGN KEY(shop_id) REFERENCES COFFEE_SHOP(shop_id);

/* Add shop_id and supplier_id FKs */
ALTER TABLE COFFEE
  ADD shop_id INTEGER,
  ADD supplier_id INTEGER,
  ADD FOREIGN KEY(shop_id) REFERENCES COFFEE_SHOP(shop_id),
  ADD FOREIGN KEY(supplier_id) REFERENCES SUPPLIER(supplier_id);
  
/* Insert example data for employee table */
INSERT INTO EMPLOYEE(employee_id, first_name, last_name, hire_date, job_title)
VALUES(1, "Claude", "Jeffers", "2020-01-15", "Shift Leader"),
(2, "Jenny", "Craig", "2020-10-02", "Marketing Lead"),
(3, "Pat", "Patterson", "2021-02-20", "IT Lead");

/* Insert example data for Coffee Shop table */
INSERT INTO COFFEE_SHOP(shop_id, shop_name, city, state)
VALUES(1, "Jaunty Old Town Coffee", "San Tiburon", 'TX'),
(2, "Jaunty West Heights Coffee", "New Coventry", 'NJ'),
(3, "Jaunty Midcoast Coffee", "Vicuapa Nueva", 'CA');

/* Insert example data for Coffee table */
INSERT INTO COFFEE(coffee_id, coffee_name, price_per_pound)
VALUES(1, "Darkest Night", 15.25),
(2, "Funnest Blonde", 14.99),
(3, "Hazelnut Gogo", 16.42);

/* Insert example data for Supplier table */
INSERT INTO SUPPLIER(supplier_id, company_name, country, sales_contact_name, email)
VALUES(1, "Coffee Barons Inc.", "Argentina", "Fernando Jimenez", "fjimen@cbi.com.ar"),
(2, "Tastee Coffee", "Indonesia", "Buana Suharto", "buanasales@tasteecoffeeintl.com"),
(3, "Big Coffee Importer", "United States", "Chim Richalds", "crichalds@bigcoffee.biz");

/* Set shop_id for each employee */
UPDATE EMPLOYEE
SET shop_id = 1 WHERE employee_id = 1;
UPDATE EMPLOYEE
SET shop_id = 2 WHERE employee_id = 2;
UPDATE EMPLOYEE
SET shop_id = 3 WHERE employee_id = 3;

/* Set shop and supplier id for each coffee */
UPDATE COFFEE
SET shop_id = 1, supplier_id = 1 WHERE coffee_id = 3;
UPDATE COFFEE
SET shop_id = 2, supplier_id = 2 WHERE coffee_id = 1;
UPDATE COFFEE
SET shop_id = 3, supplier_id = 3 WHERE coffee_id = 2;

/* Create view to concatenate employee names */
CREATE VIEW concat_names AS
SELECT CONCAT(first_name, ' ', last_name) AS employee_full_name, employee_id, hire_date, job_title, shop_id
FROM EMPLOYEE
WHERE first_name IS NOT NULL AND last_name IS NOT NULL;

/* Create an index on the coffee_name field */
CREATE INDEX coffee_index
ON COFFEE (coffee_name);

/* Create a SFW query for Coffee Shop table */
SELECT * FROM COFFEE_SHOP
WHERE state = 'CA'

/* Create a query to join three tables and include all attributes */
/*
SELECT * FROM EMPLOYEE
JOIN COFFEE_SHOP
ON EMPLOYEE.shop_id = COFFEE_SHOP.shop_id
JOIN COFFEE
ON COFFEE_SHOP.shop_id = COFFEE.shop_id
*/