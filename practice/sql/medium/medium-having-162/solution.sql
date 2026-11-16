-- Xom Data · Suppliers that deliver late frequently
-- Problem: https://xomdata.com/practice/medium-having-162
-- Solved: 2026-11-16

with late_values as (
    select
        s.supplier_name,
        s.material_type,
        count(po.supplier_id) as purchase_count,
        sum(po.total_value) as total_purchase_value,
        round(avg(po.actual_receipt::date - po.expected_receipt::date), 2) as avg_late_days,
        round(avg(
            case
                when po.expected_receipt >= po.actual_receipt then 1
                else 0
            end
        ) * 100.0, 2) as on_time_rate,
        rank() over (order by avg(po.actual_receipt::date - po.expected_receipt::date) desc) as late_rank,
        ntile(4) over (order by avg(po.actual_receipt::date - po.expected_receipt::date) desc) as risk_tier
    from suppliers s
    inner join purchase_orders po on s.id = po.supplier_id
    group by s.supplier_name, s.material_type
    having count(po.supplier_id) >= 3 
        and round(avg(po.actual_receipt::date - po.expected_receipt::date),2) > 0.00
)

select
    *
from late_values
order by late_rank, supplier_name
