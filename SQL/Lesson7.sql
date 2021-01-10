-- QUIZ 3
SELECT *
FROM accounts a
FULL JOIN sales_reps s
ON a.sales_rep_id = s.id
-- WHERE accounts.sales_rep_id IS NULL OR sales_reps.id IS NULL

--QUIZ 6
SELECT a.name account_name, a.primary_poc, s.name sales_rep_name
FROM accounts a
LEFT JOIN sales_reps s
ON a.sales_rep_id = s.id
AND a.primary_poc < s.name

--QUIZ 9
SELECT w1.id AS w1_id,
       w1.account_id AS w1_account_id,
       w1.occurred_at AS w1_occurred_at,
       w2.id AS w2_id,
       w2.account_id AS w2_account_id,
       w2.occurred_at AS w2_occurred_at
  FROM web_events w1
 LEFT JOIN web_events w2
   ON w1.account_id = w2.account_id
  AND w2.occurred_at > w1.occurred_at
  AND w2.occurred_at <= w1.occurred_at + INTERVAL '1 days'
ORDER BY w1.account_id, w1.occurred_at

-- QUIZ 12
SELECT *
FROM accounts
UNION ALL
SELECT *
FROM accounts
ORDER BY id


WITH double_accounts AS
  (SELECT *
  FROM accounts
  UNION ALL
  SELECT *
  FROM accounts)
SELECT name, COUNT(*)
FROM double_accounts
GROUP BY 1

-- Exercise 18
WITH orders AS
 (SELECT DATE_TRUNC('day',o.occurred_at) AS day,
        COUNT(DISTINCT a.sales_rep_id) AS active_sales_reps,
        COUNT(o.id) AS num_orders
  FROM orders o
  JOIN accounts a
    ON a.id = o.account_id
  GROUP BY 1),
  web_events AS
  (SELECT DATE_TRUNC('day',w.occurred_at) AS day,
          COUNT(w.id) as web_visits
  FROM web_events w
  GROUP BY 1
  )
SELECT COALESCE(o.day,w.day),
  o.active_sales_reps,o.num_orders,w.web_visits
FROM orders o
FULL JOIN web_events w
ON o.day = w.day
