-- Xom Data · Showtime count and average ticket price per film
-- Problem: https://xomdata.com/practice/medium-join-076
-- Solved: 2026-11-14

select
    m.movie_name,
    m.genres,
    count(s.movie_id) as showtime_count,
    round(avg(s.ticket_price), 0) as avg_ticket_price,
    dense_rank() over (partition by m.genres order by avg(s.ticket_price) desc) as rank_in_genre,
    first_value(m.movie_name) over (partition by m.genres order by avg(s.ticket_price) desc) as top_movie_in_genre
from movies m
inner join showtimes s on m.id = s.movie_id
group by m.movie_name, m.genres
order by m.genres
