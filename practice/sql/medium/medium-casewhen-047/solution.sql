-- Xom Data · Portfolio profit/loss
-- Problem: https://xomdata.com/practice/medium-casewhen-047
-- Solved: 2026-11-12

with profit_loss as (
    select
        s.stock_code,
        c.stock_quantity,
        c.avg_cost_price,
        s.current_price,
        (s.current_price - c.avg_cost_price) * c.stock_quantity as profit_loss,
        round(((s.current_price - c.avg_cost_price) * c.stock_quantity * 100.0) / (c.avg_cost_price * c.stock_quantity), 2) as profit_pct
    from stocks s
    left join categories c on s.id = c.stock_id
)

select
    *,
    case
        when profit_pct > 10.0 then 'Strong Gain'
        when profit_pct > 0.0 and profit_pct <= 10.0 then 'Mild Gain'
        when profit_pct = 0.0 then 'Break Even'
        when profit_pct > -10.0 and profit_pct < 0 then 'Mild Loss'
        else 'Strong Loss'
    end as status,
    rank() over (order by profit_pct desc) as rank_by_pct,
    sum(avg_cost_price * stock_quantity) over (order by profit_pct desc rows between unbounded preceding and current row) as cumulative_invested
from profit_loss
