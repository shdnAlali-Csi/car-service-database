-- =====================================================
-- 🚀 PERFORMANCE OPTIMIZATION INDEXES
-- =====================================================

-- =====================================================
-- 👤 1. البحث عن العملاء بسرعة (الهاتف + الإيميل)
-- =====================================================
CREATE INDEX idx_customers_phone ON customers(phone);
CREATE INDEX idx_customers_email ON customers(email);

-- =====================================================
-- 🚗 2. البحث عن السيارات (لوحة + VIN)
-- =====================================================
CREATE INDEX idx_cars_plate ON cars(plate_number);
CREATE INDEX idx_cars_vin ON cars(vin_number);

-- =====================================================
-- 🔗 3. تسريع العلاقات (JOINs)
-- =====================================================
CREATE INDEX idx_cars_customer ON cars(customer_id);
CREATE INDEX idx_appointments_customer ON appointments(customer_id);
CREATE INDEX idx_appointments_car ON appointments(car_id);
CREATE INDEX idx_appointments_branch ON appointments(branch_id);

-- =====================================================
-- 📅 4. المواعيد حسب التاريخ (Dashboard / Reports)
-- =====================================================
CREATE INDEX idx_appointments_date ON appointments(appointment_date);

-- =====================================================
-- 📊 5. الحالة (Filtering + Dashboard)
-- =====================================================
CREATE INDEX idx_appointments_status ON appointments(status);

-- =====================================================
-- 💳 6. عمليات الدفع (تقارير مالية)
-- =====================================================
CREATE INDEX idx_payments_appointment ON payments(appointment_id);
CREATE INDEX idx_payments_date ON payments(payment_date);
CREATE INDEX idx_payments_method ON payments(payment_method);

-- =====================================================
-- 🔧 7. الخدمات داخل المواعيد (JOIN كثيف)
-- =====================================================
CREATE INDEX idx_appt_services_appointment ON appointment_services(appointment_id);
CREATE INDEX idx_appt_services_service ON appointment_services(service_id);
CREATE INDEX idx_appt_services_employee ON appointment_services(employee_id);

-- =====================================================
-- 👨‍🔧 8. الموظفين حسب الفرع
-- =====================================================
CREATE INDEX idx_employees_branch ON employees(branch_id);

-- =====================================================
-- 🧾 9. INDEX مركب (Composite Index) مهم جدًا
-- =====================================================
-- لتحسين التقارير (customer + date)

CREATE INDEX idx_appointments_customer_date 
ON appointments(customer_id, appointment_date);

-- =====================================================
-- 📊 10. INDEX مركب للدفع (تحليل مالي)
-- =====================================================
CREATE INDEX idx_payments_date_method 
ON payments(payment_date, payment_method);