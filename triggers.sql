
-- =====================================================
-- 🧠 1. Auto Calculate Total Invoice Amount
-- =====================================================
-- Whenever a service is added to an appointment,
-- the total_amount is automatically updated.

DELIMITER $$

CREATE TRIGGER trg_update_total_amount
AFTER INSERT ON appointment_services
FOR EACH ROW
BEGIN
    UPDATE appointments
    SET total_amount = total_amount + NEW.actual_price
    WHERE appointment_id = NEW.appointment_id;
END $$

DELIMITER ;

-- =====================================================
-- 💳 2. Business Rule: Prevent Payment Before Completion
-- =====================================================
-- Ensures payments can only be made if appointment is completed.

DELIMITER $$

CREATE TRIGGER trg_payment_validation
BEFORE INSERT ON payments
FOR EACH ROW
BEGIN
    DECLARE appt_status VARCHAR(50);

    SELECT status INTO appt_status
    FROM appointments
    WHERE appointment_id = NEW.appointment_id;

    IF appt_status != 'completed' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Payment allowed only for completed appointments';
    END IF;
END $$

DELIMITER ;

-- =====================================================
-- 🚗 3. Auto Update Appointment Status After Payment
-- =====================================================
-- Once a payment is made, appointment is marked as completed.

DELIMITER $$

CREATE TRIGGER trg_mark_appointment_paid
AFTER INSERT ON payments
FOR EACH ROW
BEGIN
    UPDATE appointments
    SET status = 'completed'
    WHERE appointment_id = NEW.appointment_id;
END $$

DELIMITER ;

-- =====================================================
-- 🧾 4. Audit Logging System (Track Data Changes)
-- =====================================================
-- Logs every new appointment for tracking purposes.

CREATE TABLE IF NOT EXISTS audit_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    action VARCHAR(100),
    table_name VARCHAR(100),
    record_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER trg_log_appointments
AFTER INSERT ON appointments
FOR EACH ROW
BEGIN
    INSERT INTO audit_logs(action, table_name, record_id)
    VALUES ('INSERT', 'appointments', NEW.appointment_id);
END $$

DELIMITER ;

-- =====================================================
-- 👤 5. Data Integrity: Prevent Deleting Customers with Cars
-- =====================================================
-- Protects relational integrity by blocking unsafe deletes.

DELIMITER $$

CREATE TRIGGER trg_prevent_customer_delete
BEFORE DELETE ON customers
FOR EACH ROW
BEGIN
    DECLARE car_count INT;

    SELECT COUNT(*) INTO car_count
    FROM cars
    WHERE customer_id = OLD.customer_id;

    IF car_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete customer with existing cars';
    END IF;
END $$

DELIMITER ;

-- =====================================================
-- 🔧 6. Auto Update Timestamp on Customer Update
-- =====================================================
-- Automatically updates "updated_at" whenever customer data changes.

DELIMITER $$

CREATE TRIGGER trg_update_customer_timestamp
BEFORE UPDATE ON customers
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END $$

DELIMITER ;