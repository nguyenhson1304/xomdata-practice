-- Xom Data · Highest and lowest score in the cohort
-- Problem: https://xomdata.com/practice/easy-minmax-001
-- Solved: 2026-10-21

select
    max(avg_score) as max_score,
    min(avg_score) as min_score
from students 
where avg_score is not null
