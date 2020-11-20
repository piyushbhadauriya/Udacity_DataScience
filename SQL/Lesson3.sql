-- Quiz 7
SELECT SUM(poster_qty) AS total_poster_qty
FROM orders

SELECT SUM(standard_qty) AS total_standard_qty
FROM orders

SELECT SUM(total_amt_usd) AS total_sales_usd
FROM orders

/*
SELECT
SUM(standard_amt_usd) AS total_standard_amt_usd,
SUM(gloss_amt_usd) AS total_gloss_amt_usd
FROM orders
*/
SELECT standard_amt_usd + gloss_amt_usd AS total_standard_gloss
FROM orders;

SELECT
SUM(standard_amt_usd)/SUM(standard_qty) AS per_unit_standard_amt_usd
FROM orders

-- QUIZ 11
SELECT MIN(occurred_at)
FROM orders
-- 2013-12-04T04:22:44.000Z
SELECT occurred_at
FROM orders
ORDER BY occurred_at
LIMIT 1

SELECT MAX(occurred_at)
FROM web_events

SELECT occurred_at
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1

SELECT AVG(standard_amt_usd) avg_standard_amount
AVG(gloss_amt_usd) avg_gloss_amount
AVG(poster_amt_usd) avg_poster_amount
AVG(standard_qty) avg_standard_quantity
AVG(gloss_qty) avg_gloss_quantity
AVG(poster_qty) avg_poster_quantity
FROM orders

SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;

-- QUIZ 14
SELECT a.name, MIN(o.occurred_at) date_order
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name
ORDER BY date_order
LIMIT 1

SELECT a.name, SUM(o.total_amt_usd) total_usd
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name

/*
SELECT a.name AccountName, w.channel, MAX(w.occurred_at) dates
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
GROUP BY AccountName, w.channel
ORDER BY dates DESC
LIMIT 1
*/
SELECT w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
ORDER BY w.occurred_at DESC
LIMIT 1;

SELECT channel, COUNT(*)
FROM web_events
GROUP BY channel

SELECT a.primary_poc
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
ORDER BY w.occurred_at
LIMIT 1

SELECT a.name, MIN(o.total_amt_usd) amt_usd
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name
ORDER BY amt_usd

SELECT r.name, COUNT(*) sales_rep_count
FROM sales_reps s
LEFT JOIN region r
ON s.region_id = r.id
GROUP BY (r.name)
ORDER BY sales_rep_count

-- QUIZ 17

SELECT a.name, AVG(o.standard_qty) avg_standard_quantity ,
AVG(o.gloss_qty) avg_gloss_quantity,
AVG(o.poster_qty) avg_poster_quantity
FROM orders o
RIGHT JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name

SELECT a.name, AVG(o.standard_amt_usd) avg_standard_usd ,
AVG(o.gloss_amt_usd) avg_gloss_usd,
AVG(o.poster_amt_usd) avg_poster_usd
FROM orders o
RIGHT JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name

SELECT r.name, w.channel, COUNT(w.id) num_of_events
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
GROUP BY r.name, w.channel
ORDER BY num_of_events DESC

-- QUIZ 20
SELECT DISTINCT a.name AcccountName, r.name RegionName
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY a.name

--QUIZ 23
SELECT s.name, COUNT(a.id) num_accounts
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY s.name
HAVING COUNT(a.id) > 5

SELECT o.account_id, COUNT(o.id)
FROM orders o
GROUP BY o.account_id
HAVING COUNT(o.id) >20

SELECT a.name, COUNT(o.id) num_orders
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name
ORDER BY num_orders DESC
LIMIT 1

SELECT a.name, SUM(o.total_amt_usd)
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name
HAVING SUM(o.total_amt_usd) > 30000
/*HAVING SUM(o.total_amt_usd) < 1000 */

SELECT a.name, SUM(o.total_amt_usd) spent_usd
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name
ORDER BY spent_usd DESC
LIMIT 1

SELECT a.name, COUNT(w.id)
FROM web_events w
JOIN accounts a
ON w.account_id = a.id AND w.channel = 'facebook'
GROUP BY a.name
HAVING COUNT(w.id) > 6

SELECT a.name, COUNT(w.id) num_of_events
FROM web_events w
JOIN accounts a
ON w.account_id = a.id AND w.channel = 'facebook'
GROUP BY a.name
ORDER BY num_of_events DESC
LIMIT 1

SELECT w.channel, COUNT(w.id) num_of_events
FROM web_events w
GROUP BY w.channel
ORDER BY num_of_events DESC
LIMIT 1

SELECT w.channel, w.account_id, COUNT(w.id) num_of_events
FROM web_events w
GROUP BY w.channel, w.account_id
ORDER BY num_of_events DESC
LIMIT 10

-- QUIZ 27
SELECT DATE_TRUNC('year',o.occurred_at) AS year, SUM(o.total_amt_usd)
FROM orders o
GROUP BY 1
ORDER BY 1

SELECT DATE_PART('month',o.occurred_at) AS month, SUM(o.total_amt_usd)
FROM orders o
GROUP BY 1
ORDER BY 2 DESC

SELECT DATE_TRUNC('year',o.occurred_at) AS year, COUNT(*)
FROM orders o
GROUP BY 1
ORDER BY 2 DESC

SELECT DATE_PART('month',o.occurred_at) AS month, COUNT(*)
FROM orders o
GROUP BY 1
ORDER BY 2 DESC

SELECT DATE_TRUNC('month',o.occurred_at) AS month, SUM(o.gloss_amt_usd)
FROM orders o
JOIN accounts a
ON a.id = o.account_id AND a.name = 'Walmart'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1

-- QUIZ 31
SELECT account_id, total_amt_usd, CASE WHEN total_amt_usd > 3000 THEN 'Large'
                                       ELSE 'Small' END AS orders_size
FROM orders

SELECT CASE WHEN total < 1000 THEN 'Less than 1000'
            WHEN total BETWEEN 1000 AND 2000 THEN 'Between 1000 and 2000'
            WHEN total > 2000 THEN 'At Least 2000' END AS num_orders, COUNT(*)
FROM orders
GROUP BY 1

SELECT a.name AccountName, SUM(o.total_amt_usd) total_sales_usd,
CASE WHEN SUM(o.total_amt_usd) < 100000 THEN 'under 100,000'
     WHEN SUM(o.total_amt_usd) BETWEEN 100000 AND 200000 THEN 'Between 100000 and 200000'
     WHEN SUM(o.total_amt_usd) > 200000 THEN 'greater than 200,000' END AS level
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id AND o.occurred_at BETWEEN 2016-1-1 AND 2018-1-1
GROUP BY 1
ORDER BY 2 DESC

SELECT a.name AccountName, SUM(o.total_amt_usd) total_sales_usd,
CASE WHEN SUM(o.total_amt_usd) < 100000 THEN 'under 100,000'
     WHEN SUM(o.total_amt_usd) BETWEEN 100000 AND 200000 THEN 'Between 100000 and 200000'
     WHEN SUM(o.total_amt_usd) > 200000 THEN 'greater than 200,000' END AS level
FROM accounts a
JOIN orders o
ON a.id = o.account_id AND o.occurred_at BETWEEN '2016-1-1' AND '2018-1-1'
GROUP BY 1
ORDER BY 2 DESC


SELECT s.name SalesRepName, COUNT(*) num_orders,
CASE WHEN COUNT(*) > 200 THEN 'top'
ELSE 'not' END as performance
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY 1
ORDER BY 2 DESC

SELECT s.name SalesRepName, COUNT(*) num_orders, SUM(o.total_amt_usd) total_sales_usd
CASE WHEN COUNT(*) > 200 OR SUM(o.total_amt_usd)> 750000 THEN 'top'
     WHEN (COUNT(*) BETWEEN 150 AND 200)  OR (SUM(o.total_amt_usd) BETWEEN 500000 AND  750000) THEN 'middle'
ELSE 'low' END as performance
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY 1
ORDER BY 3 DESC
