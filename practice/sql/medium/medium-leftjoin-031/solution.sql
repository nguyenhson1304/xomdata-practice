-- Xom Data · Candidates not yet interviewed
-- Problem: https://xomdata.com/practice/medium-leftjoin-031
-- Solved: 2026-10-29

select
    c.full_name,
    c.email,
    c.application_date,
    row_number() over(order by c.application_date, c.full_name) as queue_position,
    round(cast(percent_rank() over (order by application_date) * 100 AS numeric), 2) as older_than_pct
from candidates c
left join interviews i on c.id = i.candidate_id
where c.id not in (select candidate_id from interviews)
