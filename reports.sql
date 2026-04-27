-- =========================
-- 🚗 Car Service Dashboard Queries
-- =========================

-- 1. إجمالي عدد العملاء
SELECT COUNT(*) AS total_customers
FROM customers;

-- 2. إجمالي عدد السيارات
SELECT COUNT(*) AS total_cars
FROM cars;

-- 3. عدد المواعيد حسب الحالة (Chart)
SELECT status, COUNT(*) AS total
FROM appointments
GROUP BY status;

-- 4. إجمالي الإيرادات
SELECT SUM(amount) AS total_revenue
FROM payments;

-- 5. الإيرادات حسب الفرع
SELECT 
b.name AS branch_name,
SUM(p.amount) AS revenue
FROM payments p
JOIN appointments a ON p.appointment_id = a.appointment_id
JOIN branches b ON a.branch_id = b.branch_id
GROUP BY b.branch_id, b.name;

-- 6. أكثر الخدمات استخداما
SELECT 
s.name,
COUNT(*) AS usage_count
FROM appointment_services ap
JOIN services s ON ap.service_id = s.service_id
GROUP BY ap.service_id, s.name
ORDER BY usage_count DESC;

-- 7. أكثر العملاء نشاطا
SELECT 
c.first_name,
c.last_name,
COUNT(a.appointment_id) AS total_visits
FROM customers c
JOIN appointments a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_visits DESC;

-- 8. السيارات الأكثر زيارة
SELECT 
car.plate_number,
COUNT(a.appointment_id) AS visits
FROM cars car
JOIN appointments a ON car.car_id = a.car_id
GROUP BY car.car_id, car.plate_number
ORDER BY visits DESC;

-- 9. أداء الفروع (عدد المواعيد)
SELECT 
b.name,
COUNT(a.appointment_id) AS total_appointments
FROM branches b
JOIN appointments a ON b.branch_id = a.branch_id
GROUP BY b.branch_id, b.name;

-- 10. طرق الدفع الأكثر استخداما
SELECT 
payment_method,
COUNT(*) AS count
FROM payments
GROUP BY payment_method;