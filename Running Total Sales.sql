CREATE TABLE sales (
    store_name VARCHAR(50),
    sale_date DATE,
    sales_amount DECIMAL(10, 2)
);

INSERT INTO sales (store_name, sale_date, sales_amount) 
VALUES
('A', '2024-01-01', 1000.00),
('A', '2024-02-01', 1500.00),
('A', '2024-03-01', 2000.00),
('A', '2024-04-01', 3000.00),
('A', '2024-05-01', 4500.00),
('A', '2024-06-01', 6000.00),
('B', '2024-01-01', 2000.00),
('B', '2024-02-01', 2200.00),
('B', '2024-03-01', 2400.00),
('B', '2024-04-01', 2600.00),
('B', '2024-05-01', 2800.00),
('B', '2024-06-01', 3000.00),
('C', '2024-01-01', 3000.00),
('C', '2024-02-01', 3100.00),
('C', '2024-03-01', 3200.00),
('C', '2024-04-01', 3300.00),
('C', '2024-05-01', 3400.00),
('C', '2024-06-01', 3500.00);

SELECT * FROM SALES

--Calculate each store running total
--Growth ratio compare to previous month
--return store name, sales amount, running total, growth ratio



-- RUNNING TOTAL
-- LAST MONTH SALE
-- GROWTH RATIO
-- growth ratio = cr sale - last_sale/last m sale * 100

WITH CTE AS (
    SELECT *,
        SUM(SALES_AMOUNT) OVER (PARTITION BY STORE_NAME ORDER BY SALE_DATE) AS RUNNING_TOTAL,
        LAG(SALES_AMOUNT, 1) OVER (PARTITION BY STORE_NAME ORDER BY SALE_DATE) AS LAST_MONTH_SALE
    FROM SALES
)
SELECT
    STORE_NAME,
    SALE_DATE,
    SALES_AMOUNT,
    RUNNING_TOTAL,
    LAST_MONTH_SALE,
    ROUND((SALES_AMOUNT - LAST_MONTH_SALE) / NULLIF(LAST_MONTH_SALE, 0) * 100, 2) AS GROWTH_RATIO
FROM CTE;
