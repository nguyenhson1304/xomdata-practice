-- Xom Data · Number of delivered orders
-- Problem: https://xomdata.com/practice/easy-count-002
-- Solved: 2026-10-23

select count(id) as order_count
FROM orders
WHERE status = 'Delivered';
