-- Create the ecommerce database
CREATE DATABASE ecommerce;

-- use the ecommerce database
USE ecommerce;

-- Create the customers table
CREATE TABLE customers (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL UNIQUE,
address TEXT
);


-- Create the orders table
CREATE TABLE orders (
id INT PRIMARY KEY AUTO_INCREMENT,
customer_id INT NOT NULL,
order_date DATE NOT NULL,
-- total_amount DECIMAL(10,2) NOT NULL,
FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- Create the products table
CREATE TABLE products (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(255) NOT NULL,
price DECIMAL(10,2) NOT NULL,
description TEXT
);

-- Insert Sample data into Customers table
INSERT INTO customers (name, email, address)
VALUES ("Ganishwar Arun", "ganishwararun@gmail.com", "West Mambalam Chennai"),
("Arun Kumar", "arunstrength@gmail.com", "MaraiMalaiNagar"),
("Appu Papa", "ganishwarips@gmail.com", "T.NAGAR Chennai");


-- Insert sample data into orders table
INSERT INTO orders (customer_id, order_date,  total_amount)
VALUES (1, CURDATE() - INTERVAL 10 DAY, 100.50),
(2, CURDATE(), 75.25),
(1, CURDATE() - INTERVAL 25 DAY, 98.00);
     

-- Insert sample data into products table
INSERT INTO products (name, price, description)
VALUES ("PRODUCT A", 20.00, "BEST QUALITY AT BEST PRICE"),
      ("PRODUCT B", 32.00, "AWESOME PRODUCT"),
      ("PRODUCT C", 40.00, "GREAT AND USEFUL PRODUCT");
      
      -- QUERIES WRITNG 
      
      -- a) Retrieve customers who ordered in the last 30 days:
      SELECT * FROM customers c 
      INNER JOIN orders o ON c.id = o.customer_id
      WHERE o.order_date >= CURDATE() - INTERVAL 30 DAY;
      
      -- b) get total amount of all orders per customer:
      SELECT c.name, SUM(o.total_amount) AS total_spent
      FROM customers c 
      INNER JOIN orders o ON c.id = o.customer_id
      GROUP BY c.name;
      
      -- c) Update price of Product C:
      
-- Retrieve the id of "Product C"
-- SELECT id FROM products WHERE name = "Product C" LIMIT 0, 1000;

-- Update the price based on the retrieved id
UPDATE products
SET price = 45.00
WHERE name = "Product C";

-- d) Add discount coulmn to products table:
ALTER TABLE products 
ADD COLUMN discount DECIMAL(5,2) DEFAULT NULL;

-- e) Retrieve the top 3 products with the highest price:
SELECT * FROM products 
ORDER BY price DESC LIMIT 3;

-- f) Get names of customers who ordered Product A:
SELECT  c.name FROM customers c 
INNER JOIN orders o ON c.id = o.customer_id
INNER JOIN products p ON o.id = p.id
WHERE p.name = "Product A";

-- g) Join orders and customers tables to retrieve the customer's name & date:
SELECT c.name, o.order_date 
FROM customers c 
INNER JOIN orders o ON c.id = o.customer_id;

-- h) retrieve the orders with total amount greater than 150.00:

SELECT * FROM orders
WHERE total_amount > 150.00


-- i) Normalize the database by creating a seperate table for order items and updating the orders;

-- Create the order_items table
CREATE TABLE order_items (
  id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(id),
  FOREIGN KEY (product_id) REFERENCES products(id)   

);

-- Populate order_items table with sample data (assuming single product per order for simplicity)
INSERT INTO order_items (order_id, product_id, quantity, price)
SELECT o.id, p.id, 1, p.price
FROM orders o
INNER JOIN products p ON o.id = p.id;

-- Update orders table to reference order_items
ALTER TABLE orders DROP COLUMN total_amount;


-- j) Retrieve the average total of all orders:
SELECT AVG(total_amount) AS average_total
FROM orders;





