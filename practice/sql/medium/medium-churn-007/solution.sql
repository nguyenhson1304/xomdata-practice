-- Xom Data · Revenue walking out the door with old customers
-- Problem: https://xomdata.com/practice/medium-churn-007
-- Solved: 2026-11-11

with date_diff as (
    select
        customer_id,
        amount,
        sum(amount) over (partition by customer_id) as total_revenue,
        max(order_date) over (partition by customer_id) as last_order_date,
        '2024-06-30'::date - (max(order_date) over (partition by customer_id))::date as date_diff
    from orders
)

select
    distinct customer_id,
    last_order_date,
    total_revenue as lost_revenue
from date_diff
where date_diff > 90
order by lost_revenue desc, customer_id
