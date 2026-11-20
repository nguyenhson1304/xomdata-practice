-- Xom Data · Monthly income and expense report
-- Problem: https://xomdata.com/practice/medium-groupby-080
-- Solved: 2026-11-20

with income_expense as (
    select
        left(transaction_date, 7) as month,
        case
            when type = 'Income' then amount
            else 0
        end income,
        case
            when type = 'Expense' then amount
            else 0
        end expense
    from transactions
)

select
    month,
    sum(income) as total_income,
    sum(expense) as total_expense,
    (sum(income) - sum(expense)) as balance,
    sum(sum(income) - sum(expense)) over (order by month rows between unbounded preceding and current row) as cumulative_balance,
    case
        when sum(income) > sum(expense) then 'Surplus'
        when sum(income) < sum(expense) then 'Deficit'
        else 'Balanced'
    end as status
from income_expense
group by month
