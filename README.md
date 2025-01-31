Sure! Here is the entire `README.md` in **bash format** with each step laid out clearly for terminal usage, along with all SQL commands for creating the database, tables, and executing the queries.

```bash
# E-Commerce Database - SQL Task

This task involves creating a simple e-commerce system using a MySQL database. The system consists of three main tables: `customers`, `orders`, and `products`. Below are the step-by-step instructions, including SQL commands and queries to manage the e-commerce system.

---

# Step 1: Create the Database

```bash
-- Create the 'ecommerce' database
CREATE DATABASE ecommerce;

-- Switch to the 'ecommerce' database
USE ecommerce;
```

---

# Step 2: Create the Tables

## 2.1 Create `customers` Table

```bash
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for each customer
    name VARCHAR(100) NOT NULL,         -- Customer's name
    email VARCHAR(100) NOT NULL,        -- Customer's email address
    address TEXT                        -- Customer's address
);
```

## 2.2 Create `orders` Table

```bash
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,   -- Unique identifier for each order
    customer_id INT,                     -- Foreign key referring to customers.id
    order_date DATE,                      -- Date the order was placed
    total_amount DECIMAL(10, 2),          -- Total amount of the order
    FOREIGN KEY (customer_id) REFERENCES customers(id)  -- Link to customers table
);
```

## 2.3 Create `products` Table

```bash
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,   -- Unique identifier for each product
    name VARCHAR(100) NOT NULL,           -- Product's name
    price DECIMAL(10, 2) NOT NULL,        -- Product's price
    description TEXT                      -- Product's description
);
```

---

# Step 3: Insert Sample Data

```bash
-- Insert sample data into the 'customers' table
INSERT INTO customers (name, email, address)
VALUES
    ('Alice Johnson', 'alice@example.com', '123 Elm Street'),
    ('Bob Smith', 'bob@example.com', '456 Oak Avenue'),
    ('Charlie Brown', 'charlie@example.com', '789 Pine Road');

-- Insert sample data into the 'products' table
INSERT INTO products (name, price, description)
VALUES
    ('Product A', 25.00, 'Description of Product A'),
    ('Product B', 30.00, 'Description of Product B'),
    ('Product C', 40.00, 'Description of Product C');

-- Insert sample data into the 'orders' table
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES
    (1, '2024-01-15', 55.00),
    (2, '2024-01-20', 60.00),
    (3, '2024-01-25', 90.00);
```

---

# Step 4: Write Queries

## 4.1 Retrieve All Customers Who Have Placed an Order in the Last 30 Days

```bash
SELECT DISTINCT customers.name, customers.email
FROM customers
JOIN orders ON customers.id = orders.customer_id
WHERE orders.order_date >= CURDATE() - INTERVAL 30 DAY;
```

- This query retrieves customers who have placed orders in the last 30 days.

---

## 4.2 Get the Total Amount of All Orders Placed by Each Customer

```bash
SELECT customers.name, SUM(orders.total_amount) AS total_spent
FROM customers
JOIN orders ON customers.id = orders.customer_id
GROUP BY customers.id;
```

- This query calculates the total amount spent by each customer.

---

## 4.3 Update the Price of Product C to 45.00

```bash
UPDATE products
SET price = 45.00
WHERE name = 'Product C';
```

- This query updates the price of "Product C" to 45.00.

---

## 4.4 Add a New Column `discount` to the `products` Table

```bash
ALTER TABLE products
ADD COLUMN discount DECIMAL(5, 2);
```

- This query adds a `discount` column to the `products` table.

---

## 4.5 Retrieve the Top 3 Products with the Highest Price

```bash
SELECT name, price
FROM products
ORDER BY price DESC
LIMIT 3;
```

- This query retrieves the top 3 products with the highest price.

---

## 4.6 Get the Names of Customers Who Have Ordered Product A

```bash
SELECT DISTINCT customers.name
FROM customers
JOIN orders ON customers.id = orders.customer_id
JOIN order_items ON orders.id = order_items.order_id
JOIN products ON order_items.product_id = products.id
WHERE products.name = 'Product A';
```

- This query retrieves the names of customers who have ordered "Product A".

---

## 4.7 Join the Orders and Customers Tables to Retrieve the Customer's Name and Order Date for Each Order

```bash
SELECT customers.name, orders.order_date
FROM orders
JOIN customers ON orders.customer_id = customers.id;
```

- This query retrieves the customer's name and the order date for each order placed.

---

## 4.8 Retrieve Orders with a Total Amount Greater Than 150.00

```bash
SELECT * FROM orders
WHERE total_amount > 150.00;
```

- This query retrieves all orders with a total amount greater than 150.00.

---

## 4.9 Normalize the Database by Creating a Separate Table for Order Items

### Step 1: Create `order_items` Table

```bash
-- Create the order_items table
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);
```

### Step 2: Remove `total_amount` Column from Orders Table

```bash
-- Remove the total_amount column from orders table
ALTER TABLE orders
DROP COLUMN total_amount;
```

- These queries normalize the database by creating a new `order_items` table to store each product's details (quantity, price, etc.) for an order, and remove the `total_amount` column from the `orders` table.

---

## 4.10 Retrieve the Average Total of All Orders

```bash
SELECT AVG(total_amount) AS average_order_total
FROM orders;
```

- This query calculates the average total amount of all orders.

---

# Conclusion

By following these steps, you have successfully created and managed an e-commerce database with tables for customers, orders, and products. You can now run SQL queries to retrieve and manipulate data efficiently.

---

# Additional Notes

- Make sure to adjust the queries and table structures as necessary depending on your database management system.
- You can further enhance the database by adding more attributes or creating additional tables (e.g., `payments`, `shippings`, etc.) based on requirements.

Let me know if you need more information or if you encounter any issues.
```

### Summary:
This `README.md` file provides you with **clear bash-style commands** for creating the database, tables, inserting data, and running queries. Each section is marked with a clear step and corresponding SQL command. You can easily copy and run these commands in your terminal or MySQL client to set up the e-commerce system.