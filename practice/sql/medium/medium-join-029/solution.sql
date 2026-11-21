-- Xom Data · Instructor teaching load
-- Problem: https://xomdata.com/practice/medium-join-029
-- Solved: 2026-11-21

-- with cte_1 as (
--     select
--         l.full_name,
--         l.academic_degree,
--         count(s.lecturer_id) as subjects_taught,
--         rank() over (order by count(s.lecturer_id) desc) as workload_rank,
--         sum(count(s.lecturer_id)) over (order by count(s.lecturer_id) desc, l.full_name rows between unbounded preceding and current row) as cumulative_subjects
--     from lecturers l
--     left join subjects s on l.id = s.lecturer_id
--     group by l.full_name, l.academic_degree, s.lecturer_id
-- )

-- select *
-- from cte_1
-- order by workload_rank, full_name

select
    l.full_name,
    l.academic_degree,
    count(s.lecturer_id) as subjects_taught,
    rank() over (order by count(s.lecturer_id) desc) as workload_rank,
    sum(count(s.lecturer_id)) over (order by count(s.lecturer_id) desc, l.full_name rows between unbounded preceding and current row) as cumulative_subjects
from lecturers l
left join subjects s on l.id = s.lecturer_id
group by l.full_name, l.academic_degree, s.lecturer_id
