
-- Populates the tables from 2a with data from the original northwind database. 
-- --------------------------------------------------------------------------------------------------------------
-- TODO: Extract the appropriate data from the northwind database, and INSERT it into the Northwind_DW database.
-- -----------------------------------------------------------------------------------------------------------
-- ----------------------------------------------
-- Populate dim_customers
-- ----------------------------------------------
INSERT INTO `northwind_dw`.`dim_customers`
(`customer_key`,
`company`,
`last_name`,
`first_name`,
`job_title`,
`business_phone`,
`fax_number`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`)
SELECT `id`,
`company`,
`last_name`,
`first_name`,
`job_title`,
`business_phone`,
`fax_number`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`
FROM northwind.customers;

-- ----------------------------------------------
-- Validate that the Data was Inserted ----------
-- ----------------------------------------------
SELECT * FROM `northwind_dw`.dim_customers;


-- ----------------------------------------------
-- Populate dim_employees
-- ----------------------------------------------
INSERT INTO `northwind_dw`.`dim_employees`
(`employee_key`,
`company`,
`last_name`,
`first_name`,
`email_address`,
`job_title`,
`business_phone`,
`home_phone`,
`fax_number`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`,
`web_page`)
SELECT `employees`.`id`,
    `employees`.`company`,
    `employees`.`last_name`,
    `employees`.`first_name`,
    `employees`.`email_address`,
    `employees`.`job_title`,
    `employees`.`business_phone`,
    `employees`.`home_phone`,
    `employees`.`fax_number`,
    `employees`.`address`,
    `employees`.`city`,
    `employees`.`state_province`,
    `employees`.`zip_postal_code`,
    `employees`.`country_region`,
    `employees`.`web_page`
FROM `northwind`.`employees`;

-- ----------------------------------------------
-- Validate that the Data was Inserted ----------
-- ----------------------------------------------
SELECT * FROM `northwind_dw`.dim_employees;


SELECT * FROM northwind.products;
-- ----------------------------------------------
-- Populate dim_products
-- ----------------------------------------------
INSERT INTO `northwind`.`dim_products`
(`product_key`,
`product_code`,
`product_name`,
`standard_cost`,
`list_price`,
`reorder_level`,
`target_level`,
`quantity_per_unit`,
`discontinued`,
`minimum_reorder_quantity`,
`category`)
SELECT `id`,
`product_code`,
`product_name`,
`standard_cost`,
`list_price`,
`reorder_level`,
`target_level`,
`quantity_per_unit`,
`discontinued`,
`minimum_reorder_quantity`,
`category`
FROM northwind.products;
# TODO: Write a SELECT Statement to Populate the table;

-- ----------------------------------------------
-- Validate that the Data was Inserted ----------
-- ----------------------------------------------
SELECT * FROM `northwind_dw`.dim_products;

-- ----------------------------------------------
-- Populate dim_shippers
-- ----------------------------------------------
INSERT INTO `northwind_dw`.`dim_shippers`
(`shipper_key`,
`company`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`)
SELECT
`id`,
`company`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`
FROM northwind.shippers;
# TODO: Write a SELECT Statement to Populate the table;

-- ----------------------------------------------
-- Validate that the Data was Inserted ----------
-- ----------------------------------------------
SELECT * FROM `northwind_dw`.dim_shippers;
-- ----------------------------------------------
-- Populate fact_orders
-- ----------------------------------------------
INSERT INTO `northwind_dw`.`fact_orders`
( `order_key`,
  `order_status_id`,
  `order_details_id`,
  `product_id` ,
  `inventory_id` ,
  `purchase_order_id` ,
  `shipper_id` ,
  `order_status_name`,
  `order_details_status_name`,
  `quantity` ,
  `unit_price` ,
  `discount` ,
  `order_date`,
  `shipped_date`,
  `ship_name`,
  `ship_address`,
  `ship_city`,
  `ship_state_province`,
  `ship_zip_postal_code`,
  `ship_country_region`,
  `shipping_fee` ,
  `taxes`,
  `payment_type`,
  `paid_date`,
  `tax_rate` )
SELECT 
  o.`id`,
  os.`id`,
  od.`status_id`,
  od.`product_id` ,
  od.`inventory_id` ,
  od.`purchase_order_id` ,
  o.`shipper_id` ,
  os.`status_name`,
  ods.`status_name`,
  od.`quantity` ,
  od.`unit_price` ,
  od.`discount` ,
  o.`order_date`,
  o.`shipped_date`,
  o.`ship_name`,
  o.`ship_address`,
  o.`ship_city`,
  o.`ship_state_province`,
  o.`ship_zip_postal_code`,
  o.`ship_country_region`,
  o.`shipping_fee` ,
  o.`taxes`,
  o.`payment_type`,
  o.`paid_date`,
  o.`tax_rate`
  FROM northwind.orders AS o
  LEFT JOIN northwind.orders_status AS os
  ON o.status_id=os.id
  LEFT JOIN northwind.order_details as od
  ON o.id=od.order_id
  LEFT JOIN northwind.order_details_status as ods
  ON od.status_id=ods.id;
  
/* 
--------------------------------------------------------------------------------------------------
TODO: Write a SELECT Statement that:
- JOINS the northwind.orders table with the northwind.orders_status table
- JOINS the northwind.orders with the northwind.order_details table.
--  (TIP: Remember that there is a one-to-many relationship between orders and order_details).
- JOINS the northwind.order_details table with the northwind.order_details_status table.
--------------------------------------------------------------------------------------------------
- The column list I've included in the INSERT INTO clause above should be your guide to which 
- columns you're required to extract from each of the four tables. Pay close attention!
--------------------------------------------------------------------------------------------------
*/



-- ----------------------------------------------
-- Validate that the Data was Inserted ----------
-- ----------------------------------------------
SELECT * FROM `northwind_dw`.fact_orders;