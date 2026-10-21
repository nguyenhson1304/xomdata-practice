-- Xom Data · Highest-revenue month across the chain
-- Problem: https://xomdata.com/practice/easy-max-001
-- Solved: 2026-10-21

select
    max(monthly_revenue) as max_revenue
from stores
