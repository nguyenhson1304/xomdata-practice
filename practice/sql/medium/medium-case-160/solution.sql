-- Xom Data · Delivery performance by size class
-- Problem: https://xomdata.com/practice/medium-case-160
-- Solved: 2026-11-09

with info_by_vehicle as (
    select
        t.id,
        t.vehicle_type,
        t.capacity_tons,
        count(s.id) as shipment_count,
        case
            when t.capacity_tons >= 10 then 'Large Truck'
            when t.capacity_tons >= 5 and t.capacity_tons < 10 then 'Medium Truck'
            else 'Small Truck'
        end as size_class
    from shipments s
    inner join trucks t on s.truck_id = t.id
    inner join deliveries d on s.id = d.shipment_id
    group by t.id, t.vehicle_type, t.capacity_tons
),

delivered_by_vehicle as (
    select
        s.truck_id,
        count(case when d.results = 'success' then 1 end) over (partition by s.truck_id) as delivered
    from deliveries d
    inner join shipments s on d.shipment_id = s.id
)

select
    ibv.vehicle_type,
    ibv.capacity_tons,
    ibv.shipment_count,
    ibv.size_class,
    dbv.delivered,
    round(dbv.delivered * 100.0 / ibv.shipment_count, 2) as delivery_rate,
    rank() over (partition by ibv.size_class order by round(dbv.delivered * 100.0 / ibv.shipment_count, 2) desc) as rank_in_size
from delivered_by_vehicle dbv
inner join info_by_vehicle ibv on dbv.truck_id = ibv.id
group by ibv.vehicle_type, ibv.capacity_tons, ibv.shipment_count, ibv.size_class, dbv.delivered
