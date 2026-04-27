  CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  );
  CREATE TABLE cars (
    car_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    brand VARCHAR(50),
    model VARCHAR(50),
    year INT,
    plate_number VARCHAR(20) UNIQUE,
    
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
  );
  CREATE TABLE branches (
    branch_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    location VARCHAR(100)
  );
  CREATE TABLE branches (
    branch_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    location VARCHAR(100)
  );
  CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    branch_id INT,
    name VARCHAR(100),
    role VARCHAR(50),
    
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
  );
  CREATE TABLE services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    base_price DECIMAL(10,2),
    duration_minutes INT
  );
  CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    car_id INT,
    branch_id INT,
    appointment_date DATETIME,
    status VARCHAR(50),
    
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (car_id) REFERENCES cars(car_id),
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
  );
  CREATE TABLE appointment_services (
    id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT,
    service_id INT,
    price_at_time DECIMAL(10,2),
    
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id),
    FOREIGN KEY (service_id) REFERENCES services(service_id)
  );
  CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT,
    amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    payment_date DATETIME,
    
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
  );

  ALTER TABLE branches 
ADD COLUMN phone VARCHAR(20) AFTER location,
ADD COLUMN is_active BOOLEAN DEFAULT TRUE AFTER phone,
ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
ALTER TABLE customers 
ADD COLUMN address TEXT AFTER email,
ADD COLUMN status ENUM('active', 'inactive', 'blacklisted') DEFAULT 'active' AFTER address,
ADD COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE cars 
ADD COLUMN vin_number VARCHAR(17) UNIQUE AFTER plate_number,
ADD COLUMN color VARCHAR(30) AFTER vin_number,
ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE employees 
ADD COLUMN specialty VARCHAR(100) AFTER role,
ADD COLUMN phone VARCHAR(20) AFTER specialty,
ADD COLUMN salary DECIMAL(10,2) AFTER phone,
ADD COLUMN hire_date DATE AFTER salary,
ADD COLUMN is_active BOOLEAN DEFAULT TRUE AFTER hire_date;

ALTER TABLE employees MODIFY COLUMN role ENUM('manager', 'technician', 'receptionist', 'admin') NOT NULL;

ALTER TABLE services 
ADD COLUMN description TEXT AFTER name,
ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE appointments 
ADD COLUMN total_amount DECIMAL(10,2) DEFAULT 0.00 AFTER status,
ADD COLUMN notes TEXT AFTER total_amount,
ADD COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE appointments MODIFY COLUMN status ENUM('pending', 'confirmed', 'in_progress', 'completed', 'cancelled') DEFAULT 'pending';

ALTER TABLE appointment_services 
ADD COLUMN employee_id INT AFTER service_id,
ADD FOREIGN KEY (employee_id) REFERENCES employees(employee_id);

ALTER TABLE payments 
ADD COLUMN transaction_reference VARCHAR(100) AFTER payment_method;

ALTER TABLE payments MODIFY COLUMN payment_method ENUM('cash', 'credit_card', 'bank_transfer', 'apple_pay') NOT NULL;


CREATE TABLE parts (
  part_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  sku VARCHAR(50) UNIQUE,
  price DECIMAL(10,2) NOT NULL,
  stock_quantity INT DEFAULT 0,
  min_stock_level INT DEFAULT 5,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE customers CHANGE name first_name VARCHAR(50);
ALTER TABLE customers ADD COLUMN last_name VARCHAR(50) AFTER first_name;
