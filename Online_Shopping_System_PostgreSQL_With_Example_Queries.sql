-- =====================================================
-- ONLINE SHOPPING SYSTEM - PostgreSQL Compatible
-- Complete SQL + Example Queries
-- =====================================================

DROP TABLE IF EXISTS review CASCADE;
DROP TABLE IF EXISTS shipping CASCADE;
DROP TABLE IF EXISTS payment CASCADE;
DROP TABLE IF EXISTS order_item CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS product CASCADE;
DROP TABLE IF EXISTS customer CASCADE;
DROP TABLE IF EXISTS category CASCADE;

-- =====================================================
-- 1. CATEGORY TABLE
-- =====================================================
CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255)
);

-- =====================================================
-- 2. CUSTOMER TABLE
-- =====================================================
CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE,
    password VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    city VARCHAR(100),
    pincode VARCHAR(10)
);

-- =====================================================
-- 3. PRODUCT TABLE
-- =====================================================
CREATE TABLE product (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description VARCHAR(255),
    price DECIMAL(10, 2) NOT NULL,
    stock_qty INT NOT NULL,
    category_id INT NOT NULL,
    sku VARCHAR(50) UNIQUE NOT NULL,
    FOREIGN KEY (category_id) REFERENCES category (category_id)
);

-- =====================================================
-- 4. ORDERS TABLE
-- =====================================================
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(30) NOT NULL,
    customer_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer (customer_id)
);

-- =====================================================
-- 5. ORDER_ITEM TABLE
-- =====================================================
CREATE TABLE order_item (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders (order_id),
    FOREIGN KEY (product_id) REFERENCES product (product_id)
);

-- =====================================================
-- 6. PAYMENT TABLE
-- =====================================================
CREATE TABLE payment (
    payment_id SERIAL PRIMARY KEY,
    order_id INT UNIQUE NOT NULL,
    payment_mode VARCHAR(30) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    pay_date DATE NOT NULL,
    status VARCHAR(30) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders (order_id)
);

-- =====================================================
-- 7. SHIPPING TABLE
-- =====================================================
CREATE TABLE shipping (
    shipping_id SERIAL PRIMARY KEY,
    order_id INT UNIQUE NOT NULL,
    address VARCHAR(255) NOT NULL,
    courier VARCHAR(100),
    tracking_no VARCHAR(100) UNIQUE,
    delivery_date DATE,
    FOREIGN KEY (order_id) REFERENCES orders (order_id)
);

-- =====================================================
-- 8. REVIEW TABLE
-- =====================================================
CREATE TABLE review (
    review_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT NOT NULL,
    comment VARCHAR(500),
    review_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
    FOREIGN KEY (product_id) REFERENCES product (product_id)
);

-- =====================================================
-- DATA INSERTS
-- =====================================================

INSERT INTO category (category_name, description) VALUES 
('Electronics', 'Electronic devices and accessories'),
('Clothing', 'Men and women clothing'),
('Books', 'Educational and general books'),
('Home Appliances', 'Home and kitchen appliances');

INSERT INTO customer (name, email, phone, password, address, city, pincode) VALUES 
('Rahul Kumar', 'rahul@gmail.com', '9876543210', 'rahul123', 'MG Road', 'Vijayawada', '520010'),
('Priya Sharma', 'priya@gmail.com', '9876543211', 'priya123', 'Main Road', 'Rajahmundry', '533101'),
('Arjun Reddy', 'arjun@gmail.com', '9876543212', 'arjun123', 'Market Street', 'Kakinada', '533001'),
('Sneha Rao', 'sneha@gmail.com', '9876543213', 'sneha123', 'College Road', 'Visakhapatnam', '530001'),
('Kiran Kumar', 'kiran@gmail.com', '9876543214', 'kiran123', 'Station Road', 'Guntur', '522001');

INSERT INTO product (name, description, price, stock_qty, category_id, sku) VALUES 
('Wireless Mouse', '2.4GHz wireless optical mouse', 599.00, 50, 1, 'ELEC001'),
('Bluetooth Headphones', 'Wireless over-ear headphones', 1499.00, 30, 1, 'ELEC002'),
('Mechanical Keyboard', 'RGB mechanical gaming keyboard', 2499.00, 20, 1, 'ELEC003'),
('Cotton T-Shirt', 'Comfortable cotton round-neck T-shirt', 499.00, 100, 2, 'CLOT001'),
('Jeans', 'Regular fit denim jeans', 1199.00, 60, 2, 'CLOT002'),
('Python Programming', 'Beginner to advanced Python book', 799.00, 40, 3, 'BOOK001'),
('DBMS Fundamentals', 'Database management systems textbook', 899.00, 35, 3, 'BOOK002'),
('Electric Kettle', '1.5 litre stainless steel kettle', 1299.00, 25, 4, 'HOME001');

INSERT INTO orders (order_date, total_amount, status, customer_id) VALUES 
('2026-09-20', 2098.00, 'Delivered', 1),
('2026-09-21', 2499.00, 'Shipped', 2),
('2026-09-22', 1298.00, 'Pending', 3),
('2026-09-23', 1998.00, 'Delivered', 4),
('2026-09-24', 799.00, 'Processing', 5);

INSERT INTO order_item (order_id, product_id, quantity, unit_price) VALUES 
(1, 1, 1, 599.00),
(1, 2, 1, 1499.00),
(2, 3, 1, 2499.00),
(3, 4, 1, 499.00),
(3, 5, 1, 799.00),
(4, 5, 1, 1199.00),
(4, 8, 1, 799.00),
(5, 6, 1, 799.00);

INSERT INTO payment (order_id, payment_mode, amount, pay_date, status) VALUES 
(1, 'UPI', 2098.00, '2026-09-20', 'Paid'),
(2, 'Card', 2499.00, '2026-09-21', 'Paid'),
(3, 'Cash on Delivery', 1298.00, '2026-09-22', 'Pending'),
(4, 'UPI', 1998.00, '2026-09-23', 'Paid'),
(5, 'Card', 799.00, '2026-09-24', 'Paid');

INSERT INTO shipping (order_id, address, courier, tracking_no, delivery_date) VALUES 
(1, 'MG Road, Vijayawada - 520010', 'BlueDart', 'BD10001', '2026-09-23'),
(2, 'Main Road, Rajahmundry - 533101', 'DTDC', 'DT10002', NULL),
(3, 'Market Street, Kakinada - 533001', 'Delhivery', 'DL10003', NULL),
(4, 'College Road, Visakhapatnam - 530001', 'BlueDart', 'BD10004', '2026-09-26'),
(5, 'Station Road, Guntur - 522001', 'DTDC', 'DT10005', NULL);

INSERT INTO review (customer_id, product_id, rating, comment, review_date) VALUES 
(1, 1, 5, 'Very good mouse and smooth performance.', '2026-09-24'),
(2, 3, 4, 'Keyboard quality is good.', '2026-09-25'),
(3, 4, 5, 'Comfortable T-shirt.', '2026-09-25'),
(4, 5, 4, 'Good quality jeans.', '2026-09-27'),
(5, 6, 5, 'Useful Python book for beginners.', '2026-09-27');


-- =====================================================
-- EXAMPLE QUERIES
-- =====================================================

-- -----------------------------------------------------
-- A. BASIC SELECT QUERIES
-- -----------------------------------------------------

-- Query 1: Display all categories
SELECT * FROM category;

-- Query 2: Display all customers
SELECT * FROM customer;

-- Query 3: Display all products
SELECT * FROM product;

-- Query 4: Display all orders
SELECT * FROM orders;

-- Query 5: Display only product names and prices
SELECT name, price FROM product;


-- -----------------------------------------------------
-- B. WHERE / FILTERING QUERIES
-- -----------------------------------------------------

-- Query 6: Products costing more than 1000
SELECT name, price
FROM product
WHERE price > 1000;

-- Query 7: Products costing between 500 and 1500
SELECT name, price
FROM product
WHERE price BETWEEN 500 AND 1500;

-- Query 8: Customers from Vijayawada
SELECT *
FROM customer
WHERE city = 'Vijayawada';

-- Query 9: Orders with Delivered status
SELECT *
FROM orders
WHERE status = 'Delivered';

-- Query 10: Products with stock less than 40
SELECT name, stock_qty
FROM product
WHERE stock_qty < 40;


-- -----------------------------------------------------
-- C. ORDER BY / SORTING
-- -----------------------------------------------------

-- Query 11: Products from highest price to lowest
SELECT name, price
FROM product
ORDER BY price DESC;

-- Query 12: Products from lowest price to highest
SELECT name, price
FROM product
ORDER BY price ASC;

-- Query 13: Customers sorted alphabetically
SELECT name, city
FROM customer
ORDER BY name ASC;


-- -----------------------------------------------------
-- D. DISTINCT / LIKE / IN
-- -----------------------------------------------------

-- Query 14: Display unique cities
SELECT DISTINCT city
FROM customer;

-- Query 15: Products containing the word 'Python'
SELECT *
FROM product
WHERE name ILIKE '%Python%';

-- Query 16: Customers from selected cities
SELECT name, city
FROM customer
WHERE city IN ('Vijayawada', 'Kakinada', 'Guntur');

-- Query 17: Orders with selected statuses
SELECT *
FROM orders
WHERE status IN ('Delivered', 'Shipped');


-- -----------------------------------------------------
-- E. AGGREGATE FUNCTIONS
-- -----------------------------------------------------

-- Query 18: Count total customers
SELECT COUNT(*) AS total_customers
FROM customer;

-- Query 19: Count total products
SELECT COUNT(*) AS total_products
FROM product;

-- Query 20: Find maximum product price
SELECT MAX(price) AS highest_price
FROM product;

-- Query 21: Find minimum product price
SELECT MIN(price) AS lowest_price
FROM product;

-- Query 22: Find average product price
SELECT ROUND(AVG(price), 2) AS average_price
FROM product;

-- Query 23: Find total stock quantity
SELECT SUM(stock_qty) AS total_stock
FROM product;

-- Query 24: Find total order amount
SELECT SUM(total_amount) AS total_sales
FROM orders;


-- -----------------------------------------------------
-- F. GROUP BY / HAVING
-- -----------------------------------------------------

-- Query 25: Number of products in each category
SELECT c.category_name, COUNT(p.product_id) AS product_count
FROM category c
LEFT JOIN product p ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
ORDER BY c.category_id;

-- Query 26: Average product price in each category
SELECT c.category_name, ROUND(AVG(p.price), 2) AS average_price
FROM category c
JOIN product p ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name;

-- Query 27: Total orders by status
SELECT status, COUNT(*) AS order_count
FROM orders
GROUP BY status;

-- Query 28: Payment amount by payment mode
SELECT payment_mode, SUM(amount) AS total_amount
FROM payment
GROUP BY payment_mode;

-- Query 29: Categories having more than 1 product
SELECT c.category_name, COUNT(p.product_id) AS product_count
FROM category c
JOIN product p ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
HAVING COUNT(p.product_id) > 1;


-- -----------------------------------------------------
-- G. INNER JOIN QUERIES
-- -----------------------------------------------------

-- Query 30: Display products with their category names
SELECT p.product_id, p.name AS product_name,
       c.category_name, p.price
FROM product p
INNER JOIN category c
ON p.category_id = c.category_id;

-- Query 31: Display orders with customer names
SELECT o.order_id, o.order_date, o.total_amount,
       o.status, c.name AS customer_name
FROM orders o
INNER JOIN customer c
ON o.customer_id = c.customer_id;

-- Query 32: Display order details with product names
SELECT oi.order_id, p.name AS product_name,
       oi.quantity, oi.unit_price
FROM order_item oi
INNER JOIN product p
ON oi.product_id = p.product_id;

-- Query 33: Display customer, order and payment information
SELECT c.name AS customer_name,
       o.order_id,
       o.total_amount,
       p.payment_mode,
       p.status AS payment_status
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payment p ON o.order_id = p.order_id;


-- -----------------------------------------------------
-- H. MULTI-TABLE JOIN QUERIES
-- -----------------------------------------------------

-- Query 34: Complete order details
SELECT o.order_id,
       c.name AS customer_name,
       p.name AS product_name,
       oi.quantity,
       oi.unit_price,
       o.status
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id
JOIN order_item oi ON o.order_id = oi.order_id
JOIN product p ON oi.product_id = p.product_id
ORDER BY o.order_id;

-- Query 35: Product review details
SELECT p.name AS product_name,
       c.name AS customer_name,
       r.rating,
       r.comment,
       r.review_date
FROM review r
JOIN product p ON r.product_id = p.product_id
JOIN customer c ON r.customer_id = c.customer_id
ORDER BY r.review_date;

-- Query 36: Shipping details with customer names
SELECT o.order_id,
       c.name AS customer_name,
       s.courier,
       s.tracking_no,
       s.delivery_date
FROM shipping s
JOIN orders o ON s.order_id = o.order_id
JOIN customer c ON o.customer_id = c.customer_id;


-- -----------------------------------------------------
-- I. LEFT JOIN QUERIES
-- -----------------------------------------------------

-- Query 37: Show all categories, including categories
-- that have no products
SELECT c.category_name, p.name AS product_name
FROM category c
LEFT JOIN product p
ON c.category_id = p.category_id
ORDER BY c.category_id;

-- Query 38: Show all customers and their orders
SELECT c.name AS customer_name,
       o.order_id,
       o.total_amount,
       o.status
FROM customer c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
ORDER BY c.customer_id;


-- -----------------------------------------------------
-- J. SUBQUERIES
-- -----------------------------------------------------

-- Query 39: Products more expensive than the average price
SELECT name, price
FROM product
WHERE price > (
    SELECT AVG(price)
    FROM product
);

-- Query 40: Customer(s) with the highest order amount
SELECT c.name, o.order_id, o.total_amount
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.total_amount = (
    SELECT MAX(total_amount)
    FROM orders
);

-- Query 41: Products that have received a 5-star review
SELECT name
FROM product
WHERE product_id IN (
    SELECT product_id
    FROM review
    WHERE rating = 5
);


-- -----------------------------------------------------
-- K. CASE STATEMENT
-- -----------------------------------------------------

-- Query 42: Classify products according to price
SELECT name, price,
       CASE
           WHEN price < 700 THEN 'Low Price'
           WHEN price BETWEEN 700 AND 1500 THEN 'Medium Price'
           ELSE 'High Price'
       END AS price_category
FROM product
ORDER BY price;


-- -----------------------------------------------------
-- L. DATE QUERIES
-- -----------------------------------------------------

-- Query 43: Orders placed after 2026-09-21
SELECT *
FROM orders
WHERE order_date > '2026-09-21';

-- Query 44: Reviews submitted in September 2026
SELECT *
FROM review
WHERE review_date BETWEEN '2026-09-01' AND '2026-09-30';

-- Query 45: Orders sorted by latest date
SELECT *
FROM orders
ORDER BY order_date DESC;


-- -----------------------------------------------------
-- M. UPDATE QUERIES
-- -----------------------------------------------------

-- Query 46: Increase Wireless Mouse stock by 10
UPDATE product
SET stock_qty = stock_qty + 10
WHERE product_id = 1;

-- Query 47: Change order 3 status to Shipped
UPDATE orders
SET status = 'Shipped'
WHERE order_id = 3;

-- IMPORTANT:
-- If you are only demonstrating UPDATE in class,
-- execute SELECT after it to verify the change.


-- -----------------------------------------------------
-- N. DELETE QUERY
-- -----------------------------------------------------

-- Query 48: Delete a review by review ID
-- This is an example only. It permanently removes the row.
-- DELETE FROM review
-- WHERE review_id = 5;


-- -----------------------------------------------------
-- O. VIEW
-- -----------------------------------------------------

-- Query 49: Create a view for product-category information
CREATE OR REPLACE VIEW product_category_view AS
SELECT p.product_id,
       p.name AS product_name,
       c.category_name,
       p.price,
       p.stock_qty
FROM product p
JOIN category c
ON p.category_id = c.category_id;

-- Execute the view
SELECT * FROM product_category_view;


-- -----------------------------------------------------
-- P. ORDER REPORT VIEW
-- -----------------------------------------------------

-- Query 50: Create a customer order report
CREATE OR REPLACE VIEW customer_order_report AS
SELECT o.order_id,
       o.order_date,
       c.name AS customer_name,
       c.city,
       o.total_amount,
       o.status
FROM orders o
JOIN customer c
ON o.customer_id = c.customer_id;

-- Execute the report
SELECT *
FROM customer_order_report
ORDER BY order_id;


-- -----------------------------------------------------
-- Q. USEFUL PROJECT REPORT QUERIES
-- -----------------------------------------------------

-- Query 51: Top 3 most expensive products
SELECT name, price
FROM product
ORDER BY price DESC
LIMIT 3;

-- Query 52: Top-rated products
SELECT p.name,
       AVG(r.rating) AS average_rating
FROM product p
JOIN review r ON p.product_id = r.product_id
GROUP BY p.product_id, p.name
ORDER BY average_rating DESC;

-- Query 53: Products that are low in stock
SELECT name, stock_qty
FROM product
WHERE stock_qty <= 30
ORDER BY stock_qty ASC;

-- Query 54: Pending payments
SELECT o.order_id,
       c.name AS customer_name,
       p.amount,
       p.payment_mode,
       p.status
FROM payment p
JOIN orders o ON p.order_id = o.order_id
JOIN customer c ON o.customer_id = c.customer_id
WHERE p.status = 'Pending';

-- Query 55: Undelivered shipments
SELECT s.shipping_id,
       o.order_id,
       c.name AS customer_name,
       s.courier,
       s.tracking_no
FROM shipping s
JOIN orders o ON s.order_id = o.order_id
JOIN customer c ON o.customer_id = c.customer_id
WHERE s.delivery_date IS NULL;

-- Query 56: Total spending by each customer
SELECT c.customer_id,
       c.name,
       COALESCE(SUM(o.total_amount), 0) AS total_spending
FROM customer c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spending DESC;

-- Query 57: Number of orders placed by each customer
SELECT c.name,
       COUNT(o.order_id) AS number_of_orders
FROM customer c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY number_of_orders DESC;

-- Query 58: Products that have never been reviewed
SELECT p.product_id, p.name
FROM product p
LEFT JOIN review r
ON p.product_id = r.product_id
WHERE r.review_id IS NULL;

-- Query 59: Products purchased in orders
SELECT DISTINCT p.product_id, p.name
FROM product p
JOIN order_item oi
ON p.product_id = oi.product_id
ORDER BY p.product_id;

-- Query 60: Complete shopping summary
SELECT
    o.order_id,
    c.name AS customer_name,
    o.order_date,
    o.total_amount,
    o.status AS order_status,
    pay.payment_mode,
    pay.status AS payment_status,
    s.courier,
    s.tracking_no,
    s.delivery_date
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id
LEFT JOIN payment pay ON o.order_id = pay.order_id
LEFT JOIN shipping s ON o.order_id = s.order_id
ORDER BY o.order_id;


-- =====================================================
-- END OF ONLINE SHOPPING SYSTEM SQL PROJECT
-- =====================================================
