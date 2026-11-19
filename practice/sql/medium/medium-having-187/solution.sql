-- Xom Data · Players with 3 or more goals
-- Problem: https://xomdata.com/practice/medium-having-187
-- Solved: 2026-11-19

with calcul_1 as (
    select
        p.full_name,
        p.positions,
        t.team_name,
        count(distinct g.id) as goal_count,
        count(distinct g.match_id) as scoring_matches,
        count(distinct pt.id) as cards_received,
        round(count(distinct g.id) * 1.0 / count(distinct g.match_id), 2) as goals_per_match,
        dense_rank() over (order by (count(distinct g.id) * 1.0 / count(distinct g.match_id)) desc) as efficiency_rank,
        rank() over (order by count(distinct g.id) desc) as volume_rank
    from players p
    left join teams t on p.team_id = t.id
    left join goals g on p.id = g.player_id
    left join penalties pt on p.id = pt.player_id
    group by p.full_name, p.positions, t.team_name
    having count(distinct g.id) >= 3 and count(distinct pt.id) < 5
)

select
    *
from calcul_1
order by efficiency_rank, full_name
