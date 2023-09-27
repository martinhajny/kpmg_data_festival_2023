DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS clients;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;


-- Create clients table
CREATE TABLE clients (
    client_id INT AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    address VARCHAR(200) NOT NULL,
    PRIMARY KEY (client_id)
);


-- Create departments table
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT,
    department_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (department_id)
);



-- Create employees table
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    address VARCHAR(200) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    department_id INT NOT NULL,
    PRIMARY KEY (employee_id),
    FOREIGN KEY (department_id) REFERENCES departments (department_id)
);


-- Create transactions table
CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT,
    transaction_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    client_id INT NOT NULL,
    employee_id INT NOT NULL,
    PRIMARY KEY (transaction_id),
    FOREIGN KEY (client_id) REFERENCES clients (client_id),
    FOREIGN KEY (employee_id) REFERENCES employees (employee_id)
);


-- Insert data into clients table
INSERT INTO clients (first_name, last_name, email, phone_number, address)
VALUES
    ('Idaline', 'Tuvey', 'ituvey0@google.co.jp', '(767) 6979016', '952 Heffernan Hill'),
    ('Gloriana', 'Passie', 'gpassie1@miitbeian.gov.cn', '(693) 2169265', '7221 Mendota Pass'),
    ('Mia', 'McLarnon', 'mmclarnon2@themeforest.net', '(499) 6510548', '2347 Talmadge Hill'),
    ('Gerri', 'Werndley', 'gwerndley3@com.com', '(672) 4207454', '05 Ilene Terrace'),
    ('Kristen', 'Fronks', 'kfronks4@cisco.com', '(583) 1305574', '41 Delladonna Parkway');


-- Insert data into departments table
INSERT INTO departments (department_name)
VALUES
    ('Accounting'),
    ('Sales'),
    ('Finance');

-- Insert data into employees table
INSERT INTO employees (first_name, last_name, email, phone_number, address, salary, department_id)
VALUES
    ('Michael', 'Johnson', 'michael.johnson@example.com', '1234567890', '123 Main St', 50000.00, 1),
    ('Jessica', 'Davis', 'jessica.davis@example.com', '9876543210', '456 Oak Ave', 60000.00, 2),
    ('Christopher', 'Anderson', 'christopher.anderson@example.com', '5555555555', '789 Elm Dr', 70000.00, 1),
    ('Emily', 'Wilson', 'emily.wilson@example.com', '1111111111', '321 Pine Ln', 55000.00, 3),
    ('Daniel', 'Taylor', 'daniel.taylor@example.com', '9999999999', '654 Cedar Rd', 45000.00, 2);


-- Insert data into transactions table
INSERT INTO transactions (transaction_date, amount, client_id, employee_id)
VALUES
    (CURDATE(), 500.00, 1, 1),
    (CURDATE(), 1000.00, 2, 2),
    (CURDATE(), 750.00, 3, 3),
    (CURDATE(), 600.00, 4, 4),
    (CURDATE(), 900.00, 5, 5);