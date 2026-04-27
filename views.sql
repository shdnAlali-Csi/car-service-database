-- View: Customer Cars
CREATE VIEW v_customer_cars AS
SELECT 
c.customer_id,
c.first_name,
c.last_name,
car.car_id,
car.brand,
car.model,
car.plate_number
FROM customers c
JOIN cars car ON c.customer_id = car.customer_id;