-- Xom Data · Classify student academic performance
-- Problem: https://xomdata.com/practice/medium-case-124
-- Solved: 2026-10-27

with cte_join as (
    select
        st.full_name,
        st.student_code,
        round(avg(sc.final_score), 2) as avg_score
    from students st
    left join scores sc on st.id = sc.student_id
    group by st.full_name, st.student_code
)

select
    *,
    case
        when avg_score >= 9.0 then 'Excellent'
        when avg_score >= 8.0 and avg_score < 9.0 then 'Good'
        when avg_score >= 7.0 and avg_score < 8.0 then 'Fair'
        when avg_score >= 5.0 and avg_score < 7.0 then 'Average'
        else 'Poor'
    end as grade,
    dense_rank() over(order by avg_score desc, student_code) as class_rank
from cte_join
limit 20
