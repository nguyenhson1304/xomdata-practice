-- Xom Data · Each Customer's Slice of Revenue
-- Problem: https://xomdata.com/practice/medium-monetary-005
-- Solved: 2026-11-03

with total_spent_and_revenue as (
    select
        customer_id,
        sum(amount) over (partition by customer_id) as total_spent,
        sum(amount) over () as total_revenue
    from orders
)

select
    distinct customer_id,
    total_spent,
    round((total_spent * 100.0 / total_revenue), 2) as revenue_share_pct
from total_spent_and_revenue
order by revenue_share_pct desc, customer_id
