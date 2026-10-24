-- Xom Data · Revenue from delivered orders
-- Problem: https://xomdata.com/practice/easy-sum-001
-- Solved: 2026-10-24

select
    sum(total_amount) as total_revenue
from orders
where status = 'Delivered'
