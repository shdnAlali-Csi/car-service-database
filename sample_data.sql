INSERT INTO customers (name, phone)
VALUES ('Ali', '0999999999');

INSERT INTO cars (customer_id, brand, model, year, plate_number)
VALUES (1, 'Toyota', 'Corolla', 2020, 'ABC123');


-- إضافة فروع
INSERT INTO branches (name, location, phone) VALUES 
('فرع الرياض 1', 'العليا', '0111'), ('فرع الرياض 2', 'الصحافة', '0112'),
('فرع جدة 1', 'الروضة', '0121'), ('فرع جدة 2', 'أبحر', '0122'),
('فرع الدمام', 'الفيصلية', '0131'), ('فرع مكة', 'الشوقية', '0141');

-- إضافة خدمات
INSERT INTO services (name, description, base_price, estimated_duration_minutes) VALUES 
('تغيير زيت', 'زيت 10 آلاف كم', 150, 30), ('فحص فرامل', 'فحص وتغيير فحمات', 200, 60),
('تصفية ماكينة', 'تنظيف بخاخات وبواجي', 450, 120), ('فحص كمبيوتر', 'فحص شامل', 100, 30),
('تغيير مساعدات', 'مساعدات أمامية وخلفية', 800, 180), ('تلميع ساطع', 'داخلي وخارجي', 300, 240);

-- إضافة قطع غيار
INSERT INTO parts (name, sku, price, stock_quantity) VALUES 
('فلتر زيت تويوتا', 'TOY-001', 35, 100), ('فحمات سيراميك', 'BRK-99', 250, 50),
('بواجي ليزر', 'NGK-05', 180, 80), ('زيت تخليقي', 'OIL-5W30', 45, 500);



    DELIMITER $$

CREATE PROCEDURE PopulateMassiveData()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE cust_id INT;
    DECLARE car_id INT;
    DECLARE branch_id INT;
    DECLARE emp_id INT;

    -- 1. توليد 1000 موظف
    SET i = 1;
    WHILE i <= 1000 DO
        INSERT INTO employees (branch_id, name, role, specialty, salary, hire_date)
        VALUES (FLOOR(1 + RAND() * 6), CONCAT('موظف ', i), 
                IF(i%5=0, 'manager', 'technician'), 
                IF(i%2=0, 'ميكانيكا', 'كهرباء'), 
                5000 + (RAND() * 5000), '2020-01-01');
        SET i = i + 1;
    END WHILE;

    -- 2. توليد 2000 عميل
    SET i = 1;
    WHILE i <= 2000 DO
        INSERT INTO customers (first_name, last_name, phone, email, status)
        VALUES (CONCAT('الاسم', i), CONCAT('اللقب', i), 
                CONCAT('05', FLOOR(10000000 + RAND() * 89999999)), 
                CONCAT('user', i, '@example.com'), 'active');
        SET i = i + 1;
    END WHILE;

    -- 3. توليد 3000 سيارة (كل عميل لديه سيارة أو أكثر)
    SET i = 1;
    WHILE i <= 3000 DO
        INSERT INTO cars (customer_id, brand, model, year, plate_number, vin_number, color)
        VALUES (FLOOR(1 + RAND() * 2000), 
                ELT(FLOOR(1 + RAND() * 5), 'Toyota', 'Ford', 'Hyundai', 'Tesla', 'BMW'),
                CONCAT('Model-', i), 
                FLOOR(2015 + RAND() * 9), 
                CONCAT('PLATE-', i), 
                CONCAT('VIN-', UUID_SHORT()), 
                ELT(FLOOR(1 + RAND() * 4), 'White', 'Black', 'Silver', 'Blue'));
        SET i = i + 1;
    END WHILE;

    -- 4. توليد 10,000 موعد (Appointments)
    SET i = 1;
    WHILE i <= 10000 DO
        SET cust_id = FLOOR(1 + RAND() * 2000);
        SET branch_id = FLOOR(1 + RAND() * 6);
        
        INSERT INTO appointments (customer_id, car_id, branch_id, appointment_date, status, total_amount)
        VALUES (cust_id, 
                (SELECT car_id FROM cars WHERE customer_id = cust_id LIMIT 1),
                branch_id,
                TIMESTAMPADD(SECOND, FLOOR(RAND() * 31536000), '2023-01-01 00:00:00'),
                ELT(FLOOR(1 + RAND() * 5), 'pending', 'confirmed', 'in_progress', 'completed', 'cancelled'),
                0); 
        
        -- إضافة خدمة لهذا الموعد
        INSERT INTO appointment_services (appointment_id, service_id, employee_id, actual_price)
        VALUES (i, FLOOR(1 + RAND() * 6), FLOOR(1 + RAND() * 1000), 100 + (RAND() * 500));
        
        -- إضافة عملية دفع للمواعيد المكتملة
        IF (i % 2 = 0) THEN
            INSERT INTO payments (appointment_id, amount, payment_method, transaction_reference)
            VALUES (i, 200 + (RAND() * 1000), 'credit_card', CONCAT('REF-', UUID_SHORT()));
        END IF;

        SET i = i + 1;
    END WHILE;

END$$

DELIMITER ;


CALL PopulateMassiveData();