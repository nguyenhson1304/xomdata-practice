-- Xom Data · Stock exchanges
-- Problem: https://xomdata.com/practice/easy-distinct-007
-- Solved: 2026-10-23

SELECT DISTINCT(exchange)
FROM stocks
ORDER BY exchange ASC;
