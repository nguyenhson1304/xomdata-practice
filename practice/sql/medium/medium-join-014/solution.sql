-- Xom Data · Stock-in history by supplier
-- Problem: https://xomdata.com/practice/medium-join-014
-- Solved: 2026-11-22

with cte as (
    select
        w.warehouse_name,
        count(si.import_date) as import_count,
        count(distinct si.product_id) as distinct_product_count,
        count(distinct si.suppliers) as distinct_supplier_count,
        max(si.import_date) as last_import_date,
        rank() over (order by count(si.import_date) desc) as activity_rank,
        lag(w.warehouse_name) over () as prev_warehouse
    from stock_imports si
    inner join warehouses w on si.warehouse_id = w.id
    inner join products p on si.product_id = p.id
    group by w.warehouse_name
)

select
    *
from cte
order by activity_rank, warehouse_name
