-- Xom Data · Top 5 highest-paid employees
-- Problem: https://xomdata.com/practice/easy-limit-004
-- Solved: 2026-10-21

select
    full_name,
    salaries
from employees
where salaries is not null
order by salaries desc
limit 5
