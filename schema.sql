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
