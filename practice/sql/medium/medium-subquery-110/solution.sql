-- Xom Data · Employees paid above their department average
-- Problem: https://xomdata.com/practice/medium-subquery-110
-- Solved: 2026-11-21

with cte_1 as (
    select
        e.full_name,
        d.dept_name,
        e.salary,
        avg(e.salary) over (partition by e.department_id) as dept_avg_salary,
        (e.salary - avg(e.salary) over (partition by e.department_id)) * 100.0 / (avg(e.salary) over (partition by e.department_id)) as premium_pct
    from departments d
    left join employees e on d.id = e.department_id
)

select
    full_name,
    dept_name,
    salary,
    round(cast(dept_avg_salary as decimal(10,2)), 0) as dept_avg_salary,
    round(cast(premium_pct as decimal(10,2)), 2) as premium_pct
from cte_1
where salary > dept_avg_salary
order by premium_pct desc, full_name
