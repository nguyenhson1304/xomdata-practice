-- Xom Data · High-rated sellers with many orders
-- Problem: https://xomdata.com/practice/medium-having-019
-- Solved: 2026-11-06

select
    s.store_name,
    s.reputation_score,
    count(s.store_name) as order_count,
    dense_rank() over (order by count(s.store_name) desc) as rank_by_orders,
    sum(count(s.store_name)) over (rows between unbounded preceding and current row) as cumulative_orders
from sellers s
inner join orders o on s.id = o.seller_id
where reputation_score >= 4.5
group by s.store_name, s.reputation_score
having count(s.store_name) >= 3
