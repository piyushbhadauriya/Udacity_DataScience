-- QUIZ 3
SELECT DATE_TRUNC('day',w.occurred_at), w.channel, COUNT(*)
FROM web_events w
GROUP BY 1,2
ORDER BY 3

-- QUIZ 7
SELECT DATE_TRUNC('month',MIN(occurred_at))
FROM orders

SELECT AVG(standard_qty) avg_standard_quantity, AVG(gloss_qty) avg_gloss_quantity, AVG(poster_qty) avg_poster_quantity
FROM orders
WHERE DATE_TRUNC('month',occurred_at) =
  (SELECT DATE_TRUNC('month',MIN(occurred_at))
  FROM orders)

-- QUIZ 9
SELECT s.name SalesRepName, r.name RegionName, SUM(o.total_amt_usd)
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
GROUP BY s.name,r.name
HAVING SUM(o.total_amt_usd) IN
(SELECT MAX(tbl1.total_sale) total_sale
FROM
  (SELECT s.region_id regionid,s.name SalesRepName ,SUM(o.total_amt_usd) total_sale
  FROM orders o
  JOIN accounts a
  ON o.account_id = a.id
  JOIN sales_reps s
  ON a.sales_rep_id = s.id
  GROUP BY s.region_id,s.name) AS tbl1
GROUP BY tbl1.regionid)
ORDER BY 3 DESC


  SELECT r.name RegionName, COUNT(*)
  FROM orders o
  JOIN accounts a
  ON o.account_id = a.id
  JOIN sales_reps s
  ON a.sales_rep_id = s.id
  JOIN region r
  ON s.region_id = r.id
  GROUP BY 1
  HAVING SUM(o.total_amt_usd) =
    (SELECT MAX(total_sale)
    FROM (SELECT SUM(o.total_amt_usd) total_sale
        FROM orders o
        JOIN accounts a
        ON o.account_id = a.id
        JOIN sales_reps s
        ON a.sales_rep_id = s.id
        GROUP BY s.region_id) AS tbl1
    )

SELECT COUNT(*)
FROM
  (SELECT o.account_id, SUM(o.total)
  FROM orders o
  GROUP BY o.account_id
  HAVING SUM(o.total) >
    (SELECT SUM(o.total)
    FROM orders o
    WHERE o.account_id =
      (SELECT o.account_id
      FROM orders o
      GROUP BY 1
      ORDER BY SUM(o.standard_qty) DESC
      LIMIT 1)
    )
  ) AS tbl1

SELECT a.name, w.channel, COUNT(*)
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE w.account_id =
  (SELECT o.account_id
  FROM orders o
  GROUP BY 1
  ORDER BY SUM(o.total_amt_usd) DESC
  LIMIT 1)
GROUP BY 1,2
ORDER BY 3 DESC

SELECT AVG(total_spent)
FROM
  (SELECT o.account_id, SUM(o.total_amt_usd) total_spent
  FROM orders o
  GROUP BY 1
  ORDER BY 2 DESC
  LIMIT 10) AS temp


SELECT AVG(avg_amt_usd)
FROM
  (SELECT o.account_id, AVG(o.total_amt_usd) avg_amt_usd
  FROM orders o
  GROUP BY o.account_id
  HAVING AVG(o.total_amt_usd) >
    (SELECT AVG(o.total_amt_usd)
    FROM orders o)
  ) AS tbl1

-- QUIZ 12
WITH events as
  (SELECT DATE_TRUNC('day',w.occurred_at) as day, w.channel, COUNT(w.id) num_events
  FROM web_events w
  GROUP BY 1,2)
SELECT channel, AVG(num_events)
FROM events
GROUP BY channel

-- QUIZ 13
WITH tbl1 AS(
  SELECT s.name SalesRepName, r.name RegionName,
        SUM(o.total_amt_usd) total_sale
  FROM orders o
  JOIN accounts a
  ON o.account_id = a.id
  JOIN sales_reps s
  ON a.sales_rep_id = s.id
  JOIN region r
  ON r.id = s.region_id
  GROUP BY 1,2)
SELECT *
FROM tbl1
WHERE total_sale IN (
  SELECT MAX(total_sale)
  FROM tbl1
  GROUP BY regionname)

WITH tbl1 as (
  SELECT r.name RegionName, r.id regionid,
        SUM(o.total_amt_usd) total_sale
  FROM orders o
  JOIN accounts a
  ON o.account_id = a.id
  JOIN sales_reps s
  ON a.sales_rep_id = s.id
  JOIN region r
  ON r.id = s.region_id
  GROUP BY 1,2
  ORDER BY 3 DESC
  LIMIT 1
  )
SELECT r.name, COUNT(*)
  FROM orders o
  JOIN accounts a
  ON o.account_id = a.id
  JOIN sales_reps s
  ON a.sales_rep_id = s.id
  JOIN region r
  ON r.id = s.region_id
  WHERE r.id = (
    SELECT regionid FROM tbl1
  )
  GROUP BY 1

WITH tbl1 AS (
  SELECT o.account_id,
  SUM(o.standard_qty) total_standard_qty,
  SUM(o.total) total
  FROM orders o
  GROUP BY 1)
SELECT COUNT(*)
  FROM tbl1
  WHERE total >
  (SELECT total
  FROM tbl1
  ORDER BY total_standard_qty DESC
  LIMIT 1)

  WITH tbl1 AS (
    SELECT o.account_id, SUM(o.total_amt_usd) total_usd
    FROM orders o
    GROUP BY 1
    )
  SELECT w.channel, COUNT(w.id)
  FROM web_events w
  WHERE w.account_id = (
    SELECT account_id
    FROM tbl1
    ORDER BY total_usd DESC
    LIMIT 1)
  GROUP BY 1
  ORDER BY 2

  WITH tbl1 AS (
    SELECT o.account_id, SUM(o.total_amt_usd) total_usd
    FROM orders o
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 10)
  SELECT AVG(total_usd)
  FROM tbl1

  WITH tbl1 AS (
    SELECT o.account_id, SUM(o.total_amt_usd) total_usd, AVG(o.total_amt_usd) avg_usd
    FROM orders o
    GROUP BY 1
    ORDER BY 2 DESC)
  SELECT AVG(avg_usd)
  FROM tbl1
  WHERE tbl1.avg_usd >
    (SELECT AVG(o.total_amt_usd)
    FROM orders o)
