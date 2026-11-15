-- Xom Data · Top 10 most-engaged posts
-- Problem: https://xomdata.com/practice/medium-groupby-097
-- Solved: 2026-11-15

with rank_interactions as (
    select
        u.full_name,
        p.post_type,
        p.post_date,
        (p.like_count + p.comment_count + p.share_count) as total_interactions,
        rank() over (order by (p.like_count + p.comment_count + p.share_count) desc) as overall_rank,
        row_number() over (partition by u.full_name order by (p.like_count + p.comment_count + p.share_count) desc, p.post_date) as rank_in_author,
        max(p.like_count + p.comment_count + p.share_count) over() as best_interactions
    from users u
    inner join posts p on u.id = p.user_id
)

select
    full_name,
    post_type,
    post_date,
    total_interactions,
    overall_rank,
    rank_in_author,
    round(total_interactions * 100.0 / best_interactions, 2) as pct_of_top
from rank_interactions
order by overall_rank, full_name, rank_in_author
limit 10
