-- Xom Data · Three-day rolling total per store
-- Problem: https://xomdata.com/practice/medium-rolling-002
-- Solved: 2026-10-22

-- Write your SQL here
select
    store,
    sale_date,
    units_sold,
    sum(units_sold) over(partition by store order by store, sale_date
    rows between 2 preceding and current row) as sum_3d
from daily_sales
