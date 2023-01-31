-- ------------------------------------------------------------------
-- 0). First, How Many Rows are in the Products Table?
-- ------------------------------------------------------------------
SELECT COUNT(*) AS Num_Rows FROM northwind.products;
-- ------------------------------------------------------------------
-- 1). Product Name and Unit/Quantity
-- ------------------------------------------------------------------
SELECT product_name
, quantity_per_unit 
FROM northwind.products;
-- ------------------------------------------------------------------
-- 2). Product ID and Name of Current Products
-- ------------------------------------------------------------------
SELECT id AS p_ID,
 product_name AS p_name, 
 discontinued as p_current
 FROM northwind.products
 WHERE discontinued!=1;
-- ------------------------------------------------------------------
-- 3). Product ID and Name of Discontinued Products
-- ------------------------------------------------------------------
SELECT id AS p_id,
discontinued as p_disc 
FROM northwind.products 
WHERE discontinued=1;
-- ------------------------------------------------------------------
-- 4). Name & List Price of Most & Least Expensive Products
-- ------------------------------------------------------------------
SELECT product_name AS p_id
,list_price AS p_price
FROM northwind.products
WHERE list_price = (SELECT MAX(list_price) FROM northwind.products)
OR list_price = (SELECT MIN(list_price) FROM northwind.products);
-- ------------------------------------------------------------------
-- 5). Product ID, Name & List Price Costing Less Than $20
-- ------------------------------------------------------------------
SELECT id AS p_id
, product_name AS p_name
, list_price AS p_price
FROM northwind.products 
WHERE list_price < 20.00
ORDER BY list_price DESC;
-- ------------------------------------------------------------------
-- 6). Product ID, Name & List Price Costing Between $15 and $20
-- ------------------------------------------------------------------
SELECT id AS p_id
, product_name AS p_name
, list_price AS p_price 
FROM northwind.products
WHERE list_price <= 20.00 AND list_price >= 15.00
ORDER BY list_price DESC;
-- ------------------------------------------------------------------
-- 7). Product Name & List Price Costing Above Average List Price
-- ------------------------------------------------------------------
SELECT product_name AS p_name
, list_price AS p_price
FROM northwind.products 
WHERE list_price > (SELECT AVG(list_price) FROM northwind.products);
-- ------------------------------------------------------------------
-- 8). Product Name & List Price of 10 Most Expensive Products 
-- ------------------------------------------------------------------
SELECT product_name AS p_name
, list_price AS p_price
FROM northwind.products
ORDER BY list_price DESC 
LIMIT 10;
-- ------------------------------------------------------------------ 
-- 9). Count of Current and Discontinued Products 
-- ------------------------------------------------------------------
SELECT COUNT(CASE WHEN discontinued = '1' THEN 1
ELSE NULL
END) AS p_Discontinued
,COUNT(CASE WHEN discontinued = '0' THEN 1
ELSE NULL
END) AS p_Current
,COUNT(*) AS p_ALL
FROM northwind.products;
-- ------------------------------------------------------------------
-- 10). Product Name, Units on Order and Units in Stock
--      Where Quantity In-Stock is Less Than the Quantity On-Order. 
-- ------------------------------------------------------------------
SELECT products.id
,products.product_name
,SUM(inventory_transactions.quantity) AS p_Stock
,SUM(purchase_order_details.quantity) AS p_On_Order
FROM northwind.products
LEFT JOIN inventory_transactions ON products.id=inventory_transactions.id
LEFT JOIN purchase_order_details ON products.id=purchase_order_details.purchase_order_id
WHERE inventory_transactions.quantity < purchase_order_details.quantity
Group BY id;

-- ------------------------------------------------------------------
-- EXTRA CREDIT -----------------------------------------------------
-- ------------------------------------------------------------------
-- ------------------------------------------------------------------
-- 11). Products with Supplier Company & Address Info
-- ------------------------------------------------------------------
SELECT products.product_name
, suppliers.company
, suppliers.address
FROM northwind.products
LEFT JOIN suppliers ON suppliers.id=products.supplier_ids;
-- ------------------------------------------------------------------
-- 12). Number of Products per Category With Less Than 5 Units
-- ------------------------------------------------------------------
SELECT products.id
,products.product_name
,products.category AS category
,SUM(inventory_transactions.quantity)
FROM northwind.products
LEFT JOIN inventory_transactions ON inventory_transactions.id=products.id
WHERE inventory_transactions.quantity < 5
GROUP BY id;
-- ------------------------------------------------------------------
-- 13). Number of Products per Category Priced Less Than $20.00
-- ------------------------------------------------------------------
SELECT products.id
,products.product_name
,products.category
,SUM(inventory_transactions.quantity)
,products.list_price AS price
FROM northwind.products
LEFT JOIN inventory_transactions ON inventory_transactions.id=products.id
WHERE products.list_price < 20.00
GROUP BY id;

SELECT * FROM order_details;