-- Xom Data · Scholarship-eligible students
-- Problem: https://xomdata.com/practice/easy-where-010
-- Solved: 2026-10-23

select
    full_name,
    student_code,
    avg_score
from students
where avg_score >= 8.0
order by avg_score desc
