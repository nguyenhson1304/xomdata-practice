-- Xom Data · Low-activity users
-- Problem: https://xomdata.com/practice/medium-subquery-160
-- Solved: 2026-11-10

with first_calculation as (
    select
        u.id,
        u.user_name,
        o.value,
        count(o.id) over (partition by u.id) as order_count,
        sum(o.value) over (partition by u.id) as total_value,
        sum(o.value) over (partition by u.id) / count(o.id) over (partition by u.id) as avg_order_value
    from users u
    left join orders o on u.id = o.user_id
),

total_avg_value as (
    select
        user_id,
        sum(value) over () / (select count(distinct user_id) from orders) as total_avg_value
    from orders
),

tier as (
    select
        distinct fc.user_name,
        fc.order_count,
        fc.total_value,
        fc.avg_order_value,
        case
            when avg_order_value is null then 'Inactive'
            when avg_order_value < total_avg_value then 'Low'
            else 'Normal'
        end as tier
    from first_calculation fc
    left join total_avg_value tav on fc.id = tav.user_id
    where total_value is null or total_value < total_avg_value
)

select
    *,
    rank() over (order by total_value asc nulls first) as activity_rank,
    round(cast(percent_rank() over (order by total_value asc nulls first) * 100.0 as numeric), 2) as pct_above_peers
from tier
