-- =====================================================
-- ⚙️ نظام الإجراءات المخزنة (Stored Procedures)
-- =====================================================

-- =====================================================
-- 🧾 1. إنشاء موعد جديد (حجز خدمة)
-- =====================================================
-- يقوم بإنشاء موعد جديد لعميل مع سيارته في فرع معين
-- الحالة الافتراضية: pending
-- القيمة الإجمالية تبدأ من 0

DELIMITER $$

CREATE PROCEDURE sp_create_appointment(
    IN p_customer_id INT,
    IN p_car_id INT,
    IN p_branch_id INT
)
BEGIN
    INSERT INTO appointments(
        customer_id,
        car_id,
        branch_id,
        appointment_date,
        status,
        total_amount
    )
    VALUES (
        p_customer_id,
        p_car_id,
        p_branch_id,
        NOW(),
        'pending',
        0
    );
END $$

DELIMITER ;

-- =====================================================
-- 🔧 2. إضافة خدمة إلى الموعد
-- =====================================================
-- يقوم بإضافة خدمة معينة إلى موعد
-- السعر يتم حفظه وقت التنفيذ
-- التريغر سيقوم بتحديث total_amount تلقائياً

DELIMITER $$

CREATE PROCEDURE sp_add_service_to_appointment(
    IN p_appointment_id INT,
    IN p_service_id INT,
    IN p_employee_id INT,
    IN p_price DECIMAL(10,2)
)
BEGIN
    INSERT INTO appointment_services(
        appointment_id,
        service_id,
        employee_id,
        price_at_time
    )
    VALUES (
        p_appointment_id,
        p_service_id,
        p_employee_id,
        p_price
    );
END $$

DELIMITER ;

-- =====================================================
-- 💳 3. تنفيذ عملية دفع
-- =====================================================
-- يقوم بتسجيل عملية الدفع
-- التريغر سيتأكد من أن الموعد مكتمل قبل الدفع

DELIMITER $$

CREATE PROCEDURE sp_make_payment(
    IN p_appointment_id INT,
    IN p_amount DECIMAL(10,2),
    IN p_method VARCHAR(50)
)
BEGIN
    INSERT INTO payments(
        appointment_id,
        amount,
        payment_method,
        payment_date
    )
    VALUES (
        p_appointment_id,
        p_amount,
        p_method,
        NOW()
    );
END $$

DELIMITER ;

-- =====================================================
-- 📊 4. تقرير شامل عن العميل
-- =====================================================
-- يعرض:
-- عدد الزيارات + مجموع المدفوعات

DELIMITER $$

CREATE PROCEDURE sp_customer_summary(
    IN p_customer_id INT
)
BEGIN
    SELECT 
        c.first_name,
        c.last_name,
        COUNT(a.appointment_id) AS total_visits,
        IFNULL(SUM(p.amount), 0) AS total_spent
    FROM customers c
    LEFT JOIN appointments a ON c.customer_id = a.customer_id
    LEFT JOIN payments p ON a.appointment_id = p.appointment_id
    WHERE c.customer_id = p_customer_id
    GROUP BY c.customer_id;
END $$

DELIMITER ;

-- =====================================================
-- 🏢 5. تقرير أداء الفروع
-- =====================================================
-- يعرض عدد الطلبات + الإيرادات لكل فرع

DELIMITER $$

CREATE PROCEDURE sp_branch_performance()
BEGIN
    SELECT 
        b.name,
        COUNT(a.appointment_id) AS total_appointments,
        IFNULL(SUM(p.amount), 0) AS total_revenue
    FROM branches b
    LEFT JOIN appointments a ON b.branch_id = a.branch_id
    LEFT JOIN payments p ON a.appointment_id = p.appointment_id
    GROUP BY b.branch_id;
END $$

DELIMITER ;

-- =====================================================
-- 🚗 6. عرض جميع سيارات عميل معين
-- =====================================================
-- يساعد في معرفة كل سيارات العميل

DELIMITER $$

CREATE PROCEDURE sp_get_customer_cars(
    IN p_customer_id INT
)
BEGIN
    SELECT *
    FROM cars
    WHERE customer_id = p_customer_id;
END $$

DELIMITER ;

-- =====================================================
-- 🔍 7. البحث عن عميل عبر رقم الهاتف
-- =====================================================
-- مفيد للأنظمة الحقيقية (Reception)

DELIMITER $$

CREATE PROCEDURE sp_find_customer_by_phone(
    IN p_phone VARCHAR(20)
)
BEGIN
    SELECT *
    FROM customers
    WHERE phone = p_phone;
END $$

DELIMITER ;

-- =====================================================
-- 📅 8. عرض مواعيد فرع معين
-- =====================================================
-- يعرض كل المواعيد لفرع محدد

DELIMITER $$

CREATE PROCEDURE sp_branch_appointments(
    IN p_branch_id INT
)
BEGIN
    SELECT *
    FROM appointments
    WHERE branch_id = p_branch_id
    ORDER BY appointment_date DESC;
END $$

DELIMITER ;

-- =====================================================
-- ❌ 9. إلغاء موعد
-- =====================================================
-- يغير حالة الموعد إلى cancelled

DELIMITER $$

CREATE PROCEDURE sp_cancel_appointment(
    IN p_appointment_id INT
)
BEGIN
    UPDATE appointments
    SET status = 'cancelled'
    WHERE appointment_id = p_appointment_id;
END $$

DELIMITER ;

-- =====================================================
-- 🔄 10. تحديث حالة الموعد
-- =====================================================
-- يستخدم لتغيير الحالة (confirmed / in_progress / completed)

DELIMITER $$

CREATE PROCEDURE sp_update_appointment_status(
    IN p_appointment_id INT,
    IN p_status VARCHAR(50)
)
BEGIN
    UPDATE appointments
    SET status = p_status
    WHERE appointment_id = p_appointment_id;
END $$

DELIMITER ;