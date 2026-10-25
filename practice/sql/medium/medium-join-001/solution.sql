-- Xom Data · Customer spending per order
-- Problem: https://xomdata.com/practice/medium-join-001
-- Solved: 2026-10-25

select
    c.full_name,
    count(o.customer_id) as order_count,
    sum(o.total_amount) as total_spending,
    round(avg(o.total_amount),0) as avg_order_value,
    row_number() over (order by sum(o.total_amount) desc, c.full_name) as spending_rank
from customers c
left join orders o on c.id = o.customer_id
group by c.full_name, o.customer_id
-- order by c.full_name
