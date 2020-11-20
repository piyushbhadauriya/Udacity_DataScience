--Quiz 3
SELECT o.standard_amt_usd,SUM(o.standard_amt_usd) OVER(ORDER BY o.occurred_at) AS running_total
FROM orders o

-- QUIZ 5
SELECT o.standard_amt_usd,DATE_TRUNC('year',o.occurred_at) occurred_at,
    SUM(o.standard_amt_usd) OVER(PARTITION BY DATE_TRUNC('year',o.occurred_at)
                            ORDER BY occurred_at) AS running_total
FROM orders o

-- QUIZ 8
SELECT o.id,o.account_id,o.total,
  RANK() OVER (PARTITION BY o.account_id ORDER BY o.total DESC) AS total_rank
FROM orders o

-- Quiz 11
SELECT id,
       account_id,
       standard_qty,
       DATE_TRUNC('month', occurred_at) AS month,
       DENSE_RANK() OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS dense_rank,
       SUM(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS sum_std_qty,
       COUNT(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS count_std_qty,
       AVG(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS avg_std_qty,
       MIN(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS min_std_qty,
       MAX(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS max_std_qty
FROM orders

SELECT id,
       account_id,
       standard_qty,
       DATE_TRUNC('month', occurred_at) AS month,
       DENSE_RANK() OVER (PARTITION BY account_id) AS dense_rank,
       SUM(standard_qty) OVER (PARTITION BY account_id) AS sum_std_qty,
       COUNT(standard_qty) OVER (PARTITION BY account_id ) AS count_std_qty,
       AVG(standard_qty) OVER (PARTITION BY account_id ) AS avg_std_qty,
       MIN(standard_qty) OVER (PARTITION BY account_id) AS min_std_qty,
       MAX(standard_qty) OVER (PARTITION BY account_id ) AS max_std_qty
FROM orders

-- QUIZ 14
SELECT id,
       account_id,
       DATE_TRUNC('year',occurred_at) AS year,
       DENSE_RANK() OVER account_year_window AS dense_rank,
       total_amt_usd,
       SUM(total_amt_usd) OVER account_year_window AS sum_total_amt_usd,
       COUNT(total_amt_usd) OVER account_year_window AS count_total_amt_usd,
       AVG(total_amt_usd) OVER account_year_window AS avg_total_amt_usd,
       MIN(total_amt_usd) OVER account_year_window AS min_total_amt_usd,
       MAX(total_amt_usd) OVER account_year_window AS max_total_amt_usd
FROM orders
WINDOW account_year_window AS (PARTITION BY account_id ORDER BY DATE_TRUNC('year',occurred_at))

-- QUIZ 17
SELECT o.occurred_at,o.total_amt_usd,
       LEAD(o.total_amt_usd) OVER main_window AS lead,
       LEAD(o.total_amt_usd) OVER main_window - o.total_amt_usd AS lead_difference
FROM orders o
WINDOW main_window AS (ORDER BY o.occurred_at)

--QUIZ 21
SELECT account_id, occurred_at, total_std_qty,
  NTILE(4) OVER ((PARTITION BY account_id ORDER BY total_std_qty) AS quartile
FROM (SELECT account_id,occurred_at,SUM(standard_qty) total_std_qty
      FROM orders
      GROUP BY account_id,occurred_at
)sub

SELECT account_id, occurred_at, gloss_qty,
  NTILE(2) OVER ((PARTITION BY account_id ORDER BY gloss_qty) AS level
FROM orders
ORDER BY account_id

SELECT account_id, occurred_at, total_amt_usd,
  NTILE(100) OVER (PARTITION BY account_id ORDER BY total_amt_usd) AS total_percentile
FROM orders
ORDER BY account_id
