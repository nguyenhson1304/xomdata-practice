-- Xom Data · Rank hotels by room price within each destination
-- Problem: https://xomdata.com/practice/medium-join-155
-- Solved: 2026-11-04

with various_price as (
    select
        distinct h.hotel_name,
        h.star_class,
        d.destination_name,
        count(hr.id) over (partition by hr.hotel_id) as room_count,
        min(nightly_rate) over (partition by hr.hotel_id) as min_price,
        max(nightly_rate) over (partition by hr.hotel_id) as max_price,
        avg(nightly_rate) over (partition by hr.hotel_id) as avg_price
    from hotels h
    inner join destinations d on h.destination_id = d.id
    inner join hotel_rooms hr on h.id = hr.hotel_id
)

select
    *,
    max_price - min_price as price_spread,
    rank() over (partition by destination_name order by avg_price desc) as rank_in_destination
from various_price
where room_count > 1
