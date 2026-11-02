-- Xom Data · Regional payroll with shares
-- Problem: https://xomdata.com/practice/medium-winagg-010
-- Solved: 2026-11-02

-- Write your SQL here
with region_total as (
    select
        region,
        staff_name,
        salary,
        sum(salary) over (partition by region order by salary desc, staff_name
        rows between unbounded preceding and unbounded following) as region_total
    from payroll
)

select
    *,
    round(((salary * 100.0) / region_total), 2) as pct_of_region
from region_total
