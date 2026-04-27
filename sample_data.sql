INSERT INTO branches (name, location, phone, is_active)
VALUES
('Riyadh Main Branch', 'Riyadh - Olaya', '0501111111', 1),
('Jeddah Central', 'Jeddah - Al-Rawdah', '0502222222', 1),
('Dammam Service Center', 'Dammam - Al Faisaliyah', '0503333333', 1);


INSERT INTO services (name, description, base_price, estimated_duration_minutes)
VALUES
('Oil Change', 'Engine oil replacement service', 150, 30),
('Brake Inspection', 'Full brake system check', 200, 60),
('Engine Diagnostic', 'Computer diagnostic scan', 120, 40),
('Full Car Wash', 'Exterior & interior cleaning', 80, 45);


INSERT INTO parts (name, sku, price, stock_quantity)
VALUES
('Oil Filter', 'OF-1001', 35, 200),
('Brake Pads', 'BP-2002', 180, 120),
('Air Filter', 'AF-3003', 50, 150),
('Spark Plug', 'SP-4004', 25, 300);


INSERT INTO customers (first_name, last_name, phone, email, address, status)
VALUES
('Ali', 'Ahmed', '0500000001', 'ali@gmail.com', 'Riyadh', 'active'),
('Sara', 'Mohammed', '0500000002', 'sara@gmail.com', 'Jeddah', 'active'),
('Omar', 'Khaled', '0500000003', 'omar@gmail.com', 'Dammam', 'active'),
('Nora', 'Ali', '0500000004', 'nora@gmail.com', 'Riyadh', 'active');

INSERT INTO employees (branch_id, name, role, specialty, phone, salary, hire_date)
VALUES
(7, 'Mohammed Ali', 'manager', 'General Management', '0551111111', 9000, '2022-01-01'),
(7, 'Fahad Saleh', 'technician', 'Engine Specialist', '0552222222', 6000, '2023-02-10'),
(8, 'Hassan Omar', 'technician', 'Brake Systems', '0553333333', 5500, '2023-05-01');

INSERT INTO appointment_services (appointment_id, service_id, employee_id, actual_price)
VALUES
(1, 1, 2, 150),
(1, 2, 3, 100),
(2, 3, 2, 200);

INSERT INTO appointments (customer_id, car_id, branch_id, appointment_date, status, total_amount)
VALUES
(1, 1, 1, '2026-04-28 10:00:00', 'completed', 250),
(2, 2, 2, '2026-04-29 12:00:00', 'in_progress', 200),
(3, 3, 3, '2026-04-30 09:00:00', 'pending', 0);

INSERT INTO cars (customer_id, brand, model, year, plate_number, vin_number, color)
VALUES
(1, 'Toyota', 'Camry', 2020, 'RHD123', 'VIN001AAA', 'White'),
(2, 'Hyundai', 'Elantra', 2022, 'JHD456', 'VIN002BBB', 'Black'),
(3, 'BMW', 'X5', 2021, 'DMM789', 'VIN003CCC', 'Blue'),
(4, 'Honda', 'Accord', 2019, 'RYD321', 'VIN004DDD', 'Silver');

INSERT INTO payments (appointment_id, amount, payment_method, payment_date, transaction_reference)
VALUES
(1, 250, 'credit_card', '2026-04-28 11:00:00', 'TXN10001');