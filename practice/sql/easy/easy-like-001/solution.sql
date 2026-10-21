-- Xom Data · Basic-plan subscribers
-- Problem: https://xomdata.com/practice/easy-like-001
-- Solved: 2026-10-21

select 
    phone_number,
    full_name,
    plans
from subscribers
where plans like '%basic%'
    or plans like '%Basic%'
    or plans like '%BASIC%'
order by full_name
